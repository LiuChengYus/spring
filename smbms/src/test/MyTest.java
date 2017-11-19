import cn.smbms.entity.UserInfo;
import cn.smbms.service.IUserInfoService;
import cn.smbms.service.UserInfoServiceImpl;
import cn.smbms.util.PageUtil;
import org.junit.Test;

import javax.annotation.Resource;

public class MyTest {

    IUserInfoService userInfoService=new UserInfoServiceImpl();
    @Test
    public void test01(){
        PageUtil onePageData = userInfoService.getOnePageData(0, 2, "null");
        for (UserInfo item:onePageData.getTotalList()) {
            System.out.println(item.getUserName());
        }
    }
}
