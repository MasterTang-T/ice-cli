/**
 * @file IceBusiness.ice
 * @brief   
 * @author cxl, www.nazhiai.com, <xiaolong.chen@nazhiai.com>
 * @version 3.20180829
 * @date 2018-08-29
 *
 */
#pragma once


module business
{
    /**
     * @brief 业务接口定义
     */
    interface IBusiness
    {
        /**
         * @brief  LicenseCheck 授权许可检查。
         * @since  V3.20191206
         *
         * @param code 产品代号信息。
            example: 
            {
                "product_code": "1,0",  必填,string,产品代号。
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void LicenseCheck(string code, out string result);

        /**
         * @brief  Login 用户登录。
         * @since  V3.20180922
         * @update V3.20181127 用户权限
         * @update V3.20200508 增加用户所属组织id
         * @update V3.20200713 返回模块授权信息
         *
         * @param login 用户信息。
            example: 
            {
                "username": "n1",           必填,string,登录名。
                "password": "md5 encrypted" 必填,string,MD5加密的密码。
            }
         * @param result 成功或失败。例：
            成功 - 返回对应的结果
            {
                "code": 0,
                "info":
                {
                    "user_id": 3,
                    "username": "xx",
                    "level":0,
                    "role_id":1,
                    "privilege":"",
                    "organ_id":1,
                    "org_id":1,
                    "model_auth_info":{};     // 模块授权信息
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
            for model_auth_info:
            {
                "wechat_push": 1,           int,必填,微信推送, 0: 启用, 1: 关闭
                "visitor_device": 1,        int,必填,访客机管理, 0: 启用, 1: 关闭
                "sigin": 1,                 int,必填,签到, 0: 启用, 1: 关闭
                "welcome": 1,               int,必填,迎宾, 0: 启用, 1: 关闭
                "attendance": 1,            int,必填,考勤, 0: 启用, 1: 关闭
                "retrieve": 1,              int,必填,基础检索, 0: 启用, 1: 关闭
                "super_retrieve": 1,        int,必填,高级检索, 0: 启用, 1: 关闭
            }
         */
        void Login(string login, out string result);

        /**
         * @brief  AddUser 添加用户
         * @since  V3.20180922
         * @update V3.20181227 增加用户级别
         * @update V3.20181227 增加角色id
         * @update V3.20200102 返回用户id
         * @update V3.20200421 增加用户所属机构ID
         * @update V3.20200427 增加用户所管理的地点ID列表
         *
         * @param user 用户信息。
            example: 
            {
                "username": "n1",           必填,string,登录用户，不要包含标点符号或特殊字符。!@#$%^&*([{}])_+|~-=\`;:'",<.>/?
                "password": "md5 encrypted",必填,string,登录密码，MD5加密的密码。
                "operator": "admin",        必填,string,操作者，也是创建者，即当前登录的用户。
                "level":0,                  必填,int,账户级别,1:高级管理员,2:管理员,3:普通用户)
                "role_id":1,                必填,int,用户角色id
                "organ_id":1,               必填,int,用户所属机构id(指组织ID)
                "org_id":1,                 必填,int,用户所属机构id(指组织ID)
                "siteid_list":"xx,xx",      选填,string,用户管理的地点id列表,以","分隔
                "site_list":"xx,xx",        选填,string,用户管理的地点id列表,以","分隔
                "remark": "xxx"             选填,string,备注。
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"user_id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddUser(string user, out string result);

        /**
         * @brief  UpdateUser 更新用户
         * @since  V3.20180922
         * @update V3.20181227 用户级别
         * @update V3.20181227 角色id
         * @update V3.20200421 增加用户所属机构ID
         * @update V3.20200427 增加用户所管理的地点ID列表
         *
         * @param user 用户信息。
            example: 
            {
                "user_id": 3,               必填,int,用户id。
                "username": "xx",           选填,string,用户名。不要包含标点符号或特殊字符。!@#$%^&*([{}])_+|~-=\`;:'",<.>/?
                "password": "md5 encrypted",选填,string,MD5加密的密码，修改密码时使用。
                "old_password": "fsadsda",  选填,string,MD5加密的密码，修改密码时使用，用于验证。
                "level":0,                  选填,int,账户级别,1:高级管理员,2:管理员,3:普通用户)
                "role_id":1,                选填,int,用户角色id
                "organ_id":1,               必填,int,用户所属机构id(指组织ID)
                "org_id":1,                 必填,int,用户所属机构id(指组织ID)
                "siteid_list":"xx,xx",      选填,string,用户管理的地点id列表,以","分隔
                "site_list":"xx,xx",        选填,string,用户管理的地点id列表,以","分隔
                "operator": "admin",        必填,string,操作者，即当前登录的用户。
                "remark": "xxx"             选填,string,备注。
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdateUser(string user, out string result);

        /**
         * @brief  DeleteUser 删除用户
         * @since  V3.20180922
         *
         * @param user 用户信息。
            example: 
            {
                "user_id": 3,           必填,int,用户id。
                "operator": "admin"     必填,string,操作者，即当前登录的用户。
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0} 返回对应的结果
            失败 - 执行失败 {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteUser(string user, out string result);

        /**
         * @brief  QueryUserList 查询用户列表。
         * @since  V3.20180922
         * @update V3.20181227  账户级别
         * @update V3.20181227  角色id
         * @update V3.20200421 增加用户所属机构ID和名称
         * @update V3.20200427 增加用户所管理的地点ID列表
         * @update V3.20200427 增加用户所属的组ID列表
         *
         * @param cond 查询条件。
            example: 
            {
                "page_no": 2,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "username": "xx",   选填,string,用户名
                    "level":0,          选填,int,账户级别,1:高级管理员,2:管理员,3:普通用户)
                    "role_id":1,        选填,int,用户角色id
                }
            }
         * @param result       成功或失败。例：
            成功 - 返回对应的结果
            {
                "code": 0,
                "info": {
                    "page_no": 2,
                    "page_size": 10,
                    "total_count": 32,
                    "items": [
                        {
                            "user_id": 2,
                            "username": "xx",
                            "level":0,
                            "role_id":1,
                            "role_name","solider",
                            "organ_id":1,                   //账号所属组织id
                            "organ_name":"",                //账号所属组织名称
                            "org_id":1,                     //账号所属组织id
                            "organization":"",              //账号所属组织名称
                            "siteid_list":"xx,xx",          //账号可管理的地点id列表
                            "site_list":"xx,xx",            //账号可管理的地点id列表
                            "groupid_list":"xx,xx",         //账号所属组id列表
                            "remark": "cxvx",
                            "creator": "sfd",
                            "create_time": "2018-03-23 00:12:12"
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryUserList(string cond, out string result);

        /**
         * @brief  AddRole 添加角色
         * @since  V1.20181226
         * @update V3.20200102 返回角色id
         *
         * @param role 角色信息
            example:
            {
                "role_name":"soldier",  必填,string,角色
                "privilege":"{}",       必填,json-string,json格式的属性字段
                "organ_id":1,           必填,int,组织id
                "org_id":1,             必填,int,组织id
                "operator": "admin",    必填,string,操作者，也是创建者，即当前登录的用户。
                "remark":""             选填,string,角色备注信息    
            }
                字段【privilege】取值:
                {
                    "library":0,        底库管理权限,0:无权限,1:有权限
                    "person":0,         人员管理权限,0:无权限,1:有权限
                    "group":0,          编组管理权限,0:无权限,1:有权限
                    "camera":0,         摄像头管理权限,0:无权限,1:有权限
                    "task":0,           任务管理权限,0:无权限,1:有权限
                    "user":0,           用户管理权限,0:无权限,1:有权限
                    "access":0,         门禁管理权限,0:无权限,1:有权限
                    "rollcall":0,       人员点名权限,0:无权限,1:有权限
                    "dynamic_control":0,动态布控 权限,0:无权限,1:有权限
                    "group_alarm":0,    联号告警权限,0:无权限,1:有权限
                    "patrol_alarm":0,   巡更告警权限,0:无权限,1:有权限
                    "system_config":0,  系统配置权限,0:无权限,1:有权限
                    "map":0             地图管理权限,0:无权限,1:有权限
                }
        * @param result 成功或失败,例:
            成功 - {"code": 0, "info": {"role_id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void AddRole(string role, out string result);

        /**
         * @brief  UpdateRole 更新角色
         * @since  V1.20181226
         *
         * @param role 角色信息
            example:
            {
                "role_id":1,            必填,int,角色id
                "role_name":"solider",  选填,string,角色
                "privilege":"{}",       选填,json-string,json格式的属性字段
                "organ_id":1,           必填,int,组织id
                "org_id":1,             必填,int,组织id
                "operator":"admin",     必填,string,操作者，即当前登录的用户。
                "remark":"test"         选填,string,备注信息
            }
            字段【privilege】取值:
                {
                    "library":0,        底库管理权限,0:无权限,1:有权限
                    "person":0,         人员管理权限,0:无权限,1:有权限
                    "group":0,          编组管理权限,0:无权限,1:有权限
                    "camera":0,         摄像头管理权限,0:无权限,1:有权限
                    "task":0,           任务管理权限,0:无权限,1:有权限
                    "user":0,           用户管理权限,0:无权限,1:有权限
                    "access":0,         门禁管理权限,0:无权限,1:有权限
                    "rollcall":0,       人员点名权限,0:无权限,1:有权限
                    "dynamic_control":0,动态布控 权限,0:无权限,1:有权限
                    "group_alarm":0,    联号告警权限,0:无权限,1:有权限
                    "patrol_alarm":0,   巡更告警权限,0:无权限,1:有权限
                    "system_config":0,  系统配置权限,0:无权限,1:有权限
                    "map":0             地图管理权限,0:无权限,1:有权限
                }
        * @param result 成功或失败,例:
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}  
        */
        void UpdateRole(string role, out string result);

        /**
         * @brief  DeleteRole 删除角色
         * @since  V1.20181226
         *
         * @param role 角色信息
            example:
            {
                "role_id":1,        必填,int,角色id
                "operator":"admin"  必填,string,操作者，即当前登录的用户。
            }
        * @param result 成功或失败,例:
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}   
        */
        void DeleteRole(string role, out string result);

        /**
         * @brief  QueryRoleList 查询角色列表
         * @since  V1.20181226
         *
         * @param role 角色信息
            example
            {
                "page_no": 1,           必填,int,页号
                "page_size": 10,        必填,int,每页个数
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "role_name":"solider",   选填,string,角色
                    "organid_list":""        选填,string,组织id列表
                }
            }
        * @param result 成功或失败,例:
            成功 - 返回对应的结果
            {
                "code":0,
                "info":
                {
                    "page_no":1,
                    "page_size":10,
                    "total_count":20,
                    "items":[
                        {
                            "role_id":1,
                            "role_name":"solider",
                            "privilege":"",
                            "organ_id":1,
                            "organ_name":"",
                            "org_id":1,
                            "organization":"",
                            "user_list","user1,user2"
                            "creator":"admin",
                            "create_time":"2018-12-26 15:08:00",
                            "remark":""
                        }
                    ]
                }
            }
        */
        void QueryRoleList(string role, out string result);


        /**
        -----------------------------------------------------------------------
         组织机构信息管理
        -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddOrganization 添加机构
         * @since  V3.20200508
         *
         * @param organinfo 机构信息
            example:
            {
                "operator": "admin"     必填,string,操作者，也是创建者，即当前登录的用户。
                "organ_name":"xxx",     必填,string,机构名称
                "attribute":"{}",       选填,json-string,json格式的属性字段 备用
            }
                字段【attribute】取值:
                {
                }
        * @param result 成功或失败,例:
            成功 - {"code": 0, "info": {"organ_id": 1, "org_id":1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void AddOrganization(string organinfo, out string result);

        /**
         * @brief  UpdateOrganization 更新机构
         * @since  V3.20200508
         *
         * @param organinfo 机构信息
            example:
            {
                "operator":"admin"      必填,string,操作者，即当前登录的用户
                "organ_id":1,           必填,int,机构id
                "org_id":1,             必填,int,机构id
                "organ_name":"xxx",     选填,string,机构名称
                "organization":"xxx",   选填,string,机构名称
                "attribute":"{}",       选填,json-string,json格式的属性字段 备用
            }
                字段【attribute】取值:
                {
                }
        * @param result 成功或失败,例:
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}  
        */
        void UpdateOrganization(string organinfo, out string result);
        
        /**
         * @brief  EnableOrganization 使能组织机构
         * @since  V3.20200508
         *
         * @param organinfo 机构信息
            example: 
            {
                "organ_id": 1,      必填, int, 机构id
                "org_id": 1,        必填, int, 机构id
                "enabled": true,    必填, bool,使能状态,false:停用,true:启用
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void EnableOrganization(string organinfo, out string result);

        /**
         * @brief  DeleteOrganization 删除机构
         * @since  V3.20200508
         *
         * @param organinfo 机构信息
            example:
            {
                "operator":"admin"  必填,string,操作者，即当前登录的用户。
                "organ_id":1,       必填,int,机构id
                "org_id":1,         必填,int,机构id
            }
        * @param result 成功或失败,例:
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}   
        */
        void DeleteOrganization(string role, out string result);

        /**
         * @brief  QueryOrganizationList 查询机构信息列表
         * @since  V3.20200508
         *
         * @param organinfo 机构信息查询条件
            example
            {
                "page_no": 1,           必填,int,页号
                "page_size": 10,        必填,int,每页个数
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "organ_id":xxx,       选填,string,机构id
                    "organ_name":"xxx",   选填,string,机构名称,支持模糊匹配查询
                    "org_id":xxx,         选填,string,机构id
                    "organization":"xxx", 选填,string,机构名称,支持模糊匹配查询
                }
            }
        * @param result 成功或失败,例:
            成功 - 返回对应的结果
            {
                "code":0,
                "info":
                {
                    "page_no":1,
                    "page_size":10,
                    "total_count":20,
                    "items":[
                        {
                            "organ_id":0,               //机构id
                            "organ_name":"xxx",         //机构名称
                            "org_id":0,                 //机构id
                            "organization":"xxx",       //机构名称
                            "site_count" : 100,         //下属地点总数
                            "enabled": true,            //使能状态,false:停用,true:启用
                            "attribute":"{}",           //json-string,json格式的属性字段 备用
                            "creator":"admin",
                            "create_time":"YYYY-mm-dd HH:MI:SS",
                            "site_list": [ {"id": 1, "name": "xx"} ]   //地点列表,[{id,name},...]
                        }
                    ]
                }
            }
        */
        void QueryOrganizationList(string organinfo, out string result);

        /**
         * @brief  UpdateOrganAuthorization 更新组织授权信息
         * @since  V3.20200604
         *
         * @param auth 授权信息
            example
            {
                "id": 1,                必填,int,记录id
                "auth_camera": 1,       选填,int,摄像头授权数,-1:表示不限制,以系统授权数作为限制
                "auth_face_device": 1,  选填,int,智能门禁授权数,-1:表示不限制,以系统授权数作为限制
                "remark": "",           选填,string,备注信息
            }
        * @param result 成功或失败,例:
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void UpdateOrganAuthorization(string role, out string result);

        /**
         * @brief  QueryOrganAuthorizationList 查询组织授权信息列表
         * @since  V3.20200604
         * @update V3.20200713 返回系统授权信息
         *
         * @param cond 组织授权信息查询条件
            example
            {
                "page_no": 1,           必填,int,页号
                "page_size": 10,        必填,int,每页个数
                "org_id": 1,            选填,组织id
                "query_cond": {
                    "name":"xxx",       选填,string,组织名,模糊匹配
                }
            }
        * @param result 成功或失败,例:
            成功 - 返回对应的结果
            {
                "code":0,
                "info":
                {
                    "page_no": 1,
                    "page_size": 10,
                    "total_count": 20,
                    "others": {
                        "auth_camera": 1,                   // 摄像头授权数,-1表示不限制,以系统授权数作为限制
                        "auth_camera_used": 1,              // 已绑定摄像头
                        "auth_face_device": 1,              // 智能门禁授权数,-1:表示不限制,以系统授权数作为限制
                        "auth_face_device_used": 1,         // 已绑定智能门禁设备
                        "auth_feature": 1,                  // 授权特征值,-1:表示不限制,以系统授权数作为限制
                        "auth_feature_used": 1,             // 已使用特征值
                    },
                    "items":[
                        {
                            "id": 1,                        // 记录id
                            "org_id":0,                     // 组织id
                            "organization":"xxx",           // 组织名
                            "auth_camera": 1,               // 摄像头授权数,-1表示不限制,以系统授权数作为限制
                            "auth_camera_used": 1,          // 已绑定摄像头
                            "auth_face_device": 1,          // 智能门禁授权数,-1:表示不限制,以系统授权数作为限制
                            "auth_face_device_used": 1,     // 已绑定门禁
                            "auth_feature": 1,              // 授权特征值
                            "auth_feature_used": 1,         // 已使用特征值
                            "remark": "",                   // 备注信息
                            "create_time": "",              // 创建时间
                        }
                    ]
                }
            }
        */
        void QueryOrganAuthorizationList(string cond, out string result);

        /**
        -----------------------------------------------------------------------
         地点信息管理
        -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddSite 添加地点信息
         * @since  V3.20200508
         *
         * @param siteinfo 地点信息
            example:
            {
                "operator": "admin"     必填,string,操作者，也是创建者，即当前登录的用户。
                "organ_id":xxx,         必填,int,所属组织ID
                "org_id":xxx,           必填,int,所属组织ID
                "site_name":"xxx",      必填,string,地点名称
                "attribute":"{}",       选填,json-string,json格式的属性字段 备用
            }
                字段【attribute】取值:
                {
                }
        * @param result 成功或失败,例:
            成功 - {"code": 0, "info": {"site_id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void AddSite(string siteinfo, out string result);

        /**
         * @brief  UpdateSite 更新地点
         * @since  V3.20200508
         *
         * @param siteinfo 地点信息
            example:
            {
                "operator":"admin"      必填,string,操作者，即当前登录的用户
                "site_id":1,            必填,int,地点id
                "site_name":"xxx",      选填,string,地点名称
                "sitename":"xxx",      选填,string,地点名称
                "attribute":"{}",       选填,json-string,json格式的属性字段 备用
                
            }
                字段【attribute】取值:
                {
                }
        * @param result 成功或失败,例:
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}  
        */
        void UpdateSite(string siteinfo, out string result);
        
        /**
         * @brief  EnableSite 使能地点
         * @since  V3.20200508
         *
         * @param siteinfo 地点信息
            example: 
            {
                "site_id":1,        必填, int, 地点id
                "enabled": true,    必填, bool,使能状态,false:停用,true:启用
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void EnableSite(string siteinfo, out string result);

        /**
         * @brief  DeleteSite 删除地点
         * @since  V3.20200508
         *
         * @param siteinfo 地点信息
            example:
            {
                "operator":"admin"      必填,string,操作者，即当前登录的用户
                "site_id":1,            必填,int,地点id
            }
        * @param result 成功或失败,例:
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}   
        */
        void DeleteSite(string siteinfo, out string result);

        /**
         * @brief  QuerySiteList 查询地点信息列表
         * @since  V3.20200508
         *
         * @param siteinfo 地点信息查询条件
            example
            {
                "page_no": 1,           必填,int,页号
                "page_size": 10,        必填,int,每页个数
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "organ_id":xxx,       选填,int,机构id
                    "organ_name":"xxx",   选填,string,机构名称,支持模糊匹配查询
                    "site_id":xxx,        选填,int,地点id
                    "site_name":"xxx",    选填,string,地点名称,支持模糊匹配查询
                    "org_id":xxx,         选填,int,机构id
                    "organization":"xxx", 选填,string,机构名称,支持模糊匹配查询
                    "sitename":"xxx",     选填,string,地点名称,支持模糊匹配查询
                }
            }
        * @param result 成功或失败,例:
            成功 - 返回对应的结果
            {
                "code":0,
                "info":
                {
                    "page_no":1,
                    "page_size":10,
                    "total_count":20,
                    "items":[
                        {
                            "site_id":xxx,              //地点id
                            "site_name":"xxx",          //地点名称
                            "sitename":"xxx",           //地点名称
                            "organ_id":0,               //机构id
                            "org_id":0,                 //机构id
                            "organ_name":"xxx",         //机构名称
                            "organizaiton":"xxx",       //机构名称
                            "enabled": true,            //使能状态,false:停用,true:启用
                            "attribute":"{}",           //json-string,json格式的属性字段 备用
                            "creator":"admin",
                            "create_time":"YYYY-mm-dd HH:MI:SS"
                        }
                    ]
                }
            }
        */
        void QuerySiteList(string siteinfo, out string result);
        
        /**
         -----------------------------------------------------------------------
         权限分组管理
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddPermissionGroup 添加权限分组
         * @since  V3.20200427
         * @update V3.20200527
         *
         * @param group 小组信息
            example:
            {
                "group_name": "",    必填,string,组名称
                "userid_list": "",   必填,string,包含用户id列表,id之间以逗号分隔
                "site_list": "",     必填,string,可访问地点id列表,id之间以逗号分隔
                "operator": "admin", 必填,string,操作者，也是创建者，即当前登录的用户
                "org_id": 0,         必填,int,组织id
                "remark": ""         选填,string,备注
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"group_id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddPermissionGroup(string group, out string result);

        /**
         * @brief  RemovePermissionGroup 删除权限分组
         * @since  V3.20200427
         *
         * @param group 小组信息
            example:
            {
                "group_id":xx        必填,int,小组id
                "operator": "admin"  必填,string,操作者，也是创建者，即当前登录的用户。
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void RemovePermissionGroup(string group, out string result);

        /**
         * @brief  UpdatePermissionGroup 更新权限分组信息
         * @since  V3.20200427
         * @update V3.20200527
         *
         * @param group 小组信息
            example:
            {
                "group_id" : xx,     必填,int,组id
                "group_name": "",    选填,string,组名称
                "userid_list": "",   选填,string,包含用户id列表,id之间以逗号分隔 如果为空,则不更新,如果为"NULL" 则认为清空id列表
                "site_list": "",     选填,string,可访问地点id列表,id之间以逗号分隔 如果为空,则不更新,如果为"NULL" 则认为清空id列表
                "org_id": 0,         必填,int,组织id
                "operator": "admin", 必填,string,操作者，也是创建者，即当前登录的用户。
                "remark": ""         选填,string,备注
                
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdatePermissionGroup(string group, out string result);
        
        /**
         * @brief  QueryPermissionGroupList 查询权限分组信息列表
         * @since  V3.20200427
         * @update V3.20200527
         *
         * @param group 权限分组信息查询条件
            example
            {
                "page_no": 1,           必填,int,页号
                "page_size": 10,        必填,int,每页个数
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "group_id":xxx,       选填,string,分组id
                    "group_name":"xxx",   选填,string,权限组名称,支持模糊匹配查询
                    "org_id" : 0          选填, int, 所属组织id
                }
            }
        * @param result 成功或失败,例:
            成功 - 返回对应的结果
            {
                "code":0,
                "info":
                {
                    "page_no":1,
                    "page_size":10,
                    "total_count":20,
                    "items":[
                        {
                            "group_id":0,               //分组id
                            "group_name":"xxx",         //组名称
                            "userid_list": "",          //包含用户id列表,id之间以逗号分隔
                            "username_list": "",        //包含用户名列表,以逗号分隔
                            "org_id" : 0,               //所属组织id
                            "orgnization": "",          //所属组织名称
                            "site_list": "",            //可访问地点id列表,id之间以逗号分隔
                            "sitename_list":"",         //可访问地点名称列表,以逗号分隔
                            "creator":"admin",
                            "create_time":"YYYY-mm-dd HH:MI:SS"
                        },
                        ...
                    ]
                }
            }
        */
        void QueryPermissionGroupList(string group, out string result);
        /**
        -----------------------------------------------------------------------
        底库管理
        -----------------------------------------------------------------------
        **/

