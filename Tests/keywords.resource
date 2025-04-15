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