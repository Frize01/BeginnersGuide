*** Settings ***
Library             SeleniumLibrary
Library             DateTime
Library             Collections

Test Setup          Ouvrir SeleniumEasy
Test Teardown       Fermer SeleniumEasy

Test Tags           tnr


*** Variables ***
${SELENIUM_EASY_URL}    http://localhost:8000/demo.seleniumeasy.com


*** Test Cases ***
Test00 Selenium Menu Input Forms - Simple Form Demo - Single Input Field
    [Tags]    selenium_00
    [Documentation]    ...    ${\n}Présentation Exercice
    ...    /basic-first-form-demo.html
    ...    ${\n}EXERCICE : saisir le message Hello dans le champ text
    ...    Cliquer sur le bouton show message
    ...    vérifier que le message qui s'affiche est bien celui attendu
    ...    Bonus : Remplacez HELLO par la variable d'environnement USERNAME
    # Naviguer vers
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Input Forms']
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Simple Form Demo']
    ${text}    Set Variable    WELCOME %{USERNAME}
    # Go To    ${SELENIUM_EASY_URL}/basic-first-form-demo.html
    Highlight Element    id=user-message
    Input Text    id=user-message    ${text}
    Highlight Element    xpath=//button[@onclick="showInput();"]
    Click Element    xpath=//button[@onclick="showInput();"]
    Highlight Element    id=display
    Wait Until Element Contains    id=display    ${text}
    # EXECUTER CE CODE POUR COMPRENDRE LA SOLUTION A L'EXERCICE
    


Test01 Selenium Menu Input Forms - Simple Form Demo - Two Input Fields
    [Tags]    selenium_01
    [Documentation]    ...    ${\n}Présentation Exercice
    ...    /basic-first-form-demo.html
    ...    ${\n}EXERCICE : Manipulation du formulaire
    ...    ${\n}Saisir le nombre 1
    ...    ${\n}Saisir le nombre 2
    ...    ${\n}Cliquer sur la somme
    ...    ${\n}Récupérer le résultat
    ...    ${\n}Vérifier le résultat
    # Naviguer vers
    # SeleniumLibrary.Click Element    //ul[@id='treemenu']//a[text()='Input Forms']
    # SeleniumLibrary.Click Element    //ul[@id='treemenu']//a[text()='Simple Form Demo']
    SeleniumLibrary.Go To    ${SELENIUM_EASY_URL}/basic-first-form-demo.html
    Scroll Element To Top    xpath=//div[text()="Two Input Fields"]
    Highlight Element    xpath=//div[text()="Two Input Fields"]
    # CODE A IMPLEMENTER ICI
    ${sum1}    Set Variable    9
    ${sum2}    Set Variable    15
    Input Text    id=sum1    ${sum1}
    Input Text    id=sum2    ${sum2}
    Click Element    xpath=//button[contains(.,"Get Total")]
    Wait Until Element Contains    id=displayvalue    ${${sum1}+${sum2}}

Test02 Selenium Menu Input Forms - Checkbox Demo - Single Checkbox Demo
    [Tags]    selenium_02
    [Documentation]    ...    ${\n}Présentation Exercice
    ...    /basic-checkbox-demo.html
    ...    ${\n}EXERCICE : Manipulation du formulaire
    ...    ${\n}Cliquer sur la Checkbox
    ...    ${\n}Vérifier le message
    # Naviguer vers
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Input Forms']
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Checkbox Demo']
    # CODE A IMPLEMENTER ICI
    Select Checkbox    id=isAgeSelected
    Wait Until Element Contains    id=txtAge    Success - Check box is checked
    Wait Until Page Contains    Success - Check box is checked

Test03 Selenium Menu Input Forms - Checkbox Demo - Multiple Checkbox Demo
    [Tags]    selenium_03
    [Documentation]    ...    ${\n}Présentation Exercice
    ...    /basic-checkbox-demo.html
    ...    ${\n}EXERCICE : Manipulation du formulaire
    ...    ${\n}Cliquer sur Check All et Uncheck All (créer des locators pour différencier les deux)
    ...    ${\n}Sélectionner les 4 options
    ...    ${\n}Vérifier que le bouton est passé sur Uncheck All
    # Naviguer vers
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Input Forms']
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Checkbox Demo']
    # Méthode avec les boutons
    Click Element    id=check1
    Wait Until Element Is Not Visible    xpath=//input[@id="check1" and @value="Check All"]
    Wait Until Element Is Visible    xpath=//input[@id="check1" and @value="Uncheck All"]
    Click Element    id=check1
    Wait Until Element Is Not Visible    xpath=//input[@id="check1" and @value="Uncheck All"]
    Wait Until Element Is Visible    xpath=//input[@id="check1" and @value="Check All"]

    # Méthode avec les checkbox
    @{all_checkbox}=    Get WebElements    //input[@class="cb1-element"]
    FOR    ${element}    IN    @{all_checkbox}
        Select Checkbox    ${element}
    END
    Wait Until Element Is Not Visible    xpath=//input[@id="check1" and @value="Check All"]
    Wait Until Element Is Visible    xpath=//input[@id="check1" and @value="Uncheck All"]

