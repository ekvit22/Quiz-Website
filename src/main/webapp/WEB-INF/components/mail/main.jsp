<%@ page import="java.util.ArrayList" %>
<%@ page import="Mail.*" %>
<%@ page import="Account.AccountManager" %>
<%@ page import="Account.Account" %>

<link rel="stylesheet" href="/css/mail.css" />

<%
    String curTab = request.getAttribute("currentTab") == null ?
            "all" : (String) request.getAttribute("currentTab");

    // Get the account manager
    AccountManager acm = ((AccountManager)
            request.getServletContext().getAttribute("accountManager"));


    ArrayList<Mail> mails = new ArrayList<Mail>();

    // FOR TEST
    int numFriendReqs = 2;
    int numChallenges = 0;
    int numNotes = 2;
    int numMails = numFriendReqs + numChallenges + numNotes;
    if(curTab.equals("all") || curTab.equals("friend_req")) {
        mails.add(new FriendRequestMail( acm.getAccount("vazzu") ));
        mails.add(new FriendRequestMail( acm.getAccount("bero") ));
    }
    if(curTab.equals("all") || curTab.equals("notes")) {
        mails.add(new NoteMail( acm.getAccount("realtia"), "Hey! Can you check out my new quiz?" ));
        mails.add(new NoteMail( acm.getAccount("elene"), "Metallica the best" ));
    }

%>

<div class="mail-container">
    <div class="container">
        <div class="row">
            <div class="col-3">
                <div class="mail-tabs">

                    <a href="/mail?tab=all" class="mail-tab <%= curTab.equals("all") ? "active" : "" %>">
                        <span>All</span>
                        <% if(numMails > 0) { %>
                            <span class="mail-tab-counter"><%= numMails %></span>
                        <% } %>
                    </a>
                    <a href="/mail?tab=friend_req" class="mail-tab <%= curTab.equals("friend_req") ? "active" : "" %>">
                        <span>Friend Requests</span>
                        <% if(numFriendReqs > 0) { %>
                        <span class="mail-tab-counter"><%= numFriendReqs %></span>
                        <% } %>
                    </a>
                    <a href="/mail?tab=challenges" class="mail-tab <%= curTab.equals("challenges") ? "active" : "" %>">
                        <span>Challenges</span>
                        <% if(numChallenges > 0) { %>
                        <span class="mail-tab-counter"><%= numChallenges %></span>
                        <% } %>
                    </a>
                    <a href="/mail?tab=notes" class="mail-tab <%= curTab.equals("notes") ? "active" : "" %>">
                        <span>Notes</span>
                        <% if(numNotes > 0) { %>
                        <span class="mail-tab-counter"><%= numNotes %></span>
                        <% } %>
                    </a>
                </div>
            </div>
            <div class="col-9">
                <div class="table-cont">

                    <table class="table table-hover">
                        <tr>
                            <th>#</th>
                            <th>From</th>
                            <th>Message</th>
                            <th>Action</th>
                        </tr>

                        <%
                            for(int i=1; i<=mails.size(); i++) {
                                Mail mail = mails.get(i - 1);
                                Account from = mail.getFrom();
                        %>
                            <tr data-mail-type="<%= mail.getType() %>">
                                <td><%= i %></td>
                                <td>
                                    <a href="/profile?username=<%= from.getUserName() %>"><%= from.getFirstName() %> <%= from.getLastName() %></a>
                                    <span class="sender-username">(<%= from.getUserName() %>)</span>
                                </td>
                                <td><%= mail.getMessage() %></td>
                                <td>
                                    <% if(mail.getType() == Mail.FRIEND_REQUEST) { %>
                                        <button class="btn btn-outline-success btn-round">Accept</button>
                                        <button class="btn btn-outline-danger btn-round">Decline</button>
                                    <% } else if(mail.getType() == Mail.CHALLENGE) { %>
                                        <button class="btn btn-outline-success btn-round">Accept</button>
                                    <% } %>
                                </td>
                            </tr>
                        <% } %>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

