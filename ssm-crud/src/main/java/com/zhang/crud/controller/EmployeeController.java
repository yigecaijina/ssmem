package com.zhang.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zhang.crud.bean.Employee;
import com.zhang.crud.bean.Msg;
import com.zhang.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;
    @RequestMapping(value = "/emps",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        //这是一个分页二查询
        //引入PageHelper分页查询
        //在查询之前只需要调用，传入页码和每页大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是分页查询
        List<Employee> list=employeeService.getAll();
        //使用PageInfo包装查询后结果，只需要将PageInfo交给页面就行
        //封装了详细的分页信息，包括查出来的数据和传入连续的页码
        PageInfo pageInfo=new PageInfo(list,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg getEmp(@Valid Employee employee, BindingResult bindingResult){
        Map<String,Object> map=new HashMap<>();
        if (bindingResult.hasErrors()){
            List<FieldError> list=bindingResult.getFieldErrors();
            for (FieldError f:list) {
                System.out.println("错误的字段名"+f.getField());
                System.out.println("错误的信息"+f.getDefaultMessage());
                map.put(f.getField(),f.getDefaultMessage());
            }
            return Msg.fail().add("map",map);
        }else {
            employeeService.empEmp(employee);
            return Msg.success();
        }

    }
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable(value = "id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }
    /*
    * 如果直接发送AJAX=PUT请求
    * 封装的数据除了路径中的会为null
    * 问题
    * 请求体有数据但封装不上
    * 原因：tomcat：只能封装get和post的数据
    * 解决方案
    * 要能支持直接发送PUT请求还要封装请求体中的数据
    * 1：WEB.XML配置上HttpPutFormContentFilter
    * 2：它的作用：将请求体中的数据解析包装成一个map
    * 3：request被重新包装，request.getParameter()被重写，就会从自己封装的MAP中取数据*/
@RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
@ResponseBody
    public Msg saveEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }
    @RequestMapping(value = "/checkuser",method = RequestMethod.POST)
    @ResponseBody
    public Msg checkuser(@RequestParam(value = "empName") String empName){
        boolean b=employeeService.checkUser(empName);
        String str="(^[a-z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]+$)(2,5)";
        if (!empName.matches(str)){
            return Msg.fail().add("cw","用户名可以是6-16位字母或数字2-5位中文");
        }
        if (b){
            return Msg.success();
        }else {
            return Msg.fail().add("cw","用户名不可用");
        }
    }
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpByiId(@PathVariable(value ="id") String id){
    List<Integer> list=new ArrayList<>();
    if (id.contains("-")){
        String[] str=id.split("-");
        for (String st:str) {
            list.add(Integer.parseInt(st));
        }
        employeeService.deleteBatch(list);
    }else {
        employeeService.deleteEmp(Integer.parseInt(id));
    }
    return Msg.success();
    }
}
