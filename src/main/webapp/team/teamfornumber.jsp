<%--
  Created by IntelliJ IDEA.
  User: WU
  Date: 2017/9/21
  Time: 8:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <title>组员团队</title>
    <link rel="stylesheet" href="../resources/css/team.css.css" />
    <link rel="stylesheet" type="text/css" href="../resources/js/jquery-easyui-1.4.5/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../resources/js/jquery-easyui-1.4.5/themes/icon.css">
    <link rel="stylesheet" href="../resources/css/team.inserthtml.com.radios.min.css" />
    <script type="text/javascript" src="../resources/js/jquery-easyui-1.4.5/jquery.min.js"></script>
    <script type="text/javascript" src="../resources/js/jquery-easyui-1.4.5/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../resources/js/jquery-easyui-1.4.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../resources/js/newjs.js"></script>

    <script type="text/javascript">
        $(document).ready(function(){
            $(".container").hover(function(){
                $(".container").css("color","white")
            })

            $("#team_newgroup").hide()
            $("#team_invite").hide()

            $("#inteam_newgroup").click(function(){

                $("#team_invite").hide()
                $("#team_newgroup").show()
            })

            $("#inteam_invite").click(function(){

                $("#team_newgroup").hide()
                $("#team_invite").show()
            })
        })
    </script>
    <%--遍历团队人员--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type:"Post",
                url:"/userandteam/QueryUserByTid",
                dataType:"json",
                data:{
                    tId:${param.tId},
                },
                success:function (result) {
                    $.each(result.data,function (n,v) {
                        $("#topic").html(v.tName);
                        if(v.type==1){
                            $("#query1").append("<a ><a  href='../user/userfromteam.jsp?uId="+v.uId+"'>"+v.uName+"</a>" +
                                "超级管理员</a>" +
                                "<a style='margin-left:730px;'>"+v.uEmail+"</a><br>")
                        }else{
                            $("#query1").append("<a><button class='team_btn' style='' href='../user/userfromteam.jsp?uId="+v.uId+"'>"+v.uName+"</button>" +
                                "</a>" +
                                "<a style='margin-left:800px;'>"+v.uEmail+"</a><br>")
                        }

                    })
                },
                error:function () {
                    alert("遍历组员失败")
                }
            })

        })
    </script>
    <%--遍历分组--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type:"Post",
                url:"/group/QueryGroupByTid",
                dataType:"json",
                data:{
                    tId:${param.tId},
                },
                success:function (result) {
                    if(result.errcode==1) {
                        $.each(result.data, function (n, v) {
                            $("#inteam_group").append("" +
                                "<a class='team_btn' onclick='selectGroup(this)' id='" + v.gId + "'>" + v.gName + "</a>")
                        })
                    }
                },
                error:function () {
                    alert("分组名遍历失败");
                }
            })
        })
    </script>

    <%--根据gid进行查询组员--%>
    <script type="text/javascript">
        function selectGroup(obj) {
            var gId=obj.id;
            $.ajax({
                type:"Post",
                url:"/group/SelectUserByGid",
                dataType:"json",
                data:{
                    gId:gId,
                },
                success:function (result) {
                    $("#query1").html("");
                    $.each(result.data,function (n,v) {
                        if(v.type==1){
                            $("#query1").append("<a><a href='../user/userfromteam.jsp?uId="+v.uId+"'>"+v.uName+"</a>" +
                                "超级管理员</a>" +
                                "<a style='margin-left:730px;'>"+v.uEmail+"</a><br>")
                        }else{
                            $("#query1").append("<a><a href='../user/userfromteam.jsp?uId="+v.uId+"'>"+v.uName+"</a>" +
                                "</a>" +
                                "<a style='margin-left:800px;'>"+v.uEmail+"</a><br>")
                        }

                    })
                },
                error:function () {
                    alert("小组成员遍历错误")
                }

            })
        }
    </script>

    <%--按钮所有成员的操作--%>
    <script type="text/javascript">
        function selectteam() {
            $.ajax({
                type:"Post",
                url:"/userandteam/QueryUserByTid",
                dataType:"json",
                data:{
                    tId:${param.tId},
                },
                success:function (result) {
                    $("#query1").html("");
                    $.each(result.data,function (n,v) {
                        if(v.type==1){
                            $("#query1").append("<a><a href='../user/userfromteam.jsp?uId="+v.uId+"'>"+v.uName+"</a>" +
                                "超级管理员</a>" +
                                "<a style='margin-left:730px;'>"+v.uEmail+"</a><br>")
                        }else{
                            $("#query1").append("<a><button class='team_btn' href='../user/userfromteam.jsp?uId="+v.uId+"'>"+v.uName+"</button>" +
                                "</a>" +
                                "<a style='margin-left:800px;'>"+v.uEmail+"</a><br>")
                        }

                    })
                },
                error:function () {
                    alert("遍历组员失败")
                }
            })
        }
    </script>
