<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>超市账单管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">

    <link rel="stylesheet" href="jquery-easyui-1.5.3/themes/icon.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.pagination.js"></script>

    <!-- 引入JQuery -->
    <script type="text/javascript" src="/jquery-easyui-1.5.3/jquery.min.js"></script>
    <!-- 引入EasyUI -->
    <script type="text/javascript" src="/jquery-easyui-1.5.3/jquery.easyui.min.js"></script>
    <!-- 引入EasyUI的中文国际化js，让EasyUI支持中文 -->
    <script type="text/javascript" src="/jquery-easyui-1.5.3/locale/easyui-lang-zh_CN.js"></script>
    <!-- 引入EasyUI的样式文件-->
    <link rel="stylesheet" href="/jquery-easyui-1.5.3/themes/default/easyui.css" type="text/css">
    <!-- 引入EasyUI的图标样式文件-->


    <script type="text/javascript">

        function jsGetAge(strBirthday)
        {
            var returnAge;
            var strBirthdayArr=strBirthday.split("-");
            var birthYear = strBirthdayArr[0];

            var birthMonth = strBirthdayArr[1];
            var birthDay = strBirthdayArr[2];

            var d = new Date();
            var nowYear = d.getFullYear();
            var nowMonth = d.getMonth() + 1;
            var nowDay = d.getDate();

            if(nowYear == birthYear)
            {

                returnAge = 0;//同年 则为0岁
            }
            else
            {

                var ageDiff = nowYear - birthYear ; //年之差
                if(ageDiff > 0)
                {
                    if(nowMonth == birthMonth)
                    {

                        var dayDiff = nowDay - birthDay;//日之差
                        if(dayDiff < 0)
                        {
                            returnAge = ageDiff - 1;
                        }
                        else
                        {
                            returnAge = ageDiff ;
                        }
                    }
                    else
                    {
                        var monthDiff = nowMonth - birthMonth;//月之差
                        if(monthDiff < 0)
                        {
                            returnAge = ageDiff - 1;
                        }
                        else
                        {
                            returnAge = ageDiff ;
                        }
                    }
                }
                else
                {
                    returnAge = -1;//返回-1 表示出生日期输入错误 晚于今天
                }
            }
            return returnAge;//返回周岁年龄
        }


        function FileOutput(){
           var fileName= confirm("报表导出");
           if(fileName==true){
               alert("成功");
               location.href="${pageContext.request.contextPath}/downloadFile";
           }else{
               alert("失败")
           }
        }
        //删除
        var del;
        jQuery(function ($) {

            del=function(){
               $.messager.confirm('提示','删除',function(){
                   var list=$('#list-content input:checked');
                   var ids=[];
                   $.each(list,function(i,dom){
                       ids+="id="+dom.value+"&";
                   })
                   var id=ids=ids.substring(0,ids.length-1);
                   alert(typeof (id));
                  $.post('/delUser',id,function(date){
                       alert(data)
                   })
               })

            }


            load(0,name);
            $("#silmName").click(function(){
                load(0,name);
            });
            function load(index,name) {
                $.ajax({
                    url:"/getUserInfo",
                    type:"POST",
                    data:{"pageIndex":index,"name":$("#bigName").val()},
                    success:function (data) {
                        $("#list-content").html("");
                        $.each(data.totalList,function(i,dom){
                           /* var sex=null;
                            if(dom.gender==1){
                                sex='男';
                            }else{
                                sex='女';
                            }*/
                            $("#list-content").append("<tr><td><input type='checkbox' id='id' value="+dom.id+"></td><td>"+dom.userName+"</td><td>"+(dom.gender==1?'男':'女')+"</td><td>"+dom.age+"</td><td>"+dom.phone+"</td><td>"+dom.userType+"</td><td><a href='/userView.html'><img src='/img/read.png' alt='查看' title='查看'/></a><a href='/userUpdate.html'><img src='/img/xiugai.png' alt='修改' title='修改'/></a><a href='#'><img src='/img/schu.png' alt='删除' title='删除' onclick='del()'/></a> </td></tr>");
                            //渲染分页
                            $("#pagination").pagination(data.totalRecords,{
                                current_page:index,//当前页索引
                                items_per_page:data.pageSize,//每页的记录数
                                num_display_entries:2,//显示页码块数
                                callback:load,
                                load_first_page:true,
                                prev_text:"Previous",
                                next_text:"Next"
                            })
                        })
                    }
                })
            }
        })




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
                    <li  id="active"><a href="/showUserlist">用户管理</a></li>
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
                <input type="text" id="bigName" name="name" value="${name}" placeholder="请输入用户名"/>
                <input type="button" id="silmName" value="查询"/>
                <input type="button"value="报表导出" onclick="FileOutput()">
                <a href="/userAdd.jsp">添加用户</a>
            </div>
            <!--用户-->
            <table class="providerTable" cellpadding="0" cellspacing="0">
                <tr class="firstTr">
                    <th width="10%">用户编码</th>
                    <th width="20%">用户名称</th>
                    <th width="10%">性别</th>
                    <th width="10%">年龄</th>
                    <th width="10%">电话</th>
                    <th width="10%">用户类型</th>
                    <th width="30%">操作</th>
                </tr>
                <tbody id="list-content"></tbody>
            </table>
            <div id="pagination" class="pagination" style="margin: 4px 0 0 0"></div>
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

    <footer class="footer">
        版权归北大青鸟
    </footer>

<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/js/js.js"></script>
<script src="${pageContext.request.contextPath}/js/time.js"></script>

</body>
</html>