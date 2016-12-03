cd# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  window.wrapUp = ->
    console.log('done')
    convoForm.show()
    $('#convo-form-enter').prop('disabled', true)

  converse = ->
    doc = $('body')
    convoForm = $('#convo-form')
    convoForm.hide()
    doc.append("""
    <div class="convo-window">
      <ol class="convo-chat-history">
      <li class="other">
        <div class="msg">
          <p>Hi! Welcome to conversation forms. I'm Converso, your friendly form-bot.
            Here, instead of filling out a borring form, we're going to have a pleasant
            conversation. When I ask a question, type your answer into the input box below.
          </p>
          <p> When your answer is ready, press the "NEXT" button. Or, you can simply press the ENTER (or RETURN) key on your keyboard</p>
        </div>
      </li>
      </ol>
      <input id="input-box" class="input-box" placeholder="Type your answer here ...">
      <button id="convo-form-enter">Next</button>
    </div>
    """
    )

    inputIds = [];

    $('#convo-form input[name]').each ->
      inputIds.push($(this).attr('id'))

    endIndex = inputIds.length - 1
    sequenceIndex = 0
    item = inputIds[sequenceIndex]
    inputBox = $('#input-box')


    openDialog = ->
      item = inputIds[sequenceIndex]
      $('.convo-window .convo-chat-history').append('
        <li class="other">
          <div class="msg">
            <p>Please enter your ' + item + '</p>
          </div>
        </li>
      ')
      $('.convo-window .convo-chat-history').scrollTop($('.convo-window .convo-chat-history')[0].scrollHeight);

    $('#convo-form-enter').click ->
      if sequenceIndex <= endIndex
        submitted = inputBox.val()
        inputBox.val(null)
        $('#' + item).val(submitted)
        $('.convo-window .convo-chat-history').append('
          <li class="self">
            <div class="msg">
              <p>' + submitted + '</p>
            </div>
          </li>
        ')
        $('.convo-window .convo-chat-history').scrollTop($('.convo-window .convo-chat-history')[0].scrollHeight);
        sequenceIndex++
        if sequenceIndex == endIndex
            $('#convo-form-enter').html 'submit'
        if sequenceIndex > endIndex
          wrapUp()
        else
          openDialog()

    inputBox.keyup (e) ->
      if e.which is 13
        $('#convo-form-enter').click()

    openDialog(inputIds)

  if document.getElementById('convo-form') != null
    converse()
