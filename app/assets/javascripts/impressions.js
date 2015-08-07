function hideLastImpressions() {
  var groups = $(".impression-group");
  for(i=0; i < groups.length; i++) {
    $(groups[i]).find(".impression-wrapper").last().hide();
  };
}

function removeImpression() {
  var link = $(event.target);
  link.closest(".impression-wrapper").remove();
}

function bindRemoveImpression() {
  $(".delete-impression").on("click", removeImpression);
}

function duplicateImpression() {
  var link = $(event.target);
  var impressionGroup = link.closest("td").find(".impression-group");
  var hiddenWrapper = impressionGroup.find(".impression-wrapper").last();
  impressionGroup.append(hiddenWrapper.clone());
  hiddenWrapper.show();
  bindRemoveImpression
}

function bindDuplicateImpression() {
  $(".add-impression").on("click", duplicateImpression);
}

function setUpImpressions() {
  if($(".edit-scores").length > 0) {
    hideLastImpressions();
    bindRemoveImpression();
    bindDuplicateImpression();
  }
}

$(setUpImpressions)