        /**
         * @brief  AddLibrary 添加底库
         * @since  V3.20180922
         * @update V3.20181018
         * @update V3.20190308 增加VIP底库类型
         * @update V3.20200102 返回底库id
         * @update V3.20200324 增加专用底库标识
         * @update V3.20200429 增加底库所属地点id列表
         *
         * @param lib 底库信息
            example: 
            {
                "name": "",         必填,string,人员库名称
                "type": 1,          选填,int,人员类型,参见《PersonType》
                "special": 0,       选填,int,专用底库标识,0:正常底库,1:AIOT专用底库
                "remark": "",       选填,string,人员库备注
                "operator": "",     必填,string,操作者，也是创建者，即当前登录用户名
                "siteid_list":""    必填,string,底库所属地点id列表
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"lib_id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddLibrary(string lib, out string result);

        /**
         * @brief  EnableLibrary 使能底库
         * @since  V3.20190308
         *
         * @param lib 底库信息
            example: 
            {
                "lib_id": 1,        必填,库id
                "enabled": true,    必填,使能状态,false:停用,true:启用
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void EnableLibrary(string lib, out string result);

        /**
         * @brief  DeleteLibrary 删除底库
         * @since  V3.20180922
         *
         * @param lib 底库信息
            example: 
            {
                "lib_id": 1     必填,int,人员库id
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteLibrary(string lib, out string result);

        /**
         * @brief  BatchDeleteLibrary 批量删除底库
         * @since  V3.20180922
         *
         * @param batch 批量删除参数
            example: 
            {
                "lib_list": "1,2,3,4",      必填,string,以逗号分隔的底库id列表。
                "operator": "admin"         选填,string,操作者，即当前登录用户名
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchDeleteLibrary(string batch, out string result);

        /**
         * @brief  QueryLibraryInfo 获取底库信息
         * @since  V3.20180922
         * @update V3.20181018
         * @update V3.20190308 增加VIP底库类型及使能状态
         * @update V3.20200324 增加专用底库标识
         *
         * @param cond 库信息
            example: 
            {
                "lib_id": 1     必填,int,人员库id
            }
         * @param result 成功或失败。例：
            成功 - 返回对应的结果
            {
                "code": 0, 
                "info": 
                {
                    "lib_id": 1,        库id
                    "lib_name": "",     库名
                    "type": 1,          人员类型,参见《PersonType》
                    "remark": "",       备注
                    "enabled": true,    使能状态,false:停用,true:启用
                    "special": 0,       专用底库标识,0:正常底库,1:AIOT专用底库
                    "creator": "",      创建者
                    "create_time": "",  创建时间
                    "person_count": 100 人数
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryLibraryInfo(string cond, out string result);

        /**
         * @brief  QueryLibraryList 获取底库列表
         * @since  V3.20180922
         * @update V3.20181018
         * @update V3.20190308 增加VIP底库类型及使能状态
         * @update V3.20200324 增加专用底库标识
         * @update V3.20200429 输出值增加组织/地点信息
         *
         * @param cond 库信息
            example: 
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "name":"",      选填,string,底库名,支持模糊匹配
                    "type": 1,      选填,int,人员类型,参见《PersonType》
                    "enabled": 1,   选填,int,使能状态,0:停用,1:启用
                    "special": 0,   选填,int,专用底库标识,0正常底库,1:AIOT底库
                    "site_list":""  选填,String,底库所属地点id列表
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应的结果
            {
                "code": 0, 
                "info": {
                    "page_no": 1, 页号
                    "page_size": 10, 每页个数
                    "items": [
                        {
                            "lib_id": 1,        库id
                            "lib_name": "",     库名
                            "type": 1,          人员类型,参见《PersonType》
                            "remark": "",       备注
                            "enabled": true,    使能状态,false:停用,true:启用
                            "special": 0,       专用底库标识,0:正常底库,1:AIOT专用底库
                            "creator": "",      创建者
                            "create_time": "",  创建时间
                            "person_count": 100,人数
                            "organid_list",     底库所属组织id列表
                            "organid_name",     底库所属组织名称列表
                            "siteid_list",      底库所属地点id列表
                            "siteid_name"       底库所属地点名称列表
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryLibraryList(string cond, out string result);

        /**
         * @brief  AddCredentialType 添加证件类型
         * @since  V3.20181205
         * @update V3.20200102 返回序号
         *
         * @param type 证件类型信息
            example: 
            {
                "name": "",         必填,string,证件类型名称
                "operator": ""      选填,string,操作者，即当前登录用户名
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddCredentialType(string type, out string result);

        /**
         * @brief  UpdateCredentialType 更新证件类型
         * @since  V3.20181205
         *
         * @param type 人员类别信息
            example: 
            {
                "id": 1,            必填,int,类型id
                "name": "",         必填,string,类型名称
                "operator": ""      选填,string,操作者，即当前登录用户名
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdateCredentialType(string type, out string result);

        /**
         * @brief  DeleteCredentialType 删除证件类型
         * @since  V3.20181205
         *
         * @param type 证件类型信息
            example: 
            {
                "id": 5,            必填,int,类型id
                "operator": ""      选填,string,操作者，即当前登录用户名
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteCredentialType(string type, out string result);

        /**
         * @brief  QueryCredentialType 查询证件类型
         * @since  V3.20181205
         *
         * @param cond 搜索相关信息
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "id": 1,        选填,int,证件类型id
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "page_no":xx,
                    "page_size":xx,
                    "total_count":xx,
                    "items": [
                        {
                            "id": 1, int,证件类型id
                            "name": "", string,证件类型名称
                            "creator": "", string,创建者
                            "create_time": "", string, 创建时间
                        }, ...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryCredentialType(string cond, out string result);

        /**
         -----------------------------------------------------------------------
         人员管理
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddPeople 添加人员入库
         * @since  V3.20190603
         * @update V3.20200102 返回人员id
         *
         * @param person 人员信息
            example: 
            {
                "lib_id": 1 ,       必填,int,人员库id
                "pic_list": "",     必填,string,图片路径列表,第一张图片为默认显示图片,以英文逗号分隔
                "name": "",         必填,string,人员名字
                "category": 0,      必填,int,人员类别,0:未分类,详情参见《人员类别》接口
                "english_name": "", 选填,string,英文名
                "gender": 1,        选填,int,性别（0:未知,1:男,2:女）,默认0
                "age": 20,          选填,int,年龄
                "nation": 0,        选填,int,民族Id,见数据库表
                "birthday": "",     选填,string,生日
                "credential_type":0,选填,int,证件类型（0:未知,1:身份证,2:护照,3:港澳通行证）,默认0
                "credential_no": "",选填,string,证件号
                "phone": "",        选填,string,电话
                "mobile": "",       选填,string,手机
                "email": "",        选填,string,E-Mail地址
                "address": "",      选填,string,通讯地址
                "group": 2,         选填,int,黑白名单,参见<Whitelist>,默认值2
                "speech": "",       选填,string,迎宾语
                "area_list": "",    选填,string,区域id列表,id之前以英文逗号分隔
                "remark": "",       选填,string,备注
                "property": {},     选填,json-object,人员属性
                "operator": "",     选填,string,管理者
            }
            字段property定义详情如下：
            for 员工
            {
                "rule_id": 1,       必填,int,考勤规则id
                "dept_id": 1,       选填,int,部门id
                "position": "",     选填,string,职位
                "empno": "",        选填,string,工号
                "hiredate": "",     选填,string,入职时间
            }
            for VIP
            {
                "company": "",      选填,string,公司名称
                "department":"",    选填,string,部门
                "position": "",     选填,string,职位
                "vip_level": "",    选填,string,VIP等级
                "receiver_id": 1,   选填,int,接待人id
            }
            for 访客
            {
                "company": "",      选填,string,所在单位
                "purpose": "",      选填,string,来访目的
                "interviewee_id": 0,选填,int,受访人id
                "start_time": "",   选填,string,有效时间-开始时间
                "end_time": "",     选填,string,有效时间-结束时间
            }
            for 警察
            {
                "department": "",   选填,string,部门
                "position": "",     选填,string,职位
                "police_no": "",    选填,string,警号
            }
            for 囚犯
            {
                "prisoner_no": "",  选填,string,囚犯编号
            }
            for 业主
            {
                "room_no": "",      选填,string,房号
            }
            for 外来人员
            {
                "company": "",      选填,string,工作单位
                "position": "",     选填,string,职位
            }
            for 戒毒人员
            {
                "watch_no": "",     选填,string,看管编号
                "company": "",      选填,string,工作单位
                "emergency_contact": "",    选填,string,紧急联系人
                "emergency_phone": "",      选填,string,紧急联系人电话
            }
            for 探视人员
            {
                "company": "",      选填,string,工作单位
                "target": "",       选填,string,探视对象
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"person_id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddPeople(string person, out string result);

        /**
         * @brief  UpdatePeople 更新人员信息
         * @since  V3.20190603
         *
         * @param person 人员信息
            example: 
            {
                "lib_id": 1 ,       必填,int,人员库id
                "person_id": 1 ,    必填,int,人员id
                "pic_id": 1,        必填,int,默认显示图片id
                "name": "",         必填,string,人员名字
                "category": 0,      必填,int,人员类别,0:未分类,详情参见《人员类别》接口
                "english_name": "", 选填,string,英文名
                "gender": 1,        选填,int,性别（0:未知,1:男,2:女）,默认0
                "age": 20,          选填,int,年龄
                "nation": 0,        选填,int,民族Id,见数据库表
                "birthday": "",     选填,string,生日
                "credential_type":0,选填,int,证件类型（0:未知,1:身份证,2:护照,3:港澳通行证）,默认0
                "credential_no": "",选填,string,证件号
                "phone": "",        选填,string,电话
                "mobile": "",       选填,string,手机
                "email": "",        选填,string,E-Mail地址
                "address": "",      选填,string,通讯地址
                "group": 2,         选填,int,黑白名单,参见<Whitelist>,默认值2
                "speech": "",       选填,string,迎宾语
                "area_list": "",    选填,string,区域id列表,id之前以英文逗号分隔
                "property": {},     选填,json,人员属性
                "operator": "",     选填,string,管理者
            }
            字段property定义详情参见<AddPeople>
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdatePeople(string person, out string result);

        /**
         * @brief  BatchUpdatePeople 批量修改人员信息
         * @since  V3.20190308
         *
         * @param person 人员信息
            {
                "category": 0,          必填,int,人员类别,0:未分类,详情参见《人员类别》接口
                "person_list": "1,2",   必填,string,人员id列表
                "modify": {}            必填,json-object,修改信息
            }
            字段info定义详情如下
            for 员工
            {
                "dept_id": 1,           选填,int,部门id
                "area_list": "",        选填,string,区域id列表
            }
            for VIP
            {
                "receiver_id": 1,       选填,int,接待人id
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchUpdatePeople(string person, out string result);

        /**
         * @brief  DeletePeople 删除人员信息
         * @since  V3.20180922
         *
         * @param person 人员信息
            example: 
            {
                "lib_id": 5,    必填,int,底库id
                "person_id":xx, 必填,int,人员id
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeletePeople(string person, out string result);

        /**
         * @brief  BatchDeletePeople 批量删除人员信息。
         * @since  V3.20180922
         *
         * @param batch 批量删除参数
            example: 
            {
                "lib_id": 5,                必填,int,底库id
                "person_list": "1,2,3"      必填,string,人员id列表
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchDeletePeople(string batch, out string result);

        /**
         * @brief  QueryPeopleInfo 获取人员信息。
         * @since  V3.20190603
         *
         * @param cond 搜索相关信息
            example:
            {
                "lib_id":xx,    必填,int,底库id
                "person_id":xx, 必填,int,人员id
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "person_id": 1, int,人员id
                    "pic_id": 1, int, 默认显示图片id
                    "lib_id": 1, int,人员库id
                    "lib_name": "", string,人员库名
                    "name": "", string,人员名字
                    "english_name": "", string,英文名
                    "gender": 1, int,性别（0:未知,1:男,2:女）
                    "age": 20, int,年龄
                    "nation": 0, int,名族Id,太长见数据库表
                    "birthday": "", string,生日
                    "credential_type": 0, int,证件类型（0:未知,1:身份证,2:护照,3:港澳通行证）
                    "credential_no": "", string,证件号
                    "phone": "", string,电话
                    "mobile": "", string,手机
                    "email": "", string,E-Mail地址
                    "address": "", string,通讯地址
                    "group": 2, int,黑白名单,参见<Whitelist>
                    "category": 0, int,人员类别,0:未分类,详情参见《人员类别》接口
                    "speech": "", string,迎宾语
                    "area_list": [{"id":1, "name":"xx"}], json,区域列表（华信项目：楼层列表）
                    "pic_list": [{"pic_id":1, "pic_url":"xx"}], json-array,人员图片列表
                    "learn_pics": [{"pic_id":1, "pic_url":"xx"}], json-array,自学习图片列表
                    "property": {}, json-object,人员属性
                    "update_time": "xxxx", string,更新时间,例：2017-03-02 20:02:02
                }
            }
            字段property定义详情如下：
            for 员工
            {
                "company": "",      string,公司名称
                "dept_id": 1,       int,部门id
                "department": "",   string,部门名称
                "position": "",     string,职位
                "empno": "",        string,工号
                "hiredate": "",     string,入职时间
                "rule_id": 1,       string,考勤规则id
                "rule_name": ""     string,考勤规则名称
            }
            for VIP
            {
                "company": "",      string,公司
                "department":"",    string,部门
                "position": "",     string,职位
                "vip_level": "",    string,VIP等级
                "receive_department": "", string,对接部门
                "receiver_id": 1,   int,接待人id
                "receiver_name": "",string,接待人姓名
            }
            for 访客
            {
                "company": "",              string,所在单位
                "purpose": "",              string,来访目的
                "interviewed_company": "xx",    string,受访公司
                "interviewed_department": "xx", string,受访部门
                "interviewee_id": 0,        int,受访人id
                "interviewee_name": "",     string,受访人姓名
                "interviewee_phone": "",    string,受访人电话
                "start_time": "",           string,有效时间-开始时间
                "end_time": "",             string,有效时间-结束时间
            }
            for 警察
            {
                "department": "",   string,部门
                "position": "",     string,职位
                "police_no": "",    string,警号
            }
            for 囚犯
            {
                "prisoner_no": "",  string,囚犯编号
            }
            for 业主
            {
                "room_no": "",      string,房号
            }
            for 外来人员
            {
                "company": "",      string,工作单位
                "position": "",     string,职位
            }
            for 戒毒人员
            {
                "watch_no": "",         string,看管编号
                "company": "",          string,工作单位
                "emergency_contact": "",string,紧急联系人
                "emergency_phone": "",  string,紧急联系人电话
            }
            for 探视人员
            {
                "company": "",      string,工作单位
                "target": "",       string,探视对象
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryPeopleInfo(string cond, out string result);

        /**
         * @brief  QueryPeopleList 获取人员列表。
         * @since  V3.20190616
         *
         * @param cond 搜索相关信息
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "category": 1,      必填,int,人员类别,参见<PersonType>
                    "lib_id": 1,        选填,int,底库id,默认查询有所人员
                    "name": "",         选填,string,人员姓名,支持模糊查询
                    "english_name": "", 选填,string,英文名,支持模糊查询,【与name是或的关系】
                    "credential_no": "",选填,string,证件号筛选条件,支持精确查询
                    "phone": "",        选填,string,手机号,支持精确查询
                    "dept_id": 1,       选填,int,部门id
                    "begin_time": "",   选填,string,添加的开始时间
                    "end_time": "",     选填,string,添加的结束时间
                    "company": "",      选填,string,单位
                    "police_no": "",    选填,string,警号
                    "target": "",       选填,string,探视对象
                }
            }
            字段query_cond定义详情如下：
            for 员工
            {
                "category": 1,      必填,int,人员类别,参见<PersonType>
                "lib_id": 1,        选填,int,底库id,默认查询有所人员
                "name": "",         选填,string,人员姓名,支持模糊查询
                "english_name": "", 选填,string,英文名,支持模糊查询,【与name是或的关系】
                "credential_no": "",选填,string,证件号筛选条件,支持精确查询
                "phone": "",        选填,string,手机号,支持精确查询
                "dept_id": 1,       选填,int,部门id
                "rule_id": 1,       string,考勤规则id
                "rule_name": ""     string,考勤规则名称
            }
            for VIP
            {
                "category": 2,      必填,int,人员类别,参见<PersonType>
                "lib_id": 1,        选填,int,底库id,默认查询有所人员
                "name": "",         选填,string,人员姓名,支持模糊查询
                "vip_level": "",    选填,string,VIP等级
                "company": "",      选填,string,单位
                "dept_id": 1,       选填,int,接待部门id
                "receiver": "",     选填,string,对接人,支持精确查询
            }
            for 访客
            {
                "category": 3,      必填,int,人员类别,参见<PersonType>
                "lib_id": 1,        选填,int,底库id,默认查询有所人员
                "name": "",         选填,string,人员姓名,支持模糊查询
                "credential_no": "",选填,string,证件号筛选条件,支持精确查询
                "dept_id": 1,       选填,int,受访部门id
                "begin_time": "",   选填,string,添加的开始时间
                "end_time": "",     选填,string,添加的结束时间
            }
            for 警察
            {
                "category": 4,      必填,int,人员类别,参见<PersonType>
                "lib_id": 1,        选填,int,底库id,默认查询有所人员
                "name": "",         选填,string,人员姓名,支持模糊查询
                "credential_no": "",选填,string,证件号筛选条件,支持精确查询
                "police_no": "",    选填,string,警号
            }
            for 囚犯
            {
                "category": 5,      必填,int,人员类别,参见<PersonType>
                "prisoner_no": "",  选填,string,囚犯编号
            }
            for 业主
            {
                "category": 6,      必填,int,人员类别,参见<PersonType>
                "lib_id": 1,        选填,int,底库id,默认查询有所人员
                "name": "",         选填,string,人员姓名,支持模糊查询
                "credential_no": "",选填,string,证件号筛选条件,支持精确查询
            }
            for 外来人员
            {
                "category": 7,      必填,int,人员类别,参见<PersonType>
                "lib_id": 1,        选填,int,底库id,默认查询有所人员
                "name": "",         选填,string,人员姓名,支持模糊查询
                "credential_no": "",选填,string,证件号筛选条件,支持精确查询
                "phone": "",        选填,string,手机号,支持精确查询
                "company": "",      选填,string,单位
            }
            for 戒毒人员
            {
                "category": 8,      必填,int,人员类别,参见<PersonType>
                "lib_id": 1,        选填,int,底库id,默认查询有所人员
                "name": "",         选填,string,人员姓名,支持模糊查询
                "credential_no": "",选填,string,证件号筛选条件,支持精确查询
            }
            for 探视人员
            {
                "category": 9,      必填,int,人员类别,参见<PersonType>
                "lib_id": 1,        选填,int,底库id,默认查询有所人员
                "name": "",         选填,string,人员姓名,支持模糊查询
                "credential_no": "",选填,string,证件号筛选条件,支持精确查询
                "phone": "",        选填,string,手机号,支持精确查询
                "target": "",       选填,string,探视对象
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "page_no":1,
                    "page_size":10,
                    "total_count":100,
                    "items":[
                        {
                            "person_id": 1, int,人员id
                            "pic_id": 1, int, 默认显示图片id
                            "pic_url": "", string, 默认显示图片url
                            "lib_id": 1, int,人员库id
                            "lib_name": "", string,人员库名
                            "name": "", string,人员名字
                            "english_name": "", string,英文名
                            "gender": 1, int,性别（0:未知,1:男,2:女）
                            "age": 20, int,年龄
                            "nation": 0, int,名族Id,太长见数据库表
                            "birthday": "", string,生日
                            "credential_type": 0, int,证件类型（0:未知,1:身份证,2:护照,3:港澳通行证）
                            "credential_no": "", string,证件号
                            "phone": "", string,电话
                            "mobile": "", string,手机
                            "email": "", string,E-Mail地址
                            "address": "", string,通讯地址
                            "group": 2, int,黑白名单,参见<Whitelist>
                            "category": 0, int,人员类别,0:未分类,详情参见《人员类别》接口
                            "speech": "", string,迎宾语
                            "area_list": [{"id":1, "name":"xx"}], json,区域列表（华信项目：楼层列表）
                            "property": {}, json-object,人员属性
                            "update_time": "xxxx", string,更新时间,例：2017-03-02 20:02:02
                        },...
                    ]
                }
            }
            字段property定义详情参见<QueryPeopleInfo>
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryPeopleList(string cond, out string result);

        /**
         * @brief  AddPicture 添加人员图片
         * @since  V3.20190603
         * @update V3.20200102 返回图片id
         *
         * @param pic 人员图片信息
            example: 
            {
                "person_id": 1 ,    必填,int,人员id
                "pic_path": "",     必填,string,图片路径
                "pic_type": 0,      选填,int,图片类型,0:人脸库图片,1:自学习图片,默认0
                "operator": "",     选填,string,管理者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"pic_id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddPicture(string pic, out string result);

        /**
         * @brief  DeletePicture 删除人员图片
         * @since  V3.20190603
         *
         * @param pic 人员图片信息
            example: 
            {
                "person_id": 1 ,    必填,int,人员id
                "pic_id": 1 ,       必填,int,图片id
                "operator": "",     选填,string,管理者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeletePicture(string pic, out string result);

        /**
         * @brief  SetDefaultPicture 设置默认图片
         * @since  V3.20190604
         *
         * @param pic 人员图片信息
            example: 
            {
                "person_id": 1 ,    必填,int,人员id
                "pic_id": 1 ,       必填,int,图片id
                "operator": "",     选填,string,管理者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void SetDefaultPicture(string pic, out string result);

        /**
         * @brief  BatchSetWhiteList 批量设置黑白名单
         * @since  V3.20190521
         *
         * @param persons 人员信息
            {
                "lib_id": 5,            必填,int,底库id
                "person_list": "1,2",   必填,string,人员id列表
                "group": 2,             必填,int,黑白名单,参见<Whitelist>
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchSetWhiteList(string persons, out string result);

        /**
         * @brief  BatchSetWhiteListByLib 批量设置黑白名单
         * @since  V3.20190521
         *
         * @param libs 人员信息
            {
                "lib_list": "1,2",      必填,string,底库id列表
                "group": 2,             必填,int,黑白名单,参见<Whitelist>
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchSetWhiteListByLib(string libs, out string result);

        /**
         * @brief  QueryPersonBasicInfo 查询人员基本信息（员工，VIP，访客等）
         * @since  V3.20190327
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,               必填,int,页号
                "page_size": 10,            必填,int,页尺寸
                "query_cond": {
                    "lib_id": 1,            选填,int,底库id
                    "name": "xx",           选填,string,人员姓名，支持模糊匹配
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // int,页号
                    "page_size": 10,    // int,页尺寸
                    "items": [
                        {
                            "person_id": 1,     int,人员id
                            "person_name": "xx",string,人员姓名
                            "lib_id": 1,        int,人员库id
                            "lib_name": "xx",   string,人员库名
                            "pic_id": 1,        int,人员图片id
                            "pic_url": "xx",    string,图片路径
                            "gender": 1,        int,性别（1：男：2:女）
                            "phone": "xx",      string,电话
                            "card_no": "xx",    string,身份证号
                            "create_time": "xx",string,登记时间
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryPersonBasicInfo(string cond, out string result);

        /**
         -----------------------------------------------------------------------
         分组管理
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddGroup 添加小组（或联号编组）
         * @since  V3.20180922
         * @update V3.20200102 返回小组id
         *
         * @param group 小组信息
            example:
            {
                "name": "",         必填,string,小组名称
                "lib_id": 1,        必填,int,底库id
                "type": 1,          选填,int,小组类型:1:普通小组,2:联号编组,默认值2
                "remark": "",       选填,string,备注
                "person_list": "",  选填,string,待分组人员id列表,id之间以逗号分隔
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"group_id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddGroup(string group, out string result);

        /**
         * @brief  RemoveGroup 删除小组（或联号编组）
         * @since  V3.20180922
         *
         * @param group 小组信息
            example:
            {
                "group_id":xx   必填,int,小组id
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void RemoveGroup(string group, out string result);

        /**
         * @brief  AppendGroupPerson 追加小组（或联号编组）人员
         * @since  V3.20180922
         *
         * @param person 人员信息
            example:
            {
                "lib_id":xx         必填,int,底库id
                "group_id":xx       必填,int,小组id
                "person_list":xx,   必填,string,待分组人员id列表，id之间以逗号分隔
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AppendGroupPerson(string person, out string result);

        /**
         * @brief  ChangeGroupPerson 变更小组（或联号编组）人员，源库类型与目标库类型必须一致。
         * @since  V3.20180922
         *
         * @param person 人员信息
            example:
            {
                "s_group_id":xx     必填,int,源小组id
                "t_group_id":xx     必填,int,目标小组id
                "person_list":xx,   必填,string,待分组人员id列表，id之间以逗号分隔
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void ChangeGroupPerson(string person, out string result);

        /**
         * @brief  RemoveGroupPerson 移除小组（或联号编组）人员
         * @since  V3.20180922
         *
         * @param person 人员信息
            example:
            {
                "group_id":xx       必填,int,小组id
                "person_list":xx,   必填,string,待分组人员id列表，id之间以逗号分隔
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void RemoveGroupPerson(string person, out string result);

        /**
         * @brief  QueryGroupPerson 查询小组（或联号编组）人员列表。
         * @since  V3.20180922
         * @since  V3.20181018
         *
         * @param cond 搜索相关信息
            example:
            {
                "page_no":xx,       必填,int,页号
                "page_size":xx      必填,int,每页个数
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "lib_id":xx,        必填,int,底库id
                    "group_id":xx,      必填,int,小组id，=0：表示未分组,>0：小组id
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info":
                {
                    "page_no":xx,
                    "page_size":xx,
                    "total_count":xx,
                    "items": [
                        {
                            "person_id": 1, int,人员id
                            "person_name": "", string,人员姓名
                            "group_id": 1, int,小组id，0：表示未分组
                            "group_name": "xxx",string,小组名称
                            "card_no": "", string,证件号
                            "gender": 1, int,性别 0：未知,1：男,2：女
                            "nation": 0, int,民族id
                            "birthday": "", string,生日
                            "phone": "", string,电话
                            "pic_id": 1, int,人员图片id
                            "pic_url": "", string,图片路径
                            "group": 2 int,黑白名单,参见<Whitelist>
                            "category": 0, int,人员类别,0:未分类
                        },...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryGroupPerson(string cond, out string result);

        /**
         * @brief  QueryGroupList 查询小组（或联号编组）列表。
         * @since  V3.20180922
         *
         * @param cond 搜索相关信息
            example:
            {
                "page_no":xx,       必填,int,页号
                "page_size":xx      必填,int,每页个数
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "lib_id":xx,        必填,int,底库id
                    "group_id":xx,      选填,int,小组id，=0:表示未分组,>0:小组id,未填时:表示查询小组和未分组的所有信息
                    "group_name":xx,    选填,string,分组库名，支持模糊查询
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info":
                {
                    "page_no":xx,
                    "page_size":xx,
                    "total_count":xx,
                    "items": [
                        {
                            "group_id": 1,      int,小组id，0：表示未分组
                            "group_name": "xxx",string,小组名称
                            "lib_id": 1,        int,底库id
                            "lib_name": "xxx",  string,底库名称
                            "type": 1,          int,小组类型:1:普通小组,2:联号编组
                            "remark": "xxx",    string,备注
                            "person_count": 3,  int,人数
                            "create_time": "xx",string,创建时间
                        },...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryGroupList(string cond, out string result);

        /**
         -----------------------------------------------------------------------
         陌生人管理
         -----------------------------------------------------------------------
        **/
         /**
         * @brief  DeleteStranger 删除陌生人信息
         * @since  V3.20190711
         *
         * @param person 陌生人信息
            example: 
            {
                "stranger_id":"", 必填,string,陌生人编号
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteStranger(string person, out string result);

        /**
         * @brief  BatchDeleteStranger 批量删除陌生人信息。
         * @since  
         *
         * @param batch 批量删除参数
            example: 
            {
                "stranger_id_list": "1,2,3"      必填,string,陌生人编号列表
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchDeleteStranger(string batch, out string result);

        /**
         * @brief  QueryStrangerList 查询陌生人信息列表。
         * @since  
         *
         * @param cond 搜索相关信息
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "stranger_id": "",      选填,string,陌生人编号
                    "begin_time": "xx",     选填,string,开始时间，格式：YYYY-MM-DD HH:mm:ss
                    "end_time": "xx",       选填,string,结束时间，格式：YYYY-MM-DD HH:mm:ss
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "page_no":xx,
                    "page_size":xx,
                    "total_count":xx,
                    "items": [
                        {
                            "stranger_id": "", string,陌生人编号
                            "pic_url": "", string,图片路径
                            "create_time": "xxxx", string,创建时间,例：2017-03-02 20:02:02
                            "last_capture_time": "xxxx", string,最近抓拍时间,例：2017-03-02 20:02:02
                        }, ...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryStrangerList(string cond, out string result);

        /**
         -----------------------------------------------------------------------
         访客管理（访客机接口）
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  RegisterVisitor 访客信息登记
         * @since  V3.20181018
         * @since  V3.20181128 增加英文名
         * @update V3.20190308 增加受访部门id
         *
         * @param visitor 访客信息
            example: 
            {
                "lib_id": 1,                必填,int,底库id
                "area_list": "1,2",         必填,string,区域id列表，id之间以逗号分隔（华信项目：楼层id列表）
                "pic_path": "",             必填,string,图片路径
                "name": "",                 必填,string,人员姓名
                "english_name": "",         选填,string,英文名
                "gender": 1 ,               选填,int,性别（1：男：2:女）
                "phone": "",                选填,string,电话
                "nation": 0,                选填,int,民族Id,太长见数据库表
                "birthday": "",             选填,string,生日
                "card_no": "",              选填,string,身份证号
                "company": "",              选填,string,所在单位
                "address": "",              选填,string,住址
                "speech": "",               选填,string,迎宾语
                "visiting_purpose": "",     选填,string,来访目的
                "interviewer": "",          选填,string,受访人
                "valid_begin_time": "",     选填,string,有效时间-开始时间
                "valid_end_time": "",       选填,string,有效时间-结束时间
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void RegisterVisitor(string visitor, out string result);

        /**
         * @brief  QueryVisitorList 查询访客记录
         * @since  V3.20181018
         * @since  V3.20181128 增加英文名
         * @update V3.20190308 增加受访部门查询条件
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,               必填,int,页号
                "page_size": 10,            必填,int,页尺寸
                "query_cond": {
                    "lib_id": 1,            选填,int,底库id
                    "lib_name": "xx",       选填,string,底库名，支持精确匹配
                    "name": "xx",           选填,string,人员姓名，支持模糊匹配
                    "card_no": "xx",        选填,string,证件号筛选条件，支持精确查询
                    "dept_id": 1,           选填,int,受访部门
                    "begin_time": "xx",     选填,string,开始时间，格式：YYYY-MM-DD HH:mm:ss
                    "end_time": "xx",       选填,string,结束时间，格式：YYYY-MM-DD HH:mm:ss
                    "flag": 1,              选填,int,查询标记,1:查询访客记录,2:查询访客历史记录,3:查询所有记录,默认1
                }
                "order_rule": {
                    "time_acs": true        选填,bool,时间升序
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // int,页号
                    "page_size": 10,    // int,页尺寸
                    "total_count": 1,   // int,总数
                    "items": [
                        {
                            "id": 1,            int,记录id
                            "person_id": 1,     int,人员id
                            "name": "xx",       string,人员姓名
                            "english_name": "", string,英文名
                            "lib_id": 1,        int,人员库id
                            "lib_name": "xx",   string,人员库名
                            "pic_id": 1,        int,人员图片id
                            "pic_url": "xx",    string,图片路径
                            "gender": 1,        int,性别（1：男：2:女）
                            "phone": "xx",      string,电话
                            "nation": 0,        int,名族Id
                            "birthday": "xx",   string,生日
                            "card_no": "xx",    string,身份证号
                            "company": "xx",    string,所在单位
                            "address": "xx",    string,住址
                            "speech": "xx",     string,迎宾语
                            "area_list": [{"id":1, "name":"xx"}],   json,区域列表（华信项目：楼层列表）
                            "visiting_company": "xx",       string,受访公司
                            "visiting_dept_id": 1,          int,受访部门id
                            "visiting_department": "xx",    string,受访部门
                            "visiting_purpose": "xx",       string,来访目的
                            "interviewer": "xx",            string,受访人
                            "interviewer_phone": "",        string,受访人电话
                            "valid_begin_time": "",         string,有效时间-开始时间
                            "valid_end_time": "",           string,有效时间-结束时间
                            "create_time": "xx",            string,登记时间
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryVisitorList(string cond, out string result);

        /**
         -----------------------------------------------------------------------
         区域管理
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddArea 添加区域信息（华信项目：楼层信息）
         * @since  V3.20181018
         * @since  V3.20190606
         * @update V3.20200102 返回区域id
         * @update V3.20200609 添加组织id
         *
         * @param area 区域信息（华信项目：楼层信息）
            example: 
            {
                "name": "xx",       必填,string,区域名称（华信项目：楼层名称）
                "org_id": 1,        必填,int,组织id
                "parent_id": 0,     选填,int,父级区域id
                "remark": "xx",     选填,string,备注
                "operator": "xx"    选填,string,操作者，也是创建者，即当前登录用户名
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"area_id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddArea(string area, out string result);

        /**
         * @brief  UpdateArea 修改区域信息（华信项目：楼层信息）
         * @since  V3.20181018
         * @since  V3.20190606
         *
         * @param area 区域信息（华信项目：楼层信息）
            example: 
            {
                "area_id": 1        必填,int,区域id
                "name": "xx",       必填,string,区域名称（华信项目：楼层名称）
                "parent_id": 0,     选填,int,父级区域id
                "remark": "xx",     选填,string,备注
                "operator": "xx"    选填,string,操作者，即当前登录用户名
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdateArea(string area, out string result);

        /**
         * @brief  DeleteArea 删除区域信息（华信项目：楼层信息）
         * @since  V3.20181018
         * @since  V3.20190606
         *
         * @param area 人员信息
            example: 
            {
                "area_id": 5,   必填,int,区域id
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteArea(string area, out string result);

        /**
         * @brief  QueryAreaList 查询区域列表
         * @since  V3.20181018
         * @since  V3.20190606
         * @update V3.20200609 添加组织信息
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,               必填,int,页号
                "page_size": 10,            必填,int,页尺寸
                "org_id": 1,                必填,int,组织id
                "query_cond": {
                    "name":xx,              选填,string,区域名称，支持模糊查询。
                    "area_id": 0,           选填,int,区域id
                    "level": 0,             选填,int,层级,=0:全部,>0:层级
                    "parent_id": 0,         选填,int,父级区域id
                    "begin_time": "xxxx",   选填,string,开始时间，格式：YYYY-MM-DD HH:mm:ss
                    "end_time": "xxxx",     选填,string,结束时间，格式：YYYY-MM-DD HH:mm:ss
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // int,页号
                    "page_size": 10,    // int,页尺寸
                    "total_count": 1,   // int,总数
                    "items": [
                        {
                            "area_id": 1,           int,区域id
                            "name": "xx",           string,区域名称（华信项目：楼层名称）
                            "parent_id": 0,         int,父级区域id
                            "parent_name": "",      string,父级标签名
                            "level": 0,             int,层级
                            "remark": "xx",         string,备注
                            "create_time": "xxxx"   string,创建时间
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryAreaList(string cond, out string result);

         /**
         * @brief  QueryAreaTree 查询区域列表树
         * @since  V3.20190708
         * @update V3.20200609 增加组织id
         *
         * @param cond 查询条件
            example:
            {
                "org_id": 1,        必填,int,组织id
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "childs": [
                        {
                            "area_id": 1,           int,区域id
                            "name": "xx",           string,区域名称（华信项目：楼层名称）
                            "parent_id": 0,         int,父级区域id
                            "level": 0,             int,层级
                            "remark": "xx",         string,备注
                            "childs": [...]         json-array,子区域
                        },...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryAreaTree(string cond, out string result);

        /**
         -----------------------------------------------------------------------
         标签管理
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddLabel 添加标签信息
         * @since  V3.20190606
         * @update V3.20200102 返回标签id
         *
         * @param label 标签信息
            example: 
            {
                "name": "xx",       必填,string,标签名称
                "type": 0,          必填,int,标签类型,1:捕获级标签,2:停留级标签
                "parent_id": 0,     选填,int,父级标签id
                "area_list": "1,2", 选填,string,绑定的区域id列表,id之间以逗号分隔
                "condition": "{}",  选填,json-string,标签分配条件
                "remark": "xx",     选填,string,备注
                "operator": "xx"    选填,string,操作者,也是创建者,即当前登录用户名
            }
            其中 condition:
                {
                    "min_stay_time": 5, 选填,int,分钟,停留级标签必填
                }"
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"label_id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddLabel(string label, out string result);

        /**
         * @brief  UpdateLabel 修改标签信息
         * @since  V3.20190606
         *
         * @param Label 
            example: 
            {
                "label_id": 1       必填,int,标签id
                "name": "xx",       必填,string,标签名称
                "type": 0,          必填,int,标签类型,1:捕获级标签,2:停留级标签
                "parent_id": 0,     选填,int,父级标签id
                "area_list": "1,2", 选填,string,绑定的区域id列表,id之间以逗号分隔
                "condition": "{}",  选填,json-object,标签分配条件
                "remark": "xx",     选填,string,备注
                "operator": "xx"    选填,string,操作者,即当前登录用户名
            }
            其中 condition:
                {
                    "min_stay_time": 5, 选填,int,分钟,停留级标签必填
                }"
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdateLabel(string label, out string result);

        /**
         * @brief  DeleteLabel 删除标签信息
         * @since  V3.20190606
         *
         * @param label 标签信息
            example: 
            {
                "label_id": 5,  必填,int,标签id
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteLabel(string label, out string result);

        /**
         * @brief  QueryLabelList 查询标签列表
         * @since  V3.20190606
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,               必填,int,页号
                "page_size": 10,            必填,int,页尺寸
                "query_cond": {
                    "name": xx,             选填,string,标签名称，支持模糊查询。
                    "label_id": 0,          选填,int,标签id
                    "parent_id": 0,         选填,int,父级标签id
                    "level": 0,             选填,int,层级,=0:全部,>0:层级
                    "begin_time": "xxxx",   选填,string,开始时间，格式：YYYY-MM-DD HH:mm:ss
                    "end_time": "xxxx",     选填,string,结束时间，格式：YYYY-MM-DD HH:mm:ss
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // int,页号
                    "page_size": 10,    // int,页尺寸
                    "total_count": 1,   // int,总数
                    "items": [
                        {
                            "label_id": 1,          int,标签id
                            "name": "xx",           string,标签名称
                            "type": 0,              int,标签类型,1:捕获级标签,2:停留级标签
                            "parent_id": 0,         int,父级标签id
                            "parent_name": "",      string,父级标签名
                            "level": 0,             int,层级
                            "area_list": [ {"area_id": 1, "area_name": "xx" ],   json-array,绑定的区域信息列表
                            "condition": "{}",      json-object,标签分配条件 
                            "remark": "xx",         string,备注
                            "creator": "xx",        string,创建者
                            "create_time": "xxxx"   string,创建时间
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryLabelList(string cond, out string result);

        /**
         * @brief  QueryLabelTree 查询标签列表树
         * @since  V3.20190708
         *
         * @param cond 查询条件
            example:
            {
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "childs": [
                        {
                            "label_id": 1,          int,标签id
                            "name": "xx",           string,标签名称
                            "type": 0,              int,标签类型,1:捕获级标签,2:停留级标签
                            "parent_id": 0,         int,父级标签id
                            "level": 0,             int,层级
                            "area_list": "1,2",     string,绑定的区域id
                            "condition": "{}",      json对象,标签分配条件 
                            "remark": "xx",         string,备注
                            "childs": [...]         json-array,子标签
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryLabelTree(string cond, out string result);

        /**
         -----------------------------------------------------------------------
         部门管理
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddDepartment 添加部门信息
         * @since  V3.20190308
         * @update V3.20200102 返回部门id
         * @update V3.20200609 添加组织id
         *
         * @param dept 部门信息
            example: 
            {
                "name": "xx",       必填,string,部门名称
                "org_id": 1,        必填,int,组织id
                "remark": "xx",     选填,string,备注
                "operator": "xx"    选填,string,操作者,也是创建者,即当前登录用户名
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"dept_id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddDepartment(string dept, out string result);

        /**
         * @brief  UpdateDepartment 更新部门信息
         * @since  V3.20190308
         *
         * @param dept 部门信息
            example: 
            {
                "dept_id": 1,       必填,int,部门id
                "name": "xx",       必填,string,部门名称
                "remark": "xx",     选填,string,备注
                "operator": "xx"    选填,string,操作者,也是创建者,即当前登录用户名
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdateDepartment(string dept, out string result);

        /**
         * @brief  DeleteDepartment 删除部门信息
         * @since  V3.20190308
         *
         * @param dept 部门信息
            example: 
            {
                "dept_id": 5,       必填,int,部门id
                "operator": "xx"    选填,string,操作者,也是创建者,即当前登录用户名
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteDepartment(string dept, out string result);

        /**
         * @brief  QueryDepartmentList 查询部门信息。
         * @since  V3.20190308
         * @update V3.20200609 添加组织信息
         *
         * @param cond 搜索相关信息
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "org_id": 1,        必填,int,组织id
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "name": "",     选填,string,部门名称,支持模糊查询
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "page_no":xx,
                    "page_size":xx,
                    "total_count":xx,
                    "items": [
                        {
                            "dept_id": 1,           int,部门id
                            "name": "xx",           string,部门名称
                            "org_id": 1,            int,组织id
                            "organization_id": "",  string,组织名
                            "remark": "xx",         string,备注
                            "creator": "xx",        string,创建者
                            "create_time": "xxxx",  string,创建时间
                            "update_time": "xxxx"   string,更新时间
                        }, ...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryDepartmentList(string cond, out string result);

        /**
         -----------------------------------------------------------------------
         迎宾语管理
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddWelcomeWord 添加迎宾语。
         * @since  V3.20180922
         * @update V3.20200102 返回迎宾语id
         *
         * @param word 迎宾语信息
            example:
            {
                "type":xx,      必填,int,类型（0:none,1:employee,2:manager,3:visitor,4:stranger）
                "word":xx       必填,string,迎宾语字串
                "enabled":xx,   选填,bool,使能
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddWelcomeWord(string word, out string result);

        /**
         * @brief  EnableWelcomeWord 设置迎宾语使能。
         * @since  V3.20180922
         *
         * @param word 迎宾语信息
            example:
            {
                "id":xx,        必填,int,迎宾语id
                "enabled":xx,   必填,bool,使能
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void EnableWelcomeWord(string word, out string result);

        /**
         * @brief  DeleteWelcomeWord 删除迎宾语。
         * @since  V3.20180922
         *
         * @param word 迎宾语信息
            example:
            {
                "id":xx,        必填,int,迎宾语id
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteWelcomeWord(string word, out string result);

        /**
         * @brief  QueryWelcomeWord 查询所有迎宾语。
         * @since  V3.20180922
         *
         * @param cond 搜索相关信息<保留>
            example:
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info":
                {
                    "items": [
                        {
                            "id":xx,            int,迎宾语id
                            "type":xx,          int,类型（0:none,1:employee,2:manager,3:visitor,4:stranger）
                            "word":xx           string,迎宾语
                            "enabled":xx,       bool,迎宾语使能
                            "create_time":xx,   string,创建时间
                        },...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryWelcomeWord(string cond, out string result);

        /**
         * @brief  QueryEnableWelcomeWord 查询当前启用的迎宾语。
         * @since  V3.20180922
         *
         * @param cond 搜索相关信息<保留>
            example:
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info":
                {
                    "items": [
                        {
                            "id":xx,            int,迎宾语id
                            "type":xx,          int,类型（0:none,1:employee,2:manager,3:visitor,4:stranger）
                            "word":xx           string,迎宾语
                            "enabled":xx,       bool,迎宾语使能
                            "create_time":xx,   string,创建时间
                        },...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryEnableWelcomeWord(string cond, out string result);

        /**
         -----------------------------------------------------------------------
         底库人员讯息管理
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddGroupMessage 新增用户组讯息
         * @since  V3.20190308
         * @update V3.20200102 返回消息序号
         * @update V3.20200525 增加操作员字段
         *
         * @param message 用户组讯息。
            example: 
            {
                "lib_list": "1,2",     必填,string,底库列表,id之前以逗号分隔
                "message": "xxx",      必填,string,迎宾语
                "operator": "",        必填,string,操作员
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"msg_id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddGroupMessage(string message, out string result);

        /**
         * @brief  UpdateGroupMessage 更新用户组讯息
         * @since  V3.20190308
         *
         * @param message 用户组讯息
            example: 
            {
                "msg_id": 0,           必填,int,序号
                "lib_list": "1,2",     必填,string,底库列表,id之前以逗号分隔
                "message": "xxx",      必填,string,迎宾语
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdateGroupMessage(string message, out string result);

        /**
         * @brief  DeleteGroupMessage 删除用户组讯息
         * @since  V3.20190308
         *
         * @param message 用户组讯息
            example: 
            {
                "msg_id":0,        必填,int,序号
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteGroupMessage(string message, out string result);

        /**
         * @brief  QueryGroupMessageList 查询用户组讯息
         * @since  V3.20190308
         * @update V3.20200525 增加操作员字段
         *
         * @param cond 查询条件
            {
                "page_no": 1,           必填,int,页号,默认1
                "page_size": 10,        必填,int,页大小,有效数据是10,20,30,40,50
                "operator": "",         必填,string,操作员
            }
         * @param result 成功或失败。
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "page_no": 1,
                    "page_size": 10,
                    "total_count": 100,
                    "items": [
                        {
                            "msg_id": 0,        // int,序号
                            "message": "xxx",   // string,迎宾语
                            "lib_list": [{"id":1, "name":"xx"}]  // json,底库列表
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryGroupMessageList(string cond, out string result);

        /**
         -----------------------------------------------------------------------
         个人讯息管理
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddPersonalMessage 新增个人讯息
         * @since  V3.20190308
         *
         * @param message 个人讯息。
            example: 
            {
                "person_list": [
                        {"lib_id":1,"person_id":2}
                    ],                  必填,json,人员列表
                "show_period": 1,       必填,int,显示周期,1:1次,2:1日,3:3日,4:7日,5:长期
                "message": "xxx",       必填,string,迎宾语
                "operator": "admin"     必填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddPersonalMessage(string message, out string result);

        /**
         * @brief  UpdatePersonalMessage 更新个人讯息
         * @since  V3.20190308
         *
         * @param message 个人讯息
            example: 
            {
                "msg_id": 0,            必填,int,序号
                "show_period": 1,       必填,int,显示周期,1:1次,2:1日,3:3日,4:7日,5:长期
                "message": "xxx",       必填,string,迎宾语
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdatePersonalMessage(string message, out string result);

        /**
         * @brief  DeletePersonalMessage 删除个人讯息
         * @since  V3.20190308
         *
         * @param message 个人讯息
            example: 
            {
                "msg_id":0,        必填,int,序号
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeletePersonalMessage(string message, out string result);

        /**
         * @brief  QueryPersonalMessageList 查询个人讯息
         * @since  V3.20190308
         *
         * @param cond 查询条件
            {
                "page_no": 1,           必填,int,页号,默认1
                "page_size": 10,        必填,int,页大小,有效数据是10,20,30,40,50
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "person_name": "",      选填,string,人员姓名
                }
            }
         * @param result 成功或失败。
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "page_no": 1,
                    "page_size": 10,
                    "total_count": 100,
                    "items": [
                        {
                            "msg_id": 0,        // int,序号
                            "person_id": 1,     // int,人员id
                            "person_name": "",  // string,人员姓名
                            "lib_id": 1,        // int,底库id
                            "lib_name": "",     // string,底库姓名
                            "message": "xxx",   // string,迎宾语
                            "show_period": 1,   // int,显示周期,1:1次,2:1日,3:3日,4:7日,5:长期
                            "shown": 0,         // int,是否已展示,0:未展示,1:已展示
                            "creator": "sfd",   // string,创建人
                            "create_time": "2019-03-23 00:12:12",   // string,创建时间
                            "update_time": "2019-03-23 00:12:12"    // string,更新时间
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryPersonalMessageList(string cond, out string result);

        /**
         -----------------------------------------------------------------------
         摄像头管理
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddCamera 添加摄像头
         * @since  V3.20190919
         * @update V3.20200102 返回摄像头id
         * @update V3.20200324 新增支持双光相机（视频流+黑体）
         * @update V3.20200421 增加设备所属地点ID
         * @update V3.20200529 增加设备所属组织ID
         * @update V3.20200703 修改摄像头参数信息 attribute
         *
         * @param camera 视频源信息（网络摄像头、人脸抓拍机）等，参见《CameraType》。
            example:
            {
                "name": "n1",       必填,string,摄像头名。不要包含标点符号或特殊字符。!@#$%^&*([{}])_+|~-=\`;:'",<.>/?
                "type": 1,          必填,int,类型，参见《CameraType》
                "rtsp": "rtsp://xx",必填,string,取流地址
                "rotate_angle": 32.0,选填,float,旋转角度，范围[-180.0, 180.0]。没有此字段，或字段无效，只表示旋转角度为0。
                "location": "East"  选填,string,安放位置
                "additional": "{}", 选填,json-string,附件信息。
                "global": true,     选填,bool,使用全局属性配置,true表示使用全局配置,false表示使用私有配置
                "attribute": "{}",  选填,json-string,json格式的属性字段。
                "area_id": 1,       选填,int,绑定的区域id。
                "remark": "xxx",    选填,string,备注。
                "operator": "xx",   选填,string,当前登录的用户名。
                "site_id":1,        必填,int 设备所属地点id
                "org_id":1          必填,int 组织id
            }
                【字段】 additional 取值:
                人脸抓拍机，双光相机
                {
                    "manufacturer": 0,      // 设备厂商，参见《CameraMfrsType》
                    "ip": "192.168.1.10",   // 设备ip
                    "port": 8000,           // 设备SDK登录端口,海康:8000,
                    "uuid": "umet9cxrtui9", // 设备UUID,被动模式接入,
                    "username": "admin",    // 设备SDK登录用户名
                    "password": "123",      // 设备SDK登录密码
                    "thermography_rtsp":""  // 红外摄像头流地址 (当摄像头为8358双光相机时填写)
                }
                【字段】 attribute 取值:
                {
                    "resize_facephoto_width" : 0,      //抓拍照固定尺寸,如果为0,则不进行尺寸压缩 
                    "capture_strategy" : 6,            //抓拍策略,参见<ECaptureStrategy>
                    "capture_interval": 3000,          //抓拍间隔，单位ms
                    "detect_interval": 5,              //检测间隔，每隔多少帧，检测一帧。
                    "keypoints_confidence": 6.0,       //人脸质量得分阈值[0.0-100.0],一般取值6.0
                    "video_codec": 0,                  //解码方式,参见<CodecType>
                    "detectface_threshold":0.9         //检测置信度阈值 取值[0.0-1.0]
                    "definition_threshold":0.0,        //清晰度阈值 取值[0.0-1.0]
                    "facerange_scale": 1.5,            //人脸扩充比例
                    "scene_scale":1.0,                 //全图缩放比例
                    "min_face_size": 40,               //最小人脸框短边长度
                    "skip_frame_interval":1            //解码跳帧,每隔多少帧,解码一帧
                }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddCamera(string camera, out string result);

        /**
         * @brief  UpdateCamera 更新摄像头
         * @since  V3.20190919
         * @update V3.20200421 增加设备所属机构ID
         *
         * @param camera 视频源信息（网络摄像头、人脸抓拍机）等。
            example:
            {
                "id": 1,            必填,摄像头id（主键）
                "name": "n1",       必填,string,摄像头名。不要包含标点符号或特殊字符。!@#$%^&*([{}])_+|~-=\`;:'",<.>/?
                "type": 1,          必填,int,类型（字段不可修改），参见《CameraType》
                "rtsp": "rtsp://xx",必填,string,取流地址
                "rotate_angle": 32.0,选填,float,旋转角度，范围[-180.0, 180.0]。没有此字段，或字段无效，只表示旋转角度为0。
                "location": "East"  选填,string,安放位置
                "additional": "{}", 选填,json-string,附件信息。
                "global": true,     选填,bool,使用全局属性配置,true表示使用全局配置,false表示使用私有配置
                "area_id": 1,       选填,int,绑定的区域id。
                "attribute": "{}",  选填,json-string,json格式的属性字段。
                "remark": "xxx",    选填,string,备注。
                "operator": "xx",   选填,string,当前登录的用户名。
                "site_id":1,        选填,int 设备所属地点id
            }
            // json字段详情参见 AddCamera
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdateCamera(string camera, out string result);
        
        /**
         * @brief  SetInfraredLightParam 设置双光摄像头参数信息
         * @since  V3.20200507
         *
         * @param param 参数信息
            example:
            {
                "id": 1,                        //必填,双光摄像头id
                "blackbody_x": -1,              //黑体x坐标 如果<0则不设置
                "blackbody_y":-1,               //黑体y坐标 如果<0则不设置
                "infrared_width" : xxx,         //红外光宽度
                "infrared_hight" : xxx,         //红外光高度
                "blackbody_temperature" : 36.5, //黑体温度
                "expansion_coefficient" : 1.0,  //相对红外光的宽高的扩展系数
                "center_shifting_x" : 0,        //中心点x坐标偏移位置
                "center_shifting_y" : 0         //中心点y坐标偏移位置
                "visilight_calibrat_x" : 0,     //可见光标定的x坐标
                "visilight_calibrat_y" : 0,     //可见光标定的y坐标
                "infrared_calibrat_x" : 0,      //红外光标定的x坐标
                "infrared_calibrat_y" : 0,      //红外光标定的y坐标
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void SetInfraredLightParam(string param, out string result);

        /**
         * @brief  EnableGlobalForCamera 使能摄像头的全局属性
         * @since  V3.20190919
         *
         * @param camera 视频源信息
            example:
            {
                "id": 1,            必填,摄像头id（主键）
                "enabled": true,    必填,使能
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void EnableGlobalForCamera(string camera, out string result);

        /**
         * @brief  DeleteCamera 删除摄像头。
         * @since  V3.20190919
         *
         * @param camera 视频源信息
            example:
            {
                "id": 2,            必填,int,摄像id
                "operator": "xx"    选填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteCamera(string camera, out string result);

        /**
         * @brief  QueryCameraList 查询摄像头列表。
         * @since  V3.20190919
         * @update V3.20200421 增加设备所属机构ID
         *
         * @param cond 查询条件。
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,页尺寸
                "operator": "admin",必填,string,操作者
                "org_id":1,         必填,int,所属组织id
                "query_cond": {
                    "type": 1,          选填,int,类型，参见《CameraType》
                    "name": "xx"        选填,string,摄像头名称，支持模糊匹配
                    "area_id": 1,       选填,int,绑定的区域id。
                    "type_list": "",    选填,string,类型列表,若type有效时,该字段不起作用
                    "siteid_list":"",   选填,String,设备所属地点id列表
                    "site_list":""      选填,String,设备所属地点id列表
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,
                    "page_size": 10,
                    "total_count": 103,
                    "items": [
                        {
                            "id": 1,            //int,摄像头id
                            "name": "n1",       //string,摄像头名。不要包含标点符号或特殊字符。!@#$%^&*([{}])_+|~-=\`;:'",<.>/?
                            "type": 1,          //int,类型，参见《CameraType》
                            "rtsp": "rtsp://xx",//string,取流地址
                            "rotate_angle": 32.0,//float,旋转角度，范围[-180.0, 180.0]。没有此字段，或字段无效，只表示旋转角度为0。
                            "location": "East"  //string,安放位置
                            "additional": "{}", //json-string,附件信息。
                            "global": true,     //bool,使用全局属性配置,true表示使用全局配置,false表示使用私有配置
                            "attribute": "{}",  //json-string,json格式的属性字段。
                            "state": 0,         //int,状态，0:离线,1:在线
                            "heatmap": 0,       //int,热力图映射状态,0:未映射,1:已映射
                            "area_id": 1,       //int,绑定的区域id。
                            "area_name": "",    //string,绑定的区域名
                            "capbox_id": 0,     //int,绑定的盒子的id
                            "capbox_name": "xx",//string,绑定的盒子的名称
                            "remark": "xxx",    //string,备注。
                            "organ_id":1,       //int, 设备所属机构id
                            "organ_name":"xx",  //string, 设备所属机构名称
                            "org_id":1,         //int, 设备所属机构id
                            "organization":"xx",//string, 设备所属机构名称
                            "site_id":1,        //int, 设备所属地点id
                            "site_name":"xx",   //string, 设备所属地点名称
                            "sitename":"xx",    //string, 设备所属地点名称
                            "creator": "xx",    //string,创建者
                            "create_time": "xx" //string,创建时间
                        },
                        ...
                    ]
                }
            }
            // json字段详情参见 AddCamera
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryCameraList(string cond, out string result);

        /**
         * @brief  QueryHeatmapCameraList 查询热力图摄像头列表。
         * @since  V3.20190919
         *
         * @param cond 查询条件。
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,页尺寸
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "area_id": 1,       选填,int,绑定的区域id。
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,
                    "page_size": 10,
                    "total_count": 103,
                    "items": [
                        {
                            "id": 1,            //int,摄像头id
                            "name": "n1",       //string,摄像头名。不要包含标点符号或特殊字符。!@#$%^&*([{}])_+|~-=\`;:'",<.>/?
                            "type": 1,          //int,类型，参见《CameraType》
                            "rtsp": "rtsp://xx",//string,取流地址
                            "location": "East"  //string,安放位置
                            "heatmap": 0,       //int,热力图映射状态,0:未映射,1:已映射
                        },
                        ...
                    ]
                }
            }
            // json字段详情参见 AddCamera
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryHeatmapCameraList(string cond, out string result);

        /**
         * @brief QueryCameraRtsp  查询摄像头rtsp地址
         * @since  V3.20190919
         *
         * @para cond   查询条件
            example:
            {
                "ip": "192.168.2.168",   必填,string,摄像头ip
                "username": "test",      必填,string,摄像头登录用户名
                "password": "1234"       必填,string,摄像头登录密码
            }
         * @para result 成功或失败。例:
            成功 - 返回对应的结果
            {
                "code": 0,
                "info":
                {
                    "rtsp": "rtsp://admin:admin123@192.168.2.200:554"    // 摄像头对应rtsp地址
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryCameraRtsp(string cond, out string result);

        /**
         -----------------------------------------------------------------------
         抓拍盒子管理
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddCaptureBox 添加抓拍盒子
         * @since  V3.20190905
         * @update V3.20200102 返回盒子id
         * @update V3.20200326 增加uuid
         *
         * @param box 抓拍盒子信息
            example:
            {
                "name": "n1",           必填,string,抓拍盒子名称。不要包含标点符号或特殊字符。!@#$%^&*([{}])_+|~-=\`;:'",<.>/?
                "type": 1,              必填,int,类型，参见《CapboxMfrsType》
                "ip": "192.168.1.10",   选填,string,设备ip
                "port": 8000,           选填,int,设备端口,触景无限MQTT:1883,
                "username": "admin",    选填,string,登录用户名,触景无限:admin
                "password": "123"       选填,string,登录密码,触景无限:Senscape
                "uuid": "ABSHIKDKSJH1"  选填,string,设备唯一标识符  小智盒子设备标志
                "site_id":1,            必填,int 设备所属地点id
                "cameras"[
                    {
                        "name": "camera 01",
                        "rtsp": "rtsp://admin:admin@192.168.1.10:554/h264",
                        "channel": 1,   必填,int,通道号,取值[1,4]
                        "location": "East Gate",
                        "remark": ""
                    }, ...
                ]
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddCaptureBox(string box, out string result);

        /**
         * @brief  UpdateCaptureBox 更新抓拍盒子
         * @since  V3.20190905
         * @update V3.20200326 增加uuid
         *
         * @param box 抓拍盒子信息
            example:
            {
                "id": 1,                必填,int,盒子id
                "name": "n1",           必填,string,盒子名称。不要包含标点符号或特殊字符。!@#$%^&*([{}])_+|~-=\`;:'",<.>/?
                "type": 1,              必填,int,类型,参见《CapboxMfrsType》
                "ip": "192.168.1.10",   选填,string,盒子ip
                "port": 8000,           选填,int,盒子端口,触景无限MQTT:1883,
                "username": "admin",    选填,string,登录用户名,触景无限:admin
                "password": "123"       选填,string,登录密码,触景无限:Senscape
                "uuid": ""              选填,string,,设备唯一标识符  小智盒子设备标志
                "site_id":1,            选填,int 设备所属地点id
                "cameras"[
                    {
                        "name": "camera 01",
                        "rtsp": "rtsp://admin:admin@192.168.1.10:554/h264",
                        "channel": 1,   必填,int,通道号,取值[1,4]
                        "location": "East Gate",
                        "remark": ""
                    }, ...
                ]
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdateCaptureBox(string box, out string result);

        /**
         * @brief  DeleteCaptureBox 删除抓拍盒子
         * @since  V3.20190905
         *
         * @param box 抓拍盒子信息
            example:
            {
                "id": 2,            必填,int,盒子id
                "operator": "xx"    选填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteCaptureBox(string box, out string result);

        /**
         * @brief  GetCaptureBoxInfo 获取抓拍盒子信息
         * @since  V3.20190905
         * @update V3.20200326 增加返回值uuid
         *
         * @param cond 查询条件
            example:
            {
                "id": 2,            必填,int,盒子id
                "operator": "xx"    选填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "id": 1,                int,盒子id
                    "name": "n1",           string,盒子名称。不要包含标点符号或特殊字符。!@#$%^&*([{}])_+|~-=\`;:'",<.>/?
                    "type": 1,              int,类型，参见《CapboxMfrsType》
                    "ip": "192.168.1.10",   string,盒子ip
                    "port": 8000,           int,盒子端口,触景无限MQTT:1883,
                    "username": "admin",    string,登录用户名,触景无限:admin
                    "password": "123"       string,登录密码,触景无限:Senscape
                    "uuid": ""              string,盒子唯一标识符 小智盒子
                    "cameras"[
                        {
                            "name": "camera 01",
                            "rtsp": "rtsp://admin:admin@192.168.1.10:554/h264",
                            "channel": 1,   int,通道号
                            "location": "East Gate",
                            "remark": ""
                        },
                        ...
                    ]
                }
            }
            // json字段详情参见 AddCamera
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void GetCaptureBoxInfo(string cond, out string result);

        /**
         * @brief  QueryCaptureBoxList 查询抓拍盒子信息
         * @since  V3.20190905
         * @update V3.20200326 增加uuid 和返回值uuid
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,页尺寸
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "name": "",     选填,string,盒子名称,支持模糊匹配。
                    "type": 1,      选填,int,盒子类型
                    "ip": ""        选填,string,盒子ip
                    "uuid": ""      选填,string,小智盒子uuid
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,
                    "page_size": 10,
                    "total_count": 103,
                    "items": [
                        {
                            "id": 1,                int,盒子id
                            "name": "n1",           string,盒子名称。不要包含标点符号或特殊字符。!@#$%^&*([{}])_+|~-=\`;:'",<.>/?
                            "type": 1,              int,类型，参见《CapboxMfrsType》
                            "ip": "192.168.1.10",   string,盒子ip
                            "port": 8000,           int,盒子端口,触景无限MQTT:1883,
                            "username": "admin",    string,登录用户名,触景无限:admin
                            "password": "123"       string,登录密码,触景无限:Senscape
                            "uuid": ""              string,小智盒子uuid
                            "organ_id":1,           int, 设备所属机构id
                            "organ_name":"xx",      string, 设备所属机构名称
                            "org_id":1,             int, 设备所属机构id
                            "organization":"xx",    string, 设备所属机构名称
                            "site_id":1,            int, 设备所属地点id
                            "site_name":"xx",       string, 设备所属地点名称
                            "sitename":"xx"         string, 设备所属地点名称
                        },
                        ...
                    ]
                }
            }
            // json字段详情参见 AddCamera
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryCaptureBoxList(string cond, out string result);
        
        
        /**
         -----------------------------------------------------------------------
         任务管理
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddMonitorTask 添加监控任务。
         * @since  V3.20180922
         * @update V3.20181009 增加工间点名功能
         * @update V3.20181018 增加区域绑定
         * @update V3.20181107 增加定时巡更任务
         * @update V3.20181205 增加识别间隔
         * @update V3.20190308 修改timing,支持多计划,以及普通闸机门禁信息
         * @update V3.20190522 修改attribute,新增监狱点名,监狱签到,监狱进出管理任务类型
         * @update V3.20200102 返回任务id
         * @update V3.20200427 增加任务所属机构id
         *
         * @param task 任务信息。可以是视频比对，也可以是图片比对。不能混用。
            example:
            {
                "name": "task name",        必填,string,任务名,不要包含标点符号或特殊字符。!@#$%^&*([{}])_+|~-=\`;:'",<.>/?
                "type": 1,                  必填,int,任务类型,参见《TaskType》
                "video_list": "1,2",        必填,string,视频列表,工间点名时（入口摄像头列表）。json格式的字符串。
                "video_list2": "3,4",       选填,string,视频列表,工间点名时（出口摄像头列表）必填。json格式的字符串。
                "lib_list": "1,2,3",        必填,string,底库列表,例:"1,2,3,"
                "access_list": "1,2",       必填,string,闸机列表,例:"1,2,"
                "area_id": 1,               选填,int,区域id（华信项目：楼层id）
                "score_threshold": 0.85,    选填,float,比对得分的最小阈值，非神盾任务选填。
                "alarm_stranger": true,     选填,bool,陌生人是否告警。 true or false
                "top_num": 1,               选填,int,比对topN,默认top one
                "recognize_interval": 5000, 选填,int,底库人员识别间隔,单位毫秒,默认5000ms
                "remark": "xx",             选填,string,备注。
                "timing": "{}",             选填,json-string,json格式的属性字段
                "attribute": "{}",          选填,json-string,json格式的属性字段
                "operator": "xx",           必填,string,操作者,当前登录的用户名。
                "organ_id":1                必填,任务所属机构id 任选一
                "org_id":1                  必填,任务所属机构id 任选一
            }
                【字段】 timing 取值:
                {
                    "enabled": true,
                    "plans": [
                        {
                            "weekly": "0,1,2,3",            // 每周的,0:星期日,1:星期一,...,6:星期六
                            "timeslice": [                  // 定时计划时间段
                                {
                                    "start": "02:00:00",    // 时间段开始时间
                                    "end": "03:30:00"       // 时间段结束时间
                                }
                            ]
                        }
                    ]
                }
                【字段】 attribute 取值:
                1.联号任务
                {
                    // 联号属性
                    "group_prop": {
                        "duration_time": 10,        // 每次联号事件持续时间，单位：秒
                        "check_interval": 60        // 联号事件执行间隔，单位：秒
                    }
                }
                2.定时巡更
                {
                    // 巡更属性
                    "patrol_prop": {
                        "group_id": 1,              // 巡更小组id
                        "patrol_plan": [
                            {
                                "video_id": 1,              // 摄像头id
                                "timeslice": [              // 巡更时间段
                                    {
                                        "begin": "02:00:00",// 巡更开始时间
                                        "end": "03:30:00"   // 巡更结束时间
                                    }
                                ]
                            }
                        ]
                    }
                }
                3.监狱点名
                {
                    "rollcall_prop": {
                        "duration": 5,      // 点名持续时间,单位:分钟
                        "absent_alarm": 0,  // 缺席告警,0:不告警,1:告警
                    }
                }
                4.监狱签到
                {
                    "signin_prop": {
                        "signin_duration": 5,   // 签到持续时间,单位:分钟
                        "signout_time": 5,      // 签退时间,单位:分钟
                        "signout_duration": 5,  // 签退持续时间,单位:分钟
                    }
                }
                5.监狱进出
                {
                    "inout_prop": {
                        "alarm_threshold": 30,  // 告警阈值,0表示不告警,单位:分钟
                    }
                }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"task_id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddMonitorTask(string task, out string result);

        /**
         * @brief  UpdateMonitorTask 更新监控任务。
         * @since  V3.20180922
         * @update V3.20181009 增加工间点名功能
         * @update V3.20181018 增加区域绑定
         * @update V3.20181205 增加识别间隔
         * @update V3.20190308 修改timing,支持多计划,以及普通闸机门禁信息
         *
         * @param task 
            example:
            {
                "task_id": 1,               必填,int,任务id
                "name": "task name",        必填,string,任务名,不要包含标点符号或特殊字符。!@#$%^&*([{}])_+|~-=\`;:'",<.>/?
                "type": 1,                  必填,int,任务类型,参见《TaskType》
                "video_list": "1,2",        必填,string,视频列表,工间点名时（入口摄像头列表）。json格式的字符串。
                "video_list2": "3,4",       选填,string,视频列表,工间点名时（出口摄像头列表）必填。json格式的字符串。
                "lib_list": "1,2,3",        必填,string,底库列表。"1,2,3,"
                "access_list": "1,2",       必填,string,闸机列表,例:"1,2,"
                "area_id": 1,               选填,int,区域id（华信项目：楼层id）
                "score_threshold": 0.85,    选填,float,比对得分的最小阈值,非神盾任务选填。
                "alarm_stranger": true,     选填,bool,陌生人是否告警。 true or false
                "top_num": 1,               选填,int,比对topN,默认top one。
                "recognize_interval": 5000, 选填,int,底库人员识别间隔,单位毫秒,默认5000ms
                "remark": "xx",             选填,string,备注。
                "timing": "{}",             选填,json-string,json格式的属性字段
                "attribute": "{}",          选填,json-string,json格式的属性字段
                "operator": "xx",           选填,string,操作者,当前登录的用户名。
            }
            // json字段详情参见 AddMonitorTask
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdateMonitorTask(string task, out string result);

        /**
         * @brief  DeleteMonitorTask 删除监控任务。
         * @since  V3.20180922
         *
         * @param task 包含任务id。
            example:
            {
                "task_id": 1,       必填,int,任务id
                "operator": "xx"    选填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteMonitorTask(string task, out string result);

        /**
         * @brief  QueryMonitorTaskInfo 查询监控任务信息。
         * @since  V3.20180922
         * @update V3.20181009 增加工间点名功能
         * @update V3.20181018 增加区域绑定信息
         * @update V3.20181205 增加识别间隔
         * @update V3.20190308 修改timing,支持多计划,以及普通闸机门禁信息
         *
         * @param cond 查询条件。
            example:
            {
                "task_id": 1        必填,int,任务id
            }
         * @param result       成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "task_id": 1,               int,任务id
                    "name": "task name",        string,任务名,不要包含标点符号或特殊字符。!@#$%^&*([{}])_+|~-=\`;:'",<.>/?
                    "type": 1,                  int,任务类型,参见《TaskType》
                    "video_list": [ {"id": 1, "name": "xx"} ], 视频列表,[{id,name},...]
                    "video_list2": [ {"id": 3, "name": "xx"} ],视频列表2,[{id,name},...]
                    "lib_list": [ {"id": 1, "name": "xx"} ],   底库列表,[{id,name},...]
                    "access_list": [ {"id": 1, "name": "xx"} ],闸机列表,[{id,name},...]
                    "area_id": 1,               int,区域id（华信项目：楼层id）
                    "area_name": "",            string,区域名称（华信项目：楼层名称）
                    "score_threshold": 0.85,    float,比对得分的最小阈值，非神盾任务选填。
                    "alarm_stranger": true,     bool,陌生人是否告警。 true 或 false
                    "top_num": 1,               int,比对topN，默认top one。
                    "recognize_interval": 5000, int,底库人员识别间隔,单位毫秒,默认5000ms
                    "state": 1,                 int,状态,0:已停止,1:已启动
                    "remark": "xx",             string,备注。
                    "timing": "{}",             json-string,json格式的属性字段
                    "attribute": "{}",          json-string,json格式的属性字段
                    "creator": "xx",            string,创建者,当前登录的用户名
                    "create_time": "xxxx"       string,创建时间,例：2017-03-02 20:02:02
                }
            }
            // json字段详情参见 AddMonitorTask
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryMonitorTaskInfo(string cond, out string result);

        /**
         * @brief  QueryMonitorTaskList 查询监控任务列表。
         * @since  V3.20180922
         * @update V3.20181009 增加工间点名功能
         * @update V3.20181018 增加区域绑定信息
         * @update V3.20181205 增加识别间隔
         * @update V3.20190308 修改timing,支持多计划,以及普通闸机门禁信息
         * @update V3.20190530 增加视频摄像头打开状态
         *
         * @param cond 查询条件。
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,页尺寸
                "operator": "admin",选填,string,操作者
                "query_cond": {
                    "name": "xx",   选填,string,任务名称，支持模糊匹配
                    "area_id": 0    选填,int,区域id
                }
            }
         * @param result       成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,
                    "page_size": 10,
                    "total_count": 103
                    "items": [
                        {
                            "task_id": 1,               int,任务id
                            "name": "task name",        string,任务名,不要包含标点符号或特殊字符。!@#$%^&*([{}])_+|~-=\`;:'",<.>/?
                            "type": 1,                  int,任务类型,参见《TaskType》
                            "video_list": [ {"id": 1, "name": "xx", "state": 0} ], 视频列表,[{id,name,state},...],字段state,0:未打开,1:打开
                            "video_list2": [ {"id": 3, "name": "xx", "state": 0} ],视频列表2,[{id,name,state},...],字段state,0:未打开,1:打开
                            "lib_list": [ {"id": 1, "name": "xx"} ],   底库列表,[{id,name},...]
                            "access_list": [ {"id": 1, "name": "xx"} ],闸机列表,[{id,name},...]
                            "area_id": 1,               int,区域id（华信项目：楼层id）
                            "area_name": "",            string,区域名称（华信项目：楼层名称）
                            "score_threshold": 0.85,    float,比对得分的最小阈值，非神盾任务选填。
                            "alarm_stranger": true,     bool,陌生人是否告警。 true 或 false
                            "top_num": 1,               int,比对topN，默认top one。
                            "recognize_interval": 5000, int,底库人员识别间隔,单位毫秒,默认5000ms
                            "state": 1,                 int,状态,0:已停止,1:已启动
                            "remark": "xx",             string,备注。
                            "timing": "{}",             json-string,json格式的属性字段
                            "attribute": "{}",          json-string,json格式的属性字段
                            "creator": "xx",            string,创建者,当前登录的用户名
                            "create_time": "xxxx"       string,创建时间,例：2017-03-02 20:02:02
                        }
                    ]
                }
            }
            // json字段详情参见 AddMonitorTask
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryMonitorTaskList(string cond, out string result);

        /**
         -----------------------------------------------------------------------
         普通闸机管理
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddGeneralAccess 新增普通闸机门禁信息
         * @since  V3.20190308
         * @update V3.20200102 返回控制器id
         *
         * @param device 闸机信息。
            example: 
            {
                "name": "xxx",                  必填,string,控制器名称
                "type": 1,                      必填,int,设备类型,1-微耕门禁 2-继电器 3-中国尊 4-卓因达 5-披克388（海南易建）
                "ip": "192.168.0.1",            必填,string,控制器ip,中国尊为"COM"
                "port": 1000,                   必填,int,控制器端口,中国尊为0
                "out": "xxx",                   必填,string,控制器OUT号
                "sn": "xxxxxxx",                选填,string,序列号,微耕门禁必填
                "enabled": true,                选填,bool,门禁控制器使能,默认启用
                "remark": "xxx",                选填,string,备注
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"dev_id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddGeneralAccess(string device, out string result);

        /**
         * @brief  UpdateGeneralAccess 更新普通闸机门禁信息
         * @since  V3.20190308
         *
         * @param device 闸机信息
            example: 
            {
                "dev_id":0,                     必填,int,控制器id
                "name": "xxx",                  必填,string,控制器名称
                "type": 1,                      必填,int,设备类型,1-微耕门禁 2-继电器 3-中国尊 4-卓因达 5-披克388（海南易建）
                "ip": "192.168.0.1",            必填,string,控制器ip,中国尊为"COM"
                "port": 1000,                   必填,int,控制器端口,中国尊为0
                "out": "xxx",                   必填,string,控制器OUT号
                "sn": "xxxxxxx",                选填,string,序列号,微耕门禁必填
                "enabled": true,                选填,bool,门禁控制器使能,默认启用
                "remark": "xxx",                选填,string,备注
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdateGeneralAccess(string device, out string result);

        /**
         * @brief  EnableGeneralAccess 使能普通门禁设备
         * @since  V3.20190308
         *
         * @param device 门禁信息
            example: 
            {
                "dev_id": 1,        必填,门禁id
                "enabled": true,    必填,使能状态,false:停用,true:启用
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void EnableGeneralAccess(string device, out string result);

        /**
         * @brief  DeleteGeneralAccess 删除普通闸机门禁信息
         * @since  V3.20190308
         *
         * @param device 闸机信息
            example: 
            {
                "dev_id":0,                   必填,int,闸机门禁记录id
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteGeneralAccess(string device, out string result);

        /**
         * @brief  QueryGeneralAccessList 查询普通闸机门禁信息
         * @since  V3.20190308
         *
         * @param cond 查询条件
            {
                "page_no": 1,           必填,int,页号,默认1
                "page_size": 10,        必填,int,页大小,有效数据是10,20,30,40,50
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "dev_id": 0,           选填,int,闸机序号
                    "name": "xxx",          选填,string,设备名，支持模糊匹配
                    "type": 1,              选填,int,门禁设备类型，0表示全部
                }
            }
         * @param result 成功或失败。
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "page_no": 1,
                    "page_size": 10,
                    "total_count": 100,
                    "items": [
                        {
                            "dev_id":0,                // int,控制器id
                            "name": "xxx",              // string,控制器名称
                            "type": 1,                  // int,设备类型,1-微耕门禁 2-继电器 3-中国尊 4-卓因达 5-披克388（海南易建）
                            "ip": "192.168.0.1",        // string,控制器ip,中国尊为"COM"
                            "port": 1000,               // int,控制器端口,中国尊为0
                            "out": "xxx",               // string,控制器OUT号
                            "sn": "xxxxxxx",            // string,序列号,微耕门禁必填
                            "enabled": true,            // bool,门禁控制器使能,默认启用
                            "remark": "xxx",            // string,备注
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryGeneralAccessList(string cond, out string result);

        /**
         -----------------------------------------------------------------------
         智能门禁机管理
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddSmartAccess  添加智能人脸门禁机
         * @since  V3.20190308
         * @update V3.20200102 返回设备id
         * @update V3.20200217 增加设备进出标识
         * @update V3.20200421 增加设备所属机构ID
         * @update V3.20200428 热眸单机版增加比对底库
         *
         * @param device 智能人脸门禁信息
            example:
            {
                "name": "office",           必填,设备名
                "type": 1,                  选填,设备类型,参见《FaceDeviceType》
                "in_out": 0,                选填,设备进出标识,0:未知,1:进口,2:出口
                "ip": "127.0.0.1",          必填,设备IP
                "port": 8000,               必填,设备端口
                "sn": "xxx",                选填,设备序列号
                "site_id":1,                必填,设备所属地点id
                "enabled": true,            选填,门禁控制器使能,默认启用
                "compare_info":"",          选填,设备二次比对信息
                "remark":"xxx"              选填,备注
            }
            【字段】 compare_info 取值:
            {
                "lib_list": 0,              // string,底库列表
                "compare_threshold": 0.8,   // double,比对阈值
                "confidence": 7,            // double,关键点信息值
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"dev_id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddSmartAccess(string device, out string result);

        /**
         * @brief  UpdateSmartAccess 修改智能人脸门禁机信息
         * @since  V3.20190308
         * @update V3.20190822 增加云设备支持
         * @update V3.20200217 增加设备进出标识
         * @update V3.20200421 增加设备所属机构ID
         * @update V3.20200428 增加二次比对信息
         *
         * @param device 智能人脸门禁信息
            example:
            {
                "dev_id": 1,                必填,设备号
                "name": "office",           必填,设备名
                "in_out": 0,                选填,设备进出标识,0:未知,1:进口,2:出口
                "ip": "127.0.0.1",          选填,设备IP（智能门禁可修改）
                "port": 8000,               选填,设备端口（智能门禁可修改）
                "sn": "xxx",                选填,设备序列号（智能门禁可修改）
                "site_id":1,                选填,设备所属地点id
                "area_id": 1,               选填,区域id
                "enabled": true,            选填,门禁控制器使能,默认启用
                "compare_info":"",          选填,设备二次比对信息
                "remark":"xxx"              选填,备注
            }
            【字段】 compare_info 取值:
            {
                "lib_list": 0,              // string,底库列表
                "compare_threshold": 0.8,   // double,比对阈值
                "confidence": 7,            // double,关键点信息值
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdateSmartAccess(string device, out string result);

        /**
         * @brief  EnableSmartAccess 使能智能门禁设备
         * @since  V3.20190308
         *
         * @param device 门禁信息
            example: 
            {
                "dev_id": 1,        必填,设备号
                "enabled": true,    必填,使能状态,false:停用,true:启用
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void EnableSmartAccess(string device, out string result);

        /**
         * @brief  DeleteSmartAccess 删除智能人脸门禁机
         * @since  V3.20190308
         *
         * @param device 设备参数
            example:
            {
                "dev_id": 1,        // 设备号
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteSmartAccess(string device, out string result);

        /**
         * @brief  QuerySmartAccess 查询智能人脸门禁机
         * @since  V3.20190308
         * @update V3.20190822 增加云设备支持
         * @update V3.20200217 增加设备进出标识
         * @update V3.20200421 增加设备所属机构ID
         * @update V3.20200428 设备二次比对信息
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,页号
                "page_size": 10         必填,页尺寸
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "dev_id": 0,        选填,设备号
                    "name": "xxx",      选填,设备名，支持模糊匹配
                    "type": 0,          选填,类型,参见《FaceDeviceType》
                    "in_out": 0,        选填,设备进出标识,0:未知,1:进口,2:出口
                    "siteid_list":""    选填,String,设备所属地点id列表
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // 页号
                    "page_size": 10,    // 页尺寸
                    "total_count": 1,   // 总数
                    "items": [
                        {
                            "dev_id": 1,            // 设备号
                            "name": "office",       // 设备名
                            "type": 0,              // 类型,参见《FaceDeviceType》
                            "in_out": 0,            // 设备进出标识,0:未知,1:进口,2:出口
                            "ip": "127.0.0.1",      // 设备IP
                            "port": 8000,           // 设备端口
                            "sn": "xxx",            // 设备序列号号
                            "organ_id":1,           // 设备所属机构id
                            "organ_name":"xx",      // 设备所属机构名称
                            "org_id":1,             // 设备所属机构id
                            "organization":"xx",    // 设备所属机构名称
                            "site_id":1,            // 设备所属地点id
                            "site_name":"xx",       // 设备所属地点名称
                            "sitename":"xx",        // 设备所属地点名称
                            "area_id": 1,           // 区域id
                            "area_name": "",        // 区域名称
                            "enabled": true,        // 门禁控制器使能,默认启用
                            "remark":"xxx",         // 备注
                            "online": true,         // 在线状态,true:在线,false:离线
                            "activation": true,     // 激活状态,true:激活,false:未激活
                            "compare_info": "",     // 设备二次比对信息
                            "update_time":"xxx"     // 更新时间
                        }
                    ]
                }
            }
            【字段】 compare_info 取值:
            {
                "lib_list": [{                      // 底库列表
                        "lib_id": 1,
                        "lib_name": "test"
                    }
                    ....
                ],
                "compare_threshold": 0.8,           // double,比对阈值
                "confidence": 7,                    // double,关键点信息值
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QuerySmartAccess(string cond, out string result);

        /**
         * @brief  UpdateItmRecordState 更新热眸单机版通行记录状态
         * @since  V3.20200427
         *
         * @param record 记录信息
            example: 
            {
                "id": "1",      必填,string,记录id
                "state": 0,     必填,int,处理状态,0:未处理,1:已处理
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdateItmRecordState(string record, out string result);

        /**
         * @brief  DeleteItmAccessRecord 删除热眸单机版通行记录
         * @since  V3.20200427
         *
         * @param record 记录信息
            example: 
            {
                "id": 1,    必填,int,记录id
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteItmAccessRecord(string record, out string result);

        /**
         * @brief  BatchDeleteItmAccessRecord 批量删除热眸单机版通行记录
         * @since  V3.20200427
         *
         * @param record 记录信息
            example: 
            {
                "id_list": 1,    必填,string,记录id列表
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchDeleteItmAccessRecord(string record, out string result);

        /**
         * @brief  QueryItmAccessRecord 查询热眸单机版通行记录
         * @since  V3.20200427
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,页号
                "page_size": 10         必填,页尺寸
                "operator": "admin",    必填,string,操作者
                "org_id": 1,            必填,int,组织id
                "query_cond": {
                    "site_id": 0,           选填,int,地点id
                    "lib_id": 1,            选填,int,底库id
                    "dev_id": 1,            选填,int,门禁id
                    "dev_list": "1,2",      选填,string,设备列表, 以逗号间隔
                    "name": "xxx",          选填,string,人员姓名，模糊匹配
                    "card_no": "",          选填,string,证件号，精确查询
                    "classify": 2,          选填,int,识别分类,参见<ResultClassify>
                    "begin_time": "xxxx",   选填,string,通行时间的查询开始时间，格式：YYYY-MM-DD HH:mm:ss
                    "end_time": "xxxx",     选填,string,通行时间的查询结束时间，格式：YYYY-MM-DD HH:mm:ss
                    "score_min": 0.6,       选填,float,比对的最小得分
                    "score_max": 0.9,       选填,float,比对的最大得分
                    "temperature_min": 36.5 选填,float,最低体温,单位:摄氏度
                    "fever": 1,             选填,int,发烧标记,0:正常,1:发烧
                    "state": 0,             选填,int,处理状态,0:未处理,1:已处理,2:正常,不需要处理
                    "in_out": 0,            选填,int,设备进出标识,0::未知,0:入口,2:出口
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // 页号
                    "page_size": 10,    // 页尺寸
                    "total_count": 1,   // 总数
                    "items": [
                        {
                            "id": 1,                // 记录id
                            "lib_id": 1,            // 底库id
                            "lib_name": 1,          // 底库名
                            "name": "zhangsan",     // 人员姓名
                            "gender": 0,            // 性别，0:未知,1:男,2:女
                            "card_no": "",          // 证件号
                            "group": 2,             // 黑白名单,参见<Whitelist>
                            "category": 0,          // 人员类别,0:未分类
                            "compare_score": 0.98,  // 比对得分
                            "wear_mask": true,      // 是否佩戴口罩
                            "temperature": 36.5,    // 体温,单位:摄氏度
                            "is_fever": true,       // 是否发烧,true:发烧,false:未发烧
                            "classify": 0,          // 识别分类,参见<ResultClassify>
                            "dev_id": 1,            // 设备id
                            "dev_name": "",         // 设备名
                            "in_out": 0,            // 设备进出标识,0:未知,1:进口,2:出口
                            "org_id": 1,            // 组织id
                            "organization": "",     // 组织名
                            "site_id": 1,           // 地址id
                            "site_name": "",        // 地址名
                            "access_time": "2018-08-03 10:30:00",   // 通行时间
                            "capture_time": "2018-08-03 10:30:00",  // 抓拍时间
                            "pic_url": "http://192.168.1.1:8001/p/1.jpg"        // 注册图片URL
                            "capture_url": "http://192.168.1.1:8001/c/1.jpg",   // 抓拍图片URL
                            "state": 0,             // 记录处理状态,0:未处理,1:已处理,2:正常,不需要处理
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryItmAccessRecord(string cond, out string result);

        /**
         * @brief  ActivateSmartAccess 激活云设备（智能门禁）
         * @since  V3.20190822
         *
         * @param action 激活参数
            definition:
            {
                "dev_id": 1,        必填,设备号
                "activation": true  必填,bool,激活参数,true:激活,false:核销
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void ActivateSmartAccess(string action, out string result);

        /**
         * @brief  GetSmartAccessConfig 获取人脸门禁配置
         * @since  V3.20180922
         * @update V3.20200217 增加测温平板配置参数
         *
         * @param cond 配置信息
            example:
            {
                "dev_id": "xx"         必填,设备号
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "config": "{}"      // json-string,配置数据字符串。
                }
            }
            【字段】 config 取值:
            for 纳智门禁
            {
                "show_stranger": 0,     // 显示陌生人，0：隐藏，1：显示
                //"non_living_alarm": 0,// 非活体告警，0：屏蔽，1：告警
                "controller":           // 注意：如果该设备从未配置过，那么该字段可能不存在
                {
                    "ip": "xxx",    // 门禁控制器ip
                    "port": 80,     // 门禁控制器port
                    "out": 1        // 门禁控制器输出口号
                }
            }
            for 测温平板
            {
                "temperature":
                {
                    "high_threshold": 38    // 高温阈值
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void GetSmartAccessConfig(string cond, out string result);

        /**
         * @brief  SetSmartAccessConfig 人脸门禁配置
         * @since  V3.20180922
         * @update V3.20200217 增加测温平板配置参数
         * @update V3.20200506 增加星马设备高级参数配置
         *
         * @param config 配置信息
            example:
            {
                "dev_id": "xx",        必填,设备号
                "config": "{}"         必填,设备配置信息，内容是json字符串。
            }
            【字段】 config 取值:
            for 纳智门禁
            {
                "show_stranger": 0,     // 显示陌生人，0：隐藏，1：显示
                //"non_living_alarm": 0,// 非活体告警，0：屏蔽，1：告警
                "controller":
                {
                    "ip": "xxx",    // 门禁控制器ip
                    "port": 80,     // 门禁控制器port
                    "out": 1        // 门禁控制器输出口号
                }
            }
            for 测温平板
            {
                "temperature":
                {
                    "high_threshold": 38    // 高温阈值
                }
            }
            for 星马设备
            {
                "play_sound": true,             // 必填,bool,播放语音
                "light_off_begin": "",          // 必填,string,灯光关闭开始时间
                "light_off_end": "",            // 必填,string,灯光关闭结束时间
                "show_download_info": true,     // 必填,bool,实时下载弹出提示
                "time_clean_touch": 3,          // 必填,int,触控清空时长，单位秒
                "face_score": 75,               // 必填,int,人脸识别阈值,整数,5的倍数
                "face_range": "",               // 必填,string,人脸识别距离
                "upload_collect_photo": true,   // 必填,bool,采集时上传照片
                "upload_capture_photo": true,   // 必填,bool,识别时上传照片
                "time_face_alarm": 2,           // 必填,int,识别告警时长
                "time_clear_face": 3,           // 必填,int,识别清空时长
                "show_temp_range": true,        // 必填,bool,是否显示测温区域
                "temperature_scale": 1.0,       // 必填,double,测温区域显示比例
                "stranger_mode": true,          // 必填,bool,是否开启陌生人测温模式
                "time_check_stranger": 2,       // 必填,int,陌生人检测时长
                "play_temperature": true,       // 必填,bool,是否播报温度
                "temperature_mode": 0,          // 必填,int,温度显示模式,0:摄氏度,1:华氏度
                "temperature_effective": 35.0,  // 必填,double,温感器生效值
                "temperature_alarm": 37.3,      // 必填,double,温感器报警阈值
                "temperature_offset": 0.0,      // 必填,double,温感器偏移值
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void SetSmartAccessConfig(string config, out string result);

        /**
         -----------------------------------------------------------------------
         智能门禁授权管理
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddSmartAccessAuth 添加智能人脸门禁授权
         * @since  V3.20190315
         * @update V3.20200102 返回授权id
         * @update V3.20200311 修改返回信息
         *
         * @param auth 授权信息
            example:
            {
                "dev_id": 1,                必填,设备id
                "lib_list": "1,2",          必填,底库列表
                "enabled": true,            选填,使能
                "remark": "xx",             选填,备注
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "auth_id": 1,           int,授权id
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddSmartAccessAuth(string auth, out string result);

        /**
         * @brief  UpdateSmartAccessAuth 更新智能人脸门禁授权
         * @since  V3.20190315
         * @update V3.20200311 修改返回信息
         *
         * @param auth 授权信息
            example:
            {
                "auth_id": 1,               必填,授权id
                "lib_list": "1,2",          必填,底库列表
                "enabled": true,            选填,使能
                "remark": "xx",             选填,备注
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdateSmartAccessAuth(string auth, out string result);

        /**
         * @brief  EnableSmartAccessAuth 使能智能门禁授权
         * @since  V3.20190308
         *
         * @param auth 授权信息
            example: 
            {
                "auth_id": 1,       必填,授权id
                "enabled": true,    必填,使能状态,false:停用,true:启用
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void EnableSmartAccessAuth(string auth, out string result);

        /**
         * @brief  DeleteSmartAccessAuth 删除智能人脸门禁授权
         * @since  V3.20190308
         *
         * @param auth 授权信息
            example:
            {
                "auth_id": 1,       必填,序号
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteSmartAccessAuth(string auth, out string result);

        /**
         * @brief  QuerySmartAccessAuth 查询智能人脸门禁授权记录
         * @since  V3.20190308
         * @update V3.20200313 返回人员下发详情
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,页号
                "page_size": 10         必填,页尺寸
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "dev_name": "xxx",      选填,门禁设备名称，支持模糊匹配
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // 页号
                    "page_size": 10,    // 页尺寸
                    "total_count": 1,   // 总数
                    "items": [
                        {
                            "auth_id": 1,           // 序号
                            "dev_id": 1,            // 设备id
                            "dev_name": "lib name", // 设备名称
                            "enabled": true,        // 使能
                            "lib_list": [{"id":1, "name":"xx"}] // 底库列表
                            "remark": "xx",         // 备注
                            "person_count": 10,     // 授权人数
                            "total": 1,             // 总人数
                            "success": 1,           // 成功下发人数
                            "failed": 1,            // 下发失败人员
                            "creator": "xx",        // 创建者
                            "create_time": "xxxx"   // 创建时间
                            "update_time":"xxx"     // 更新时间
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QuerySmartAccessAuth(string cond, out string result);

        /**
         * @brief  AddSmartAccessAuthPerson 添加智能人脸门禁授权人员
         * @since  V3.20190308
         *
         * @param person 授权信息
            example:
            {
                "dev_id": 1,            必填,int,设备id
                "person_list": [
                        {"lib_id":1,"person_id":2}
                    ],                  必填,json,人员列表
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddSmartAccessAuthPerson(string person, out string result);

        /**
         * @brief  DeleteSmartAccessAuthPerson 删除智能人脸门禁授权人员
         * @since  V3.20190308
         *
         * @param person 人员信息
            example:
            {
                "id": 1,        必填,int,授权信息id
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteSmartAccessAuthPerson(string person, out string result);

        /**
         * @brief  BatchDeleteSmartAccessAuthPerson 批量删除智能人脸门禁授权人员
         * @since  V3.20190308
         *
         * @param batch 批量删除参数
            example:
            {
                "id_list": "1,2",   必填,string,授权id列表
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchDeleteSmartAccessAuthPerson(string batch, out string result);

        /**
         * @brief  QuerySmartAccessAuthPerson 查询门禁授权记录人员
         * @since  V3.20190308
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,页号
                "page_size": 10         必填,页尺寸
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "dev_id": 1,                选填,设备id
                    "name": "xxx",              选填,人员姓名，模糊匹配
                    "category": 1,              选填,人员类别，0:未分类
                    "state": 1,                 选填,授权状态，1:授权成功,2:授权失败
                    "begin_time": "xxxx",       选填,授权时间的查询开始时间，格式：YYYY-MM-DD HH:mm:ss
                    "end_time": "xxxx",         选填,授权时间的查询结束时间，格式：YYYY-MM-DD HH:mm:ss
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // 页号
                    "page_size": 10,    // 页尺寸
                    "total_count": 1,   // 总数
                    "items": [
                        {
                            "auth_id": 1,           // 记录id
                            "lib_id": 1,            // 底库id
                            "lib_name": "lib name", // 底库名
                            "name": "zhangsan",     // 人员姓名
                            "gender": 1,            // 性别
                            "card_no": "xxx",       // 证件号
                            "group": 2,             // 黑白名单,参见<Whitelist>
                            "category": 0,          // 人员类别,0:未分类
                            "pic_url": "xx",        // 底库图片
                            "dev_id": 1,            // 门禁设备id
                            "dev_name": "",         // 门禁设备名称
                            "state": 0,             // 授权状态,0:授权失败，1:授权成功
                            "valid_time": {         // 有效时间，格式：YYYY-MM-DD HH:mm:ss
                                "begin_time": "2018-08-03 10:00:00",    // 开始时间，空字符串表示无限期
                                "end_time": "2018-08-03 10:30:00"       // 结束时间，空字符串表示无限期
                            }
                            "auth_time": "2018-08-03 10:30:00"          // 授权时间
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QuerySmartAccessAuthPerson(string cond, out string result);

        /**
         -----------------------------------------------------------------------
         系统配置
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  GetSystemConfig 获取系统配置。
         * @since  V3.20180922
         * @update V3.20190308 增加摄像头全局属性配置，增加迎宾全局讯息配置
                               修改display为advanced，修改compare_constraints_welcome为compare_constraints_default
         * @update V3.20190530 增加解码方式
         * @update V3.20190705 增加陌生人配置
         * @update V3.20200703 增加高阶参数和全局参数的字段
         *
         * @param cond 配置数据。
            example:
            {
                "name": "xx"        必填,string,配置名称：
                                        ConfigNameClient        -前端配置（前段自定义结构）
                                        ConfigNameCamera        -摄像头全局属性配置
                                        ConfigNameAccess        -闸机/门禁配置
                                        ConfigNameServerUser    -服务端配置
                                        ConfigNamePicService    -底库图片服务配置
                                        ConfigNameFileService   -文件服务配置
                                        ConfigNameVideoService  -短视频服务配置
                                        ConfigNameWelcomeMessage-迎宾全局讯息配置
                "operator": "admin" 选填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "config": "{}"      // json-string,配置数据字符串。
                }
            }

            for ConfigNameServerUser:
            配置内容（config）如下：
            {
                "compare_constraints_default": {},          选填  比对约束 默认值
                "compare_constraints_1v1": {},              选填  比对约束 1v1图上比对
                "compare_constraints_retrieve": {},         选填  比对约束 图片检索
                "compare_constraints_capture": {},          选填  比对约束 图片抓拍
                "library_face_constraints_default": {},     选填  底库添加时，人脸是否有效的约束
                "library_face_constraints": {},             选填  底库添加时，人脸是否有效的约束
                "advanced": {}                              选填  全局配置 高级参数
                "history_keep_days": 60,                    选填  历史记录保存天数。由于后台是每10天存一个表，所以最好是每10天一个单位。
                "capture_library_keep_days": 32,            选填  不要超过45
            }
            其中比对约束字段(compare_constraints_default, compare_constraints_1v1, compare_constraints_retrieve, compare_constraints_capture)如下：
            {
                "angle_pitch": 15.0,            // 人脸俯仰角（0忽略）
                "angle_yaw": 15.0,              // 人脸偏航角（0忽略）
                "angle_roll": 15.0,             // 人脸滚转角（0忽略）
                "keypoints_confidence": 0.95,   // 关键点检测信心值
                "compare_threshold": 0.90,      // 比对阈值
            }
            其中底库人脸约束字段(library_face_constraints_default, library_face_constraints)如下：
            {
                "min_face_size": 50,            // 最小人脸大小
                "angle_pitch": 15.0,            // 人脸俯仰角（0忽略）
                "angle_yaw": 15.0,              // 人脸偏航角（0忽略）
                "angle_roll": 15.0,             // 人脸滚转角（0忽略）
                "keypoints_confidence": 0.95,   // 关键点检测信心值
            }
            其中高级参数配置字段(advanced)如下：
            {
                "show_stranger": true,          // 显示陌生人
                "save_stranger": true,          // 记录陌生人
                "double_model": true,           // 开启双模型
                "min_face_size": 50,            // 最小人脸大小
                "compare_threshold": 0.90,      // 比对阈值
                "expand_factor": 1.5,           // 抓拍人脸扩展系数
                "enable_speech": true,          // 语音播报
                "speech_content": "您好",       // 语音内容
                "enable_stranger_library": true,// 启用/禁用陌生人库
                "stranger_storage_days": 90,     // 陌生人库的陌生人存储天数
                "fever_threshold": 38,           // 高温阈值
                "straightface_threshold":0.4,    // 正脸置信度阈值 取值[0.0-1.0]
                "confirmface_threshold" :0.75    // 去重阈值 取值[0.0-1.0]
            }

            for ConfigNameCamera:
            配置内容如下：
            {
                "global_attribute": {
                    "resize_facephoto_width" : 0,      //抓拍照固定尺寸,如果为0,则不进行尺寸压缩 
                    "capture_strategy" : 6,            //抓拍策略,参见<ECaptureStrategy>
                    "capture_interval": 3000,          //抓拍间隔，单位ms
                    "detect_interval": 5,              //检测间隔，每隔多少帧，检测一帧。
                    "keypoints_confidence": 6.0,       //人脸质量得分阈值[0.0-100.0],一般取值6.0
                    "video_codec": 0,                  //解码方式,参见<CodecType>
                    "detectface_threshold":0.9         //检测置信度阈值 取值[0.0-1.0]
                    "definition_threshold":0.0,        //清晰度阈值 取值[0.0-1.0]
                    "facerange_scale": 1.5,            //人脸扩充比例
                    "scene_scale":1.0,                 //全图缩放比例
                    "min_face_size": 40,               //最小人脸框短边长度
                    "skip_frame_interval":1            //解码跳帧,每隔多少帧,解码一帧
                }
            }

            for ConfigNameAccess
            配置内容如下：
            {
                "smart_access": {
                    "show_stranger": 0,     // 显示陌生人，0：隐藏，1：显示
                    "non_living_alarm": 0   // 非活体告警，0：屏蔽，1：告警
                }
            }

            for ConfigNamePicService
            配置内容如下：
            {
                "server_ip": "127.0.0.1",       // 服务器IP
                "server_port": 8001,            // 服务器Port
            }

            for ConfigNameFileService
            配置内容如下：
            {
                "server_ip": "127.0.0.1",       // 服务器IP
                "server_port": 8002,            // 服务器Port
                "keep_days": 60,                // 图片保存天数
                "reserved_space_ratio": 0.1,    // 预留空间
            }

            for ConfigNameVideoService
            配置内容如下：
            {
                "keep_days": 30         // 不要超过45
            }

            for ConfigNameWelcomeMessage
            配置内容如下：
            {
                "global_message": [
                    { "type": 1, "name": "普通类别", "message": "" },
                    { "type": 2, "name": "VIP类别",  "message": "" },
                    { "type": 3, "name": "访客类别", "message": "" }
                ]
            }

            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void GetSystemConfig(string cond, out string result);

        /**
         * @brief  SetSystemConfig 设置系统配置。
         * @since  V3.20180922
         * @update V3.20190308 增加摄像头全局属性配置，增加迎宾全局讯息配置
                               修改display为advanced，修改compare_constraints_welcome为compare_constraints_default
         * @update V3.20190530 增加解码方式
         * @update V3.20190705 增加陌生人配置
         * @update V3.20200326 增加高温阈值
         * @update V3.20200506 增加温度类型
         *
         * @param config 配置数据。
            example:
            {
                "name": "xx"        必填,string,配置名称：
                                        ConfigNameClient        -前端配置（前段自定义结构）
                                        ConfigNameCamera        -摄像头全局属性配置
                                        ConfigNameAccess        -闸机/门禁配置
                                        ConfigNameServerUser    -服务端配置
                                        ConfigNamePicService    -底库图片服务配置
                                        ConfigNameFileService   -文件服务配置
                                        ConfigNameVideoService  -短视频服务配置
                                        ConfigNameWelcomeMessage-迎宾全局讯息配置
                                        ConfigNameInfrared      -双光红外摄像头测温参数配置
                "config": "{}"      必填,json-string,配置数据字符串。
                "operator": "admin" 选填,string,操作者
            }

            for ConfigNameServerUser:
            配置内容如下：
            {
                "compare_constraints_default": {},          选填  比对约束 默认值
                "compare_constraints_1v1": {},              选填  比对约束 1v1图上比对
                "compare_constraints_retrieve": {},         选填  比对约束 图片检索
                "compare_constraints_capture": {},          选填  比对约束 图片抓拍
                "library_face_constraints_default": {},     选填  底库添加时，人脸是否有效的约束
                "library_face_constraints": {},             选填  底库添加时，人脸是否有效的约束
                "advanced": {}                              选填  全局配置 高级参数
                "history_keep_days": 60,                    选填  历史记录保存天数。由于后台是每10天存一个表，所以最好是每10天一个单位。
                "capture_library_keep_days": 32,            选填  不要超过45
            }
            其中比对约束字段(compare_constraints_default, compare_constraints_1v1, compare_constraints_retrieve, compare_constraints_capture)如下：
            {
                "angle_pitch": 15.0,            // 人脸俯仰角（0忽略）
                "angle_yaw": 15.0,              // 人脸偏航角（0忽略）
                "angle_roll": 15.0,             // 人脸滚转角（0忽略）
                "keypoints_confidence": 0.95,   // 关键点检测信心值
                "compare_threshold": 0.90,      // 比对阈值
            }
            其中底库人脸约束字段(library_face_constraints_default, library_face_constraints)如下：
            {
                "min_face_size": 50,            // 最小人脸大小
                "angle_pitch": 15.0,            // 人脸俯仰角（0忽略）
                "angle_yaw": 15.0,              // 人脸偏航角（0忽略）
                "angle_roll": 15.0,             // 人脸滚转角（0忽略）
                "keypoints_confidence": 0.95,   // 关键点检测信心值
            }
            其中高级参数配置字段(advanced)如下：
            {
                "show_stranger": true,          // 显示陌生人
                "save_stranger": true,          // 记录陌生人
                "compare_threshold": 0.90,      // 比对阈值
                "enable_speech": true,          // 语音播报
                "speech_content": "您好",       // 语音内容
                "enable_stranger_library": true,// 启用/禁用陌生人库
                "stranger_storage_days": 90,    // 陌生人库的陌生人存储天数
                "fever_threshold": 38,          // 高温阈值
                "temperature_type": 0,          // 温度类型,0:摄氏度,1:华氏度
                "straightface_threshold":0.4,   // 正脸置信度阈值 取值[0.0-1.0]
                "confirmface_threshold" :0.75   // 去重阈值 取值[0.0-1.0]
            }

            for ConfigNameCamera:
            配置内容如下：
            {
                "global_attribute": {
                    "resize_facephoto_width" : 0,      //抓拍照固定尺寸,如果为0,则不进行尺寸压缩 
                    "capture_strategy" : 6,            //抓拍策略,参见<ECaptureStrategy>
                    "capture_interval": 3000,          //抓拍间隔，单位ms
                    "detect_interval": 5,              //检测间隔，每隔多少帧，检测一帧。
                    "keypoints_confidence": 6.0,       //人脸质量得分阈值[0.0-100.0],一般取值6.0
                    "video_codec": 0,                  //解码方式,参见<CodecType>
                    "detectface_threshold":0.9         //检测置信度阈值 取值[0.0-1.0]
                    "definition_threshold":0.0,        //清晰度阈值 取值[0.0-1.0]
                    "facerange_scale": 1.5,            //人脸扩充比例
                    "scene_scale":1.0,                 //全图缩放比例
                    "min_face_size": 40,               //最小人脸框短边长度
                    "skip_frame_interval":1            //解码跳帧,每隔多少帧,解码一帧
                }
            }

            for ConfigNameAccess
            配置内容如下：
            {
                "smart_access": {
                    "show_stranger": 0,     // 显示陌生人，0：隐藏，1：显示
                    "non_living_alarm": 0   // 非活体告警，0：屏蔽，1：告警
                }
            }

            for ConfigNamePicService
            配置内容如下：
            {
                "server_ip": "127.0.0.1",       // 服务器IP
                "server_port": 8001,            // 服务器Port
            }

            for ConfigNameFileService
            配置内容如下：
            {
                "server_ip": "127.0.0.1",       // 服务器IP
                "server_port": 8002,            // 服务器Port
                "keep_days": 60,                // 图片保存天数
                "reserved_space_ratio": 0.1,    // 预留空间
            }

            for ConfigNameVideoService
            配置内容如下：
            {
                "keep_days": 30         // 不要超过45
            }

            for ConfigNameWelcomeMessage
            配置内容如下：
            {
                "global_message": [
                    { "type": 1, "name": "普通类别", "message": "" },
                    { "type": 2, "name": "VIP类别",  "message": "" },
                    { "type": 3, "name": "访客类别", "message": "" }
                ]
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void SetSystemConfig(string config, out string result);

        /**
         * @brief  SetVisitorConfig 设置访客配置
         * @since  V3.20190308
         *
         * @param config 配置信息
            {
                "lib_id": 1,               必填,int,访客库id
                "visit_area": "1,2"        选填,string,受访区域列表,ALL表示全部
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void SetVisitorConfig(string config, out string result);

        /**
         * @brief  GetVisitorConfig 获取访客配置
         * @since  V3.20190308
         *
         * @param cond 查询条件<预留>
            {
            }
         * @param result json格式的字符串。
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "lib_id": 1,
                    "lib_name": "默认访客库",
                    "visit_area": [
                        {"id":1, "name":"xx"}   // id=0,name=ALL 表示全部
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void GetVisitorConfig(string cond, out string result);

        /**
         * @brief  SetCameraMap 设置摄像头地图。
         * @since  V3.20180922
         *
         * @param vmap 信息
            example:
            {
                "name":xx,          必填,string,名字
                "attribute": "{}",  必填,string,信息
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void SetCameraMap(string vmap, out string result);

        /**
         * @brief  GetCameraMap 获取摄像头地图。
         * @since  V3.20180922
         *
         * @param cond 获取条件
            example:
            {
                "name":xx,          必填,string,名字
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "name": "xx",
                    "attribute": "{}"
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void GetCameraMap(string cond, out string result);

        /**
         -----------------------------------------------------------------------
         检索
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  ComparePicture1v1 1v1照片比对。如果照片中有多张人脸，则只取最大的人脸。
         * @since  V3.20180922
         *
         * @param task 比对信息。
            example:
            {
                "pic_url_left" : ""     必填。左边照片路径，完整的http路径。
                "pic_url_right" : ""    必填。右边照片路径。
                "operator" : ""         选填。
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "pic_url_left": "dsadsas",
                    "pic_url_right": "fsadsa",
                    "compare_score": 0.83,
                    "score_threshold": 0.9
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void ComparePicture1v1(string task, out string result);

        /**
         * @brief  RetrievePicture 静态库图片检索。如果照片中有多张人脸，则只取最大的人脸。
         * @since  V3.20180922
         *
         * @param task 比对信息。
            example:
            {
                "pic_url" :"",      必填。照片路径。上传图片时，返回的相对路径。
                "lib_list" :"1,2",  必填。底库列表，以郑宏给的格式为准。
                                        正确格式  -  "1,2,3"
                                        "ALL"     -  比对所有底库。
                                        ""        -  不比对任何底库。
                                        其他格式  -  直接认为出错。
                "top_num" :5,       必填。检索的人脸数。
                "operator" :""      必填。当前登录的用户名。
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "pic_url": "dsadsas",
                    "score_threshold": 0.9,
                    "compare_results": [
                        {
                            "person_id": 3,             // 人的id。
                            "person_name": "xx",        // 人名。
                            "card_no": "xx",            // 身份证号。
                            "lib_id": 3,                // 底库id。
                            "lib_name": "xx",           // 底库名。
                            "pic_id": 3,                // 人的底库照片id。
                            "pic_url": "xx",            // 人的底库照片路径。
                            "compare_score": 0.24,      // 比对得分。
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void RetrievePicture(string task, out string result);

        /**
         * @brief  RetrieveCaptureLibrary 抓拍库图片检索。如果照片中有多张人脸，则只取最大的人脸。
         * @since  V3.20180922
         *
         * @param task 比对信息。
            example:
            {
                "pic_url" : ""              必填。照片路径。上传图片时，返回的相对路径。
                "video_list" : "1,2,3"      必填。摄像头id列表，id之间以逗号分隔，ALL表示所有。
                "start_date" : ""           必填。YYYY-mm-dd，开始时间。
                "end_date" : ""             必填。YYYY-mm-dd，结束时间。
                "top_num" : 5               必填。检索的人脸数。
                "operator" : ""             必填。操作者。
                "score_threshold" : 0.86    选填。
            }
         * @param result       成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "pic_url": "dsadsas",
                    "score_threshold": 0.9,
                    "compare_results": [
                        {
                            "capture_photo_url": "capture photo url",
                            "capture_scene_url": "capture scene url",
                            "capture_time": "2018-08-02 23:00:00",
                            "video_id": 3,
                            "video_name": "xxx",
                            "video_location": "xcsdad",
                            "compare_score": 0.24,                           // 比对得分
                            "age": 30,
                            "gender": "Female"                              // Male、Female、Unknown
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void RetrieveCaptureLibrary(string task, out string result);

        /**
         * @brief  StartMonitorTask 开始监控任务。
         * @since  V3.20180922
         *
         * @param task 任务信息
            example:
            {
                "task_id": 1,       必填,int,任务id
                "operator": "xx"    选填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void StartMonitorTask(string task, out string result);

        /**
         * @brief  StopMonitorTask 停止监控任务。
         * @since  V3.20180922
         *
         * @param task 任务信息
            example:
            {
                "task_id": 1,       必填,int,任务id
                "operator": "xx"    选填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void StopMonitorTask(string task, out string result);

        /**
         * @brief  StartSignIn 开始签到。
         * @since  V3.20180922
         *
         * @param task 任务guid。
            example:
            {
                "task_id": 1
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void StartSignIn(string task, out string result);

        /**
         * @brief  StartSignOut 开始签退。
         * @since  V3.20180922
         *
         * @param task 任务guid。
            example:
            {
                "task_id": 1
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void StartSignOut(string task, out string result);

        /**
         * @brief  StartFileCaptureTask 开始视频监控任务。
         *        后台会为每个视频开启一个临时监控任务。监控任务会记录到数据表中，但这个数据表不展示出来。
         * @since  V3.20180922
         *
         * @param task 任务信息
            example:
            {
                "file_info": {
                    "file_name": "xxx监控视频",         选填,如果没有此字段，并且是新上传的视频，后台就会生成一个名字。"auto_name_yyyymmdd_hhmmss"
                    "video_url": "aa/bb/cc/dd.mp4"      必填
                },
                "top_num": 5,                           必填,top number.
                "lib_list": "1,2,3",                    选填,如果是所有底库，则传空字符串。
                "alarm_stranger": false,                选填,陌生人是否告警。
                "score_threshold": 0.9,                 选填,比对阈值
                "operator": "xx"                        选填,操作者
            }
         *
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "task_guid": "xcxadfsdafsdads",
                    "video_url": "aa/bb/cc/dd.mp4",
                    "file_name": "xxx监控视频"
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void StartFileCaptureTask(string task, out string result);

        /**
         * @brief  PlayHistoryVideo 查看历史记录附近几秒的视频。
         * @since  V3.20180922
         *
         * @param cond 查询条件。
            example:
            {
                "video_id": 1               必填。视频id。
                "capture_timestamp": 1000   必填。抓拍时间戳。
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "play_url": "http://fds/sfda/dfs.mp4"
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void PlayHistoryVideo(string cond, out string result);

        /**
         * @brief  QueryStartedTaskList 查询所有已经打开的卡口任务信息。
         * @since  V3.20180922
         * @since  V3.20190131 去掉guid
         * @update V3.20200514 添加组织id筛选
         *
         * @param cond 查询条件<保留>。
            example:
            {
                "org_id": 1,            必填,int,组织id
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "items": [
                        {
                            "id": 0,
                            "type": 0,
                            "name": "xx",
                            "videos": [
                                {
                                    "video_id": 1,
                                    "video_name": "",
                                    "rtmp_addr": ""
                                },
                                ...
                            ]
                        },
                        ...
                    ],
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryStartedTaskList(string cond, out string result);

        /**
         * @brief  QueryStartedRtmpList 查询rtmp摄像头。
         * @since  V3.20180922
         * @update V3.20190102 修改task_guid为task_id
         * @update V3.20200507 如果是双光摄像头,则返回信息增加黑体位置信息
         *
         * @param cond 查询条件。
            example:
            {
                "task_id": 1    必填,任务id。
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "items": [
                        {
                            "id" : xx,
                            "video_name": "fdsx",
                            "rtmp_addr": "fdsafsdasd",
                            "type": 4,       //摄像头类型, 双光摄像头时增加此字段 值为4
                            "blackbody_x": -1, //黑体x坐标 如果<0则不设置 以下字段同理
                            "blackbody_y":-1,  //黑体y坐标 如果<0则不设置
                            "infrared_width" : xxx,  //红外光宽度
                            "infrared_hight" : xxx,  //红外光高度
                            "blackbody_temperature" : 36.5  //黑体温度
                        }
                    ],
                    ...
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryStartedRtmpList(string cond, out string result);

        /**
         * @brief  QueryFileTaskList 查询所有已经打开的视频检索任务信息。
         *                           用于判断视频任务是否还在运行。
         * @since  V3.20180922
         *
         * @param cond 查询条件<保留>
            example:
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "items": [
                        {
                            "id": 0,
                            "type": 0,
                            "name": "xx",
                            "videos": [
                                {
                                    "video_id": 1,
                                    "video_name": "",
                                    "rtmp_addr": ""
                                },
                                ...
                            ]
                        },
                        ...
                    ],
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryFileTaskList(string cond, out string result);

        /**
         * @brief  QueryPersonListByTask 根据任务查询人员信息信息。
         * @since  V3.20180922
         *
         * @param cond 查询条件。
            example:
            {
                "page_no": 1, int,  必填，页号
                "page_size":10, int,必填，页尺寸
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "task_id": 1, int,  必填，任务id
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code":0,
                "info":
                {
                    "page_no":1,
                    "page_size":10,
                    "total_count":100,
                    "items":[
                        {
                            "lib_id":3,
                            "lib_name":"haha",
                            "person_id":3,
                            "person_name":"xx",
                            "pic_id":1,
                            "pic_url":"xx"
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryPersonListByTask(string cond, out string result);

        /**
         * @brief  QueryCaptureResult 实时查询抓拍结果。
         * @since  V3.20180922
         * @update V3.20181018 增加识别类型
         * @update V3.20190102 修改参数的task_guid为task_id
         *
         * @param cond 包含id。
            example:
            {
                "task_id": "1,2,3"      // 任务id列表,ALL:表示全部
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "capture_info":
                    {
                        "capture_id": "fdsafsdadsasd",
                        "task_id": 3,
                        "task_name": "xx",
                        "video_id": 2,
                        "video_name": "xxx",
                        "video_location": "video location or video path",
                        "capture_scene_url": "scene image file url",
                        "capture_photo_url": "capture photo file url",
                        "capture_time": "2018-08-02 23:00:00"
                    },
                    "compare_results": [
                        {
                            "lib_id": 1,
                            "lib_name": "lib",
                            "person_id": 1,
                            "person_name": "john",
                            "card_no": "",
                            "group": 2,     // 黑白名单,参见<Whitelist>
                            "category": 0,  // 人员类别,0:未分类
                            "pic_url": "http://ip:port/x.jpg",
                            "compare_score": 0.0,
                            "classify": 0   // 识别分类,参见<ResultClassify>
                        },
                        ...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryCaptureResult(string cond, out string result);

        /**
         * @brief  GetRealtimeCaptureInfo 实时查询抓拍结果。
         * @since  V3.20200505
         * @update V3.20200526 查询条件预留
         *
         * @param cond <预留>
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "alarm_type": 1,    告警类型,1:布控抓拍,2:点名缺席告警,3:进出逗留告警
                    "alarm_info": {}    告警信息,json-array
                }
            }
            for alarm_info:
            {
                "capture_info":
                {
                    "capture_id": "fdsafsdadsasd",
                    "task_id": 3,           // 任务id
                    "task_name": "xx",      // 任务名称
                    "video_id": 2,          // 视频id
                    "video_name": "xxx",    // 视频名称
                    "video_location": "",   // 视频位置或路径
                    "org_id": 1,            // 组织id
                    "organization": "",     // 组织名
                    "site_id": 1,           // 地址id
                    "site_name": "",        // 地址名
                    "wear_mask": true,      // 是否佩戴口罩
                    "temperature": 36.5,    // 体温,单位:摄氏度
                    "is_fever": true,       // 是否发烧,true:发烧,false:未发烧
                    "capture_photo_url": "",// 抓拍人脸照
                    "capture_scene_url": "",// 抓拍场景照
                    "capture_time": "2018-08-02 23:00:00"
                },
                "compare_results": [
                    {
                        "lib_id": 1,            // 底库id
                        "lib_name": "lib",      // 底库名称
                        "person_id": 1,         // 人员id
                        "person_name": "john",  // 姓名
                        "card_no": "",          // 证件号
                        "group": 2,             // 黑白名单,参见<Whitelist>
                        "category": 0,          // 人员类别,0:未分类
                        "pic_url": "http://ip:port/x.jpg",
                        "compare_score": 0.0,   // 比对得分
                        "classify": 0           // 识别分类,参见<ResultClassify>
                        "stranger":             // 陌生人库比对信息,识别为陌生人时有效
                        {
                            "is_first": true,       // 是否首次入库
                            "stranger_id": "",      // 陌生人id
                            "pic_url": "",          // 图片路径
                            "compare_score": 0.0,   // 比对得分
                        }
                    },
                    ...
                ]
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void GetRealtimeCaptureInfo(string cond, out string result);

        /**
         * @brief  GetFaceDeviceRealtimeCaptureInfo 获取智能门禁实时抓拍信息
         * @since  V3.20200505
         * @update V3.20200526 查询条件预留
         *
         * @param cond <预留>
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "alarm_type": 1,    告警类型,4:智能门禁设备抓拍
                    "alarm_info": {}    告警信息,json-array
                }
            }
            for alarm_info:
            {
                "capture_info":
                {
                    "dev_id": 1,            // 设备id
                    "dev_name": "",         // 设备名
                    "in_out": 0,            // 设备进出标识,0:未知,1:进口,2:出口
                    "org_id": 1,            // 组织id
                    "organization": "",     // 组织名
                    "site_id": 1,           // 地址id
                    "site_name": "",        // 地址名
                    "lib_id": 1,            // 底库id
                    "lib_name": 1,          // 底库名
                    "person_id": 1,         // 人员id
                    "name": "zhangsan",     // 人员姓名
                    "gender": 0,            // 性别，0:未知,1:男,2:女
                    "card_no": "",          // 证件号
                    "group": 2,             // 黑白名单,参见<Whitelist>
                    "category": 0,          // 人员类别,0:未分类
                    "compare_score": 0.98,  // 比对得分
                    "wear_mask": true,      // 是否佩戴口罩
                    "temperature": 36.5,    // 体温,单位:摄氏度
                    "is_fever": true,       // 是否发烧,true:发烧,false:未发烧
                    "classify": 0,          // 识别分类,参见<ResultClassify>
                    "capture_time": "",     // 抓拍时间,格式:2018-08-03 10:30:00
                    "pic_url": ""           // 注册图片URL
                    "capture_url": "",      // 抓拍图片URL
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void GetFaceDeviceRealtimeCaptureInfo(string cond, out string result);

        /**
         * @brief  QueryRealtimeResult 实时查询抓拍结果<迎宾>。
         * @since  V3.20180922
         * @update V3.20181009 增加工间点名状态
         * @update V3.20181018 增加识别类型
         * @update V3.20190416 增加入职时间及生日
         * @update V3.20200527 增加组织信息回显
         *
         * @param cond 查询条件
            example:
            {
                "task_id": 1,       选填,int,任务id
                "task_type": 1,     选填,int,任务类型
                "task_list": "1,2"  选填,string,任务id列表,id之间以逗号分隔
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "items":[
                        {
                            "task_id": 3,
                            "task_name": "xx",
                            "task_type": 1,
                            "org_id": 1,            // 组织id
                            "organization": "",     // 组织名
                            "video_id": 2,
                            "video_name": "xx",
                            "video_url": "video location or video path",
                            "person_id": 3,
                            "person_name": "",
                            "group": 2,             // 黑白名单,参见<Whitelist>
                            "category": 0,          // 人员类别,0:未分类
                            "birthday": "",         // 生日,员工有效,格式:YYYY-mm-dd
                            "hiredate": "",         // 入职时间,员工有效,格式:YYYY-mm-dd
                            "company": "",          // 公司名称
                            "position": "",         // 职位
                            "compare_score": 0.9,
                            "classify": 0,          // 识别分类,参见<ResultClassify>
                            "signin": 0,            // 签到/签退状态，0:未开始,1:开始签到,2:开始签退
                            "work_state": 0,        // 工间点名状态，0:未到,1:已到,2:外出
                            "speech_url": "http://ip:port/1.wav",
                            "pic_id": 1,
                            "pic_url": "picture image file path",
                            "capture_photo_url": "capture photo file url",
                            "capture_scene_url": "scene image file url",
                            "capture_time": "2018-08-02 23:00:00",
                            "group_message": "",
                            "personal_message": "",
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryRealtimeResult(string cond, out string result);

        /**
         * @brief  QueryFileCaptureResult 实时查询视频文件的抓拍结果。
         * @since  V3.20180922
         * @update V3.20181018 增加识别类型
         *
         * @param cond 包含id。
            example:
            {
                "task_id": "1"
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "capture_info":
                    {
                        "capture_id": "fdsafsdadsasd",
                        "task_id": 3,
                        "task_name": "xx",
                        "video_id": 2,
                        "video_name": "xxx",
                        "video_location": "video location or video path",
                        "capture_scene_url": "scene image file url",
                        "capture_photo_url": "capture photo file url",
                        "capture_time": "2018-08-02 23:00:00"
                    },
                    "compare_results": [
                        {
                            "lib_id": 1,
                            "lib_name": "lib",
                            "person_id": 1,
                            "person_name": "john",
                            "card_no": "",
                            "group": 2,     // 黑白名单,参见<Whitelist>
                            "category": 0,  // 人员类别,0:未分类
                            "pic_url": "http://ip:port/x.jpg",
                            "compare_score": 0.0,
                            "classify": 0   // 识别分类,参见<ResultClassify>
                        },
                        ...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryFileCaptureResult(string cond, out string result);

        /**
         * @brief  QueryCaptureAlarmList 查询抓拍告警历史记录。
         * @since  V3.20180922
         * @update V3.20181018 增加查询条件及返回识别类型
         * @update V3.20190102 删除task_guid
         * @update V3.20200306 增加口罩识别字段
         * @update V3.20200324 增加人体温度字段
         *
         * @param cond 查询条件。
            example:
            {
                "page_no": 1,       必填。页号。
                "page_size": 10,    必填。页大小。
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "task_id": 1,       选填。任务的id。
                    "task_name": "",    选填。任务名。
                    "capture_id": "",   选填。抓拍照片的guid。
                    "video_id": 1,      选填。视频流id。
                    "lib_id": 1,        选填。底库id，0表示查询所有底库。<废弃>
                    "lib_list": "1,2",  选填。底库id列表，id之间以逗号分隔。与lib_id之间任选其1，首选lib_list。
                    "person_name": "",  选填。人名，模糊查询。
                    "card_no": "",      选填。身份证号，模糊查询。
                    "score_min": 0.86,  选填。比对的最小得分。
                    "classify": 1,      选填。识别分类,参见<ResultClassify>
                    "begin_time": "",   选填。查询的开始时间。
                    "end_time": "",     选填。查询的结束时间。
                    "task_type": 1,     必填。为hist_camera_capture或hist_file_capture,如果是hist_file_capture，则会解析以下参数
                    "file_url": ""      选填。视频流地址，通过这个地址获取video信息，再查询历史记录。如果不传这个地址，就会使用videoId字段。
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": 
                {
                    "page_no": 2,
                    "page_size": 10,
                    "total_count": 1024,
                    "items": [
                        {
                            "capture_history_id": 3                 // 抓拍表的id。
                            "task_id": 3,                           // 任务id。
                            "task_name": "xxx",                     // 任务名。
                            "video_id": 3,                          // 视频流id。
                            "video_name": "xx",                     // 视频流名称。
                            "video_location": "xxx",                // 视频流所在位置。
                            "capture_scene_url": "xx",              // 抓拍的场景图片地址。
                            "capture_photo_url": "xx",              // 抓拍的头像图片地址。
                            "score_threshold": 0.85,                // 阈值。
                            "age": 32,                              // 年龄。
                            "gender": "Male",                       // 性别。Male、Female、Unknown。
                            "angle_pitch": 15.0,                    // 人脸俯仰角。
                            "angle_yaw": 15.0,                      // 人脸偏航角。
                            "angle_roll": 15.0,                     // 人脸滚转角。
                            "temperature": 36.5,                    // 体温,单位:摄氏度
                            "is_fever": false,                      // 是否发烧,true:发烧,false:未发烧
                            "wear_mask": true,                      // 是否佩戴口罩
                            "consuming_msec": 3000,                 // 抓拍和比对耗时，单位ms。
                            "capture_time": "xxxx-xx-xx xx:xx:xx",  // 抓拍的时间。
                            "capture_timestamp": 4314321432143232,  // 抓拍的时间戳。
                            "compare_results": [
                                {
                                    "compare_history_id": 2,        // 比对表的记录id。
                                    "lib_id": 3,                    // 底库id。
                                    "lib_name": "xx",               // 底库名。
                                    "person_id": 3,                 // 人的id。
                                    "person_name": "xx",            // 人名。
                                    "card_no": "xx",                // 身份证号。
                                    "group": 2,                     // 黑白名单,参见<Whitelist>
                                    "category": 0,                  // 人员类别,0:未分类
                                    "pic_id": 3,                    // 人的底库照片id。
                                    "pic_url": "xx",                // 人的底库照片路径。
                                    "compare_score": 0.24,          // 比对得分。
                                    "classify": 0                   // 识别分类,参见<ResultClassify>
                                }
                            ]
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryCaptureAlarmList(string cond, out string result);

        /**
         * @brief  QueryDynamicAlarmList 查询抓拍和告警历史记录。
         * @since  V3.20190620
         * @update V3.20200306 增加口罩识别字段
         * @update V3.20200324 增加人体温度字段
         *
         * @param cond 查询条件。
            example:
            {
                "page_no": 1,       必填。页号。
                "page_size": 10,    必填。页大小。
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "task_id": 1,       选填。任务的id。
                    "task_name": "",    选填。任务名。
                    "capture_id": "",   选填。抓拍照片的guid。
                    "video_id": 1,      选填。视频流id。
                    "lib_id": 1,        选填。底库id，0表示查询所有底库。<废弃>
                    "lib_list": "1,2",  选填。底库id列表，id之间以逗号分隔。与lib_id之间任选其1，首选lib_list。
                    "person_name": "",  选填。人名，模糊查询。
                    "card_no": "",      选填。身份证号，模糊查询。
                    "score_min": 0.86,  选填。比对的最小得分。
                    "classify": 1,      选填。识别分类,参见<ResultClassify>
                    "begin_time": "",   选填。查询的开始时间。
                    "end_time": "",     选填。查询的结束时间。
                    "task_type": 1,     必填。为hist_camera_capture或hist_file_capture,如果是hist_file_capture，则会解析以下参数
                    "file_url": ""      选填。视频流地址，通过这个地址获取video信息，再查询历史记录。如果不传这个地址，就会使用videoId字段。
                    "temperature_min": 36.5, 选填,float,最低体温,单位:摄氏度
                    "fever": 1               选填,int,发烧标记,0:正常,1:发烧
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": 
                {
                    "page_no": 2,
                    "page_size": 10,
                    "total_count": 1024,
                    "items": [
                        {
                            "capture_history_id": 3                 // 抓拍表的id。
                            "task_id": 3,                           // 任务id。
                            "task_name": "xxx",                     // 任务名。
                            "video_id": 3,                          // 视频流id。
                            "video_name": "xx",                     // 视频流名称。
                            "video_location": "xxx",                // 视频流所在位置。
                            "capture_scene_url": "xx",              // 抓拍的场景图片地址。
                            "capture_photo_url": "xx",              // 抓拍的头像图片地址。
                            "score_threshold": 0.85,                // 阈值。
                            "age": 32,                              // 年龄。
                            "gender": "Male",                       // 性别。Male、Female、Unknown。
                            "angle_pitch": 15.0,                    // 人脸俯仰角。
                            "angle_yaw": 15.0,                      // 人脸偏航角。
                            "angle_roll": 15.0,                     // 人脸滚转角。
                            "temperature": 36.5,                    // 体温,单位:摄氏度
                            "is_fever": false,                      // 是否发烧,true:发烧,false:未发烧
                            "wear_mask": true,                      // 是否佩戴口罩
                            "consuming_msec": 3000,                 // 抓拍和比对耗时，单位ms。
                            "capture_time": "xxxx-xx-xx xx:xx:xx",  // 抓拍的时间。
                            "capture_timestamp": 4314321432143232,  // 抓拍的时间戳。
                            "compare_results": [
                                {
                                    "compare_history_id": 2,        // 比对表的记录id。
                                    "lib_id": 3,                    // 底库id。
                                    "lib_name": "xx",               // 底库名。
                                    "person_id": 3,                 // 人的id。
                                    "person_name": "xx",            // 人名。
                                    "card_no": "xx",                // 身份证号。
                                    "group": 2,                     // 黑白名单,参见<Whitelist>
                                    "category": 0,                  // 人员类别,0:未分类
                                    "pic_id": 3,                    // 人的底库照片id。
                                    "pic_url": "xx",                // 人的底库照片路径。
                                    "compare_score": 0.24,          // 比对得分。
                                    "classify": 0                   // 识别分类,参见<ResultClassify>
                                }
                            ]
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryDynamicAlarmList(string cond, out string result);

        /**
         * @brief  QueryCapturePhotoList 查询抓拍照片历史记录。
         * @since  V3.20180922
         * @update V3.20181018 去掉陌生人标记
         * @update V3.20190102 删除task_guid
         * @update V3.20200306 增加口罩识别字段
         * @update V3.20200324 增加人体温度字段
         *
         * @param cond 查询条件。
            example:
            {
                "page_no": 1,       必填。页号。
                "page_size": 10,    必填。页大小。
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "task_id": 1,       选填。任务的id。
                    "task_name": "",    选填。任务名。
                    "capture_id": "",   选填。抓拍照片的guid。
                    "video_id": 1,      选填。视频流id。
                    "begin_time": "",   选填。查询的开始时间。
                    "end_time": "",     选填。查询的结束时间。
                    "task_type": "",    必填。为hist_camera_capture或hist_file_capture,如果是hist_file_capture，则会解析以下参数
                    "file_url": ""      选填。视频流地址，通过这个地址获取video信息，再查询历史记录。如果不传这个地址，就会使用videoId字段。
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": 
                {
                    "page_no": 2,
                    "page_size": 10,
                    "total_count": 1024,
                    "items": [
                        {
                            "capture_history_id": 3                 // 抓拍表的id。
                            "task_id": 3,                           // 任务id。
                            "task_name": "xxx",                     // 任务名。
                            "video_id": 3,                          // 视频流id。
                            "video_name": "xx",                     // 视频流名称。
                            "video_location": "xxx",                // 视频流所在位置。
                            "capture_scene_url": "xx",              // 抓拍的场景图片地址。
                            "capture_photo_url": "xx",              // 抓拍的头像图片地址。
                            "age": 32,                              // 年龄。
                            "gender": "Male",                       // 性别。Male、Female、Unknown。
                            "angle_pitch": 15.0,                    // 人脸俯仰角。
                            "angle_yaw": 15.0,                      // 人脸偏航角。
                            "angle_roll": 15.0,                     // 人脸滚转角。
                            "temperature": 36.5,                    // 体温,单位:摄氏度
                            "is_fever": false,                      // 是否发烧,true:发烧,false:未发烧
                            "wear_mask": true,                      // 是否佩戴口罩
                            "capture_time": "xxxx-xx-xx xx:xx:xx",  // 抓拍的时间。
                            "capture_timestamp": 4314321432143232,  // 抓拍的时间戳。
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryCapturePhotoList(string cond, out string result);

        /**
         * @brief  QueryRetrieveHistoryList 查询图片检索历史记录。
         * @since  V3.20180922
         *
         * @param cond 查询条件。
            example:
            {
                "page_no" : 1       必填。页号。
                "page_size" : 10    必填。页大小。
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "lib_id" : 1        选填。底库id，0表示查询所有底库。
                    "person_name" : ""  选填。人名，模糊查询。
                    "card_no" : ""      选填。身份证号，模糊查询。
                    "begin_time" : ""   选填。查询的开始时间。
                    "end_time" : ""     选填。查询的结束时间。
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": 
                {
                    "page_no": 2,
                    "page_size": 10,
                    "total_count": 1024,
                    "items": [
                        {
                            "retrieve_history_id": 3                // 检索图片表的id
                            "retrieve_scene_url": "xx",             // 检索图片的地址。
                            "consuming_msec": 3000,                 // 检索耗时，单位ms。
                            "retrieve_time": "xxxx-xx-xx xx:xx:xx", // 检索的时间。
                            "compare_results": [
                                {
                                    "compare_history_id": 2,    // 比对表的id。
                                    "person_id": 3,             // 人的id。
                                    "person_name": "xx",        // 人名。
                                    "card_no": "xx",            // 身份证号。
                                    "lib_id": 3,                // 底库id。
                                    "lib_name": "xx",           // 底库名。
                                    "pic_id": 3,                // 人的底库照片id。
                                    "pic_url": "xx",            // 人的底库照片路径。
                                    "compare_score": 0.24,      // 比对得分。
                                }
                            ]
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryRetrieveHistoryList(string cond, out string result);

        /**
         * @brief  QueryRetrieveCaptureLibraryList 查询抓拍库图片检索历史记录。
         * @since  V3.20180922
         *
         * @param cond 查询条件。
            example:
            {
                "page_no" : 1       必填。页号。
                "page_size" : 10    必填。页大小。
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "begin_time" : ""   选填。查询的开始时间。
                    "end_time" : ""     选填。查询的结束时间。
                    "video_id" : 1      选填。视频流id。
                }
            }
         * @param result    成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": 
                {
                    "page_no": 2,
                    "page_size": 10,
                    "total_count": 1024,
                    "items": [
                        {
                            "retrieve_history_id": 3                 // 检索图片表的id。
                            "retrieve_scene_url": "xx",              // 检索图片的地址。
                            "consuming_msec": 3000,                  // 检索耗时，单位ms。
                            "retrieve_time": "xxxx-xx-xx xx:xx:xx",  // 检索的时间。
                            "compare_results": [
                                {
                                    "compare_history_id": 2,                          // 比对表的id。
                                    "capture_id": "capture url",
                                    "capture_photo_url": "capture photo url",
                                    "capture_scene_url": "capture scene url",
                                    "capture_time": "2018-08-02 23:00:00",
                                    "video_id": 3,
                                    "video_name": "xxx",
                                    "video_location": "xcsdad",
                                    "compare_score": 0.24,                           // 比对得分
                                    "age": 30,
                                    "gender": "Female"                              // Male、Female、Unknown
                                }
                            ]
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryRetrieveCaptureLibraryList(string cond, out string result);

        /**
         * @brief  QueryHistory 查询人脸识别历史列表。
         * @since  V3.20180922
         * @update V3.20181018 增加识别类型
         * @update V3.20200306 增加口罩识别字段
         * @update V3.20200324 增加人体温度字段
         *
         * @param cond 搜索相关信息
            example:
            {
                "page_no":xx,       必填,int,页号
                "page_size":xx      必填,int,每页个数
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "task_id":xx,       选填,int,任务id
                    "video_id":xx,      选填,int,摄像头id
                    "lib_id":xx,        选填,int,低库id
                    "person_name":xx,   选填,string,人员姓名，模糊查询
                    "card_no":xx,       选填,string,人员证件号，模糊查询
                    "score_min":xx,     选填,float,比对的最小得分
                    "score_max":xx,     选填,float,比对的最大得分
                    "begin_time":xx,    选填,string,查询的开始时间
                    "end_time":xx,      选填,string,查询的结束时间
                    "temperature_min": 36.5, 选填,float,最低体温,单位:摄氏度
                    "fever": 1,              选填,int,发烧标记,0:正常,1:发烧
                    "siteid_list":""         选填,String,待查询地点id列表
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info":
                {
                    "page_no":xx,
                    "page_size":xx,
                    "total_count":xx,
                    "items": [
                        {
                            "id": 1,            int,记录id
                            "person_id": 0,     int,人员id
                            "person_name": "xx",string,人员姓名
                            "gender": 1,        int,性别 0：未知,1：男,2：女
                            "card_no": "xx",    string,证件号
                            "group": 2,         int,黑白名单,参见<Whitelist>
                            "category": 0,      int,人员类别,0:未分类
                            "lib_name": "xxx",  string,底库名
                            "video_name": "xxx",string,摄像头名
                            "temperature": 36.5,string,体温,单位:摄氏度
                            "is_fever": false,  bool,是否发烧,true:发烧,false:未发烧
                            "wear_mask": true,  bool,是否佩戴口罩
                            "pic_url": "xxx",   string,底库照片路径
                            "org_id": 1,        int,组织id
                            "organization": "", string,组织名
                            "site_id": 1,       int,地址id
                            "site_name": "",    string,地址名
                            "capture_photo_url": "xxx",string,抓拍头像的url
                            "capture_scene_url": "xxx",string,抓拍场景的url
                            "compare_score":0.8,    float,比对得分
                            "classify": 0,          int,识别分类,参见<ResultClassify>
                            "check_time": "xxx",    string,比对时间
                        },...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryHistory(string cond, out string result);

        /**
         * @brief  DeleteHistory 删除人脸识别历史记录
         * @since  V3.20190308
         *
         * @param record 记录信息
            example:
            {
                "id": 1,    必填,int,记录id
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteHistory(string record, out string result);

        /**
         * @brief  BatchDeleteHistory 删除人脸识别历史记录
         * @since  V3.20190308
         *
         * @param batch 批量删除参数
            example:
            {
                "id_list": "1,2",   必填,string,记录id列表
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchDeleteHistory(string batch, out string result);

         /**
         * @brief  QueryStrangerHistory 查询陌生人识别历史列表。
         * @since  V3.20190712
         * @update V3.20200306 增加口罩识别字段
         * @update V3.20200324 增加人体温度字段
         *
         * @param cond 搜索相关信息
            example:
            {
                "page_no":xx,       必填,int,页号
                "page_size":xx      必填,int,每页个数
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "task_id":xx,       选填,int,任务id
                    "video_id":xx,      选填,int,摄像头id
                    "score_min":xx,     选填,float,比对的最小得分
                    "begin_time":xx,    选填,string,查询的开始时间
                    "end_time":xx,      选填,string,查询的结束时间
                    "temperature_min": 36.5, 选填,float,最低体温,单位:摄氏度
                    "fever": 1               选填,int,发烧标记,0:正常,1:发烧
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info":
                {
                    "page_no":xx,
                    "page_size":xx,
                    "total_count":xx,
                    "items": [
                        {
                            "id": 1,                int,记录id
                            "stranger_id": "xx",    string,识别编码
                            "age": 1,               int,年龄
                            "gender": 1,            int,性别 0：未知,1：男,2：女
                            "pic_path": "xx",       string,图片路径
                            "temperature": 36.5,    string,体温,单位:摄氏度
                            "is_fever": false,      bool,是否发烧,true:发烧,false:未发烧
                            "wear_mask": true,      bool,是否佩戴口罩
                            "compare_score":0.8,    float,比对得分
                            "video_name": "xxx",    string,摄像头名
                            "task_name": "xxx",     string,任务名
                            "capture_photo_url": "xxx",string,抓拍头像的url
                            "capture_scene_url": "xxx",string,抓拍场景的url
                            "create_time": "xxx",   string,创建时间
                        },...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryStrangerHistory(string cond, out string result);

        /**
         * @brief  DeleteStrangerHistory 删除陌生人识别历史记录
         * @since  V3.20190712
         *
         * @param record 记录信息
            example:
            {
                "id": 1,    必填,int,记录id
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteStrangerHistory(string record, out string result);

        /**
         * @brief  BatchDeleteStrangerHistory 批量删除陌生人识别历史记录
         * @since  V3.201903712
         *
         * @param batch 批量删除参数
            example:
            {
                "id_list": "1,2",   必填,string,记录id列表
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchDeleteStrangerHistory(string batch, out string result);

        /**
         * @brief  QueryLatestSmartAccessRecord 查询最近的智能门禁通行记录 【废弃】
         * @since  V3.2020/02/26
         * @update V3.20200306 增加口罩识别字段
         *
         * @param cond 查询条件
            example:
            {
                "person_id": 1,     必填,int,人员id
                "number": 10,       选填,int,数量,默认为10
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "items": [
                        {
                            "id": 1,                // 记录id
                            "lib_id": 1,            // 底库id
                            "lib_name": 1,          // 底库名
                            "name": "zhangsan",     // 人员姓名
                            "gender": 0,            // 性别，0:未知,1:男,2:女
                            "card_no": "",          // 证件号
                            "group": 2,             // 黑白名单,参见<Whitelist>
                            "category": 0,          // 人员类别,0:未分类
                            "compare_score": 0.98,  // 比对得分
                            "wear_mask": true,      // 是否佩戴口罩
                            "temperature": 36.5,    // 体温,单位:摄氏度
                            "is_fever": true,       // 是否发烧,true:发烧,false:未发烧
                            "classify": 0,          // 识别分类,参见<ResultClassify>
                            "dev_id": 1,            // 设备id
                            "dev_name": "",         // 设备名
                            "in_out": 0,            // 设备进出标识,0:未知,1:进口,2:出口
                            "access_time": "2018-08-03 10:30:00",   // 通行时间
                            "capture_time": "2018-08-03 10:30:00",  // 抓拍时间
                            "pic_url": "http://192.168.1.1:8001/p/1.jpg"        // 注册图片URL
                            "capture_url": "http://192.168.1.1:8001/c/1.jpg",   // 抓拍图片URL
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryLatestSmartAccessRecord(string cond, out string result);
        
        /**
         * @brief  QueryLatestCaptureRecord 查询最近的人员抓拍记录
         * 此接口替代QueryLatestSmartAccessRecord接口
         * @since  V3.2020/03/27
         *
         * @param cond 查询条件
            example:
            {
                "alarm_type": 1,    告警类型,1:布控抓拍,2:点名缺席告警,3:进出逗留告警,4:智能门禁设备抓拍
                "person_id": 1,     必填,int,人员id
                "number": 10,       选填,int,数量,默认为10
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "items": [
                        {
                            "id": 1,                // 记录id
                            "lib_id": 1,            // 底库id
                            "lib_name": 1,          // 底库名
                            "name": "zhangsan",     // 人员姓名
                            "gender": 0,            // 性别，0:未知,1:男,2:女
                            "card_no": "",          // 证件号
                            "group": 2,             // 黑白名单,参见<Whitelist>
                            "category": 0,          // 人员类别,0:未分类
                            "compare_score": 0.98,  // 比对得分
                            "wear_mask": true,      // 是否佩戴口罩
                            "temperature": 36.5,    // 体温,单位:摄氏度
                            "is_fever": true,       // 是否发烧,true:发烧,false:未发烧
                            "classify": 0,          // 识别分类,参见<ResultClassify>
                            "dev_id": 1,            // 设备id
                            "dev_name": "",         // 设备名
                            "in_out": 0,            // 设备进出标识,0:未知,1:进口,2:出口
                            "access_time": "2018-08-03 10:30:00",   // 通行时间
                            "capture_time": "2018-08-03 10:30:00",  // 抓拍时间
                            "pic_url": "http://192.168.1.1:8001/p/1.jpg"        // 注册图片URL
                            "capture_url": "http://192.168.1.1:8001/c/1.jpg",   // 抓拍图片URL
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryLatestCaptureRecord(string cond, out string result);

        /**
         * @brief  QuerySmartAccessRecord 查询智能门禁通行记录
         * @since  V3.20190308
         * @update V3.20200217 增加支持设备列表查询条件
         * @update V3.20200217 增加支持体温查询条件
         * @update V3.20200306 增加口罩识别字段
         * @update V3.20200508 增加组织信息回填
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,页号
                "page_size": 10         必填,页尺寸
                "operator": "admin",    必填,string,操作者
                "org_id": 1,            必填,int,组织id
                "query_cond": {
                    "lib_id": 1,            选填,int,底库id
                    "dev_id": 1,            选填,int,门禁id
                    "dev_list": "1,2",      选填,string,设备列表, 以逗号间隔
                    "name": "xxx",          选填,string,人员姓名，模糊匹配
                    "card_no": "",          选填,string,证件号，精确查询
                    "classify": 2,          选填,int,识别分类,参见<ResultClassify>
                    "begin_time": "xxxx",   选填,string,通行时间的查询开始时间，格式：YYYY-MM-DD HH:mm:ss
                    "end_time": "xxxx",     选填,string,通行时间的查询结束时间，格式：YYYY-MM-DD HH:mm:ss
                    "score_min": 0.6,       选填,float,比对的最小得分
                    "score_max": 0.9,       选填,float,比对的最大得分
                    "temperature_min": 36.5 选填,float,最低体温,单位:摄氏度
                    "fever": 1,             选填,int,发烧标记,0:正常,1:发烧
                    "siteid_list":""        选填,String,待查询地点id列表
                    "site_list":""        选填,String,待查询地点id列表
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // 页号
                    "page_size": 10,    // 页尺寸
                    "total_count": 1,   // 总数
                    "items": [
                        {
                            "id": 1,                // 记录id
                            "lib_id": 1,            // 底库id
                            "lib_name": 1,          // 底库名
                            "name": "zhangsan",     // 人员姓名
                            "gender": 0,            // 性别，0:未知,1:男,2:女
                            "card_no": "",          // 证件号
                            "group": 2,             // 黑白名单,参见<Whitelist>
                            "category": 0,          // 人员类别,0:未分类
                            "compare_score": 0.98,  // 比对得分
                            "wear_mask": true,      // 是否佩戴口罩
                            "temperature": 36.5,    // 体温,单位:摄氏度
                            "is_fever": true,       // 是否发烧,true:发烧,false:未发烧
                            "classify": 0,          // 识别分类,参见<ResultClassify>
                            "dev_id": 1,            // 设备id
                            "dev_name": "",         // 设备名
                            "in_out": 0,            // 设备进出标识,0:未知,1:进口,2:出口
                            "org_id": 1,            // 组织id
                            "organization": "",     // 组织名
                            "site_id": 1,           // 地址id
                            "site_name": "",        // 地址名
                            "access_time": "2018-08-03 10:30:00",   // 通行时间
                            "capture_time": "2018-08-03 10:30:00",  // 抓拍时间
                            "pic_url": "http://192.168.1.1:8001/p/1.jpg"        // 注册图片URL
                            "capture_url": "http://192.168.1.1:8001/c/1.jpg",   // 抓拍图片URL
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QuerySmartAccessRecord(string cond, out string result);

        /**
         * @brief  DeleteSmartAccessRecord 删除智能门禁通行记录
         * @since  V3.20190308
         *
         * @param record 记录信息
            example: 
            {
                "id": 1,    必填,int,记录id
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteSmartAccessRecord(string record, out string result);

        /**
         * @brief  BatchDeleteSmartAccessRecord 批量删除智能门禁通行记录
         * @since  V3.20190308
         *
         * @param batch 批量删除参数
            example: 
            {
                "id_list": "1,2",   必填,string,记录id列表
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchDeleteSmartAccessRecord(string batch, out string result);

        /**
         * @brief   QuerySmartIcCardRecord 查询智能门禁IC卡通行记录
         * @since  V3.20190508
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,页号
                "page_size": 10         必填,页尺寸
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "dev_id": 1,            选填,门禁id
                    "ic_card_no": "",       选填,IC卡号，精确匹配
                    "begin_time": "xxxx",   选填,通行时间的查询开始时间，格式：YYYY-MM-DD HH:mm:ss
                    "end_time": "xxxx",     选填,通行时间的查询结束时间，格式：YYYY-MM-DD HH:mm:ss
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // 页号
                    "page_size": 10,    // 页尺寸
                    "total_count": 1,   // 总数
                    "items": [
                        {
                            "id": 1,                // 记录id
                            "name": "zhangsan",     // 人员姓名
                            "card_no": "",          // 证件号
                            "category": 0,          // 人员类别,0:未分类
                            "ic_card_no": "",       // IC卡号
                            "dev_id": 1,            // 设备id
                            "dev_name": "",         // 设备名
                            "in_out": 0,            // 设备进出标识,0:未知,1:进口,2:出口
                            "access_time": "",      // 通行时间，格式：2018-08-03 10:30:00
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QuerySmartIcCardRecord(string cond, out string result);

        /**
         * @brief   DeleteSmartAccessIcCardRecord 删除智能门禁IC卡通行记录  
         * @since   V3.20190508
         *
         * @para record 记录信息
            example:
            {
                "id": 1,    必填,int,记录id
            }
         * @para result 成功或失败。例
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
         void DeleteSmartAccessIcCardRecord(string record, out string result);

         /**
         * @brief  BatchDeleteSmartAccessIcCardRecord 批量删除智能门禁IC卡通行记录
         * @since  V3.20190508
         *
         * @param batch 批量删除参数
            example: 
            {
                "id_list": "1,2",   必填,string,记录id列表
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchDeleteSmartAccessIcCardRecord(string batch, out string result);

        /**
         * @brief   QuerySmartIdCardRecord 查询智能门禁身份证通行记录
         * @since  V3.20190508
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,页号
                "page_size": 10         必填,页尺寸
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "dev_id": 1,            选填,门禁id
                    "name":"",              选填,人员姓名,模糊匹配
                    "card_no": "",          选填,IC卡号，精确匹配
                    "begin_time": "xxxx",   选填,通行时间的查询开始时间，格式：YYYY-MM-DD HH:mm:ss
                    "end_time": "xxxx",     选填,通行时间的查询结束时间，格式：YYYY-MM-DD HH:mm:ss
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // 页号
                    "page_size": 10,    // 页尺寸
                    "total_count": 1,   // 总数
                    "items": [
                        {
                            "id": 1,                // 记录id
                            "name": "zhangsan",     // 人员姓名
                            "card_no": "",          // 证件号
                            "dev_id": 1,            // 设备id
                            "dev_name": "",         // 设备名
                            "in_out": 0,            // 设备进出标识,0:未知,1:进口,2:出口
                            "access_time": "",      // 通行时间，格式：2018-08-03 10:30:00
                            "id_photo_url": "",     // 身份证照片URL
                            "capture_url": "",      // 抓拍图片URL，例：http://192.168.1.1:8001/c/1.jpg
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QuerySmartIdCardRecord(string batch, out string result);

        /**
         * @brief   DeleteSmartAccessIdCardRecord 删除智能门禁身份证通行记录  
         * @since   V3.20190508
         *
         * @para record 记录信息
            example:
            {
                "id":1,      必填,int,记录id
            }
         * @para result 成功或失败。例
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
         void DeleteSmartAccessIdCardRecord(string record, out string result);

         /**
         * @brief  BatchDeleteSmartAccessIdCardRecord 批量删除智能门禁身份证通行记录
         * @since  V3.20190508
         *
         * @param batch 批量删除参数
            example: 
            {
                "id_list": "1,2",   必填,string,记录id列表
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchDeleteSmartAccessIdCardRecord(string batch, out string result);

        /**
         * @brief  QueryGeneralAccessRecord 查询普通门禁通行记录
         * @since  V3.20190308
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,页号
                "page_size": 10         必填,页尺寸
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "lib_id": 1,            选填,底库id
                    "dev_id": 1,            选填,门禁id
                    "name": "xxx",          选填,人员姓名，模糊匹配
                    "card_no": "",          选填,证件号，精确查询
                    "classify": 2,          选填,识别分类,参见<ResultClassify>
                    "begin_time": "xxxx",   选填,通行时间的查询开始时间，格式：YYYY-MM-DD HH:mm:ss
                    "end_time": "xxxx",     选填,通行时间的查询结束时间，格式：YYYY-MM-DD HH:mm:ss
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // 页号
                    "page_size": 10,    // 页尺寸
                    "total_count": 1,   // 总数
                    "items": [
                        {
                            "id": 1,                // 记录id
                            "lib_id": 1,            // 底库id
                            "lib_name": 1,          // 底库名
                            "name": "zhangsan",     // 人员姓名
                            "gender": 0,            // 性别，0:未知,1:男,2:女
                            "card_no": "",          // 证件号
                            "group": 2,             // 黑白名单,参见<Whitelist>
                            "category": 0,          // 人员类别,0:未分类
                            "compare_score": 0.98,  // 比对得分
                            "classify": 0,          // 识别分类,参见<ResultClassify>
                            "dev_id": 1,            // 设备id
                            "dev_name": "",         // 设备名
                            "access_time": "2018-08-03 10:30:00",   // 通行时间
                            "capture_time": "2018-08-03 10:30:00",  // 抓拍时间
                            "pic_url": "http://192.168.1.1:8001/p/1.jpg"        // 注册图片URL
                            "capture_url": "http://192.168.1.1:8001/c/1.jpg",   // 抓拍图片URL
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryGeneralAccessRecord(string cond, out string result);

        /**
         * @brief  DeleteGeneralAccessRecord 删除普通门禁通行记录
         * @since  V3.20190308
         *
         * @param record 记录信息
            example: 
            {
                "id": 1,    必填,int,记录id
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteGeneralAccessRecord(string record, out string result);

        /**
         * @brief  BatchDeleteGeneralAccessRecord 批量删除普通门禁通行记录
         * @since  V3.20190308
         *
         * @param batch 批量删除参数
            example: 
            {
                "id_list": "1,2",   必填,string,记录id列表
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchDeleteGeneralAccessRecord(string batch, out string result);

        /**
         * @brief  QuerySigninRecord 查询签到记录。
         * @since  V3.20180922
         *
         * @param cond 查询条件。
            example:
            {
                "page_no": 1, int,      必填，页号
                "page_size":10, int,    必填，页尺寸
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "begin_time":xx, string,    选填，签到开始时间
                    "end_time":xx, string,      选填，签到结束时间
                    "task_name":xx, string,     选填，任务名，支持模糊匹配
                    "person_name":xx, string,   选填，人名，支持模糊匹配
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code":0,
                "info":
                {
                    "page_no":1,
                    "page_size":10,
                    "total_count":100,
                    "items":[
                        {
                            "task_id":3,
                            "task_name":"xx",
                            "lib_id":3,
                            "lib_name":"haha",
                            "person_id":3,
                            "person_name":"xx",
                            "gender":1,
                            "card_no":"xx",
                            "pic_id":1,
                            "pic_url":"xx",
                            "signin_time":"xx",
                            "signin_score":0,
                            "signin_photo_url":"xx",
                            "signin_scene_url":"xx",
                            "signout_time":"xx",
                            "signout_score":0,
                            "signout_photo_url":"xx",
                            "signout_scene_url":"xx"
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QuerySigninRecord(string cond, out string result);

        /**
         * @brief  GetLatestGroupAlarmInfo 获取最新的联号告警信息
         * @since  V3.20180922
         *
         * @param cond <预留>
            example:
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "alarm_id": 3,
                    "task_id": 4,
                    "task_name": "xxx",
                    "lib_id": 3,
                    "lib_name": "xxx",
                    "group_id": 3,
                    "group_name": "xxx",
                    "cont_times": 1,
                    "alarm_time": "YYYY-mm-dd HH:MM:SS",
                    "discover": [
                        {
                            "person_id": 1,
                            "person_name": "xxx",
                            "gender": 3,    // 1：男；2：女；3：未知
                            "card_no": "xxxxxxxx",
                            "pic_url": "xxx"
                        }, ...
                    ],
                    "missing": [
                        {
                            "person_id": 1,
                            "person_name": "xxx",
                            "gender": 3,    // 1：男；2：女；3：未知
                            "card_no": "xxxxxxxx",
                            "pic_url": "xxx"
                        }, ...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void GetLatestGroupAlarmInfo(string cond, out string result);

        /**
         * @brief  QueryGroupAlarmInfo 查询联号告警信息
         * @since  V3.20180922
         *
         * @param cond 查询条件
            example:
            {
                "alarm_id": 3
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "alarm_id": 3,
                    "task_id": 4,
                    "task_name": "xxx",
                    "lib_id": 3,
                    "lib_name": "xxx",
                    "group_id": 3,
                    "group_name": "xxx",
                    "cont_times": 1,
                    "alarm_time": "YYYY-mm-dd HH:MM:SS",
                    "state": 0,    // 0：未处理，1：已处理
                    "comment": "...",
                    "commit_time": "YYYY-mm-dd HH:MM:SS",
                    "discover": [
                        {
                            "person_id": 1,
                            "person_name": "xxx",
                            "gender": 3,    // 1：男；2：女；3：未知
                            "card_no": "xxxxxxxx",
                            "pic_url": "xxx"
                        }, ...
                    ],
                    "missing": [
                        {
                            "person_id": 1,
                            "person_name": "xxx",
                            "gender": 3,    // 1：男；2：女；3：未知
                            "card_no": "xxxxxxxx",
                            "pic_url": "xxx"
                        }, ...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryGroupAlarmInfo(string cond, out string result);

        /**
         * @brief  QueryGroupAlarmList 查询联号告警信息列表
         * @since  V3.20180922
         *
         * @param cond 查询条件
            example:
            {
                "page_no": int,         必填。页号，默认1。
                "page_size": int,       必填。页大小，有效数据是10, 20, 30, 40, 50。
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                     "task_id": int,        选填。任务id。
                     "task_name": string,   选填。任务名。
                     "lib_id": int,         选填。底库id。
                     "lib_name": string,    选填。底库名称。
                     "state": int,          选填。状态，0:未处理,1:已处理。
                     "begin_time": string,  选填。开始时间。
                     "end_time": string,    选填。结束时间。
                 }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "page_no": 1,
                    "page_size": 10,
                    "total_count": 100,
                    "items": [
                        {
                            "alarm_id": 2,
                            "task_id": 4,
                            "task_name": "xxx",
                            "lib_id": 3,
                            "lib_name": "xxx",
                            "group_id": 3,
                            "group_name": "xxx",
                            "cont_times": 1,
                            "alarm_time": "YYYY-mm-dd HH:MM:SS",
                            "state": 0,    // 0：未处理，1：已处理
                            "comment": "xxx",
                            "commit_time": "YYYY-mm-dd HH:MM:SS",
                            "discover": [
                                {
                                    "person_id": 1,
                                    "person_name": "xxx",
                                    "gender": 3,    // 1：男；2：女；3：未知
                                    "card_no": "xxxxxxxx",
                                    "pic_url": "xxx"
                                }, ...
                            ],
                            "missing": [
                                {
                                    "person_id": 1,
                                    "person_name": "xxx",
                                    "gender": 3,    // 1：男；2：女；3：未知
                                    "card_no": "xxxxxxxx",
                                    "pic_url": "xxx"
                                }, ...
                            ]
                        }, ...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryGroupAlarmList(string cond, out string result);

        /**
         * @brief  CommitGroupAlarmComment 提交联号告警处理结果
         * @since  V3.20180922
         *
         * @param comment 处理结果
            example:
            {
                "alarm_id": 1,
                "comment": "xxx"
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void CommitGroupAlarmComment(string comment, out string result);

        /**
         * @brief  QueryRollcallCurrent 查询任务的当前点名详情
         * @since  V3.20180922
         * @since  V3.20181018
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,页号
                "page_size": 10,        必填,页尺寸
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "task_id": 1           必填,任务id
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // 页号
                    "page_size": 10,    // 页尺寸
                    "total_count": 1,   // 总数
                    "items": [
                        {
                            "id": 1,                    // 记录id
                            "event_id": 1,              // 事件id
                            "task_id": 4,               // 任务id
                            "task_name": "xxx",         // 任务名
                            "lib_id": 3,                // 底库id
                            "lib_name": "xxx",          // 底库名
                            "person_id": 1,             // 人员id
                            "person_name": "zhangsan",  // 人员姓名
                            "gender": 0,                // 性别，1：男；2：女；0：未知
                            "card_no": "xxxxxxxx",      // 证件号
                            "group": 2,                 // 黑白名单,参见<Whitelist>
                            "category": 0,              // 人员类别,0:未分类
                            "pic_url": "xxx",           // 底库照片
                            "rollcall_state": 0,        // 点名状态,0:未到,1:已到
                            "rollcall_time": "xxx",     // 点名时间
                            "compare_score": 0.98,      // 比对得分
                            "capture_photo_url": "xxx", // 抓拍人脸图URL
                            "capture_scene_url": "xxx", // 抓拍场景图URL
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryRollcallCurrent(string cond, out string result);

        /**
         * @brief  QueryRollcallRecord 查询点名记录
         * @since  V3.20180922
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,页号
                "page_size": 10,        必填,页尺寸
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "task_id": 1,              选填,任务id
                    "task_name": "xxx",        选填,任务名，模糊匹配
                    "begin_time": "xxxx",      选填,开始时间，格式：YYYY-MM-DD HH:mm:ss
                    "end_time": "xxxx"         选填,结束时间，格式：YYYY-MM-DD HH:mm:ss
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // 页号
                    "page_size": 10,    // 页尺寸
                    "total_count": 1,   // 总数
                    "items": [
                        {
                            "event_id": 1,              // 事件id
                            "task_id": 4,               // 任务id
                            "task_name": "xxx",         // 任务名
                            "start_mode": 1,            // 开启方式,1:自动,2:手动
                            "start_time": "xxx",        // 开始时间
                            "end_time": "xxx",          // 结束时间
                            "headcount": 100,           // 总人数
                            "present": 80,              // 已到
                            "absent ": 20,              // 未到
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryRollcallRecord(string cond, out string result);

        /**
         * @brief  QueryRollcallDetails 查询点名详情
         * @since  V3.20180922
         * @since  V3.20181018
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,页号
                "page_size": 10,        必填,页尺寸
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "event_id": 1,             选填,事件id
                    "task_id": 1,              选填,任务id
                    "task_name": "xxx",        选填,任务名，精确匹配
                    "lib_id": 1,               选填,底库id
                    "lib_name": "xxx",         选填,底库名，精确匹配
                    "person_name": "xxx",      选填,人员姓名，模糊匹配
                    "present": 0,              选填,0:未到,1:已到
                    "begin_time": "xxxx",      选填,开始时间，格式：YYYY-MM-DD HH:mm:ss
                    "end_time": "xxxx"         选填,结束时间，格式：YYYY-MM-DD HH:mm:ss
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // 页号
                    "page_size": 10,    // 页尺寸
                    "total_count": 1,   // 总数
                    "items": [
                        {
                            "id": 1,                    // 记录id
                            "event_id": 1,              // 事件id
                            "task_id": 4,               // 任务id
                            "task_name": "xxx",         // 任务名
                            "lib_id": 3,                // 底库id
                            "lib_name": "xxx",          // 底库名
                            "person_id": 1,             // 人员id
                            "person_name": "zhangsan",  // 人员姓名
                            "gender": 0,                // 性别，1：男；2：女；0：未知
                            "card_no": "xxxxxxxx",      // 证件号
                            "group": 2,                 // 黑白名单,参见<Whitelist>
                            "category": 0,              // 人员类别,0:未分类
                            "pic_url": "xxx",           // 底库照片
                            "rollcall_state": 0,        // 点名状态,0:未到,1:已到
                            "rollcall_time": "xxx",     // 点名时间
                            "compare_score": 0.98,      // 比对得分
                            "capture_photo_url": "xxx", // 抓拍人脸图URL
                            "capture_scene_url": "xxx", // 抓拍场景图URL
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryRollcallDetails(string cond, out string result);

        /**
         * @brief  QueryWorkplaceStartedTask 查询已启动的工间点名任务信息
         * @since  V3.20181106
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,页号
                "page_size": 10,        必填,页尺寸
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "task_name": "xxx",    选填,任务名 支持模糊匹配
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // 页号
                    "page_size": 10,    // 页尺寸
                    "total_count": 1,   // 总数
                    "items": [
                        {
                            "event_id": 1,              // 事件id
                            "task_id": 4,               // 任务id
                            "task_name": "xxx",         // 任务名
                            "start_mode": 1,            // 开启方式,1:自动,2:手动
                            "start_time": "xxx",        // 开始时间
                            "headcount": 100,           // 总人数
                            "present": 80,              // 当前上工人数
                            "leave":10,                 // 中途离开人数
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryWorkplaceStartedTask(string cond, out string result);

        /**
         * @brief  QueryWorkplaceCurrent 查询任务的当前工间点名详情
         * @since  V3.20181009
         * @since  V3.20181018
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,页号
                "page_size": 10,        必填,页尺寸
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "task_id": 1           必填,任务id
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // 页号
                    "page_size": 10,    // 页尺寸
                    "total_count": 1,   // 总数
                    "items": [
                        {
                            "id": 1,                    // 记录id
                            "event_id": 1,              // 事件id
                            "task_id": 4,               // 任务id
                            "task_name": "xxx",         // 任务名
                            "lib_id": 3,                // 底库id
                            "lib_name": "xxx",          // 底库名
                            "person_id": 1,             // 人员id
                            "person_name": "zhangsan",  // 人员姓名
                            "gender": 0,                // 性别，1：男；2：女；0：未知
                            "card_no": "xxxxxxxx",      // 证件号
                            "group": 2,                 // 黑白名单,参见<Whitelist>
                            "category": 0,              // 人员类别,0:未分类
                            "pic_url": "xxx",           // 底库照片
                            "work_state": 0,            // 工间点名状态,0:未到,1:已到,2:外出
                            "check_time": "xxx",        // 工间点名时间
                            "compare_score": 0.98,      // 比对得分
                            "capture_photo_url": "xxx", // 抓拍人脸图URL
                            "capture_scene_url": "xxx", // 抓拍场景图URL
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryWorkplaceCurrent(string cond, out string result);

        /**
         * @brief  QueryWorkplaceRecord 查询工间点名记录
         * @since  V3.20181009
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,页号
                "page_size": 10,        必填,页尺寸
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "task_id": 1,              选填,任务id
                    "task_name": "xxx",        选填,任务名，模糊匹配
                    "begin_time": "xxxx",      选填,开始时间，格式：YYYY-MM-DD HH:mm:ss
                    "end_time": "xxxx"         选填,结束时间，格式：YYYY-MM-DD HH:mm:ss
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // 页号
                    "page_size": 10,    // 页尺寸
                    "total_count": 1,   // 总数
                    "items": [
                        {
                            "event_id": 1,              // 事件id
                            "task_id": 4,               // 任务id
                            "task_name": "xxx",         // 任务名
                            "start_mode": 1,            // 开启方式,1:自动,2:手动
                            "start_time": "xxx",        // 开始时间
                            "end_time": "xxx",          // 结束时间
                            "headcount": 100,           // 总人数
                            "present": 80,              // 出席人数
                            "leave":10,                 // 中途离开人数
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryWorkplaceRecord(string cond, out string result);

        /**
         * @brief  QueryWorkplaceDetails 查询工间点名详情
         * @since  V3.20181009
         * @since  V3.20181018
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,页号
                "page_size": 10,        必填,页尺寸
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "event_id": 1,             选填,事件id
                    "task_id": 1,              选填,任务id
                    "task_name": "xxx",        选填,任务名，精确匹配
                    "lib_id": 1,               选填,底库id
                    "lib_name": "xxx",         选填,底库名，精确匹配
                    "person_name": "xxx",      选填,人员姓名，模糊匹配
                    "work_state": 0,           选填,点名状态,0:未到,1:已到,2:外出
                    "begin_time": "xxxx",      选填,开始时间，格式：YYYY-MM-DD HH:mm:ss
                    "end_time": "xxxx"         选填,结束时间，格式：YYYY-MM-DD HH:mm:ss
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // 页号
                    "page_size": 10,    // 页尺寸
                    "total_count": 1,   // 总数
                    "items": [
                        {
                            "id": 1,                    // 记录id
                            "event_id": 1,              // 事件id
                            "task_id": 4,               // 任务id
                            "task_name": "xxx",         // 任务名
                            "video_id": 4,              // 摄像头id
                            "video_name": "xxx",        // 摄像头名称
                            "lib_id": 3,                // 底库id
                            "lib_name": "xxx",          // 底库名
                            "person_id": 1,             // 人员id
                            "person_name": "zhangsan",  // 人员姓名
                            "gender": 0,                // 性别，1：男；2：女；0：未知
                            "card_no": "xxxxxxxx",      // 证件号
                            "group": 2,                 // 黑白名单,参见<Whitelist>
                            "category": 0,              // 人员类别,0:未分类
                            "pic_url": "xxx",           // 底库照片
                            "work_state": 0,            // 工间点名状态,0:未到,1:已到,2:外出
                            "check_time": "xxx",        // 工间点名时间
                            "compare_score": 0.98,      // 比对得分
                            "capture_photo_url": "xxx", // 抓拍人脸图URL
                            "capture_scene_url": "xxx", // 抓拍场景图URL
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryWorkplaceDetails(string cond, out string result);

        /**
         * @brief  GetLatestPatrolAlarm 获取最新的巡更告警信息
         * @since  V3.20181107
         *
         * @param cond <预留>
            example:
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "task_id": 4,       int,任务id
                    "task_name": "xxx", string,任务名称
                    "video_id": 3,      int,摄像头id
                    "video_name": "xxx",string,摄像头名
                    "lib_id": 3,        int,底库id
                    "lib_name": "xxx",  string,底库名称
                    "group_id": 3,      int,小组id
                    "group_name": "xxx",string,小组名称
                    "plan_begin_time": "xxx",   string,巡更计划的开始时间,格式:HH:MM:SS
                    "plan_end_time": "xxx",     string,巡更计划的结束时间,格式:HH:MM:SS
                    "alarm_time": "xxx",        string,告警时间,格式:YYYY-mm-dd HH:MM:SS
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void GetLatestPatrolAlarm(string cond, out string result);

        /**
         * @brief  QueryPatrolAlarmList 查询巡更告警信息列表
         * @since  V3.20181107
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,int,页号,默认1
                "page_size": 10,        必填,int,页大小,有效数据是10,20,30,40,50
                "query_cond": {
                    "task_id": 1,       选填,int,任务id
                    "task_name": "xx",  选填,string,任务名称,支持模糊匹配
                    "group_id": 1,      选填,int,小组id
                    "group_name": "xx", 选填,string,小组名称,支持模糊匹配
                    "begin_time": "xxx",选填,string,开始时间
                    "end_time": "xxx",  选填,string,结束时间
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "page_no": 1,
                    "page_size": 10,
                    "total_count": 100,
                    "items": [
                        {
                            "id": 1,            int,记录id
                            "task_id": 4,       int,任务id
                            "task_name": "xxx", string,任务名称
                            "video_id": 3,      int,摄像头id
                            "video_name": "xxx",string,摄像头名
                            "lib_id": 3,        int,底库id
                            "lib_name": "xxx",  string,底库名称
                            "group_id": 3,      int,小组id
                            "group_name": "xxx",string,小组名称
                            "plan_begin_time": "xxx",   string,巡更计划的开始时间,格式:HH:MM:SS
                            "plan_end_time": "xxx",     string,巡更计划的结束时间,格式:HH:MM:SS
                            "alarm_time": "xxx",        string,告警时间,格式:YYYY-mm-dd HH:MM:SS
                        }, ...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryPatrolAlarmList(string cond, out string result);

        /**
         * @brief  QueryPatrolList 查询巡更信息列表
         * @since  V3.20181107
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,int,页号,默认1
                "page_size": 10,        必填,int,页大小,有效数据是10,20,30,40,50
                "query_cond": {
                    "task_id": 1,       选填,int,任务id
                    "task_name": "xx",  选填,string,任务名称,支持模糊匹配
                    "group_id": 1,      选填,int,小组id
                    "group_name": "xx", 选填,string,小组名称,支持模糊匹配
                    "patrol_state": 1,  选填,int,状态,1:正常巡更,2:异常巡更
                    "begin_time": "xxx",选填,string,开始时间
                    "end_time": "xxx",  选填,string,结束时间
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "page_no": 1,
                    "page_size": 10,
                    "total_count": 100,
                    "items": [
                        {
                            "id": 1,            int,记录id
                            "task_id": 4,       int,任务id
                            "task_name": "xxx", string,任务名称
                            "video_id": 3,      int,摄像头id
                            "video_name": "xxx",string,摄像头名
                            "lib_id": 3,        int,底库id
                            "lib_name": "xxx",  string,底库名称
                            "group_id": 3,      int,小组id
                            "group_name": "xxx",string,小组名称
                            "plan_begin_time": "xxx",   string,巡更计划的开始时间,格式:HH:MM:SS
                            "plan_end_time": "xxx",     string,巡更计划的结束时间,格式:HH:MM:SS
                            "patrol_state": 1,  int,巡更状态,1:正常巡更,2:异常巡更
                            "patrol_time": "xx",string,巡更时间,格式:YYYY-mm-dd HH:MM:SS
                            "person_id": 0,     int,巡更人员id（巡更异常告警）
                            "person_name": "xx",string,巡更人员姓名
                            "gender": 1,        int,性别 0:未知,1:男,2:女
                            "card_no": "xx",    string,证件号
                            "group": 2,         int,黑白名单,参见<Whitelist>
                            "category": 0,      int,人员类别,0:未分类
                            "compare_score": 0.8,       float,比对得分
                            "pic_url": "xxx",   string,低库照片url
                            "capture_photo_url": "xxx", string,抓拍头像的url
                            "capture_scene_url": "xxx", string,抓拍场景的url
                            "capture_timestamp": 10000, long, 抓拍时间戳
                        }, ...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryPatrolList(string cond, out string result);

        /**
         * @brief  GetLibPicServer 获取底库图片服务器信息
         * @since  V3.20181018
         *
         * @param cond <预留>
            example:
            {
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "ip": "127.0.0.1",  // string,服务器ip
                    "port": 8001,       // int,服务器端口
                    "upload_url": "xx", // string,上传URL,例:/up
                }
            }
            Full upload URL: You have to make it yourself.
            example:
                http://127.0.0.1:8001/up
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void GetLibPicServer(string cond, out string result);

        /**
         * @brief  SearchCamera 获取访客配置
         * @since  V3.20190308
         *
         * @param cond 搜索条件<预留>
            {
            }
         * @param result json格式的字符串。
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "items": [
                        {
                            "ip": "192.168.2.10",
                            "rtsp": "rtsp://192.168.2.10/h264",
                            "mfrs": "HIKVISION"
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void SearchCamera(string cond, out string result);

        /**
         * @brief  GetSystemInfo 获取当前服务器的信息。
         * @since  V3.20180922
         *
         * @param cond 获取条件
            example:
            {
                "ip": "192.168.2.106",
                "mac_addr": ""
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "local_ip": "192.168.2.106",
                    "disk_free": 201432,            // Byte     程序安装目录盘符的空闲磁盘大小(如D:盘大小)
                    "disk_size": 4212323,           // Byte     程序安装目录盘符的总磁盘大小(如D:盘大小)
                    "mem_use": 4321432,             // Byte     使用内存
                    "mem_free": 4321432,            // Byte     空闲内存
                    "mem_total": 4321432,           // Byte     总内存
                    "core_num": 3,                  // number   cpu核数
                    "cpu": 43,                      // 0~100    cpu使用率
                    "gpu_rate": 43,                 // 0~100    gpu rate      do not show this info
                    "gpu_mem": 43,                  // 0~100    显存          do not show this info
                    "gpu_celsius": 43               // 0~100    gpu温度       do not show this info
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void GetSystemInfo(string cond, out string result);

        /**
         * @brief  GetStatisticsReport 获取统计报告。
         * @since  V3.2020/02/26
         * @update V3.2020/05/08 增加智能门禁通行统计
         * @update V3.20200513 增加组织id筛选条件
         * @update V3.20200527 增加aiot设备列表、摄像头列表查询条件
         *
         * @param cond 获取条件
            example:
            {
                "org_id": 1,            选填,int,组织id
                "dev_list": "1,2",      选填,string,aiot设备列表,设备id之间以逗号间隔
                "camera_list": "1,2",   选填,string,摄像头列表,摄像头id之间以逗号间隔
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "today_capture": 43,            // 今日抓拍数
                    "today_blacklist_alarm": 43,    // 今日黑名单告警数
                    "today_fever_alarm": 43,        // 今日发烧告警数
                    "total_photo_num": 43,          // 底库照片数
                    "total_video_num": 43,          // 视频源数量
                    "working_task_num": 43,         // 工作中的任务数
                    "face_device_capture": 43,      // 智能门禁今日抓拍数
                    "face_device_blacklist_alarm": 43,      // 智能门禁今日黑名单告警数
                    "face_device_fever_alarm": 43,          // 智能门禁今日发烧告警数
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void GetStatisticsReport(string cond, out string result);

        /**
         * @brief  QuerySystemLogList 查询系统日志。
         * @since  V3.20180922
         *
         * @param cond  查询信息。
            example:
            {
                "page_no": 1            必填。页号。
                "page_size": 10         必填。页大小。
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "ip": ""                    选填。ip地址。
                    "mac_addr": ""              选填。mac地址。
                    "level": 1                  选填。日志级别，查看哪个级别以上的日志。 0:ALL,1:TRACE,2:DEBUG,3:INFO,4:WARNING,5:ERROR,6:FATAL
                                                 比如 选1，就会查看1:TRACE,2:DEBUG,3:INFO,4:WARNING,5:ERROR,6:FATAL的日志
                                                      选3，就会查看3:INFO,4:WARNING,5:ERROR,6:FATAL的日志
                    "begin_time": ""            选填。查询的开始时间。
                    "end_time": ""              选填。查询的结束时间。
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "items": [
                        {
                            "ip": "192.168.2.16",
                            "mac_addr": "A0-D2-3E-1D-B7-42",
                            "project": "4212323",             // 不需要展示
                            "module": "SDBusiness V1.0",      // 不需要展示
                            "event": "Open capture task",
                            "level": 1,                       // 日志级别, 1:TRACE,2:DEBUG,3:INFO,4:WARNING,5:ERROR,6:FATAL
                            "message": "Normal",
                            "detail": "{}",
                            "create_time": "2017-08-09 13:00:00"
                        },
                        ...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QuerySystemLogList(string cond, out string result);

        /**
         * @brief  QueryPersonCount 查询底库中的人数
         * @since  V3.20180922
         * @update V3.20190308 增加VIP底库类型
         *
         * @param cond 查询条件
            example:
            {
                "lib_list": "xx"       选填,底库id列表，id之前以逗号','分隔，默认查询总人数
                "lib_type": 1,         选填,底库类型,1:普通底库,2:VIP底库,3:访客底库,4:预警底库,5:在押犯人底库
                "group_by": 0          选填,分类汇总,1:按底库类型分类
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "person_count": 0    // 所选底库中的人数。
                    "items": [
                        {
                            "type": 1,      // 底库类型
                            "count": 10     // 人数
                        },....
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryPersonCount(string cond, out string result);

        /**
         * @brief  QueryTodayGroupAlarmCount 查询今天的联号告警数量
         * @since  V3.20180922
         *
         * @param cond <预留>
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "latest_id": 100,
                    "alarm_count": 10
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryTodayGroupAlarmCount(string cond, out string result);

        /**
         * @brief  QueryStatistics 查询统计信息
         * @since  V3.20180922
         *
         * @param cond <预留>
            example:
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "today_visitor_count": 0    // 当天访客人数
                    "today_rollcall_count": 0   // 当天的点名记录数
                    "total_rollcall_count": 0   // 总的点名记录数
                    // 联号告警
                    "group_alarm": [
                        {
                            "date": "xxx",      // 日期
                            "count": 0          // 记录数
                        }
                    ]
                    // 抓拍告警
                    "capture_alarm": [
                        {
                            "date": "xxx",      // 日期
                            "count": 0          // 记录数
                        }
                    ]
                    // 智能门禁通行记录
                    "smart_passage": [
                        {
                            "date": "xxx",      // 日期
                            "count": 0          // 记录数
                        }
                    ]
                    // 普通闸机通行记录
                    "general_passage": [
                        {
                            "date": "xxx",      // 日期
                            "count": 0          // 记录数
                        }
                    ]
                    //巡更告警  Modified:20181224
                    "partol_alarm":[
                    {
                        "data":"",              //日期
                        "count":0               记录数
                    }
                    ]
                    //陌生人告警  Modified:20181224
                    "stranger_alarm":[
                       {
                            "date":"",          //日期
                            "count":0           //记录数
                       }
                    ]
                    //黑名单告警 Modified:20181224
                    "blacklist_alarm":[
                        {
                            "date":"",          //日期
                            "count":0           //记录数
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryStatistics(string cond, out string result);

        /**
         * @brief  AddIcCard 绑定人员IC卡信息
         * @since  V3.20190506
         *
         * @param cond IC卡信息
            example:
            {
                "person_id": 1,         必填,int,员工id
                "ic_card_no": "xxx1",   必填,string,IC卡号
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void AddIcCard(string cond, out string result);

        /**
         * @brief  DeleteIcCard 删除人员IC卡信息
         * @since  V3.20190506
         *
         * @param cond IC卡信息
            example:
            {
                "ic_card_no": "xxxx",         必填,string,ic卡号
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void DeleteIcCard(string cond, out string result);

        /**
         * @brief  QueryIcCard 查询IC卡信息
         * @since  V3.20190506
         *
         * @param cond IC卡信息
            example:
            {
                "person_id": 1,         必填,int,员工id
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "items": [
                        {
                            "ic_card_no": "xxx1", string,ic卡号
                        }, ...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryIcCard(string cond, out string result);

        /**
         * @brief  QueryPersonWithIcCardInfo 查询人员及IC卡信息
         * @since  V3.20190508
         *
         * @param cond 查询条件
            example:
            {
                "person_id": 1 ,    必填,int,人员库id
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "person_id": 1,     int,人员id
                    "name": "",         string,人员名字
                    "lib_name": "",     string,底库名称
                    "birthday": "",     string,生日
                    "card_no": "",      string,证件号
                    "phone": "",        string,手机号码
                    "category": 6,      int,人员类别
                    "pic_path": "",     string,图片路径
                    "group": 2,         int,黑白名单,参见<Whitelist>
                    "property": "{}",   string,人员特定属性
                    "ic_card_list": [
                        "xxxx1"
                    ],                  json-array,IC卡卡号列表
                }
            }
            property 格式定义如下：
            业主人员属性：
            {
                "proprietor": {
                    "room_no": "", string,房号
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryPersonWithIcCardInfo(string cond, out string result);

        /**
         * @brief  QueryPersonWithIcCardList 根据IC卡查询人员列表
         * @since  V3.20190508
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "query_cond": {
                    "category": 6,          必填,int,人员类别,业主类型为6
                    "name": "",             选填,string,人员名称,模糊匹配
                    "card_no": "xxxx",      选填,string,证件号码
                    "room_no": "xxxx",      选填,string,房号<业主类型时可选>
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "page_no": 1,
                    "page_size": 10,
                    "total_count": 200,
                    "items": [
                        {
                            "person_id": 1,     int,人员id
                            "name": "",         string,人员名字
                            "lib_name": "",     string,底库名称
                            "birthday": "",     string,生日
                            "card_no": "",      string,证件号
                            "phone": "",        string,手机号码
                            "category": 6,      int,人员类别
                            "pic_path": "",     string,图片路径
                            "group": 2,         int,黑白名单,参见<Whitelist>
                            "property": "{}",   string,人员特定属性
                            "ic_card_count": 0, int,已绑定IC卡的数量
                        }, ...
                    ]
                }
            }
            property 格式定义定义参见《QueryPersonWithIcCardInfo》
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryPersonWithIcCardList(string cond, out string result);

        /**
         * @brief  QuerySummaryInfo 查询汇总信息
         * @since  V3.20190510
         *
         * @param cond 查询条件<预留>
            example:
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "people": {
                        "total": 0,         // 总人数
                        "employee": 0,      // 员工人数
                        "vip": 0,           // VIP人数
                        "visitor": 0,       // 访客人数
                        "police": 0,        // 警察人数
                        "prisoner": 0,      // 囚犯人数
                        "proprietor": 0,    // 业主人数
                        "outsider": 0,      // 外来人数（外协）
                        "drug_addict": 0,   // 戒毒人员人数
                        "visiting": 0,      // 探视人员人数
                    }
                    "ic_card:": {
                        "give_out": 0,  // 发送的IC卡张数
                    }
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QuerySummaryInfo(string cond, out string result);

        /**
         * @brief  GetTodayAccessRecord 获取今日的门禁通行记录
         * @since  V3.20190510
         *
         * @param cond 查询条件
            example:
            {
                "dev_id": 1,        选填,int,设备id
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "smart_access": {
                        "face_count": 0,    // 人脸识别通行记录数
                        "ic_card_count": 0, // IC卡刷卡通行记录数
                        "id_card_count": 0  // 身份证刷卡通行记录数
                    },
                    "general_access": {
                        "face_count": 0,    // 人脸识别通行记录数
                    }
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void GetTodayAccessRecord(string cond, out string result);

        /**
         * @brief  GetLast24hAccessRecord 获取过去24小时的门禁通行记录
         * @since  V3.20190510
         *
         * @param cond 查询条件
            example:
            {
                "dev_id": 1,        选填,int,设备id
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "items": [
                        {
                            "time": 1,              // 时间,取值[1,24]
                            "smart_access": {
                                "face_count": 0,    // 人脸识别通行记录数
                                "ic_card_count": 0, // IC卡刷卡通行记录数
                                "id_card_count": 0  // 身份证刷卡通行记录数
                            },
                            "general_access": {
                                "face_count": 0,    // 人脸识别通行记录数
                            }
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void GetLast24hAccessRecord(string cond, out string result);

        /**
         * @brief  GetLast7daysAccessRecord 获取过去7天的门禁通行记录
         * @since  V3.20190510
         *
         * @param cond 查询条件
            example:
            {
                "dev_id": 1,        选填,int,设备id
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "items": [
                        {
                            "date": "06-08",        // 日期,格式:MM:dd
                            "smart_access": {
                                "face_count": 0,    // 人脸识别通行记录数
                                "ic_card_count": 0, // IC卡刷卡通行记录数
                                "id_card_count": 0  // 身份证刷卡通行记录数
                            },
                            "general_access": {
                                "face_count": 0,    // 人脸识别通行记录数
                            }
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void GetLast7daysAccessRecord(string cond, out string result);

        /**
         * @brief  GetRealtimeAccessMessage 获取实时门禁通行消息
         * @since  V3.20190510
         *
         * @param cond 查询条件<预留>
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "id_card_total": 100,   // 身份证通信记录总数
                    "passage_message": "",  // 通信消息
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void GetRealtimeAccessMessage(string cond, out string result);

        /**
         * @brief  AddSimpleLeave 添加请假信息
         * @since  V3.20190522
         * @update V3.20200102 返回记录id
         *
         * @param info 请假信息
            example: 
            {
                "person_id" : 1,    必填,int,员工ID
                "reason" : "",      必填,string,请假原因
                "start_time" : "",  必填,string,请假开始时间
                "end_time" : "",    必填,string,请假结束时间
                "remark": ""        选填,string,备注信息
                "operator" : "",    必填,string,操作员
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddSimpleLeave(string info, out string result);

        /**
         * @brief  ResumptionFromSimpleLeave 销假
         * @since  V3.20190522
         *
         * @param info 请假记录信息
            example: 
            {
                "id", 1         必填,int,记录id
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void ResumptionFromSimpleLeave(string info, out string result);

        /**
         * @brief  DeleteSimpleLeave 删除请假记录
         * @since  V3.20190522
         *
         * @param cond 请假记录信息
            example: 
            {
                "id", 1         必填,int,记录id
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteSimpleLeave(string cond, out string result);

        /**
         * @brief  QuerySimpleLeaveList 查询请假信息
         * @since  V3.20190522
         *
         * @param cond 搜索相关信息
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "query_cond": {
                    "lib_id": 0,        选填,int,底库ID
                    "name": "",         选填,string,员工名称
                    "begin_time": "",   选填,string,开始时间
                    "end_time": "",     选填,string,结束时间
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "page_no":xx,
                    "page_size":xx,
                    "total_count":xx,
                    "items": [
                        {
                            "id": 1             int,记录id
                            "lib_id", 1,        int,底库id
                            "lib_name": "",     string,底库名
                            "person_id" : 1,    int,员工ID
                            "person_name" : "", string,员工名称
                            "start_time" : "",  string,请假开始时间
                            "end_time" : "",    string,请假结束时间
                            "reason" : "",      string,请假原因
                            "reported_time": "" string,销假日期
                            "remark": ""        string,备注信息
                            "creator" : "",     string,创建者
                            "create_time": ""   string,创建时间
                        }, ...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QuerySimpleLeaveList(string cond, out string result);

        /**
         * @brief  QueryPrisonRollcallRecord 查询监狱点名记录
         * @since  V3.20190522
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,页号
                "page_size": 10,        必填,页尺寸
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "task_id": 1,              选填,任务id
                    "lib_id": 1,               选填,底库id
                    "begin_time": "xxxx",      选填,开始时间，格式：YYYY-MM-DD HH:mm:ss
                    "end_time": "xxxx"         选填,结束时间，格式：YYYY-MM-DD HH:mm:ss
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // 页号
                    "page_size": 10,    // 页尺寸
                    "total_count": 1,   // 总数
                    "items": [
                        {
                            "event_id": 1,      // 事件id
                            "task_id": 4,       // 任务id
                            "task_name": "xxx", // 任务名
                            "lib_id": 4,        // 底库id
                            "lib_name": "xxx",  // 底库名
                            "start_time": "xxx",// 开始时间
                            "end_time": "xxx",  // 结束时间
                            "headcount": 100,   // 应到人数
                            "present": 80,      // 出席人数（实到）
                            "absent": 19,       // 缺席人数（未到）
                            "leave": 1,         // 请假人数
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryPrisonRollcallRecord(string cond, out string result);

        /**
         * @brief  DeletePrisonRollcallRecord 删除点名记录
         * @since  V3.20190528
         *
         * @param cond 删除条件
            example: 
            {
                "event_id": 3,           必填,int,事件id。
                "operator": "",          必填,string,修改人,即当前登录的用户。
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0} 返回对应的结果
            失败 - 执行失败 {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeletePrisonRollcallRecord(string cond, out string result);

        /**
         * @brief  BatchDeletePrisonRollcallRecord 批量删除点名记录
         * @since  V3.20190528
         *
         * @param cond 删除条件
            example: 
            {
                "event_id_list": "1,2",  必填,string,事件id,多个事件id使用","分隔。
                "operator": "",          必填,string,修改人,即当前登录的用户。
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0} 返回对应的结果
            失败 - 执行失败 {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchDeletePrisonRollcallRecord(string cond, out string result);

        /**
         * @brief  QueryPrisonRollcallDetails 查询监狱点名详情
         * @since  V3.20190522
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,           必填,页号
                "page_size": 10,        必填,页尺寸
                "operator": "admin",    必填,string,操作者
                "query_cond": {
                    "event_id": 1,      选填,事件id
                    "rollcall_state":1  选填,点名状态,0:未到,1:已到,2:请假
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 1,       // 页号
                    "page_size": 10,    // 页尺寸
                    "total_count": 1,   // 总数
                    "items": [
                        {
                            "id": 1,                    // 记录id
                            "event_id": 1,              // 事件id
                            "task_id": 4,               // 任务id
                            "task_name": "xxx",         // 任务名
                            "lib_id": 3,                // 底库id
                            "lib_name": "xxx",          // 底库名
                            "person_id": 1,             // 人员id
                            "person_name": "zhangsan",  // 人员姓名
                            "gender": 0,                // 性别，1:男,2:女,0:未知
                            "card_no": "xxxxxxxx",      // 证件号
                            "group": 2,                 // 黑白名单,参见<Whitelist>
                            "category": 0,              // 人员类别,0:未分类
                            "pic_url": "xxx",           // 底库照片
                            "compare_score": 0.98,      // 比对得分
                            "rollcall_state": 0,        // 点名状态,0:未到,1:已到,2:请假
                            "rollcall_time": "xxx",     // 点名时间
                            "capture_photo_url": "xxx", // 抓拍人脸图URL
                            "capture_scene_url": "xxx", // 抓拍场景图URL
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryPrisonRollcallDetails(string cond, out string result);

        /**
         * @brief  QueryPrisonSigninRecordList 查询签到/签退事件记录列表
         * @since  V3.20190522
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 2,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "operator": "admin",必填,string,操作者
                "query_cond": {
                    "task_id": 0,   选填,int,任务id
                    "lib_id":0,     选填,int,底库id
                    "begin_time":,"2019-01-01 11:11:11",     选填,string,签到开始时间
                    "end_time":,"2019-01-02 11:11:11",       选填,string,签到结束时间
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "page_no": 2,
                    "page_size": 10,
                    "total_count": 32,
                    "items": [
                        {
                            "event_id": 2,      事件ID
                            "lib_id": 2,        底库ID
                            "lib_name": "xx",   底库名称
                            "task_id": 2,       任务ID
                            "task_name": "xx",  任务名称
                            "headcount": 100,   人数
                            "signin_count": "", 签到人数
                            "signout_count": "",签退人数
                            "signin_start_time": "",    签到开始时间
                            "signin_end_time": "",      签到结束时间
                            "signout_start_time": "",   签退开始时间
                            "signout_end_time": "",     签退结束时间
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryPrisonSigninRecordList(string cond, out string result);

        /**
         * @brief  QueryPrisonSigninDetailsList 查询签到/签退记录列表
         * @since  V3.20190522
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 2,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "query_cond": {
                    "event_id": 0,  必填,int,事件id
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "page_no": 2,
                    "page_size": 10,
                    "total_count": 32,
                    "items": [
                        {
                            "id":1,             记录ID
                            "event_id": 2,      事件ID
                            "lib_id": 2,        底库ID
                            "lib_name": "xx",   底库名称
                            "task_id": 2,       任务ID
                            "task_name": "xx",  任务名称
                            "person_id": 2,     人员ID
                            "person_name": "xx",人员名称
                            "signin_time": "",  签到时间
                            "signout_time": "", 签退时间
                            "modifier": "",     修改人
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryPrisonSigninDetailsList(string cond, out string result);

        /**
         * @brief  DeletePrisonSigninRecord 删除签到/签退事件记录
         * @since  V3.20190522
         *
         * @param cond 删除条件
            example: 
            {
                "event_id": 3,           必填,int,事件id。
                "operator": "",          必填,string,修改人,即当前登录的用户。
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0} 返回对应的结果
            失败 - 执行失败 {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeletePrisonSigninRecord(string cond, out string result);

        /**
         * @brief  BatchDeletePrisonSigninRecord 批量删除签到/签退事件记录
         * @since  V3.20190522
         *
         * @param cond 删除条件
            example: 
            {
                "event_id_list": "1,2",  必填,string,事件id,多个事件id使用","分隔。
                "operator": "",          必填,string,修改人,即当前登录的用户。
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0} 返回对应的结果
            失败 - 执行失败 {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchDeletePrisonSigninRecord(string cond, out string result);

        /**
         * @brief  AddPrisonSigninInfo 新增签到/签退信息
         * @since  V3.20190522
         * @update V3.20200102 返回记录id
         *
         * @param  info 新增记录信息
            example: 
            {
                "event_id": 1,  必填，int，事件id
                "lib_id": 1,    必填，int，底库id
                "person_id": 1,     必填，int，人员id
                "signin_time": "",  必填，string, 签到开始时间
                "signout_time": "", 必填，string, 签退开始时间
                "operator": "",     必填,string,修改人,即当前登录的用户。
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0, "info": {"id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddPrisonSigninInfo(string info, out string result);

        /**
         * @brief  DeletePrisonSigninInfo 删除签到/签退信息
         * @since  V3.20190522
         *
         * @param cond 删除条件
            example: 
            {
                "id": 3,           必填,int,记录id。
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0} 返回对应的结果
            失败 - 执行失败 {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeletePrisonSigninInfo(string cond, out string result);

        /**
         * @brief  BatchDeletePrisonSigninInfo 批量删除签到/签退信息
         * @since  V3.20190522
         *
         * @param cond 删除条件
            example: 
            {
                "id_list": "1,2,3,4",  必填,string,记录id,多个记录id使用","分隔。
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0} 返回对应的结果
            失败 - 执行失败 {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchDeletePrisonSigninInfo(string cond, out string result);

        /**
         * @brief  UpdatePrisonSigninInfo 更新签到/签退信息
         * @since  V3.20190522
         *
         * @param cond 修改信息
            example: 
            {
                "id": 3,            必填,int,记录id。
                "signin_time": "",  必填,string,签到时间
                "signout_time": "", 必填,string,签退时间
                "operator": "",     必填,string,修改人
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0} 返回对应的结果
            失败 - 执行失败 {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdatePrisonSigninInfo(string cond, out string result);

        /**
         * @brief  BatchUpdatePrisonSigninInfo 批量更新签到信息
         * @since  V3.20190522
         *
         * @param cond 修改信息
            example: 
            {
                "event_id": 1,      必填,int,事件id
                "id_list": "1,2",   必填,string,记录id,多个记录id使用","分隔。
                "signin_time": "",  选填,string,签到时间
                "signout_time": "", 选填,string,签退时间
                "operator": "",     必填,string,修改人
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0} 返回对应的结果
            失败 - 执行失败 {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchUpdatePrisonSigninInfo(string cond, out string result);

        /**
         * @brief  QueryInOutList 查询进出管理信息
         * @since  V3.20190522
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "operator": "admin",选填,string,操作者
                "query_cond": {
                    "lib_id": 1,        选填,int,底库id
                    "task_id": 1,       选填,int,任务id
                    "begin_time": "",   选填,string,开始时间
                    "end_time": "",     选填,string,结束时间
                    "complete": 0,      选填,int,0:全部记录,1:完整记录,2:不完整记录
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "page_no": 2,
                    "page_size": 10,
                    "total_count": 32,
                    "items": [
                        {
                            "id": 1             // 记录序号
                            "task_id": 3,       // 任务id
                            "task_name": "xx",  // 任务名称
                            "area_id": 3,       // 区域id
                            "area_name": "xx",  // 区域名称
                            "lib_id": 1,        // 底库id
                            "lib_name": "lib",  // 底库名称
                            "person_id": 1,         // 人员id
                            "person_name": "john",  // 姓名
                            "card_no": "",          // 证件号
                            "group": 2,             // 黑白名单,参见<Whitelist>
                            "category": 0,          // 人员类别,0:未分类
                            "pic_url": "http://ip:port/x.jpg",
                            "entry_photo_url": "",// 进入抓拍人脸照
                            "entry_scene_url": "",// 进入抓拍场景照
                            "leave_photo_url": "",// 离开抓拍人脸照
                            "leave_scene_url": "",// 离开抓拍场景照
                            "entry_time": "",       // 进入时间，格式:yyyy-MM-dd HH:mm:ss
                            "leave_time": "",       // 离开时间，格式:yyyy-MM-dd HH:mm:ss
                            "stay_time": "",        // 停留时间，格式:HH:mm:ss
                            "ignore": 0,            // 忽略标记，0:未忽略,1:已忽略
                            "operator", ""          // 忽略操作员
                        },
                        ...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryInOutList(string cond, out string result);

        /**
         * @brief  DeleteInOutRecord 删除出入管理记录
         * @since  V3.20190522
         *
         * @param cond 删除条件
            example: 
            {
                "id": 3,            必填,int,记录id。
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0} 返回对应的结果
            失败 - 执行失败 {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteInOutRecord(string cond, out string result);

        /**
         * @brief  BatchDeleteInOutRecord 批量删除出入管理记录
         * @since  V3.20190522
         *
         * @param cond 删除条件
            example: 
            {
                "id_list": "1,2",   必填,string,记录id,多个记录id使用","分隔。
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0} 返回对应的结果
            失败 - 执行失败 {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchDeleteInOutRecord(string cond, out string result);

        /**
         * @brief  IgnoreInOutRecord 忽略出入管理记录
         * @since  V3.20190522
         *
         * @param cond 删除条件
            example: 
            {
                "id": 3,            必填,int,记录id。
                "operator": "admin",选填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0} 返回对应的结果
            失败 - 执行失败 {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void IgnoreInOutRecord(string cond, out string result);

        /**
         * @brief  BatchIgnoreInOutRecord 批量忽略出入管理记录
         * @since  V3.20190522
         *
         * @param cond 删除条件
            example: 
            {
                "id_list": "1,2",   必填,string,记录id,多个记录id使用","分隔。
                "operator": "admin",选填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0} 返回对应的结果
            失败 - 执行失败 {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchIgnoreInOutRecord(string cond, out string result);

        /**
         * @brief  GetRealtimeAlarm 获取实时告警信息
         * @since  V3.20190522
         * @update V3.20190822 支持陌生人库识别推送
         * @update V3.20200217 增加智能门禁设备抓拍推送
         * @update V3.20200306 增加口罩识别字段
         * @update V3.20200508 增加组织地点信息回填
         *
         * @param cond 查询条件 <预留>
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "alarm_type": 1,    告警类型,1:布控抓拍,2:点名缺席告警,3:进出逗留告警,4:智能门禁设备抓拍
                    "alarm_info": {}    告警信息,json-array
                }
            }
            for alarm_info:
            1:布控抓拍告警
            {
                "capture_info":
                {
                    "capture_id": "fdsafsdadsasd",
                    "task_id": 3,           // 任务id
                    "task_name": "xx",      // 任务名称
                    "video_id": 2,          // 视频id
                    "video_name": "xxx",    // 视频名称
                    "video_location": "",   // 视频位置或路径
                    "org_id": 1,            // 组织id
                    "organization": "",     // 组织名
                    "site_id": 1,           // 地址id
                    "site_name": "",        // 地址名
                    "wear_mask": true,      // 是否佩戴口罩
                    "temperature": 36.5,    // 体温,单位:摄氏度
                    "is_fever": true,       // 是否发烧,true:发烧,false:未发烧
                    "capture_photo_url": "",// 抓拍人脸照
                    "capture_scene_url": "",// 抓拍场景照
                    "capture_time": "2018-08-02 23:00:00"
                },
                "compare_results": [
                    {
                        "lib_id": 1,            // 底库id
                        "lib_name": "lib",      // 底库名称
                        "person_id": 1,         // 人员id
                        "person_name": "john",  // 姓名
                        "card_no": "",          // 证件号
                        "group": 2,             // 黑白名单,参见<Whitelist>
                        "category": 0,          // 人员类别,0:未分类
                        "pic_url": "http://ip:port/x.jpg",
                        "compare_score": 0.0,   // 比对得分
                        "classify": 0           // 识别分类,参见<ResultClassify>
                        "stranger":             // 陌生人库比对信息,识别为陌生人时有效
                        {
                            "is_first": true,       // 是否首次入库
                            "stranger_id": "",      // 陌生人id
                            "pic_url": "",          // 图片路径
                            "compare_score": 0.0,   // 比对得分
                        }
                    },
                    ...
                ]
            }
            2:点名缺席告警
            {
                "rollcall_info":
                {
                    "task_id": 3,       // 任务id
                    "task_name": "xx",  // 任务名称
                    "area_id": 3,       // 区域id
                    "area_name": "xx",  // 区域名称
                    "lib_id": 1,        // 底库id
                    "lib_name": "lib",  // 底库名称
                    "headcount": 100,   // 应到人数
                    "present": 80,      // 出席人数（实到）
                    "absent": 20,       // 缺席人数（未到）
                    "leave": 1,         // 请假人数
                    "start_time": "xx"  // 点名开始时间
                    "end_time": "xx"    // 点名开始时间
                },
                "absentees": [
                    {
                        "person_id": 1,         // 人员id
                        "person_name": "john",  // 姓名
                        "card_no": "",          // 证件号
                        "group": 2,             // 黑白名单,参见<Whitelist>
                        "category": 0,          // 人员类别,0:未分类
                        "pic_url": "http://ip:port/x.jpg",
                    },
                    ...
                ]
            }
            3:进出逗留告警
            {
                "stay_info":
                {
                    "task_id": 3,       // 任务id
                    "task_name": "xx",  // 任务名称
                    "area_id": 3,       // 区域id
                    "area_name": "xx",  // 区域名称
                    "lib_id": 1,        // 底库id
                    "lib_name": "lib",  // 底库名称
                    "person_id": 1,         // 人员id
                    "person_name": "john",  // 姓名
                    "card_no": "",          // 证件号
                    "group": 2,             // 黑白名单,参见<Whitelist>
                    "category": 0,          // 人员类别,0:未分类
                    "pic_url": "http://ip:port/x.jpg",
                    "entry_photo_url": "",// 抓拍人脸照
                    "entry_scene_url": "",// 抓拍场景照
                    "entry_time": "",       // 进入时间，格式:yyyy-MM-dd HH:mm:ss
                    "stay_time": ""         // 停留时间，格式:HH:mm:ss
                }
            }
            4:智能门禁设备抓拍
            {
                "capture_info":
                {
                    "dev_id": 1,            // 设备id
                    "dev_name": "",         // 设备名
                    "in_out": 0,            // 设备进出标识,0:未知,1:进口,2:出口
                    "org_id": 1,            // 组织id
                    "organization": "",     // 组织名
                    "site_id": 1,           // 地址id
                    "site_name": "",        // 地址名
                    "lib_id": 1,            // 底库id
                    "lib_name": 1,          // 底库名
                    "person_id": 1,         // 人员id
                    "name": "zhangsan",     // 人员姓名
                    "gender": 0,            // 性别，0:未知,1:男,2:女
                    "card_no": "",          // 证件号
                    "group": 2,             // 黑白名单,参见<Whitelist>
                    "category": 0,          // 人员类别,0:未分类
                    "compare_score": 0.98,  // 比对得分
                    "wear_mask": true,      // 是否佩戴口罩
                    "temperature": 36.5,    // 体温,单位:摄氏度
                    "is_fever": true,       // 是否发烧,true:发烧,false:未发烧
                    "classify": 0,          // 识别分类,参见<ResultClassify>
                    "capture_time": "",     // 抓拍时间,格式:2018-08-03 10:30:00
                    "pic_url": ""           // 注册图片URL
                    "capture_url": "",      // 抓拍图片URL
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void GetRealtimeAlarm(string cond, out string result);

        /**
         * @brief  GetRealtimePersonCount 获取指定区域的实时人数
         * @since  V3.20190522
         *
         * @param cond 查询条件
            example:
            {
                "area_id": 1,       必填,int,任务id
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "person_count": 90,     // 人数
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void GetRealtimePersonCount(string cond, out string result);

        /**
         * @brief  GetTodayCaptureInfo 获取今日的抓拍信息
         * @since  V3.20190522
         *
         * @param cond 查询条件
            example:
            {
                "task_id": 1,       选填,int,任务id
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "task_id": 1,       // 任务id
                    "task_name": "",    // 任务名
                    "area_id": 1,       // 区域id
                    "area_name": "",    // 区域名
                    "whitelist": 90,    // 白名单
                    "blacklist": 10,    // 黑名单
                    "stranger": 50      // 陌生人
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void GetTodayCaptureInfo(string cond, out string result);

        /**
         * @brief  GetTodayInOutInfo 获取今日的进出信息
         * @since  V3.20190522
         *
         * @param cond 查询条件
            example:
            {
                "task_id": 1,       必填,int,任务id
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "task_id": 3,       // 任务id
                    "task_name": "xx",  // 任务名称
                    "area_id": 3,       // 区域id
                    "area_name": "xx",  // 区域名称
                    "enter": 90,        // 进入人数
                    "leave": 10,        // 离开人数
                    "stay": 50          // 逗留人数
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void GetTodayInOutInfo(string cond, out string result);

        /**
         * @brief  GetLatestPrisonRollcallInfo 获取最近的监狱点名信息
         * @since  V3.20190522
         *
         * @param cond 查询条件
            example:
            {
                "task_id": 1,       选填,int,任务id
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "task_id": 3,       // 任务id
                    "task_name": "xx",  // 任务名称
                    "area_id": 3,       // 区域id
                    "area_name": "xx",  // 区域名称
                    "lib_id": 1,        // 底库id
                    "lib_name": "lib",  // 底库名称
                    "headcount": 100,   // 应到人数
                    "present": 80,      // 出席人数（实到）
                    "absent": 20,       // 缺席人数（未到）
                    "leave": 1,         // 请假人数
                    "start_time": "xx"  // 点名开始时间
                    "end_time": "xx"    // 点名开始时间
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void GetLatestPrisonRollcallInfo(string cond, out string result);

        /**
         * @brief  GetLatestPrisonSigninInfo 获取最近的监狱签到信息
         * @since  V3.20190522
         *
         * @param cond 查询条件
            example:
            {
                "task_id": 1,       选填,int,任务id
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info": {
                    "task_id": 3,       // 任务id
                    "task_name": "xx",  // 任务名称
                    "area_id": 3,       // 区域id
                    "area_name": "xx",  // 区域名称
                    "lib_id": 1,        // 底库id
                    "lib_name": "lib",  // 底库名称
                    "headcount": 100,   // 人数
                    "signin": 90,       // 签到人数
                    "signout": 10,      // 签退人数
                    "start_time": "xx"  // 签到开始时间
                    "end_time": "xx"    // 签退结束时间
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void GetLatestPrisonSigninInfo(string cond, out string result);

        /**
         * @brief  CheckVideoRefreshStatus 检查转码视频流是否需要刷新
         * @since  V3.20190624
         *
         * @param voCond 查询条件
            example:
            {
                "rtmp_addr": ""  // RTMP地址
            }
         * @param voRes 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "need_flash": true  // 是否需要进行刷新
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void CheckVideoRefreshStatus(string voCond, out string voRes);

        /**
         * @brief  QueryLabelStatistics 客群分析(标签统计)
         * @since  V3.20190628
         *
         * @param voCond 查询标签列表及起始终止日期
            example:
            {
                "label_list" : "xxx",   // 必填，标签列表，多个用逗号分隔，最多3个。例:"1,2,3"
                "start_time" : "xxx",   // 选填，统计的开始时间，2018-08-02 00:00:00
                "end_time" : "xxx"      // 选填，统计的结束时间，2018-08-02 23:59:59
            }
         * @param voRes 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "label_num": x,
                    "label_info": [
                        {
                            "id": x,            // 序号
                            "label_id": x,      // 标签id
                            "label_name": "xxx" // 标签名称
                        },...
                    ],
                    "block_num": x,
                    "block_info": [
                        {
                            "id": x,        // 序号
                            "number": xx    // 数量
                        },...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
         void QueryLabelStatistics(string voCond, out string voRes);


         /**
         * @brief  QueryLabelStatisticsDetails 人群分析详情
         * @since  V3.20190702
         *
         * @param voCond 查询标签列表及起始终止日期
            example:
            {
                "label_info" : [
                    {
                        "label_id" : x,
                        "selected" : x //1选中，0未被选中
                    },...
                ],
                "start_time" : "xxx", //2018-08-02 00:00:00
                "end_time" : "xxx", //2018-08-02 23:59:59
                //only_vip page_no page_size total_count同时存在且与vip_name互斥
                "only_vip" : x, //可选 仅查看vip 0或1
                "page_no" : x, //可选 页数
                "page_size": x, //可选 该页显示条数
                "total_count" : x, //可选 总数
                "vip_name" : "xxx" //可选 vip用户名

            }
         * @param voRes 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0,
                "info":
                {
                    "page_no": x, //页数
                    "page_size": x, //该页条数
                    "total_count": x, //总数
                    "items" :[
                        {
                            "person_type" : x //人员类型VIP:2or游客:0
                            "person_name" : "xxx",
                            "capture_photo" : "xxx", //现场图地址
                            "library_photo" : "xxx", //底库图地址
                            "last_capture_time" : "xxxx-xx-xx xx:xx:xx", //最后抓拍时间
                            "label_capture_number" : [
                                {
                                    "label_id" : x,
                                    "label_name": "xxx",
                                    "number" : x
                                },...
                            ]
                        },...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
         void QueryLabelStatisticsDetails(string voCond, out string voRes);

        /**
         * @brief GetCameraScene 获取摄像头场景图
         * @since V3.20190606
         *
         * @para vCond 摄像头rtsp地址
            example:
            {
                "rtsp": "",       string,必填,摄像头rtsp取流地址
            }
         * @para result 成功或失败。例:
            成功 - 返回对应的结果
            {
                "code": 0,
                "info":
                {
                    "camera_scene_url: ""            string,摄像头场景图
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void GetCameraScene(string vCond, out string result);


        /**
         * @brief AddPointMapping 新增点映射信息
         * @since  V3.20190606
         *
         * @para vInfo 点映射信息
            example:
            {
                "area_id": 1,                int,必填,区域id
                "panorama_url": "",          string,必填,全景图地址
                "duration": 1,               int,必填,人脸框采集间隔
                "detect_model": "face",      string,必填，检测模型,可取值:face,person
                "point_mapping":[
                    {
                        "video_id": 1,              int,必填，摄像头id
                        "camera_scene_url": "",     string,必填,摄像头场景图地址
                        "point_info": "{}",         json-string,必填,json格式的属性字段
                    }
                    ...
                    ]
            }
                [字段] point_info 取值:
                {
                    "point_camera": {   //摄像头场景图上瞄点采用逆时针方向选取A,B,C,D
                        "height_rate":0.2,      float,必填,场景图缩放比例
                        "width_rate":0.2,      float,必填,场景图缩放比例
                        "Ax": 1,        int,必填,A点x坐标
                        "Ay": 1,        int,必填,A点y坐标
                        "Bx": 1,        int,必填,B点x坐标
                        "By": 1,        int,必填,B点y坐标
                        "Cx": 1,        int,必填,C点x坐标
                        "Cy": 1,        int,必填,C点y坐标
                        "Dx": 1,        int,必填,D点x坐标
                        "Dy": 1         int,必填,D点y坐标
                    },
                    "point_panorama": {      //全景图上瞄点采用逆时针方向选取A,B,C,D
                        "height_rate":0.2,      float,必填,场景图缩放比例
                        "width_rate":0.2,      float,必填,场景图缩放比例
                        "Ax": 1,        int,必填,A点x坐标
                        "Ay": 1,        int,必填,A点y坐标
                        "Bx": 1,        int,必填,B点x坐标
                        "By": 1,        int,必填,B点y坐标
                        "Cx": 1,        int,必填,C点x坐标
                        "Cy": 1,        int,必填,C点y坐标
                        "Dx": 1,        int,必填,D点x坐标
                        "Dy": 1         int,必填,D点y坐标
                    }
                }
         * @para result 成功或失败。例:
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void AddPointMapping(string vInfo, out string result);

        /**
         * @brief UpdatePointMapping 修改点映射信息
         * @since V3.20190715
         *
         * @para vInfo 点映射信息
            example:
            {
                "area_id": 1,                int,必填,区域id
                "panorama_url": "",          string,必填,全景图地址
                "duration": 1,               int,必填,人脸框采集间隔
                "detect_model": "face",      string,必填，检测模型,可取值:face,person
                "point_mapping":[
                    {
                        "video_id": 1,              int,必填，摄像头id
                        "camera_scene_url": "",     string,必填,摄像头场景图地址
                        "point_info": "{}",         json-string,必填,json格式的属性字段
                    }
                    ...
                ]
            }
                [字段] point_info 取值:
                {
                    "point_camera": {   //摄像头场景图上瞄点采用逆时针方向选取A,B,C,D
                        "height_rate":0.2,      float,必填,场景图缩放比例
                        "width_rate":0.2,      float,必填,场景图缩放比例
                        "Ax": 1,        int,必填,A点x坐标
                        "Ay": 1,        int,必填,A点y坐标
                        "Bx": 1,        int,必填,B点x坐标
                        "By": 1,        int,必填,B点y坐标
                        "Cx": 1,        int,必填,C点x坐标
                        "Cy": 1,        int,必填,C点y坐标
                        "Dx": 1,        int,必填,D点x坐标
                        "Dy": 1         int,必填,D点y坐标
                    },
                    "point_panorama": {      //全景图上瞄点采用逆时针方向选取A,B,C,D
                        "height_rate":0.2,      float,必填,场景图缩放比例
                        "width_rate":0.2,      float,必填,场景图缩放比例
                        "Ax": 1,        int,必填,A点x坐标
                        "Ay": 1,        int,必填,A点y坐标
                        "Bx": 1,        int,必填,B点x坐标
                        "By": 1,        int,必填,B点y坐标
                        "Cx": 1,        int,必填,C点x坐标
                        "Cy": 1,        int,必填,C点y坐标
                        "Dx": 1,        int,必填,D点x坐标
                        "Dy": 1         int,必填,D点y坐标
                    }
                }
         * @para result 成功或失败。例:
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void UpdatePointMapping(string vInfo, out string result);

        /**
         * @brief DeletePointMapping 删除点映射信息
         * @since V3.20190611
         *
         * @para vRecord 点映射信息
            example:
            {
                "area_id": 1,       int,必填,区域id
            }
         * @para result 成功或失败。例:
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void DeletePointMapping(string vRecord, out string result);

        /**
         * @brief QueryHeatmapAreaList 获取已设定热力图区域
         * @since V3.20190606
         *
         * @para vCond 查询条件
            example:
            {
                "page_no": 1,               int,必填,页号
                "page_size": 1,             int,必填,每页个数
                "qyery_cond":
                {
                    "area_id": 1,               int,选填,区域id
                }
            }
         * @para result 成功或失败。例:
            成功 - 返回对应的结果
            {
                "code": 0,
                "info":
                {
                    "page_no": 2,
                    "page_size": 10,
                    "total_count": 1,
                    "items": [
                        {
                            "area_id": 1,           int,区域id
                            "area_name": "name",    string,区域名
                            "level": 1,             int,区域级别,1:一级,2:二级,3:三级
                            "panorama_url": 1,      string,区域全景图
                            "create_time": "2019-07-17 14:00:00"    string,创建时间
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryHeatmapAreaList(string vCond, out string result);

        /**
         * @brief QueryCameraPointMappingInfo 查询指定摄像头映射信息
         * @since V3.20190611
         *
         * @para vCond 查询条件
            example:
            {
                "area_id": 1,               int,必填,区域id
                "video_id": 1,              int,必填,摄像头id
            }
         * @para result 成功或失败。例:
            成功 - 返回对应的结果
            {
                "code": 0,
                "info":
                {
                    "id": 1,                     int,记录id
                    "area_id": 1,                int,区域id
                    "area_name": "",             string,区域名
                    "panorama_url": "",          string,全景图地址
                    "duration": 1,               int,人脸框采集间隔
                    "detect_model": "person",    string,检测模型
                    "video_id": 1,               int,摄像头id
                    "video_name": "",            string,摄像头名
                    "camera_scene_url": "",      string,摄像头场景图地址
                    "point_info": "{}",          json-string,json格式的属性字段
                } 
            }
            [字段] point_info 取值:
                {
                   "point_camera": {   //摄像头场景图上瞄点采用逆时针方向选取A,B,C,D
                        "height_rate":0.2,      float,必填,场景图缩放比例
                        "width_rate":0.2,      float,必填,场景图缩放比例
                        "Ax": 1,        int,必填,A点x坐标
                        "Ay": 1,        int,必填,A点y坐标
                        "Bx": 1,        int,必填,B点x坐标
                        "By": 1,        int,必填,B点y坐标
                        "Cx": 1,        int,必填,C点x坐标
                        "Cy": 1,        int,必填,C点y坐标
                        "Dx": 1,        int,必填,D点x坐标
                        "Dy": 1         int,必填,D点y坐标
                    },
                    "point_panorama": {      //全景图上瞄点采用逆时针方向选取A,B,C,D
                        "height_rate":0.2,      float,必填,场景图缩放比例
                        "width_rate":0.2,      float,必填,场景图缩放比例
                        "Ax": 1,        int,必填,A点x坐标
                        "Ay": 1,        int,必填,A点y坐标
                        "Bx": 1,        int,必填,B点x坐标
                        "By": 1,        int,必填,B点y坐标
                        "Cx": 1,        int,必填,C点x坐标
                        "Cy": 1,        int,必填,C点y坐标
                        "Dx": 1,        int,必填,D点x坐标
                        "Dy": 1         int,必填,D点y坐标
                    }
                }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryCameraPointMappingInfo(string vCond, out string result);

        /**
         * @brief QueryPointMappingInfoByArea 查询区域热力图映射信息
         * @since V3.20190712
         *
         * @para vCond 查询条件
            example:
            {
                "area_id": 1,               int,必填,区域id
            }
         * @para result 成功或失败。例:
            成功 - 返回对应的结果
            {
                "code": 0,
                "info":
                {
                    "area_id": 1,                int,区域id
                    "area_name": "",             string,区域名
                    "panorama_url": "",          string,全景图地址
                    "duration": 1,               int,人脸框采集间隔
                    "detect_model": "person",    string,检测模型
                    "items": [
                        {
                            "id": 1,                     int,记录id
                            "video_id": 1,               int,摄像头id
                            "video_name": "",            string,摄像头名
                            "camera_scene_url": "",      string,摄像头场景图地址
                            "point_info": "{}",          json-string,json格式的属性字段
                        }
                    ]
                } 
            }
            [字段] point_info 取值:
                {
                   "point_camera": {   //摄像头场景图上瞄点采用逆时针方向选取A,B,C,D
                        "height_rate": 0.8,     float,高度缩放比例
                        "wide_rate": 0.8,       float,宽度缩放比例
                        "Ax": 1,        int,必填,A点x坐标
                        "Ay": 1,        int,必填,A点y坐标
                        "Bx": 1,        int,必填,B点x坐标
                        "By": 1,        int,必填,B点y坐标
                        "Cx": 1,        int,必填,C点x坐标
                        "Cy": 1,        int,必填,C点y坐标
                        "Dx": 1,        int,必填,D点x坐标
                        "Dy": 1         int,必填,D点y坐标
                    },
                    "point_panorama": {      //全景图上瞄点采用逆时针方向选取A,B,C,D
                        "height_rate": 0.8,     float,高度缩放比例
                        "wide_rate": 0.8,       float,宽度缩放比例
                        "Ax": 1,        int,必填,A点x坐标
                        "Ay": 1,        int,必填,A点y坐标
                        "Bx": 1,        int,必填,B点x坐标
                        "By": 1,        int,必填,B点y坐标
                        "Cx": 1,        int,必填,C点x坐标
                        "Cy": 1,        int,必填,C点y坐标
                        "Dx": 1,        int,必填,D点x坐标
                        "Dy": 1         int,必填,D点y坐标
                    }
                }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryPointMappingInfoByArea(string vCond, out string result);

        /**
         * @brief DeleteCameraPointMapping 删除摄像头映射信息
         * @since V3.20190611
         *
         * @para vRecord 摄像头映射信息
            example:
            {
                "area_id": 1,       int,必填,区域id
                "video_id": 1       int,必填,摄像头id
            }
         * @para result 成功或失败。例:
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void DeleteCameraPointMapping(string vRecord, out string result);


        /**
         * @brief QueryHeatmapData 获取热力图数据
         * @since V3.20190606
         *
         * @para vCond 查询条件
            example:
            {
                "area_id": 1,               int,必填,区域id
                "start_time": "",           string,必填,开始时间
                "stop_time": ""             string,必填,结束时间
            }
         * @para result 成功或失败。例:
            成功 - 返回对应的结果
            {
                "code": 0,
                "info":
                {
                    "items": [
                        {
                            "x": 1,         int,x坐标
                            "y": 1,         int,y坐标
                            "heat": 1,      int,热力值
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryHeatmapData(string vCond, out string result);
        
        //////////////////////////////商场主页面板功能定义开始/////////////////////////////////////////
       /**
         * @brief  QueryCustomersConsititution 客流构成
         * @since  V3.20190618
         *
         * @param data json格式的字符串。
         example: 
         {
             "type": 0,  必填,int,查询类型 0-今日 1-昨日 2-近一周，不含今日 3-近一月，不含今日 4-近三月，不含今日
         }
         * @param result 输出json格式字符串。
         成功 - 返回对应结果
         {
             "code": 0,
             "info": {
                 "male" : 1, int,男性数量
                 "female" : 98, int,女性数量
                 "unknow" : 1, int,未知性别数量
                 "age_sections": [
                     {
                         "age":"0-12", string,年龄标签
                         "count":1, int,该年龄段数量
                     },
                     ...
                 ]
             }
         }
         失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryCustomersConsititution(string cond, out string result);

        /**
         * @brief  QueryCustomersLinkRelative 客流环比(近15日数据，不含今日)
         * @since  V3.20190618
         *
         * @param data json格式的字符串。
         example: 
         {
         }
         * @param result 输出json格式字符串。
         成功 - 返回对应结果
         {
             "code": 0,
             "info": {
                 "items": [
                     {
                         "date": "2019-06-18",   string,日期
                         "total": 100,   int,该日客流量
                         "relative": 10  int,环比增减率
                     },
                     ...
                 ]
             }
         }
         失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryCustomersLinkRelative(string cond, out string result);

        /**
         * @brief  QueryCapiteStayTime 人均停留时间(近30日数据，含今日)
         * @since  V3.20190618
         *
         * @param data json格式的字符串。
         example: 
         {
         }
         * @param result 输出json格式字符串。
         成功 - 返回对应结果
         {
             "code": 0,
             "info": {
                 "item" : [
                     "date": "2019-06-18",   string,日期
                     "male": 1,  int,男性平均停留时间
                     "female":12 int,女性平均停留时间
                 ]
             }
         }
         失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryCapiteStayTime(string cond, out string result);

        /**
         * @brief  QueryAverageCustomerCountByTime 时段客流均值(近30日数据，按小时统计，不含今日)
         * @since  V3.20190618
         *
         * @param data json格式的字符串。
         example: 
         {
            "area_id": x //选填,区域id
         }
         * @param result 输出json格式字符串。
         成功 - 返回对应结果
         {
             "code": 0,
             "info": {
                 "items": [
                     {
                         "hour" : 1,    int,hour
                         "count" : 100   int,客流均值
                     },
                     ...
                 ]
             }
         }
         失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryAverageCustomerCountByTime(string cond, out string result);

        /**
         * @brief  QueryCustomersArrivedInfo 新老顾客对比(近30日数据，不含今日)
         * @since  V3.20190618
         *
         * @param data json格式的字符串。
         example: 
         {
         }
         * @param result 输出json格式字符串。
         成功 - 返回对应结果
         {
             "code": 0,
             "info": {
                "item" : [
                    {
                        "name":"newbee",    int,新顾客占比
                        "percent":1
                    },
                    {
                        "name":"second",    int,二次光顾占比
                        "percent":2
                    },
                    {
                        "name":"multi",    int,多次光顾占比
                        "percent":3
                    },
                    {
                        "name":"vip",    int,VIP顾客占比
                        "percent":94
                    }
                 ]
             }
         }
         失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryCustomersArrivedInfo(string cond, out string result);

        /**
         * @brief  QueryCommercialAblility 业态集客力(近30日数据，不含今日)
         * @since  V3.20190618
         *
         * @param data json格式的字符串。
         example: 
         {
         }
         * @param result 输出json格式字符串。
         成功 - 返回对应结果
         {
             "code": 0,
             "info": {
                 "items": [
                     {
                         "area_id": 0,   int,二级区域id
                         "area_name": "",    string,区域名
                         "customer_count": 0 int,客流量
                     },
                     ...
                 ]
             }
         }
         失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryCommercialAblility(string cond, out string result);

        /**
         * @brief  QueryStoreCustomersRank 店铺客流排行(近30日数据，不含今日)
         * @since  V3.20190618
         *
         * @param data json格式的字符串。
         example: 
         {
         }
         * @param result 输出json格式字符串。
         成功 - 返回对应结果
         {
             "code": 0,
             "info": {
                 "items": [
                     {
                         "area_id": 0,   int,三级区域id
                         "area_name": "",    string,区域名
                         "customer_count": 0 int,客流量
                     },
                     ...
                 ]
             }
         }
         失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryStoreCustomersRank(string cond, out string result);

        /**
         * @brief  QueryMarketMainPageInfos 查询商场主页信息
         * @since  V3.20190627
         *
         * @param data json格式的字符串。
         example: 
         {
             "type": 0,  必填,int,查询类型 0-今日 1-昨日 2-近一周，不含今日 3-近一月，不含今日 4-近三月，不含今日
         }
         * @param result 输出json格式字符串。
         成功 - 返回对应结果
         {
             "code": 0,
             "info": {
                 "items": {
                     "customers_consititution":{
                         "male" : 1, int,男性所占百分比
                         "female" : 98, int,女性所占百分比
                         "unknow" : 1, int,未知性别所占百分比
                         "age_sections": [
                             {
                                 "age":"0-12", string,年龄标签
                                 "percent":1, int,该年龄段所占百分比
                             },
                             ...
                         ]
                     },
                     "relative":[
                         {
                             "date": "2019-06-18",   string,日期
                             "total": 100,   int,该日客流量
                             "relative": 10  int,环比增减率
                         },
                         ...
                     ],
                    "capite_stay_time":[
                         {
                             "date": "2019-06-18",
                             "male": 1,
                             "female":12
                         },
                         ...
                     ],
                     "average_customer_count_by_time":[
                         {
                             "hour" : 1,    int,hour
                             "count" : 100   int,客流均值
                         },
                         ...
                     ],
                     "customers_arrived": {
                         "newbee" : 1,   int,新顾客占比
                         "second" : 1,   int,二次光顾占比
                         "multi" : 1,   int,多次光顾占比
                         "vip" : 1   int,VIP顾客占比
                     },
                     "commercial_ablility": [
                         {
                             "area_id": 0,   int,二级区域id
                             "area_name": "",    string,区域名
                             "customer_count": 0 int,客流量
                         },
                         ...
                     ],
                     "store_customers_rank": [
                         {
                             "area_id": 0,   int,二级区域id
                             "area_name": "",    string,区域名
                             "customer_count": 0 int,客流量
                         },
                         ...
                     ]
                 }
             }
         }
         失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryMarketMainPageInfos(string cond, out string result);

        /**
         * @brief  QueryTodayCustomerCount 查询今日客流总量
         * @since  V3.20190709
         *
         * @param data json格式的字符串。
         example: 
         {
         }
         * @param result 输出json格式字符串。
         成功 - 返回对应结果
         {
             "code": 0,
             "info": {
                 "date":"2019-07-01", string,查询日期
                "customer_count": 0 int,今日客流量
             }
         }
         失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryTodayCustomerCount(string cond, out string result);

        /**
         * @brief  QueryStoreRelationship 查询店铺相关度
         * @since  V3.20190710
         *
         * @param data json格式的字符串。
         example: 
         {
         }
         * @param result 输出json格式字符串。
         成功 - 返回对应结果
         {
             "code": 0,
             "info": {
                "items":{
                    "relationship":[
                        {
                            "area_name1":"name1",   string,区域名称
                            "area_name2":"name2",   string,区域名称
                            "relevancy":1   int,相关度
                        },
                        ...
                    ],
                    "area_names":"name1,name2,name3"   string,区域名称,以","分割
                }
             }
         }
         失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryStoreRelationship(string cond, out string result);

        /**
         * @brief  QueryMainPageStoreIncome 查询主页商铺收入
         * @since  V3.20190731
         *
         * @param data json格式的字符串。
         example: 
         {
            "date_count":1  int,选填,查询收入记录的日期总数
         }
         * @param result 输出json格式字符串。
         成功 - 返回对应结果
         {
             "code": 0,
             "info": {
                "items":[
                    {
                        "date":"2019-07-01", string,收入日期
                        "income": 0 int,该日期总收入
                    }
                    ...
                ]
             }
         }
         失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryMainPageStoreIncome(string cond, out string result);
        /////////////////////////////////商场主页面板功能定义结束/////////////////////////////////////////

        /**
         * @brief  AddStoreIncome 新增商铺收入记录
         * @since  V3.20190731
         * @update V3.20200102 返回记录id
         *
         * @param data json格式的字符串。
         example: 
         {
            "area_name":1, int,必填,区域名称
            "date":"2019-01-01", string,必填,收入日期
            "income":1, int,必填,具体收入
         }
         * @param result 输出json格式字符串。
         成功 - {"code": 0, "info": {"id": 1}}
         失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void AddStoreIncome(string cond, out string result);

        /**
         * @brief  UpdateStoreIncome 修改商铺收入记录
         * @since  V3.20190731
         *
         * @param data json格式的字符串。
         example: 
         {
            "id":1, int,必填,该条记录id
            "income":1, int,必填,具体收入
         }
         * @param result 输出json格式字符串。
         成功 - {"code": 0}
         失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void UpdateStoreIncome(string cond, out string result);

        /**
         * @brief  QueryStoreIncomeList 查询商铺收入记录列表
         * @since  V3.20190731
         *
         * @param data json格式的字符串。
         example: 
         {
            "area_id":1 int,必填,区域ID
            "query_date":"2019-01" string,必填,查询的月份
         }
         * @param result 输出json格式字符串。
         成功 - 返回对应结果
         {
             "code": 0,
             "info": {
                "items":[
                    {
                        "id":1, int,记录id
                        "date":"2019-07-01", string,收入日期
                        "income": 0 int,该区域收入
                        "area_id":1 int,区域id
                        "area_name":"xxx" string,区域名称
                    }
                    ...
                ]
             }
         }
         失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryStoreIncomeList(string cond, out string result);

        /**
         * @brief AddRetrieveMap 新增轨迹检索地图
         * @since  V3.20190702
         * @update V3.20200102 返回地图id
         * @update V3.20200605 增加组织id
         *
         * @para vInfo 轨迹检索地图信息
            example:
            {
                "org_id": 1,            int,必填,组织id
                "name": "",             string,必填,地图名
                "map_url": "",          string,必填,地图url
                "video_list": "1,2",    string,必填,摄像头列表
                "attribute":"{}",       json-string,必填,json格式的属性字段
                "remark": ""            string,选填,备注信息
            }
         * @para result 成功或失败。例:
            成功 - {"code": 0, "info": {"id": 1}}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void AddRetrieveMap(string vInfo, out string result);

        /**
         * @brief DeleteRetrieveMap 删除轨迹检索地图
         * @since V3.20190702
         *
         * @para vRecord 轨迹检索地图信息
            example:
            {
                "id": 1,           int,必填,地图id
            }
          * @para result 成功或失败。例:
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void DeleteRetrieveMap(string vRecord, out string result);

        /**
         * @brief UpdateRetrieveMap 修改轨迹检索地图
         * @since V3.20190702
         *
         * @para vInfo 轨迹检索地图信息
            example:
            {
                "id": 1,                int,必填,地图id
                "name": "map1",         string,选填,地图名
                "map_url": "",          string,选填,地图url
                "video_list": "1,2",    string,选填,摄像头列表
                "attribute":"{}",       json-string,选填,json格式的属性字段
                "remark": ""            string,选填,备注信息
            }
         * @para result 成功或失败。例:
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void UpdateRetrieveMap(string vInfo, out string result);

        /**
         * @brief QueryRetrieveMapInfo 查询轨迹检索地图信息
         * @since V3.20190702
         * @update V3.20200605 增加组织信息
         *
         * @para vCond 查询条件
            example:
            {
                "id": 1,               int,必填,地图id
            }
         * @para result 成功或失败。例:
            成功 - 返回对应的结果
            {
                "code": 0,
                "info":
                {
                    "id": 1,                int,记录id
                    "name": "",             string,地图名
                    "map_url": "",          string,地图url
                    "video_list": [ {"id": 1, "name": "xx", "state": 0} ], 视频列表,[{id,name,state},...],字段state,0:离线,1:在线
                    "attribute":"{}",       json-string,json格式的属性字段
                    "remark": ""            string,备注信息
                } 
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryRetrieveMapInfo(string vCond, out string result);

        /**
         * @brief QueryRetrieveMapList 查询轨迹检索地图列表
         * @since V3.20190702
         *
         * @para vCond 查询条件
            example:
            {
                "page_no": 1,               int,必填,页号
                "page_size": 10,            int,必填,每页个数
                "org_id": 1,                int,必填,组织id
                "query_cond":
                {
                    "name": "",             string,选填,地图名
                }
            }
         * @para result 成功或失败。例:
            成功 - 返回对应的结果
            {
                "code": 0,
                "info":
                {
                    "page_no": 2,
                    "page_size": 10,
                    "total_count": 1,
                    "items": [
                        {
                            "id": 1,                int,地图id
                            "name": "",             string,地图名
                            "org_id": 1,            int,组织id
                            "organization": "",     string,组织名
                            "map_url": "",          string,地图url
                            "video_list": [ {"id": 1, "name": "xx", "state": 0} ], 视频列表,[{id,name,state},...],字段state,0:离线,1:在线
                            "attribute":"{}",       json-string,json格式的属性字段
                            "remark": ""            string,备注信息
                        }
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void QueryRetrieveMapList(string vCond, out string result);

        /**
         -----------------------------------------------------------------------
         访客机
         -----------------------------------------------------------------------
        **/
        /**
         * @brief  AddVisitorDevice 添加访客机
         * @since V3.20200609
         *
         * @param device 考勤机信息
            example:
            {
                "name": "",     必填,string,访客机标识
                "sn": "",       必填,string,访客机序列号
                "org_id": 9,    必填,int,组织id
                "site_id": 1,   必填,int,地点id
                "lib_id": 1,    必填,int,底库id
                "remark": 1,    必填,string,备注信息
            }
         * @param result 成功或失败。例：
             成功 - {"code": 0}
             失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void AddVisitorDevice(string cond, out string result);

        /**
         * @brief  DeleteVisitorDevice 删除访客机
         * @since V3.20200609
         *
         * @param device 访客机信息
            example:
            {
                "id": 9,        必填,int,记录id
            }
         * @param result 成功或失败。例：
             成功 - {"code": 0}
             失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void DeleteVisitorDevice(string cond, out string result);

        /**
         * @brief  UpdateVisitorDevice 修改访客机
         * @since V3.20200609
         *
         * @param device 访客机信息
            example:
            {
                "id": 9,        必填,int,记录id
                "name": "",     选填,string,访客机标识
                "sn": "",       选填,string,访客机序列号
                "site_id": 1,   选填,int,地点id
                "lib_id": 1,    选填,int,底库id
                "remark": 1,    选填,string,备注信息
            }
         * @param result 成功或失败。例：
             成功 - {"code": 0}
             失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void UpdateVisitorDevice(string cond, out string result);

        /**
         * @brief  QueryVisitorDeviceList 查询访客机列表
         * @since V3.20200609
         *
         * @param cond 查询条件
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "org_id": 1,        必填,int,组织id
                "query_cond": {
                    "name": "",             选填,string,访客机标识,模糊匹配
                    "site_list": "",        选填,string,地点列表,地点id直接以逗号间隔
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "page_no":xx,
                    "page_size":xx,
                    "total_count":xx,
                    "items": [
                        {
                            "dev_id": 1,            // 设备号
                            "name": "office",       // 设备名
                            "sn": "xxx",            // 设备序列号号
                            "org_id":1,             // 设备所属机构id
                            "organization":"xx",    // 设备所属机构名称
                            "site_id":1,            // 设备所属地点id
                            "site_name":"xx",       // 设备所属地点名称
                            "lib_id": 1,            // 设备绑定底库id
                            "lib_name": "",         // 设备绑定底库名
                            "remark":"xxx",         // 备注
                            "online": true,         // 在线状态,true:在线,false:离线
                            "create_time":"xxx"     // 创建时间
                            "update_time":"xxx"     // 更新时间
                        }, ...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryVisitorDeviceList(string cond, out string result);
        
/*****************************************考勤相关接口*************************************/
        /**
         * @brief SetHolidays 设置节假日
         * @since  V1.20200409
         * @update V2.20200513
         *
         * @param info 节假日信息
             example:
             {
                "org_id":0,     必填,int,组织ID
                "year": 2019,   必填,int,年
                "workdays": "1212", 必填,string,工作日列表,自该年一月一日起,1-工作日 2-休息日
                "operator": "jobs", 必填,string,操作者
             }
         * @param result 成功或失败。例：
             成功 - {"code": 0}
             失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void SetHolidays(string info, out string result);

        /**
         * @brief GetHolidays 获取节假日
         * @since  V1.20200409
         * @update V2.20200513
         *
         * @param info 节假日信息
             example:
             {
                "year": 2019    必填,int,年
                "org_id":0      必填,int,组织ID
                "operator": "jobs",     必填,string,操作者
             }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "year": 2019,   int,年
                    "workdays": "1212",   string,工作日列表,自该年一月一日起,1-工作日 2-休息日
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void GetHolidays(string info, out string result);

        /**
         * @brief  AddLeaveInfo 添加请假信息
         * @since  V1.20200409
         *
         * 请假类型:
         * 1:出差
         * 2:参会
         * 3:事假
         * 4:病假
         * 5:产假
         * 6:婚假
         * 7:工伤
         * 8:哺乳假
         * 9:丧假
         * 10:其他
         * @param info 请假信息
            example: 
            {
                "type" : 1,         必填,int,请假类型
                "lib_id" : 1,       必填,int,人员ID
                "lib_name" : "xxx", 必填,string,人员名称
                "people_id" : 1,    必填,int,人员ID
                "people_name" : "xxx",  必填,string,人员名称
                "start_date" : "",  必填,string,请假开始时间
                "end_date" : "",    必填,string,请假结束时间
                "remark" : "",     选填,string,备注
                "org_id" : 1,       必填,int,组织ID
                "operator": "jobs",     必填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddLeaveInfo(string info, out string result);

        /**
         * @brief  UpdateLeaveInfo 更新请假信息
         * @since  V1.20200409
         *
         * 请假类型:
         * 1:出差
         * 2:参会
         * 3:事假
         * 4:病假
         * 5:产假
         * 6:婚假
         * 7:工伤
         * 8:哺乳假
         * 9:丧假
         * 10:其他
         * @param info 请假信息
            example: 
            {
                "id":0,             必填,int,记录id
                "type" : 1,         选填,int,请假类型
                "lib_id" : 1,       选填,int,人员ID
                "lib_name" : "xxx", 选填,string,人员名称
                "people_id" : 1,    选填,int,人员ID
                "people_name" : "xxx",  选填,string,人员名称
                "start_date" : "",  选填,string,请假开始时间
                "end_date" : "",    选填,string,请假结束时间
                "remark" : "",      选填,string,备注
                "org_id" : 1,       必填,int,组织ID
                "operator": "jobs",     必填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void UpdateLeaveInfo(string info, out string result);

        /**
         * @brief  DeleteLeaveInfo 删除请假信息
         * @since  V1.20200409
         *
         * @param info 请假信息
            example: 
            {
                "id":0,             必填,int,记录id
                "org_id" : 1,       必填,int,组织ID
                "operator": "jobs", 必填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
        */
        void DeleteLeaveInfo(string info, out string result);

