#coefficient responds to the number of reps performed filled with key value pairs
coefficients = {
  1: 1, 2: .943, 3: .906, 4: .881, 5: .851, 6: .831, 7: .807, 8: .786, 9: .765, 10: .744
}
# creating a react component for the form
@LiftForm = React.createClass
  # set initial values for the fields that will be on the form
  getInitialState: ->
    date: ''
    liftname: ''
    ismetric: false
    repsperformed: ''
    weightlifted: ''
    onerm: '0'
  # handleValueChange will detect the input that triggered it
  handleValueChange: (e) ->
    # assign the name of the input field to valueName
    valueName = e.target.name
    # will update the component state to the current value and automatically triggers a UI refresh using the components new state
    @setState "#{ valueName }": e.target.value
  toggleUnit: (e) ->
    e.preventDefault()
    # reversing the value , if true it is metric, if it is false it is not
    @setState ismetric: !@state.ismetric
  calculateOneRm: ->
    # check to see if there is enough data to calculate
    if @state.weightlifted and @state.repsperformed
      # to calculate onerm, we devide the weight lifted by a coefficient that responds to the number of reps performed
      # this passes state.repsperformed as the key
        @state.onerm = @state.weightlifted / coefficients[@state.repsperformed]
    else
      0
    # creating valid function to check the input data
  valid: ->
    @state.date && @state.liftname && @state.weightlifted && @state.repsperformed && @state.onerm
  # on submit runs this function, stops the default rails action to submit the form using http request.
  handleSubmit: (e) ->
    e.preventDefault()
    # using jquery to make a post to the database when the submission is successful, the form should reset its values by calling setState and having it run getInitialState
    $.post '', { lift: @state }, (data) =>
      @props.handleNewLift data
      @setState @getInitialState()
    , 'JSON'
  render: ->
    React.DOM.form
      className: 'form-inline'
      # when the form in submitted, the handleSubmit function sends the post data inside the variable called data (on line 26) to the prop on the parent component called handleNewLift
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'date'
          className: 'form-control'
          placeholder: 'date'
          name: 'date'
          # value atrribute of each input field is set to the value contained in the components state
          value: @state.date
          #set to trigger the function @handleValueChange, everytime a key stroke is detected in the input field, this components handleValueChange will be run
          onChange: @handleValueChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'lift'
          name: 'liftname'
          value: @state.liftname
          onChange: @handleValueChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'number'
          className: 'form-control'
          placeholder: 'weightlifted'
          name: 'weightlifted'
          value: @state.weightlifted
          onChange: @handleValueChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'number'
          min: 1
          max: 10
          className: 'form-control'
          placeholder: 'repsperformed'
          name: 'repsperformed'
          value: @state.repsperformed
          onChange: @handleValueChange
      React.DOM.button
        className: 'btn btn-primary'
        # button toggles between false and true when clicked
        onClick: @toggleUnit
        'Metric = ' + @state.ismetric.toString()
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        #disable the function called valid
        disabled: !@valid()
        'Create Lift'
      # rendering OneRmBox
      React.createElement OneRmBox, onerm: @calculateOneRm()
