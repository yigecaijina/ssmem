package com.zhang.crud.service;

import com.zhang.crud.bean.Employee;
import com.zhang.crud.bean.EmployeeExample;
import com.zhang.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    public boolean checkUser(String empName) {
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long   count= employeeMapper.countByExample(example);
        return count==0;
    }

    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }

    public void empEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    public Employee getEmp(Integer id) {
       return employeeMapper.selectByPrimaryKey(id);
    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> id) {
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria create= example.createCriteria();
        create.andEmpIdIn(id);
        employeeMapper.deleteByExample(example);
    }
}
