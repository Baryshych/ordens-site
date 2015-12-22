jQuery(document).ready ->
  return if $('.petitions-page').length == 0

  $('.datepicker3').datetimepicker({ format: 'DD.MM.YYYY', debug: true })
  $('.selectize').selectize(create: false)

  $('#search').on('keyup', (e)->
    if e.keyCode == 13
      document.location.href = '/petitions?search=' + $('#search').val()
  )
