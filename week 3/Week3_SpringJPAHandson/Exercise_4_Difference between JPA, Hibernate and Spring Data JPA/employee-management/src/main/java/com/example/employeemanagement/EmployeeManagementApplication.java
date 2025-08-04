package com.example.employeemanagement;

import com.example.employeemanagement.model.Employee;
import com.example.employeemanagement.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class EmployeeManagementApplication implements CommandLineRunner {

    @Autowired
    private EmployeeService employeeService;

    public static void main(String[] args) {
        SpringApplication.run(EmployeeManagementApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        Employee e = new Employee();
        e.setName("Avinaba Ghosh");
        e.setDepartment("DNP Programmer");
        e.setSalary(60000);

        employeeService.addEmployee(e);
        System.out.println("Employee added to database.");
    }
}
