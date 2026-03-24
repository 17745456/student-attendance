package com.example.studentattendance.service.impl;
import com.example.studentattendance.dao.StudentDao;
import com.example.studentattendance.entity.Student2;
import com.example.studentattendance.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service // 标记为 Service 层 Bean
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentDao studentDao;

    @Override
    public void addStudent(Student2 student) {
        // 业务校验：学号不能为空
        if (student.getStudentNo() == null || student.getStudentNo().trim().isEmpty()) {
            throw new IllegalArgumentException("学号不能为空！");
        }
        // 调用 Dao 层执行数据库插入
        studentDao.insertStudent(student);
    }
}