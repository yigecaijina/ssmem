package com.zhang.crud.service;

import com.zhang.crud.bean.Department;
import com.zhang.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;
    public List<Department> deptsAll(){
        return departmentMapper.selectByExample(null);
    }
}
