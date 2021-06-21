package com.zhang.crud.controller;

import com.zhang.crud.bean.Department;
import com.zhang.crud.bean.Msg;
import com.zhang.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;
    @RequestMapping(value = "depts")
    @ResponseBody
    public Msg depts(){
        List<Department> list=departmentService.deptsAll();
      return Msg.success().add("list",list);
    }
}
