package com.service;

import com.dao.ResourceDao;
import com.entity.Resource;
import com.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Transactional(readOnly = true)
@Service("resourceService")
public class ResourceServiceImpl implements ResourceService{

    @Autowired
    private ResourceDao resourceDao;


    @Override
    public Page<Resource> find(Resource example, int page, int rows) {
        int count = this.resourceDao.count(example);
        Page<Resource> pageBean = new Page<>(count,page,rows);
        if(count>0){
            List<Resource> list = this.resourceDao.findByExampleWithPage(example,pageBean.getStart(),pageBean.getRows());
            pageBean.setList(list);
        }
        return pageBean;
    }

    @Override
    public List<Resource> find(Resource example) {
        return this.resourceDao.findByExample(example);
    }

    @Override
    public List<Map<String, Object>> findSelectInfo(Resource example) {
        return this.resourceDao.findSelctInfoByExample(example);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED,readOnly = false)
    public Resource add(Resource resource) {
        // 查询父类的路径
        Integer parent_id = resource.getParent_id();
        Resource parent = null;
        if(parent_id!=null){
            parent = resourceDao.findById(parent_id);
        }
        this.resourceDao.add(resource);
        if(parent!=null) {
            String parent_ids = parent.getParent_ids() + "/" + resource.getId();
            resource.setParent_ids(parent_ids);
            this.resourceDao.update(resource);
        }
        return resource;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED,readOnly = false)
    public Resource update(Resource resource) {
        this.resourceDao.update(resource);
        return resource;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED,readOnly = false)
    public void delete(Integer id) {
        this.resourceDao.delete(id);
    }

    @Override
    public Resource findById(Integer id) {
        return resourceDao.findById(id);
    }

    @Override
    public List<Map<String,Object>> findResourcesWithTree(Integer id) {
       /* List<Integer> selectedIdList = new ArrayList<>();
        if(id!=null){
            Resource resource = this.resourceDao.findById(id);
            selectedIdList.add(resource.getId());
        }
        return treeNodeService.generateResourcesTree(selectedIdList);*/
       return null;
    }

}
