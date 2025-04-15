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
    [Documentation]    ...    ${\n}Présentation Exercice
    ...    /basic-first-form-demo.html
    ...    ${\n}EXERCICE : saisir le message Hello dans le champ text
    ...    Cliquer sur le bouton show message
    ...    vérifier que le message qui s'affiche est bien celui attendu
    ...    Bonus : Remplacez HELLO par la variable d'environnement USERNAME
    # Naviguer vers
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Input Forms']
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Simple Form Demo']
    Highlight Element    id:user-message
    Input Text    id:user-message    HELLO %{USERNAME}
    Highlight Element    xpath://button[@onclick="showInput();"]
    Click Element    xpath://button[@onclick="showInput();"]
    Highlight Element    id:display
    Wait Until Element Contains    id:display    HELLO %{USERNAME}

Test01 Selenium Menu Input Forms - Simple Form Demo - Two Input Fields
    [Documentation]    ...    ${\n}Présentation formateur
    ...    /basic-first-form-demo.html
    ...    ${\n}EXERCICE : Manipulation du formulaire
    ...    ${\n}Saisir le nombre 1
    ...    ${\n}Saisir le nombre 2
    ...    ${\n}Cliquer sur la somme
    ...    ${\n}Récupérer le résultat
    ...    ${\n}Vérifier le résultat
    # Naviguer vers
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Input Forms']
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Simple Form Demo']
    Scroll Element To Top    xpath://div[text()="Two Input Fields"]
    Highlight Element    xpath://div[text()="Two Input Fields"]
    # Corrigé de l'exercice
    SeleniumLibrary.Input Text    id = sum1    10
    SeleniumLibrary.Input Text    id = sum2    4
    SeleniumLibrary.Click Element    xpath://button[text()='Get Total']
    SeleniumLibrary.Wait Until Element Contains    id = displayvalue    14

Test02 Selenium Menu Input Forms - Checkbox Demo - Single Checkbox Demo
    [Documentation]    ...    ${\n}Présentation formateur
    ...    /basic-checkbox-demo.html
    ...    ${\n}EXERCICE : Manipulation du formulaire
    ...    ${\n}Cliquer sur la Checkbox
    ...    ${\n}Vérifier le message
    # Naviguer vers
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Input Forms']
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Checkbox Demo']
    # Corrigé de l'exercice
    SeleniumLibrary.Select Checkbox    id = isAgeSelected
    
    #${status}    Run Keyword And Return Status    SeleniumLibrary.Checkbox Should Be Selected    id = isAgeSelected
    # SeleniumLibrary.Click Element    id = isAgeSelected

    SeleniumLibrary.Wait Until Element Contains    id = txtAge    Success - Check box is checked

Test03 Selenium Menu Input Forms - Checkbox Demo - Multiple Checkbox Demo
    [Documentation]    ...    ${\n}Présentation formateur
    ...    /basic-checkbox-demo.html
    ...    ${\n}EXERCICE : Manipulation du formulaire
    ...    ${\n}Cliquer sur Check All et Uncheck All (créer des locators pour différencier les deux)
    ...    ${\n}Sélectionner les 4 options
    ...    ${\n}Vérifier que le bouton est passé sur Uncheck All
    # Naviguer vers
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Input Forms']
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Checkbox Demo']
    Scroll Element To Top    xpath://div[text()="Multiple Checkbox Demo"]
    Highlight Element    xpath://div[text()="Multiple Checkbox Demo"]    
    # Corrigé de l'exercice
    SeleniumLibrary.Click Element    xpath://input[@value='Check All']
    SeleniumLibrary.Click Element    xpath://input[@value='Uncheck All']

    SeleniumLibrary.Select Checkbox    xpath://label[text()='Option 1']/input
    SeleniumLibrary.Select Checkbox    xpath://label[text()='Option 2']/input
    SeleniumLibrary.Select Checkbox    xpath://label[text()='Option 3']/input
    SeleniumLibrary.Select Checkbox    xpath://label[text()='Option 4']/input
	
	# OU 
	
    ${count}    SeleniumLibrary.Get Element Count    //label[contains(.,'Option')]
    FOR    ${counter}    IN RANGE    1    ${count+1}
        Log    ${counter}    console=${True}
        SeleniumLibrary.Select Checkbox    //label[text()='Option ${counter}']/input
    END	
	
	
	

    # les 3 méthode précisé dans le cours
    # method 1
    ${value}    SeleniumLibrary.Get Element Attribute    xpath://input[@id='check1']    value
    BuiltIn.Should Be Equal    Uncheck All    ${value}

    # method 2
    SeleniumLibrary.Wait Until Page Contains Element    xpath://input[@id='check1' and @value='Uncheck All']

    # method 3
    Wait Until Element Attribute Contains    xpath://input[@id='check1']    value    Uncheck All    10


