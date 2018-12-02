<%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <form>
            <table>
                <tr>
                    <td align="right" style="width: 100px">
                        <strong>任务编号：</strong>
                    </td>
                    <td align="left">
                        <label>{{task_code}}</label>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <strong>任务名称：</strong>
                    </td>
                    <td align="left">
                        <label>{{task_name}}</label>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <strong>巡检线路：</strong>
                    </td>
                    <td align="left">
                        <label>{{line_name_String}}</label>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <strong>起始杆号：</strong>
                    </td>
                    <td align="left">
                        <label>{{start_pole_code}}</label>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <strong>结束杆号：</strong>
                    </td>
                    <td align="left">
                        <label>{{start_pole_code}}</label>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 100px">
                        <strong>下发人：</strong>
                    </td>
                    <td align="left">
                        <label>{{distribute_name}}</label>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <strong>下发日期：</strong>
                    </td>
                    <td align="left" style="width: 200px">
                        <label style="width: 200px">{{distribute_time}}</label>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <strong>备注：</strong>
                    </td>
                    <td align="left">
                        <p>{{remark}}</p>
                    </td>
                </tr>
            </table>
        </form>