STUDYOS CLOUD — LOGIN + REALTIME SYNC
====================================

PENTING
Web ini sudah disiapkan untuk sinkronisasi cloud lintas HP dan laptop memakai Supabase.
Sinkronisasi realtime AKAN AKTIF setelah Anda membuat project Supabase, menjalankan SQL,
mengisi config.js, dan meng-host seluruh folder ini lewat HTTPS. Tanpa konfigurasi tersebut,
tracker tetap berfungsi dalam mode lokal seperti versi sebelumnya.

A. BUAT DATABASE SUPABASE (gratis untuk mulai)
1. Buka https://supabase.com/dashboard lalu buat akun / masuk.
2. Create project. Simpan password database di tempat aman.
3. Tunggu sampai project selesai dibuat.
4. Buka SQL Editor > New query.
5. Buka file supabase/setup.sql, salin seluruh isinya ke SQL Editor, lalu tekan Run.
   Skrip membuat tabel studyos_data, aturan keamanan RLS per pengguna, dan publikasi realtime.

B. ISI CONFIG.JS
1. Di Supabase Dashboard, buka Project Settings > API (atau API Keys).
2. Salin Project URL.
3. Salin publishable key (sb_publishable_...) atau legacy anon/public key.
4. Buka config.js dengan text editor.
5. Ganti YOUR_PROJECT_ID dan YOUR_SUPABASE_PUBLISHABLE_OR_ANON_KEY.
6. Simpan.

CONTOH:
window.STUDYOS_CONFIG = {
  supabaseUrl: "https://abcdefgh.supabase.co",
  supabaseAnonKey: "sb_publishable_xxxxxxxxx"
};

JANGAN PERNAH memasukkan secret key atau service_role key ke config.js / browser.
Publishable/anon key memang boleh dipakai di browser karena tabel dilindungi RLS.

C. SIAPKAN AUTH URL
1. Supabase Dashboard > Authentication > URL Configuration.
2. Site URL: masukkan URL website StudyOS setelah di-host.
3. Tambahkan URL website yang sama ke Redirect URLs.
4. Email provider aktif secara default pada banyak project. Setelah daftar, periksa email
   verifikasi bila Supabase meminta verifikasi sebelum login.
5. Jangan menonaktifkan keamanan email tanpa alasan.

D. HOST WEB (HTTPS)
1. Upload seluruh isi folder ini, bukan hanya index.html, ke hosting statis HTTPS
   (misalnya Cloudflare Pages, GitHub Pages, atau Netlify).
2. Pastikan config.js, manifest.webmanifest, service-worker.js, folder assets, dan folder
   supabase ikut terunggah.
3. Buka URL website. Klik tombol "Hubungkan akun".
4. Buat akun menggunakan email dan password. Gunakan akun SAMA di HP dan laptop.
5. Setelah login, status di bagian atas akan berubah menjadi "Tersinkron · realtime aktif".

E. PINDAHKAN PROGRES LAMA
- Jika akun cloud belum memiliki data dan browser ini berisi progres StudyOS lama, progres lokal
  akan digunakan sebagai data awal dan dikirim ke cloud setelah login.
- Jika akun cloud sudah berisi progres dan perangkat ini juga punya progres lokal, StudyOS akan
  bertanya apakah data mau digabung. Data per tanggal yang lebih baru diprioritaskan.
- Jika memilih memakai cloud saja, data lokal tidak digabung.
- Setelah data masuk cloud, login dengan akun yang sama di perangkat lain. Progres yang sama
  akan dimuat di perangkat tersebut.

F. UJI SINKRONISASI
1. Login dengan akun yang sama di laptop dan HP.
2. Di laptop, buka Absen Harian, ubah catatan atau checklist, lalu simpan.
3. Pastikan HP yang sedang terbuka menerima perubahan dalam beberapa detik jika kedua perangkat
   online dan koneksi Realtime tersambung.
4. Coba juga sebaliknya dari HP ke laptop.

CARA KERJA & BATASAN
- Catatan lokal disimpan langsung di perangkat untuk mengurangi risiko kehilangan ketika offline.
- Saat online, perubahan dikirim otomatis ke Supabase. Perangkat lain yang login menerima
  perubahan lewat Realtime.
- Jika offline, data tetap di cache perangkat. Saat koneksi pulih atau tab dibuka kembali, StudyOS menarik data terbaru dari cloud, menggabungkannya dengan catatan lokal, lalu mengirim perubahan yang belum tersinkron.
- Gunakan akun yang sama di seluruh perangkat. Akun berbeda memiliki data terpisah.
- Sinkronisasi berarti near-real-time, bukan jaminan tanpa jeda; koneksi internet dan layanan
  backend tetap berpengaruh. Database diperiksa ulang saat koneksi pulih/tab aktif untuk membantu
  memulihkan pembaruan yang mungkin terlewat ketika WebSocket terputus.
- Data progres StudyOS tersinkron. Progres course pihak ketiga (mis. Microsoft Learn atau
  platform MOOC) tetap mengikuti akun dan sistem masing-masing platform.
- Ekspor JSON berkala sebagai backup mandiri.
- Supabase Free saat ini mempunyai batas penggunaan dan proyek gratis dapat dijeda setelah
  satu minggu tidak aktif. Jika itu terjadi, buka dashboard Supabase dan aktifkan kembali
  project sesuai opsi yang tersedia. Periksa halaman pricing terbaru sebelum penggunaan luas.

REFERENSI RESMI
Supabase install: https://supabase.com/docs/reference/javascript/installing
Supabase Realtime: https://supabase.com/docs/guides/realtime/postgres-changes
Supabase RLS: https://supabase.com/docs/guides/database/postgres/row-level-security
Supabase pricing: https://supabase.com/pricing
