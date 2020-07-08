<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/6/7
  Time: 14:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <script type="text/javascript" src="layui/layui.js"></script>
    <script type="text/javascript" src="jquery-3.3.1.min.js"></script>
</head>


<!--无样式-->
<script type="text/javascript">
    $(function () {
        queryMenuList();
    })
    function queryMenuList(){
        var mname = $("#mname").val();
        var mtaste = $("#mtaste").val();
        var url = "http://localhost:8090/menus/queryMenuList";
        $.ajax({
            url:url,
            dataType:"json",
            data:{
              mname:mname,
              mtaste:mtaste
            },
            type:"post",
            success:function(result){
                if(result.code == 200){
                    var htmls = "";
                     htmls += "<tr>\n" +
                        "            <td>主键ID</td>\n" +
                        "            <td>菜品名称</td>\n" +
                        "            <td>是否售罄</td>\n" +
                        "            <td>菜品的价格</td>\n" +
                        "            <td>菜品的味道</td>\n" +
                        "            <td>菜品的介绍</td>\n" +
                        "            <td>时间</td>\n" +
                        "        </tr>\n" +
                        "        <tr id=\"menuTr\">\n" +
                        "        </tr>";
                    var data = result.data;
                    for(var i = 0 ; i < data.length ; i ++){
                        htmls+="<tr>";
                        htmls+="<td>"+data[i].nid+"</td>";
                        htmls+="<td>"+data[i].mname+"</td>";
                        if(data[i].dvalid == 1){
                            htmls+="<td>售卖</td>";
                        }else{
                            htmls+="<td>售罄</td>";
                        }
                        htmls+="<td>"+data[i].mprice+"</td>"
                        if(data[i].mtaste == 1){
                            htmls += "<td>不辣</td>"
                        }else if(data[i].mtaste == 2){
                            htmls += "<td>微辣</td>"
                        }else if(data[i].mtaste == 3){
                            htmls += "<td>特辣</td>"
                        }
                        htmls+="<td>"+data[i].minfo+"</td>"
                        htmls+="<td>"+data[i].mtime+"</td>"
                        htmls+="</tr>";
                    }
                    $("#menuTable").html(htmls);
                }
            }
        })
    }
</script>
<body>
<button type="button" onclick="location.href='http://localhost:8090/menus/execelMenu'">导出Excel</button>
<center>
    <form>
        菜名:<input type="text" id="mname"/><br>
        菜的味道:<select id="mtaste">
        <option value="0">请选择</option>
        <option value="1">不辣</option>
        <option value="2">微辣</option>
        <option value="3">特辣</option>
    </select>
        <br>
        <input type="button" onclick="queryMenuList()" value="查询"/>
        <input type="reset"  value="重置"/>
    </form>
    <table border="1" cellspacing="0" id="menuTable">
        <tr>
            <td></td>
        </tr>
    </table>
</center>
<input type="button" value="添加菜品" onclick="location.href='menu_add.jsp'"/>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" onclick="location.href='http://localhost:8090/menus/execelLayuiMenu'"><i class="layui-icon">&#xe67d;</i></button>
        <button class="layui-btn layui-btn-sm" lay-event="addMenu">添加用户</button>
    </div>
</script>
<form class="layui-form layui-form-pane">
    <div class="layui-form-item">
        <label class="layui-form-label">菜名</label>
        <div class="layui-input-inline">
            <input type="text" name="mname" id="mame"  class="layui-input">
        </div>
            <label class="layui-form-label">菜品的味道</label>
            <div class="layui-input-inline">
                <select name="mtaste" id="maste">
                    <option value="0">请选择</option>
                    <option value="1">不辣</option>
                    <option value="2">微辣</option>
                    <option value="3">特辣</option>
                </select>
            </div>
        <button type="button" id="searchClick" class="layui-btn"><i class="layui-icon">&#xe615;搜索</i></button>
    </div>
