package com.example.studentattendance.dao;
import com.example.studentattendance.entity.Student2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class StudentDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void insertStudent(Student2 student) {
        String sql = "INSERT INTO student(student_no, name, age, gender) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(
                sql,
                student.getStudentNo(),
                student.getName(),
                student.getAge(),
                student.getGender()
        );
    }
}