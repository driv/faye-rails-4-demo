# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

client = new Faye.Client('/faye')

client.on 'transport:up', () ->
  console.log('Client online');

client.on 'transport:down', () ->
  console.log('Client offline');

subscription = client.subscribe '/chat', (payload)->
  $('#chat').append("<li>#{payload.message}</li>")

subscription.then () ->
  console.log('Subscription complete.');

$(document).ready ->
  input = $('input')
  button = $('button')
  button.click ->
    button.attr('disabled', 'disabled')
    button.text('Posting...')
    publication = client.publish '/chat',
      message: input.val(),
      created_at: new Date()
    publication.callback ->
      input.val('');
      button.removeAttr('disabled')
      button.text('Post')
    publication.errback ->
      button.removeAttr('disabled')
      button.text('Try again')

# in case anyone wants to play with the inspector.
window.client = client
