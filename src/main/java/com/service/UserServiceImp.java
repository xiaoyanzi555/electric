package com.service;


import com.dao.UserDao;
import com.dao.UserInsConDao;
import com.entity.Resource;
import com.entity.User;
import com.entity.UserInsCon;
import com.utils.Page;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.DefaultHashService;
import org.apache.shiro.crypto.hash.HashRequest;
import org.apache.shiro.util.ByteSource;
import org.apache.shiro.util.SimpleByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

@Service("userService")
@Transactional(readOnly = true)
public class UserServiceImp implements UserService{
    @Autowired
    private UserDao userDao;
    @Autowired
    private UserInsConDao userInsConDao;
    @Override
    public Page<User> find(User example, Integer page, Integer rows) {
        int total=userDao.count(example);
        Page pageBean=new Page(total,page,rows);
        List<User> list=userDao.find(example,pageBean.getStart(),rows);
        pageBean.setList(list);
        return pageBean;
    }
    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }


    @Override
    public User findById(Integer id) {
        return userDao.findById(id);
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public User add(User user) {
        //设置默认邮箱
        user.setEmail(user.getAccount()+"@qq.com");
        //如果没有设置日期
        if (user.getDimission_time()==""){
            SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
            String dateStr=df.format(new Date());
            user.setDimission_time(dateStr);
        }
        if (user.getHiredate_time()==""){
            SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
            String dateStr=df.format(new Date());
            user.setHiredate_time(dateStr);
        }
        String salt = generateSalt(user.getPassword());  // 根据明文密码产生盐
        String pass = generateHex(user.getPassword(),generateSaltString(user.getAccount(),salt)); // 结合明文密码与私盐产生密文密码
        user.setPassword(pass);
        user.setSalt(salt);
        userDao.add(user);
        return user;
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public User delete(Integer id) {
        User user=userDao.findById(id);
        if(user!=null){
            userDao.delete(id);
        }
        return user;
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public User[] delete(Integer[] id) {
        User[] users=new User[id.length];
        if(id!=null && id.length>0){
            for (int i = 0; i <id.length ; i++) {
                User u=userDao.findById(id[i]);
                if(u!=null){
                    userDao.delete(id[i]);
                    users[i]=u;
                }
            }
        }
        return users;
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public User update(User user) {
        //如果没有设置日期
        if (user.getDimission_time()==""){
            SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
            String dateStr=df.format(new Date());
            user.setDimission_time(dateStr);
        }
        if (user.getHiredate_time()==""){
            SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
            String dateStr=df.format(new Date());
            user.setHiredate_time(dateStr);
        }
        String salt = generateSalt(user.getPassword());  // 根据明文密码产生盐
        String pass = generateHex(user.getPassword(),generateSaltString(user.getAccount(),salt)); // 结合明文密码与私盐产生密文密码
        user.setPassword(pass);
        user.setSalt(salt);

        userDao.update(user);
        User dbuser=userDao.findById(user.getId());
        return dbuser;
    }


    //批量修改
    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public User[] update(Integer[] id) {
        //通过id找到user
        User[] users=new User[id.length];
        if (id!=null && id.length>0){
            for (int i = 0; i <id.length ; i++) {
                User user=userDao.findById(id[i]);
                if (user.getAccount_state()==1){
                    user.setAccount_state(2);
                }else {
                    user.setAccount_state(1);
                }
                users[i]=user;
                userDao.update(user);
            }

        }
        return users;
    }

    @Override
    public User findByAccount(User user) {
        return userDao.findByAccount(user);
    }

    //根据角色id查找用户
    @Override
    public List<User> findUsersByRoleId(Integer roleid) {
        return userDao.findUsersByRoleId(roleid);
    }

    @Override
    public List<User> findByUIC(UserInsCon userInsCon) {
        //构建user集合
        List<User> userList=new ArrayList<>();
        List<UserInsCon> list=userInsConDao.find(userInsCon);
        //通过循环查取用户
        if (list!=null && list.size()>0){
            for(UserInsCon uic:list){
                User user=userDao.findById(uic.getStaff_id());
                userList.add(user);
            }
        }
        return userList;
    }





    @Override
    public User login(String account, String pass) {
        // 根据用户账户查找用户
        User example = new User();
        example.setAccount(account);
        User user = this.userDao.findByAccount(example);
        if(user==null) return null;
        // 比较密码
        String inPass = generateHex(pass,user.getSalt());
        // 如果传入的密码与数据库存储的密码相同
        if(inPass.equals(user.getPassword())){
            return user;
        }
        return null;
    }

    @Override
    public User findByAccount(String account) {
        User user=new User();
        user.setAccount(account);
        return this.userDao.findByAccount(user);
    }

    // 根据用户账号查询对应的角色集合
    @Override
    public Set<String> findAllRoles(String account) {
        return this.userDao.findAllRoles(account);
    }
    // 根据用户账号查询对应的权限集合
    @Override
    public Set<String> findAllPermissions(String account) {
        return this.userDao.findAllPermissions(account);
    }


    /**
     * 使用密码与时间字符串随机生成盐
     * @return
     */
    static final SimpleDateFormat DF = new SimpleDateFormat("yyyyMMddHHmmssSSS");
    public String generateSalt(String msg){
        SecureRandomNumberGenerator randomNumberGenerator =
                new SecureRandomNumberGenerator();
        randomNumberGenerator.setSeed((DF.format(new Date())+msg).getBytes());
        return randomNumberGenerator.nextBytes().toHex();
    }
    @Override
    public String generateSaltString(String username, String salt) {
        return username + salt;
    }


    /**
     * 根据字符串和私盐生成加密字符串
     * @param salt
     * @return
     */
    @Transactional(propagation = Propagation.REQUIRED,readOnly = false)
    public String generateHex(String pass,String salt){
        DefaultHashService hashService = new DefaultHashService();
        hashService.setHashAlgorithmName("SHA-512");
        hashService.setPrivateSalt(new SimpleByteSource(salt));//私盐，只接受SimpleByteSource对象
        hashService.setHashIterations(2);//加密次数
        HashRequest request = new HashRequest.Builder()
                .setAlgorithmName("SHA-512")
                .setSource(ByteSource.Util.bytes(pass))
                .setSalt(ByteSource.Util.bytes(salt))
                .setIterations(2)
                .build();
        return hashService.computeHash(request).toHex();
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED,readOnly = false)
    public boolean checkPass(String pass, String salt, String dbPass) {
        String securityPass = generateHex(pass,salt);
        return securityPass.equals(dbPass);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED,readOnly = false)
    public void changePass(String account, String pass,Integer id) {
        User user = new User();
        user.setAccount(account);
        String salt = generateSalt(pass);  // 根据明文密码产生公盐
        pass = generateHex(pass,generateSaltString(account,salt)); // 结合明文密码与盐产生密文密码
        user.setPassword(pass);
        user.setSalt(salt);
        user.setId(id);
        this.userDao.update(user);
    }

    @Override
    public List<Resource> findMenu(String account) {
        return userDao.findMenu(account);
    }

}
