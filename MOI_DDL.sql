DROP DATABASE IF EXISTS moi;

CREATE DATABASE IF NOT EXISTS moi;

USE moi;

-- DROP SQL
DROP TABLE IF EXISTS participation;
DROP TABLE IF EXISTS project;
DROP TABLE IF EXISTS student;

-- 학생들
CREATE TABLE student (
	id VARCHAR(16) NOT NULL,
    password VARCHAR(128) NOT NULL,
    name VARCHAR(12) NOT NULL,
    birthday DATE NOT NULL,
    school CHAR(4) NOT NULL,				-- 대덕, 광주, 대구 로 하자. ENUM으로 안 한 이유는 ENUM을 사용하지 말아야 하는 이유 N가지? 때문에 안 쓰게 됐는데 쓸 거면 써도 돼
    profile VARCHAR(128),
    github VARCHAR(128),
    phone_number CHAR(11),
    area VARCHAR(24),						-- 분야(직무)를 말함
    hashtag VARCHAR(40),
    
    PRIMARY KEY(id)
);

-- 프로젝트 게시물
CREATE TABLE project (
	id INT(11) AUTO_INCREMENT,
    title VARCHAR(24) NOT NULL,
    content VARCHAR(400) NOT NULL,
    closing_date DATE NOT NULL,
    writer VARCHAR(16) NOT NULL,
    personnel VARCHAR(40) NOT NULL,			-- 인원인데 프론트엔드 4명 백엔드 3명이면 프론트엔드4|백엔드3| 이런식으로 저장하자. (좋은 생각있으면 알려줘 딱히 좋은 생각이 안 나)
    hashtag VARCHAR(40),					-- 해시태그인데 #java, #springboot, #django, #flask 라면 #java#springboot#django#flask 로 저장하자.
    profile VARCHAR(128),
    
    FOREIGN KEY (writer) REFERENCES student(id) ON UPDATE CASCADE,
    
    PRIMARY KEY(id)
);

-- 프로젝트 참가현황 ( student >-< project )
CREATE TABLE participation (
	student_id VARCHAR(16) NOT NULL,
    project_id INT(11) NOT NULL,
    
    student_area VARCHAR(24) NOT NULL,		-- student 테이블의 area 컬럼을 말하는 게 아니라 프로젝트 신청할 때 사용한 분야를 말함
    isPassed BOOLEAN DEFAULT false,
    
    FOREIGN KEY (student_id) REFERENCES student(id) ON UPDATE CASCADE,
    FOREIGN KEY (project_id) REFERENCES project(id) ON UPDATE CASCADE,
    
    PRIMARY KEY(student_id, project_id)
);