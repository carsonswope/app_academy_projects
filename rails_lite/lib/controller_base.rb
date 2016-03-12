require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @params = route_params

    @req.params.each do |key, val|
      @params[key] = val
    end

    @session = Session.new(req)
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    !@already_built_response.nil?
  end

  # Set the response status code and header
  def redirect_to(url)

    raise Exception if already_built_response?

    res.status = 302
    res['location'] = url

    @already_built_response = true
    session.store_session(@res)
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)

    raise Exception if already_built_response?

    res.write(content)
    res['Content-Type'] = content_type

    @already_built_response = true
    session.store_session(@res)
  end

  def render_partial(template_name, args = {})
    
    if template_name.to_s.split("/").length > 1
      file_path = "views/#{template_name}.html.erb"
    else
      file_path = "views/#{self.class.to_s.underscore}/#{template_name.to_s}.html.erb"
    end
    page = File.read(file_path)

    ERB.new(page).result(binding)
  end

  def render_response
    @template_path = "views/#{self.class.to_s.underscore}/#{@main_template.to_s}.html.erb"

    page = File.read("views/layouts/application.html.erb")

    content = ERB.new(page).result(binding)
    content_type = 'text/html'

    render_content(content, content_type)
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    @main_template = template_name
    render_response
  end

  # method exposing a `Session` object
  def session
    @session
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    send name
    render name unless @already_built_response
  end
end