Test04 Selenium Menu Input Forms - Radio Buttons Demo - Radio Button Demo
    [Documentation]    ...    ${\n}Présentation formateur
    ...    /basic-radiobutton-demo.html
    ...    ${\n}EXERCICE : Manipulation du formulaire
    ...    ${\n}Sélectionner Male puis Female
    ...    ${\n}Clicker sur Get Checked value
    ...    ${\n}Vérifier le message
    # Naviguer vers
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Input Forms']
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Radio Buttons Demo']
    # Corrigé de l'exercice

    SeleniumLibrary.Wait Until Page Contains Element    xpath://input[@name='optradio' and @value='Male']
    SeleniumLibrary.Wait Until Element Is Visible    xpath://input[@name='optradio' and @value='Male']
    SeleniumLibrary.Wait Until Element Is Enabled    xpath://input[@name='optradio' and @value='Male']
    


    SeleniumLibrary.Select Radio Button    optradio    Male
    SeleniumLibrary.Click Element    id = buttoncheck
    SeleniumLibrary.Wait Until Element Contains    css = p.radiobutton    Radio button 'Male' is checked
    
    ${genre}    BuiltIn.Set Variable    Female
    SeleniumLibrary.Wait Until Page Contains Element    xpath://*[@name='optradio' and @value='${genre}']
    SeleniumLibrary.Select Radio Button    optradio    ${genre}
    SeleniumLibrary.Click Element    id = buttoncheck
    SeleniumLibrary.Wait Until Element Contains    css = .radiobutton    Radio button '${genre}' is checked

Test05 Selenium Menu Input Forms - Select Dropdown List - Select List Demo 6
    [Documentation]    ...    ${\n}Présentation formateur    ...
    ...    ${\n}EXERCICE : Manipulation du formulaire    ...
    ...    ${\n}Sélectionner Monday    ...
    ...    ${\n}Vérifier que le message affiche bien la sélection    ...
    ...    ${\n}EXERCICE PLUS DIFFICILE : Sélectionner un élement de manière aléatoire    ...
    ...    ${\n}Sur ce corrigé le test va planter dans quel cas ?
    # Naviguer vers
    #Move Element To Up//*[text()='Menu List']
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Input Forms']
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Select Dropdown List']
    # Corrigé de l'exercice
    SeleniumLibrary.Wait Until Page Contains Element    id = select-demo
    SeleniumLibrary.Select From List By Value    id:select-demo    Wednesday
    SeleniumLibrary.Wait Until Element Contains    class = selected-value    Wednesday
    # Corrigé de l'exercice difficile
    ${countItem}    SeleniumLibrary.Get Element Count    xpath://select[@id='select-demo']/option
    # countItem a le premier élément en trop non sélectionnable qui est Please select
    # on esclut donc l'index 0, on commence notre random à 1
    ${randomItem}    BuiltIn.Evaluate    str(random.randint(1,${countItem}-1))    modules=random
    Select From List By Index    id = select-demo    ${randomItem}
    ${selectedItem}    Get Selected List Label    id = select-demo
    SeleniumLibrary.Wait Until Element Contains    class = selected-value    ${selectedItem}

