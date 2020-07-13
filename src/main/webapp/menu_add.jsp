<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/6/7
  Time: 15:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="jquery-3.3.1.min.js"></script>
</head>
<body>
    <input type="button" value="返回查询" onclick="location.href='menu_list.jsp'"/>
<form id="addMenuForm">
    菜名:<input type="text" name="mname"/><br>
    是否售罄:<input type="radio" value="1" name="dvalid"/>售卖
    <input type="radio" value="2" name="dvalid"/>售罄<br>
    菜品的价格:<input type="number" name="mprice"/><br>
    菜品的味道:<select name="mtaste">
    <option value="0">请选择菜品味道</option>
    <option value="1">不辣</option>
    <option value="2">微辣</option>
    <option value="3">特辣</option>
</select><br>
    菜品的介绍:<input type="text" name="minfo"/><br>
    菜品的时间:<input type="date" name="mtime"/><br>
    <input type="button" onclick="addMenu()" value="提交"/><input type="reset" value="重置"/>
</form>
</body>
<script type="text/javascript">
    function addMenu(){
        var url = "http://localhost:8090/menus/addMenu";
        $.ajax({
            url:url,
            data:$("#addMenuForm").serialize(),
            dataType:"json",
            type:"post",
            success:function(result){
                if(result.code == 200){
                    alert(result.msg);
                    location.href="menu_list.jsp";
                }
            }
        })
    }
</script>
</html>
