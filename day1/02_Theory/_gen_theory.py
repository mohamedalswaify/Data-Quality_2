# -*- coding: utf-8 -*-
from pathlib import Path

OUT = Path(r"C:\Users\Mohamed Alswaify\Desktop\Data Quality\Material\01_Day1_Foundations_Measurement\02_Theory")

CSS = """
body{background:#f7fafc;font-family:Tahoma,Arial,sans-serif;color:#1f2937;line-height:2.05;font-size:1.08rem;}
.hero{background:linear-gradient(135deg,#1f4e79,#2f6fa8);color:#fff;padding:28px 20px;border-radius:18px;margin-bottom:18px;}
.card{background:#fff;border:1px solid #dbe5f0;border-radius:16px;padding:18px 20px;margin-bottom:14px;box-shadow:0 4px 14px rgba(15,23,42,.05);}
.h{color:#1f4e79;font-weight:700;font-size:1.15rem;margin-bottom:8px;}
.ok{background:#ecfdf5;border-right:5px solid #059669;border-radius:12px;padding:12px 14px;margin:10px 0;}
.note{background:#fff8e1;border-right:5px solid #f2b705;border-radius:12px;padding:12px 14px;margin:10px 0;}
.bad{background:#fff1f2;border-right:5px solid #e11d48;border-radius:12px;padding:12px 14px;margin:10px 0;}
.code{background:#0f172a;color:#e2e8f0;border-radius:12px;padding:12px;font-family:Consolas,monospace;direction:ltr;text-align:left;white-space:pre-wrap;font-size:.92rem;}
.nav{margin-top:16px;}
.nav a{color:#1f4e79;font-weight:700;text-decoration:none;margin-left:12px;}
li{margin-bottom:.35rem;}
"""

def page(title, body, prev_file=None, next_file=None):
    nav = ['<div class="nav">', '<a href="00_Theory_Index.html">فهرس الشرح</a>']
    if prev_file:
        nav.append(f'<a href="{prev_file}">← السابق</a>')
    if next_file:
        nav.append(f'<a href="{next_file}">التالي →</a>')
    nav.append('</div>')
    return f"""<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>{title}</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.rtl.min.css" rel="stylesheet">
  <style>{CSS}</style>
</head>
<body>
  <div class="container py-4" style="max-width:860px">
    <section class="hero text-center"><h2 class="fw-bold mb-0">{title}</h2></section>
{body}
{''.join(nav)}
  </div>
</body>
</html>
"""

files = {}

files["T01_What_is_Data_Quality.html"] = page(
"01 — ما هي جودة البيانات؟",
"""
<div class="card">
  <div class="h"> الفكرة بكلمات بسيطة</div>
  <p>جودة البيانات تعني:</p>
  <div class="ok"><strong>هل البيانات صحيحة وكافية عشان أشتغل عليها بثقة؟</strong></div>
  <p>مثال من الحياة:</p>
  <ul>
    <li>لو رقم جوال العميل ناقص → مش هقدر أتصل به.</li>
    <li>لو الاسم مكتوب مرتين بطريقتين → النظام يحسبه عميلين.</li>
    <li>لو العنوان فاضي → الشحنة هترجع.</li>
  </ul>
</div>
<div class="card">
  <div class="h"> جملة مهمة احفظها</div>
  <div class="note">الجودة ليست «كمالًا 100%»، بل أن البيانات <strong>مناسبة للغرض</strong>.<br>
  لو غرضك تواصل مع العملاء، لازم الجوال والإيميل يكونوا موجودين وصحيحين.</div>
</div>
<div class="card">
  <div class="h"> خلاصة الدرس</div>
  <ol>
    <li>البيانات أصل أعمال.</li>
    <li>لو البيانات ضعيفة → القرار يضعف.</li>
    <li>أول خطوة: نفهم المشكلة بوضوح قبل أي إصلاح.</li>
  </ol>
</div>
""", None, "T02_Why_It_Matters.html")

files["T02_Why_It_Matters.html"] = page(
"02 — لماذا جودة البيانات مهمة؟",
"""
<div class="card">
  <div class="h"> تخيل هذا الموقف</div>
  <p>شركة تتصل بـ 1000 عميل لحملة تسويق.</p>
  <ul>
    <li>300 رقم خطأ</li>
    <li>200 رقم فاضي</li>
    <li>100 عميل مكرر</li>
  </ul>
  <div class="bad">يعني أكثر من نصف الجهد ضاع بدون فائدة.</div>
</div>
<div class="card">
  <div class="h"> ماذا نخسر؟</div>
  <ol>
    <li>فلوس (اتصالات/رسائل فاشلة)</li>
    <li>وقت الموظفين</li>
    <li>ثقة الإدارة في التقارير</li>
    <li>فرص بيع ضائعة</li>
  </ol>
</div>
<div class="card">
  <div class="h"> خلاصة</div>
  <div class="ok">تحسين الجودة = تقليل الخسارة + قرارات أفضل.</div>
</div>
""", "T01_What_is_Data_Quality.html", "T03_Completeness.html")

