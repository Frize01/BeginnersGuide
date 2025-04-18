*** Settings ***
Library    FakerLibrary
Library    OperatingSystem

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
${SELECT_ALL_KEY}    COMMAND+A

*** Keywords ***

initialize data set
    ${FIRSTNAME} =    FakerLibrary.First Name
    ${MIDDLE_NAME} =    FakerLibrary.Name
    ${LASTNAME} =    FakerLibrary.Last Name
    ${EMPLOYEE_NAME} =    FakerLibrary.Name
    ${NEW_USERNAME} =    FakerLibrary.User Name
    ${NEW_PASSWORD} =    FakerLibrary.Password
    ${FIRSTNAME_MODIFIED_VALUE_FIELD} =    FakerLibrary.First Name
    Set Test Variable    ${FIRSTNAME}
    Set Test Variable    ${MIDDLE_NAME}
    Set Test Variable    ${LASTNAME}
    Set Test Variable    ${EMPLOYEE_NAME}
    Set Test Variable    ${NEW_USERNAME}
    Set Test Variable    ${NEW_PASSWORD}
    Set Test Variable    ${FIRSTNAME_MODIFIED_VALUE_FIELD}
    # Je suis sur MacOS au début je ne comprennais pas pourquoi ça ne marchait pas avec Control+A
    ${system}=    Evaluate    platform.system()    platform
    Run Keyword If    '${system}' == 'Darwin'    Set Suite Variable    ${SELECT_ALL_KEY}    COMMAND+A
    ...    ELSE    Set Suite Variable    ${SELECT_ALL_KEY}    CTRL+A