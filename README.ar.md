<div dir="rtl">

# Sanad — توزيعة ألعاب مبنية على Bazzite

Sanad تعديل على **Bazzite** (مشروع Universal Blue مفتوح المصدر): نظام لينكس غير قابل للتعديل العرضي (image-based) بواجهة KDE Plasma، مجهّز مسبقاً للألعاب (Steam وProton وGameMode وMangoHud وتعريفات الكروت). أضفنا فوقه هوية Sanad وخطوطاً ولوحة مفاتيح عربية ومنطقة بغداد الزمنية، وتثبيتاً تلقائياً لـ Heroic وProtonUp-Qt وBottles وDiscord وLibreOffice وVLC عند أول دخول.

الـ ISO يُبنى في سحابة GitHub مجاناً، فلا تحتاج جهازاً قوياً ولا Arch.

## الخطوات (مرة واحدة، نحو 15 دقيقة عملاً + وقت بناء)

1. **حساب GitHub:** أنشئ مستودعاً فارغاً باسم **`sanad`** (الاسم مهم).
2. **ضبط المالك:** على جهازك داخل هذا المجلد:
   ```bash
   ./setup.sh <اسم-مستخدم-GitHub>
   ```
3. **الرفع:**
   ```bash
   git init && git add -A && git commit -m "Sanad"
   git branch -M main
   git remote add origin https://github.com/<اسم-مستخدم-GitHub>/sanad.git
   git push -u origin main
   ```
4. **بناء الصورة:** من تبويب Actions يبدأ `Build container image` تلقائياً بعد الرفع. انتظر اكتماله (نحو 30–60 دقيقة).
5. **اجعل الحزمة عامة:** GitHub › صفحتك › Packages › `sanad` › Package settings › Change visibility › Public (مطلوب لتحديث النظام لاحقاً).
6. **بناء ISO:** Actions › `Build disk images` › Run workflow › platform = `amd64`.
7. **التنزيل:** بعد اكتماله ينزل ملف الـ ISO من قسم Artifacts في صفحة التشغيل (يُحفظ 7 أيام).

## التشغيل على VMware
| الإعداد | القيمة |
|---|---|
| النظام | Other Linux 6.x 64-bit (Fedora 64-bit) |
| البرنامج الثابت | UEFI |
| الذاكرة | 8 غيغابايت أو أكثر |
| القرص | 160 غيغابايت أو أكثر |
| الشاشة | Accelerate 3D مفعّل |

المثبّت Anaconda: اختر القرص، أنشئ المستخدم، ثم أعد التشغيل. **المثبّت يحتاج إنترنت** لأنه يضبط التحديثات من مستودعك على ghcr.io.

## عند أول دخول
يعمل سكربت في الخلفية: يضع خلفية Sanad، ويثبّت التطبيقات (يحتاج إنترنت، ويعيد المحاولة تلقائياً في الدخول التالي إن فشل). تبديل لغة الإدخال: `Alt + Shift`.

## تشغيل GTA V
Steam › تثبيت اللعبة › Compatibility › Proton-GE (من ProtonUp-Qt) › خيارات التشغيل: `gamemoderun mangohud %command%`. التفاصيل في ملف `GTA-V-README.txt` على سطح المكتب.

## خيارات التعديل
- **كروت NVIDIA:** في `Containerfile` غيّر القاعدة إلى `ghcr.io/ublue-os/bazzite-nvidia:stable`.
- **GNOME بدل KDE:** القاعدة `bazzite-gnome:stable`.
- **حزم إضافية:** عدّل `build_files/build.sh` (حزم RPM) أو قائمة Flatpak في `system_files/usr/libexec/sanad-first-login`.
- **ملفات تُنسخ للنظام:** ضعها في `system_files/` بنفس مسارها الهدف.

## قيود يجب الانتباه لها
- **لم أبنِ الصورة هنا** (بيئتي لا تصل إلى ghcr.io)، والتركيب مبني على قالب Universal Blue الرسمي. أول بناء قد يحتاج تعديلاً بسيطاً حسب رسائل Actions؛ أرسل لي السجل وأصلحه.
- **حجم الـ ISO** عدة غيغابايت. إن رفض GitHub رفع الـ Artifact بسبب الحجم، استخدم خيار `upload-to-s3` في workflow (يحتاج حساب S3).
- **GPU:** داخل VM بدون تمرير كرت حقيقي لن تكون GTA V قابلة للعب. على جهاز فعلي تعمل بشكل ممتاز.
- **GTA Online** غير مدعومة على لينكس (BattlEye). اللعبة نفسها غير مضمّنة (مدفوعة).
- أسماء حزم الخطوط في Fedora قد تتغير؛ السكربت يتخطى أي حزمة غير موجودة ولا يفشل.
- التوقيع بـ cosign اختياري (غير مفعّل افتراضياً). لتفعيله أضف السر `SIGNING_SECRET` في إعدادات المستودع.

## الترخيص والنسب
مبني على Bazzite وUniversal Blue (Apache-2.0) ويحتفظ بترخيص القالب. راجع ملف `NOTICE`.

</div>