Test04 Selenium Menu Input Forms - Radio Buttons Demo - Radio Button Demo
    [Tags]    selenium_04
    [Documentation]    ...    ${\n}Présentation Exercice
    ...    /basic-radiobutton-demo.html
    ...    ${\n}EXERCICE : Manipulation du formulaire
    ...    ${\n}Sélectionner Male puis Female
    ...    ${\n}Clicker sur Get Checked value
    ...    ${\n}Vérifier le message
    # Naviguer vers
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Input Forms']
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Radio Buttons Demo']
    # CODE A IMPLEMENTER ICI

Test05 Selenium Menu Input Forms - Select Dropdown List - Select List Demo
    [Tags]    selenium_05
    [Documentation]    ...    ${\n}Présentation Exercice
    ...    /basic-select-dropdown-demo.html
    ...    ${\n}EXERCICE : Manipulation du formulaire
    ...    ${\n}Sélectionner Monday
    ...    ${\n}Vérifier que le message affiche bien la sélection
    ...    ${\n}EXERCICE PLUS DIFFICILE : Sélectionner un élement de manière aléatoire
    # Naviguer vers
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Input Forms']
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Select Dropdown List']
    # indice Select From List By Label
    ${day}    Set Variable    Monday
    # CODE A IMPLEMENTER ICI
    Select From List By Index    id=select-demo    2
    Capture Element Screenshot    id=select-demo
    Select From List By Label    id=select-demo    ${day}
    Capture Element Screenshot    id=select-demo
    Select From List By Value    id=select-demo    ${day}
    Capture Element Screenshot    id=select-demo
    Wait Until Element Contains    xpath=//p[@class='selected-value']    Day selected :- ${day}

    

Test06 Selenium Menu Input Forms - Select Dropdown List - Multi Select List Demo
    [Tags]    selenium_06
    [Documentation]    ...    ${\n}Présentation Exercice
    ...    /basic-select-dropdown-demo.html
    ...    ${\n}EXERCICE : Manipulation du formulaire
    ...    ${\n}Sélectionner deux choix dans la liste
    ...    ${\n}Vérifier que le message First Selected correspond bien à la première sélection
    ...    ${\n}Vérifier que le message Get All Selected contient bien les deux sélections
    # Naviguer vers
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Input Forms']
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Select Dropdown List']
    @{cities}    Set Variable    Florida    New York    Texas
    ${flag}    Set Variable    0
    FOR    ${city}    IN    @{cities}
        IF    "${flag}"=="0"
            Click Element    //select[@id="multi-select"]/option[@value="${city}"]
        ELSE
            Click Element    //select[@id="multi-select"]/option[@value="${city}"]    CTRL
        END
        Capture Element Screenshot    //select[@id="multi-select"]
        ${flag}=      Evaluate    ${flag} + 1
    END
    # CODE A IMPLEMENTER ICI
    # Select From List By Label ne fonctionnera pas, utiliser le click sur les balises option
    
    Click Element    id=printMe
    Wait Until Element Contains
    ...    xpath=//p[@class="getall-selected"]
    ...    First selected option is : ${cities}[0]
    Click Element    id=printAll
    Wait Until Element Contains
    ...    xpath=//p[@class="getall-selected"]
    ...    Options selected are : ${cities}[0],${cities}[1],${cities}[2]

Test07 Selenium Menu Progress Bars & Sliders - Bootstrap Progress bar - Progress Bar for Download
    [Tags]    selenium_07
    [Documentation]    ${\n}Présentation Exercice
    ...    /bootstrap-download-progress-demo.html
    ...    ${\n}EXERCICE : Cliquer sur Download
    ...    ${\n}Synchroniser et vérifier d'être à 100%
    ...    ${\n}Quel est la durée nécessaire au timeout ?
    # Naviguer vers
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Progress Bars & Sliders']
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Bootstrap Progress bar']
    # CODE A IMPLEMENTER ICI

