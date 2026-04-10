*** Settings ***
Library               SeleniumLibrary
Library               Collections
Library               OperatingSystem
Library               RequestsLibrary
Library               String
Library               BuiltIn
Library               DateTime
Library               JSONLibrary

*** Variables ***
${URL_LOGIN}                      https://uat-app.linklian.org/registration/login
${BROWSER}                        Chrome
${USERNAME_SCHOOL}                registration@khp.ac.th
${PASSWORD_SCHOOL}                khpRegistration!
${LEARNING_AREA}                  สังคมศึกษา
${SUBJECT_ID}                     ส32001
${SUBJECT_NAME}                   สังคมศึกษา ศาสนา และวัฒนธรรม
${CREDITS}                        2.0
${LEARNING_TIME}                  2
${PROGRAM_NAME}                   ไทย-ญี่ปุ่น

*** Test Cases ***
#Course Work Test
    Open App
    Input Credentials    ${USERNAME_SCHOOL}    ${PASSWORD_SCHOOL}
    Click Login Button
    Open Course Work Page
    Add Learning Area
    Add Subject
    Add Program
    Close App

Course Work Flow
    Open App
    Input Credentials    ${USERNAME_SCHOOL}    ${PASSWORD_SCHOOL}
    Click Login Button
    Open Course Work Page
    Add Subject With CSV
    Add Program With CSV
    Close App

*** Keywords ***

Open App
    Open Browser    ${URL_LOGIN}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5s

Input Credentials
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    id=input-email    10s
    Input Text    //*[@id="input-email"]    ${username}
    Input Text    //*[@id="input-password"]    ${password}

Click Login Button
    Click Element    //*[@id="rememberMe"]
    Click Element    //*[@id="submit-button"]

Close App
    Close Browser

#------------------------------------------------------------------------------

Open Course Work Page
#    Wait Until Page Contains    ยินดีต้อนรับสู่ระบบทะเบียน    10s
    Wait Until Element Is Visible    xpath=//div[normalize-space()="งานหลักสูตร"]    10s
    Click Element    xpath=//button[.//div[normalize-space()="งานหลักสูตร"]]

Add Learning Area
    Wait Until Element Is Visible    //*[@id="add-learning-area-button"]    10s
    Click Element    //*[@id="add-learning-area-button"]
    Input Text    //*[@id="input-learning-area-name"]    ${LEARNING_AREA}
    Click Element    //*[@id="submit-button"]
    Sleep    2s

Add Subject
    Click Element    //*[@id="add-subject-button"]
    Click Element    //*[@id="select-learning-area"]
    Click Element    xpath=//*[@data-combobox-option="true" and contains(., "สังคมศึกษา")]
    Input Text    //*[@id="input-subject-code"]    ${SUBJECT_ID}
    Input Text    //*[@id="input-subject-name-th"]    ${SUBJECT_NAME}
    Input Text    //*[@id="input-subject-credit"]    ${CREDITS}
    Input Text    //*[@id="input-subject-hour-per-week"]    ${LEARNING_TIME}
    Click Element    //*[@id="submit-button"]
    Sleep    2s

Add Subject With CSV
    Sleep    10s
    Click Element    //*[@id="add-subject-button"]
    Click Element    //*[@id="add-subject-tab"]/div[2]/label
    Click Element    //*[@id="next-step-button"]
    Sleep    3s 
    ${FILE_TMP}    Set Variable    ${EXECDIR}/../Files/school/sch_subject_template.xlsx
    ${FILE}        Normalize Path    ${FILE_TMP}
    File Should Exist    ${FILE}
    Sleep    3s 
    Choose File    xpath=//*[@id="subject-import-dropzone"]//input[@type="file"]    ${FILE}
    Click Element    //*[@id="validate-button"]
    Click Element    //*[@id="confirm-import-button"]
    Press Keys    None    ESC
    Sleep    5s

Add Program
    Click Element    //*[@id="add-program-button"]
    Input Text    //*[@id="input-program-name"]    ${PROGRAM_NAME}
    Click Element    //*[@id="submit-button"]
    Sleep    2s

Add Program With CSV
    Sleep    10s
    Click Element    //*[@id="add-program-button"]
    Click Element    //*[@id="add-program-tab-control"]/div[2]/label
    Click Element    //*[@id="next-step-button"]
    Sleep    3s 
    ${FILE_TMP}    Set Variable    ${EXECDIR}/../Files/school/sch_program_school_template.xlsx
    ${FILE}        Normalize Path    ${FILE_TMP}
    File Should Exist    ${FILE}
    Sleep    3s 
    Choose File    xpath=//*[@id="program-import-dropzone"]//input[@type="file"]    ${FILE}
    Click Element    //*[@id="validate-button"]
    Sleep    2s
    Click Element    //*[@id="confirm-import-button"]
    Press Keys    None    ESC
    Sleep    5s