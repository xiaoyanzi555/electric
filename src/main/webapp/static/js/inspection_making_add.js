function find_start_end(newValue, oldValue) {
    //动态查询出起始杆号和结束杆号自动填写
    //获得所选择的线路id
    $.ajax({
        url:'/poles/'+newValue+'/poles',
        type:'get',
        success:function (result) {
            if (result.code==200){
                $("#start_pole_id").val(result.data.min)
                $("#end_pole_id").val(result.data.max)
            }
        }
    })
}
//在打开一个弹框
function openChoose() {
    $("#distribution_dialog").dialog({"href":"/page/inspection/inspection_making/distribution.jsp"});
    $("#distribution_dialog").dialog("open");
}
//建立存储对象
var peoplename=[];//人员名字
var peopleid=[];//人员id
function dis_dl_save(){
    //点击保存之前首先情况值
    peoplename.length=0;
    peopleid.length=0;
    //点击保存的时候获取被选中的值
    var options=$("#check_staf option");
    $.each(options,function (i) {
        //建立一个对象将option和对应的值进行存储
        peoplename.push($(this).text());
        peopleid.push($(this).val());
    })
    //关闭对话框
    $("#distribution_dialog").dialog("close");
    //将保存的文本值放入texterea里面
    $("#ins_peoples").html(peoplename.join(","))
    //设置巡检员的id
    $("#staff_ids").val(peopleid.join(","))
}
function dis_cl_save(){ //取消保存
    $("#distribution_dialog").dialog("close");
}
