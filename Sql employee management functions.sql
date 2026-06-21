-- 1. Fungsi untuk menghitung total pegawai yang memiliki gaji dalam rentang tertentu
CREATE OR REPLACE FUNCTION hitung_gaji_pegawai (Salary INT) 
RETURNS INT AS $$ 
DECLARE 
    total INT; 
BEGIN  
    SELECT count(*) INTO total 
    FROM "EMPLOYEE" 
    WHERE "EMPLOYEE"."Salary" > Salary; 
    
    RETURN total; 
END;  
$$ LANGUAGE PLPGSQL; 

-- Contoh Pemanggilan:
SELECT hitung_gaji_pegawai(25000) AS total_employee;


-- 2. Fungsi untuk menghitung total jam pegawai dalam project tertentu
CREATE OR REPLACE FUNCTION total_jam_project(Pno INT) 
RETURNS INT AS $total_hours$ 
DECLARE 
    total_hours INT; 
BEGIN 
    -- Menghitung jumlah jam yang dimiliki oleh suatu proyek 
    SELECT SUM("Hour") INTO total_hours 
    FROM "WORKS_ON" 
    WHERE "WORKS_ON"."Pno" = Pno; 
    
    -- Mengembalikan hasil 
    RETURN total_hours; 
END; 
$total_hours$ 
LANGUAGE PLPGSQL; 

-- Contoh Pemanggilan:
SELECT total_jam_project(3) AS total_jam;


-- 3. Fungsi untuk menghitung jumlah anggota keluarga dari pegawai tertentu
CREATE OR REPLACE FUNCTION jumlah_anggota_keluarga(Essn VARCHAR) 
RETURNS INT AS $$ 
DECLARE 
    total_dep INT; 
BEGIN 
    -- Menghitung jumlah anggota keluarga oleh suatu karyawan 
    SELECT COUNT(*) INTO total_dep 
    FROM "DEPENDENT" 
    WHERE "DEPENDENT"."Essn" = Essn; 
    
    -- Mengembalikan hasil 
    RETURN total_dep; 
END; 
$$ LANGUAGE PLPGSQL; 

-- Contoh Pemanggilan:
SELECT jumlah_anggota_keluarga('333445555') AS total_anggotakeluarga_karyawan;


-- 4. Fungsi untuk menghitung berapa jumlah proyek yang dihandle oleh department tertentu
CREATE OR REPLACE FUNCTION jumlah_Project(Dnum INT) 
RETURNS INT AS $$ 
DECLARE 
    total_project INT; 
BEGIN 
    -- Menghitung jumlah project pada suatu department 
    SELECT COUNT(*) INTO total_project 
    FROM "PROJECT" 
    WHERE "PROJECT"."Dnum" = Dnum; 
    
    -- Mengembalikan hasil 
    RETURN total_project; 
END; 
$$ LANGUAGE PLPGSQL; 

-- Contoh Pemanggilan:
SELECT jumlah_project('5') AS total_project_yangdikerjakan;


-- 5. Fungsi untuk menghitung berapa jumlah pegawai yang berada pada rentang usia tertentu
CREATE OR REPLACE FUNCTION jumlah_pegawai_dalam_rentang_usia(min_age INT, max_age INT) 
RETURNS INT AS $$ 
DECLARE 
    total_pegawai INT; 
BEGIN 
    -- Menghitung jumlah pegawai dalam rentang usia tertentu 
    SELECT COUNT(*) INTO total_pegawai 
    FROM "EMPLOYEE" 
    WHERE DATE_PART('year', AGE(NOW(), "EMPLOYEE"."Bdate")) BETWEEN min_age AND max_age; 
    
    -- Mengembalikan hasil 
    RETURN total_pegawai; 
END; 
$$ LANGUAGE PLPGSQL; 

-- Contoh Pemanggilan:
SELECT jumlah_pegawai_dalam_rentang_usia(50,70);


-- 6. Fungsi untuk menghitung berapa jumlah pegawai yang berada pada department tertentu
CREATE OR REPLACE FUNCTION jmlh_pegawai_pddpart (Dno integer) 
RETURNS integer AS $jmlpegawai$ 
DECLARE 
    jmlpegawai integer; 
BEGIN 
    SELECT COUNT(*) INTO jmlpegawai 
    FROM "EMPLOYEE" 
    WHERE "EMPLOYEE"."Dno" = Dno; 
    
    RETURN jmlpegawai; 
END; 
$jmlpegawai$ 
LANGUAGE PLPGSQL; 

-- Contoh Pemanggilan:
SELECT jmlh_pegawai_pddpart(1) AS Jumlah_Pegawai;


-- 7. Fungsi untuk menghitung rata-rata gaji pegawai pada department tertentu
CREATE OR REPLACE FUNCTION rata_gaji_pegawai (Dno integer) 
RETURNS integer AS $ratagaji$ 
DECLARE 
    ratagaji integer; 
