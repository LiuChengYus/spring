<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="utf-8" isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>超市账单管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <%--<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/easyui/themes/icon.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css"/>


    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jQuery1.11.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-migrate-1.2.0.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js"></script>



    <script type="text/javascript">

        function save(){
         $.messager.confirm('提示','添加吗',function(){
                 $.post('${pageContext.request.contextPath}/addUser',$("#form2").serialize(),function(data){
                     if(data==true){
                         alert('添加成功');
                         $('#addUser').dialog('close');
                     }else{
                         alert('添加失败');
                     }
                 });
         });
        }

        //删除 单条记录
        function del(index){  //删除操作
            $.messager.confirm('确认','确认删除?',function(row){
                if(row){
                    var selectedRow = $('#test').datagrid('getSelected');  //获取选中行
                    $.ajax({
                        url:'/delUser?id='+selectedRow.id+'&type=stu',
                        success:function(data){
                            if(data){
                                $.messager.alert('提示','删除成功','question');
                            }
                        }
                    });
                    $('#test').datagrid('deleteRow',index);
                }
            })
        }


        //删除多条记录

        function deluser(index){
            var selectRows = $("#test").datagrid("getSelections");
            if (selectRows!=0) {
                //提示用户是否真的删除数据
                $.messager.confirm("确认消息", "您确定要删除此信息么？", function (r) {
                    if (r) {
                        var strIds = "";
                        for (var i = 0; i < selectRows.length; i++) {
                            strIds += selectRows[i].id + ",";
                        }
                        strIds = strIds.substr(0, strIds.length - 1);

                        $.post("${pageContext.request.contextPath}/delis", {ids: strIds}, function (data) {
                            if (data == true) {
                                //删除完成后自动刷新页面
                                $("#test").datagrid("reload");
                                $("#test").datagrid("clearSelections");
                            } else {
                                $.messager.alert("删除失败", data);
                            }
                        })
                    }
                })
            }else{
                $.messager.alert("系统提示","请选择一条要编辑的数据！");
                return;
            }
        }

        //修改
        function edit(rec){
             var row = $('#test').datagrid('getSelected');
             $.ajax({
                url:'/updateboolean',
                 data:{'id':row.id},
                success:function(data){
                    location.href="/userUpdate.jsp";
                }
             });
        }

        function load() {
            $('#test').datagrid({
                /*title:'用户列表',
                iconCls:'icon-add',*/
                width:680,
                height:450,
                pagination: true,
                loadMsg: '数据加载中...',
                nowrap: true,
                striped: true,
                url:'${pageContext.request.contextPath}/getUserInfo?name='+$("[name=uname]").val(),
                sortName: 'code',
                sortOrder: 'desc',
                align:'center',
                idField:'code',
                frozenColumns:[[  //冻结列
                    {field:'ck',checkbox:true},//控制复选框是否显示
                    /*{title:'用户编号',field:'code',width:80,sortable:true}*/
                ]],
                columns:[[ //Column是一个数组对象，它的每个元素也是一个数组。元素数组的元素是一个配置对象，它定义了每个列的字段。
                    {field:'userName',title:'用户名称',width:100}, //title 标题文本
                    {field:'gender',title:'性别',width:100,  //field：列的字段名
                        formatter:function(value){
                            if(value==1){
                                return "男";
                            }else{
                                return "女";
                            }
                        }
                    },
                    {field:'birthday',title:'年龄',width:100,
                        formatter:function(value){
                            return jsGetAge(value);
                        }
                    },
                    {field:'phone',title:'电话',width:100},
                    {field:'userType',title:'用户类型',width:100,
                        formatter:function(value){
                            if(value==1){
                                return "管理员";
                            }else if(value==2){
                                return "员工";
                            }else{
                                return "经理";
                            }
                        }
                    },
                    {field:'opt',title:'操作',width:100,align:'center',formatter:function(value,rec,index){
                       var d = '<a href="#" mce_href="#" onclick="del(\''+ index +'\')">删除';
                       var e = '<a href="#" mce_href="#" onclick="edit(\''+ rec.id + '\')">修改</a> ';
                       return d+e;
                    }},
                ]],
                pagination:true,
                rownumbers:true,
                pageSize: 2,
                pageList: [2, 3, 5, 10],
                singleSelect:false,
                toolbar:[{ //工具栏
                    text:'添加',
                    iconCls:'icon-add',
                    disabled:false,
                    handler:function(){
                        open1();
                    }
                },'-',{
                    id: 'btnDelete',
                    text:'删除',
                    iconCls:'icon-remove',
                    disabled:false,
                    handler:function(){
                        deluser();
                    }
                },'-',{
                    text:'修改',
                    iconCls: 'icon-edit',
                    disabled:false,
                    handler:function(){
                       alert('修改');
                    }
                },'-',{
                    text:'查找',
                    iconCls: 'icon-search',
                    disabled:false,
                    handler:function(){
                        alert('查找');
                    }
                },'-']
            });
        }
        //模糊查询
        var btnSelect=function() {
            load();

        };
        $(function () {
            load();
            $('#cc').combobox( {
                width:150
            });
        });

      function open1(){
          $('#addUser').dialog();
      }

        function close1() {
            $('#addUser').dialog('close');
        }


        function jsGetAge(strBirthday) {
            var returnAge;
            var strBirthdayArr=strBirthday.split("-");
            var birthYear = strBirthdayArr[0];
            var birthMonth = strBirthdayArr[1];
            var birthDay = strBirthdayArr[2];
            var d = new Date();
            var nowYear = d.getFullYear();
            var nowMonth = d.getMonth() + 1;
            var nowDay = d.getDate();
            if(nowYear == birthYear){
                returnAge = 0;//同年 则为0岁
            }else{
                var ageDiff = nowYear - birthYear ; //年之差
                if(ageDiff > 0){
                    if(nowMonth == birthMonth){
                        var dayDiff = nowDay - birthDay;//日之差
                        if(dayDiff < 0){
                            returnAge = ageDiff - 1;
                        }else{
                            returnAge = ageDiff ;
                        }
                    }else{
                        var monthDiff = nowMonth - birthMonth;//月之差
                        if(monthDiff < 0){
                            returnAge = ageDiff - 1;
                        } else{
                            returnAge = ageDiff ;
                        }
                    } }else{
                    returnAge = -1;//返回-1 表示出生日期输入错误 晚于今天
                }
            }
            return returnAge;//返回周岁年龄
        }

    </script>


