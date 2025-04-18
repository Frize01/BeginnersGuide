*** Settings ***
Library           SeleniumLibrary

Test Setup    Ouvrir la page de connexion
Test Teardown    Fermer le navigateur

*** Variables ***
${URL}    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${USERNAME}    Robotframework
${PASSWORD}    securepassword123
${USER_ROLE}    ESS
${STATUS}    Enabled
${EMPLOYEE_NAME}    a
${TIMEOUT}    10s

*** Test Cases ***
Gestion des utilisateurs
    [Tags]    User Management
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
    Input Text    name=username    Admin
    Input Text    name=password    admin123
    Click Button    xpath=//button[@type='submit']
    Wait Until Page Contains Element    xpath=//h6[contains(normalize-space(), 'Dashboard')]    timeout=${TIMEOUT}

Je navigue vers la page Admin
    Click Element    xpath=//span[text()='Admin']
    Wait Until Page Contains Element     xpath=//h6[contains(normalize-space(), 'Admin')]    timeout=${TIMEOUT}
    Log    message=Je suis sur la page Admin

Je crée un nouvel utilisateur
    Log    Début de la création de l'utilisateur ${USERNAME}
    Element Should Be Visible    xpath=//button[normalize-space()='Add']
    Click Element    xpath=//button[normalize-space()='Add']
    Wait Until Element Is Visible    xpath=//h6[text()='Add User']    timeout=${TIMEOUT}
    
    # Sélectionner le rôle utilisateur
    Click Element    xpath=//label[contains(text(), 'User Role')]/ancestor::div[contains(@class, 'oxd-input-group')]//div[contains(@class, 'oxd-select-text')]
    Wait Until Element Is Visible    xpath=//div[@role='listbox']    timeout=${TIMEOUT}
    Click Element    xpath=//div[@role='option' and contains(., '${USER_ROLE}')]
    
    # Sélectionner le statut
    Click Element    xpath=//label[contains(text(), 'Status')]/ancestor::div[contains(@class, 'oxd-input-group')]//div[contains(@class, 'oxd-select-text')]
    Wait Until Element Is Visible    xpath=//div[@role='listbox']    timeout=${TIMEOUT}
    Click Element    xpath=//div[@role='option' and contains(., '${STATUS}')]
    
    # Saisir le nom de l'employé
    Input Text    xpath=//label[contains(text(), 'Employee Name')]/ancestor::div[contains(@class, 'oxd-input-group')]//input    ${EMPLOYEE_NAME}
    
    # Attendre que la liste des suggestions apparaisse
    Wait Until Element Is Visible    xpath=//div[@role='listbox']    timeout=${TIMEOUT}
    Sleep    1s
    
    # Méthode 1: Sélectionner le premier résultat par clic
    # Wait Until Element Is Visible    xpath=//div[@role='option'][1]    timeout=${TIMEOUT}
    # Click Element    xpath=//div[@role='option'][1]
    
    # Méthode 2: Utiliser les touches du clavier pour le premier résultat
    Press Keys    xpath=//label[contains(text(), 'Employee Name')]/ancestor::div[contains(@class, 'oxd-input-group')]//input    ARROW_DOWN    RETURN
    
    # Entrer le nom d'utilisateur et le mot de passe
    Input Text    xpath=//label[contains(text(), 'Username')]/ancestor::div[contains(@class, 'oxd-input-group')]//input    ${USERNAME}
    Input Text    xpath=//label[contains(text(), 'Password')]/ancestor::div[contains(@class, 'oxd-input-group')]//input[@type='password']    ${PASSWORD}
    Input Text    xpath=//label[contains(text(), 'Confirm Password')]/ancestor::div[contains(@class, 'oxd-input-group')]//input[@type='password']    ${PASSWORD}
    
    # Sauvegarder
    Wait Until Element Is Visible    xpath=//button[normalize-space()='Save']    timeout=${TIMEOUT}
    Wait Until Element Is Enabled    xpath=//button[normalize-space()='Save']    timeout=${TIMEOUT}
    Click Element    xpath=//button[normalize-space()='Save']
    # Attendre la confirmation de création
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'oxd-toast-container')]    timeout=${TIMEOUT}
    Log    Utilisateur ${username} créé avec succès

Je vérifie que l'utilisateur a été créé
    # Rechercher l'utilisateur créé
    Input Text    xpath=//label[contains(text(), 'Username')]/ancestor::div[contains(@class, 'oxd-input-group')]//input    ${USERNAME}
    Press Keys    xpath=//label[contains(text(), 'Username')]/ancestor::div[contains(@class, 'oxd-input-group')]//input    RETURN
    
    # Vérifier que l'utilisateur est bien présent
    Wait Until Element Is Visible    xpath=//div[contains(text(), '${USERNAME}')]    timeout=${TIMEOUT}
    Element Should Be Visible    xpath=//div[contains(text(), '${USERNAME}')]

Je modifie les informations de l'utilisateur  
    # Cliquer sur le bouton d'édition
    Click Element    xpath=//div[contains(text(), '${USERNAME}')]/ancestor::div[contains(@class, 'oxd-table-row')]//i[contains(@class, 'bi-pencil-fill')]
    Wait Until Element Is Visible    xpath=//h6[text()='Edit User']    timeout=${TIMEOUT}
    
    # Modifier le statut de l'utilisateur
    Click Element    xpath=//label[contains(text(), 'Status')]/ancestor::div[contains(@class, 'oxd-input-group')]//div[contains(@class, 'oxd-select-text')]
    Wait Until Element Is Visible    xpath=//div[@role='listbox']    timeout=${TIMEOUT}
    Click Element    xpath=//div[@role='option' and contains(., 'Disabled')]
    
    # Sauvegarder les modifications
    Click Button    xpath=//button[normalize-space()='Save']
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'oxd-toast')]    timeout=${TIMEOUT}

Je vérifie que l'utilisateur a été modifié
    # Rechercher l'utilisateur modifié
    Input Text    xpath=//label[contains(text(), 'Username')]/ancestor::div[contains(@class, 'oxd-input-group')]//input    ${USERNAME}
    Press Keys    xpath=//label[contains(text(), 'Username')]/ancestor::div[contains(@class, 'oxd-input-group')]//input    RETURN
    
    # Vérifier que l'utilisateur est toujours présent mais modifié
    Wait Until Element Is Visible    xpath=//div[contains(text(), '${USERNAME}')]    timeout=${TIMEOUT}
    # Vérifier que le statut a bien été modifié à "Disabled"
    Element Should Be Visible    xpath=//div[contains(text(), '${USERNAME}')]/ancestor::div[contains(@class, 'oxd-table-row')]//div[contains(text(), 'Disabled')]

Je supprime l'utilisateur
    # Sélectionner l'utilisateur à supprimer
    Click Element    xpath=//div[contains(text(), '${USERNAME}')]/ancestor::div[contains(@class, 'oxd-table-row')]//i[contains(@class, 'bi-trash')]
    
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
    Wait Until Page Contains Element    name=username    timeout=${TIMEOUT}
    # URL contient "auth/login"
    ${current_url}=    Get Location
    Should Contain    ${current_url}    auth/login