</head>

<body style="background-color: #212121;">
<div style="margin-left: 80px;">
    <div class="container">
        <a style="font-size: 35px;">卡布奇诺</a>
    </div>
    <br>
    <a id="inteam_group">
        <button class="team_btn" id="inteam_team" onclick="selectteam()">所有成员</button>
    </a>

    <div class="menu-sep" style="margin-left: 0px;margin-top: 20px;margin-bottom: 80px;width: 1000px;"></div>
</div>

<%--遍历组员--%>
<div id="query"  >
    <div id="query1" style="color: slateblue;font-weight: bold; margin-left: 80px;margin-top: -60px;margin-bottom: 10px;"></div>
</div>
<%--遍历分组成员--%>
<div id="selectgroup">
    <div id="selectgroup1"></div>
</div>
<!--新建分组-->
<div id="team_newgroup" style="margin-left: 80px;margin-top: -60px;">
    <div class="container">
        <a style="font-size: 25px;">新建成员分组</a></div>
    <br>
    <textarea placeholder="成员分组名称" style="margin-top: 10px; color:slateblue;background-color: #212121; margin-left: 10px;border-radius: calc(5px); resize: none;height: 25px;width: 300px;"></textarea>
    <br>
    <br>
    <div class="container">
        <a style="margin-left: 0px;font-size: 25px;color: white;">选择成员</a>
    </div>
    <br><br>&nbsp;&nbsp;
    <input type="checkbox" id="checkbox-2-1" />
    <label for="checkbox-2-1" style="height: 10px;width: 50px;text-align: left;font-weight: bold;font-size: 18px;">BF</label>
    <input type="checkbox" id="checkbox-2-2" />
    <label for="checkbox-2-2" style="height: 10px;width: 50px;text-align: left;font-weight: bold;font-size: 18px;">YG</label>
    <input type="checkbox" id="checkbox-2-3" />
    <label for="checkbox-2-3" style="height: 10px;width: 50px;text-align: left;font-weight: bold;font-size: 18px;">JX</label>
    <div class="menu-sep" style="margin-left: 10px;margin-top: 20px;margin-bottom: 20px;width: 1000px;"></div>
    <button class="team_btn"  style="margin-left: 10px;width: 170px;border-color: #212121;">邀请新成员加入分组</button><br>
    <button class="team_btn"  style="margin-left: 40px;">保存设置</button>

</div>

<div id="team_invite">
    <div id="text" style="color: slateblue;font-weight: bold; margin-left: 80px;margin-top: -60px;margin-bottom: 10px;">
        > 添加新成员<span id="cursor"> █</span>
    </div>
    <div class="container" style="margin-left: 80px;">
        <a style="font-size: 20px;">通过邮件邀请，无需审核</a></div><br>
    <a style="font-size: 15px;color: grey;margin-left: 90px;">你可以预先设置好访问权限，发送邀请给指定的邮箱，对方只需进行个人账户设置即可直接加入团队，无需等待审批。</a>
    <br>
    <button class="team_btn"  style="margin-left: 90px;margin-top: 20px;width: 180px;">通过邮件邀请新成员</button>
    <br><br>
    <div class="container" style="margin-left: 80px;">
        <a style="font-size: 20px;">通过微信扫码，邀请好友</a></div><br>
    <a style="font-size: 15px;color: grey;margin-left: 90px;">用微信扫描二维码获取邀请函，转发给微信好友/群，即可邀请他们加入你的团队。</a>
</div>

</div>
</body>

</html>