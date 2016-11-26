@Lifts = React.createClass
  # setting initial state of component
  # when this component renders, it will have an array of lifts and assign it to the data we pass through to the components from @lifts
  getInitialState: ->
    lifts: @props.data
  # defines the value the component has by default
  getDefaultProps: ->
    lifts: []
  # takes in new data with new variable lift
  # pushing new lift into array, then use setState to redefine lifts where the UI will update when the function is successful
  addLift: (lift) ->
    lifts = @state.lifts.slice()
    lifts.push lift
    @setState lifts: lifts
  render: ->
    React.DOM.div
      className: 'lifts'
      React.DOM.h1
        className: 'title'
        'Lifts'
      # render the liftform component by usuing React.createElement function
      # define handleNewLift prop by setting it to a function called addLift
       React.createElement LiftForm, handleNewLift: @addLift
       React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Date'
            React.DOM.th null, 'Lift Name'
            React.DOM.th null, 'Weight Lifted'
            React.DOM.th null, 'Metric ?'
            React.DOM.th null, 'Reps Performed'
            React.DOM.th null, '1 RM'
        React.DOM.tbody null,
         for lift in @state.lifts
          React.createElement Lift, key: lift.id, lift: lift, handleDeleteLift: @deleteLift, handleEditLift: @updateLift