</form>
<table class="layui-hide" id="menTable" lay-filter="menTable"></table>
</body>

<!--layui-->
<script type="text/javascript">

    layui.use(['table','laydate','form'],function () {
        var table = layui.table;
        var laydate = layui.laydate;
        var form = layui.form;
        var menTable = table.render({
            elem:"#menTable"
            ,url:'http://localhost:8090/menus/queryMenuLayuiList'
            ,id:"UserDemo"
            ,where:{
                mname:$("#mame").val(),
                mtaste:$("#maste").val(),
            }
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
            ,cols: [
                [
                    {field:'nid', title: 'ID',}
                    ,{field:'mname', title: '菜品名称'}
                    ,{field:'dvalid', title: '是否售罄',templet:function (data) {
                        if(data.dvalid == 1){
                            return "售卖";
                        }else{
                            return "售罄";
                        }
                    }}
                    ,{field:'mprice',  title: '菜品价格'}
                    ,{field:'mtaste', title: '菜品味道',templet:function (data) {
                        if(data.mtaste == 1){
                            return "不辣";
                        }else if(data.mtaste == 2){
                            return "微辣";
                        }else {
                            return "特辣";
                        }
                    }} //minWidth：局部定义当前单元格的最小宽度，layui 2.2.1 新增
                    ,{field:'minfo', title: '菜品介绍'}
                    ,{field:'mtime',title:'时间'}
                ]
            ],
        })
        $("#searchClick").on('click',function () {
            menTable.reload({
                where:{
                    mname:$("#mame").val(),
                    mtaste:$("#maste").val(),
                },
                page:{
                    curr:1
                }
            })
        })
        table.on('toolbar(menTable)',function (obj) {
            switch(obj.event){
                case 'addMenu':
                    addMenu();
                    break;
            }
        })

        function addMenu(){
            layer.open({
                type:1,
                title:"用户新增",
                content: $("#menuFormHtml").html(), //这里content是一个普通的String
                area: ['24%', '60%'],
                btn:['保存','关闭'],
                success:function (layero,index) {
                    laydate.render({
                        elem:"#mtime"
                    })
                    form.render();
                },
                yes:function (lavero,index) {
                    layer.msg("保存");
                    var url = "http://localhost:8090/menus/addLayuiMenu";
                    $.ajax({
                        url:url,
                        data:$("#menuForm").serialize(),
                        dataType:"json",
                        type:"post",
                        success:function(result){
                            if(result.code == 200){
                                layer.msg(result.msg);
                                layer.closeAll();
                                menTable.reload();
                            }
                        }

                    })
                }
            })
        }
    })



</script>

<script type="text/html" id="menuFormHtml">
    <form class="layui-form" id="menuForm">
        <div class="layui-form-item">
            <label class="layui-form-label">菜品名称</label>
            <div class="layui-input-inline">
                <input type="text" name="mname" required lay-verify="required" placeholder="请输入菜品名称" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">菜品的价格</label>
            <div class="layui-input-inline">
                <input type="number" name="mprice" required lay-verify="required" placeholder="请输入菜品价格" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">是否售罄</label>
            <div class="layui-input-block">
                <input type="radio" name="dvalid" value="1" title="售卖"checked>
                <input type="radio" name="dvalid" value="2" title="售罄">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">菜品的味道</label>
            <div class="layui-input-inline">
                <select name="mtaste">
                    <option value="0">请选择</option>
                    <option value="1">不辣</option>
                    <option value="2">微辣</option>
                    <option value="3">特辣</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">菜品的介绍</label>
            <div class="layui-input-inline">
                <input type="text" name="minfo" required lay-verify="required" placeholder="请输入菜品介绍" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">时间</label>
            <div class="layui-input-inline">
                <input type="text" name="mtime" id="mtime" required lay-verify="required" placeholder="请输入日期" autocomplete="off" class="layui-input">
            </div>
        </div>
    </form>
</script>

</html>
