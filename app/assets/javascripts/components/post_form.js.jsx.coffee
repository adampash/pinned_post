@PostForm = React.createClass
  handleSubmit: (e) ->
    e.preventDefault()
    e.stopPropagation()
    $.ajax
      method: "POST"
      url: "/#{@props.site}"
      dataType: 'json'
      data: @state
      success: (response) =>
        if response?
          @props.handleNewPost response
          React.findDOMNode(@refs.description).value = ''
          React.findDOMNode(@refs.url).value = ''
          React.findDOMNode(@refs.url).focus()
        else
          alert "Something went wrong. Are you sure this post belongs to your site?"
      error: (e) ->
        alert "Something went wrong. Are you sure this post belongs to your site?"


  handleChange: (e) ->
    obj = {}
    obj[e.target.name] = e.target.value
    @setState obj

  render: ->
    `<div>
      <form action="/posts" className="post" onSubmit={this.handleSubmit}>
        <input
          placeholder="Url of the post you want to pin"
          ref="url"
          onChange={this.handleChange}
          name="url"
        />
        <input placeholder="Description"
          name="description"
          onChange={this.handleChange}
          ref="description"
        />
        <button type="submit">Save</button>
      </form>
    </div>`

