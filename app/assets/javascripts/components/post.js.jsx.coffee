@Post = React.createClass
  getInitialState: ->
    post: @props.post
    live: @props.live
    loading: false

  handleClick: (e) ->
    @setState
      live: e.target.checked
    console.log e.target.checked
    @setState
      loading: true
    $.ajax
      method: "PUT"
      url: "/posts/#{@state.post.id}"
      data:
        live: e.target.checked
      success: (post) =>
        @setState
          loading: false

  getDomain: (url) ->
    url.match(/^https?:\/\/(\w+\.)?(\w+)\.com/)[2].toUpperCase()

  render: ->
    post = @state.post

    if @state.loading
      loader = `<i className="fa fa-spinner fa-pulse"></i>`
    else
      loader = ''
    `<div className="post">
      <div className="description">
        <a href={post.url} target="_blank">
          {this.getDomain(post.url)}: {post.name}
        </a>
      </div>
      <div className="updating">
        {loader}
        <input type="checkbox" onChange={this.handleClick}
          checked={this.state.live}
        /> Live
      </div>
    </div>`

