CREATE TABLE ADMIN (
	ADMIN_NO NUMBER NOT NULL,
	ADMIN_ID VARCHAR2(300),
	ADMIN_PW VARCHAR2(300),
	ADMIN_NAME VARCHAR2(300),
	ADMIN_TEL VARCHAR2(300),
	JOIN_DATE DATE default sysdate
);

ALTER TABLE ADMIN
	ADD
		CONSTRAINT PK_ADMIN
		PRIMARY KEY (
			ADMIN_NO
		);

CREATE TABLE MEMBERS (
	MEMBERS_NO NUMBER NOT NULL,
	MEMBERS_ID VARCHAR2(300),
	MEMBERS_PW VARCHAR2(300),
	MEMBERS_NAME VARCHAR2(300),
	MEMBERS_TEL VARCHAR2(100),
	MEMBERS_EMAIL VARCHAR2(300),
	MEMBERS_REGDATE DATE default sysdate,
	MEMBERS_OUTDATE DATE,
	MEMBERS_GENDER VARCHAR2(300),
	MEMBERS_ZIPCODE VARCHAR2(300),
	MEMBERS_ADDRESS VARCHAR2(300),
	MEMBERS_ADDRESS_DETAIL VARCHAR2(300)
);

ALTER TABLE MEMBERS
	ADD
		CONSTRAINT PK_MEMBERS
		PRIMARY KEY (
			MEMBERS_NO
		);

CREATE TABLE STORY (
	STORY_NO NUMBER NOT NULL,
	MEMBERS_NO NUMBER,
	STORY_TITLE VARCHAR2(300),
	STORY_CONTENT CLOB,
	STORY_WRITER VARCHAR2(300),
	STORY_CNT NUMBER default 0,
	STORY_DATE DATE default sysdate
);

ALTER TABLE STORY
	ADD
		CONSTRAINT PK_STORY
		PRIMARY KEY (
			STORY_NO
		);

ALTER TABLE STORY
	ADD
		CONSTRAINT FK_MEMBERS_TO_STORY
		FOREIGN KEY (
			MEMBERS_NO
		)
		REFERENCES MEMBERS (
			MEMBERS_NO
		);

CREATE TABLE FLIGHT (
	FLIGHT_NO NUMBER NOT NULL,
	FLIGHT_TITLE VARCHAR2(300),
	FLIGHT_CONTENT VARCHAR2(3000),
	FLIGHT_IMG1 VARCHAR2(1500),
	FLIGHT_THUMB VARCHAR2(1500),
	FLIGHT_PRICE VARCHAR2(300),
	FLIGHT_DEPARTURE VARCHAR2(300),
	FLIGHT_ARRIVAL VARCHAR2(300)
);

ALTER TABLE FLIGHT
	ADD
		CONSTRAINT PK_FLIGHT
		PRIMARY KEY (
			FLIGHT_NO
		);

CREATE TABLE HOTEL (
	HOTEL_NO NUMBER NOT NULL,
	HOTEL_TITLE VARCHAR2(300),
	HOTEL_CONTENT VARCHAR2(3000),
	HOTEL_IMG VARCHAR2(1500),
	HOTEL_THUMB VARCHAR2(1500),
	HOTEL_PRICE VARCHAR2(300),
	HOTEL_CATEGORY VARCHAR2(300),
	HOTEL_AREA VARCHAR2(300)
);

ALTER TABLE HOTEL
	ADD
		CONSTRAINT PK_HOTEL
		PRIMARY KEY (
			HOTEL_NO
		);

CREATE TABLE ACTIVITY (
	ACTIVITY_NO NUMBER NOT NULL,
	ACTIVITY_TITLE VARCHAR2(300),
	ACTIVITY_CONTENT VARCHAR2(3000),
	ACTIVITY_IMG VARCHAR2(1500),
	ACTIVITY_THUMB VARCHAR2(1500),
	ACTIVITY_PRICE VARCHAR2(300),
	ACTIVITY_VIDEO VARCHAR2(1500),
	ACTIVITY_AREA VARCHAR2(300)
);

ALTER TABLE ACTIVITY
	ADD
		CONSTRAINT PK_ACTIVITY
		PRIMARY KEY (
			ACTIVITY_NO
		);

CREATE TABLE LANTRIP (
	LANTRIP_NO NUMBER NOT NULL,
	LANTRIP_TITLE VARCHAR2(300),
	LANTRIP_CONTENT VARCHAR2(3000),
	LANTRIP_IMG1 VARCHAR2(1500),
	LANTRIP_THUMB VARCHAR2(1500),
	LANTRIP_PRICE VARCHAR2(300),
	LANTRIP_VIDEO VARCHAR2(1500),
	LANTRIP_AREA VARCHAR2(300)
);

