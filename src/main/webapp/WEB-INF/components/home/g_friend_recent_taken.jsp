<%@ page import="Quiz.QuizManager" %>
<%@ page import="Quiz.Quiz" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Account.Account" %>
<%@ page import="Account.AccountManager" %>

<%
    Account user = (Account) request.getAttribute("currentUser");
    QuizManager qm = (QuizManager) request.getServletContext().getAttribute("quizManager");
    ArrayList<Quiz> friendsRecentlyTaken = qm.getFriendTakenQuizzes(user.getUserId());
    AccountManager acm = (AccountManager) request.getServletContext().getAttribute("accountManager");
%>

<section class="group-section g-recent">
    <div class="g-content">
        <div class="g-title-cont">
            <div class="g-title-bg">
                <h4 class="g-title">Taken By Friends</h4>
            </div>
        </div>
        <div class="g-list pt-4">

            <% if(friendsRecentlyTaken.isEmpty()) { %>
            <p> No friends with taken quizzes yet.</p>
            <% } else { %>
            <ol>
                <% for(int i=0; i<Math.min(5, friendsRecentlyTaken.size()); i++) { %>
                <%
                    Quiz quiz = friendsRecentlyTaken.get(i);
                    if(quiz == null) { %>
                        <li><span> [deleted quiz] </span></li>
                        <% } else {
                        Account author = acm.getAccountById(quiz.getAuthorId());
                        if(author == null) { %>
                            <li><a href="/about_quiz?id=<%= quiz.getId() %>"><%=quiz.getName()%></a> (By <span style="color:black" class="friend-quiz-author" >[deleted user]</span>)</li>
                        <% } else { %>
                            <li><a href="/about_quiz?id=<%= quiz.getId() %>"><%=quiz.getName()%></a> (By <a class="friend-quiz-author" href="/profile?username=<%=author.getUserName()%>"><%=author.getUserName()%></a>)</li>
                        <% } %>
                    <% } %>
                <% } %>
                </ol>
            <% } %>
        </div>
    </div>
</section>

