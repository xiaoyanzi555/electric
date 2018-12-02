package com.utils;

import com.entity.User;
import com.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

public class UserRealm extends AuthorizingRealm {
    private UserService userService;
    /**
     * 认证
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    //Authentication认证，Token令牌
    //AuthenticationToken 用于收集用户提交的身份（如用户名）及凭据（如密码）：
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken)
            throws AuthenticationException {
        // 获取用户账户
        String account = (String) authenticationToken.getPrincipal();
        // 根据账户在数据库中查找用户对象
        User user = this.userService.findByAccount(account);
        if(user==null){
            throw new UnknownAccountException("用户不存在");
        }
        if(user.getAccount_state()==2){
            throw new LockedAccountException("账户已锁定");
        }
        // 返回包含用户名、加密密码、盐的AuthenticationInfo对象，交给CredentialsMatcher进行密码匹配
        SimpleByteSource salt = SimpleByteSource.bytes(userService.generateSaltString(account,user.getSalt()));
        return new SimpleAuthenticationInfo(user.getAccount(),user.getPassword(),salt,getName());
    }

    /**
     * 授权
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        String account = (String) principalCollection.getPrimaryPrincipal();
        SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
        simpleAuthorizationInfo.setRoles(userService.findAllRoles(account));
        simpleAuthorizationInfo.setStringPermissions(userService.findAllPermissions(account));
        return simpleAuthorizationInfo;
    }

    public UserService getUserService() {
        return userService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
}