        /**
         * @brief  QueryLeaveList 查询请假信息
         * @since  V1.20200409
         *
         * @param cond 搜索相关信息
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "org_id": 0,        必填,int,组织id
                "query_cond": {
                    "type" : 0,         选填,int,请假类型
                    "name": "",         选填,string,员工名称
                    "lib_id": 0,        选填,int,底库id
                    "begin_time": "",   选填,string,开始时间
                    "end_time": "",     选填,string,结束时间
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "page_no":xx,
                    "page_size":xx,
                    "total_count":xx,
                    "items": [
                        {
                            "id" : 1,           int,记录序号
                            "org_id" : 1,       int,组织ID
                            "type" : 1,         int,请假类型
                            "lib_id" : 1,       int,人员ID
                            "lib_name" : "xxx", string,人员名称
                            "people_id" : 1,    int,人员ID
                            "people_name" : "xxx",  string,人员名称
                            "start_date" : "",  string,请假开始时间
                            "end_date" : "",    string,请假结束时间
                            "remark" : "",      string,备注
                        }, ...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryLeaveList(string cond, out string result);

        /**
         * @brief  AddReSigninInfo 添加补签信息
         * @since  V1.20200409
         * @update  V2.20200514
         *
         * @param info 补签信息
            example: 
            {
                "lib_id" : 1,       必填,int,底库ID
                "lib_name" : "",    必填,string,底库名称
                "people_id" : 1,    必填,int,员工ID
                "people_name" : "", 必填,string,员工名称
                "type" : 1,         必填,int,补签类型,1:上班,2:下班
                "rule_id" : 1,      必填,int,考勤主规则ID
                "rule_name" : "",   必填,int,考勤主规则名称
                "sub_rule_id" : 1,  必填,int,考勤子规则ID
                "sub_rule_name" : "",   必填,int,考勤子规则名称
                "signin_date" : "", 必填,string,补签日期 格式:"2020-01-01"
                "remark" : "",      选填,string,补签原因
                "org_id" : 1,       必填,int,组织ID
                "operator": "jobs",     必填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddReSigninInfo(string info, out string result);

        /**
         * @brief  UpdateReSigninInfo 修改补签信息
         * @since  V1.20200409
         *
         * @param info 补签信息
            example: 
            {
                "rule_id" : 0,      必填,int,记录id
                "lib_id" : 1,       选填,int,底库ID
                "lib_name" : "",    选填,string,底库名称
                "people_id" : 1,    选填,int,员工ID
                "people_name" : "", 选填,string,员工名称
                "type" : 1,         选填,int,补签类型,1:上班,2:下班
                "signin_date" : "", 必填,string,补签日期 格式:"2020-01-01"
                "remark" : "",      选填,string,补签原因
                "org_id" : 1,       必填,int,组织ID
                "operator": "jobs", 必填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdateReSigninInfo(string info, out string result);

        /**
         * @brief  DeleteReSigninInfo 删除补签信息
         * @since  V1.20200409
         *
         * @param info 补签信息
            example: 
            {
                "rule_id" : 1,           必填,int,记录ID
                "org_id" : 1,       必填,int,组织ID
                "operator": "jobs", 必填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteReSigninInfo(string info, out string result);

        /**
         * @brief  QueryReSigninList 查询补签信息
         * @since  V1.20200409
         *
         * @param cond 搜索相关信息
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "org_id": 0,        必填,int,底库id
                "query_cond": {
                    "name": "",         选填,string,员工名称
                    "lib_id": 0,        选填,int,底库id
                    "type": 0,          选填,int,"1-上班 2-下班"
                    "begin_time": "",   选填,string,开始时间
                    "end_time": "",     选填,string,结束时间
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "page_no":xx,
                    "page_size":xx,
                    "total_count":xx,
                    "items": [
                        {
                            "id" : 1,           int,记录序号
                            "org_id" : 1,       int,组织id
                            "lib_id" : 1,       int,底库id
                            "lib_name" : "",    string,底库名称
                            "rule_name" : "",   string,考勤主规则名称
                            "sub_rule_name" : "",    string,考勤子规则名称
                            "people_id" : 1,    int,员工id
                            "people_name" : "", string,员工名称
                            "type" : 1,         int,补签类型,1:上班,2:下班
                            "signin_time" : "", string,补签时间 格式:"2020-01-01"
                            "remark" : "",      string,补签原因
                        }, ...
                    ]
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryReSigninList(string cond, out string result);

        /**
         * @brief  AddAttendanceRule 添加考勤规则
         * @since  V1.20200409
         * @update  V2.20200514
         *
         * @param cond 搜索相关信息
            example:
            {
                "name":"",                  必填,string,考勤规则名
                "enable_holiday":0,         必填,int,节假日休息标识，0-节假日不可用 1-节假日可用
                "type":1,                   必填,int,规则类型 1-固定考勤 2-时长考勤 3-排班考勤
                "enable_over_work":0,       必填,int,是否开启加班   0-关闭 1-开启
                "property": {}              必填,具体根据type确定
                "org_id" : 1,               必填,int,组织ID
                "operator": "jobs",         必填,string,操作者
                "dead_line":"00 04:00:00"   选填,string,下班卡截止时间,固定和时长考勤必填
                "enable_dead_line_cross":0  选填,int,下班卡截止时间是否跨天 0-不跨天 1-跨天,固定和时长考勤必填
                "unsign_threshold":30,      选填,int,签到延迟阈值, 单位/分钟(固定时长-漏打卡/早退阈值 时长考勤-当班阈值 排班考勤-漏打卡阈值)
                "over_work_threshold":30,   选填,int,加班开始延迟阈值, 单位/分钟
                "remark":"",                选填,string,备注
                "dead_line_threshold":240,  选填,int,截止时间,最后时间延后阈值,轮班考勤必填
                "team_count":3,             选填,int,班组数量,轮班考勤必填
                "shift_period":3,           选填,int,排班周期,轮班考勤必填
                "shift_times":3,            选填,int,每日排班次数,轮班考勤必填
                "start_date":"2020-05-07",  选填,string,主规则开始日期,排班考勤必填
            }
            type=1:固定时长考勤规则
            "property": {
                "rule_info":    //最多四组规则，四组规则时间不交叉，时间顺序增加
                [
                    { 
                        "name":"rule_name",                 string,子规则名称
                        "start_signin_time":"00 09:00:00",  string,开始签到时间
                        "end_signin_time":"00 09:00:00",    string,结束签到时间
                        "start_signout_time":"00 18:00:00", string,开始签退时间
                        "end_signout_time":"00 18:00:00",   string,结束签退时间
                    },...
                ]
            }
            type=2:时长考勤规则
            "property": {
            
            }
            type=3:轮班考勤规则
            "property": {
                "rule_info":
                [
                    {
                        "index":0,                          int,该规则日期索引,0-第一天 1-第二天,以此类推
                        "rule_index":0,                     int,该规则索引,0-第一班 1-第二班,以此类推
                        "team_index":0,                     int,该规则班组索引
                        "sub_rule_name":"A班组",            string,该规则适用班组
                        "start_signin_time":"00 07:00:00",  string,签到开始时间
                        "end_signin_time":"00 09:00:00",    string,签到结束时间
                        "start_signout_time":"00 17:00:00", string,签退开始时间
                        "end_signout_time":"00 19:00:00"    string,签退结束时间
                    },...
                ]
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void AddAttendanceRule(string cond, out string result);

        /**
         * @brief  UpdateAttendanceRule 更新考勤规则
         * @since  V1.20200409
         *
         * @param cond 搜索相关信息
            example:
            {                
                "rule_id":0,                     必填,int,考勤规则ID
                "name":"",                  必填,string,考勤规则名
                "enable_holiday":0,         必填,int,节假日休息标识，0-节假日不可用 1-节假日可用
                "type":1,                   必填,int,规则类型 1-固定考勤 2-时长考勤 3-排班考勤
                "enable_over_work":0,       必填,int,是否开启加班   0-关闭 1-开启
                "property": {}              必填,具体根据type确定
                "org_id" : 1,               必填,int,组织ID
                "operator": "jobs",         必填,string,操作者
                "dead_line":"00 04:00:00"   选填,string,下班卡截止时间,固定和时长考勤必填
                "enable_dead_line_cross":0  选填,int,下班卡截止时间是否跨天 0-不跨天 1-跨天,固定和时长考勤必填
                "unsign_threshold":30,      选填,int,签到延迟阈值, 单位/分钟(固定时长-漏打卡/早退阈值 时长考勤-当班阈值 排班考勤-漏打卡阈值)
                "over_work_threshold":30,   选填,int,加班开始延迟阈值, 单位/分钟
                "remark":"",                选填,string,备注
                "dead_line_threshold":240,  选填,int,截止时间,最后时间延后阈值,轮班考勤必填
                "team_count":3,             选填,int,班组数量,轮班考勤必填
                "shift_period":3,           选填,int,排班周期,轮班考勤必填
                "shift_times":3,            选填,int,每日排班次数,轮班考勤必填
                "start_date":"2020-05-07"   选填,string,主规则开始日期,排班考勤必填
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void UpdateAttendanceRule(string cond, out string result);

        /**
         * @brief  DeleteAttendanceRule 删除考勤规则
         * @since  V1.20200409
         *
         * @param cond 搜索相关信息
            example:
            {
                "rule_id":0,        必填,int,考勤规则ID
                "type":0,           必填,int,考勤规则类型
                "org_id" : 1,       必填,int,组织ID
                "operator": "jobs", 必填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void DeleteAttendanceRule(string cond, out string result);

        /**
         * @brief  GetSimpleAttendanceRuleList 查询简单考勤规则列表
         * @since  V1.20200409
         *
         * @param cond 搜索相关信息
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "org_id":0,         必填,int,组织ID
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {                
                "code": 0, 
                "info": {
                    "page_no":xx,
                    "page_size":xx,
                    "total_count":xx,
                    "items": [
                        {
                            "rule_id":0,        int,考勤规则ID
                            "name":"",          string,考勤规则名
                            "type":1,           int,规则类型 1-固定考勤 2-时长考勤 3-排班考勤
                        }
                    ]
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void GetSimpleAttendanceRuleList(string cond, out string result);

        /**
         * @brief  GetSimpleSubAttendanceRuleList 查询简单子规则列表
         * @since  V1.20200409
         *
         * @param cond 搜索相关信息
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "org_id":0,         必填,int,组织ID
                "rule_id":0,        必填,int,主规则ID
                "type":0,           选填,int,规则type 1-固定考勤 2-时长考勤 3-排班考勤
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {                
                "code": 0, 
                "info": {
                    "page_no":xx,
                    "page_size":xx,
                    "total_count":xx,
                    "items": [
                        {
                            "rule_id":0,    int,考勤规则ID
                            "name":"",          string,考勤规则名
                            "type":1,           int,规则类型 1-固定考勤 2-时长考勤 3-排班考勤
                            "property" : {}
                        }
                    ]
            }
            for property:
            type 1-固定考勤
            {
                "start_signin_time" : "00 09:00:00",
                "end_signin_time" : "00 09:30:00",
                "start_signout_time" : "01 09:00:00",
                "end_signout_time" : "01 09:30:00"
                "rule_id" :1,
                "sub_rule_name" : "",
                "type" : 1
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void GetSimpleSubAttendanceRuleList(string cond, out string result);

        /**
         * @brief  QueryAttendanceRuleList 查询考勤规则列表
         * @since  V1.20200409
         *
         * @param cond 搜索相关信息
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "org_id":0,         必填,int,组织ID
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {                
                "code": 0, 
                "info": {
                    "page_no":xx,
                    "page_size":xx,
                    "total_count":xx,
                    "items": [
                        {
                            "rule_id":0,        int,考勤规则ID
                            "org_id":0,         int,组织ID
                            "name":"",          string,考勤规则名
                            "type":1,           int,规则类型 1-固定考勤 2-时长考勤 3-排班考勤
                            "bind_count":0      int,绑定人数
                            "remark":"xxx"      string,备注
                        }
                    ]
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryAttendanceRuleList(string cond, out string result);

        /**
         * @brief  QueryAttendanceRuleBindList 查询考勤规则绑定列表
         * @since  V1.20200409
         *
         * @param cond 搜索相关信息
            example:
            {
                "page_no": 1,       必填,int,页号
                "page_size": 10,    必填,int,每页个数
                "type": 1,          必填,int,规则类型 1-固定考勤 2-时长考勤 3-轮班考勤
                "rule_id": 1,       必填,int,主考勤ID
                "org_id":0,         必填,int,组织ID
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {                
                "code": 0, 
                "info": {
                    "page_no":xx,
                    "page_size":xx,
                    "total_count":xx,
                    "items": [
                        {
                            "rule_id":0,        int,考勤规则ID
                            "org_id":0,         int,组织ID
                            "rule_name":"",     string,考勤规则名
                            "type":1,           int,规则类型 1-固定考勤 2-时长考勤 3-排班考勤
                            "people_id":1       int,人员ID
                            "people_name":""    string,人员名称
                        }
                    ]
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryAttendanceRuleBindList(string cond, out string result);

        /**
         * @brief  QueryAttendanceRuleInfo 查询考勤规则信息
         * @since  V1.20200409
         * @update  V2.20200514
         *
         * @param cond 搜索相关信息
            example:
            {
                "org_id":0,         必填,int,组织ID
                "type":1,           必填,int,规则类型, 1-固定时长考勤 2-不固定时长 3-轮班
                "rule_id":0,        必填,int,主规则ID
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {                
                "rule_id" : 1,          int,主规则ID
                "rule_name" : "",       int,主规则名称
                "enable_holiday" : 1,   int,节假日可用 0-不可用 1-可用
                "enable_cross_day" : 1, int,是否跨天 0-不跨天 1-跨天
                "unsign_threshold" : 30,int,漏打卡阈值，单位/分钟
                "enable_over_work" : 1, int,是否开启加班 0-关闭 1-开启
                "over_work_threshold" : 30, int,加班阈值,单位/分钟
                "dead_line" : "01 04:00:00",int,截止日期
                "type" : 1,             int,规则类型 1-固定时长2-不固定时长 3-轮班
                "remark" : "",          string,备注
                "org_id" : 1,           int,组织ID
                "rule_info" : [         子规则信息
                    {}
                ],
                "dead_line_threshold":240,  int,截止时间,最后时间延后阈值,轮班考勤独有
                "team_count":3,             int,班组数量,轮班考勤独有
                "shift_period":3,           int,排班周期,轮班考勤独有
                "shift_times":3,            int,每日排班次数,轮班考勤独有
                "start_date":"2020-05-07",  string,主规则开始日期,轮班考勤独有
           }
            for rule_info:
            type = 1 固定时长考勤
            {
                "sub_rule_id" : 1,  int,子规则ID
                "sub_rule_name" : "",                  string,子规则名称
                "start_signin_time" : "00 09:00:00",   string,开始签到时间
                "end_signin_time" : "00 09:30:00",     string,结束签到时间
                "start_signout_time" : "00 18:00:00",  string,开始签退时间
                "end_signout_time" : "00 18:30:00"     string,结束签退时间
            }
            type = 2 时长考勤
            {
            }
            type = 3 轮班考勤
            {
                "index":0,                          int,该规则日期索引,0-第一天 1-第二天,以此类推
                "rule_index":0,                     int,该规则索引,0-第一班 1-第二班,以此类推
                "team_index":0,                     int,该规则班组索引
                "sub_rule_name":"A班组",            string,该规则适用班组
                "start_signin_time":"00 07:00:00",  string,签到开始时间
                "end_signin_time":"00 09:00:00",    string,签到结束时间
                "start_signout_time":"00 17:00:00", string,签退开始时间
                "end_signout_time":"00 19:00:00"    string,签退结束时间
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryAttendanceRuleInfo(string cond, out string result);

        /**
         * @brief  BatchSetAttendanceRule 批量设置考勤规则
         * @since  V1.20200409
         * @update  V2.20200514
         *
         * @param cond 搜索相关信息
            example:
            {
                "rule_id":0,            必填,int,考勤规则ID
                "people_id_list":"1",   必填,string,人员ID列表
                "org_id" : 1,           必填,int,组织ID
                "operator": "jobs",     必填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void BatchSetAttendanceRule(string cond, out string result);

        /**
         * @brief  SetPeopleAttendanceRule 设置考勤规则
         * @since  V1.20200409
         *
         * @param cond 搜索相关信息
            example:
            {
                "rule_id":0,            必填,int,考勤规则ID
                "people_id":1,          必填,int,人员ID
                "org_id" : 1,           必填,int,组织ID
                "operator": "jobs"      必填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - {"code": 0}
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void SetPeopleAttendanceRule(string cond, out string result);

        /**
         * @brief  QueryCurMonthAttendance 查询当月考勤统计
         * @since  V1.20200409
         *
         * @param cond 搜索相关信息
            example:
            {
                "org_id" : 1,           必填,int,组织ID
                "start_time":"2020-04-01",  必填,string,开始时间
                "end_time":"2020-04-01",    必填,string,结束时间
                "operator": "jobs",     必填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "org_id" : 1,               int,组织ID
                    "late_count" : 1,           int,迟到总数
                    "early_leave_count" : 1,    int,早退人员总数
                    "unsignin_count" : 1,       int,漏打卡总数
                    "absent_count" : 1,         int,缺勤总数
                    "leave_count" : 1,          int,请假总数
                    "resign_count" : 1          int,补签总数
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryCurMonthAttendance(string cond, out string result);

        /**
         * @brief  QueryAttendanceToday 查询今日考勤统计
         * @since  V1.20200409
         *
         * @param cond 搜索相关信息
            example:
            {
                "org_id" : 1,           必填,int,组织ID
                "operator": "jobs",     必填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "org_id" : 1,               int,组织ID
                    "people_count" : 1,         int,应到人员总数
                    "arrive_count" : 1,         int,实到人员总数
                    "late_count" : 1,           int,迟到总数
                    "unsignin_count" : 1,       int,漏打卡总数
                    "leave_count" : 1           int,请假总数
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryAttendanceToday(string cond, out string result);

        /**
         * @brief  QueryAttendanceList 查询考勤记录列表
         * @since  V1.20200409
         *
         * @param cond 搜索相关信息
            example:
            {
                "page_no": 1,           必填,int,页号
                "page_size": 10,        必填,int,每页个数
                "org_id" : 1,           必填,int,组织ID
                "operator": "jobs",     必填,string,操作者
                "query_cond": {
                    "start_time":"2020-04-01",  选填,string,开始时间
                    "end_time":"2020-04-01",    选填,string,结束时间
                    "lib_id":1,                 选填,int,底库id
                    "people_name":"",           选填,string,员工名称
                    "rule_id":1,                选填,int,考勤规则ID
                    "state":0                   选填,int,异常状态 1-迟到 2-早退 3-漏打卡 4-缺勤 5-请假 6-加班 7-补卡
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "page_no":xx,
                    "page_size":xx,
                    "total_count":xx,
                    "items": [
                        {
                            "id" : 1,                   int,记录序号
                            "org_id" : 1,               int,组织ID
                            "people_id" : 1,            int,人员ID
                            "people_name" : "xxx",      string,人员名称
                            "lib_id" : 1,               int,人员ID
                            "lib_name" : "xxx",         string,人员名称
                            "rule_id" : 1,              int,考勤规则ID
                            "rule_name" : "",           string,考勤规则名称
                            "attend_date" : "2020-01-01",   string,考勤日期
                            "signin_time" : "09:00:00",     string,签到时间
                            "signout_time" : "09:00:00",    string,签退时间
                            "late_mins" : 30,           int,迟到时长 单位/分钟
                            "early_leave_mins" : 30,    int,早退时长 单位/分钟
                            "over_work_mins" : 30,      int,加班时长 单位/分钟
                            "forget_sigin_times" : 1,        int,漏打卡次数,每个规则最大2次,2次即为缺勤
                            "absent_times" : 0,         int,缺勤次数,每个规则最大缺勤次数一次
                            "resign_times" : 0,         int,补签次数
                            "is_leave" : 0              int,是否请假
                        }, ...
                    ]
                    "others":{                          其他统计数据
                        "total_late_mins" : 30,         int,所有迟到分钟和
                        "total_late_times" : 30,        int,所有迟到人数和
                        "total_early_leave_mins" : 30,  int,所有早退分钟和
                        "total_early_leave_times" : 30, int,所有早退人数和
                        "total_over_work_mins" : 30,    int,所有加班分钟和
                        "total_over_work_times" : 30,   int,所有加班人数和
                        "total_forget_sigin_times" : 30,     int,所有漏打卡次数
                        "total_absent_times" : 30,      int,所有缺勤次数
                        "total_leave_days" : 30         int,所有请假天数
                    }
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryAttendanceList(string cond, out string result);

        /**
         * @brief  QueryTodayAttendanceList 查询今日考勤记录列表
         * @since  V1.20200409
         *
         * @param cond 搜索相关信息
            example:
            {

                "page_no": 1,           必填,int,页号
                "page_size": 10,        必填,int,每页个数
                "org_id" : 1,           必填,int,组织ID
                "operator": "jobs",     必填,string,操作者
                "query_cond": {
                    "lib_id":1,                 选填,int,底库id
                    "rule_id":1,                选填,int,考勤规则ID
                    "state":0                   选填,int,异常状态 1-迟到 3-漏打卡 5-请假
                }
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "page_no":xx,
                    "page_size":xx,
                    "total_count":xx,
                    "items": [
                        {
                            "org_id" : 1,               int,组织ID
                            "people_id" : 1,            int,人员ID
                            "people_name" : "xxx",      string,人员名称
                            "lib_id" : 1,               int,人员ID
                            "lib_name" : "xxx",         string,人员名称
                            "rule_id" : 1,              int,考勤规则ID
                            "rule_name" : "",           string,考勤规则名称
                            "signin_time" : "2020-04-01 09:00:00",     string,签到时间
                            "state" : 0                 int,1-迟到 3-漏打卡 5-迟到
                        }, ...
                    ]
                    "others":{                          其他统计数据
                        "total_late_times" : 30,        int,所有迟到人数和
                        "total_forget_sigin_times" : 30,     int,所有漏打卡次数
                        "total_people" : 30,            int,所有考勤人员数
                        "total_leave_times" : 30        int,所有请假人次
                    }
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryTodayAttendanceList(string cond, out string result);

        /**
         * @brief  QueryAttendanceMainPage 查询首页考勤记录统计
         * @since  V1.20200409
         *
         * @param cond 搜索相关信息
            example:
            {

                "site_list" : "1,2",        必填,string,店铺ID列表
                "begin_date":"2020-04-01",  必填,string,开始时间
                "end_date":"2020-04-01",    必填,string,结束时间
                "org_id" : 1,               必填,int,组织ID
                "operator": "jobs",         必填,string,操作者
            }
         * @param result 成功或失败。例：
            成功 - 返回对应结果
            {
                "code": 0, 
                "info": {
                    "resign_count" : 30,            int,补签总和
                    "late_count" : 30,              int,迟到总和
                    "absent_count" : 30,            int,旷工总和
                    "sign_count" : 30,              int,正常总和
                    "record_count" : 30             int,记录总和
                }
            }
            失败 - {"code": <非0>, "msg": "错误说明", "user_visible": false}
         */
        void QueryAttendanceMainPage(string cond, out string result);
/*****************************************考勤相关接口结束*************************************/        
    };
};
