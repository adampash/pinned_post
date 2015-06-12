@Posts = React.createClass
  getInitialState: ->
    posts: @props.posts

  handleNewPost: (post) ->
    posts = @state.posts
    posts.unshift post
    @setState
      posts: posts

  render: ->
    posts = @state.posts.map (post, index) =>
      `<Post
        live={post.live}
        post={post}
        key={post.kinja_id}
      />`

    `<div className="posts">
      <PostForm handleNewPost={this.handleNewPost} />
      {posts}
    </div>`
