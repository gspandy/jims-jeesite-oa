<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')}</title>
	<meta name="decorator" content="blank"/>
	<style type="text/css">
        body {
            background-color: #EDEFF0;
        }
        #menu {
            width: 100%;
        }
        #menu,#userLogo img{
            height: 90px;
        }
        #userLogo {
            float: left;
        }
        #userLogo img{
            width: 200px;
        }
        #menu .menuImg {
            width: 50px;
            height: 50px;
        }
        #menu ul,#left ul {
            list-style:none;
            margin: 0;
        }
        #menu li {
            float:left;
            width:70px;
            padding: 10px 10px;
            cursor: pointer;
        }
        #menu li a,#left li a{
            font-family:Helvetica, Georgia, Arial, sans-serif, 黑体;
            text-decoration:none;
            color: #555555;
        }
		#main {padding:0;margin:0;}
		#header {margin:0;position:static;} #header li {font-size:14px;_font-size:12px;}
		#header .brand {font-family:Helvetica, Georgia, Arial, sans-serif, 黑体;font-size:26px;padding-left:33px;}
		#userControl>li>a{/*color:#fff;*/text-shadow:none;}
        #userControl>li>a:hover, #user #userControl>li.open>a{background:transparent;}
        #left{
            overflow-x:hidden;
            overflow-y:auto;
            width: 200px;
            border-right: 1px solid #C2C3C4;
            background-color: #FFF;
        }
        #left ul {
            margin-top: 20px;
        }
        #left li {
            height: 27px;
            /*border: 1px solid red;*/
            padding-left: 30px;
            padding-top: 5px;
            font-family:Helvetica, Georgia, Arial, sans-serif, 黑体;
            font-size: 14px;
            cursor: pointer;
        }
        .hover {
            background-color: #CBDBF7;
        }
        .active {
            background-color: #30A5FF;
        }
        iframe {
            padding-top: 3px;
        }
        .menu {
            text-align: center;
        }
        .test-icon{
            background:url("/static/images/icons/1.png") no-repeat;
            width:50px;
            height: 50px;
        }
    </style>
</head>
<body>
	<div id="main">
		<div id="header" class="navbar navbar-fixed-top">
			<div class="navbar-inner">
				<div class="brand"><span id="productName">${fns:getConfig('productName')}</span></div>
				<ul id="userControl" class="nav pull-right">
					<li id="mianPage"><a href="${ctx}/sys/main/form" target="mainFrame" title="首页"><i class="icon-home"></i></a></li>
					<li id="themeSwitch" class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="主题切换"><i class="icon-th-large"></i></a>
						<ul class="dropdown-menu">
							<c:forEach items="${fns:getDictList('theme')}" var="dict"><li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href">${dict.label}</a></li></c:forEach>
						</ul>
						<!--[if lte IE 6]><script type="text/javascript">$('#themeSwitch').hide();</script><![endif]-->
					</li>
					<li id="userInfo" class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="个人信息">您好, ${fns:getUser().name}&nbsp;<span id="notifyNum" class="label label-info hide"></span></a>
						<ul class="dropdown-menu">
							<li><a href="${ctx}/sys/user/info" target="mainFrame"><i class="icon-user"></i>&nbsp; 个人信息</a></li>
							<li><a href="${ctx}/sys/user/modifyPwd" target="mainFrame"><i class="icon-lock"></i>&nbsp;  修改密码</a></li>
							<li><a href="${ctx}/oa/oaNotify/self" target="mainFrame"><i class="icon-bell"></i>&nbsp;  我的通知 <span id="notifyNum2" class="label label-info hide"></span></a></li>
						</ul>
					</li>
					<li><a href="${ctx}/logout" title="退出登录">退出</a></li>
					<li>&nbsp;</li>
				</ul>
			</div>
	    </div>

        <div id="menu" style="background-color: #fff">
            <div id="userLogo">
                <img src="/static/images/icons/4.png">
            </div>
            <div>
                <ul>
                    <c:set var="firstMenu" value="true"/>
                    <c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
                        <c:if test="${menu.parent.id eq '1'&&menu.isShow eq '1'}">
                            <li>
                                <a class="menu" href="javascript:" data-href="${ctx}/sys/menu/tree?parentId=${menu.id}" data-id="${menu.id}">
                                    <span class="test-icon">&nbsp;</span><br>
                                    <span>${menu.name}</span></a>
                            </li>
                            <c:if test="${firstMenu}">
                                <c:set var="firstMenuId" value="${menu.id}"/>
                            </c:if>
                            <c:set var="firstMenu" value="false"/>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>

        </div>

        <div>
            <div id="left">
            </div>
            <div id="right">
                <iframe id="mainFrame" name="mainFrame" src="" style="" scrolling="yes" frameborder="yes" width="100%"></iframe>
            </div>
        </div>
	</div>
	<script type="text/javascript">
        var menuObj = $("#menu");
        var headerObj = $("#header");
        var frameObj = $("#left, #right, #right iframe");
        $(window).resize(function () {
            wSize()
        });
        wSize()
        function wSize(){
            var strs = getWindowSize().toString().split(",");
            $('#right').width(strs[1] - $('#left').width() - 5)
            $('html').css({overflow: 'hidden'})
            frameObj.height(strs[0] - headerObj.height() - menuObj.height() - 5);
        }
        function getWindowSize() {
            return ["Height", "Width"].map(function (a) {
                return window["inner" + a] || document.compatMode === "CSS1Compat" && document.documentElement["client" + a] || document.body["client" + a]
            })
        }


        $("#menu a.menu").click(function(){
            $.get($(this).attr("data-href"), function(data){
                if (data.indexOf("id=\"loginForm\"") != -1){
                    alert('未登录或登录超时。请重新登录，谢谢！');
                    top.location = "${ctx}";
                    return false;
                }
                $("#left").empty();
                $("#left").append(data);
                $('#left .menu2').css({fontSize: '12px',paddingLeft:'48px'})

                $('#left a').click(function(e){
                    var thisLi = $(this).parent('li')
                    if(thisLi.hasClass('menu1') && thisLi.next().hasClass('parent-' + thisLi.attr('data-id'))){
                        thisLi.next().click()
                        return false
                    }
                    $('#left li').removeClass("active")
                    $(this).parent('li').addClass("active")
                    $('#left a').css({color : '#555'})
                    $(this).css({color : '#fff'})
                    e.stopPropagation()
                })
                $('#left li').mouseover(function(){
                    $('#left li').removeClass("hover")
                    $(this).addClass("hover")
                })
                $('#left li').click(function(e){
                    $('#left li').removeClass("active")
                    $(this).addClass("active")
                    $('a',this)[0].click()
                })
                $('#left li:eq(0)').click()
            });
        });
	</script>

</body>
</html>