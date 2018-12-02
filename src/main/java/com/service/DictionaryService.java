package com.service;

import com.dao.DictionaryDao;
import com.entity.Dictionary;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DictionaryService {
    private DictionaryDao dictionaryDao;
    //缓存数据
    static Map<String,Map<String,String>> data=new HashMap<>();
    static List<Dictionary> list=new ArrayList<>();
    public Map<String,Map<String,String>> load(){
        List<Dictionary> list=dictionaryDao.find();
        if(!DictionaryService.list.equals(list)){
            data.clear();
            for(Dictionary dictionary:list){
                if(!data.containsKey(dictionary.getTypename())){
                    data.put(dictionary.getTypename(),new HashMap<String, String>());
                }
                data.get(dictionary.getTypename()).put(dictionary.getCode(),dictionary.getName());
            }
            DictionaryService.list=list;
        }
        return data;
    }
    public static Map<String,String> load(String typename){
        return data.containsKey(typename)?data.get(typename):new HashMap<String,String>();
    }
    public static String load(String typename,String code){
        Map<String,String> items=load(typename);
        return items.containsKey(code)?items.get(code):"";
    }
    public DictionaryDao getDictionaryDao() {
        return dictionaryDao;
    }

    public void setDictionaryDao(DictionaryDao dictionaryDao) {
        this.dictionaryDao = dictionaryDao;
    }
}
