*** Settings ***
Library             SeleniumLibrary

Test Teardown       SeleniumLibrary.Close Browser

Test Tags           tnr


*** Variables ***
# variable SUT
${URL}                      https://todomvc.com/examples/angular/dist/browser/#/all

# variable CONF
${BROWSER}                  chrome
# page object model
${LOCATOR_TITLE}            xpath://h1
${LOCATOR_INPUT_NEWTODO}    xpath://app-todo-header//input
${LOCATOR_TODO_LIST}        xpath://app-todo-list//app-todo-item
${LOCATOR_BUTTON_CLEAR}     xpath://button[contains(.,"Clear Completed")]
${LOCATOR_DELETE}           //button[@class="destroy"]


*** Test Cases ***
Scenario TODO
    [Documentation]
    ...    \n0) Exercices sur le site angular
    ...    \n1) scenario d'ajout de 3 todo
    ...    \n2) traitement d'une tache
    ...    \n3) supression d'une tache
    ...    \n4) contrôle supplémentaire
    Launch Todo
    Capture Page Screenshot    ${OUTPUT_DIR}/step01-initial.png
    Add Todo    SELENIUM
    Add Todo    APPIUM
    Add Todo    PYTHON
    Count Todo    3
    Capture Page Screenshot    ${OUTPUT_DIR}/step02-addTodo.png
    Select Todo    APPIUM
    Capture Page Screenshot    ${OUTPUT_DIR}/step03-selectTodo.png
    Clear Todo
    Count Todo    2
    Capture Page Screenshot    ${OUTPUT_DIR}/step04-clearTodo.png
    Delete Todo    PYTHON
    Count Todo    1
    Capture Page Screenshot    ${OUTPUT_DIR}/step05-clearTodo.png
    # VERIFICATION A REALISER


*** Keywords ***
# page object model

YOU_CAN_DO_IT_KEYWORD
    [Arguments]    @{arg}
    Log    ${arg}

Launch Todo
    # Ouvrir navigateur
    Open Browser    ${URL}    ${BROWSER}
    # implicit wait
    Set Browser Implicit Wait    1s
    # attendre que l'url contient
    Wait Until Location Contains    angular
    # attendre que l'élément contient
    Wait Until Element Contains    ${LOCATOR_TITLE}    Todos    timeout=5s

Add Todo
    [Arguments]    ${todo_name}="TODO"
    # Saisir un todo
    Input Text    ${LOCATOR_INPUT_NEWTODO}    ${todo_name}
    # Soumettre le formulaire
    Press Keys    ${LOCATOR_INPUT_NEWTODO}    RETURN
    # attendre que la page contient notre saisie
    Wait Until Element Contains    ${LOCATOR_TODO_LIST}\[contains(.,"${todo_name}")]    ${todo_name}    timeout=5s

Select Todo
    [Arguments]    ${todo_name}
    # cliquer sur notre checkbox de sélection de tache
    Select Checkbox    ${LOCATOR_TODO_LIST}\[contains(.,"${todo_name}")]//input[@type="checkbox"]

Clear Todo
    # cliquer sur clear completed
    Click Element    ${LOCATOR_BUTTON_CLEAR}

Delete Todo
    [Arguments]    ${todo_name}
    # cliquer sur supprimer la todo
    Mouse Over    ${LOCATOR_TODO_LIST}\[contains(.,"${todo_name}")]
    Wait Until Element Is Visible    ${LOCATOR_TODO_LIST}\[contains(.,"${todo_name}")]${LOCATOR_DELETE}    5s
    Click Element    ${LOCATOR_TODO_LIST}\[contains(.,"${todo_name}")]${LOCATOR_DELETE}

Count Todo
    [Arguments]    ${excpected_result}
    ${count}=    Get Element Count    ${LOCATOR_TODO_LIST}
    Should Be True    ${count} == ${excpected_result}
