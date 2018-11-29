<div class="header">
    <div class="h-logo">
        <img src="<%=request.getContextPath() + "/Staff/"%>Images/logo.png" alt="logo" width="180" height="40">
    </div>
    <div class="h-others">
        <p id="time-and-date">Loading...</p>
    </div>
    <div class="user-profile dropdown">

        <div class="profile dropdown-toggle" data-toggle="dropdown" aria-expanded="true" role="menu">
            <div class="u-image">
                <img src="<%=request.getContextPath() + "/Staff/"%>Images/avatar-mini-2.jpg" alt="user image">
            </div>
            <span class="profile-name"><%=session.getAttribute("name")%></span>
        </div>
        <ul class="dropdown-menu">
            <li><a href="#"><i class="fas fa-user"></i> View your profile</a></li>
            <li><a href="#"><i class="fas fa-pencil-alt"></i> Edit your profile</a></li>
            <li><a href="#"><i class="fas fa-bell"></i> Notifications</a></li>
            <li class="divider"></li>
            <li><a href="/StaffWelcome?from=logout"><i class="fas fa-lock"></i> log out</a></li>
        </ul>
    </div>
</div>

<!--
<form action="<%/*AD_PAGES.ADMIN_LOGOUT*/%>" method="post">
<input type="hidden" name="logout" value="logout"/>
</form>
-->
