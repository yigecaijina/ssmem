<%--
  Created by IntelliJ IDEA.
  User: 84129
  Date: 2021/6/7
  Time: 13:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Title</title>
  <link rel="stylesheet" href="/static/bootstrap-3.3.7-dist/css/bootstrap-theme.css">
  <link rel="stylesheet" href="/static/bootstrap-3.3.7-dist/css/bootstrap.css">
  <link rel="stylesheet" href="/static/bootstrap-3.3.7-dist/css/bootstrap-theme.min.css">
  <script src="/static/js/jquery.min.js"></script>
  <script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  <script src="static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>

<!--员工添加模态框-->
<div class="modal fade" id="emp_add_Model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label">username</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="empName_add_input" placeholder="username" name="empName">
              <span class="help-block"></span>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Email</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="email_add_input" placeholder="Email" name="email">
              <span class="help-block"></span>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">gender</label>
            <div class="col-sm-10">
              <label class="radio-inline">
                <input type="radio" name="gender" id="gender1_add_input" value="m" checked="checked"> 男
              </label>
              <label class="radio-inline">
                <input type="radio" name="gender" id="gender2_add_input" value="f"> 女
              </label>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">deptName</label>
            <div class="col-sm-10">
              <select class="form-control" name="dId" id="dept_add_select"></select>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
      </div>
    </div>
  </div>
</div>

<!--员工修改模态框-->
<div class="modal fade" id="emp_Update_Model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">员工修改</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label">username</label>
            <div class="col-sm-10">
              <p class="form-control-static" id="empName_update_static">empName</p>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Email</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="email_Update_input" placeholder="Email" name="email">
              <span class="help-block"></span>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">gender</label>
            <div class="col-sm-10">
              <label class="radio-inline">
                <input type="radio" name="gender" id="gender1_Update_input" value="m" checked="checked"> 男
              </label>
              <label class="radio-inline">
                <input type="radio" name="gender" id="gender2_Update_input" value="f"> 女
              </label>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">deptName</label>
            <div class="col-sm-10">
              <select class="form-control" name="dId" id="dept_Update_select"></select>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_Update_btn">保存</button>
      </div>
    </div>
  </div>
</div>

<div class="container">
  <!--标题-->
  <div class="row">
    <div class="col-md-12">
      <h1>SSM-CRUD</h1>
    </div>
  </div>
  <!--按钮-->
  <div class="row">
    <div class="col-md-offset-8 col-md-4">
      <button class="btn-primary btn" id="emp_add_Model_btn">新增</button>
      <button class="btn-danger btn" id="emp_delete_all_btn">删除</button>
    </div>
  </div>
  <!--显示表格数据-->
  <div class="row">
    <div class="col-md-12">
      <table class="table table-hover" id="emps_table">
        <thead>
        <tr>
          <th><input type="checkbox" id="checkbox_all"></th>
          <th>#</th>
          <th>empName</th>
          <th>gender</th>
          <th>email</th>
          <th>deptName</th>
          <th>操作</th>
        </tr>
        </thead>
        <tbody></tbody>
      </table>
    </div>
  </div>
  <!--显示分页信息-->
  <div class="row">
    <!--分页文字信息-->
    <div class="col-md-6" id="page_info_area"></div>
    <!--分页条信息-->
    <div class="col-md-6" id="page_nav_area"></div>
  </div>