BEGIN 
    SELECT AVG("EMPLOYEE"."Salary") INTO ratagaji 
    FROM "EMPLOYEE" 
    WHERE "EMPLOYEE"."Dno" = Dno; 
    
    RETURN ratagaji; 
END; 
$ratagaji$ 
LANGUAGE PLPGSQL; 

-- Contoh Pemanggilan:
SELECT rata_gaji_pegawai(1) AS Rata_Gaji;


-- 8. Fungsi untuk menghitung jumlah proyek yang dihandle oleh manager tertentu
CREATE OR REPLACE FUNCTION jmlh_proyek_mgr (Mgrssn CHAR) 
RETURNS INTEGER AS $$ 
DECLARE 
    Jumlah_Project INTEGER; 
BEGIN 
    SELECT COUNT(*) INTO Jumlah_Project 
    FROM "DEPARTEMENT" AS "D" 
    JOIN "PROJECT" AS "P" ON "D"."Dnumber" = "P"."Dnum" 
    LEFT JOIN "WORKS_ON" AS "W" ON "P"."Pnumber" = "W"."Pno" 
    WHERE "D"."Mgr_ssn" = Mgrssn; 
    
    RETURN Jumlah_Project; 
END; 
$$ LANGUAGE plpgsql; 

-- Contoh Pemanggilan:
SELECT jmlh_proyek_mgr ('333445555') AS jumlah_proyek;


-- 9. Fungsi untuk memasukkan data pegawai baru 
CREATE OR REPLACE FUNCTION tambah_data_pegawai ( 
    Fname VARCHAR,  
    Mnit CHAR,  
    Lname VARCHAR,  
    Ssn CHAR,  
    Bdate DATE,  
    Address VARCHAR,  
    Sex CHAR,  
    Salary INT,  
    Super_ssn CHAR,  
    Dno INT 
) 
RETURNS VOID AS $$ 
BEGIN  
    INSERT INTO "EMPLOYEE"("Fname", "Mnit", "Lname", "Ssn", "Bdate", "Address", "Sex", "Salary", "Super_ssn", "Dno") 
    VALUES (Fname, Mnit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno); 
END; 
$$ LANGUAGE PLPGSQL; 

-- Contoh Pemanggilan & Pembuktian:
SELECT tambah_data_pegawai('Nathan', 'X', 'Xavier', '122456785', '1994-01-01', '128 Main, Rindu, TX', 'M', 50000, '987654321', 1); 
SELECT * FROM "EMPLOYEE";


-- 10. Fungsi untuk update data dependent dari pegawai tertentu
CREATE OR REPLACE FUNCTION update_data_dependent(Essn CHAR, Dependent_name VARCHAR, Relationship_new VARCHAR) 
RETURNS SETOF VOID 
AS $$ 
BEGIN  
    UPDATE "DEPENDENT" 
    SET "Relationship" = Relationship_new 
    WHERE "Essn" = Essn AND "Dependent_name" = Dependent_name; 
END; 
$$ LANGUAGE PLPGSQL; 

-- Contoh Pemanggilan & Pembuktian:
SELECT update_data_dependent('123456789','Alice','Daughter'); 
SELECT * FROM "DEPENDENT";


-- 11. Fungsi untuk delete lokasi department dengan kriteria tertentu
CREATE OR REPLACE FUNCTION delete_lokasi (Dloc text) 
RETURNS SETOF record 
AS $$ 
BEGIN 
    DELETE FROM "DEPT_LOCATIONS" WHERE "Dlocation" = Dloc; 
END; 
$$ LANGUAGE PLPGSQL; 

-- Contoh Pemanggilan & Pembuktian:
SELECT delete_lokasi ('Houston'); 
SELECT * FROM "DEPT_LOCATIONS";


-- 12. Fungsi untuk menampilkan data pegawai yang telah terlibat project dalam jumlah tertentu
CREATE OR REPLACE FUNCTION datapegawai_project (Pno integer) 
RETURNS TABLE (
    Fname character varying, 
    Mnit character, 
    Lname character varying, 
    Ssn character, 
    Bdate date,  
    Address character varying, 
    Sex character, 
    Salary integer, 
    Super_ssn character, 
    Dno integer
) AS $$ 
    SELECT "EMPLOYEE"."Fname", "EMPLOYEE"."Mnit", "EMPLOYEE"."Lname", 
           "EMPLOYEE"."Ssn", "EMPLOYEE"."Bdate", "EMPLOYEE"."Address", 
           "EMPLOYEE"."Sex", "EMPLOYEE"."Salary", "EMPLOYEE"."Super_ssn", "EMPLOYEE"."Dno" 
    FROM "EMPLOYEE" 
    INNER JOIN ( 
        SELECT "WORKS_ON"."Essn", COUNT(*) AS totalproj 
        FROM "WORKS_ON" 
        GROUP BY "Essn" 
    ) AS total ON "EMPLOYEE"."Ssn" = total."Essn" 
    WHERE total.totalproj = Pno; 
