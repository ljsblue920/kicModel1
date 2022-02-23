<%@page import="model.Board"%>
<%@page import="java.util.List"%>
<%@page import="service.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

String boardid = "";
int pageInt = 1;
int limit = 10;

//boardid 파라메터로 넘어 왓을때만 session에 저장 한다
if (request.getParameter("boardid") !=null) {
	session.setAttribute("boardid", request.getParameter("boardid"));
	session.setAttribute("pageNum", "1");
}

boardid = (String) session.getAttribute("boardid");

if (boardid==null) {
	boardid = "1";
}
//	pageNum이 파라메터로 넘어 왔을때만 session에 저장 한다
if (request.getParameter("pageNum") !=null) {
	session.setAttribute("pageNum", request.getParameter("pageNum"));
}

String pageNum = (String) session.getAttribute("pageNum");

if (pageNum==null) {
	pageNum = "1";
}

pageInt = Integer.parseInt(pageNum);


BoardDao bd = new BoardDao();
int boardcount = bd.boardCount(boardid);


/* -- 1, 4, 7, 10
-- start : (pageInt-1) * limit + 1;
-- end : start + limit - 1;
-- 1 p --> 1 ~ 3 
-- 2 p --> 4 ~ 6
-- 3 p --> 7 ~ 10
 */

List<Board> list = bd.boardList(pageInt, limit, boardcount, boardid);

/* 
-- 1 p --> boardcount ~
-- 2 p --> boardcount -1 * limit ~
-- 3 p --> boardcount -2 * limit 
*/

int boardnum = boardcount - (pageInt -1 ) * limit;

/* 
-- 1 p --> boardcount ~
-- 2 p --> boardcount -1 * limit ~
-- 3 p --> boardcount -2 * limit 
*/
int bottomLine = 3;
int startPage = (pageInt -1 )/ bottomLine * bottomLine + 1;
int endPage = startPage + bottomLine -1;
int maxPage = (boardcount / limit) + (boardcount % limit == 0 ? 0 : 1);
if (endPage > maxPage) endPage = maxPage;


/* 
-- 1 p --> startpage = 1	(p-1)/3 * 3 +1
-- 2 p --> startpage = 1	
-- 3 p --> startpage = 1	
-- 4 p --> startpage = 4 
-- 5 p --> startpage = 4 
-- 6 p --> startpage = 4 
 1 2 3 , 4 5 6 , 7 8 9
*/

	String boardName[] = {"", "공지사항", "자유게시판", "QNA" };	
%>
<hr>
	<!-- table list start -->
	<div class="container">
		<h2  id="center"><%=boardName[Integer.parseInt(boardid)] %> [<%=pageInt%>]-[<%=boardid %>]</h2>
		<p align="right">
		<% if (boardcount > 0) { %>글개수 <%=boardcount%>	<%} else { %>
		등록된 게시물이 없습니다
		<% } %>
		</p>

		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
					<th>파일</th>
					<th>조회수</th>

				</tr>
			</thead>
			<tbody>
			<%
			
			for (Board b : list) {
							
			%>
				<tr>
					<td><%=(boardnum--) %></td>
					<td>
					
					<% if (b.getReflevel() > 0) { 
					// 답글임
					%>
					<img src="<%=request.getContextPath()%>/image/level.gif" width = "<%=5*b.getReflevel() %>">
					<img src="<%=request.getContextPath()%>/image/re.gif" >
					<% } %>
												
					<td><a href="boardInfo.jsp?num=<%=b.getNum() %>"><%=b.getSubject() %></a></td>
					<td><%=b.getWriter() %></td>
					<td><%=b.getRegdate() %></td>
					<td><%=b.getFile1() %></td>
					<td><%=b.getReadcnt() %></td>
					
				</tr>
			<% } %>
			</tbody>
		</table>
		<p align="right"><a href="<%=request.getContextPath() %>/view/board/writeForm.jsp">게시판입력</a></p>
		<div class="container"  >
		<ul class="pagination justify-content-center"  >
		
   <li class="page-item <% if (startPage <= bottomLine) { %> disabled <% } %>"><a class="page-link" href="list.jsp?pageNum=<%=startPage-bottomLine%>">Previous</a></li>

 <% for ( int i = startPage ; i <= endPage ; i ++) { %>
 <li class = "page-item <% if (i==pageInt) { %> active <%}%>"><a class = "page-link" href="list.jsp?pageNum=<%=i %>"><%=i %></a></li>
 <% } %>
 
  <li class="page-item <% if (endPage >= maxPage) { %> disabled <% } %>" ><a class="page-link" href="list.jsp?pageNum=<%=startPage+bottomLine%>">Next</a></li>
 
</ul> </div>
	</div>
</body>
</html>