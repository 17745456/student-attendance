package com.example.studentattendance.entity;

public class Student2 {
    private String studentNo;
    private String name;
    private Integer age;
    private String gender;
    public Student2() {}
    public Student2(String studentNo, String name, Integer age, String gender) {
        this.studentNo = studentNo;
        this.name = name;
        this.age = age;
        this.gender = gender;}
    public String getStudentNo() { return studentNo; }
    public void setStudentNo(String studentNo) { this.studentNo = studentNo; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
}