Test06 Selenium Menu Input Forms - Select Dropdown List - Multi Select List Demo 7
    [Documentation]    ...    ${\n}Présentation formateurs
    ...    ${\n}EXERCICE : Manipulation du formulaire
    ...    ${\n}Sélectionner deux choix dans la liste
    ...    ${\n}Vérifier que le message First Selected correspond bien à la première sélection
    ...    ${\n}Vérifier que le message Get All Selected contient bien les deux sélections
    # Naviguer vers
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Input Forms']
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Select Dropdown List']
    # Corrigé de l'exercice
    # NE FONCTIONNE PAS : Select From List By Value    id = multi-select    Florida    CTRL+Texas
    SeleniumLibrary.Click Element    xpath://select[@id="multi-select"]/option[@value='Florida']
    SeleniumLibrary.Click Element    xpath://select[@id="multi-select"]/option[@value='Texas']    CTRL
    ${selectedValues}    SeleniumLibrary.Wait Until Page Contains Element    id = multi-select
    SeleniumLibrary.Click Element    id = printMe
    SeleniumLibrary.Wait Until Element Contains    css = .getall-selected    First selected option is : Florida
    SeleniumLibrary.Click Element    id = printAll
    SeleniumLibrary.Wait Until Element Contains    css = .getall-selected    Options selected are : Florida,Texas

Test07 Selenium Menu Progress Bars & Sliders - Bootstrap Progress bar - Progress Bar for Download 10
    [Documentation]    ...    ${\n}Présentation formateur    ...
    ...    ${\n}EXERCICE : Cliquer sur Download    ...
    ...    ${\n}Synchroniser et vérifier d'être à 100%    ...
    ...    ${\n}Quel est la durée nécessaire au timeout ?
    # Naviguer vers
    #Move Element To Up//*[text()='Menu List']
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Progress Bars & Sliders']
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Bootstrap Progress bar']
    # Corrigé de l'exercice
    SeleniumLibrary.Wait Until Element Contains    class = percenttext    0%
    SeleniumLibrary.Click Element    id = cricle-btn
    SeleniumLibrary.Wait Until Element Contains    class = percenttext    100%    timeout=30s

Test08 Selenium Menu Table - Table Data Search - Type in your search
    [Documentation]    ${\n}Présentation Exercice sur le parcourt d'un tableau
    ...    /table-search-filter-demo.html
    ...    ${\n}Récupérer le nom de la personne affectée à jQuery
    # Naviguer vers
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Table']
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Table Data Search']
    # Corrigé de l'exercice
    SeleniumLibrary.Wait Until Page Contains Element    //table[@id='task-table']
    # Exemple de solution rapide par XPATH1
    ${columnAssignee}    Get Text    xpath://tr[contains(., "jQuery library")]/td[3]
    BuiltIn.Log    Assignee: ${columnAssignee}

    # Exemple de solution rapide par XPATH2
    ${columnAssignee}    Get Text    xpath://td[text()="jQuery library"]/following-sibling::td[1]
    BuiltIn.Log    Assignee: ${columnAssignee}

    # Exemple de solution rapide par FILTRE et XPATH sur les not style ='display: none;'
    SeleniumLibrary.Input Text    id = task-table-filter    jQuery
    ${columnAssignee}    Get Text    xpath://table[@id='task-table']/tbody/tr[not(@style ='display: none;')]
    BuiltIn.Log    Assignee: ${columnAssignee}

    SeleniumLibrary.Input Text    id = task-table-filter    ${EMPTY}


    # Exemple par une boucle qui parcoure tout le tableau
    ${elementcount}    SeleniumLibrary.Get Element Count    xpath://table[@id='task-table']/tbody/tr
    ${task}    Set Variable    jQuery library
    ${personne_trouve}    Set Variable    ${false}

    FOR    ${index}    IN RANGE    1    ${elementcount}+1
        SeleniumLibrary.Wait Until Page Contains Element    xpath://table[@id='task-table']/tbody/tr[${index}]/td[2]
        ${columnTask}    SeleniumLibrary.Get Text    xpath://table[@id='task-table']/tbody/tr[${index}]/td[2]
        ${columnAssignee}    SeleniumLibrary.Get Text    xpath://table[@id='task-table']/tbody/tr[${index}]/td[3]
        IF    '''${columnTask}''' == '${task}'
            ${personne_trouve}    Set Variable    ${true}
            BREAK
        END
    END
    IF    ${personne_trouve} == ${false}
        Fail    La tache ${task} n'existe pas
    ELSE
        BuiltIn.Log    Assignee: ${columnAssignee}
    END
    
    # ATTENTION SI VOUS FILTREZ LES LIGNES SONT TOUJOURS PRESENTES MAIS INVISIBLES
    # <tr style="display: none;"></tr>
    # //table[@id='task-table']/tbody/tr[not(contains(@style, "display: none"))]

