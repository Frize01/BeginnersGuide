*** Settings ***
Library    SeleniumLibrary
Library    ../../.venv/lib/python3.10/site-packages/robot/libraries/Screenshot.py
Resource    ./variable.resource

*** Keywords ***
Ouvrir le navigateur
    [Documentation]    Ouvrir le navigateur et accéder à l'URL de connexion
    variable.initialize data set
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    name=username    timeout=${TIMEOUT}

Fermer le navigateur
    Close Browser

Navigation NavBar
    [Arguments]    ${element}
    [Documentation]    Naviguer dans la barre de navigation
    Click Element    xpath=//span[text()='${element}']
    Wait Until Page Contains Element    xpath=//h6[contains(normalize-space(), '${element}')]    timeout=${TIMEOUT}
Clear And Fill Field
    [Arguments]    ${element}    ${new_content}
    Wait Until Element Is Visible    ${element}    timeout=${TIMEOUT}
    SeleniumLibrary.Press Keys       xpath=${element}    ${SELECT_ALL_KEY}
    Press Keys    NONE    BACKSPACE
    Input Text                       ${element}    ${new_content}

