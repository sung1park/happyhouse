package com.happyhouse.vue.model.service;

import com.happyhouse.vue.model.FileInfoDto;
import com.happyhouse.vue.model.UserDto;

public interface UserService {
    
    int idCheck(String id) throws Exception;

    boolean registerMember(UserDto userDto) throws Exception;

    UserDto login(UserDto userDto) throws Exception;

    boolean updateUser(UserDto userDto) throws Exception;

    boolean removeUser(String id) throws Exception;

    UserDto mypageUser(String id) throws Exception;
    
    UserDto mypageDong(UserDto userDto) throws Exception;

    UserDto getUserPwd(UserDto userDto) throws Exception;
    
    boolean uploadAuthFile(FileInfoDto fileInfoDto) throws Exception;
    
}
