module ApplicationHelper

  def auth_token
    html = <<-HTML
      <input type="hidden" name="authenticity_token" value="#{form_authenticity_token}">
    HTML

    html.html_safe
  end

  def post_info(post)

    if post.url
      unless post.url.start_with?('http://')
        url = 'http://' + post.url
      else
        url = post.url
      end
    end

    headline = post.url ? "<a href='#{url}'>#{h(post.title)}</a>" : link_to(h(post.title), h(post_url(post)))
    subr_links = ""
    post.subrs.each do |subr|
      subr_links += link_to subr.title, sub_url(subr)
      subr_links += "<br>"
    end

    html = <<-HTML
      <h2> #{ headline } </h2>
      <h3> by #{ link_to (h(post.author.name)), user_url(h(post.author.id)) } </h3>
      <p> #{ h(post.content) } </p>
      <p> #{ subr_links } </p>
    HTML

    html.html_safe
  end

  def default_subreddit(post, url_id)

    if post.persisted?
      default_subreddit = post.subr.title
    elsif url_id
      default_subreddit = Sub.find_by(id: url_id).title
    else
      default_subreddit = ""
    end

    default_subreddit
    # debugger
  end

end
