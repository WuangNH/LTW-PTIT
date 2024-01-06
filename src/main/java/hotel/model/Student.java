package hotel.model;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "Student")
public class Student {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String diachi;
    private String gpa;
    private String age;

    public Student(Long id, String name, String diachi, String gpa, String age) {
        this.id = id;
        this.name = name;
        this.diachi = diachi;
        this.gpa = gpa;
        this.age = age;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDiachi() {
        return diachi;
    }

    public void setDiachi(String diachi) {
        this.diachi = diachi;
    }

    public String getGpa() {
        return gpa;
    }

    public void setGpa(String gpa) {
        this.gpa = gpa;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    @Override
    public String toString() {
        return "Student{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", address='" + diachi + '\'' +
                ", gpa='" + gpa + '\'' +
                ", age='" + age + '\'' +
                '}';
    }
}
