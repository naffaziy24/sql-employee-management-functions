# sql-employee-management-functions
Implementasi SQL Function dan Stored Procedure untuk mendukung proses administrasi pegawai dan pengelolaan operasional berbasis basis data.

# Manipulasi Logika Basis Data Menggunakan PostgreSQL Function

## 📌 Project Overview

Proyek ini menyajikan implementasi **manipulasi data dan logika prosedural berbasis SQL** menggunakan fungsi kustom (`PL/pgSQL` dan `SQL`) di PostgreSQL[cite: 1]. Berdasarkan skema basis data relasional perusahaan (*company database*), proyek ini berfokus pada enkapsulasi aturan bisnis ke dalam lapisan basis data[cite: 1]. Melalui pembuatan 15 fungsi kustom, proyek ini menyelesaikan berbagai kebutuhan data mulai dari kalkulasi agregat, pembaruan bersyarat (*conditional updates*), otomatisasi manipulasi rekor tabel, hingga pengembalian data bertipe tabel (*table-valued returns*)[cite: 1].

## 🎯 Objectives

* Mengotomatiskan perhitungan jumlah pegawai berdasarkan kriteria rentang gaji dan rentang usia tertentu[cite: 1].
* Membangun pelacak logis untuk menghitung total akumulasi jam kerja proyek, jumlah anggota keluarga (*dependent*), serta performa manajerial[cite: 1].
* Mengoptimalkan otomatisasi penambahan (*insert*), pembaruan (*update*), dan penghapusan (*delete*) rekor data relasional secara prosedural[cite: 1].
* Menyusun kueri tingkat lanjut menggunakan *inner join* bersenang untuk menampilkan hasil pencarian data bertipe tabel[cite: 1].

## 📊 Key Features Analyzed

* **Manajemen & Analisis Karyawan:**
  * Perhitungan total pegawai dengan ambang batas gaji tertentu (`hitung_gaji_pegawai`)[cite: 1].
  * Perhitungan kuantitas personil berdasarkan klasifikasi umur (`jumlah_pegawai_dalam_rentang_usia`)[cite: 1].
  * Sinkronisasi data anggota keluarga karyawan secara spesifik (`jumlah_anggota_keluarga`)[cite: 1].
  * Prosedur pengisian/injeksi rekor data karyawan baru (`tambah_data_pegawai`)[cite: 1].
* **Metrik Operasional & Departemen:**
  * Kalkulasi kumulatif jam kerja karyawan pada suatu proyek (`total_jam_project`)[cite: 1].
  * Pelacakan performa manajer dalam menangani proyek (`jmlh_proyek_mgr`)[cite: 1].
  * Perhitungan volume proyek (`jumlah_Project`) dan kuantitas pegawai (`jmlh_pegawai_pddpart`) per departemen[cite: 1].
  * Pembersihan rekor lokasi departemen berdasarkan kriteria spesifik (`delete_lokasi`)[cite: 1].
* **Kalkulasi Finansial & Penggajian:**
  * Perhitungan rata-rata pendapatan pegawai pada departemen tertentu (`rata_gaji_pegawai`)[cite: 1].
  * Pembaruan gaji otomatis bersyarat berdasarkan jender (Pria naik 20%, Wanita naik 15%) (`update_gaji_gender`)[cite: 1].
  * Penyesuaian upah manajer bersyarat berdasarkan durasi masa jabatan menggunakan fungsi ekstensi `AGE` dan `EXTRACT` (`update_salary_manager111`)[cite: 1].
* **Ekstraksi Data Tingkat Lanjut:**
  * Pembuatan fungsi bertipe tabel untuk memfilter data pegawai yang terlibat dalam jumlah proyek tertentu (`datapegawai_project`)[cite: 1].
  * Penanganan nilai kosong menggunakan `COALESCE` untuk menghitung rata-rata jam kerja keterlibatan proyek (`rata_rata_jam_kerja_pegawai`)[cite: 1].

## 🔍 Key Insights

* **Eksekusi Sisi Server (*Server-Side Execution*):** Pemrosesan aturan logika seperti penyesuaian gaji jender dan perhitungan masa jabatan langsung di dalam database terbukti menghemat penggunaan memori dan memangkas waktu bolak-balik data (*network round-trip*)[cite: 1].
* **Integritas Data Transaksional:** Penggunaan fungsi kustom memastikan manipulasi data—seperti sinkronisasi tabel `DEPENDENT` atau penghapusan di `DEPT_LOCATIONS`—berjalan secara atomik dan patuh terhadap batasan relasional[cite: 1].
* **Fleksibilitas Analitik Temporal:** Pemanfaatan fungsi bawaan PostgreSQL seperti `AGE(NOW(), ...)` dan `DATE_PART` mempermudah kalkulasi data berbasis waktu, seperti pelacakan demografi usia karyawan dan masa bakti manajer secara *real-time*[cite: 1].

## 🛠️ Tools Used

* **Dialek SQL:** PostgreSQL Prosedural (`PL/pgSQL`) dan Standard SQL[cite: 1]
* **Aplikasi Manajemen:** pgAdmin / DBeaver Database Client Tool[cite: 1]
* **Skema Target:** Basis Data Perusahaan Relasional (*Employee, Department, Project, Works_On, Dependent, Dept_Locations*)[cite: 1]

## 📝 Notes

* Seluruh komponen logika bisnis, pengondisian `IF-THEN-ELSE`, dan kalkulasi matematis dalam repositori ini dieksekusi **murni di dalam lingkungan DBMS PostgreSQL**[cite: 1].
* Proyek ini tidak menggunakan bahasa pemrograman tingkat menengah (seperti Python, Java, atau PHP) untuk mengontrol data[cite: 1].
* Skema, data, dan parameter fungsi di dalam proyek ini ditujukan untuk **keperluan analisis profesional, pengujian performa kueri, dan edukasi**[cite: 1].
