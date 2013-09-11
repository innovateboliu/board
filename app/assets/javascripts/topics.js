var httpRequest;
function add_vote(comment_id) {
  var httpRequest = getHttpRequest();
  addChange(httpRequest, comment_id);
  send("add_vote", httpRequest, comment_id);
};
function subtract_vote(comment_id) {
  var httpRequest = getHttpRequest();
  addChange(httpRequest, comment_id);
  send("subtract_vote", httpRequest, comment_id);
};

function send(methodName, httpRequest, comment_id) {
  path = document.URL + "/" + methodName + "?comment_id=" + comment_id;
  httpRequest.open('GET', path);
  httpRequest.send();
}

function addChange(httpRequest, comment_id) {
  httpRequest.onreadystatechange = (function(){
    var id = "vote_" + comment_id;
    return function updateVoteNumber() {
      if (httpRequest.readyState === 4) {
        document.getElementById(id).innerHTML = httpRequest.responseText;
      }
    };
  })();
}

function getHttpRequest() {
  var httpRequest;
  if (window.XMLHttpRequest) {
    httpRequest = new XMLHttpRequest();
  } else if (window.ActiveXObject) {
    try {
      httpRequest = new ActiveXObject("Msxml2.XMLHTTP");
    } catch(e) {
      try {
        httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
      } catch (e) {

      }
    }
  }

  if (!httpRequest) {
    alert("Cannot create an XMLHTTP object");
    return false;
  }

  return httpRequest;
}

