<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<title>首页</title>
<meta charset="utf-8"/>
<link type="text/css" rel="stylesheet" href="/static/dist/easyui/themes/default/easyui.css">
<link type="text/css" rel="stylesheet" href="/static/dist/easyui/themes/icon.css">
<script type="text/javascript" src="/static/dist/easyui/jquery.min.js"></script>
<script type="text/javascript" src="/static/dist/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/static/js/template-web.js"></script>
<script type="text/javascript" src="/static/js/easyui-extend.js"></script>
<script type="text/javascript" src="/static/js/find.js"></script>
<script type="text/javascript">
    $(function(){
        $("#menu").tree({
            method:'get',
            url:'/menu',
            loadFilter:function (rest,parent) {
                return rest.data;
            },
            onClick:function (node) {
                if(node.url){
                    var tab=$("#main").tabs('getTab',node.text);
                    if(!tab){
                        $("#main").tabs('add',{
                            title:node.text,
                            closable:true,
                            content:'<iframe src="'+node.url+'" frameborder="0" style="width:100%;height:100%;margin:0;"></ifram>'
                        });
                    }else{
                        $("#main").tabs('select',node.text);
                    }
                }
            }
        });
        /*主题部分*/
        $("#main").tabs({
            border:false,
            fit:true
        })
        $("#main").tabs('add',{
            title:"我的工作台",
            href:"/page/workbench/waiting_list/list.jsp"
        })

        //获得日期
        setInterval(function(){
            var currentTime=getDate("more");
            $("#time").html(currentTime);
        },1000)

    })

    function close(){
         var tab = $("#main").tabs('getSelected');
        var index = $("#main").tabs('getTabIndex',tab);
        $("#main").tabs("close",index);
    }

</script>
    <body class="easyui-layout">
    <div data-options="region:'north'" style="height:100px;background: url(/static/imgs/bg.jpg)">
        <span style="color: #fff;text-align: center;line-height: 80px;text-shadow:#000 4px 4px 4px;font-size: 3rem">电力巡检系统</span>
        <div style="float: right">
            <p id="time" style="font-size: 18px;color:#fff;font-weight:bold;text-shadow:#000 1px 1px 1px;position: absolute;right: 400px"></p>
            <div style="margin-top: 30px">

            </div>
            <strong style="font-size: 18px;margin-right: 30px;">欢迎:${user.account}登录</strong>
            <strong style="font-size: 18px;margin-right: 30px">角色:${user.roleName}</strong>
            <div class="op" style="position: absolute;bottom: 5px">
                <strong style="font-size: 16px">【修改密码】</strong>
                <strong><a href="/logout" style="font-size: 16px;text-decoration: none">【注销】</a></strong>
            </div>
        </div>
    </div>
    <div data-options="region:'west',title:'功能菜单'" style="width:180px;">
        <div id="menu"></div>
    </div>
    <div data-options="region:'center'" style="padding:5px;background:#eee;">
        <div id="main" data-x="1222"></div>
    </div>
    </body>
</html>


