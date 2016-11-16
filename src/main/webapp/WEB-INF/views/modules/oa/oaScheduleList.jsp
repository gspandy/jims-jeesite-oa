<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>日程管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/oa/oaSchedule/">日程列表</a></li>
		<shiro:hasPermission name="oa:oaSchedule:edit"><li><a href="${ctx}/oa/oaSchedule/form">日程添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="oaSchedule" action="${ctx}/oa/oaSchedule/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <ul class="ul-form">
            <li><label>日期：</label>
                <input name="scheduleDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
                       value="<fmt:formatDate value="${oaSchedule.scheduleDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
            </li>
            <li><label>完成状态：</label>
                <form:select path="flag" class="input-medium">
                    <form:option value="" label=""/>    <%--htmlEscape="false"--%>
                    <form:options items="${fns:getDictList('oa_schedule_status')}" itemLabel="label" itemValue="value" htmlEscape="true" />
                </form:select>
            </li>
            <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
            <li class="clearfix"></li>
        </ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
        <tr>
            <th>标题</th>
            <th>重要等级</th>
            <th>缓急程度</th>
            <th>完成状态</th>
            <th>更新时间</th>
            <shiro:hasPermission name="oa:oaSchedule:edit"><th>操作</th></shiro:hasPermission>
           <%-- <c:if test="${!oaNotify.self}"><shiro:hasPermission name="oa:oaNotify:edit"><th>操作</th></shiro:hasPermission></c:if>--%>
        </tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="oaSchedule">
			<tr>
                <td style="width:200px " align="center">
                    <a href="${ctx}/oa/oaSchedule/form?id=${oaSchedule.id}">${fns:abbr(oaSchedule.content,50)}</a>
                </td>
                <td align="center">
                        ${fns:getDictLabel(oaSchedule.importantLevel, 'oa_schedule', '')}
                </td>
                <td align="center">
                        ${fns:getDictLabel(oaSchedule.emergencyLevel, 'oa_schedule_import', '')}
                </td>
                <td align="center">
                        ${fns:getDictLabel(oaSchedule.flag, 'oa_schedule_status', '')}
                </td>
                <td align="center">
                    <fmt:formatDate value="${oaSchedule.scheduleDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
				<shiro:hasPermission name="oa:oaSchedule:edit"><td>
    				<a href="${ctx}/oa/oaSchedule/form?id=${oaSchedule.id}">修改</a>
					<a href="${ctx}/oa/oaSchedule/delete?id=${oaSchedule.id}" onclick="return confirmx('确认要删除该日程安排吗？', this.href)">删除</a>
                    <a href="${ctx}/oa/oaSchedule/complete?id=${oaSchedule.id}">完成</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>