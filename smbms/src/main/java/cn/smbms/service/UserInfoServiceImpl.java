package cn.smbms.service;
import cn.smbms.dao.IUserInfoDAO;
import cn.smbms.entity.UserInfo;
import cn.smbms.util.PageUtil;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("userService")
public class UserInfoServiceImpl implements IUserInfoService {
    @Resource(name = "IUserInfoDAO")
    private IUserInfoDAO userInfoDAO;
    //登陆
    public UserInfo login(UserInfo info) {
        return userInfoDAO.login(info);
    }

    //全部分类记录
    public int getTotalCount(@Param("name") String name) {
        return userInfoDAO.getTotalCount(name);
    }


  //加载数据
    public PageUtil getOnePageData(int pageIndex, int pageSize,String name) {
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("name",name);
        map.put("pageIndex",(pageIndex-1)*pageSize );//从第条数据开始
        map.put("pageSize",pageSize);

        PageUtil pageUtil=new PageUtil();
        pageUtil.setPageIndex(pageIndex);
        pageUtil.setPageSize(pageSize);

        int totalCount = userInfoDAO.getTotalCount(name);
        int page=totalCount % pageSize ==0 ? totalCount % pageSize : totalCount % pageSize+1;

        pageUtil.setTotalPages(page);
        pageUtil.setTotalRecords(totalCount);

        List<UserInfo> onePageData = userInfoDAO.getOnePageData(map);
        pageUtil.setTotalList(onePageData);
        return pageUtil;
    }

    public boolean addUserInfo(UserInfo userInfo) {
        return userInfoDAO.addUserInfo(userInfo);
    }

    public boolean delUser(Integer id) {
        return userInfoDAO.delUser(id);
    }

    public UserInfo showInfo(@Param("id") Integer id) {
        return userInfoDAO.showInfo(id);
    }

    public boolean updateUserInfo(UserInfo userInfo) {
        return userInfoDAO.updateUserInfo(userInfo);
    }


}
