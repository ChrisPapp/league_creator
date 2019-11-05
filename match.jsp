<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- begin html --%>
<!DOCTYPE html>
<html lang="en">
  	<head>
    	<meta charset="utf-8">    
   		<title>League Name</title>
  		<link rel="stylesheet" type="text/css" href="css/default_styles.css"> 
      <!-- Import the base grid styles -->
      <link rel="stylesheet" type="text/css" href="css/grid.css">
      <!-- Match specific styles -->
      <link rel="stylesheet" type="text/css" href="css/match.css">
  	</head>
  	<body>
  		<%@ include file="navbar.html" %>
    	<div class="grid-container">
      <div class="grid">
        <div class="grid-col grid-col--fixed-left">
          <div class="grid-item grid-item--header">
            <img src="https://seeklogo.com/images/G/greece-super-league-logo-19FBE0771B-seeklogo.com.gif" alt="Super League Logo">
          </div>
          <div class="grid-item">
            <h2>Goals</h2>
          </div>
          <div class="grid-item">
            <h2>Yellow Cards</h2>
          </div>
          <div class="grid-item">
            <h2>Red Cards</h2>
          </div>
        </div>

        <div class="grid-col">
          <div class="grid-item grid-item--header">
            <img src="https://seeklogo.com/images/O/Olympiacos_FC-logo-8F8F1A05DD-seeklogo.com.png" alt="Olympiacos">
          </div>
          <div class="grid-item result">
            <p>5</p>
          </div>
          <div class="grid-item result">
            <p>Semedo</p>       
          </div>
          <div class="grid-item result">
            <p>-</p>
          </div>
        </div>

        <div class="grid-col">
          <div class="grid-item grid-item--header">
            <img src="https://upload.wikimedia.org/wikipedia/el/thumb/5/56/Panathinaikos_FC_logo.svg/300px-Panathinaikos_FC_logo.svg.png" alt="Panathinaikos">
          </div>
          <div class="grid-item result">
            <p>0</p>
          </div>
          <div class="grid-item result">
            <p>Insua, Mpouzoukis</p>
          </div>
          <div class="grid-item result">
            <p>Dioudis</p>
          </div>
        </div>
      </div>
    </div>	     
  </body>
</html>