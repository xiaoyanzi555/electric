function check_lines() {
    var prefix="";//前缀
    //校验线路编码
    var regex=/^[A-Z]/;
    $("#line_code").blur(function () {
        if(!regex.test($("#line_code").val())){
            $(this).val("");//清空数据
            $(this).focus();//再次聚焦
        }
        //获取到前缀
        var str=$("#line_code").val();
        for(var i=0;i<str.length;i++){
            var s=str[i];
            if(s>='A' && s<='Z'){
                prefix+=s;
            }else{
                break;
            }
        }
    });
    //校验起始杆号和结束杆号
    $("#start_pole,#end_pole").blur(function () {
        var reg=new RegExp("^"+prefix);
        var value=$(this).val();
        if(!reg.test(value)){   //不是以前缀开头
            $(this).val("");//清空数据
            $(this).focus();//再次聚焦
        }
        //如果两个值都不低于null时才计算
        //计算出塔基数
        var start_str=$("#start_pole").val()
        var end_str=$("#end_pole").val()
        if(start_str && end_str){
            var str=parseInt(start_str.substring(prefix.length));
            var end=parseInt(end_str.substring(prefix.length));
            //两者相减
            var base_tower=end-str;
            if (base_tower>0){
                $("#tower_base").val(end-str);
            }else{
                $.messager.alert("警告","结束塔基数不能比开始塔基数编号小");
                //清空结束塔编号，清空塔基数，聚焦
                $("#end_pole").val("");
                $("#end_pole").focus();
            }
        }
    });
}