// **********************************************************************
//
// Copyright (c) 2003-2016 ZeroC, Inc. All rights reserved.
//
// **********************************************************************

var Ice = require("ice").Ice;
// var Demo = require("./Hello").Demo;
var Demo = require("./IceBusiness").business;
var config = require("../../../configFile");


// Ice.MessageSizeMax = 204800;
//
// var id = new Ice.InitializationData();

// Ice.createProperties("Ice.MessageSizeMax",204800);
// var Property =Ice.createProperties();
// Property.setProperty("MessageSizeMax",0);
// id.clone();
// id.properties = Ice.createProperties();
// id.properties.setProperty("Ice.MessageSizeMax",204800);
var proxy;

function createProx() {
    console.log("重新创建代理");
    var communicator;
    // communicator = Ice.initialize(process.argv,id);
    communicator = Ice.initialize(['--Ice.MessageSizeMax=0']);
    // communicator = Ice.initialize(id);
    var proxyStr = "business:default -h " + config.iceConfig.iceIp + " -p " + config.iceConfig.port;
    proxy = communicator.stringToProxy(proxyStr);
    if(connectObject){
        connectObject = null;
    }
}

createProx();
// var proxy = communicator.stringToProxy("facenet:default -h 192.168.2.220 -p 10000");
//代理生成对象
var connectObject = "";


function common(method, params, params2) {
    params = changeJson(params);

    if (!connectObject) {
        return new Promise(function (resolve, reject) {
            Demo.IBusinessPrx.checkedCast(proxy).then(function (twoway) {
                connectObject = twoway;
                if (params2 || params2 == 0) {
                    twoway[method](params, params2).then(function (data) {
                        // console.log(data);
                        resolve(JSON.parse(data));
                    }, function (err) {
                        console.log(err);
                        reject(err);
                    })
                } else {
                    twoway[method](params || "").then(function (data) {
                        // console.log(data);
                        resolve(JSON.parse(data));
                    }, function (err) {
                        console.log(err);
                        reject(err);
                    })
                }

            },function (err) {
                    connectObject = null;
                    reject(err);
                    console.log(err);
            })
        })
    } else {
        return new Promise(function (resolve, reject) {
            if (params2 || params2 == 0) {
                connectObject[method](params, params2).then(function (data) {
                    // console.log(data);
                    resolve(JSON.parse(data));
                }, function (err) {
                    console.log(err);
                    reject(err);
                })
            } else {
                connectObject[method](params || "").then(function (data) {
                    // console.log(data);
                    resolve(JSON.parse(data));
                }, function (err) {
                    console.log(err);
                    reject(err);
                })
            }
        });
    }
    // return new Promise(function (resolve,reject) {
    //     Demo.FaceShowPrx.checkedCast(proxy).then(function (twoway) {
    //         twoway[method](params).then(function (data) {
    //             console.log(data);
    //             resolve(data);
    //         },function (err) {
    //             console.log(err);
    //             reject(err);
    //         })
    //     })
    // })
}

//
// function common(method,params) {
//     if(!connectObject){
//         return new Promise(function (resolve,reject) {
//             Demo.IFaceNetPrx.checkedCast(proxy).then(function (twoway) {
//                 // console.log(params);
//                 connectObject = twoway;
//                 twoway[method](params).then(function (data) {
//                     console.log(data);
//                     //json 转换
//                     if(typeof data == "string") {
//                         var datas = JSON.parse(data);
//                         resolve(datas);
//                     }else{
//                         reject("JSON err");
//                     }
//
//
//                 },function (err) {
//                     console.log(err);
//                     reject(err);
//                 })
//             })
//         })
//     }else{
//         return new Promise(function (resolve,reject) {
//             connectObject[method](params).then(function (data) {
//                 // console.log(data);
//                 //json 转换
//                 if(typeof data == "string"){
//                     var datas = JSON.parse(data);
//                     resolve(datas);
//                 }else{
//                     reject("JSON Err");
//                 }
//             },function (err) {
//                 console.log(err);
//                 reject(err);
//             })
//         })
//     }
// }


//公共参数转json
function changeJson(params) {
    if (typeof params == "object") {
        return JSON.stringify(params);
    } else {
        return params || ""
    }
}