Test08 Selenium Menu Table - Table Data Search - Type in your search
    [Tags]    selenium_08
    [Documentation]    ${\n}Présentation Exercice sur le parcourt d'un tableau
    ...    /table-search-filter-demo.html
    ...    ${\n}Récupérer le nom de la personne affectée à jQuery

    # Naviguer vers
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Table']
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Table Data Search']
    # CODE A IMPLEMENTER ICI

Test09 Selenium Menu Progress Bars & Sliders - Drag & Drop Sliders - Range Sliders
    [Tags]    selenium_09
    [Documentation]    ${\n}Présentation Exercice
    ...    /drag-drop-range-sliders-demo.html
    ...    ${\n}EXERCICE : Manipuler la barre de progression
    ...    ${\n}Trouver un xpath qui identifie input et output en fonction de id="slider1"
    ...    ${\n}Faire un press keys ARROW_RIGHT sur la barre, on remarque que le press key clique au milieu avant et nous positionne à 50
    ...    ${\n}Alimenter une liste @{KEYS} de 40 ARROW_RIGHT afin de passer de 50 à 90
    ...    ${\n}Faire un press keys sur cette liste @{KEYS}
    ...    ${\n}Faire un press keys pour atteindre 89 avec seulement 3 KEYS (ARROW_LEFT, ARROW_RIGHT, HOME, END, PAGE_UP, PAGE_DOWN)
    # Naviguer vers
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Progress Bars & Sliders']
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Drag & Drop Sliders']
    # CODE A IMPLEMENTER ICI

Test10 Selenium Menu Table - Table Pagination - Table with Pagination Example
    [Tags]    selenium_10
    [Documentation]    ${\n}Présentation Exercice
    ...    /table-pagination-demo.html
    ...    ${\n}EXERCICE : Naviguer sur le nombre de page et le nombre de ligne des tableaux
    ...    ${\n}Compter le nombre de page
    ...    ${\n}Sur quelle page sommes nous ?
    ...    ${\n}Compter le nombre de ligne du tableau
    ...    ${\n}Initialiser une variable nombreLigneCumul à 0
    ...    ${\n}Faire une boucle sur le nombre de page en cliquant sur suivant à la fin
    ...    ${\n}Dans la boucle :
    ...    ${\n}    Vérifier que la page active correspond à l'index de la boucle
    ...    ${\n}    Compter le nombre de ligne du tableau
    ...    ${\n}    Faire le cumul du nombre de ligne
    ...    ${\n}    Cliquer sur le bouton suivant si on n'est pas sur la dernière page
    ...    ${\n}Récupérer l'index de la dernière ligne
    ...    ${\n}Vérifier que le cumul du nombre de ligne est égal à cet index
    # Naviguer vers
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Table']
    SeleniumLibrary.Click Element    xpath=//ul[@id='treemenu']//a[text()='Table Pagination']
    # CODE A IMPLEMENTER ICI

Test Unitaire de Wait Until Element Attribute Contains
    SeleniumLibrary.Go To    ${SELENIUM_EASY_URL}/basic-checkbox-demo.html
    Scroll Element To Top    xpath=//div[text()="Multiple Checkbox Demo"]
    Log    TEST UNITAIRE
    Log    TOUT LES CAS D'ERREUR DOIVENT PRODUIRE 2 TENTATIVES (1 SECONDE PAR TENTATIVE)
    Log    CAS D'ERREUR AVEC MAUVAIS LOCATOR
    Run Keyword And Continue On Failure
    ...    Run Keyword And Expect Error
    ...    locator id:xx not found
    ...    Wait Until Element Attribute Contains
    ...    id:xx
    ...    value
    ...    Check All
    ...    2
    Log    CAS D'ERREUR AVEC MAUVAIS NOM D'ATTRIBUT
    ${expected}    Set Variable
    ...    locator id:check1 found but the value of attribute xx is different \nExpected=Check All != Actual=None \n<input type="button" class="btn btn-primary" id="check1" value="Check All">
    Run Keyword And Continue On Failure
    ...    Run Keyword And Expect Error
    ...    ${expected}
    ...    Wait Until Element Attribute Contains
    ...    id:check1
    ...    xx
    ...    Check All
    ...    2
    Log    CAS D'ERREUR AVEC MAUVAISE VALEUR D'ATTRIBUT
    ${expected}    Set Variable
    ...    locator id:check1 found but the value of attribute value is different \nExpected=xx != Actual=Check All \n<input type="button" class="btn btn-primary" id="check1" value="Check All">
    Run Keyword And Continue On Failure
    ...    Run Keyword And Expect Error
    ...    ${expected}
    ...    Wait Until Element Attribute Contains
    ...    id:check1
    ...    value
    ...    xx
    ...    2
    Log    CAS PASSANT AVEC LES BONS PARAMETRES
    Run Keyword And Continue On Failure
    ...    Wait Until Element Attribute Contains
    ...    id:check1
    ...    value
    ...    Check All
    ...    2
    Log    CAS PASSANT AVEC LES BONS PARAMETRES POUR VERIFIER LE CONTAINS
    Run Keyword And Continue On Failure    Wait Until Element Attribute Contains    id:check1    value    All    2


