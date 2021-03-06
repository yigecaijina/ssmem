package com.zhang.crud.test;

import com.github.pagehelper.PageInfo;
import com.zhang.crud.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
    @ContextConfiguration(locations = {"file:web/WEB-INF/applicationContext.xml", "file:web/WEB-/INFdispatcher-servlet.xml"})
public class MvcTest {
    @Autowired
    WebApplicationContext webApplicationContext;
    MockMvc mockMvc;
    @Before
    public void initMokcMvc(){
        mockMvc= MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }
    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult mvcResult=mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","5")).andReturn();
        MockHttpServletRequest httpServletRequest=mvcResult.getRequest();
        PageInfo pageInfo= (PageInfo) httpServletRequest.getAttribute("pageInfo");
        System.out.println("当前页码"+pageInfo.getPageNum());
        System.out.println("总页码"+pageInfo.getPages());
        System.out.println("总记录数"+pageInfo.getTotal());
        System.out.println("在页面需要连续显示的页码");
        int[] nums = pageInfo.getNavigatepageNums();
        for (int i:nums) {
            System.out.println(" "+i);
        }
        List<Employee> list=pageInfo.getList();
        for (Employee employee:list) {
            System.out.println("ID"+employee.getEmpId()+"==>Name:"+employee.getEmpName());
        }
    }
}