</head>
<body>
<!--头部-->
<header class="publicHeader">
    <h1>超市账单管理系统</h1>
    <div class="publicHeaderR">
        <p><span>下午好！</span><span style="color: #fff21b"> Admin</span> , 欢迎你！</p>
        <a href="login.html">退出</a>
    </div>
</header>
<!--时间-->
<section class="publicTime">
    <span id="time">2015年1月1日 11:11  星期一</span>
    <a href="#">温馨提示：为了能正常浏览，请使用高版本浏览器！（IE10+）</a>
</section>
<!--主体内容-->
<section class="publicMian ">
    <div class="left">
        <h2 class="leftH2"><span class="span1"></span>功能列表 <span></span></h2>
        <nav>
            <ul class="list">
                <li><a href="billList.html">账单管理</a></li>
                <li><a href="providerList.html">供应商管理</a></li>
                <li  id="active"><a href="userList.html">用户管理</a></li>
                <li><a href="password.html">密码修改</a></li>
                <li><a href="login.html">退出系统</a></li>
            </ul>
        </nav>
    </div>
    <div class="right">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span>用户管理页面</span>
        </div>
        <div class="search">
            <span>用户名：</span>
            <input type="text" name="uname" placeholder="请输入用户名"/>
            <input type="button" onclick="btnSelect()" value="查询"/>
            <a href="userAdd.jsp">添加用户</a>
        </div>
        <!--用户-->
        <table id="test">
        </table>
        <div  class="pagination" id="pagination" style="margin:4px 0 0 0" ></div>
    </div>
</section>

<!--点击删除按钮后弹出的页面-->
<div class="zhezhao"></div>
<div class="remove" id="removeUse">
    <div class="removerChid">
        <h2>提示</h2>
        <div class="removeMain">
            <p>你确定要删除该用户吗？</p>
            <a href="#" id="yes">确定</a>
            <a href="#" id="no">取消</a>
        </div>
    </div>
</div>
<div  id="addUser" style="width:700px;padding:30px 60px;font-size: 17px;">
    <form id="form2" onsubmit="return validateUser()">
        <div>
            <label for="userId">用户编码：</label>
            <input type="text"  name="userCode" id="userId"/>
            <span id="userIdMsg"></span>
        </div>
        <div>
            <label for="userName">用户名称：</label>
            <input type="text" class="easyui-textbox" name="userName" id="userName"/>
            <span >*请输入用户名称</span>
        </div>
        <div>
            <label for="userpassword">用户密码：</label>
            <input type="text" class="easyui-textbox" name="userPassword" id="userpassword"/>
            <span>*密码长度必须大于6位小于20位</span>

        </div>
        <div>
            <label for="userRemi">确认密码：</label>
            <input type="text" class="easyui-textbox"  id="userRemi"/>
            <span>*请输入确认密码</span>
        </div>
        <div>
            <label >用户性别：</label>
            <select name="gender">
                <option value="1">男</option>
                <option value="0">女</option>
            </select>
                    <span></span>
        </div>
        <div>
            <label for="data">出生日期：</label>
            <input type="text" name="birthday" id="data"/>
            <span >*</span>
        </div>
        <div>
            <label for="userphone">用户电话：</label>
            <input type="text" class="easyui-textbox" name="phone" id="userphone"/>
            <span >*</span>
        </div>
        <div>
            <label for="userAddress">用户地址：</label>
            <input type="text" class="easyui-textbox" name="address" id="userAddress"/>
        </div>
        <div>
            <label >用户类别：</label>
            <input type="radio" name="userType" value="0"/>管理员
            <input type="radio" name="userType" value="1"/>经理
            <input type="radio" name="userType" value="2"/>普通用户
        </div>
        <a href="javascript:save();" class="easyui-linkbutton">添加</a>
        <a href="javascript:close1();" class="easyui-linkbutton">关闭</a>
    </form>
</div>

<footer class="footer">
    版权归北大青鸟
</footer>

</body>
</html>