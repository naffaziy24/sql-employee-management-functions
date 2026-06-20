# sql-employee-management-functions
Implementasi SQL Function dan Stored Procedure untuk mendukung proses administrasi pegawai dan pengelolaan operasional berbasis basis data.

# Manipulasi Logika Basis Data Menggunakan PostgreSQL Function

## 🎯 Objectives

* Mengotomatiskan perhitungan jumlah pegawai berdasarkan kriteria rentang gaji dan rentang usia tertentu.
* Membangun pelacak logis untuk menghitung total akumulasi jam kerja proyek, jumlah anggota keluarga (*dependent*), serta performa manajerial.
* Mengoptimalkan otomatisasi penambahan (*insert*), pembaruan (*update*), dan penghapusan (*delete*) rekor data relasional secara prosedural.
* Menyusun kueri tingkat lanjut menggunakan *inner join* bersarang untuk menampilkan hasil pencarian data bertipe tabel.

## 📊 Key Features Analyzed

* **Manajemen & Analisis Karyawan:**
  * Perhitungan total pegawai dengan ambang batas gaji tertentu (`hitung_gaji_pegawai`).
  * Perhitungan kuantitas personil berdasarkan klasifikasi umur (`jumlah_pegawai_dalam_rentang_usia`).
  * Sinkronisasi data anggota keluarga karyawan secara spesifik (`jumlah_anggota_keluarga`).
  * Prosedur pengisian/injeksi rekor data karyawan baru (`tambah_data_pegawai`).
* **Metrik Operasional & Departemen:**
  * Kalkulasi kumulatif jam kerja karyawan pada suatu proyek (`total_jam_project`).
  * Pelacakan performa manajer dalam menangani proyek (`jmlh_proyek_mgr`).
  * Perhitungan volume proyek (`jumlah_Project`) dan kuantitas pegawai (`jmlh_pegawai_pddpart`) per departemen.
  * Pembersihan rekor lokasi departemen berdasarkan kriteria spesifik (`delete_lokasi`).
* **Kalkulasi Finansial & Penggajian:**
  * Perhitungan rata-rata pendapatan pegawai pada departemen tertentu (`rata_gaji_pegawai`).
  * Pembaruan gaji otomatis bersyarat berdasarkan jender (Pria naik 20%, Wanita naik 15%) (`update_gaji_gender`).
  * Penyesuaian upah manajer bersyarat berdasarkan durasi masa jabatan menggunakan fungsi ekstensi `AGE` dan `EXTRACT` (`update_salary_manager111`).
* **Ekstraksi Data Tingkat Lanjut:**
  * Pembuatan fungsi bertipe tabel untuk memfilter data pegawai yang terlibat dalam jumlah proyek tertentu (`datapegawai_project`).
  * Penanganan nilai kosong menggunakan `COALESCE` untuk menghitung rata-rata jam kerja keterlibatan proyek (`rata_rata_jam_kerja_pegawai`).

## 🔍 Key Insights

* **Eksekusi Sisi Server (*Server-Side Execution*):** Pemrosesan aturan logika seperti penyesuaian gaji jender dan perhitungan masa jabatan langsung di dalam database terbukti menghemat penggunaan memori dan memangkas waktu bolak-balik data (*network round-trip*).
* **Integritas Data Transaksional:** Penggunaan fungsi kustom memastikan manipulasi data—seperti sinkronisasi tabel `DEPENDENT` atau penghapusan di `DEPT_LOCATIONS`—berjalan secara atomik dan patuh terhadap batasan relasional.
* **Fleksibilitas Analitik Temporal:** Pemanfaatan fungsi bawaan PostgreSQL seperti `AGE(NOW(), ...)` dan `DATE_PART` mempermudah kalkulasi data berbasis waktu, seperti pelacakan demografi usia karyawan dan masa bakti manajer secara *real-time*.

## 🛠️ Tools Used

* **Dialek SQL:** PostgreSQL Prosedural (`PL/pgSQL`) dan Standard SQL
* **Aplikasi Manajemen:** pgAdmin / DBeaver Database Client Tool
* **Skema Target:** Basis Data Perusahaan Relasional (*Employee, Department, Project, Works_On, Dependent, Dept_Locations*)
