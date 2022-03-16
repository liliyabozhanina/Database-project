SET SCHEMA FN71873@
--������, � ����� �� ���������� ������� � ������� � ��� (���� ��� �������, ���� ���� ���� �� ��������� ������ �� ������� ���������)

CREATE TABLE DOCTORS1 LIKE FN71873.DOCTORS@

INSERT INTO DOCTORS1
SELECT * FROM FN71873.DOCTORS@

CREATE TABLE AUDIT1(CTIME TIMESTAMP, TEXT VARCHAR(200))@

SELECT * FROM AUDIT1@

DROP TRIGGER TRIG_UPD_DOCTOR@

CREATE TRIGGER TRIG_UPD_DOCTOR
    AFTER UPDATE OF SALARY ON DOCTORS
    REFERENCING OLD AS O NEW AS N
    FOR EACH ROW
    WHEN (O.SALARY != N.SALARY)
    BEGIN
      DECLARE V_TEXT VARCHAR(200);
      SET V_TEXT = USER || ' CODE = ' || O.CODE
                        || ' OLD SALARY = ' || CHAR(O.SALARY)
                        || 'NEW SALARY = ' || CHAR(N.SALARY);
      INSERT INTO AUDIT VALUES(CURRENT_TIMESTAMP, V_TEXT);
    END@


SELECT CODE, NAME, SALARY FROM DOCTORS
WHERE COMPARTMENTNAME = 'Surgery'@

UPDATE DOCTORS
    SET SALARY = SALARY + 1000
    WHERE COMPARTMENTNAME = 'Surgery'@
    
CREATE TRIGGER TRIG_DOCTOR_END
    NO CASCADE BEFORE INSERT ON DOCTORS
    REFERENCING OLD AS O NEW AS N
    FOR EACH ROW
    MODE DB2SQL
    WHEN (O.SALARY != N.SALARY)
    BEGIN
      DECLARE V_TEXT VARCHAR(200);
      SET V_TEXT = USER || ' CODE = ' || O.CODE
                        || ' OLD SALARY = ' || CHAR(O.SALARY)
                        || 'NEW SALARY = ' || CHAR(N.SALARY);
      INSERT INTO AUDIT VALUES(CURRENT_TIMESTAMP, V_TEXT);
    END@

