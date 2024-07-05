<%@ page import="Question.QuestionResponse" %>
<%@ page import="Quiz.*" %>
<%
    QuestionResponse qObject = (QuestionResponse) request.getAttribute("currentQuestion");
    Integer curQuestionIndex = (Integer) request.getAttribute("curQuestionIndex");

    Quiz currentQuiz = (Quiz) request.getAttribute("currentQuiz");
    Integer numQuestions = currentQuiz.getNumberOfQuestions();

    String userAnswer = qObject.getUserAnswer() == null ? "" : qObject.getUserAnswer();
%>

<div class="row">
    <div class="col">
        <div class="question-cont">
            <div class="question">
                <h5>Question #<%= curQuestionIndex %></h5>
                <p><%= qObject.getQuestionText() %></p>
            </div>
            <div class="answer">
                <% if(!qObject.hasAnswer()) { %>
                <label class="answer-label" for="text_<%= qObject.getId() %>">Your answer: </label>
                <textarea id="text_<%= qObject.getId() %>" class="form-control answer-text" spellcheck="false" autocomplete="off" autocapitalize="off"><%= userAnswer %></textarea>
                <% } else { %>
                <div><span>Your Answer: </span></div>
                    <% if(qObject.countPoints() > 0) { %>
                    <b class="text-ans text-correct"><%= qObject.getUserAnswer() %></b>
                    <% } else { %>
                    <b class="text-ans text-wrong"><%= qObject.getUserAnswer() %></b>
                    <div><span>Correct Answer: </span></div>
                    <b class="text-ans text-correct"><%= String.join(", ", qObject.getCorrectAnswers()) %></b>
                    <% } %>
                <% } %>
            </div>
        </div>
    </div>
</div>