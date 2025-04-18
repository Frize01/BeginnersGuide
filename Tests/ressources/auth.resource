*** Settings ***
Library    SeleniumLibrary
Resource    ./variable.resource
Resource    ./basic_action.resource


*** Keywords ***
Connexion
    [Arguments]    ${username}    ${password}
    [Documentation]    Se connecter à l'application avec les identifiants fournis
    Input Text    name=username    ${username}
    Input Text    name=password    ${password}
    Click Button    xpath=//button[@type='submit']
    Wait Until Page Contains Element    xpath=//h6[contains(normalize-space(), 'Dashboard')]    timeout=${TIMEOUT}

Logout
    [Documentation]    Se déconnecter de l'application
    Click Element    xpath=//span[contains(@class, 'oxd-userdropdown-tab')]
    Wait Until Element Is Visible    xpath=//a[contains(text(), 'Logout')]    timeout=${TIMEOUT}
    Click Element    xpath=//a[contains(text(), 'Logout')]