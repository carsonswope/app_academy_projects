require 'byebug'
require 'active_support/inflector'

class Route
  attr_reader :http_method, :controller_class, :action_name
  attr_accessor :pattern

  def initialize(pattern, http_method, controller_class, action_name)
    # pattern comes in of the form
    # "users/:user_id"
    # and gets saved in the form of
    # ['users', ':user_id']
    # or even
    # ['users', ':username', 'posts'] - eventually nested ones too
    # * signifies whatever is between those slashes will be evaluated
    # as something to be passed into the params
    @http_method = http_method
    @controller_class = controller_class
    @action_name = action_name
    @pattern = pattern
  end

  def matches?(req)

    requested_method = req.request_method.downcase

    if requested_method == "post" && req.params["_method"]
      requested_method = req.params["_method"].downcase
    end

    return false unless requested_method.to_sym == http_method

    path_array = path_to_a(req.fullpath)

    return false unless path_array.length == pattern_array.length

    pattern_array.zip(path_array).each do |pair|
      # pair[0] is pattern specification
      # pair[1] is given path specification
      if !pair[0].start_with?(":")
        return false unless pair[0] == pair[1].downcase
      end
    end

    return true
  end

  def pattern_array
    @pattern.split("/").select { |el| el.length > 0 }
  end

  def run(req, res)
    params = route_params(req.fullpath)
    @controller_class.constantize.new(req, res, params).invoke_action(action_name)
  end

  # private

  def path_to_a(path)
    # turn "users/1/posts?page=10" into ["users", "1", "posts"]
    path.split("?").first.split("/").drop(1)
  end

  def query_string_a(path)
    query_string = path.split("?").drop(1).first
    return [] if query_string.nil?
    query_string
      .split("&")
      .map { |opt| opt.split("=") }
  end

  def path_params_a(path)
    pattern_array.zip(path_to_a(path)).select do |pair|
      pair[0].start_with?(":")
    end.map { |opt| [opt[0][1..-1], opt[1]] }
  end

  def route_params(path)
    #first half =  path params from url like /users/:user_id/etc
    #second half = path params from url like /users?page=10
    params = {}
    (query_string_a(path) + path_params_a(path)).each do |pair|
      params[pair[0]] = pair[1]
    end
    params
  end
end

class Router

  attr_reader :routes

  def initialize
    @routes = []
  end

  def add_route(pattern, method, controller_class, action_name)
    @routes << Routes.new(pattern, method, controller_class, action_name)
  end

  def routes_list(resource_name, options, resource_type = :plural)

    singular = resource_name.to_s.singularize
    plural = resource_name.to_s.pluralize
    controller_class = "#{plural.camelcase}Controller" #constantize?

    # id overrides id_type
    # url looks like      /users/:user_id           (default)
    # can be changed to   /users/:user_email        id_type: :email
    # can be changed to   /users/:email             id: :email
    options[:id_type] ||= "id"
    options[:id] ||= "#{singular}_#{options[:id_type]}"

    if resource_type == :plural

      actions = {
        index:  ["/#{plural}",                        :get    ],
        show:   ["/#{plural}/:#{options[:id]}",       :get    ],
        new:    ["/#{plural}/new",                    :get    ],
        edit:   ["/#{plural}/:#{options[:id]}/edit",  :get    ],
        create: ["/#{plural}",                        :post   ],
        update: ["/#{plural}/:#{options[:id]}",       :put    ],
        destroy:["/#{plural}/:#{options[:id]}",       :delete ]
      }

    else

      actions = {
        show:   ["/#{singular}",                      :get    ],
        new:    ["/#{singular}/new",                  :get    ],
        edit:   ["/#{singular}/edit",                 :get    ],
        create: ["/#{singular}",                      :post   ],
        update: ["/#{singular}",                      :put    ],
        destroy:["/#{singular}",                      :delete ]
      }

    end

    if options[:only]
      narrowed = options[:only]
      method = :select
    elsif options[:except]
      narrowed = options[:except]
      method = :reject
    end

    if narrowed
      operator = narrowed.is_a?(Array) ? :include? : :==
      operation = Proc.new{ |action| narrowed.send(operator, action ) }
      to_draw = actions.keys.send(method, &operation)
    else
      to_draw = actions.keys
    end

    to_draw.map! do |action|
      Route.new(
        actions[action][0],  #pattern_string
        actions[action][1],  #http_method
        controller_class,
        action
      )
      # here we add to the @routes instance variable the moment the
      # route is created. in the case of the nested route, we mutate
      # the routes as they are passed up the stack
    end.each { |route| @routes << route }

  end

  # Router#resource and Router#resources:
  # if there is a block passed for a nested route,
  # mutate each child route (given to us via the return value
  # of nested.call) with the prefix of our resource.
  # return that array plus the list of routes added
  # by this call to resource or resources
  # in that way it recursively builds nested routes

  def resources(resource_name, options = {}, &nested )
    (nested ? nested.call : []).each do |nested_route|
      nested_route.pattern = "/#{plural}/:#{options[:id]}#{nested_route.pattern}"
    end + routes_list(resource_name, options, :plural)
  end

  def resource(resource_name, options = {}, &nested)
    (nested ? nested.call : []).each do |nested_route|
      nested_route.pattern = "/#{singular}#{nested_route.pattern}"
    end + routes_list(resource_name, options, :singular)

  end



  [:get, :post, :put, :delete].each do |http_method|
    define_method http_method do |pattern_string, controller_class, action_name|
      add_route(pattern_string, http_method, controller_class, action_name)
    end
  end

  def add_route(pattern_string, method, controller_class, action_name)
    @routes << Route.new(pattern_string, method, controller_class, action_name)
  end

  def rake_routes
  end

  def draw (&proc)
    self.instance_eval(&proc)
  end

  def sort_routes!
    order = [:index, :create, :new, :edit, :show, :update, :destroy]
    @routes.sort! { |a,b| order.index(a.action_name) <=> order.index(b.action_name)}
  end

  def match(req)
    @routes.each do |route|
      return route if route.matches?(req)
    end
    return nil
  end

  def run(req, res)
    matched_route = match(req)
    if matched_route
      matched_route.run(req, res)
    else
      res.status = 404
    end
  end
end
