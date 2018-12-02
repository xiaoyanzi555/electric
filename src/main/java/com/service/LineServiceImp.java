package com.service;

import com.dao.LineDao;
import com.dao.PoleDao;
import com.entity.Line;
import com.entity.Pole;
import com.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service("lineService")
@Transactional(readOnly = true)
public class LineServiceImp implements LineService {
    @Autowired
    private LineDao lineDao;
    @Autowired
    private PoleDao poleDao;
    @Override
    public List<Line> findAll() {
        return lineDao.findAll();
    }

    @Override
    public Page<Line> find(Line line, Integer page, Integer rows) {
        int total=lineDao.count(line);
        Page<Line> pageBean=new Page<>(total,page,rows);
        List<Line> list=lineDao.find(line,pageBean.getStart(),rows);
        pageBean.setList(list);
        return pageBean;
    }

    @Override
    public Line findById(Integer id) {
        return lineDao.findById(id);
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public Line add(Line line) {
        //默认让其是运行状态
        line.setRun_state(1);
        //如果没有设置投运日期则默认当前日期
        if (line.getDeliver_time()==""){
            SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
            String dateStr=df.format(new Date());
            line.setDeliver_time(dateStr);
        }
        //添加线路表
        lineDao.add(line);
        //获得刚刚添加的前缀,只需要数字
        String line_code=line.getLine_code();
        String prefix="";
        for (int i = 0; i <line_code.length() ; i++) {
            char ch=line_code.charAt(i);
            if (ch>='A' && ch<='Z'){
                prefix+=ch;
            }else {
                break;
            }
        }
        //添加新路的话需要循环新建杆塔
        //1.新建线路，获得新建线路的id
        //1、新建杆塔
        String start_pole=line.getStart_pole().substring(prefix.length());//截取出除开前缀的数字
        int start=start=Integer.parseInt(start_pole);

       //结束编号：
        String end_pole=line.getEnd_pole().substring(prefix.length());;
        int len=end_pole.length();//获取到有几位数字不足的话好补齐0
        int end= end=Integer.parseInt(end_pole);

        for (int i = start; i <end ; i++) {
            Pole pole=new Pole();
            pole.setUse_state(1);//默认让其启用
            pole.setLine_id(line.getId());
            if (len-((i+"").length())==0){
                pole.setPole_code(prefix+i);
            }else if(len-((i+"").length())==1){
                pole.setPole_code(prefix+"0"+i);
            }else if(len-((i+"").length())==2){
                pole.setPole_code(prefix+"00"+i);
            }else if(len-((i+"").length())==3){
                pole.setPole_code(prefix+"000"+i);
            }else if(len-((i+"").length())==4){
                pole.setPole_code(prefix+"0000"+i);
            }else if(len-((i+"").length())==5){
                pole.setPole_code(prefix+"00000"+i);
            }
            //循环添加塔杆表
            poleDao.add(pole);
        }

        return line;
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public Line delete(Integer id) {
        lineDao.delete(id);
        Line line=lineDao.findById(id);
        return line;
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public Line[] delete(Integer[] id) {
        Line[] lines=new Line[id.length];
        for (int i = 0; i <id.length ; i++) {
            Line line=lineDao.findById(id[i]);
            if (line!=null){
                //删除该线路下的所有塔杆
                Pole pole=new Pole();
                pole.setLine_id(id[i]);
                poleDao.deleteByEntity(pole);//根据线路的id删除该线路下的所有杆塔
                lineDao.delete(id[i]);
                lines[i]=line;
            }
        }
        return lines;
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public Line update(Line line) {
        if (line.getDeliver_time()==""){
            SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
            String dateStr=df.format(new Date());
            line.setDeliver_time(dateStr);
        }
        lineDao.update(line);
        Line dbLine=findById(line.getId());
        return dbLine;
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public void update(Integer[] id) {
        if (id!=null && id.length>0){
            for (int i = 0; i <id.length ; i++) {
                Line line=lineDao.findById(id[i]);
                if (line.getUse_state()==1){
                    line.setUse_state(2);
                    //修改该线路下的所有塔杆为相关状态
                    Pole pole=new Pole();
                    pole.setLine_id(id[i]);
                    pole.setUse_state(2);
                    poleDao.updateByEntity(pole);
                }else{
                    line.setUse_state(1);
                    //修改该线路下的所有塔杆为相关状态
                    Pole pole=new Pole();
                    pole.setLine_id(id[i]);
                    pole.setUse_state(1);
                    poleDao.updateByEntity(pole);
                }
                lineDao.update(line);
            }
        }
    }
}
