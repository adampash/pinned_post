@PostForm = React.createClass
  handleSubmit: (e) ->
    e.preventDefault()
    e.stopPropagation()
    $.ajax
      method: "POST"
      url: '/posts'
      dataType: 'json'
      data: @state
      success: (response) =>
        @props.handleNewPost response

  handleChange: (e) ->
    obj = {}
    obj[e.target.name] = e.target.value
    @setState obj

  render: ->
    `<div>
      <form action="/posts" className="post" onSubmit={this.handleSubmit}>
        <input
          placeholder="Paste the url of the post you want to stick to the top"
          onChange={this.handleChange}
          name="url"
        />
        <input placeholder="Description" ref="name"
          name="description"
          onChange={this.handleChange}
        />
        <button type="submit">Save</button>
      </form>
    </div>`

