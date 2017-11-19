package cn.smbms.dao;
import cn.smbms.entity.UserInfo;
import cn.smbms.util.PageUtil;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface IUserInfoDAO {
    //登录
    public UserInfo login(UserInfo info);
    //全部 / 分类 总记录
    public int getTotalCount(@Param("name") String name);
    //获取单页的数据
    public List<UserInfo> getOnePageData(Map<String,Object> map);

   //添加
    public boolean addUserInfo(UserInfo userInfo);

    //删除
    public boolean delUser(Integer id);

    //查看详细信息
    public UserInfo showInfo(@Param("id") Integer  id);

    //修改
    public boolean updateUserInfo(UserInfo userInfo);



}
