<%@ page import="Question.PictureResponse" %>
<%@ page import="Quiz.*" %>
<%@ page import="Question.QuestionType" %>
<%@ page import="java.util.HashMap" %>
<%
  PictureResponse qObject = (PictureResponse) request.getAttribute("currentQuestion");
  Integer curQuestionIndex = (Integer) request.getAttribute("curQuestionIndex");

  Quiz currentQuiz = (Quiz) request.getAttribute("currentQuiz");
  Integer numQuestions = currentQuiz.getNumberOfQuestions();

  String userAnswer = qObject.getUserAnswer() == null ? "" : qObject.getUserAnswer();

  HashMap<Integer, QuestionType> typeMap = QuestionType.createMap();
  QuestionType questionType = typeMap.get(qObject.getId());
  String questionTypeStr = questionType == null ? "UNKNOWN" : questionType.getTypeName();

%>

<div class="row">
  <div class="col">
    <div class="question-cont" data-index="<%= curQuestionIndex %>" data-type="<%= questionTypeStr %>" data-id="<%= qObject.getId() %>">
      <div class="question">
        <h5>Question #<%= curQuestionIndex %></h5>
        <p><%= qObject.getQuestionText() %></p>
        <div class="question-image-cont">
          <img src="<%= qObject.getPicture() %>" alt="<%= qObject.getQuestionText() %>" />
        </div>
      </div>

      <div class="answer">
        <% if(currentQuiz.isImmediateCorrectionOn() && qObject.hasAnswer()) { %>
          <div><span>Your Answer: </span></div>
          <% if(qObject.countPoints() > 0) { %>
          <b class="text-ans text-correct"><%= qObject.getUserAnswer() %></b>
          <% } else { %>
          <b class="text-ans text-wrong"><%= qObject.getUserAnswer() %></b>
          <div><span>Correct Answer: </span></div>
          <b class="text-ans text-correct"><%= String.join(", ", qObject.getCorrectAnswers()) %></b>
          <% } %>
        <% } else { %>
        <label class="answer-label" for="text_<%= qObject.getId() %>">Your answer: </label>
        <textarea id="text_<%= qObject.getId() %>" class="form-control answer-text" spellcheck="false" autocomplete="off" autocapitalize="off"><%= userAnswer %></textarea>
        <% } %>
      </div>

    </div>
  </div>
</div>