package Question;

import java.util.ArrayList;

public abstract class TextQuestion extends Question {
    /* List of possible answers to the question */
    protected ArrayList<String> correctAnswerList;

    /* Current user answer */
    protected String userAnswer;

    public TextQuestion(String questionText, int questionType, int questionId, ArrayList<String> correctAnswerList) {
        super(questionText, questionType, questionId);
        addAnswers(correctAnswerList);
    }

    private void addAnswers(ArrayList<String> answerList) {
        this.correctAnswerList = new ArrayList<String>(answerList);
        this.userAnswer = null;
        for(String answer : answerList) {
            this.correctAnswerList.add(answer.toLowerCase());
        }
    }

    public ArrayList<String> getCorrectAnswers() {
        return this.correctAnswerList;
    }

    public void setAnswer(String userAnswer) {
        this.userAnswer = userAnswer;
    }

    public String getUserAnswer() {
        return userAnswer;
    }

    @Override
    public boolean hasAnswer() {
        return this.userAnswer != null;
    }

    @Override
    public int countPoints() {
        return isAnswerCorrect() ? 1 : 0;
    }

    private boolean isAnswerCorrect() {
        return this.correctAnswerList.contains(userAnswer.toLowerCase());
    }
}
