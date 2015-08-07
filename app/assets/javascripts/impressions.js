function bindImpressions() {
  if($(".edit-scores").length > 0) {
    $(".add-impression").on("click", function(){
      alert("Yo");
    });
  }
}

$(bindImpressions)
