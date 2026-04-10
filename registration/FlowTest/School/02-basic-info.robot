*** Settings ***
Library           SeleniumLibrary
Library           Collections
Library           OperatingSystem
Library           RequestsLibrary
Library           String
Library           BuiltIn
Library           DateTime
Library           JSONLibrary

*** Variables ***
${URL_LOGIN}                      https://uat-app.linklian.org/registration/login
${BROWSER}                        Chrome
${USERNAME_SCHOOL}                registration@khp.ac.th
${PASSWORD_SCHOOL}                khpRegistration!
${USER_ID1}                       141213
${USER_NAME}                      อภิชาติ
${USER_SURENAME}                  ศรีสวัสดิ์
${USER_EMAIL}                     apichart.sri@example.com
${PHONE_NUMBER}                   0812345678
${SEMESTER}                       1/2570
${START_DATE}                     02/08/2570
${END_DATE}                       15/12/2571
${BUILDING_NAME}                  อาคารเรียนรวม
${BUILDING_NUMBER}                10

*** Test Cases ***
#Basic Info Test
    Open App
    Input Credentials    ${USERNAME_SCHOOL}    ${PASSWORD_SCHOOL}
    Click Login Button
    Open Basic Info Page
    Add Teacher
    Add Semester
    Add Building
    Close App

Basic Info Flow
    Open App
    Input Credentials    ${USERNAME_SCHOOL}    ${PASSWORD_SCHOOL}
    Click Login Button
    Open Basic Info Page
    Add Teacher With CSV
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

#---------------------------------------------------------------------------

Open Basic Info Page
#    Wait Until Page Contains    ยินดีต้อนรับสู่ระบบทะเบียน    10s
    Wait Until Element Is Visible    xpath=//div[normalize-space()="ข้อมูลพื้นฐาน"]    10s
    Click Element    xpath=//button[.//div[normalize-space()="ข้อมูลพื้นฐาน"]]

Add Teacher
    Wait Until Element Is Visible    //*[@id="add-staff-button"]    10s
    Click Element    //*[@id="add-staff-button"]
    Input Text    //*[@id="input-staff-code"]    ${USER_ID1}
    Input Text    //*[@id="input-first-name"]    ${USER_NAME}
    Input Text    //*[@id="input-middle-name"]    ${USER_SURENAME}
    Input Text    //*[@id="input-email"]    ${USER_EMAIL}
    Input Text    //*[@id="input-phone"]    ${PHONE_NUMBER}
    Click Element    //*[@id="select-learning-area"]
    Click Element    xpath=//*[@data-combobox-option="true" and contains(., "สังคมศึกษา")]
    Click Element    //*[@id="select-user-status"]
    Click Element    xpath=//*[@data-combobox-option="true" and contains(., "ใช้งาน")]
    Click Element    //*[@id="submit-button"]
    Sleep    5s

Add Teacher With CSV
    Sleep    5s    
    Click Element    //*[@id="add-staff-button"]
    Click Element    //*[@id="add-staff-tab"]/div[2]/label
    Click Element    //*[@id="next-step-button"]
    Sleep    3s 
    ${FILE_TMP}    Set Variable    ${EXECDIR}/../Files/school/sch_academic_staff_template.xlsx
    ${FILE}        Normalize Path    ${FILE_TMP}
    File Should Exist    ${FILE}
    Sleep    3s 
    Choose File    xpath=//*[@id="staff-import-dropzone"]//input[@type="file"]    ${FILE}
    Click Element    //*[@id="validate-button"]
    Click Element    //*[@id="confirm-import-button"]
    Press Keys    None    ESC
    Sleep    5s

Add Semester
    Click Element    //*[@id="add-semester-button"]
    Input Text    //*[@id="input-semester"]    ${SEMESTER}
    Input Text    //*[@id="input-start-date"]    ${START_DATE}
    Input Text    //*[@id="input-end-date"]    ${END_DATE}
    Click Element    //*[@id="submit-button"]
    Click Element    //*[@id="cancel-button"]
    Sleep    3s

Add Building
    Click Element    //*[@id="add-building-button"]
    Input Text     //*[@id="input-building-name"]    ${BUILDING_NAME}
    Input Text     //*[@id="input-building-no"]    ${BUILDING_NUMBER}
    Click Element    //*[@id="submit-button"]
    Sleep    3s