*** Keywords ***
Ouvrir SeleniumEasy
    [Documentation]
    ...    Ouverture de Chrome à l'adresse ${SELENIUM_EASY_URL}
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --disable-search-engine-choice-screen
    Call Method    ${options}    add_argument    ignore-certificate-errors
    ${excludeSwitches}    Create List    enable-automation    enable-logging    disable-popup-blocking
    Call Method    ${options}    add_experimental_option    excludeSwitches    ${excludeSwitches}
    # ETAPE DE LANCEMENT DE L APPLICATION
    SeleniumLibrary.Open Browser    ${SELENIUM_EASY_URL}
    ...    browser=chrome
    ...    options=${options}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Set Selenium Implicit Wait    5s
    ${title}    SeleniumLibrary.Get Title
    BuiltIn.Should Contain    ${title}    Selenium Easy

Fermer SeleniumEasy
    [Documentation]
    ...    Fermeture du navigateur
    ...    On laisse un peu de temps pour visualiser l'écran final
    # BuiltIn.Sleep    3
    Capture Page Screenshot
    SeleniumLibrary.Close Browser

Scroll Element To Top
    [Documentation]    Permet de placer l'élément en haut de page avec delta
    ...    Par defaut le delta=0
    ...    Le delta peut être la hauteur d'un bandeau
    [Arguments]    ${locator}    ${delta_top}=0
    SeleniumLibrary.Wait Until Page Contains Element    ${locator}
    ${el_pos_y}    SeleniumLibrary.Get Vertical Position    ${locator}
    ${final_y}    BuiltIn.Evaluate    int(${el_pos_y}) -int(${delta_top})
    SeleniumLibrary.Execute Javascript    window.scrollTo(0, arguments[0])    ARGUMENTS    ${final_y}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}

Highlight Element
    [Arguments]    ${locator}
    # Change le style de couleur de l'élément pour le mettre en évidence (le bord en rouge et le fond en jaune)
    # Le style est repositionné par défault
    ${element}    SeleniumLibrary.Get WebElement    ${locator}
    ${original_style}    SeleniumLibrary.Execute Javascript
    ...    element = arguments[0];
    ...    original_style = element.getAttribute('style');
    ...    element.setAttribute('style', original_style + "; color: red; background: yellow; border: 2px solid red;");
    ...    return original_style;
    ...    ARGUMENTS
    ...    ${element}
    BuiltIn.Sleep    0.1s
    ${element}    SeleniumLibrary.Get WebElement    ${locator}
    SeleniumLibrary.Execute Javascript
    ...    element = arguments[0];
    ...    original_style = arguments[1];
    ...    element.setAttribute('style', original_style);
    ...    ARGUMENTS
    ...    ${element}
    ...    ${original_style}

Wait Until Element Attribute Contains
    [Arguments]    ${locator}    ${attribute_name}    ${attribute_expected_value}    ${nb_loop_in_second}=2
    ${initial_implicit_wait}    Set Selenium Implicit Wait    0
    FOR    ${counter}    IN RANGE    ${nb_loop_in_second}
        ${find_element}    Run Keyword And Return Status    SeleniumLibrary.Page Should Contain Element    ${locator}
        IF    ${find_element}
            ${attribute_actual_value}    SeleniumLibrary.Get Element Attribute    ${locator}    ${attribute_name}
            ${comparaison}    Run Keyword And Return Status
            ...    Should Contain
            ...    ${attribute_actual_value}
            ...    ${attribute_expected_value}
            IF    ${comparaison}    BREAK
        END
        Sleep    1s
    END
    Set Selenium Implicit Wait    ${initial_implicit_wait}
    IF    ${find_element} == ${false}    Fail    locator ${locator} not found
    IF    ${comparaison} == ${false}
        ${outerHTML}    SeleniumLibrary.Get Element Attribute    ${locator}    outerHTML
        ${message}    Catenate    locator ${locator} found but the value of attribute ${attribute_name} is different
        ...    \nExpected=${attribute_expected_value} != Actual=${attribute_actual_value}
        ...    \n${outerHTML}
        Fail    ${message}
    END
