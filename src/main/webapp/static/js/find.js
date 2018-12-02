//poles表：poles表的查询条件
function find_poles_by_line_id() {
    $.ajax({
        type:'get',
        url:"/lines",
        headers:{"data":"select"},
        success:function(result){
            $("#search_poles_by_lines").combobox({
                data:result.data,
                valueField:'id',
                textField:'text'//不写这两个就不能正常显示
            });
        }
    })
}
function find_poles_by_use_state() {
    $("#search_poles_by_use_state").combobox({
        data:[{
            "id":"",
            "text":"---请选择",
            "selected":true
            },{
            "id":1,
            "text":"启用"
            },{
            "id":2,
            "text":"禁用"
        }],
        valueField:'id',
        textField:'text'
    });
}
//获得当前日期
function getDate(flag) {
        var date = new Date();
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var hours=date.getHours();
        var min=date.getMinutes();
        var second=date.getSeconds();
        var currentdate="";
        if("more"==flag){//判断是否要时分秒
            currentdate = year + "年" + month + "月" + strDate+"日"+hours+"时"+min+"分"+second+"秒"
        }else{
            currentdate = year + "-" + month + "-" + strDate
        }
        return currentdate;

}