package com.example.studentattendance.controller;
import com.example.studentattendance.entity.Student2;
import com.example.studentattendance.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/students")
public class StudentController2 {
    @Autowired
    private StudentService studentService;

    @PostMapping("/add")
    public String addStudent(@RequestBody Student2 student) {
        try {
            studentService.addStudent(student);
            return "学生新增成功！学号：" + student.getStudentNo();
        } catch (IllegalArgumentException e) {
            return "新增失败：" + e.getMessage();
        } catch (Exception e) {
            return "系统错误，请稍后重试";
        }
    }
}
