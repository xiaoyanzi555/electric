
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <form id="lines_dataForm" action="/lines" method="post">
            <table>
                <tr>
                    <td align="right" style="width: 180px">
                        <label>线路编码：</label>
                    </td>
                    <td align="left">
                        <input name="line_code" id="line_code" type="text" style="width: 250px;height: 28px"
                               class="easyui-validatebox"
                               data-options="novalidate:true,required:true" placeholder="请输入以大写英文字母+数字：XW001">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>线路名称：</label>
                    </td>
                    <td align="left" style="width: 400px">
                        <input name="line_name" id="line_name" type="text" style="width: 250px;height: 28px"
                               class="easyui-validatebox"
                               data-options="novalidate:true,required:true">
                        <label id="tip_line_name" style="color: red"></label>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>线路长度：</label>
                    </td>
                    <td align="left">
                        <input name="line_len" type="number" style="width: 250px;height: 28px"
                               class="easyui-validatebox"
                               data-options="novalidate:true,required:true" placeholder="请输入数字">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>回路长度：</label>
                    </td>
                    <td align="left">
                        <input name="loop_len" type="number" style="width: 250px;height: 28px"
                               class="easyui-validatebox"
                               data-options="novalidate:true,required:true" placeholder="请输入数字">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>投运日期：</label>
                    </td>
                    <td align="left">
                        <input name="deliver_time" type="text" style="width: 250px;height: 28px"
                               class="easyui-datebox">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>电压等级：</label>
                    </td>
                    <td align="left">
                        <input name="elec_grade" type="number" style="width: 250px;height: 28px"
                               class="easyui-validatebox"
                               data-options="novalidate:true,required:true" placeholder="请输入数字">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>起始杆号：</label>
                    </td>
                    <td align="left">
                        <input name="start_pole" id="start_pole" type="text" style="width: 250px;height: 28px"
                               class="easyui-validatebox"
                               data-options="novalidate:true,required:true" placeholder="请以线路名开头">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>结束杆号：</label>
                    </td>
                    <td align="left">
                        <input name="end_pole" id="end_pole" type="text" style="width: 250px;height: 28px"
                               class="easyui-validatebox"
                               data-options="novalidate:true,required:true" placeholder="请以线路名开头">
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>塔基数：</label>
                    </td>
                    <td align="left">
                        <input name="tower_base" id="tower_base" type="number" style="width: 250px;height: 28px"
                               class="easyui-validatebox"
                               data-options="novalidate:true,required:true" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>备注：</label>
                    </td>
                    <td align="left">
                        <textarea cols="5" rows="5" name="remake" type="text" style="width: 250px" class="easyui-validatebox"
                               data-options="novalidate:true,required:true">
                        </textarea>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <label>启用状态：</label>
                    </td>
                    <td align="left">
                        <input name="use_state" type="radio" value="1" checked>启用
                        <input name="use_state" type="radio" value="2">停用
                    </td>
                </tr>
            </table>
        </form>
<style type="text/css">
    #lines_dataForm tr{line-height: 48px}
</style>
<script type="text/javascript">
    $(function () {
        check_lines();
        $("#line_name").blur(function () {
            //线路名称确保唯一
            $.ajax({
                url:'/lines',
                type:'get',
                headers:{"data":"all"},
                success:function (result) {
                    if(result.code==230){
                        var datas=result.data;
                        $.each(datas,function(i){
                            if(datas[i].line_name==$("#line_name").val()){
                                $("#tip_line_name").html("该名称已存在")
                                $("#line_name").val("");
                                $("#line_name").focus();
                                return false;
                            }else {
                                $("#tip_line_name").html("")
                            }
                        })
                    }
                }
            })

        });
    })
</script>