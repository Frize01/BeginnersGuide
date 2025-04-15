*** Settings ***
Resource    ./keywords.resource

Library           SeleniumLibrary

Test Setup    Ouvrir la page de connexion
Test Teardown    Fermer le navigateur

Test Tags       user_mng

*** Variables ***
${URL}    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${USERNAME}    Admin
${PASSWORD}    admin123
${USER_ROLE}    ESS
${STATUS}    Enabled
${EMPLOYEE_NAME}    A
${NEW_USERNAME}    Robotframework
${NEW_PASSWORD}    secure password
${TIMEOUT}    10s

*** Test Cases ***
Gestion des utilisateurs
    [Documentation]    Test de la gestion complète du cycle de vie d'un utilisateur
    Given Je me connecte avec le compte Admin
    When Je navigue vers la page Admin
    And Je crée un nouvel utilisateur
    Then Je vérifie que l'utilisateur a été créé
    When Je modifie les informations de l'utilisateur
    Then Je vérifie que l'utilisateur a été modifié
    When Je supprime l'utilisateur
    And Je me déconnecte
    Then Je vérifie que je suis sur la page de connexion

*** Keywords ***
Ouvrir la page de connexion
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    name=username    timeout=${TIMEOUT}

Fermer le navigateur
    Close Browser

Je me connecte avec le compte Admin
    Input Text    name=username    ${USERNAME}
    Input Text    name=password    ${PASSWORD}
    Click Button    xpath=//button[@type='submit']
    Wait Until Element Is Visible    xpath=//h6[contains(text(), 'Dashboard')]    timeout=${TIMEOUT}

Je navigue vers la page Admin
    Click Element    xpath=//span[text()='Admin']
    Wait Until Element Is Visible    xpath=//h6[contains(text(), 'Admin')]    timeout=${TIMEOUT}

Je crée un nouvel utilisateur
    Click Button    xpath=//button[normalize-space()='Add']
    Wait Until Element Is Visible    xpath=//h6[text()='Add User']    timeout=${TIMEOUT}
    
    # Sélectionner le rôle utilisateur
    Click Element    xpath=//label[contains(text(), 'User Role')]/ancestor::div[contains(@class, 'oxd-input-group')]//div[contains(@class, 'oxd-select-text')]
    Wait Until Element Is Visible    xpath=//div[@role='listbox']    timeout=${TIMEOUT}
    Click Element    xpath=//div[@role='option' and contains(., '${USER_ROLE}')]
    
    # Sélectionner le statut
    Click Element    xpath=//label[contains(text(), 'Status')]/ancestor::div[contains(@class, 'oxd-input-group')]//div[contains(@class, 'oxd-select-text')]
    Wait Until Element Is Visible    xpath=//div[@role='listbox']    timeout=${TIMEOUT}
    Click Element    xpath=//div[@role='option' and contains(., '${STATUS}')]
    
    # Saisir le nom de l'employé et sélectionner dans les suggestions
    Input Text    xpath=//label[contains(text(), 'Employee Name')]/ancestor::div[contains(@class, 'oxd-input-group')]//input    ${EMPLOYEE_NAME}
    Wait Until Element Is Visible    xpath=//div[@role='listbox']    timeout=${TIMEOUT}
    Click Element    xpath=//div[@role='option'][1]
    
    # Entrer le nom d'utilisateur et le mot de passe
    Input Text    xpath=//label[contains(text(), 'Username')]/ancestor::div[contains(@class, 'oxd-input-group')]//input    ${NEW_USERNAME}
    Input Text    xpath=//label[contains(text(), 'Password')]/ancestor::div[contains(@class, 'oxd-input-group')]//input[@type='password']    ${NEW_PASSWORD}
    Input Text    xpath=//label[contains(text(), 'Confirm Password')]/ancestor::div[contains(@class, 'oxd-input-group')]//input[@type='password']    ${NEW_PASSWORD}
    
    # Sauvegarder
    Click Button    xpath=//button[normalize-space()='Save']
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'oxd-toast')]    timeout=${TIMEOUT}

Je vérifie que l'utilisateur a été créé
    # Rechercher l'utilisateur créé
    Input Text    xpath=//label[contains(text(), 'Username')]/ancestor::div[contains(@class, 'oxd-input-group')]//input    ${NEW_USERNAME}
    Click Button    xpath=//button[normalize-space()='Search']
    
    # Vérifier que l'utilisateur est bien présent
    Wait Until Element Is Visible    xpath=//div[contains(text(), '${NEW_USERNAME}')]    timeout=${TIMEOUT}
    Element Should Be Visible    xpath=//div[contains(text(), '${NEW_USERNAME}')]

Je modifie les informations de l'utilisateur
    # Cliquer sur le bouton d'édition
    Click Element    xpath=//div[contains(text(), '${NEW_USERNAME}')]/ancestor::div[contains(@class, 'oxd-table-row')]//i[contains(@class, 'bi-pencil-fill')]
    Wait Until Element Is Visible    xpath=//h6[text()='Edit User']    timeout=${TIMEOUT}
    
    # Modifier le statut (exemple de modification)
    Click Element    xpath=//label[contains(text(), 'Status')]/ancestor::div[contains(@class, 'oxd-input-group')]//div[contains(@class, 'oxd-select-text')]
    Wait Until Element Is Visible    xpath=//div[@role='listbox']    timeout=${TIMEOUT}
    Click Element    xpath=//div[@role='option' and contains(., 'Disabled')]
    
    # Sauvegarder les modifications
    Click Button    xpath=//button[normalize-space()='Save']
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'oxd-toast')]    timeout=${TIMEOUT}

Je vérifie que l'utilisateur a été modifié
    # Rechercher l'utilisateur modifié
    Input Text    xpath=//label[contains(text(), 'Username')]/ancestor::div[contains(@class, 'oxd-input-group')]//input    ${NEW_USERNAME}
    Click Button    xpath=//button[normalize-space()='Search']
    
    # Vérifier que l'utilisateur est toujours présent mais modifié
    Wait Until Element Is Visible    xpath=//div[contains(text(), '${NEW_USERNAME}')]    timeout=${TIMEOUT}
    # Vérifier que le statut a bien été modifié à "Disabled"
    Element Should Be Visible    xpath=//div[contains(text(), '${NEW_USERNAME}')]/ancestor::div[contains(@class, 'oxd-table-row')]//div[contains(text(), 'Disabled')]

Je supprime l'utilisateur
    # Sélectionner l'utilisateur à supprimer
    Click Element    xpath=//div[contains(text(), '${NEW_USERNAME}')]/ancestor::div[contains(@class, 'oxd-table-row')]//i[contains(@class, 'bi-trash')]
    
    # Confirmer la suppression
    Wait Until Element Is Visible    xpath=//button[normalize-space()='Yes, Delete']    timeout=${TIMEOUT}
    Click Button    xpath=//button[normalize-space()='Yes, Delete']
    
    # Attendre la confirmation de suppression
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'oxd-toast')]    timeout=${TIMEOUT}

Je me déconnecte
    Click Element    xpath=//span[contains(@class, 'oxd-userdropdown-tab')]
    Wait Until Element Is Visible    xpath=//a[contains(text(), 'Logout')]    timeout=${TIMEOUT}
    Click Element    xpath=//a[contains(text(), 'Logout')]

Je vérifie que je suis sur la page de connexion
    Wait Until Element Is Visible    xpath=//h5[contains(text(), 'Login')]    timeout=${TIMEOUT}
    Element Should Be Visible    name=username
    Element Should Be Visible    name=password