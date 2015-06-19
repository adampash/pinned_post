@Posts = React.createClass
  getInitialState: ->
    posts: @props.posts

  handleNewPost: (post) ->
    posts = @state.posts
    posts.unshift post
    @setState
      posts: posts

  handleDelete: (post) ->
    posts = _.without(@state.posts, post)
    @setState
      posts: posts

  render: ->
    handleDelete = @handleDelete
    posts = @state.posts.map (post, index) =>
      `<Post
        live={post.live}
        post={post}
        key={post.kinja_id}
        removePost={handleDelete}
      />`

    `<div className="posts">
      <PostForm handleNewPost={this.handleNewPost}
        site={this.props.site}
      />
      {posts}
    </div>`
