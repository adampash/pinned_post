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

  deletePost: (e) ->
    remove = confirm "You sure you want to delete that?"
    if remove
      $.ajax
        method: 'DELETE'
        url: "/posts/#{@state.post.id}"
        success: =>
          @props.removePost(@state.post)


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
        /> Pinned
        <i className="fa fa-trash-o" onClick={this.deletePost}></i>
      </div>
    </div>`