Test09 Selenium Menu Progress Bars & Sliders - Drag & Drop Sliders - Range Sliders
    [Documentation]    ${\n}Présentation Exercice
    ...    /drag-drop-range-sliders-demo.html
    ...    ${\n}EXERCICE : Manipuler la barre de progression
    ...    ${\n}Trouver un xpath qui identifie input et output en fonction de id="slider1"
    ...    ${\n}Faire un press keys ARROW_RIGHT sur la barre, on remarque que le press key clique au milieu avant et nous positionne à 50
    ...    ${\n}Alimenter une liste @{KEYS} de 40 ARROW_RIGHT afin de passer de 50 à 90
    ...    ${\n}Faire un press keys sur cette liste @{KEYS}
    ...    ${\n}Faire un press keys pour atteindre 89 avec seulement 3 KEYS (ARROW_LEFT, ARROW_RIGHT, HOME, END, PAGE_UP, PAGE_DOWN)
    # Naviguer vers
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Progress Bars & Sliders']
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Drag & Drop Sliders']
    # Corrigé de l'exercice
	
    # créer la liste 
    @{KEYS}    BuiltIn.Create List
    FOR    ${counter}    IN RANGE    20
        Collections.Append To List    ${KEYS}    ARROW_RIGHT
    END	
    BuiltIn.Repeat Keyword    20    Collections.Append To List    ${KEYS}    ARROW_RIGHT
	
    # cliquer sur l'élément, on va être positionné à 50 (ou 51 suivant la résolution)
    SeleniumLibrary.Click Element    xpath://div[@id="slider1"]//input
    
    # simule le nombre de press key vers la droite
    # @{KEYS}    --> c'est une liste d'argument donc ARROW_RIGHT    ARROW_RIGHT    ARROW_RIGHT    ARROW_RIGHT
    # ${KEYS}    --> c'est un seul objet de type liste python ['ARROW_RIGHT','ARROW_RIGHT','ARROW_RIGHT','ARROW_RIGHT', ....]
    
	SeleniumLibrary.Press Keys    xpath://div[@id="slider1"]//input    @{KEYS}

    SeleniumLibrary.Element Text Should Be    //div[@id="slider1"]//output    90

    # Pour atteindre 89 en 3 coups
    SeleniumLibrary.Click Element    xpath://div[@id="slider1"]//input
    SeleniumLibrary.Press Keys    xpath://div[@id="slider1"]//input    END    PAGE_DOWN    ARROW_LEFT
    SeleniumLibrary.Element Text Should Be    //div[@id="slider1"]//output    89

