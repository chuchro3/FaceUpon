$(document).ready(function() {
  console.log('here i am');

  FB.logout(function(response) {
    alert("Successfully logged out!");
    window.location.replace("/");
  });
});


