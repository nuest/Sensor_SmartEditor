<%--

    See the NOTICE file distributed with
    this work for additional information regarding copyright ownership.
    con terra GmbH licenses this file to You under the Apache License, Version 2.0
    (the "License"); you may not use this file except in compliance with
    the License. You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<tiles:insertAttribute name="editor.header" />

<link type="text/css" href="styles/jquery.ui.selectmenu.css"
	rel="stylesheet" />
<script type="text/javascript" language="javascript"
	src="js/jquery.ui.selectmenu.js"></script>

<style type="text/css">
label {
	padding: 5px;
	width: 20em;
}
</style>

<style type="text/css">
/* demo styles */
select, .ui-select-menu {
	float: left;
	margin-right: 20px;
}

.wrap ul.ui-selectmenu-menu-popup li a {
	font-weight: bold;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		$('#selectStates,#selectOperationsSOS').selectmenu({
			style : 'popup',
			width : 300
		});
		$('#serviceURLSOS').addClass("ui-corner-all");
		$('#serviceURLSOS').addClass("ui-selectmenu");
		$('#serviceURLSOS').css("width","300");	
		$("#publishFormButton").click(function() {
			$("#publishForm").submit();
		});
	});
</script>
<div class="container">
	<fieldset>
		<legend>
			<fmt:message key="publish.states.title" />
		</legend>
		<p style="margin-bottom: 20px">
			<fmt:message key="publish.states.message" />
		</p>
		<form:form commandName="publish" action="publish.do" id="publishForm">
			<div id="selectStatesDiv" style="margin-top: 25px">
				<label for="selectStates" style="width: 30em; float: left;"><fmt:message
						key="publish.states.title.sub" />:</label> <select name="stateId"
					id="selectStates">
					<c:forEach items="${stateModel.transitionStates}" var="state">
						<option value="${state.stateId}"
							<c:if test="${stateModel.currentStateId == state.stateId}">
                        selected="selected"</c:if>>${state.stateName}</option>
					</c:forEach>
				</select>
			</div>
			<div id="procedureIdSOSDiv" style="margin-top: 25px">
				<label for="procedureIdSOS" style="width: 30em; float: left;"><fmt:message
						key="publish.procedureIdSOS.title.sub" />:</label>
				<c:out value="${stateModel.procedureIdSOS}" />
				<%-- <form:hidden path="procedureIdSOS" id="procedureIdSOS" value="${stateModel.procedureIdSOS}"/> --%>
			</div>

			<div id="selectOperationsSOSDiv" style="margin-top: 25px">
				<label for="selectOperationsSOS" style="width: 30em; float: left;"><fmt:message
						key="publish.operationsSOS.title.sub" />:</label> <select
					name="operationSOS" id="selectOperationsSOS">
					<c:forEach items="${stateModel.operationsSOS}" var="operationSOS">
						<option value="${operationSOS.stateId}"
							<c:if test="${stateModel.currentOperationSOSId == operationSOS.stateId}">
                        selected="selected"</c:if>>${operationSOS.stateName}</option>
					</c:forEach>
				</select>
			</div>
			<div id="serviceURLSOSDiv" style="margin-top: 25px">
				<label for="serviceURLSOS" style="width: 30em; float: left;"><fmt:message
						key="publish.serviceURLSOS.title.sub" />:</label> <input
					name="serviceUrlSOS" id="serviceURLSOS"
					value="${stateModel.serviceURLSOS}" />
			</div>
			<br>
			<div id="stateButtons" style="margin-top: 25px">
				<a class="button" href="#" id="publishFormButton"> <fmt:message
						key="publish.submit" />
				</a>
				<c:url value="/edit.do" var="continueEditing" />
				<a class="button" href="<c:out value="${continueEditing}"/>"> <fmt:message
						key="publish.back" />
				</a>
			</div>
		</form:form>
	</fieldset>
</div>
<tiles:insertAttribute name="editor.footer" />