$$ LANGUAGE SQL; 

-- Contoh Pemanggilan:
SELECT datapegawai_project(1);


-- 13. Fungsi untuk menghitung rata-rata jam kerja terlibat di proyek dari pegawai tertentu
CREATE OR REPLACE FUNCTION rata_rata_jam_kerja_pegawai(Ssn CHAR) 
RETURNS NUMERIC 
AS $$ 
DECLARE 
    jmlh_jam INT; 
    jumlah_proyek INT; 
    rata_rata INT; 
BEGIN 
    SELECT COALESCE(SUM("Hour"), 0) INTO jmlh_jam 
    FROM "WORKS_ON" 
    WHERE "Essn" = Ssn;  
    
    SELECT COUNT(*) INTO jumlah_proyek 
    FROM "WORKS_ON" 
    WHERE "Essn" = Ssn; 
    
    -- Menghitung rata-rata jam kerja 
    IF jumlah_proyek > 0 THEN 
        rata_rata := jmlh_jam / jumlah_proyek; 
    ELSE 
        rata_rata := 0; 
    END IF;  
    
    RETURN rata_rata; 
END; 
$$ LANGUAGE PLPGSQL; 

-- Contoh Pemanggilan:
SELECT rata_rata_jam_kerja_pegawai('333445555') AS Rata_Rata_Jam_Kerja_Pegawai;


-- 14. Fungsi untuk mengupdate salary dari pegawai (MALE naik 20%, FEMALE naik 15%)
CREATE OR REPLACE FUNCTION update_gaji_gender(Essn char) 
RETURNS VOID AS $$ 
DECLARE  
    gender CHAR; 
    current_gaji NUMERIC; 
    updated_gaji NUMERIC; 
BEGIN  
    SELECT "EMPLOYEE"."Sex" INTO gender FROM "EMPLOYEE" WHERE "Ssn" = Essn; 
    SELECT "Salary" INTO current_gaji FROM "EMPLOYEE" WHERE "Ssn" = Essn; 
    
    IF gender = 'M' THEN 
        updated_gaji := current_gaji * 1.2;  
    ELSIF gender = 'F' THEN 
        updated_gaji := current_gaji * 1.15;  
    ELSE 
        updated_gaji := current_gaji; -- Jika bukan F atau M
    END IF; 
    
    UPDATE "EMPLOYEE" SET "Salary" = updated_gaji WHERE "Ssn" = Essn; 
END; 
$$ LANGUAGE PLPGSQL; 

-- Contoh Pemanggilan & Pembuktian:
SELECT update_gaji_gender('999887777'); 
SELECT * FROM "EMPLOYEE";


-- 15. Fungsi untuk update data salary manager berdasarkan masa jabatan (>10 tahun naik 30%, <10 tahun naik 10%)
CREATE OR REPLACE FUNCTION update_salary_manager111(manager_ssn VARCHAR) 
RETURNS VARCHAR 
AS $$ 
DECLARE 
    tenure_years INT; 
    current_salary NUMERIC; 
    new_salary NUMERIC; 
    updated_rows INT; 
BEGIN 
    -- Menghitung lamanya masa jabatan sebagai manajer 
    SELECT EXTRACT(YEAR FROM AGE(NOW(), "Mgr_start_date")) INTO tenure_years 
    FROM "DEPARTEMENT" 
    WHERE "Mgr_ssn" = manager_ssn;  
    
    -- Mendapatkan gaji saat ini manajer 
    SELECT "Salary" INTO current_salary 
    FROM "EMPLOYEE" 
    WHERE "Ssn" = manager_ssn; 
    
    GET DIAGNOSTICS updated_rows = ROW_COUNT; 
    
    -- Menghitung kenaikan gaji berdasarkan lamanya masa jabatan 
    IF tenure_years > 10 THEN 
        new_salary := current_salary * 1.30; -- Kenaikan 30% untuk lebih dari 10 tahun 
    ELSE 
        new_salary := current_salary * 1.10; -- Kenaikan 10% untuk kurang dari atau sama dengan 10 tahun 
    END IF; 
    
    -- Memperbarui gaji manajer 
    UPDATE "EMPLOYEE" 
    SET "Salary" = new_salary 
    WHERE "Ssn" = manager_ssn; 
    
    IF FOUND THEN 
        RETURN 'GAJI BERHASIL DIPERBARUI'; 
    ELSE 
        RETURN 'GAJI GAGAL DIPERBARUI'; 
    END IF; 
END; 
$$ LANGUAGE PLPGSQL; 

-- Contoh Pemanggilan & Pembuktian:
SELECT update_salary_manager111('987654321'); 
SELECT * FROM "EMPLOYEE";






