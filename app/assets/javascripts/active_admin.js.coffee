#= require active_admin/base
#= require chosen-jquery

$(document).ready ->
  return $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    placeholder_text_multiple: 'Select as many as applicable'
    width: '80%'
