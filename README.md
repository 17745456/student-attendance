# SpringBoot 开发实践 - 第六周 JdbcTemplate 数据访问

这个示例项目已经帮你完成了：

- 任务一：配置数据源
- 任务二：创建 `UserDao` 并完成 CRUD
- 任务三：创建 `Service` 和 `Controller`
- 课后作业：补充登录验证接口，并给出 Postman 测试方法

---

## 一、项目结构

```text
attendance-system
├── pom.xml
├── src/main/java/com/example/attendance
│   ├── AttendanceSystemApplication.java
│   ├── common/ApiResponse.java
│   ├── controller/AuthController.java
│   ├── controller/UserController.java
│   ├── dao/UserDao.java
│   ├── dto/LoginRequest.java
│   ├── entity/User.java
│   ├── service/UserService.java
│   └── service/impl/UserServiceImpl.java
└── src/main/resources
    ├── application.yml
    └── sql/attendance_system.sql
```

---

## 二、任务一：配置数据源

### 1）创建数据库
先执行下面这个 SQL 文件：

```sql
src/main/resources/sql/attendance_system.sql
```

它会自动：
- 创建 `attendance_system` 数据库
- 创建 `user` 表
- 插入 4 条测试数据

### 2）修改数据库配置
打开：

```yaml
src/main/resources/application.yml
```

把密码改成你自己的 MySQL 密码：

```yaml
spring:
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/attendance_system?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B8
    username: root
    password: your_password
```

### 3）启动项目
在项目根目录运行：

```bash
mvn spring-boot:run
```

或者直接用 IDEA 启动 `AttendanceSystemApplication`。

如果控制台没有报错，并且访问接口成功，就说明数据库连接成功。

---

## 三、任务二：创建 UserDao 类

已经完成的方法如下：

- `insert(User user)`：新增用户
- `findById(Long id)`：根据 ID 查询
- `findByUsername(String username)`：根据用户名查询
- `findAllTeachers()`：查询所有教师
- `findAll()`：查询所有用户
- `findByRole(String role)`：按角色查询
- `countByRole(String role)`：统计角色人数
- `update(User user)`：更新用户
- `deleteById(Long id)`：根据 ID 删除

说明：
- 查询使用了 `query()` 和 `queryForObject()`
- 增删改使用了 `update()`
- 使用 `BeanPropertyRowMapper` 自动映射 `real_name -> realName`

---

## 四、任务三：创建 Service 和 Controller

### 1）Service 层
- `UserService`
- `UserServiceImpl`

职责：
- 调用 `UserDao`
- 组织业务逻辑
- 提供登录验证方法

### 2）Controller 层
- `UserController`
- `AuthController`

提供 REST 接口，方便你用 Postman 测试。

---

## 五、接口清单（可直接用于 Postman）

### 1）新增用户
**POST** `http://localhost:8080/users`

请求体：
```json
{
  "username": "teacher03",
  "password": "123456",
  "realName": "赵老师",
  "role": "TEACHER"
}
```

---

### 2）根据 ID 查询用户
**GET** `http://localhost:8080/users/1`

---

### 3）根据用户名查询
**GET** `http://localhost:8080/users/username/teacher01`

---

### 4）查询全部用户
**GET** `http://localhost:8080/users`

---

### 5）查询全部教师
**GET** `http://localhost:8080/users/teachers`

---

### 6）按角色查询
**GET** `http://localhost:8080/users/role/TEACHER`

---

### 7）统计某角色人数
**GET** `http://localhost:8080/users/count/TEACHER`

---

### 8）更新用户
**PUT** `http://localhost:8080/users/1`

请求体：
```json
{
  "password": "888888",
  "realName": "张老师（已修改）",
  "role": "TEACHER"
}
```

---

### 9）删除用户
**DELETE** `http://localhost:8080/users/4`

---

### 10）登录验证接口（课后作业）
**POST** `http://localhost:8080/auth/login`

请求体：
```json
{
  "username": "teacher01",
  "password": "123456"
}
```

---

## 六、提交作业建议

你可以直接用下面的提交信息：

```bash
git add .
git commit -m "完成第六周JDBC-template开发"
```

---

## 七、常见问题排查

### 1）数据库连接失败
检查：
- MySQL 是否启动
- 数据库 `attendance_system` 是否创建成功
- 用户名密码是否正确
- 3306 端口是否可用

### 2）查询报空指针或查不到数据
检查：
- 表里是否有数据
- 用户名是否正确
- `findById()` 或 `findByUsername()` 查不到时，本项目已返回 `null`

### 3）中文乱码
本项目连接串已加：
- `useUnicode=true`
- `characterEncoding=utf8`

### 4）字段映射失败
当前实体类字段：
- `id`
- `username`
- `password`
- `realName`
- `role`

数据库字段：
- `id`
- `username`
- `password`
- `real_name`
- `role`

其中 `real_name -> realName` 可被 `BeanPropertyRowMapper` 自动识别。

---

## 八、老师检查时你可以这样讲

1. 我先在 `pom.xml` 中引入了 Web、JDBC 和 MySQL 驱动依赖。  
2. 然后在 `application.yml` 中完成了数据源配置。  
3. 接着在 `UserDao` 中使用 `JdbcTemplate` 完成了增删改查。  
4. 查询使用 `query` / `queryForObject`，新增、修改、删除使用 `update`。  
5. 最后封装了 `Service` 和 `Controller`，并增加了登录验证接口。  
6. 我还使用 Postman 对各接口进行了测试。  

---

## 九、一个课堂答辩时可补充的小优化点

目前密码还是明文保存，只适合课堂练习。  
如果是正式项目，应该：
- 对密码进行加密存储（例如 BCrypt）
- 增加参数校验
- 增加全局异常处理
- 返回更规范的状态码
