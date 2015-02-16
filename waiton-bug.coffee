Items = new Meteor.Collection 'items'

log_items = ->
  Tracker.nonreactive ->
    console.dir Items.find({}).fetch()
  
Router.configure
  waitOn: ->
    console.log 'waitOn'
    log_items()
    Meteor.subscribe 'items'
  onAfterAction: ->
    console.log 'onAfterAction'
    log_items()

if Meteor.isClient 
  Template.hello.rendered = ->
    console.log 'rendered'
    log_items()

if Meteor.isServer
  Items.insert 
    test: 1
    
  Meteor.publish 'items', ->
    Items.find {}

Router.route '/',
  name: 'hello'
