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
      loading: false
    $.ajax
      method: "PUT"
      url: "/posts/#{@state.post.id}"
      data:
        live: e.target.checked
      success: (post) =>
        @setState
          loading: false

  render: ->
    post = @state.post
    `<div className="post">
      <div className="description">
        <a href={post.url} target="_blank">
          {post.name}
        </a>
      </div>
      <div className="updating">
        <input type="checkbox" onChange={this.handleClick}
          checked={this.state.live}
        /> Live
      </div>
    </div>`

