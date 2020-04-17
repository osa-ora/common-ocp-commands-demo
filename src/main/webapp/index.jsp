<%@page import="osa.ora.freeoffers.OrderSubmit"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Dynamic Heel - 3 Days Offer</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script language="Javascript">
function IsEmpty(){ 
	if(document.forms[0].name.value == "") {
		alert("Please enter valid name!");
		return false;
	}
	if(document.forms[0].address.value == "") {
		alert("Please enter valid address!");
		return false;
	}
	if(document.forms[0].email.value == "") {
		alert("Please enter valid Email or Mobile No!");
		return false;
	}
    document.forms[0].submit();
}
</script>
    </head>
    <body>
    <center>
        <h1>Smart Shoes Store offers</h1>
        <h2><i>Hello Lucky, This is our <b>Free</b> 3-days offer</i></h2>
<form method="get" action="OrderSubmit">
        <table>
            <tr>
                <td></td>
                <td>This Amazing collection can be dynamically converted during your day to whatever makes you feel comfortable</td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td>We are giving one free order per customer from our stores in Cairo, Dubai and Kuwait<br><b>Remaining orders: <%=34000-OrderSubmit.COUNTER%> </b></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td><img src="images/4.jpg" width="400"><img src="images/1.jpg" width="400"></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td><img src="images/2.jpg" width="400"><img src="images/3.jpg" width="400"></td>
                <td></td>
            </tr>
            <tr>
            <tr>
                <td></td>
                <td>Order Details:</td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td><font color="red">*</font>Full Name<bt>
                <input id="name" name="name" size="30"></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td><font color="red">*</font>Email or Mobile No<bt>
                    <input id="email" name="email" size="30"></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td><font color="red">*</font>Full Address<br>
                <input id="address" name="address" size="100"></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td><font color="red">*</font>Shoes Size (Pick Exact Size)
                &nbsp;&nbsp;&nbsp;<select id = "size" name="size" width="200">
                    <option value = "35">Size 35</option>
                    <option value = "36">Size 36</option>
                    <option value = "37">Size 37</option>
                    <option value = "38">Size 38</option>
                    <option value = "39">Size 39</option>
                    <option value = "40">Size 40</option>
                </select></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td><br><input id="insert" onclick="return IsEmpty();" type="submit" value="Place Order" width="100"/></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td>Note: Kindly place only one order, the shoes color will be randomly selected, if you put 2 orders we may cancel your orders<br></td>
                <td></td>
            </tr>
        </table>
</form>    
<hr width="50%">
Smart Shoes Store, Copyright © 2020<br>
</center>
    </body>
</html>
