<%@ page import="Account.Account" %>
<%@ page import="Global.SessionManager" %>
<%@ page import="Database.Database" %>
<%@ page import="Account.FriendRequestManager" %>
<%@ page import="Account.AccountManager" %>
<%@ page import="Account.FriendsManager" %>
<%@ page import="java.util.ArrayList" %>

<%
    Account userAccount = (Account) request.getAttribute("userAccount");

    SessionManager sessionManager = new SessionManager(request.getSession());
    Account myAccount = sessionManager.getCurrentUserAccount();

    Database db = ((Database) request.getServletContext().getAttribute("database"));
    FriendRequestManager frm = new FriendRequestManager(db);

    FriendsManager fm = new FriendsManager(db);
    AccountManager acm = ((AccountManager) request.getServletContext().getAttribute("accountManager"));

%>

<style>
    .red-button{
        color:red;
    }

    .blue-button{
        color: blue;
    }

    .buttons{
        display: flex;
        gap: 10px;
    }

    .edit-text{
        width: 100%;
    }

    .original-text{
        width: 100%;
    }

    .user-details-cont {
        flex-grow: 1;
    }

</style>

<main class="profile-page">
    <div class="container">
        <div class="row">

            <% if(userAccount != null) { %>

            <div class="col">
                <div class="user-profile">

                    <%if(myAccount != null && userAccount != null){
                        int myId = myAccount.getUserId();
                        int userId = userAccount.getUserId();
                        String status = frm.getStatusById(myId, userId);
                        String reqSent = frm.getStatusById(userId, myId);
                        boolean areFriends = fm.areFriends(myId, userId);
                        if(sessionManager.isUserLoggedIn() && myAccount.getUserId() != userAccount.getUserId()) { %>
                            <div class="user-action">
                                <% if (reqSent != null && reqSent.equals("PENDING")){ %>
                                    <p>this user sent you a friend request</p>
                                <%}else  if (status != null && status.equals("PENDING")){%>
                                    <button id="request" class="btn btn-round btn-outline-success" style="display: block">request sent</button>
                                <%} else if(!areFriends){ %>
                                    <button onclick="addFriend('<%=userAccount.getUserName()%>')" id="add_friend" class="btn btn-round btn-outline-primary" style="display: block">Add Friend</button>
                                <%} else if (areFriends){%>
                                    <button onclick="removeFriend('<%=userAccount.getUserName()%>')" id="rem_friend" class="btn btn-round btn-outline-danger" style="display: block">Unfriend</button>
                                <%} %>
                            </div>
                        <% } %>
                    <% } %>
                    <div class="profile-row">
                        <div class="user-image-cont">
                            <img id="profile-picture" src="<%=userAccount.getImage()%>" width="200" height="200" />
                            <% if (myAccount != null && myAccount.getUserId() == userAccount.getUserId()){ %>
                                <div class="owner-action">
                                    <div class="btn-action">
                                        <a id="change-profile-pic" class="changed-profile-pic" style="display: block;" href="#">Change Profile Picture</a>
                                    </div>
                                </div>
                            <% } %>
                            <div class="achievement-cont">
                                <h4><i class="fa-solid fa-trophy"></i> My Achievements </h4>
                                <ul>
                                    <li style="color: green">Amateur Author</li>
                                    <li style="color: purple">Prolific Author</li>
                                    <li style="color: red">I am the greatest</li>
                                    <li style="color: blue">Practice Makes Perfect</li>
                                </ul>
                            </div>
                        </div>
                        <div class="user-details-cont">
                            <div class="name-lastname-cont">
                                <h3><%= userAccount.getFirstName() %> <%= userAccount.getLastName() %></h3>
                            </div>
                            <div class="username-cont">
                                <p><%= userAccount.getUserName() %></p>
                            </div>
                            <form id="profile-form" action="/profile" method="post">
                                <div class="about-cont">
                                    <h4>About Me
                                        <% if (myAccount != null && myAccount.getUserId() == userAccount.getUserId()) { %>
                                            <a id="edit-about-me" class="about-me-edit" style="display: block;" href="#">edit</a>
                                        <% } %>
                                    </h4>
                                    <p style="display: block" id="text-about-me" class="original-text"> <%=userAccount.getAboutMe()%></p>
<%--                                    this wont work if edit button isnt clicked but just for insurance--%>
                                    <% if(myAccount != null && myAccount.getUserId() == userAccount.getUserId()) { %>
                                        <textarea style="display: none" id="write-about-me" name="aboutMe" class="edit-text"><%=userAccount.getAboutMe()%></textarea>
                                        <input type="hidden" id="username" value="<%= userAccount.getUserName() %>">
                                        <div class="buttons">
                                            <button style="display: none" id="cancel-button" class="red-button" >Cancel</button>
                                            <button style="display: none" id="save-button" class="blue-button" >Save</button>
                                        </div>
                                    <% } %>
                                </div>
                            </form>
                            <div class="profile-sub-row">
                                <div class="profile-note friends-cont">
                                    <h4>My Friends <span class="num-friends">(3)</span></h4>
                                    <ul>
                                        <%if(myAccount != null){
                                                ArrayList<Integer> friendsListById = fm.friendsList(myAccount.getUserId());
                                                for(Integer userId: friendsListById){
                                                    Account account = acm.getAccountById(userId); %>
                                                    <li><a href="#"><%=account.getUserName()%></a></li>
                                                <%}%>
                                        <%}%>
<%--                                        <li><a href="#">Elene Kvitsiani</a></li>--%>
<%--                                        <li><a href="#">Vasiko Vazagaevi</a></li>--%>
<%--                                        <li><a href="#">Gio Beridze</a></li>--%>
                                    </ul>
                                </div>
                                <div class="profile-note my-quizzes-cont">
                                    <h4>Quizzes I Created</h4>
                                    <ul>
                                        <li><a href="#">Geography Quiz</a></li>
                                        <li><a href="#">Astronomy Quiz</a></li>
                                        <li><a href="#">Cool Exoplanets</a></li>
                                    </ul>
                                </div>
                                <div class="profile-note quizzes-took-cont">
                                    <h4>Quizzes I Took</h4>
                                    <ul>
                                        <li><a href="#">P = EXPTIME?</a></li>
                                        <li><a href="#">RP = BPP = P???</a></li>
                                        <li><a href="#">NSPACE is cool</a></li>
                                        <li><a href="#">Is NP cooler than P?</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <% } else { %>

            <!-- User was not found message -->
            <div class="user-not-found">
                <h3>User "<%= request.getAttribute("reqUsername") %>" does not exist.</h3>
            </div>

            <% } %>

        </div>
    </div>
</main>