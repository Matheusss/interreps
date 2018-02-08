angular.module 'interreps'
  .run ($log, editableOptions) ->
    'ngInject'
    $log.debug 'runBlock end'

    editableOptions.cancelButtonTitle = 'Cancelar'
    editableOptions.cancelButtonAriaLabel = "Cancelar"
    editableOptions.submitButtonAriaLabel = "Salvar"
    editableOptions.submitButtonTitle = "Salvar"
