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
${USERNAME_SCHOOL}                info@kmutt.ac.th
${PASSWORD_SCHOOL}                kmuttRegistration!
${USER_ID2}                       47982
${USER_NAME}                      กรกนก
${USER_SURENAME}                  เวลาเกิด
${USER_EMAIL}                     kornkanok.wel@example.com
${PHONE_NUMBER}                   0812345688

*** Test Cases ***
Student Registration Test
    Open App
    Input Credentials    ${USERNAME_SCHOOL}    ${PASSWORD_SCHOOL}
    Click Login Button
    Open Student Registration Page
    Add Student
    Close App

#Student Registration Flow
    Open App
    Input Credentials    ${USERNAME_SCHOOL}    ${PASSWORD_SCHOOL}
    Click Login Button
    Open Student Registration Page
    Add Student With CSV
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

Open Student Registration Page
#    Wait Until Page Contains    ยินดีต้อนรับสู่ระบบทะเบียน    10s
    Wait Until Element Is Visible    xpath=//div[normalize-space()="งานทะเบียนนักเรียน"]    10s
    Click Element    xpath=//button[.//div[normalize-space()="งานทะเบียนนักเรียน"]]

Add Student
    Wait Until Element Is Visible    //*[@id="add-student-button"]    10s
    Click Element    //*[@id="add-student-button"]
    Input Text    //*[@id="input-student-code"]    ${USER_ID2}
    Input Text    //*[@id="input-first-name"]    ${USER_NAME}
    Input Text    //*[@id="input-last-name"]    ${USER_SURENAME}
    Input Text    //*[@id="input-email"]    ${USER_EMAIL}
    Input Text    //*[@id="input-phone"]    ${PHONE_NUMBER}
    Click Element    //*[@id="select-edu-level"]
    Click Element    xpath=//*[@data-combobox-option="true" and contains(., "ปริญญาตรี ชั้นปี 3")]
    Input Text       //*[@id="select-program"]    วิทยาการคอมพิวเตอร์ประยุกต์
    Sleep    3s    
    Click Element    xpath=//*[@data-combobox-option="true" and contains(., "วิทยาการคอมพิวเตอร์ประยุกต์")]
    Sleep    1s
    Click Element    //*[@id="select-student-status"]
    Click Element    xpath=//*[@data-combobox-option="true" and contains(., "ใช้งาน")]
    Click Element    //*[@id="submit-button"]
    Sleep    3s

Add Student With CSV
    Sleep    10s
    Click Element    //*[@id="add-student-button"]
    Click Element    //*[@id="add-student-tab"]/div[2]/label
    Click Element    //*[@id="next-step-button"]
    Sleep    3s
    ${FILE_TMP}    Set Variable    ${EXECDIR}/../Files/university/uni_student_university_template.xlsx
    ${FILE}        Normalize Path    ${FILE_TMP}
    File Should Exist    ${FILE}
    Sleep    3s
    Choose File    xpath=//*[@id="student-import-dropzone"]//input[@type="file"]    ${FILE}
    Click Element    //*[@id="validate-button"]
    Click Element    //*[@id="confirm-import-button"]
    Press Keys    None    ESC
    Sleep    5s