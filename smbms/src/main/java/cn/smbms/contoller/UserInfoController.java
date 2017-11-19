package cn.smbms.contoller;
import cn.smbms.entity.UserInfo;
import cn.smbms.service.IUserInfoService;
import cn.smbms.util.MyDate;
import cn.smbms.util.PageUtil;
import org.apache.commons.io.FileUtils;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


@Controller
public class UserInfoController {
    //登陆
    @Resource(name = "userService")
    IUserInfoService userInfoService;
    @RequestMapping("/login")
  public String isLogin(UserInfo info, HttpSession session){
       UserInfo user = userInfoService.login(info);
       if(user!=null){
           //登录成功
           session.setAttribute("userinfo",user);
           return "/welcome.jsp";
       }else{
        //登录失败，跳回login
           return "/login.jsp";
       }
   }

   //日期转换
    @InitBinder
    public void initBinder(WebDataBinder webDataBinder){
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        webDataBinder.registerCustomEditor(Date.class,new MyDate());
    }


   @RequestMapping(value = "/showUserlist")
   public String showUserList(){
      return "/userList.jsp";
   }


   //获取用户数据
    @ResponseBody
    @RequestMapping(value = "/getUserInfo")
    public Object getUserInfo(@RequestParam(defaultValue = "1", value = "page")int pageIndex, @RequestParam(defaultValue = "2",value = "rows")int pageSize,@RequestParam(required = false) String name, Model model){
       model.addAttribute("name",name);
        System.out.println(name+"---->");
        Map<String,Object> map=new HashMap<String,Object>();
        PageUtil onePageData = userInfoService.getOnePageData(pageIndex, pageSize, name);
        map.put("total",onePageData.getTotalRecords());
        map.put("rows",onePageData.getTotalList());
        return map;
    }


    //添加用户
    @RequestMapping(value = "/addUser")
    @ResponseBody
    public Object addUser( UserInfo userInfo,HttpSession session){
        UserInfo userinfo = (UserInfo) session.getAttribute("userinfo");
        System.out.println(userinfo.getId()+"--->");
        userinfo.setCreatedBy(userinfo.getId());
        userInfo.setCreationDate(new Date());
        userInfo.setModifyDate(new Date());
        return userInfoService.addUserInfo(userInfo);
    }
    //导出报表
    @RequestMapping(value = "/downloadFile")
    @ResponseBody
    public ResponseEntity<byte[]> download() throws Exception{
        System.out.println(1);
        String path="E:/user.xls";
        File file=new File(path);
        HttpHeaders  headers=new HttpHeaders();
        String fileName=new String("你好.xls".getBytes("UTF-8"),"ISO-8859-1");
        headers.setContentDispositionFormData("attachment",fileName);
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers,HttpStatus.CREATED);
    }


    //删除  单挑记录
    @RequestMapping(value = "/delUser")
    @ResponseBody
    public Object delUser(Integer  id){
        System.out.println(id+"---》");
        boolean b = userInfoService.delUser(id);
        return b;
    }


    //删除多条记录
    @ResponseBody
    @RequestMapping(value = "/delis" ,method = RequestMethod.POST)
    public Object delUser(@RequestParam(value = "ids",required = false) String  ids){
        String [] idstr = ids.split(",");
        System.out.println(idstr.length+"-->");
        boolean flag = false;
        for (String id:idstr){
            System.out.println(id+"-->");
            flag = userInfoService.delUser(Integer.parseInt(id));
        }
        return flag;
    }

   /* //查看详细信息
    @ResponseBody
    @RequestMapping(value = "/showinfo")
    public Object showinfo(UserInfo userInfo, HttpServletRequest request){
        UserInfo userInfo1 = userInfoService.showInfo(userInfo);
        request.setAttribute("user",userInfo1);
        return "/userView.jsp";
    }*/

   //修改1

    @ResponseBody
    @RequestMapping(value = "/updateboolean")
    public void updateboolean(Integer id,HttpSession session){
        System.out.println(id+"-->");
        //session.setAttribute("id",id);//保存修改的id
        UserInfo userInfo = userInfoService.showInfo(id);
        session.setAttribute("user",userInfo);//保存修改的实体
    }




    //修改2
    @ResponseBody
    @RequestMapping(value = "/updateInfo")
    public ModelAndView updateInfois(UserInfo userInfo, HttpSession session,ModelAndView modelAndView){
           UserInfo user = (UserInfo) session.getAttribute("userinfo");
           System.out.println("的能录的用户id"+user.getId());
           UserInfo u=new UserInfo();
           u.setId(userInfo.getId());
           u.setUserName(userInfo.getUserName());
           u.setGender(userInfo.getGender());
           u.setBirthday(userInfo.getBirthday());
           u.setPhone(userInfo.getPhone());
           u.setAddress(userInfo.getAddress());
           u.setUserType(userInfo.getUserType());
           u.setModifyBy(user.getId());
           u.setModifyDate(new Date());
        boolean b = userInfoService.updateUserInfo(u);
         modelAndView.setViewName("/userList.jsp");
        return modelAndView;
    }
}



