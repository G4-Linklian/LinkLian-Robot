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
${USERNAME_SCHOOL}                info@kmutt.ac.th
${PASSWORD_SCHOOL}                kmuttRegistration!
${SUBJECT_ID}                     CSS101
${SECTION_NAME}                   S2

*** Test Cases ***
Scheduling Work Test
    Open App
    Input Credentials    ${USERNAME_SCHOOL}    ${PASSWORD_SCHOOL}
    Click Login Button
    Open Scheduling Work Page
    Add Section
    Manage Section
    Close App

#Scheduling Work Flow
    Open App
    Input Credentials    ${USERNAME_SCHOOL}    ${PASSWORD_SCHOOL}
    Click Login Button
    Open Scheduling Work Page
    Add Section With CSV
    Add Enrollment With CSV
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

Open Scheduling Work Page
#    Wait Until Page Contains    ยินดีต้อนรับสู่ระบบทะเบียน    10s
    Wait Until Element Is Visible    xpath=//div[normalize-space()="งานจัดตาราง"]    10s
    Click Element    xpath=//button[.//div[normalize-space()="งานจัดตาราง"]]

Add Section
    Wait Until Element Is Visible    //*[@id="add-section-button"]    10s
    Click Element    //*[@id="add-section-button"]
    Input Text    //*[@id="select-subject"]    ${SUBJECT_ID}
    Sleep    2s
    Click Element    xpath=//*[@data-combobox-option="true" and contains(., "CSS101")]
    Input Text    //*[@id="section-name"]    ${SECTION_NAME}
    Click Element    //*[@id="submit-button"]
    Sleep    3s

Add Section With CSV
    Sleep    5s
    Click Element    //*[@id="add-section-button"]
    Click Element    //*[@id="add-section-tab"]/div[2]/label
    Click Element    //*[@id="next-step-button"]
    Sleep    3s
    ${FILE_TMP}    Set Variable    ${EXECDIR}/../Files/university/uni_section_templat.xlsx
    ${FILE}        Normalize Path    ${FILE_TMP}
    File Should Exist    ${FILE}
    Sleep    3s
    Choose File    xpath=//*[@id="section-dropzone"]//input[@type="file"]    ${FILE}
    Click Element    //*[@id="validate-file-button"]
    Click Element    //*[@id="confirm-button"]
    Press Keys    None    ESC
    Sleep    5s

Manage Section
    Click Element    xpath=//table[@id="section-table"]//tr[td[1][normalize-space()='3']]
    Click Element    //*[name()='svg' and contains(@class,'tabler-icon-eye')]
    Sleep    2s
    Click Element    //*[@id="add-schedule-button"]
    Click Element    //*[@id="select-day-of-week"]
    Click Element    xpath=//*[@data-combobox-option="true" and contains(., "จันทร์")]
    Click Element    //*[@id="input-start-time"]
    Input Text       //*[@id="input-start-time"]    10:30
    Press Keys       //*[@id="input-start-time"]    ENTER
    Input Text       //*[@id="input-end-time"]      12:30
    Press Keys       //*[@id="input-end-time"]      ENTER
    Sleep    1s
    Click Element    //*[@id="select-building"]
    Click Element    xpath=//*[@data-combobox-option="true" and contains(., "อาคารเรียนรวม 1")]
    Sleep    1s
    Click Element    //*[@id="select-room"]
    Click Element    xpath=//*[@data-combobox-option="true" and contains(., "101")]
    Click Element    //*[@id="save-button"]
    Sleep    1s
    Click Element    //*[@id="add-teacher-button"]
    Click Element    //*[@id="select-teacher"]
    Input Text       //*[@id="select-teacher"]    141227007   
    Click Element    xpath=//*[@data-combobox-option="true" and contains(., "141227007")]
    Click Element    //*[@id="teacher-position-select"]
    Click Element    xpath=//*[@data-combobox-option="true" and contains(., "ผู้ช่วยสอน")]
    Click Element    //*[@id="submit-button"]
    Sleep    1s
    Click Element    //*[@id="add-student-button"]
    Click Element    //*[@id="select-user"]
    Input Text       //*[@id="select-user"]    47987
    Click Element    xpath=//*[@data-combobox-option="true" and contains(., "47987")]
    Click Element    //*[@id="submit-button"]
    Sleep    5s

Add Enrollment With CSV
    Sleep    5s
    Execute Javascript    document.evaluate('//*[@id="section-table"]/tbody/tr[15]', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView({block:'center'});
    Click Element    //*[@id="section-table"]/tbody/tr[15]//*[contains(@class,"tabler-icon-eye")]
    Sleep    10s   
    Wait Until Element Is Visible    //*[@id="add-student-button"]    10s
    Click Element    //*[@id="add-student-button"]
    Click Element    //*[@id="add-student-tab"]/div[2]/label
    Click Element    //*[@id="next-step-button"]
    Sleep    3s
    ${FILE_TMP}    Set Variable    ${EXECDIR}/../Files/university/uni_enrollment_template.xlsx
    ${FILE}        Normalize Path    ${FILE_TMP}
    File Should Exist    ${FILE}
    Sleep    3s
    Choose File    xpath=//*[@id="enrollment-import-dropzone"]//input[@type="file"]    ${FILE}
    Click Element    //*[@id="validate-button"]
    Click Element    //*[@id="confirm-import-button"]
    Press Keys    None    ESC
    Sleep    5s