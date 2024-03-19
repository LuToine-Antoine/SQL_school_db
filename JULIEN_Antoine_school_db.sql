CREATE TABLE PROMOTIONS(
    id_promotion NUMBER PRIMARY KEY,
    promotion_name VARCHAR2(50) UNIQUE NOT NULL,
    promotion_year NUMBER NOT NULL
);

CREATE TABLE TEACHERS(
    id_teacher NUMBER PRIMARY KEY,
    teacher_mail VARCHAR2(50) UNIQUE NOT NULL,
    teacher_first_name VARCHAR2(50) NOT NULL,
    teacher_last_name VARCHAR2(50) NOT NULL,
    teacher_enter_date DATE NOT NULL
);

CREATE TABLE SUBJECTS(
    id_subject NUMBER PRIMARY KEY,
    subject_name VARCHAR2(50) UNIQUE NOT NULL,
    id_teacher NUMBER NOT NULL,
    CONSTRAINT id_teacher_fk FOREIGN KEY (id_teacher) REFERENCES TEACHERS(id_teacher)
);

CREATE TABLE STUDENTS(
    id_student NUMBER PRIMARY KEY,
    student_email VARCHAR2(50) UNIQUE,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    id_promotion NUMBER NOT NULL,
    old_promotion NUMBER,
    CONSTRAINT id_promotion_fk FOREIGN KEY (id_promotion) REFERENCES PROMOTIONS(id_promotion),
    CONSTRAINT old_promotion_fk FOREIGN KEY (old_promotion) REFERENCES PROMOTIONS(id_promotion)
);

CREATE TABLE ABSENCES(
    id_absence NUMBER PRIMARY KEY,
    type_abs VARCHAR2(50) NOT NULL,
    date_abs DATE NOT NULL,
    justify VARCHAR(10) NOT NULL,
    duration_abs NUMBER NOT NULL,
    id_student_abs NUMBER NOT NULL,
    CONSTRAINT id_student_fk FOREIGN KEY (id_student_abs) REFERENCES STUDENTS(id_student)
);

CREATE TABLE NOTES(
    id_notes NUMBER PRIMARY KEY,
    note NUMBER NOT NULL,
    id_student_notes NUMBER NOT NULL,
    id_teacher_notes NUMBER NOT NULL,
    publication_date DATE NOT NULL,
    id_subject_notes NUMBER NOT NULL,
    CONSTRAINT id_student_notes_fk FOREIGN KEY (id_student_notes) REFERENCES STUDENTS(id_student),
    CONSTRAINT id_teacher_notes_fk FOREIGN KEY (id_teacher_notes) REFERENCES TEACHERS(id_teacher),
    CONSTRAINT id_subject_notes_fk FOREIGN KEY (id_subject_notes) REFERENCES SUBJECTS(id_subject)
);

INSERT INTO PROMOTIONS(id_promotion, promotion_name, promotion_year)
VALUES
(1, 'Les trucs', 2022),
(2, 'Les cookies', 2023),
(3, 'Dune fans', 2023),
(4, 'Ghibli fans', 2024);

INSERT INTO STUDENTS (id_student, student_email, first_name, last_name, id_promotion, old_promotion)
VALUES
(1, 'jean.bidule@school.fr', 'Jean', 'BIDULE', 1, 0),
(2, 'george.de.la.motte@school.fr', 'George', 'DE LA MOTTE', 1, 0),
(3, 'timothe.chalamet@school.fr', 'Timothé', 'CHALAMET', 2, 1),
(4, 'zendaya.coleman@school.fr', 'Zendaya', 'COLEMAN', 3, 0);

INSERT INTO ABSENCES (id_absence, type_abs, date_abs, justify, duration_abs, id_student_abs)
VALUES
(1, 'late', '2022-02-01', TRUE, 60, 1),
(2, 'absence', '2023-08-02', TRUE, 480, 4),
(3, 'absence', '2024-02-28', TRUE, 480, 4),
(4, 'late', '2022-11-05', FALSE, 240, 1),
(5, 'absence', '2024-02-28', TRUE, 480, 3);

INSERT INTO NOTES (id_notes, note, id_student_notes, id_teacher_notes, publication_date, id_subject_notes)
VALUES
(1, 20 , 2, 2, TO_DATE('2023-02-08', 'YYYY-MM-DD'), 2),
(2, 19 , 4, 2, TO_DATE('2023-02-08', 'YYYY-MM-DD'), 2),
(3, 16 ,1 , 3, TO_DATE('2022-10-25', 'YYYY-MM-DD'), 4),
(4, 15 , 3, 4, TO_DATE('2024-09-24', 'YYYY-MM-DD'), 2);

INSERT INTO TEACHERS (id_teacher, teacher_mail, teacher_first_name, teacher_last_name, teacher_enter_date)
VALUES
(1, 'andrew.mahe@school.com', 'Andrew', 'MAHE', TO_DATE('2023-10-01', 'YYYY-MM-DD')),
(2, 'jean.baptiste.herpin@school.com', 'Jean-Baptiste', 'HERPIN', TO_DATE('2020-09-01', 'YYYY-MM-DD')),
(3, 'kevin.titeux@school.com', 'Kévin', 'TITEUX', TO_DATE('2016-10-01', 'YYYY-MM-DD')),
(4, 'benjamin.labastie@school.com', 'Benjamin', 'LABASTIE',TO_DATE('2023-10-01', 'YYYY-MM-DD'));

INSERT INTO SUBJECTS (id_subject, subject_name, id_teacher)
VALUES
(1, '1PHP', 1),
(2, '1WORK', 2),
(3, '1TALK', 2),
(4, '1HTML', 3),
(5, '1SYN', 4);

SELECT first_name, last_name FROM STUDENTS;

SELECT student_email, first_name, last_name
FROM STUDENTS
INNER JOIN ABSENCES ON STUDENTS.id_student = ABSENCES.id_student_abs 
WHERE ABSENCES.type_abs = "late" AND ABSENCES.justify != TRUE AND ABSENCES.duration_abs >= 10
ORDER BY ABSENCES.duration_abs DESC;

SELECT note, id_student, id_teacher
FROM NOTES
INNER JOIN STUDENTS ON NOTES.id_student_notes = STUDENTS.id_student
INNER JOIN TEACHERS ON NOTES.id_teacher_notes = TEACHERS.id_teacher
WHERE 15 <= note AND note <= 20
ORDER BY note DESC;