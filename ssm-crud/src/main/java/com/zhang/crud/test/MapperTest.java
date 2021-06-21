package com.zhang.crud.test;

import com.zhang.crud.dao.DepartmentMapper;
import com.zhang.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:WEB-INF/applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession session;
    @Test
    public void testCRUD(){
        System.out.println(departmentMapper);
//        //插入部门
//        departmentMapper.insert(new Department(null,"开发部"));
//        departmentMapper.insert(new Department(null,"测试部"));
        //插入员工信息
//        employeeMapper.insert(new Employee(null,"jerry","m","jerry@atguigu.com",1));
        //批量插入员工信息
//        EmployeeMapper employeeMapper2=session.getMapper(EmployeexMapper.class);
//        for (int i = 0; i <1000 ; i++) {
//            String uid=UUID.randomUUID().toString().substring(0,5)+i;
//            employeeMapper2.insert(new Employee(null,uid+i,"m",uid+"@atguigu.com",1));
//        }
        System.out.println("添加完成 ");
    }
}
