<%@ page import="java.sql.ResultSet" %>
<%@ page import="Core.SqlConnection" %>
<%--
  Created by IntelliJ IDEA.
  User: Geeth Sandaru
  Date: 5/15/2018
  Time: 13:07
  To change this template use File | Settings | File Templates.
--%>
<div class="header">
    <div class="online-options">
        <ul>
            <li>ONLINE STORE</li>
            <li><i class="fas fa-circle fa-xs"></i>PAYMENTS</li>
            <li><i class="fas fa-circle fa-xs"></i>SHIPPING</li>
            <li><i class="fas fa-circle fa-xs"></i>RETURN</li>
        </ul>
    </div>
    <div class="cart-options">
        <ul>
            <li><a href="viewShoppingCart.jsp"><i class="fas fa-shopping-basket"></i></a></li>
            <li><i class="fas fa-heart"></i>WISHLIST ( 0 ) ITEMS</li>
            <%
                if (session.getAttribute("username") == null)
                {
            %>
            <li><i class="fas fa-user"></i><a href="login.jsp">Login</a></li>
            <li><i class="fas fa-user"></i><a href="signup.jsp">Sign up</a></li>
            <%
            }
            else
            {
            %>
            <li><i class="fas fa-user"></i><a href="/CustomerLogout">Logout</a></li>
            <li><i class="fas fa-user"></i><a href="updateCustomer.jsp">Update profile</a></li>
            <li><i class="fas fa-circle fa-xs"></i><a href="customerInvoiceHistory.jsp">History</a></li>
            <%
                }
            %>
        </ul>
    </div>
    <div class="social-icons">
        <ul>
            <li class="fb"><i class="fab fa-facebook-f fa-2x"></i></li>
            <li class="pin"><i class="fab fa-pinterest fa-2x"></i></li>
            <li class="twit"><i class="fab fa-twitter fa-2x"></i></li>
            <li class="you"><i class="fab fa-youtube fa-2x"></i></li>
        </ul>
    </div>

</div>
<div class="nav">
    <div class="logo">
        <a href="index.jsp"><img src="Images/logo.png" alt="logo"></a>
    </div>
    <div class="manu">
        <div class="menu-item">
            <div class="k">
                <a href="index.jsp">
                    <i class="fas fa-home fa-1x"></i>
                    <p>HOME</p>
                </a>
            </div>
        </div>
        <div class="menu-item sub">
            <div class="k">
                <a href="shop.jsp">
                    <i class="fas fa-shopping-basket fa-1x"></i>
                    <p>SHOP</p>
                </a>
            </div>
        </div>
        <div class="menu-item sub">
            <div id="menu-listiner">
                <a>
                    <i class="fas fa-book fa-1x"></i>
                    <p>CATEGORIES</p>
                </a>
            </div>
        </div>
        <div class="menu-item sub">
            <div class="k">
                <a href="about.jsp">
                    <i class="fas fa-magic fa-1x"></i>
                    <p>ABOUT</p>
                </a>
            </div>
        </div>
        <div class="menu-item sub">
            <div class="k">
                <a>
                    <i class="fas fa-images fa-1x"></i>
                    <p>GALARY</p>
                </a>
            </div>
        </div>
        <div class="menu-item sub" >
            <div class="k">
                <a>
                    <i class="fas fa-camera fa-1x"></i>
                    <p>EVENTS</p>
                </a>
            </div>
        </div>
    </div>
    <div class="search">
        <div>
            <i class="fas fa-search"></i>
        </div>
    </div>
</div>
<div class="mainImage">
    <div class="navi-manu">
        <%
            try
            {
                ResultSet rs = SqlConnection.getData("SELECT * FROM category");

                while (rs.next())
                {
        %>
        <div class="ncategory">
            <div class="ctitle">
                <i class="fas fa-book fa-1x"></i>
                <%=rs.getString("cat_name")%>
            </div>
        </div>
        <%
                }
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
        %>
    </div>
</div>
