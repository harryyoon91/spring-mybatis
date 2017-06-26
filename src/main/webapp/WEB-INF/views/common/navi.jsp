<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<ul class="pagination">
<c:if test="${pagination.currentBlock gt 1 }">
	<li>
		<a href="${link }?pageNo=${pagination.prevBlock }" id="navi-${pagination.prevBlock }" aria-label="Previous">
			<span aria-hidden="true">&laquo;</span>
		</a>
	</li>
</c:if>
	<c:forEach var="pno" begin="${pagination.beginPage }" end="${pagination.endPage }">
		<c:choose>
			<c:when test="${pno eq pagination.currentPage }">
				<li class="active">
					<a href="${link }?pageNo=${pno }" id="navi-${pno }">${pno }</a>
				</li>
			</c:when>
			<c:otherwise>
				<li>
					<a href="${link }?pageNo=${pno }" id="navi-${pno }">${pno }</a>
				</li>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:if test="${pagination.currentBlock lt pagination.totalBlocks }">
	<li>
		<a href="${link }?pageNo=${pagination.nextBlock }" id="navi-${pagination.nextBlock }" aria-label="Next">
			<span aria-hidden="true">&raquo;</span>
		</a>
	</li>
	</c:if>
</ul>