Test10 Selenium Menu Table - Table Pagination - Table with Pagination Example
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
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Table']
    SeleniumLibrary.Click Element    xpath://ul[@id='treemenu']//a[text()='Table Pagination']
    # Corrigé de l'exercice
    SeleniumLibrary.Wait Until Page Contains Element    //table
    # Compter le nombre de page
    ${nombrePage}    SeleniumLibrary.Get Element Count    xpath://ul[@id='myPager']//a[contains(@class,'page_link')]
    # ${nombrePage}    SeleniumLibrary.Get Element Count    css:#myPager a.page_link
    # Sur quelle page sommes nous au départ ?
    ${activePagePardefaut}    SeleniumLibrary.Get Text    xpath://ul[@id='myPager']//a[@class='page_link active']
    # Sur quelle page sommes si on navigue ?
    ${PageEnCours}    SeleniumLibrary.Get Text    css:#myPager li.active > a

    ${nombreLigne}    SeleniumLibrary.Get Element Count    xpath://table//tr[contains(@style,'table-row')]

    ${nombreLigneCumul}    BuiltIn.Set Variable    ${0}
    FOR    ${INDEX}    IN RANGE    1    ${nombrePage+1}
        ${activePage}    SeleniumLibrary.Get Text    //ul[@id='myPager']//li[@class='active']
        Should Be Equal As Numbers    ${INDEX}    ${activePage}
        ${nombreLigne}    SeleniumLibrary.Get Element Count    //tbody[@id='myTable']//tr[contains(@style,'table-row')]
        ${nombreLigneCumul}    BuiltIn.Evaluate    ${nombreLigneCumul} + ${nombreLigne}
        ${nextIsPresent}    BuiltIn.Run Keyword And Return Status
        ...    SeleniumLibrary.Element Should Be Visible
        ...    xpath://ul[@id='myPager']//a[contains(@class,'next_link')]
        IF    ${nextIsPresent}
            SeleniumLibrary.Click Element    xpath://ul[@id='myPager']//a[contains(@class,'next_link')]
        END
    END
    ${indexDerniereLigne}    SeleniumLibrary.Get Text
    ...    xpath://tbody[@id='myTable']//tr[contains(@style,'table-row')][last()]/td[1]
    BuiltIn.Should Be True    ${nombreLigneCumul} == int('${indexDerniereLigne}')
    Should Be Equal As Strings    ${nombreLigneCumul}    ${indexDerniereLigne}
    Should Be Equal As Numbers    ${nombreLigneCumul}    ${indexDerniereLigne}
    Should Be Equal As Integers    ${nombreLigneCumul}    ${indexDerniereLigne}
    # plante car les deux variables n'ont pas le même type (int et string)
    # Should Be Equal    ${nombreLigneCumul}    ${indexDerniereLigne}


Test Unitaire de Wait Until Element Attribute Contains
    Log    TEST UNITAIRE
    Log    TOUT LES CAS D'ERREUR DOIVENT PRODUIRE 2 TENTATIVES (1 SECONDE PAR TENTATIVE)
    Log    CAS D'ERREUR AVEC MAUVAIS LOCATOR
    Run Keyword And Continue On Failure    Wait Until Element Attribute Contains    id:xx    value    Check All    2
    Log    CAS D'ERREUR AVEC MAUVAIS NOM D'ATTRIBUT
    Run Keyword And Continue On Failure    Wait Until Element Attribute Contains    id:check1    xx    Check All    2
    Log    CAS D'ERREUR AVEC MAUVAISE VALEUR D'ATTRIBUT
    Run Keyword And Continue On Failure    Wait Until Element Attribute Contains    id:check1    value    xx    2
    Log    CAS PASSANT AVEC LES BONS PARAMETRES
    Run Keyword And Continue On Failure    Wait Until Element Attribute Contains    id:check1    value    Check All    2
    Log    CAS PASSANT AVEC LES BONS PARAMETRES POUR VERIFIER LE CONTAINS
    Run Keyword And Continue On Failure    Wait Until Element Attribute Contains    id:check1    value    All    2
	


*** Keywords ***
Ouvrir SeleniumEasy
    [Documentation]
    ...    Ouverture de Chrome à l'adresse ${SELENIUM_EASY_URL}

    # ETAPE DE LANCEMENT DE L APPLICATION
    SeleniumLibrary.Open Browser    ${SELENIUM_EASY_URL}/basic-first-form-demo.html
    ...    browser=chrome
    ...    options=add_experimental_option('excludeSwitches', ['enable-logging'])
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Set Selenium Implicit Wait    5s
    # SeleniumLibrary.Set Selenium Speed    0.1s

    # verification de l etat initial : etre sur la page du site
    # Cette partie est commenté car cette popup n'est plus présente
    # ${popupIsPresent}    BuiltIn.Run Keyword And Return Status
    # ...    SeleniumLibrary.Wait Until Page Contains Element
    # ...    //a[@title="Close"]
    # IF    ${popupIsPresent}
    #    SeleniumLibrary.Click Element    //a[@title="Close"]
    # END

    # Vérifier que le titre contient "Selenium Easy Demo"
    ${title}    SeleniumLibrary.Get Title
    BuiltIn.Should Contain    ${title}    Selenium Easy

Fermer SeleniumEasy
    [Documentation]
    ...    Fermeture du navigateur
    ...    On laisse un peu de temps pour visualiser l'écran final
    BuiltIn.Sleep    3
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