var methods = [
	"LicenseCheck",
	"Login",
	"AddUser",
	"UpdateUser",
	"DeleteUser",
	"QueryUserList",
	"AddRole",
	"UpdateRole",
	"DeleteRole",
	"QueryRoleList",
	"AddOrganization",
	"UpdateOrganization",
	"EnableOrganization",
	"DeleteOrganization",
	"QueryOrganizationList",
	"UpdateOrganAuthorization",
	"QueryOrganAuthorizationList",
	"AddSite",
	"UpdateSite",
	"EnableSite",
	"DeleteSite",
	"QuerySiteList",
	"AddPermissionGroup",
	"RemovePermissionGroup",
	"UpdatePermissionGroup",
	"QueryPermissionGroupList",
	"AddLibrary",
	"EnableLibrary",
	"DeleteLibrary",
	"BatchDeleteLibrary",
	"QueryLibraryInfo",
	"QueryLibraryList",
	"AddCredentialType",
	"UpdateCredentialType",
	"DeleteCredentialType",
	"QueryCredentialType",
	"AddPeople",
	"UpdatePeople",
	"BatchUpdatePeople",
	"DeletePeople",
	"BatchDeletePeople",
	"QueryPeopleInfo",
	"QueryPeopleList",
	"AddPicture",
	"DeletePicture",
	"SetDefaultPicture",
	"BatchSetWhiteList",
	"BatchSetWhiteListByLib",
	"QueryPersonBasicInfo",
	"AddGroup",
	"RemoveGroup",
	"AppendGroupPerson",
	"ChangeGroupPerson",
	"RemoveGroupPerson",
	"QueryGroupPerson",
	"QueryGroupList",
	"DeleteStranger",
	"BatchDeleteStranger",
	"QueryStrangerList",
	"RegisterVisitor",
	"QueryVisitorList",
	"AddArea",
	"UpdateArea",
	"DeleteArea",
	"QueryAreaList",
	"QueryAreaTree",
	"AddLabel",
	"UpdateLabel",
	"DeleteLabel",
	"QueryLabelList",
	"QueryLabelTree",
	"AddDepartment",
	"UpdateDepartment",
	"DeleteDepartment",
	"QueryDepartmentList",
	"AddWelcomeWord",
	"EnableWelcomeWord",
	"DeleteWelcomeWord",
	"QueryWelcomeWord",
	"QueryEnableWelcomeWord",
	"AddGroupMessage",
	"UpdateGroupMessage",
	"DeleteGroupMessage",
	"QueryGroupMessageList",
	"AddPersonalMessage",
	"UpdatePersonalMessage",
	"DeletePersonalMessage",
	"QueryPersonalMessageList",
	"AddCamera",
	"UpdateCamera",
	"SetInfraredLightParam",
	"EnableGlobalForCamera",
	"DeleteCamera",
	"QueryCameraList",
	"QueryHeatmapCameraList",
	"QueryCameraRtsp",
	"AddCaptureBox",
	"UpdateCaptureBox",
	"DeleteCaptureBox",
	"GetCaptureBoxInfo",
	"QueryCaptureBoxList",
	"AddMonitorTask",
	"UpdateMonitorTask",
	"DeleteMonitorTask",
	"QueryMonitorTaskInfo",
	"QueryMonitorTaskList",
	"AddGeneralAccess",
	"UpdateGeneralAccess",
	"EnableGeneralAccess",
	"DeleteGeneralAccess",
	"QueryGeneralAccessList",
	"AddSmartAccess",
	"UpdateSmartAccess",
	"EnableSmartAccess",
	"DeleteSmartAccess",
	"QuerySmartAccess",
	"UpdateItmRecordState",
	"DeleteItmAccessRecord",
	"BatchDeleteItmAccessRecord",
	"QueryItmAccessRecord",
	"ActivateSmartAccess",
	"GetSmartAccessConfig",
	"SetSmartAccessConfig",
	"AddSmartAccessAuth",
	"UpdateSmartAccessAuth",
	"EnableSmartAccessAuth",
	"DeleteSmartAccessAuth",
	"QuerySmartAccessAuth",
	"AddSmartAccessAuthPerson",
	"DeleteSmartAccessAuthPerson",
	"BatchDeleteSmartAccessAuthPerson",
	"QuerySmartAccessAuthPerson",
	"GetSystemConfig",
	"SetSystemConfig",
	"SetVisitorConfig",
	"GetVisitorConfig",
	"SetCameraMap",
	"GetCameraMap",
	"ComparePicture1v1",
	"RetrievePicture",
	"RetrieveCaptureLibrary",
	"StartMonitorTask",
	"StopMonitorTask",
	"StartSignIn",
	"StartSignOut",
	"StartFileCaptureTask",
	"PlayHistoryVideo",
	"QueryStartedTaskList",
	"QueryStartedRtmpList",
	"QueryFileTaskList",
	"QueryPersonListByTask",
	"QueryCaptureResult",
	"GetRealtimeCaptureInfo",
	"GetFaceDeviceRealtimeCaptureInfo",
	"QueryRealtimeResult",
	"QueryFileCaptureResult",
	"QueryCaptureAlarmList",
	"QueryDynamicAlarmList",
	"QueryCapturePhotoList",
	"QueryRetrieveHistoryList",
	"QueryRetrieveCaptureLibraryList",
	"QueryHistory",
	"DeleteHistory",
	"BatchDeleteHistory",
	"QueryStrangerHistory",
	"DeleteStrangerHistory",
	"BatchDeleteStrangerHistory",
	"QueryLatestSmartAccessRecord",
	"QueryLatestCaptureRecord",
	"QuerySmartAccessRecord",
	"DeleteSmartAccessRecord",
	"BatchDeleteSmartAccessRecord",
	"QuerySmartIcCardRecord",
	"DeleteSmartAccessIcCardRecord",
	"BatchDeleteSmartAccessIcCardRecord",
	"QuerySmartIdCardRecord",
	"DeleteSmartAccessIdCardRecord",
	"BatchDeleteSmartAccessIdCardRecord",
	"QueryGeneralAccessRecord",
	"DeleteGeneralAccessRecord",
	"BatchDeleteGeneralAccessRecord",
	"QuerySigninRecord",
	"GetLatestGroupAlarmInfo",
	"QueryGroupAlarmInfo",
	"QueryGroupAlarmList",
	"CommitGroupAlarmComment",
	"QueryRollcallCurrent",
	"QueryRollcallRecord",
	"QueryRollcallDetails",
	"QueryWorkplaceStartedTask",
	"QueryWorkplaceCurrent",
	"QueryWorkplaceRecord",
	"QueryWorkplaceDetails",
	"GetLatestPatrolAlarm",
	"QueryPatrolAlarmList",
	"QueryPatrolList",
	"GetLibPicServer",
	"SearchCamera",
	"GetSystemInfo",
	"GetStatisticsReport",
	"QuerySystemLogList",
	"QueryPersonCount",
	"QueryTodayGroupAlarmCount",
	"QueryStatistics",
	"AddIcCard",
	"DeleteIcCard",
	"QueryIcCard",
	"QueryPersonWithIcCardInfo",
	"QueryPersonWithIcCardList",
	"QuerySummaryInfo",
	"GetTodayAccessRecord",
	"GetLast24hAccessRecord",
	"GetLast7daysAccessRecord",
	"GetRealtimeAccessMessage",
	"AddSimpleLeave",
	"ResumptionFromSimpleLeave",
	"DeleteSimpleLeave",
	"QuerySimpleLeaveList",
	"QueryPrisonRollcallRecord",
	"DeletePrisonRollcallRecord",
	"BatchDeletePrisonRollcallRecord",
	"QueryPrisonRollcallDetails",
	"QueryPrisonSigninRecordList",
	"QueryPrisonSigninDetailsList",
	"DeletePrisonSigninRecord",
	"BatchDeletePrisonSigninRecord",
	"AddPrisonSigninInfo",
	"DeletePrisonSigninInfo",
	"BatchDeletePrisonSigninInfo",
	"UpdatePrisonSigninInfo",
	"BatchUpdatePrisonSigninInfo",
	"QueryInOutList",
	"DeleteInOutRecord",
	"BatchDeleteInOutRecord",
	"IgnoreInOutRecord",
	"BatchIgnoreInOutRecord",
	"GetRealtimeAlarm",
	"GetRealtimePersonCount",
	"GetTodayCaptureInfo",
	"GetTodayInOutInfo",
	"GetLatestPrisonRollcallInfo",
	"GetLatestPrisonSigninInfo",
	"CheckVideoRefreshStatus",
	"QueryLabelStatistics",
	"QueryLabelStatisticsDetails",
	"GetCameraScene",
	"AddPointMapping",
	"UpdatePointMapping",
	"DeletePointMapping",
	"QueryHeatmapAreaList",
	"QueryCameraPointMappingInfo",
	"QueryPointMappingInfoByArea",
	"DeleteCameraPointMapping",
	"QueryHeatmapData",
	"QueryCustomersConsititution",
	"QueryCustomersLinkRelative",
	"QueryCapiteStayTime",
	"QueryAverageCustomerCountByTime",
	"QueryCustomersArrivedInfo",
	"QueryCommercialAblility",
	"QueryStoreCustomersRank",
	"QueryMarketMainPageInfos",
	"QueryTodayCustomerCount",
	"QueryStoreRelationship",
	"QueryMainPageStoreIncome",
	"AddStoreIncome",
	"UpdateStoreIncome",
	"QueryStoreIncomeList",
	"AddRetrieveMap",
	"DeleteRetrieveMap",
	"UpdateRetrieveMap",
	"QueryRetrieveMapInfo",
	"QueryRetrieveMapList",
	"AddVisitorDevice",
	"DeleteVisitorDevice",
	"UpdateVisitorDevice",
	"QueryVisitorDeviceList",
	"SetHolidays",
	"GetHolidays",
	"AddLeaveInfo",
	"UpdateLeaveInfo",
	"DeleteLeaveInfo",
	"QueryLeaveList",
	"AddReSigninInfo",
	"UpdateReSigninInfo",
	"DeleteReSigninInfo",
	"QueryReSigninList",
	"AddAttendanceRule",
	"UpdateAttendanceRule",
	"DeleteAttendanceRule",
	"GetSimpleAttendanceRuleList",
	"GetSimpleSubAttendanceRuleList",
	"QueryAttendanceRuleList",
	"QueryAttendanceRuleBindList",
	"QueryAttendanceRuleInfo",
	"BatchSetAttendanceRule",
	"SetPeopleAttendanceRule",
	"QueryCurMonthAttendance",
	"QueryAttendanceToday",
	"QueryAttendanceList",
	"QueryTodayAttendanceList",
	"QueryAttendanceMainPage"
]
var test = {

    //断线重连
    createProx: createProx,

}
methods.forEach(function (method) {
    test[method] = function (param) {
        return common(method,param);
    }
})
module.exports = test;