ALTER TABLE LANTRIP
	ADD
		CONSTRAINT PK_LANTRIP
		PRIMARY KEY (
			LANTRIP_NO
		);

CREATE TABLE PRACTICE (
	PRACTICE_NO NUMBER NOT NULL,
	PRACTICE_TITLE VARCHAR2(300),
	PRACTICE_CONTENT VARCHAR2(3000)
);

ALTER TABLE PRACTICE
	ADD
		CONSTRAINT PK_PRACTICE
		PRIMARY KEY (
			PRACTICE_NO
		);

CREATE TABLE QNA (
	QNA_NO NUMBER NOT NULL,
	MEMBERS_NO NUMBER,
	QNA_TITLE VARCHAR2(300),
	QNA_CONTENT VARCHAR2(3000),
	QNA_WRITER VARCHAR2(300),
	QNA_DATE DATE default sysdate
);

ALTER TABLE QNA
	ADD
		CONSTRAINT PK_QNA
		PRIMARY KEY (
			QNA_NO
		);

ALTER TABLE QNA
	ADD
		CONSTRAINT FK_MEMBERS_TO_QNA
		FOREIGN KEY (
			MEMBERS_NO
		)
		REFERENCES MEMBERS (
			MEMBERS_NO
		);

CREATE TABLE PAYMENT (
	PAYMENT_NO NUMBER NOT NULL,
	MEMBERS_NO NUMBER,
	FLIGHT_NO NUMBER,
	HOTEL_NO NUMBER,
	ACTIVITY_NO NUMBER,
	LANTRIP_NO NUMBER,
	PAYMENT_BOOKDATE DATE default sysdate,
	PAYMENT_QUANTITY VARCHAR2(300),
	PAYMENT_PRICE VARCHAR2(300),
	PAYMENT_DATE DATE default sysdate
);

ALTER TABLE PAYMENT
	ADD
		CONSTRAINT PK_PAYMENT
		PRIMARY KEY (
			PAYMENT_NO
		);

ALTER TABLE PAYMENT
	ADD
		CONSTRAINT FK_MEMBERS_TO_PAYMENT
		FOREIGN KEY (
			MEMBERS_NO
		)
		REFERENCES MEMBERS (
			MEMBERS_NO
		);

ALTER TABLE PAYMENT
	ADD
		CONSTRAINT FK_FLIGHT_TO_PAYMENT
		FOREIGN KEY (
			FLIGHT_NO
		)
		REFERENCES FLIGHT (
			FLIGHT_NO
		);

ALTER TABLE PAYMENT
	ADD
		CONSTRAINT FK_HOTEL_TO_PAYMENT
		FOREIGN KEY (
			HOTEL_NO
		)
		REFERENCES HOTEL (
			HOTEL_NO
		);

ALTER TABLE PAYMENT
	ADD
		CONSTRAINT FK_ACTIVITY_TO_PAYMENT
		FOREIGN KEY (
			ACTIVITY_NO
		)
		REFERENCES ACTIVITY (
			ACTIVITY_NO
		);

ALTER TABLE PAYMENT
	ADD
		CONSTRAINT FK_LANTRIP_TO_PAYMENT
		FOREIGN KEY (
			LANTRIP_NO
		)
		REFERENCES LANTRIP (
			LANTRIP_NO
		);

/* 시퀀스 */
CREATE SEQUENCE MEMBERS_SEQ
increment by 1
start with 1
nocache;

CREATE SEQUENCE FLIGHT_SEQ
increment by 1
start with 1
nocache;

CREATE SEQUENCE HOTEL_SEQ
increment by 1
start with 1
nocache;

CREATE SEQUENCE ACTIVITY_SEQ
increment by 1
start with 1
nocache;

CREATE SEQUENCE LANTRIP_SEQ
increment by 1
start with 1
nocache;

CREATE SEQUENCE PAYMENT_SEQ
increment by 1
start with 1
nocache;

CREATE SEQUENCE STORY_SEQ
increment by 1
start with 1
nocache;

CREATE SEQUENCE ADMIN_SEQ
increment by 1
start with 1
nocache;

CREATE SEQUENCE QNA_SEQ
increment by 1
start with 1
nocache;

CREATE SEQUENCE PRACTICE_SEQ
increment by 1
start with 1
nocache;

/* 관리자 정보 입력 */
INSERT INTO ADMIN (ADMIN_NO, ADMIN_ID, ADMIN_PW, ADMIN_NAME, ADMIN_TEL, JOIN_DATE)
VALUES(999, 'admin', '1004', '운영자', '010-1004-1004', sysdate);

commit