</div>
<script>
  var totalRecrd,currentPage;
  $(function (){
    to_page(1)
  });
  function to_page(pn){
    $.ajax({
      url:"emps",
      data:"pn="+pn,
      type:"get",
      success(data){
        build_emps_table(data);
        build_page_info(data);
        build_page_nav(data);
      }
    });
  }
  //解析数据
  function build_emps_table(result){
    //清空table表格
    $("#emps_table tbody").empty();
    var emps=result.extend.pageInfo.list;
    $.each(emps,function (index,itme){
      var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
      var empId=$("<td></td>").append(itme.empId);
      var empName=$("<td></td>").append(itme.empName);
      var gender=$("<td></td>").append(itme.gender=='m'?'男':'女');
      var email=$("<td></td>").append(itme.email);
      var deptName=$("<td></td>").append(itme.department.deptName);
      var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
              .append($("<span></span>").addClass("glyphicon glyphicon-pencil delete_btn")).append("编辑");
      editBtn.attr("edit-id",itme.empId);
      var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
              .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
      delBtn.attr("delete-edit-id",itme.empId);
      var btntd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
      $("<tr></tr>").append(checkBoxTd).append(empId).append(empName).append(gender).append(email).append(deptName).appendTo("#emps_table tbody").append(btntd);
    });
  }
  //解析分页信息
  function build_page_info(result){
    $("#page_info_area").empty();
    $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页," +
            "总"+result.extend.pageInfo.pages+"页," +
            "总"+result.extend.pageInfo.total+"条记录");
    totalRecrd=result.extend.pageInfo.total;
    currentPage=result.extend.pageInfo.pageNum;
  }
  //解析分页条
  function build_page_nav(result){
    $("#page_nav_area").empty();
    var ui=$("<ul></ul>").addClass("pagination");
    var firstPageLi=$("<li></li>").append($("<a></a>").append("首页"));
    var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
    //判断是否有上一页
    if (result.extend.pageInfo.hasPreviousPage==false){
      firstPageLi.addClass("disabled");
      prePageLi.addClass("disabled");
    }else {
      //回到首页
      firstPageLi.click(function (){to_page(1)});
      //上一页
      prePageLi.click(function (){to_page(result.extend.pageInfo.pageNum-1)});
    }

    var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
    var lastPageLi=$("<li></li>").append($("<a></a>").append("末页"));
    //判断是否有下一页
    if (result.extend.pageInfo.hasNextPage==false){
      nextPageLi.addClass("disabled");
      lastPageLi.addClass("disabled");
    }else {
      //进入末页
      lastPageLi.click(function (){to_page(result.extend.pageInfo.pages);});
      //下一页
      nextPageLi.click(function (){to_page(result.extend.pageInfo.pageNum+1)})
    }
    //添加首页和前一页
    ui.append(firstPageLi).append(prePageLi)
    $.each(result.extend.pageInfo.navigatepageNums,function (index,itme){
      var numLi=$("<li></li>").append($("<a></a>").append(itme));
      //判断遍历页码是否等于当前页码 是就高亮显示
      if (result.extend.pageInfo.pageNum==itme){
        numLi.addClass("active");
      }
      numLi.click(function (){
        to_page(itme);
      });
      ui.append(numLi);
    });
    //添加下一页和末页
    ui.append(nextPageLi).append(lastPageLi);
    //加入到nav元素
    var navEle=$("<nav></nav>").append(ui);
    navEle.appendTo(("#page_nav_area"));
  }
  //开启模态框
  $("#emp_add_Model_btn").click(function (){
    validate_boolean("#emp_add_Model form");
    getDepts("#dept_add_select");
    $('#emp_add_Model').modal({
      backdrop:"static"
    });
  });
  //动态获取部门信息
  function getDepts(ele){
    $(ele).empty();
    $("#dept_add_select").empty();
    $.ajax({
      url: "depts",
      type: "get",
      success(data) {
        //{"code":100,"msg":"成功","extend":{"list":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}}
        $.each(data.extend.list,function (){
          var optionEle= $("<option></option>").append(this.deptName).attr("value",this.deptId)
          optionEle.appendTo(ele)
        });
      }
    });
  }
  //数据校验
  function validate_add_form(){
    var empName=$("#empName_add_input").val();
    var regName=/(^[a-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]+$)(2,5)/;
    if (!regName.test(empName)){
      show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或6-16位字母或数字")
      return false;
    }else {
      show_validate_msg("#empName_add_input","success","")

    }

    var empemail=$("#email_add_input").val();
    var regemail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    if (!regemail.test(empemail)){
      show_validate_msg("#email_add_input","error","邮箱格式错误")
      return false;
    }else {
      show_validate_msg("#email_add_input","success","")
    }
    return true;
  }
  function validate_boolean(ele){
    $(ele)[0].reset();
    $(ele).find("*").removeClass("has-success has-error");
    $(ele).find(".help-block").text("");
  }
  //点击保存发送AJAX保存员工
  $("#emp_save_btn").click(function (){
    if (!validate_add_form()){
      return false;
    }
    if ($(this).attr("ajax-va")=="error"){
      return false;
    }
    $.ajax({
      url:"emp",
      type:"post",
      //获取表单中的数据，是一个MAP集合
      data:$("#emp_add_Model form").serialize(),
      success(date){
        if (date.code==100){
          //关闭模态框
          $("#emp_add_Model").modal("hide");
          //跳转到最后一页
          to_page(totalRecrd);
        }else {
          if (undefined!=date.extend.map.email){
            show_validate_msg("#email_add_input","error",date.extend.map.email)
          }
          if (undefined!=date.extend.map.empName){
            show_validate_msg("#empName_add_input","error",date.extend.map.empName)
          }
        }
      }
    });
  });
  function show_validate_msg(ele,status,msg){
    $(ele).parent().removeClass("has-success has-error");
    $(ele).next("span").text("");
    if ("success"==status){
      $(ele).parent().addClass("has-success");
      $(ele).next("span").text(msg);
    }else if ("error"==status){
      $(ele).parent().addClass("has-error");
      $(ele).next("span").text(msg);
    }
  }
  //判断用户名是否可用
  $("#empName_add_input").change(function (){
    var empName=this.value;
    $.ajax({
      url:"checkuser",
      type:"POST",
      data:"empName="+empName,
      success(data){
        if (data.code==100){
          show_validate_msg("#empName_add_input","success","用户名可用");
          $("#emp_save_btn").attr("ajax-va","success");
        }else {
          show_validate_msg("#empName_add_input","error",data.extend.cw);
          $("#emp_save_btn").attr("ajax-va","error");
        }
      }
    });
  });
  //开启修改的模态框
  $(document).on("click",".edit_btn",function (){
    //查出部门信息
    getDepts("#dept_Update_select")
    getEmp($(this).attr("edit-id"));
    $("#emp_Update_btn").attr("edit-id",$(this).attr("edit-id"));
    $('#emp_Update_Model').modal({
      backdrop:"static"
    });
  });
  //修改信息回显
  function getEmp(id){
    $.ajax({
      url:"emp/"+id,
      type:"get",
      success:function (data){
        console.log(data);
        var empDate=data.extend.emp;
        $("#empName_update_static").text(empDate.empName);
        $("#email_Update_input").val(empDate.email);
        $("#emp_Update_Model input[name=gender]").val([empDate.gender]);
        $("#emp_Update_Model select").val([empDate.dId])
      }
    });
  }
  //AJAX的修改方法
  $("#emp_Update_btn").click(function (){
    var empemail=$("#email_Update_input").val();
    var regemail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    if (!regemail.test(empemail)){
      show_validate_msg("#email_Update_input","error","邮箱格式错误")
      return false;
    }else {
      show_validate_msg("#email_Update_input","success","")
    }
    $.ajax({
      url:"emp/"+$(this).attr("edit-id"),
      type:"PUT",
      data:$("#emp_Update_Model form").serialize(),
      success:function (data){
        $("#emp_Update_Model").modal("hide");
        to_page(currentPage)
      }
    });
  });
  //单个删除方法
  $(document).on("click",".delete_btn",function (){
    var empName=$(this).parents("tr").find("td:eq(2)").text();
    if (confirm("确认删除"+empName+"吗")){
      $.ajax({
        url:"emp/"+$(this).attr("delete-edit-id"),
        type:"DELETE",
        success:function (data){
          alert(data.msg);
          to_page(currentPage);
        }
      });
    }
  });
  //多个删除全选按钮
  $("#checkbox_all").click(function (){
    $(".check_item").prop("checked",$(this).prop("checked"));
  });
  $(document).on("click",".check_item",function (){
    var flag=$(".check_item:checked").length==$(".check_item").length;
    $("#checkbox_all").prop("checked",flag);
  });

  $("#emp_delete_all_btn").click(function (){
    var emp="";
    var idadd="";
    $.each($(".check_item:checked"),function (){
      emp+= $(this).parents("tr").find("td:eq(2)").text()+",";
      idadd+=$(this).parents("tr").find("td:eq(1)").text()+"-";
    });
    emp=emp.substring(0,emp.length-1);
    idadd=idadd.substring(0,idadd.length-1);
    if (confirm("确认删除"+idadd+"吗")){
      $.ajax({
        url:"emp/"+idadd,
        type:"DELETE",
        success:function (data){
          alert(data.msg);
          to_page(currentPage);
        }
      });
    }
  });
</script>
</body>
</html>