files["T03_Completeness.html"] = page(
"03 — الاكتمال Completeness",
"""
<div class="card">
  <div class="h"> المعنى</div>
  <p><strong>الاكتمال</strong> يعني: الحقل المهم موجود وغير فاضي.</p>
  <div class="ok">مثال: هل عند العميل رقم جوال؟</div>
</div>
<div class="card">
  <div class="h"> مثال جدول صغير</div>
  <table class="table table-bordered">
    <tr><th>الاسم</th><th>الجوال</th></tr>
    <tr><td>أحمد</td><td>0501112233</td></tr>
    <tr><td>سارة</td><td></td></tr>
    <tr><td>خالد</td><td>0559998877</td></tr>
  </table>
  <p>عندنا 3 صفوف. صف واحد الجوال فاضي.</p>
  <div class="note">اكتمال الجوال = 2 ÷ 3 × 100 = <strong>66.67%</strong></div>
</div>
<div class="card">
  <div class="h"> متى نقول الحقل ناقص؟</div>
  <ul>
    <li>NULL (فارغ في القاعدة)</li>
    <li>نص فاضي ""</li>
    <li>مسافات فقط</li>
  </ul>
</div>
<div class="card">
  <div class="h"> خلاصة</div>
  <p>Completeness يسأل سؤال واحد فقط: <strong>موجود ولا لا؟</strong></p>
</div>
""", "T02_Why_It_Matters.html", "T04_Validity.html")

files["T04_Validity.html"] = page(
"04 — الصلاحية Validity",
"""
<div class="card">
  <div class="h"> المعنى</div>
  <p><strong>الصلاحية</strong> تعني: القيمة موجودة… لكن هل شكلها صحيح؟</p>
</div>
<div class="card">
  <div class="h"> فرق مهم جدًا</div>
  <div class="ok">Completeness: هل فيه قيمة؟</div>
  <div class="note">Validity: هل القيمة صحيحة الشكل؟</div>
  <ul>
    <li>الجوال <code>05abcd</code> = موجود لكنه غير صالح</li>
    <li>الإيميل <code>khaled@@mail</code> = موجود لكنه غير صالح</li>
  </ul>
</div>
<div class="card">
  <div class="h"> أمثلة سهلة</div>
  <table class="table table-bordered">
    <tr><th>القيمة</th><th>Completeness</th><th>Validity</th></tr>
    <tr><td>0501234567</td><td>مكتمل</td><td>غالبًا صالح</td></tr>
    <tr><td>(فاضي)</td><td>ناقص</td><td>—</td></tr>
    <tr><td>123</td><td>مكتمل</td><td>غير صالح كجوال</td></tr>
  </table>
</div>
<div class="card">
  <div class="h"> خلاصة</div>
  <p>أولًا نسأل: موجود؟ ثم نسأل: صحيح؟</p>
</div>
""", "T03_Completeness.html", "T05_Uniqueness.html")

files["T05_Uniqueness.html"] = page(
"05 — التفرّد Uniqueness",
"""
<div class="card">
  <div class="h"> المعنى</div>
  <p><strong>التفرّد</strong> يعني: نفس الشخص/نفس الرقم لا يظهر أكثر من مرة بطريقة مضلّلة.</p>
</div>
<div class="card">
  <div class="h"> مثال</div>
  <table class="table table-bordered">
    <tr><th>الاسم</th><th>الإيميل</th></tr>
    <tr><td>أحمد العتيبي</td><td>ahmad@mail.com</td></tr>
    <tr><td>احمد العتيبي</td><td>ahmad@mail.com</td></tr>
  </table>
  <div class="bad">نفس الإيميل مرتين = غالبًا عميل مكرر.</div>
</div>
<div class="card">
  <div class="h"> ليه خطر؟</div>
  <ul>
    <li>خصم يتكرر مرتين</li>
    <li>تقرير العملاء يبقى أكبر من الحقيقة</li>
    <li>تواصل مزدوج يزعج العميل</li>
  </ul>
</div>
<div class="card">
  <div class="h"> خلاصة</div>
  <p>Uniqueness يسأل: <strong>هل تكررت القيمة بدون قصد؟</strong></p>
</div>
""", "T04_Validity.html", "T06_Consistency_Integrity.html")

