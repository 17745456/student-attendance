DROP DATABASE IF EXISTS attendance_system;

CREATE DATABASE attendance_system 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE attendance_system;

SET NAMES utf8mb4;

DROP TABLE IF EXISTS user;
CREATE TABLE user (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(100) NOT NULL COMMENT '密码',
    real_name VARCHAR(200) NOT NULL COMMENT '真实姓名',
    role VARCHAR(20) NOT NULL DEFAULT 'TEACHER' COMMENT '角色：TEACHER/ADMIN',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

DROP TABLE IF EXISTS course;
CREATE TABLE course (
    course_id VARCHAR(20) PRIMARY KEY COMMENT '课程编号',
    course_name VARCHAR(200) NOT NULL COMMENT '课程名称',
    class_name VARCHAR(100) NOT NULL COMMENT '班级名称',
    teacher_id BIGINT NOT NULL COMMENT '教师ID',
    classroom_name VARCHAR(100) COMMENT '教室名称',
    `rows` TINYINT COMMENT '教室行数',
    `cols` TINYINT COMMENT '教室列数',
    exclude_seats VARCHAR(200) COMMENT '不可坐的座位位置',
    weekday TINYINT COMMENT '星期几',
    start_week INT COMMENT '开始周次',
    end_week INT COMMENT '结束周次',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (teacher_id) REFERENCES user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='课程表';

DROP TABLE IF EXISTS course_selection;
CREATE TABLE course_selection (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    student_id VARCHAR(20) NOT NULL COMMENT '学号',
    student_name VARCHAR(200) NOT NULL COMMENT '学生姓名',
    gender CHAR(2) COMMENT '性别',
    course_id VARCHAR(20) NOT NULL COMMENT '课程编号',
    select_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '选课时间',
    FOREIGN KEY (course_id) REFERENCES course(course_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='选课表';

DROP TABLE IF EXISTS attendance;
CREATE TABLE attendance (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    student_id VARCHAR(20) NOT NULL COMMENT '学号',
    student_name VARCHAR(200) NOT NULL COMMENT '学生姓名',
    course_id VARCHAR(20) NOT NULL COMMENT '课程编号',
    check_in_time DATETIME NOT NULL COMMENT '签到时间',
    seat_row TINYINT COMMENT '座位行号',
    seat_col TINYINT COMMENT '座位列号',
    status VARCHAR(20) NOT NULL DEFAULT 'NORMAL' COMMENT '状态：NORMAL正常/LATE迟到/EARLY早退/ABSENT缺勤',
    ip VARCHAR(15) COMMENT '签到IP地址',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    KEY idx_course_id (course_id),
    KEY idx_student_id (student_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='考勤记录表';

SHOW TABLES;

INSERT INTO user (username, password, real_name, role) VALUES
('admin', 'admin123', '系统管理员', 'ADMIN'),
('teacher_zhang', 'teacher123', '张明', 'TEACHER'),
('teacher_li', 'teacher123', '李芳', 'TEACHER');

INSERT INTO course (course_id, course_name, class_name, teacher_id, classroom_name, `rows`, `cols`, exclude_seats, weekday, start_week, end_week) VALUES
('CS101', '数据库系统原理', '计算机1班', 2, '教学楼A-101', 8, 6, '1,1;1,2', 1, 1, 16),
('SE201', 'Java程序设计', '软件1班', 3, '实验楼B-205', 10, 4, '8,1;8,2', 2, 1, 16);

INSERT INTO course_selection (student_id, student_name, gender, course_id) VALUES
('20240001', '王小明', '男', 'CS101'),
('20240002', '刘小红', '女', 'CS101'),
('20240003', '陈思琪', '女', 'CS101'),
('20240001', '王小明', '男', 'SE201'),
('20240002', '刘小红', '女', 'SE201');

INSERT INTO attendance (student_id, student_name, course_id, check_in_time, seat_row, seat_col, status, ip) VALUES
('20240001', '王小明', 'CS101', '2026-03-30 08:25:00', 3, 5, 'NORMAL', '192.168.1.101'),
('20240002', '刘小红', 'CS101', '2026-03-30 08:30:00', 3, 6, 'NORMAL', '192.168.1.102'),
('20240003', '陈思琪', 'CS101', '2026-03-30 08:45:00', 1, 3, 'LATE', '192.168.1.103'),
('20240001', '王小明', 'SE201', '2026-03-31 13:30:00', 2, 1, 'NORMAL', '192.168.1.101'),
('20240002', '刘小红', 'SE201', '2026-03-31 13:28:00', 2, 2, 'NORMAL', '192.168.1.102');


SELECT '========== user表 ==========' AS '';
SELECT * FROM user;

SELECT '========== course表 ==========' AS '';
SELECT * FROM course;

SELECT '========== course_selection表 ==========' AS '';
SELECT * FROM course_selection;

SELECT '========== attendance表 ==========' AS '';
SELECT * FROM attendance;

SELECT '========== 课程及授课教师 ==========' AS '';
SELECT c.course_id, c.course_name, c.class_name, u.real_name AS teacher_name
FROM course c
JOIN user u ON c.teacher_id = u.id;

SELECT '========== 选课详情 ==========' AS '';
SELECT cs.student_id, cs.student_name, cs.course_id, c.course_name
FROM course_selection cs
JOIN course c ON cs.course_id = c.course_id;