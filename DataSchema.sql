CREATE TABLE users (
    user_id NUMBER(4),
    ename VARCHAR2(20) NOT NULL,
    email VARCHAR2(50),
    mobile VARCHAR2(15)
);

CREATE TABLE steering_wheels (
    steering_id NUMBER(4),
    user_id NUMBER(4),
    marker_id NUMBER(3),
    angle_value NUMBER(5, 2)
);

CREATE TABLE calibrations (
    calibration_id NUMBER(6),
    steering_id NUMBER(4),
    center_offset NUMBER(5, 2),
    calibration_date TIMESTAMP
);

/* Встановлення первинних ключів */

ALTER TABLE users
ADD CONSTRAINT users_pk
PRIMARY KEY (user_id);

ALTER TABLE steering_wheels
ADD CONSTRAINT steering_wheels_pk
PRIMARY KEY (steering_id);

ALTER TABLE calibrations
ADD CONSTRAINT calibrations_pk
PRIMARY KEY (calibration_id);

/* Встановлення зовнішніх ключів */

ALTER TABLE steering_wheels
ADD CONSTRAINT steering_wheels_user_id_fk
FOREIGN KEY (user_id)
REFERENCES users (user_id);

ALTER TABLE calibrations
ADD CONSTRAINT calibrations_steering_id_fk
FOREIGN KEY (steering_id)
REFERENCES steering_wheels (steering_id);

/* Обмеження цілісності та регулярні вирази для Oracle (REGEXP_LIKE) */

ALTER TABLE users
ADD CONSTRAINT users_email_template
CHECK (
    REGEXP_LIKE(email, '^[a-z0-9][a-z0-9._-]*@[a-z][a-z0-9._-]*\.[a-z]{2,4}$')
);

ALTER TABLE users
ADD CONSTRAINT users_mobile_template
CHECK (REGEXP_LIKE(mobile, '^(\([0-9]{3}\))?[0-9]{3}-[0-9]{4}$'));

ALTER TABLE steering_wheels
ADD CONSTRAINT steering_angle_range
CHECK (angle_value BETWEEN 0 AND 360);