files["T06_Consistency_Integrity.html"] = page(
"06 — الاتساق والسلامة",
"""
<div class="card">
  <div class="h"> الاتساق Consistency</div>
  <p>نفس المعلومة مكتوبة بأكثر من شكل:</p>
  <ul>
    <li>الرياض / Riyadh / RYD</li>
    <li>Active / active / ACTIVE</li>
  </ul>
  <div class="note">المعنى واحد… لكن الشكل مختلف فيربك التقارير.</div>
</div>
<div class="card">
  <div class="h"> السلامة Integrity</div>
  <p>العلاقة بين الجداول صحيحة.</p>
  <div class="bad">مثال: طلب sales لعميل رقم C999… لكن C999 غير موجود في جدول العملاء.</div>
  <p>هذا اسمه <strong>Orphan</strong> (سجل يتيم بدون أب).</p>
</div>
<div class="card">
  <div class="h"> خلاصة</div>
  <ol>
    <li>Consistency = توحيد الشكل</li>
    <li>Integrity = صحة الربط بين الجداول</li>
  </ol>
</div>
""", "T05_Uniqueness.html", "T07_Metric_Simple.html")

files["T07_Metric_Simple.html"] = page(
"07 — ما هو المقياس؟",
"""
<div class="card">
  <div class="h"> المعنى</div>
  <p>المقياس = رقم نقدر نتابعه.</p>
  <div class="ok">بدل ما نقول «في مشكلة»، نقول: «اكتمال الجوال = 84%».</div>
</div>
<div class="card">
  <div class="h"> قانون بسيط جدًا</div>
  <div class="code">النسبة = (العدد الصحيح ÷ الإجمالي) × 100</div>
  <p>مثال:</p>
  <ul>
    <li>إجمالي العملاء = 100</li>
    <li>عندهم جوال = 90</li>
    <li>النسبة = 90%</li>
  </ul>
</div>
<div class="card">
  <div class="h"> الهدف Target</div>
  <p>رقم نريد الوصول إليه، مثل: اكتمال الجوال ≥ 98%.</p>
  <ul>
    <li>أخضر: وصلنا الهدف</li>
    <li>أصفر: قريبين</li>
    <li>أحمر: بعيدين</li>
  </ul>
</div>
""", "T06_Consistency_Integrity.html", "T08_What_is_Table.html")

files["T08_What_is_Table.html"] = page(
"08 — ما هو الجدول في SQL؟",
"""
<div class="card">
  <div class="h"> تخيل Excel</div>
  <p>الجدول في SQL يشبه شيت Excel:</p>
  <ul>
    <li>الصف = سجل (عميل واحد)</li>
    <li>العمود = حقل (الاسم، الجوال، المدينة...)</li>
  </ul>
</div>
<div class="card">
  <div class="h"> جداول سنستخدمها اليوم</div>
  <ul>
    <li><code>customers</code> = العملاء</li>
    <li><code>orders</code> = الطلبات</li>
  </ul>
  <div class="note">قاعدة التدريب اسمها: <code>Abad_DataQuality_Lab</code></div>
</div>
<div class="card">
  <div class="h"> خلاصة</div>
  <p>SQL تسأل الجدول أسئلة، والجدول يرد بصفوف.</p>
</div>
""", "T07_Metric_Simple.html", "T09_SELECT_Step_by_Step.html")

files["T09_SELECT_Step_by_Step.html"] = page(
"09 — SELECT خطوة بخطوة",
"""
<div class="card">
  <div class="h"> الجملة الأساسية</div>
  <div class="code">SELECT الأعمدة
FROM اسم_الجدول;</div>
</div>
<div class="card">
  <div class="h"> مثال 1 (انسخه كما هو)</div>
  <div class="code">USE Abad_DataQuality_Lab;
SELECT TOP 5 * FROM dbo.customers;</div>
  <div class="ok">المعنى: أعطني أول 5 عملاء بكل الأعمدة.</div>
</div>
<div class="card">
  <div class="h"> مثال 2</div>
  <div class="code">SELECT customer_id, full_name, phone
FROM dbo.customers;</div>
  <div class="ok">المعنى: أريد فقط رقم العميل والاسم والجوال.</div>
</div>
<div class="card">
  <div class="h"> نصيحة</div>
  <div class="note">ابدأ دائمًا بـ USE ثم SELECT بسيط قبل أي حساب معقد.</div>
</div>
""", "T08_What_is_Table.html", "T10_WHERE_Simple.html")

files["T10_WHERE_Simple.html"] = page(
"10 — WHERE ببساطة",
"""
<div class="card">
  <div class="h"> المعنى</div>
  <p>WHERE = فلتر. تقول للقاعدة: أظهر فقط الصفوف التي تحقق الشرط.</p>
</div>
<div class="card">
  <div class="h"> مثال</div>
  <div class="code">SELECT customer_id, full_name, email
FROM dbo.customers
WHERE email IS NULL;</div>
  <div class="ok">المعنى: أعطني العملاء اللي إيميلهم فاضي.</div>
</div>
<div class="card">
  <div class="h"> أمثلة شروط شائعة</div>
  <ul>
    <li><code>IS NULL</code> = فاضي</li>
    <li><code>IS NOT NULL</code> = مش فاضي</li>
    <li><code>= 'Active'</code> = يساوي قيمة معينة</li>
  </ul>
</div>
""", "T09_SELECT_Step_by_Step.html", "T11_COUNT_Simple.html")

