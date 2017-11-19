package cn.smbms.util;

import cn.smbms.entity.UserInfo;

import java.util.List;

/**
 * Created by LY on 2017/11/10.
 */
public class PageUtil {
    //1.当前页
    private Integer pageIndex;
    //2.当前页的记录
    private Integer pageSize;
    //3.总记录数
    private Integer totalRecords;
    //4.总页数
    private Integer totalPages;
    //5.总记录数
    private List<UserInfo> totalList;

    public Integer getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(Integer pageIndex) {
        this.pageIndex = pageIndex;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getTotalRecords() {
        return totalRecords;
    }

    public void setTotalRecords(Integer totalRecords) {
        this.totalRecords = totalRecords;
    }

    public Integer getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(Integer totalPages) {
        this.totalPages = totalPages;
    }

    public List<UserInfo> getTotalList() {
        return totalList;
    }

    public void setTotalList(List<UserInfo> totalList) {
        this.totalList = totalList;
    }
}
