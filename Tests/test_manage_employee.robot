*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary

Resource    ./ressources/auth.resource
Resource    ./ressources/basic_action.resource
Resource    ./ressources/variable.resource

Test Setup    basic_action.Ouvrir le navigateur
Test Teardown    basic_action.Fermer le navigateur

Test Tags       user_mng

*** Keywords ***

Create Employee
    [Arguments]    ${employee_lastname}    ${employee_firstname}    ${employee_middletname}
    [Documentation]    Créer un nouvel employé
    basic_action.Navigation NavBar    PIM
    Click Button    xpath=//button[normalize-space()='Add']
    Wait Until Element Is Visible    xpath=//h6[text()='Add Employee']    timeout=${TIMEOUT}

    Input Text    name=firstName    ${employee_firstname}
    Input Text    name=middleName     ${employee_middletname}
    Input Text    name=lastName     ${employee_lastname}

    Click Button    xpath=//button[normalize-space()='Save']

    Wait Until Page Contains Element    xpath=//h6[contains(normalize-space(), '${employee_lastname}')]   timeout=${TIMEOUT}
    Screenshot.Take Screenshot

Search Employee
    [Arguments]    ${employee_name}
    [Documentation]    Rechercher un employé
    basic_action.Navigation NavBar    PIM
    Input Text    //*[@id="app"]/div[1]/div[2]/div[2]/div/div[1]/div[2]/form/div[1]/div/div[1]/div/div[2]/div/div/input   ${employee_name}
    Click Button    xpath=//button[normalize-space()='Search']
    Wait Until Page Contains Element    xpath=//*[@id="app"]/div[1]/div[2]/div[2]/div/div[2]/div[3]/div/div[2]/div/div/div[4]/div[contains(normalize-space(), '${employee_name}')]   timeout=${TIMEOUT}
    Screenshot.Take Screenshot

Edit Employee
    [Arguments]    ${employee_name}
    [Documentation]    Modifier les informations d'un employé
    Search Employee    ${employee_name}
    Click Element    xpath=//div[contains(@class, 'oxd-table-row') and .//div[contains(normalize-space(), '${employee_name}')]]//button[i[contains(@class, 'bi-pencil-fill')]]
    Wait Until Page Contains Element    xpath=//h6[contains(normalize-space(), '${employee_name}')]   timeout=${TIMEOUT}
    SeleniumLibrary.Wait Until Page Contains Element    xpath=//*[@id="app"]/div[1]/div[2]/div[2]/div/div/div/div[2]/div[1]/form/div[1]/div/div/div/div[2]/div[1]/div[2]/input   timeout=${TIMEOUT}
    basic_action.Clear And Fill Field    //input[@name='lastName']    ${NEW_USERNAME}
    Click Button    xpath=//*[@id="app"]/div[1]/div[2]/div[2]/div/div/div/div[2]/div[1]/form/div[4]/button[normalize-space()='Save']
    Wait Until Page Contains Element    xpath=//*[normalize-space()='Successfully Updated']    timeout=${TIMEOUT}
    Screenshot.Take Screenshot

Delete Employee
    [Arguments]    ${employee_name}
    [Documentation]    Supprimer un employé
    Search Employee    ${employee_name}
    Click Element    xpath=//div[contains(@class, 'oxd-table-row') and .//div[contains(normalize-space(), '${employee_name}')]]//button[i[contains(@class, 'bi-trash')]]
    Wait Until Page Contains Element    xpath=//button[normalize-space()='Yes, Delete']   timeout=${TIMEOUT}
    Click Button    xpath=//button[normalize-space()='Yes, Delete']


*** Test Cases ***
Gestion des employes
    [Documentation]    Test de la gestion complète du cycle de vie d'un utilisateur
    Given auth.Connexion    ${USERNAME}    ${PASSWORD}
    When Create Employee   ${LASTNAME}    ${FIRSTNAME}    ${MIDDLE_NAME}
    When Search Employee    ${LASTNAME}
    When Edit Employee    ${LASTNAME}
    When Delete Employee    ${NEW_USERNAME}
    Then auth.Logout