files["T11_COUNT_Simple.html"] = page(
"11 — COUNT وعدّ الصفوف",
"""
<div class="card">
  <div class="h"> المعنى</div>
  <p>COUNT(*) يعد كم صف رجع.</p>
</div>
<div class="card">
  <div class="h"> مثال 1</div>
  <div class="code">SELECT COUNT(*) AS total_customers
FROM dbo.customers;</div>
  <div class="ok">كم عدد العملاء؟</div>
</div>
<div class="card">
  <div class="h"> مثال 2</div>
  <div class="code">SELECT COUNT(*) AS missing_email
FROM dbo.customers
WHERE email IS NULL OR LTRIM(RTRIM(email)) = '';</div>
  <div class="ok">كم عميل إيميله ناقص؟</div>
</div>
<div class="card">
  <div class="h"> خلاصة</div>
  <p>COUNT مهم لأنه أساس حساب النسبة المئوية.</p>
</div>
""", "T10_WHERE_Simple.html", "T12_Find_Missing.html")

files["T12_Find_Missing.html"] = page(
"12 — كيف نجد القيم الناقصة؟",
"""
<div class="card">
  <div class="h"> الهدف</div>
  <p>نجد الصفوف الناقصة، ثم نحسب نسبتها.</p>
</div>
<div class="card">
  <div class="h"> خطوة 1: شاهد الناقص</div>
  <div class="code">SELECT customer_id, full_name, phone
FROM dbo.customers
WHERE phone IS NULL OR LTRIM(RTRIM(phone)) = '';</div>
</div>
<div class="card">
  <div class="h"> خطوة 2: احسب النسبة (نسخة سهلة)</div>
  <div class="code">SELECT
  COUNT(*) AS total_rows,
  SUM(CASE WHEN phone IS NULL OR LTRIM(RTRIM(phone)) = '' THEN 1 ELSE 0 END) AS missing_phone
FROM dbo.customers;</div>
  <div class="note">
    اقرأ الناتج هكذا:<br>
    total_rows = الكل<br>
    missing_phone = الناقص<br>
    الاكتمال ≈ (الكل - الناقص) ÷ الكل × 100
  </div>
</div>
""", "T11_COUNT_Simple.html", "T13_Find_Duplicates.html")

files["T13_Find_Duplicates.html"] = page(
"13 — كيف نجد التكرار؟",
"""
<div class="card">
  <div class="h"> الفكرة</div>
  <p>نجمع القيم المتشابهة، ونشوف أي قيمة ظهرت أكثر من مرة.</p>
</div>
<div class="card">
  <div class="h"> مثال جاهز (انسخه)</div>
  <div class="code">SELECT email, COUNT(*) AS cnt
FROM dbo.customers
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;</div>
  <div class="ok">أي إيميل cnt أكبر من 1 = مكرر.</div>
</div>
<div class="card">
  <div class="h"> شرح سطر بسطر</div>
  <ol>
    <li>GROUP BY email = اجمع نفس الإيميل مع بعض</li>
    <li>COUNT(*) = كم مرة تكرر</li>
    <li>HAVING COUNT(*) > 1 = أظهر المكرر فقط</li>
  </ol>
</div>
""", "T12_Find_Missing.html", "T14_Read_Results.html")

files["T14_Read_Results.html"] = page(
"14 — كيف نقرأ نتيجة الاستعلام؟",
"""
<div class="card">
  <div class="h"> لا تخف من الجداول</div>
  <p>النتيجة عادة صفوف وأعمدة. اقرأ اسم العمود أولًا ثم الرقم.</p>
</div>
<div class="card">
  <div class="h"> مثال</div>
  <table class="table table-bordered">
    <tr><th>total_rows</th><th>missing_phone</th></tr>
    <tr><td>23</td><td>1</td></tr>
  </table>
  <div class="ok">التفسير: من 23 عميل، واحد بدون جوال.</div>
</div>
<div class="card">
  <div class="h"> ماذا تفعل بعد النتيجة؟</div>
  <ol>
    <li>اكتب الرقم في ورقة بسيطة</li>
    <li>حوّله لنسبة إن لزم</li>
    <li>قرر: هل مقبول أم يحتاج تحسين؟</li>
  </ol>
  <div class="note">الآن أنت جاهز للتاسكات السهلة.</div>
</div>
""", "T13_Find_Duplicates.html", None)

for name, html in files.items():
    (OUT / name).write_text(html, encoding="utf-8")
    print("wrote", name)
print("done", len(files))
