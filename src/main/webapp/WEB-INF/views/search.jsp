<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="kor">
<head>
<meta charset="UTF-8">
<title>Employee Search Page</title>
<link type="text/css" rel="stylesheet" href="resources/bootstrap/css/bootstrap.css">
<script type="text/javascript" src="resources/jquery/jquery-3.2.0.min.js"></script>
<script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
</head>
<script type="text/javascript">
$(function() {
	// Clear info from search bar
	$("button:has('.glyphicon')").removeClass("btn-info").addClass("btn-default");
	var sort = $("#search-form :input[name='sort']").val();
	var orderby = $("#search-form :input[name='orderby']").val();
	var $orderedButton = $("#"+sort+"-"+orderby);
	$orderedButton.removeClass('btn-default').addClass("btn-info");
	
	function setSearchFormField(pageNo) {
		// if   pageNo = 0
		//      false  : true
		//		output : 1
		// if   pageNo = 2
		//      true   : true
		//		output : 2
		pageNo = pageNo || 1;
		$("#search-form :input[name='pageNo']").val(pageNo);
		
		var rows = $("select[name='rows']").val();
		$("#search-form :input[name='display']").val(rows);
		
		var opt = $("#origin-search-form select[name='opt']").val();
		$("#search-form :input[name='opt']").val(opt);
		
		var keyword = $("#search-form :input[name='keyword']").val();
		$("#search-form :input[name='keyword']").val(keyword);
		
		var arr = $("button:has(.glyphicon)").filter(".btn-info").attr("id").split("-");
		$("#search-form :input[name='sort']").val(arr[0]);
		$("#search-form :input[name='orderby']").val(arr[1]);
	}
	
	// Set display in hidden form
	$("select[name='rows']").change(function() {
		setSearchFormField();
		$("#search-form").submit();

	})
	
	// Set current pageno to hidden form
	$("ul.pagination li > a").click(function(event) {
		event.preventDefault();
		var pageNo = $(this).attr("id").replace("navi-", "");
		setSearchFormField(pageNo);
 		$(":input[name='pageNo']").val(pageNo);
		
		$("#search-form").submit();
	});
	
	$("button:has('.glyphicon')").click(function() {
		$("button:has('.glyphicon')").removeClass("btn-info").addClass("btn-default");
		$(this).addClass("btn-info").removeClass("btn-default");
		
		var arr = $("button:has(.glyphicon)").filter(".btn-info").attr("id").split("-");
		$("#search-form :input[name='sort']").val(arr[0]);
		$("#search-form :input[name='orderby']").val(arr[1]);

		$("#search-form").submit();
	});
});
</script>
<body>
<div class="container">
	<h1>사원 조회</h1>
	<div class="row pull-right">
		<select name="rows" class="form-control" style="width:200px;">
			<option value="5" ${search.display eq 5 ? 'selected=selected' : '' }>5</option>
			<option value="10" ${search.display eq 10 ? 'selected=selected' : '' }>10</option>
			<option value="20" ${search.display eq 20 ? 'selected=selected' : '' }>20</option>
			<option value="50" ${search.display eq 50 ? 'selected=selected' : '' }>50</option>
		</select>
		<br/>
	</div>
	<c:if test="${not search.keyword eq ''}">
	<div class="text-center">
		<h4><span class="glyphicon glyphicon-search"></span><strong id="category"></strong>Result of ' <strong>${search.keyword }</strong> '.</h4>
	</div>
	</c:if>
	<div class="row">
		<table class="table table-striped">
				<colgroup>
					<col width="15%">
					<col width="15%">
					<col width="10%">
					<col width="10%">
					<col width="15%">
					<col width="15%">
					<col width="5%">
					<col width="15%">
				</colgroup>
			<thead>
				<tr>
					<th>
						Employee ID
						<button class="btn btn-default btn-xs" id="employee_id-asc">
							<span class="glyphicon glyphicon-sort-by-order"></span>
						</button>
						<button class="btn btn-default btn-xs" id="employee_id-desc">
							<span class="glyphicon glyphicon-sort-by-order-alt"></span>
						</button>
					</th>
					<th>
						First Name
						<button class="btn btn-default btn-xs" id="first_name-asc">
							<span class="glyphicon glyphicon-sort-by-alphabet"></span>
						</button>
						<button class="btn btn-default btn-xs" id="first_name-desc">
							<span class="glyphicon glyphicon-sort-by-alphabet-alt"></span>
						</button>
					</th>
					<th>Department ID</th>
					<th>Job ID</th>
					<th>Phone #</th>
					<th>
						Salary
						<button class="btn btn-default btn-xs" id="salary-asc">
							<span class="glyphicon glyphicon-sort-by-order"></span>
						</button>
						<button class="btn btn-default btn-xs" id="salary-desc">
							<span class="glyphicon glyphicon-sort-by-order-alt"></span>
						</button>
					</th>
					<th>Commission(%)</th>
					<th>Hired Date</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="emp" items="${employees }">
				<tr>
					<td>${emp.id }</td>
					<td>${emp.name }</td>
					<td>${emp.dept }</td>
					<td>${emp.job }</td>
					<td>${emp.phone }</td>
					<td>${emp.salary }</td>
					<td>${emp.comm }</td>
					<td><fmt:formatDate value="${emp.hiredate }"/></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="row text-center">
		<c:set var="link" value="search.do"/>
		<%@ include file="common/navi.jsp" %>
	</div>
	<div class="row text-center">
		<form id="origin-search-form" class="form-inline">
			<div class="form-group">
				<label class="sr-only">Search Options</label>
				<select name="opt" class="form-control">
					<option value="dept" ${search.opt eq 'dept' ? 'selected=selected' : '' }>Department ID</option>
					<option value="job" ${search.opt eq 'job' ? 'selected=selected' : '' }>Job ID</option>
					<option value="name" ${search.opt eq 'name' ? 'selected=selected' : '' }>First Name</option>
					<option value="salary" ${search.opt eq 'salary' ? 'selected=selected' : '' }>Salary</option>
				</select>
			</div>
			<div class="form-group">
				<label class="sr-only">Keyword</label>
				<input type="text" name="keyword" class="form-control" value="${search.keyword }"/>
			</div>
			<button type="submit" class="btn btn-default">Search</button>
		</form>
	</div>
	<form id="search-form" action="search.do">
		<input type="hidden" name="pageNo" value="1"/>
		<input type="hidden" name="opt" value=""/>
		<input type="hidden" name="keyword" value="${search.keyword }"/>
		<input type="hidden" name="display" value="5"/>
		<input type="hidden" name="sort" value="${search.sort }"/>
		<input type="hidden" name="orderby" value="${search.orderby }"/>
	</form>
</div>
</body>
</html>