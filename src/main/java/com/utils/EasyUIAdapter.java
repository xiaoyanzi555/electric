package com.utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.entity.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EasyUIAdapter {

    public static String datagrid(Page pageBean){
        Map<String,Object> data=new HashMap<>();
        data.put("total",pageBean.getTotalPages());
        data.put("rows",pageBean.getList());
        return JSON.toJSONStringWithDateFormat(data, "yyyy-MM-dd",SerializerFeature.PrettyFormat);
    }
    public static Map<String,Object> datagridMap(Page pageBean){
        Map<String,Object> data=new HashMap<>();
        data.put("total",pageBean.getTotalPages());
        data.put("rows",pageBean.getList());
        return data;

    }
    //适配有check的控件defectType
    public static Map<String,Object> datagridMapChecked_DefectType(Page pageBean){
        Map<String,Object> data=new HashMap<>();
        data.put("total",pageBean.getTotalPages());
        List<DefectType> list=pageBean.getList();
        for (DefectType defectType:list){
            if (defectType.getUse_state()==2){
                defectType.setChecked(false);
            }
        }
        data.put("rows",list);
        return data;

    }
    //适配DefectType的适配
    public static List<Map<String,Object>> combobox_DefectType(List<DefectType> list, List<DefectType> selectedList){
        List<Map<String,Object>> result=new ArrayList<>();
        Map<String,Object> def=new HashMap<>();
        def.put("id","");
        def.put("text","---请选择---");
        def.put("selected",true);
        result.add(def);
        if(list!=null && list.size()>0){
            for(DefectType defectType:list){
                Map<String,Object> item=new HashMap<>();
                item.put("id",defectType.getId());
                item.put("text",defectType.getDefect_type());
                if(selectedList!=null && selectedList.size()>0){
                    for(DefectType d:selectedList){
                        if (d.getId().equals(defectType.getId())){
                            item.put("selected",true);
                        }
                    }
                }
                result.add(item);
            }
        }
        return result;
    }
    //适配role
    public static Map<String,Object> datagridMapChecked_Role(Page pageBean){
        Map<String,Object> data=new HashMap<>();
        data.put("total",pageBean.getTotalPages());
        List<Role> list=pageBean.getList();
        for (Role role:list){
            if (role.getUse_state()==2){
                 role.setChecked(false);
            }
        }
        data.put("rows",list);
        return data;

    }
    //以role的名字为id
    public static List<Map<String,Object>> datagridMap_Role(List<Role> list){
        List<Map<String,Object>> data=new ArrayList<>();
        Map<String,Object> def=new HashMap<>();
        def.put("id","");
        def.put("text","---请选择---");
        def.put("selected",true);
        data.add(def);
       if (list!=null && list.size()>0){
           for(Role role:list){
               Map<String,Object> item=new HashMap<>();
               item.put("id",role.getRole_name());
               item.put("text",role.getRole_name());
               data.add(item);
           }

       }
        return data;

    }
    //以role的id为id
    public static List datagridMap_Role_id(List<Role> list,User user) {
        List<Map<String,Object>> data=new ArrayList<>();
        if (user==null){
            Map<String,Object> def=new HashMap<>();
            def.put("id","");
            def.put("text","---请选择---");
            def.put("selected",true);
            data.add(def);
        }
        if (list!=null && list.size()>0){
            for(Role role:list){
                Map<String,Object> item=new HashMap<>();
                item.put("id",role.getId());
                item.put("text",role.getRole_name());
                if(user!=null){
                    if (role.getId().equals(user.getRole_id())){
                        item.put("selected",true);
                    }
                }
                data.add(item);
            }

        }
        return data;
    }
    public static List<Map<String,Object>> comboboxLine(List<Line> list,Line dbline){
        List<Map<String,Object>> result=new ArrayList<>();
        if (dbline==null){
            Map<String,Object> def=new HashMap<>();
            def.put("id","");
            def.put("text","---请选择---");
            def.put("selected",true);
            result.add(def);//为了设置请选择
        }
        if(list!=null && list.size()>0){
            for(Line line:list){
                Map<String,Object> item=new HashMap<>();
                item.put("id",line.getId());
                item.put("text",line.getLine_name());
                if (dbline!=null){
                    if (line.getId().equals(dbline.getId())){
                        item.put("selected",true);
                    }
                }
                result.add(item);
            }
        }
        return result;
    }

    //user的适配
    public static List<Map<String,Object>> combobox_User(List<User> list, List<User> selectedList){
        List<Map<String,Object>> result=new ArrayList<>();
        if(list!=null && list.size()>0){
            for(User user:list){
                Map<String,Object> item=new HashMap<>();
                item.put("id",user.getId());
                item.put("text",user.getUname());
                if(selectedList!=null && selectedList.size()>0){
                    for(User u:selectedList){
                        if (u.getId().equals(user.getId())){
                            item.put("selected",true);
                        }
                    }
                }
                result.add(item);
            }
        }
        return result;
    }

    //inspection适配
    public static List<Map<String,Object>> datagridMap_Ins(List<Inspection> list){
        List<Map<String,Object>> data=new ArrayList<>();
        Map<String,Object> def=new HashMap<>();
        def.put("id","");
        def.put("text","---请选择---");
        def.put("selected",true);
        data.add(def);
        if (list!=null && list.size()>0){
            for(Inspection inspection:list){
                Map<String,Object> item=new HashMap<>();
                item.put("id",inspection.getTask_code());
                item.put("text",inspection.getTask_code());
                data.add(item);
            }

        }
        return data;

    }

    /**
     * 将数据库的查询结果转化为easyui tree的形式
     * @param list
     * @return
     */
    public static List<Map<String,Object>> treeMap(List<Resource> list) {
        //找根节点
        List<Map<String,Object>> result=new ArrayList<>();
        if (list!=null && list.size()>0){
            for(Resource resource:list){
                if(resource.getParent_id()==null){
                    Map<String,Object> node=new HashMap<>();
                    node.put("id",resource.getId());
                    node.put("text",resource.getMenu_name());
                    result.add(node);
                    iterator(node,list);
                }
            }
        }
        return result;
    }
//递归查找子节点
    private static void iterator(Map<String, Object> parentNode, List<Resource> list) {
        Integer id= (Integer) parentNode.get("id");
        //找到子节点
        for(Resource resource:list){
            if(id.equals(resource.getParent_id())){
                Map<String,Object> child=new HashMap<>();
                child.put("id",resource.getId());
                child.put("text",resource.getMenu_name());
                child.put("url",resource.getUrl());//为了让根节点没有url属性
                if(!parentNode.containsKey("children")){
                    List<Map<String,Object>> children=new ArrayList<>();
                    parentNode.put("children",children);
                }
                //将子节点放入父节点的children集合中
                ((List<Map<String,Object>>)parentNode.get("children")).add(child);
                //递归
                iterator(child,list);
            }

        }
    }
}
