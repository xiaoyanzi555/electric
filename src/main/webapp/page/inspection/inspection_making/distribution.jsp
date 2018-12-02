<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/12
  Time: 21:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div style="float: left;margin-left: 40px">
    <p><label>待选择列表</label></p>
    <select multiple style="width: 150px;height: 200px" id="all_staff"></select>
</div>
<div style="float: left;margin-top: 100px">
    <span>
    <p><a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,onClick:rightFunc">→</a></p>
    <p><a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true,onClick:leftFunc">←</a></p>
</span>
</div>
<div style="float: left;">
    <p><label>已经选择列表</label></p>
    <select multiple style="height: 200px;width: 150px" id="check_staf"></select>
</div>

<script type="text/javascript">
    $(function () {
        //通过角色表查询出巡检员的id
        $.ajax({
            type:'get',
            url:'/roles',
            data:{role_name:"巡检员"},
            headers:{"select":"ins"},
            success:function (result) {
                if(result.code==200){
                    var roleid=result.data.id;
                    //查取出所有的用户显示在列表中,且身份是巡检员的
                    //必须完成之后再发请求不然获取不到id
                    $.ajax({
                        url:"/roles/"+roleid+"/users",
                        data:{role_id:roleid},
                        success:function (result) {
                            if(result.code==200){
                                var allstf=result.data;
                                $.each(allstf,function(i){
                                    var child='<option value="'+allstf[i].id+'">'+allstf[i].text+'</option>'
                                    $("#all_staff").append(child)
                                })
                            }
                        }
                    })
                }
            }
        })

    })
    function rightFunc() {
        $("#all_staff option:selected").each(function () {
            $("#check_staf")[0].appendChild($(this)[0]);
        })
    }
    function leftFunc() {
        $("#check_staf option:selected").each(function () {
            $("#all_staff")[0].appendChild($(this)[0]);
        })
    }



</script>