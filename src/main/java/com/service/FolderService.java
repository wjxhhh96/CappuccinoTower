package com.service;

import com.pojo.File;
import com.pojo.Folder;

import java.util.List;

/**
 * Created by WU on 2017/8/29.
 * 对应 Folder 接口
 * [FolderMapper]
 */
public interface FolderService {

    /**
     * 创建一个新的文件夹
     * @param folder 文件夹实体类
     * @return 返回0表示失败，返回1表示成功
     */
    int addFolder(Folder folder,int pId);


    /**
     * 删除一个文件夹
     * @param folderId 根据文件ID删除
     * @return 返回0表示失败，返回1表示成功
     */
    int deleteFolder(int folderId);

    /**
     * 更新一个文件夹
     * @param folder 文件夹实体类
     * @return 返回0表示失败，返回1表示成功
     */
    int updateFolder(Folder folder);

    /***
     * 查询文件夹
     * @param folder 文件夹实体类
     * @param folderId 文件夹id 进行查找
     * @return
     */
    List<Folder> selectFolder(Folder folder,int folderId);

    /**
     * 根据totalid进行查询
     * @param totalid
     * @return
     */
    List<Folder> QueryList(int totalid);

    /**
     * 根据文件夹ID遍历其中的文件
     * @param folderId
     * @return
     */
    public List<File> queryFileByFolderId(int folderId);
}
