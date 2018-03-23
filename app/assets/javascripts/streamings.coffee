$(document).on 'turbolinks:load', ->

  $('#q_daterange').daterangepicker
    "locale": {
      "format": "DD/MM/YYYY",
      "separator": " - ",
      "applyLabel": "Aplicar",
      "cancelLabel": "Cancelar",
      "fromLabel": "De",
      "toLabel": "Para",
      "customRangeLabel": "Custom",
      "daysOfWeek": [
          "Dom",
          "Seg",
          "Ter",
          "Qua",
          "Qui",
          "Sex",
          "Sab"
      ],
      "monthNames": [
          "Janeiro",
          "Fevereiro",
          "Março",
          "Abril",
          "Maio",
          "Junho",
          "Julho",
          "Agosto",
          "Setembro",
          "Outubro",
          "Novembro",
          "Decembro"
      ],
      "firstDay": 0
    }
    startDate: moment()
    endDate: moment()
    , (start, end, label) ->
      $('#q_date_gteq').val start.format("YYYY-MM-DD")
      $('#q_date_lteq').val end.format("YYYY-MM-DD")

  $('#streaming_date').daterangepicker
    startDate: moment(),
    singleDatePicker: true,
    "locale": {
      "format": "DD/MM/YYYY",
      "separator": " - ",
      "applyLabel": "Aplicar",
      "cancelLabel": "Cancelar",
      "fromLabel": "De",
      "toLabel": "Para",
      "customRangeLabel": "Custom",
      "daysOfWeek": [
          "Dom",
          "Seg",
          "Ter",
          "Qua",
          "Qui",
          "Sex",
          "Sab"
      ],
      "monthNames": [
          "Janeiro",
          "Fevereiro",
          "Março",
          "Abril",
          "Maio",
          "Junho",
          "Julho",
          "Agosto",
          "Setembro",
          "Outubro",
          "Novembro",
          "Decembro"
      ],
      "firstDay": 0
    }
