ALTER SESSION SET CONTAINER = XEPDB1;

-- Docker 초기화 스크립트
-- 1. myshop 사용자 생성 (이미 존재하면 무시)
DECLARE
    v_user_exists NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_user_exists FROM all_users WHERE username = 'MYSHOP';
    IF v_user_exists = 0 THEN
        EXECUTE IMMEDIATE 'CREATE USER myshop IDENTIFIED BY myshop';
    END IF;
END;
/

-- 2. myshop 사용자에게 권한 부여
GRANT CREATE SESSION TO myshop;
GRANT CONNECT, RESOURCE, DBA TO myshop;
GRANT CREATE VIEW TO myshop;
GRANT CREATE SEQUENCE TO myshop;
ALTER USER myshop DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;

-- 3. 스키마를 myshop으로 변경
ALTER SESSION SET CURRENT_SCHEMA = myshop;

-- 4. 기존 테이블 및 시퀀스 삭제 (오류 무시)
BEGIN EXECUTE IMMEDIATE 'DROP TABLE transactionDetail'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE transaction'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE product'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE users'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE category'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE seq_product_prod_no'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE seq_transaction_tran_no'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE seq_tranDetail_detail_no'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- 5. 시퀀스 생성
CREATE SEQUENCE seq_product_prod_no		 	INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_transaction_tran_no	INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_tranDetail_detail_no	INCREMENT BY 1 START WITH 10000;

-- 6. 테이블 생성
CREATE TABLE users (
	user_id 			VARCHAR2(20)	NOT NULL,
	user_name 	VARCHAR2(50)	NOT NULL,
	password 		VARCHAR2(10)	NOT NULL,
	role 					VARCHAR2(5) 		DEFAULT 'user',
	ssn 					VARCHAR2(13),
	cell_phone 		VARCHAR2(14),
	addr 				VARCHAR2(100),
	email 				VARCHAR2(50),
	reg_date 		DATE,
	PRIMARY KEY(user_id)
);

CREATE TABLE product (
	prod_no 						NUMBER 				NOT NULL,
	prod_name 				VARCHAR2(100) 	NOT NULL,
	prod_detail 				VARCHAR2(200),
	manufacture_day		VARCHAR2(12),
	price 							NUMBER(10),
	image_file 					VARCHAR2(100),
	reg_date 					DATE,
    stock_quantity            NUMBER  DEFAULT 0 NOT NULL,
    CONSTRAINT chk_stock_quantity CHECK (STOCK_QUANTITY >= 0),
	PRIMARY KEY(prod_no)
);

CREATE TABLE transaction (
	tran_no 					NUMBER 			NOT NULL,
	buyer_id 				VARCHAR2(20)	NOT NULL REFERENCES users(user_id),
	payment_option		CHAR(3),
	receiver_name 		VARCHAR2(20),
	receiver_phone		VARCHAR2(14),
	demailaddr 			VARCHAR2(100),
	dlvy_request 			VARCHAR2(100),
	tran_status_code	CHAR(3),
	order_date 			DATE,
	dlvy_date 				DATE,
    total_price             NUMBER NOT NULL,
	PRIMARY KEY(tran_no)
);

CREATE TABLE transactionDetail(
    detail_no NUMBER NOT NULL,
    tran_no NUMBER NOT NULL,
    prod_no NUMBER NOT NULL,
    type_quantity NUMBER NOT NULL,
    type_price NUMBER NOT NULL,
    PRIMARY KEY(detail_no),
    FOREIGN KEY(prod_no) REFERENCES product(prod_no),
    FOREIGN KEY(tran_no) REFERENCES transaction(tran_no)
);

CREATE TABLE category
(
    category_no   NUMBER(16),
    category_name VARCHAR2(100) NOT NULL,
    PRIMARY KEY (category_no),
    UNIQUE (category_name)
);

-- 7. 데이터 삽입
INSERT
INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'admin', 'admin', '1234', 'admin', NULL, NULL, '서울시 서초구', 'admin@mvc.com',to_date('2024/01/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS'));

INSERT
INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date )
VALUES ( 'manager', 'manager', '1234', 'admin', NULL, NULL, NULL, 'manager@mvc.com', to_date('2024/01/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS'));

INSERT INTO users
VALUES ( 'user01', 'SCOTT', '1111', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user02', 'SCOTT', '2222', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user03', 'SCOTT', '3333', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user04', 'SCOTT', '4444', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user05', 'SCOTT', '5555', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user06', 'SCOTT', '6666', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user07', 'SCOTT', '7777', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user08', 'SCOTT', '8888', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user09', 'SCOTT', '9999', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user10', 'SCOTT', '1010', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user11', 'SCOTT', '1111', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user12', 'SCOTT', '1212', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user13', 'SCOTT', '1313', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user14', 'SCOTT', '1414', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user15', 'SCOTT', '1515', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user16', 'SCOTT', '1616', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user17', 'SCOTT', '1717', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user18', 'SCOTT', '1818', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users
VALUES ( 'user19', 'SCOTT', '1919', 'user', NULL, NULL, NULL, NULL, sysdate);


insert into product values (seq_product_prod_no.nextval,'vaio vgn FS70B','소니 바이오 노트북 신동품','20240514',2000, 'AHlbAAAAtBqyWAAA.jpg',to_date('2024/12/14 11:27:27', 'YYYY/MM/DD HH24:MI:SS'),3);
insert into product values (seq_product_prod_no.nextval,'자전거','자전거 좋아요~','20240514',10000, 'AHlbAAAAvetFNwAA.jpg',to_date('2024/11/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS'),2);
insert into product values (seq_product_prod_no.nextval,'보르도','최고 디자인 신품','20240201',1170000, 'AHlbAAAAvewfegAB.jpg',to_date('2024/10/14 10:49:39', 'YYYY/MM/DD HH24:MI:SS'),3);
insert into product values (seq_product_prod_no.nextval,'보드세트','한시즌 밖에 안썼습니다. 눈물을 머금고 내놓음 ㅠ.ㅠ','20240217', 200000, 'AHlbAAAAve1WwgAC.jpg',to_date('2024/11/14 10:50:58', 'YYYY/MM/DD HH24:MI:SS'),3);
insert into product values (seq_product_prod_no.nextval,'인라인','좋아욥','20240819', 20000, 'AHlbAAAAve37LwAD.jpg',to_date('2024/11/14 10:51:40', 'YYYY/MM/DD HH24:MI:SS'),3);
insert into product values (seq_product_prod_no.nextval,'삼성센스 2G','sens 메모리 2Giga','20241121',800000, 'AHlbAAAAtBqyWAAA.jpg',to_date('2024/11/14 18:46:58', 'YYYY/MM/DD HH24:MI:SS'),3);
insert into product values (seq_product_prod_no.nextval,'연꽃','정원을 가꿔보세요','20241022',232300, 'AHlbAAAAtDPSiQAA.jpg',to_date('2024/11/15 17:39:01', 'YYYY/MM/DD HH24:MI:SS'),3);
insert into product values (seq_product_prod_no.nextval,'삼성센스','노트북','20240212',600000, 'AHlbAAAAug1vsgAA.jpg',to_date('2024/11/12 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),3);

insert into transaction values (seq_transaction_tran_no.nextval,'user12', '1', '김철수', '010-1234-5678','서울시 강남구','배송시 연락주세요','b',to_date('2024/11/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS'),to_date('2024/11/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS'),14000);

insert into transactionDetail values (seq_tranDetail_detail_no.nextval, 10000, 10000, 2, 4000);
insert into transactionDetail values (seq_tranDetail_detail_no.nextval, 10000, 10001, 1, 10000);
