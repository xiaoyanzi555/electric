package com.service;

import com.dao.PoleDao;
import com.entity.Pole;
import com.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service("poleService")
@Transactional(readOnly = true)
public class PoleServiceImp implements PoleService {
    @Autowired
    private PoleDao poleDao;
    @Override
    public List<Pole> findAll() {
        return poleDao.findAll();
    }

    @Override
    public Page<Pole> find(Pole pole, Integer page, Integer rows) {
        int total=poleDao.count(pole);
        Page<Pole> pageBean=new Page<>(total,page,rows);
        List<Pole> list=poleDao.find(pole,pageBean.getStart(),rows);
        pageBean.setList(list);
        return pageBean;
    }


    @Override
    
    public Pole findById(Integer id) {
        return poleDao.findById(id);
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public Pole add(Pole pole) {
        poleDao.add(pole);
        return pole;
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public Pole delete(Integer id) {
        return null;
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public Pole[] delete(Integer[] id) {
        Pole[] poles=new Pole[id.length];
        if(id!=null && id.length>0){
            for (int i = 0; i <id.length ; i++) {
                Pole pole=poleDao.findById(id[i]);
                if(pole!=null){
                    poleDao.delete(id[i]);
                    poles[i]=pole;
                }
            }
        }
        return new Pole[0];
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public Pole update(Pole pole) {
        poleDao.update(pole);
        pole=poleDao.findById(pole.getId());
        return pole;
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public void update(Integer[] id) {
        if (id!=null && id.length>0){
            for (int i = 0; i <id.length ; i++) {
                Pole pole=poleDao.findById(id[i]);
                if (pole.getUse_state()==1){
                    pole.setUse_state(2);
                }else{
                    pole.setUse_state(1);
                }
                poleDao.update(pole);
            }
        }
    }

    @Override
    public Map<String,String> findStartAndEnd(Integer id) {
        return poleDao.findStartAndEnd(id);
    }

    @Override
    public List<Pole> findByEntity(Pole pole) {
        return poleDao.findByEntity(pole);
    }

    @Override
    public List<Pole> findByEntity_hasDefect(Pole pole) {
        return poleDao.findByEntity_hasDefect(pole);
    }
}
