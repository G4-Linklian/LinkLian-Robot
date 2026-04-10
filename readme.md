# LinkLian-Robot

LinkLian-Robot เป็นระบบการทดสอบอัตโนมัติสำหรับขั้นตอนการลงทะเบียนนักเรียน ตั้งแต่โรงเรียนจนถึงระดับมหาวิทยาลัย โดยใช้ Robot Framework สำหรับการตรวจสอบคุณภาพของระบบ

## ภาพรวมโครงการ

ระบบนี้ออกแบบมาเพื่อทดสอบเวิร์กโฟลว์การลงทะเบียนนักเรียนให้ครบถ้วน ซึ่งครอบคลุม:

- **ขั้นตอนการล็อกอิน** - การตรวจสอบความปลอดภัยและการเข้าสู่ระบบ
- **ข้อมูลพื้นฐาน** - การตรวจสอบข้อมูลส่วนตัวและข้อมูลพื้นฐาน
- **การจัดการหลักสูตร** - การตรวจสอบการจัดการและการลงทะเบียนหลักสูตร
- **การจัดตารางเรียน** - การตรวจสอบการจัดตารางเรียนและการชั้นเรียน
- **ลงทะเบียนนักเรียน** - การตรวจสอบขั้นตอนสุดท้ายของการลงทะเบียน

สนับสนุนทั้ง **โรงเรียน** และ **มหาวิทยาลัย**

##  วิธีการเริ่มต้น

### ติดตั้ง Python และ Robot Framework

```bash
# ติดตั้ง Python 3.8 ขึ้นไป
python --version

# สร้าง Virtual Environment
python -m venv venv

# เปิดใช้งาน Virtual Environment
# สำหรับ macOS/Linux:
source venv/bin/activate

# สำหรับ Windows:
venv\Scripts\activate
```

### ติดตั้ง Dependencies

```bash
pip install -r requirements.txt
```

หรือติดตั้ง Robot Framework และ SeleniumLibrary ด้วยตนเอง:

```bash
pip install robotframework
pip install robotframework-seleniumlibrary
pip install openpyxl  # สำหรับอ่านไฟล์ Excel
```

### ตัวแปร Environment

สร้างไฟล์ `.env` หรือตั้งค่าตัวแปร environment ดังนี้:

```bash
# URL ของระบบ
APP_URL=http://your-app-url

# ข้อมูลการเข้าสู่ระบบ
USERNAME=your-username
PASSWORD=your-password

# Chrome/Firefox Driver Path (ถ้าจำเป็น)
DRIVER_PATH=/path/to/chromedriver
```

## วิธีการรัน Test

### รันทั้งหมดของมหาวิทยาลัย

```bash
robot --outputdir reports registration/FlowTest/University/
```

### รันเฉพาะไฟล์เดียว

```bash
robot --outputdir reports registration/FlowTest/University/01-home-uni.robot
```

### รันกับ Browser ที่มองเห็นได้ (Debug Mode)

```bash
robot --outputdir reports -d reports registration/FlowTest/University/
```

### รันเฉพาะ Test ที่มี Tag เฉพาะ

```bash
robot --include smoke -outputdir reports registration/FlowTest/University/
```

## ผลลัพธ์ Test

หลังจากรัน test แล้ว ผลลัพธ์จะบันทึกใน:

- `reports/output.xml` - ข้อมูล XML สำหรับการบันทึก
- `reports/log.html` - รายละเอียดการทดสอบ (เปิดด้วย Browser)
- `reports/report.html` - สรุปผลการทดสอบ

เปิดไฟล์ `report.html` เพื่อดูผลลัพธ์แบบภาพ

## โครงสร้าง Test Cases

ไฟล์ `.robot` ใช้ไวยากรณ์ของ Robot Framework:

```robot
*** Test Cases ***
Test Case Name
    [Documentation]    คำอธิบายของ Test
    [Tags]            smoke
    Keyword Name    Argument1    Argument2

*** Keywords ***
Custom Keyword
    [Arguments]    ${arg1}    ${arg2}
    Log    Message
    Click Button    button_id
```

## ตัวอย่าง Test Flow

1. **Login** - ล็อกอินเข้าสู่ระบบด้วยข้อมูลประจำตัว
2. **Home** - ตรวจสอบหน้าแรกของระบบ
3. **Basic Info** - ตรวจสอบและเพิ่มข้อมูลพื้นฐาน
4. **Course Management** - จัดการหลักสูตรและวิชา
5. **Scheduling** - จัดตารางเรียนและชั้นเรียน
6. **Student Registration** - ลงทะเบียนนักเรียนเสร็จสิ้น

## ความต้องการของระบบ

- **Python**: 3.8 ขึ้นไป
- **Robot Framework**: 5.0+
- **SeleniumLibrary**: 6.0+
- **Browser**: Chrome หรือ Firefox (ต้องติดตั้ง WebDriver)
- **Excel Support**: openpyxl

## Troubleshooting

### ไม่พบ WebDriver
```bash
# ดาวน์โหลด ChromeDriver ตรงกับเวอร์ชัน Chrome ของคุณ
# ใส่ไว้ใน PATH หรือระบุ path อย่างชัดเจนในสคริปต์
```

### Import Error ไม่พบ Library
```bash
pip install --upgrade robotframework-seleniumlibrary
```

### Test Timeout
ปรับค่า timeout ในสคริปต์ robot โดยใช้ `Set Selenium Timeout`

**สำหรับคำถามหรือปัญหา** โปรดติดต่อ Project Lead หรือสร้าง Issue ใน Repository