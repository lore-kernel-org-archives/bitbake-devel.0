Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id ECAF37231B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jan 2015 12:46:58 +0000 (UTC)
Received: by mail-pa0-f47.google.com with SMTP id kq14so10331416pab.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jan 2015 04:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=kdIPyr8DQp6VpWZ9nopst+xGw+WtZS77xSs3AMw5PPE=;
	b=TIYYBx2bQMxpL6YHq+P7HZA+Wn6jh0N3771hnl3vZBqeTogROXlTutbYn7dUSTa2li
	SAKbvkh6thPszkSUTdqFbALII20oIg82g21esLLVll+YRpMulm1FK7PX6auVF6otr5MB
	3/O9k5Vebneooq2m1lI8ZTfNbFotb9cTyneRQprv4+Vh0xn541epNRSpzisvxhxvXvXU
	J1yWyMi7coZF6ly5MZAuX7b8cQCH2N7MWQNxp0FFlGzHEdKDi7cvHWvUoPb1qk7BeQNe
	3/rwen3Y7u4mHZTatk/oGA0Aedw0MXy3/0Sj3CU+Yr7NPpkNrsOSqqnE0hJOfR740fyk
	plXw==
X-Gm-Message-State: ALoCoQmewgf4H7DJVbIs+WIA6+teDKTVKV1Mh3kXEmP2D9NW964ET4x0ThA1vKxMYBwfOAwH3Z/y
X-Received: by 10.68.179.226 with SMTP id dj2mr5510075pbc.100.1421239619219;
	Wed, 14 Jan 2015 04:46:59 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id t9sm19635778pbs.75.2015.01.14.04.46.57
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 14 Jan 2015 04:46:58 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id E9DA85621A2; Wed, 14 Jan 2015 12:46:56 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Jan 2015 12:46:52 +0000
Message-Id: <37d047c01cabee67a55e0750bfe51ec407be6b09.1421239131.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1421239131.git.alexandru.damian@intel.com>
References: <cover.1421239131.git.alexandru.damian@intel.com>
Subject: [PATCH 1/4] toaster: Add layer details page feature
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 14 Jan 2015 12:47:01 -0000

From: Michael Wood <michael.g.wood@intel.com>

This commit adds the layer details page which shows the metadata for the
layer such as layer description, machines associated with the layer as well
as the targets provided.
If the layer is an imported layer this page also allows you to update
the layer's configuration.
From this page you can add/remove the layer from the current project

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/css/default.css      |   1 +
 lib/toaster/toastergui/static/js/layerdetails.js   | 404 +++++++++++++
 lib/toaster/toastergui/static/js/libtoaster.js     |  35 ++
 lib/toaster/toastergui/templates/layerdetails.html | 644 ++++++++++++++++-----
 .../toastergui/templates/layers_dep_modal.html     |   9 +
 lib/toaster/toastergui/urls.py                     |   1 +
 lib/toaster/toastergui/views.py                    |  94 ++-
 7 files changed, 1038 insertions(+), 150 deletions(-)
 create mode 100644 lib/toaster/toastergui/static/js/layerdetails.js

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 199c753..a3fa0dd 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -232,3 +232,4 @@ dd > span { line-height: 20px; }
 .animate-repeat.ng-enter.ng-enter-active {
   opacity:1;
 }
+.tab-pane table { margin-top: 10px; }
diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
new file mode 100644
index 0000000..a5a6330
--- /dev/null
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -0,0 +1,404 @@
+"use strict"
+
+function layerDetailsPageInit (ctx) {
+
+  var layerDepInput = $("#layer-dep-input");
+  var layerDepBtn = $("#add-layer-dependency-btn");
+  var layerDepsList = $("#layer-deps-list");
+  var currentLayerDepSelection;
+  var addRmLayerBtn = $("#add-remove-layer-btn");
+
+  /* setup the dependencies typeahead */
+  libtoaster.makeTypeahead(layerDepInput, ctx.xhrDataTypeaheadUrl, { type : "layers", project_id: ctx.projectId, include_added: "true" }, function(item){
+    currentLayerDepSelection = item;
+
+    layerDepBtn.removeAttr("disabled");
+  });
+
+  function addRemoveDep(depLayerId, add, doneCb) {
+    var data = { layer_version_id : ctx.layerVersion.id };
+    if (add)
+      data.add_dep = depLayerId;
+    else
+      data.rm_dep = depLayerId;
+
+    $.ajax({
+        type: "POST",
+        url: ctx.xhrUpdateLayerUrl,
+        data: data,
+        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+        success: function (data) {
+          if (data.error != "ok") {
+            console.warn(data.error);
+          } else {
+            doneCb();
+          }
+        },
+        error: function (data) {
+          console.warn("Call failed");
+          console.warn(data);
+        }
+    });
+  }
+
+  function layerRemoveClick() {
+    var toRemove = $(this).parent().data('layer-id');
+    var layerDepItem = $(this);
+
+    addRemoveDep(toRemove, false, function(){
+      layerDepItem.parent().fadeOut(function (){
+        layerDepItem.remove();
+      });
+    });
+  }
+
+  /* Add dependency layer button click handler */
+  layerDepBtn.click(function(){
+    if (currentLayerDepSelection == undefined)
+      return;
+
+    addRemoveDep(currentLayerDepSelection.id, true, function(){
+      /* Make a list item for the new layer dependency */
+      var newLayerDep = $("<li><a></a><span class=\"icon-trash\" data-toggle=\"tooltip\" title=\"Delete\"></span></li>");
+
+      newLayerDep.data('layer-id', currentLayerDepSelection.id);
+      newLayerDep.children("span").tooltip();
+
+      var link = newLayerDep.children("a");
+      link.attr("href", ctx.layerDetailsUrl+String(currentLayerDepSelection.id));
+      link.text(currentLayerDepSelection.name);
+      link.tooltip({title: currentLayerDepSelection.tooltip, placement: "right"});
+
+      /* Connect up the tash icon */
+      var trashItem = newLayerDep.children("span");
+      trashItem.click(layerRemoveClick);
+
+      layerDepsList.append(newLayerDep);
+      /* Clear the current selection */
+      layerDepInput.val("");
+      currentLayerDepSelection = undefined;
+      layerDepBtn.attr("disabled","disabled");
+    });
+  });
+
+  $(".icon-pencil").click(function (){
+    var mParent = $(this).parent("dd");
+    mParent.prev().css("margin-top", "10px");
+    mParent.children("form").slideDown();
+    var currentVal = mParent.children(".current-value");
+    currentVal.hide();
+    /* Set the current value to the input field */
+    mParent.find("textarea,input").val(currentVal.text());
+    /* Hides the "Not set" text */
+    mParent.children(".muted").hide();
+    /* We're editing so hide the delete icon */
+    mParent.children(".delete-current-value").hide();
+    mParent.find(".cancel").show();
+    $(this).hide();
+  });
+
+  $(".delete-current-value").click(function(){
+    var mParent = $(this).parent("dd");
+    mParent.find("input").val("");
+    mParent.find("textarea").val("");
+    mParent.find(".change-btn").click();
+  });
+
+  $(".cancel").click(function(){
+    var mParent = $(this).parents("dd");
+    $(this).hide();
+    mParent.children("form").slideUp(function(){
+      mParent.children(".current-value").show();
+      /* Show the "Not set" text if we ended up with no value */
+      if (!mParent.children(".current-value").html()){
+        mParent.children(".muted").fadeIn();
+        mParent.children(".delete-current-value").hide();
+      } else {
+        mParent.children(".delete-current-value").show();
+      }
+
+      mParent.children(".icon-pencil").show();
+      mParent.prev().css("margin-top", "0px");
+    });
+  });
+
+  $(".build-target-btn").click(function(){
+    /* fire a build */
+    var target = $(this).data('target-name');
+    libtoaster.startABuild(ctx.projectBuildUrl, ctx.projectId, target, null, null);
+    window.location.replace(ctx.projectPageUrl);
+  });
+
+  $(".select-machine-btn").click(function(){
+    var data =  { machineName : $(this).data('machine-name') };
+    libtoaster.editProject(ctx.xhrEditProjectUrl, ctx.projectId, data,
+      function (){
+        window.location.replace(ctx.projectPageUrl);
+    }, null);
+  });
+
+  function defaultAddBtnText(){
+      var text = " Add the "+ctx.layerVersion.name+" layer to your project";
+      addRmLayerBtn.text(text);
+      addRmLayerBtn.prepend("<span class=\"icon-plus\"></span>");
+      addRmLayerBtn.removeClass("btn-danger");
+  }
+
+  $("#details-tab").on('show', function(){
+    if (!ctx.layerVersion.inCurrentPrj)
+      defaultAddBtnText();
+
+    window.location.hash = "details";
+  });
+
+  function targetsTabShow(){
+    if (!ctx.layerVersion.inCurrentPrj){
+      if (ctx.numTargets > 0) {
+        var text = " Add the "+ctx.layerVersion.name+" layer to your project "+
+          "to enable these targets";
+        addRmLayerBtn.text(text);
+        addRmLayerBtn.prepend("<span class=\"icon-plus\"></span>");
+      } else {
+        defaultAddBtnText();
+      }
+    }
+
+    window.location.hash = "targets";
+  }
+
+  $("#targets-tab").on('show', targetsTabShow);
+
+  function machinesTabShow(){
+    if (!ctx.layerVersion.inCurrentPrj) {
+      if (ctx.numMachines > 0){
+        var text = " Add the "+ctx.layerVersion.name+" layer to your project " +
+          "to enable these machines";
+        addRmLayerBtn.text(text);
+        addRmLayerBtn.prepend("<span class=\"icon-plus\"></span>");
+      } else {
+        defaultAddBtnText();
+      }
+    }
+
+    window.location.hash = "machines";
+  }
+
+  $("#machines-tab").on('show', machinesTabShow);
+
+  $(".pagesize").change(function(){
+    var search = libtoaster.parseUrlParams();
+    search.limit = this.value;
+
+    window.location.search = libtoaster.dumpsUrlParams(search);
+  });
+
+  /* Enables the Build target and Select Machine buttons and switches the
+   * add/remove button
+   */
+  function setLayerInCurrentPrj(added, depsList) {
+    ctx.layerVersion.inCurrentPrj = added;
+    var alertMsg = $("#alert-msg");
+    /* Reset alert message */
+    alertMsg.text("");
+
+    if (added){
+      /* enable and switch all the button states */
+      $(".build-target-btn").removeAttr("disabled");
+      $(".select-machine-btn").removeAttr("disabled");
+      addRmLayerBtn.addClass("btn-danger");
+      addRmLayerBtn.data('directive', "remove");
+      addRmLayerBtn.text(" Delete the "+ctx.layerVersion.name+" layer from your project");
+      addRmLayerBtn.prepend("<span class=\"icon-trash\"></span>");
+
+      if (depsList) {
+        alertMsg.append("You have added <strong>"+(depsList.length+1)+"</strong> layers: <span id=\"layer-affected-name\"></span> and its dependencies ");
+
+        /* Build the layer deps list */
+        depsList.map(function(layer, i){
+          var link = $("<a></a>");
+
+          link.attr("href", layer.layerdetailurl);
+          link.text(layer.name);
+          link.tooltip({title: layer.tooltip});
+
+          if (i != 0)
+            alertMsg.append(", ");
+
+          alertMsg.append(link);
+        });
+      } else {
+        alertMsg.append("You have added <strong>1</strong> layer: <span id=\"layer-affected-name\"></span>");
+      }
+    } else {
+      /* disable and switch all the button states */
+      $(".build-target-btn").attr("disabled","disabled");
+      $(".select-machine-btn").attr("disabled", "disabled");
+      addRmLayerBtn.removeClass("btn-danger");
+      addRmLayerBtn.data('directive', "add");
+
+      /* "special" handler so that we get the correct button text which depends
+       * on which tab is currently visible. Unfortunately we can't just call
+       * tab('show') as if it's already visible it doesn't run the event.
+       */
+      switch ($(".nav-pills .active a").prop('id')){
+        case 'machines-tab':
+          machinesTabShow();
+          break;
+        case 'targets-tab':
+          targetsTabShow();
+          break;
+        default:
+          defaultAddBtnText();
+          break;
+      }
+
+      alertMsg.append("You have deleted <strong>1</strong> layer: <span id=\"layer-affected-name\"></span>");
+    }
+
+    alertMsg.children("#layer-affected-name").text(ctx.layerVersion.name);
+    $("#alert-area").show();
+  }
+
+  /* Add or remove this layer from the project */
+  addRmLayerBtn.click(function() {
+    var directive = $(this).data('directive');
+
+    if (directive == 'add') {
+      /* If adding get the deps for this layer */
+      libtoaster.getLayerDepsForProject(ctx.xhrDataTypeaheadUrl, ctx.projectId, ctx.layerVersion.id, function (data) {
+        /* got result for dependencies */
+        if (data.list.length == 0){
+          var editData = { layerAdd : ctx.layerVersion.id };
+          libtoaster.editProject(ctx.xhrEditProjectUrl, ctx.projectId, editData,
+            function() {
+              setLayerInCurrentPrj(true);
+          });
+          return;
+        } else {
+          /* The add deps will include this layer so no need to add it
+           * separately.
+           */
+          show_layer_deps_modal(ctx.projectId, ctx.layerVersion, data.list, null, null, true, function () {
+            /* Success add deps and layer */
+            setLayerInCurrentPrj(true, data.list);
+          });
+        }
+      }, null);
+    } else if (directive == 'remove') {
+      var editData = { layerDel : ctx.layerVersion.id };
+
+      libtoaster.editProject(ctx.xhrEditProjectUrl, ctx.projectId, editData,
+        function () {
+          /* Success removed layer */
+           //window.location.reload();
+           setLayerInCurrentPrj(false);
+        }, function () {
+          console.warn ("Removing layer from project failed");
+      });
+    }
+  });
+
+  /* Handler for all of the Change buttons */
+  $(".change-btn").click(function(){
+    var mParent = $(this).parent();
+    var prop = $(this).data('layer-prop');
+
+    /* We have inputs, select and textareas to potentially grab the value
+     * from.
+     */
+    var entryElement = mParent.find("input");
+    if (entryElement.length == 0)
+      entryElement = mParent.find("textarea");
+    if (entryElement.length == 0)
+      entryElement = mParent.find("select");
+    if (entryElement.length == 0) {
+      console.warn("Could not find element to get data from for this change");
+      return;
+    }
+
+    var data = { layer_version_id: ctx.layerVersion.id };
+    data[prop] = entryElement.val();
+
+    $.ajax({
+        type: "POST",
+        url: ctx.xhrUpdateLayerUrl,
+        data: data,
+        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+        success: function (data) {
+          if (data.error != "ok") {
+            console.warn(data.error);
+          } else {
+            /* success layer property changed */
+            var inputArea = mParent.parents("dd");
+            var text;
+            /* We don't actually want the value from the select option we want
+             * the text that represents the value to display
+             */
+            text = entryElement.children("option:selected").text();
+            if (!text)
+              text = entryElement.val();
+
+            /* Hide the "Not set" text if it's visible */
+            inputArea.find(".muted").hide();
+            inputArea.find(".current-value").text(text);
+            /* Same behaviour as cancel in that we hide the form/show current
+             * value.
+             */
+            inputArea.find(".cancel").click();
+          }
+        },
+        error: function (data) {
+          console.warn("Call failed");
+          console.warn(data);
+        }
+    });
+  });
+
+  /* Disable the change button when we have no data in the input */
+  $("dl input, dl textarea").keyup(function() {
+    if ($(this).val().length == 0)
+      $(this).parent().children(".change-btn").attr("disabled", "disabled");
+    else
+      $(this).parent().children(".change-btn").removeAttr("disabled");
+  });
+
+  /* This checks to see if the dt's dd has data in it or if the change data
+   * form is visible, otherwise hide it
+   */
+  $("dl").children().each(function (){
+    if ($(this).is("dt")) {
+      var dd = $(this).next("dd");
+      if (!dd.children("form:visible")|| !dd.find(".current-value").html()){
+        if (ctx.layerVersion.sourceId == 3){
+        /* There's no current value and the layer is editable
+         * so show the "Not set" and hide the delete icon
+         */
+        dd.find(".muted").show();
+        dd.find(".delete-current-value").hide();
+        } else {
+          /* We're not viewing an editable layer so hide the empty dd/dl pair */
+          $(this).hide();
+          dd.hide();
+        }
+      }
+    }
+  });
+
+  /* Clear the current search selection and reload the results */
+  $("#target-search-clear").click(function(){
+    $("#target-search").val("");
+    $(this).parents("form").submit();
+  });
+
+  $("#machine-search-clear").click(function(){
+    $("#machine-search").val("");
+    $(this).parents("form").submit();
+  });
+
+
+  layerDepsList.find(".icon-trash").click(layerRemoveClick);
+  layerDepsList.find("a").tooltip();
+  $(".icon-trash").tooltip();
+  $(".commit").tooltip();
+
+}
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index a2a0abd..04264cd 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -161,6 +161,39 @@ var libtoaster = (function (){
     });
   };
 
+  /* parses the query string of the current window.location to an object */
+  function _parseUrlParams() {
+    string = window.location.search
+    string = string.substr(1);
+    stringArray = string.split ("&");
+    obj = {};
+
+    for (i in stringArray) {
+      keyVal = stringArray[i].split ("=");
+      obj[keyVal[0]] = keyVal[1];
+    }
+
+    return obj;
+  };
+
+  /* takes a flat object and outputs it as a query string
+   * e.g. the output of dumpsUrlParams
+   */
+  function _dumpsUrlParams(obj) {
+    var str = "?";
+
+    for (key in obj){
+      if (!obj[key])
+        continue;
+
+      str += key+ "="+obj[key].toString();
+      str += "&";
+    }
+
+    return str;
+  };
+
+
   return {
     reload_params : reload_params,
     startABuild : _startABuild,
@@ -169,6 +202,8 @@ var libtoaster = (function (){
     getLayerDepsForProject : _getLayerDepsForProject,
     editProject : _editProject,
     debug: false,
+    parseUrlParams : _parseUrlParams,
+    dumpsUrlParams : _dumpsUrlParams,
   }
 })();
 
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 78dc54b..c69f9e9 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -1,159 +1,505 @@
 {% extends "baseprojectpage.html" %}
 {% load projecttags %}
 {% load humanize %}
-
+{% load static %}
 {% block localbreadcrumb %}
-<li>Layer Details</li>
+<li><a href="{% url 'layers' %}">All Layers</a></li>
+<li>
+  {{layerversion.layer.name}} ({{layerversion.commit|truncatechars:13}})
+</li>
 {% endblock %}
-
 {% block projectinfomain %}
-<div class="page-header">
-    <h1>Layer Details</h1>
-</div>
-
- <div class="row-fluid span7 tabbable">
-       <ul class="nav nav-pills">
-       <li class="active">
-           <a data-toggle="tab" href="#information">Layer details</a>
-       </li>
-       <li>
-           <a data-toggle="tab" href="#targets">Targets (0)</a>
-       </li>
-       <li>
-           <a data-toggle="tab" href="#machines">Machines (0)</a>
-       </li>
-       <li>
-           <a data-toggle="tab" href="#classes">Classes (0)</a>
-       </li>
-       <li>
-           <a data-toggle="tab" href="#bbappends">bbappends (0)</a>
-       </li>
-       </ul>
-       <div class="tab-content">
-               <div name="information" id="information" class="tab-pane active">
-        <dl class="dl-horizontal">
-        <dt class="">
-            <i class="icon-question-sign get-help" title="Fetch/clone URL of the repository"></i>
-            Repository URL
-        </dt>
-        <dd>
-            <form id="change-repo-form" class="control-group">
-            <div class="input-append">
-            <input type="text" class="input-xlarge" id="type-repo" value="{{layerversion.layer.vcs_url}}">
-            <button id="apply-change-repo" class="btn" type="button">Change</button>
-            <!--a href="#" id="cancel-change-repo" class="btn btn-link">Cancel</a-->
-            </div>
-            <span class="help-block">Cloning this Git repository failed</span>
-            </form>
-        </dd>
-        <dt>
-            <i class="icon-question-sign get-help" title="Subdirectory within the repository where the layer is located, if not in the root (usually only used if the repository contains more than one layer)"></i>
-            Repository subdirectory
-        </dt>
-        <dd>
-            <span id="subdir">{{layerversion.dirpath}}</span>
-            <i id="change-subdir" class="icon-pencil"></i>
-            <i id="delete-subdir" class="icon-trash"></i>
-            <form id="change-subdir-form" style="display:none;">
-            <div class="input-append">
-            <input type="text" id="type-subdir" value="meta-acer">
-            <button id="apply-change-subdir" class="btn" type="button">Change</button>
-            <a href="#" id="cancel-change-subdir" class="btn btn-link">Cancel</a>
-            </div>
-            </form>
-        </dd>
-        <dt>Brach, tag or commit</dt>
-        <dd>
-            {{layerversion.up_branch.name}}
-            <i class="icon-pencil"></i>
-        </dd>
-        <dt>
-            <i class="icon-question-sign get-help" title="The Yocto Project versions with which this layer is compatible. Currently Toaster supports Yocto Project 1.6 and 1.7"></i>
-            Yocto Project compatibility
-        </dt>
-        <dd>
-            <i class="icon-pencil"></i>
-        </dd>
-        <dt>
-            <i class="icon-question-sign get-help" title="Other layers this layer depends upon"></i>
-            Layer dependencies
-        </dt>
-        <dd>
-            <ul class="unstyled">
-            {% for ld in layer.dependencies.all %}
-            <li>
-                <a href="#">openembedded core (meta)</a>
-                <i class="icon-trash"></i>
-            </li>
-            {% endfor %}
-            </ul>
-            <div class="input-append">
-            <input type="text" autocomplete="off" data-minLength="1" data-autocomplete="off"
-            data-provide="typeahead"  data-source='
-            '
-            placeholder="Type a layer name" id="layer-dependency">
-            <a class="btn" type="button" id="add-layer-dependency" disabled>
-            Add layer
-            </a>
-            </div>
-            <span class="help-block">You can only add layers Toaster knows about</span>
-        </dd>
-        </dl>
-        </div>
-        <div name="targets" id="targets" class="tab-pane">
-        <div class="alert alert-info">
-        <strong>There is no target data for {{layerversion.layer.name}} ... yet</strong> <br />
-        Toaster learns about layers as they are built. Once you have used {{layerversion.layer.name}} in a build, Toaster will show you
-        here the targets it provides.
-        </div>
-        </div>
-        <div name="machines" id="machines" class="tab-pane">
-        <div class="alert alert-info">
-        <strong>There is no machine data for {{layerversion.layer.name}} ... yet</strong> <br />
-        Toaster learns about layers as they are built. Once you have used {{layerversion.layer.name}} in a build, Toaster will show you
-        here the machines it provides.
-        </div>
-        </div>
+
+
+<script src="{% static 'js/layerdetails.js' %}"></script>
+<script>
+
+  $(document).ready(function (){
+    var ctx = {
+      projectBuildUrl : "{% url 'xhr_build' %}",
+      layerDetailsUrl : "{% url 'layerdetails' %}",
+      projectPageUrl : "{% url 'project' project.id %}",
+      xhrEditProjectUrl : "{% url 'xhr_projectedit' project.id %}",
+      xhrDataTypeaheadUrl : "{% url 'xhr_datatypeahead' %}",
+      xhrUpdateLayerUrl : "{% url 'xhr_updatelayer' %}",
+      projectId : {{project.id}},
+      numTargets : {{total_targets}},
+      numMachines: {{machines|length}},
+      layerVersion : {
+        name : "{{layerversion.layer.name}}",
+        id : {{layerversion.id}},
+        commit: "{{layerversion.commit}}",
+        inCurrentPrj : {{layer_in_project}},
+        url : "{% url 'layerdetails' layerversion.id  %}",
+        sourceId: {{layerversion.layer_source_id}},
+      }
+    };
+
+    try {
+      layerDetailsPageInit(ctx);
+    } catch (e) {
+      document.write("Sorry, An error has occurred loading this page");
+      console.warn(e);
+    }
+  });
+</script>
+
+{# If this is not an imported layer then hide the edit ui #}
+{% if layerversion.layer_source_id != 3 %}
+<style>
+ .icon-pencil {
+   display:none;
+ }
+.delete-current-value{
+  display: none;
+}
+ li .icon-trash {
+   display:none;
+ }
+ .add-deps {
+   display:none;
+ }
+</style>
+{% endif %}
+
+{% include "layers_dep_modal.html" %}
+ <div class="container-fluid top-padded">
+  <div class="row-fluid">
+    <div class="span11">
+      <div class="page-header">
+        <h1>{{layerversion.layer.name}} <small class="commit" data-toggle="tooltip" title="{{layerversion.commit}}">({{layerversion.commit|truncatechars:13}})</small></h1>
+      </div>
     </div>
-</div>
-<div class="row span4 well">
-<h2>About {{layerversion.layer.name}}</h2>
-<dl>
-
-    <dt>
-    Summary
-    <i class="icon-question-sign get-help" title="One-line description of the layer"></i>
-    </dt>
-    <dd>
-    <span >{{layerversion.layer.summary}}</span>
-    <i class="icon-pencil"></i>
-    </dd>
-    <!--form>
-    <textarea class="span12" rows="2"></textarea>
-    <button class="btn" type="button">Change</button>
-    <a href="#" class="btn btn-link">Cancel</a>
-    </form-->
-    <dt>
-    Description
-    </dt>
-    <dd>
-    <span >{{layerversion.layer.description}}</span>
-    <i class="icon-pencil"></i>
-    </dd>
-    <!--form>
-    <textarea class="span12" rows="6"></textarea>
-    <button class="btn" type="button">Change</button>
-    <a href="#" class="btn btn-link">Cancel</a>
-    </form-->
-    <dt>
-    Maintainer(s)
-    </dt>
-    <dd>
-    <span class="muted">Not set</span>
-    <i class="icon-pencil"></i>
-    </dd>
-</dl>
-</div>
+  </div>
+
+    <div class="row-fluid">
+    <div class="span7">
+      <div class="tabbable">
+        <div class="alert alert-info lead" id="alert-area" style="display:none">
+          <button type="button" class="close" id="dismiss-alert" data-dismiss="alert">&times;</button>
+          <span id="alert-msg"></span>
+          <p style="margin-top:10px;"><a href="{% url 'project' project.id %}">Go to project configuration</a></p>
+        </div>
+        <ul class="nav nav-pills">
+          <li class="active">
+            <a data-toggle="tab" href="#information" id="details-tab">Layer details</a>
+          </li>
+          <li>
+            <a data-toggle="tab" href="#targets" id="targets-tab">Targets ({{total_targets}})</a>
+          </li>
+          <li>
+            <a data-toggle="tab" href="#machines" id="machines-tab">Machines ({{total_machines}})</a>
+          </li>
+        </ul>
+      </div>
+      <div class="tab-content">
+        <span class="button-place">
+          {% if layer_in_project == 0 %}
+          <button id="add-remove-layer-btn" data-directive="add" class="btn btn-large btn-block">
+            <span class="icon-plus"></span>
+            Add the {{layerversion.layer.name}} layer to your project
+          </button>
+          {% else %}
+          <button id="add-remove-layer-btn" data-directive="remove" class="btn btn-block btn-large btn-danger">
+            <span class="icon-trash"></span>
+            Delete the {{layerversion.layer.name}} layer from your project
+          </button>
+          {% endif %}
+        </span>
+
+        <!-- layer details pane -->
+        <div name="information" id="information" class="tab-pane active">
+          <dl class="dl-horizontal">
+            <dt class="">
+              <i class="icon-question-sign get-help" title="Fetch/clone URL of the repository"></i>
+              Repository URL
+            </dt>
+            <dd>
+              <span class="current-value">{{layerversion.layer.vcs_url}}</span>
+              {% if layerversion.get_vcs_link_url %}
+                <a href="{{layerversion.get_vcs_link_url}}/" class="icon-share get-info"></a>
+              {% endif %}
+              <form id="change-repo-form" class="control-group" style="display:none">
+                <div class="input-append">
+                  <input type="text" class="input-xlarge" value="{{layerversion.layer.vcs_url}}">
+                    <button data-layer-prop="vcs_url" class="btn change-btn" type="button">Save</button>
+                    <a href="#" style="display:none" class="btn btn-link cancel">Cancel</a>
+                  </div>
+                </form>
+                <i class="icon-pencil" ></i>
+              </dd>
+              <dt>
+                <i class="icon-question-sign get-help" title="Subdirectory within the repository where the layer is located, if not in the root (usually only used if the repository contains more than one layer)"></i>
+                Repository subdirectory
+              </dt>
+              <dd>
+                <span class="muted" style="display:none">Not set</span>
+                <span class="current-value">{{layerversion.dirpath}}</span>
+                {% if layerversion.get_vcs_dirpath_link_url %}
+                  <a href="{{layerversion.get_vcs_dirpath_link_url}}" class="icon-share get-info"></a>
+                {% endif %}
+                <form id="change-subdir-form" style="display:none;">
+                  <div class="input-append">
+                    <input type="text" value="{{layerversion.dirpath}}">
+                      <button data-layer-prop="dirpath" class="btn change-btn" type="button">Save</button>
+                      <a href="#" style="display:none" class="btn btn-link cancel">Cancel</a>
+                    </div>
+                  </form>
+                  <i id="change-subdir" class="icon-pencil"></i>
+                  <span class="icon-trash delete-current-value" data-toggle="tooltip" title="Delete"></span>
+                </dd>
+                <dt>Brach, tag or commit</dt>
+                <dd>
+                  <span class="current-value">{{layerversion.commit}}</span>
+                  <form style="display:none;">
+                    <div class="input-append">
+                      <input type="text" value="{{layerversion.commit}}">
+                        <button  data-layer-prop="commit" class="btn change-btn" type="button">Save</button>
+                        <a href="#" style="display:none" class="btn btn-link cancel">Cancel</a>
+                      </div>
+                    </form>
+                    <i class="icon-pencil"></i>
+                  </dd>
+                  <dt>
+                    <i class="icon-question-sign get-help" title="The Yocto Project versions with which this layer is compatible. Currently Toaster supports Yocto Project 1.6 and 1.7"></i>
+                    Yocto Project compatibility
+                  </dt>
+                  <dd>
+                    <span class="current-value">{{layerversion.up_branch.name}}</span>
+                    <form style="display:none">
+                      <div class="input-append">
+                        <select name="projectversion" id="projectversion">
+                          {% for compat in yocto_compat %}
+                          <option value="{{compat.id}}" {%if layerversion.up_branch.id == compat.id %} selected{%endif%}>{{compat.name}}</option>
+                          {% endfor %}
+                        </select>
+                        <button  data-layer-prop="up_branch" class="btn change-btn" type="button">Save</button>
+                        <a href="#" style="display:none" class="btn btn-link cancel">Cancel</a>
+                      </div>
+                    </form>
+                    <i class="icon-pencil"></i>
+                  </dd>
+                  <dt>
+                    <i class="icon-question-sign get-help" title="Other layers this layer depends upon"></i>
+                    Layer dependencies
+                  </dt>
+                  <dd>
+                    <ul class="unstyled" id="layer-deps-list">
+                      {% for ld in layerversion.dependencies.all %}
+                      <span class="current-value">
+                      <li data-layer-id="{{ld.depends_on.id}}">
+                        <!-- TODO use ld.depends_on.get_vcs_reference instead of commit -->
+                        <a data-toggle="tooltip" title="{{ld.depends_on.layer.vcs_url}} | {{ld.depends_on.commit}}" href="{% url 'layerdetails' ld.depends_on.id %}">{{ld.depends_on.layer.name}}</a>
+                        <span class="icon-trash " data-toggle="tooltip" title="Delete"></span>
+                      </li>
+                      </span>
+                      {% endfor %}
+                    </ul>
+                    <div class="input-append add-deps">
+                      <input type="text" autocomplete="off" data-minLength="1" data-autocomplete="off"  placeholder="Type a layer name" id="layer-dep-input">
+                        <a class="btn" type="button" id="add-layer-dependency-btn" disabled>
+                          Add layer
+                        </a>
+                      </div>
+                      <span class="help-block add-deps">You can only add layers Toaster knows about</span>
+                    </dd>
+                  </dl>
+                </div>
+                <!-- targets tab -->
+                <div name="targets" id="targets" class="tab-pane">
+                  {% if total_targets == 0 %}
+                  <div class="alert alert-info">
+                    <strong>There is no target data for {{layerversion.layer.name}} ... yet</strong> <br />
+                    Toaster learns about layers as they are built. Once you have used {{layerversion.layer.name}} in a build, Toaster will show you
+                    here the targets it provides.
+                  </div>
+                  {% else %}
+
+                  <div class="row-fluid">
+
+                  {% if targets.paginator.count == 0 %}
+                  <div class="alert">
+                    <h3>No targets found</h3>
+                  {% endif %}
+
+                {# only show the search form if we have more than 10 results #}
+                  {% if targets.paginator.count > 10 or request.GET.targets_search %}
+                    {% if targets.paginator.count == 0 %}
+                      <form class="input-append">
+                    {% else %}
+                      <form class="navbar-search input-append pull-left">
+                    {% endif %}
+
+                      <input type="text" id="target-search" name="targets_search" placeholder="Search targets" class="input-xlarge" value="{{request.GET.targets_search}}">
+                        {% if request.GET.targets_search %}
+                        <a class="add-on btn" id="target-search-clear">
+                          <i class="icon-remove"></i>
+                        </a>
+                        {% endif %}
+                        <button type="submit" class="btn">Search</button>
+                      </form>
+                    {% endif %}
+
+                    {% if targets.paginator.count == 0 %}
+                      <!-- end alert -->
+                     </div>
+                     <!-- end row-fluid -->
+                     </div>
+                    {% else %}
+
+                    <div class="pull-right">
+                      <span class="help-inline" style="padding-top:5px;">Show rows:</span>
+                      <select style="margin-top:5px;margin-bottom:0px;" class="pagesize">
+                        {% with "10 25 50 100 150" as list%}
+                        {% for i in list.split %}
+                        {% if request.session.limit == i %}
+                        <option value="{{i}}" selected>{{i}}</option>
+                        {% else %}
+                        <option value="{{i}}">{{i}}</option>
+                        {% endif %}
+                        {% endfor %}
+                      {% endwith %}
+                    </select>
+                  </div>
+                </div>
+
+                <table class="table table-bordered table-hover">
+                  <thead>
+                    <tr>
+                      <th>
+                          <i class="icon-question-sign get-help" title="Information about a single piece of software, including where to download the source, configuration options, how to compile the source files and how to package the compiled output"></i>
+                          Target
+                          {% if request.GET.targets_search %}
+                            <span class="badge badge-info">{{targets.paginator.count}}</span>
+                          {% endif %}
+                        </th>
+                        <th>
+                          <i class="icon-question-sign get-help" title="The recipe version and revision"></i>
+                          Target version
+                        </th>
+                        <th class="span4">Description</th>
+                        <th>Build target</th>
+                      </tr>
+                    </thead>
+                    <tbody>
+                      {% for target in targets %}
+                      <tr>
+                        <td>
+                          {{target.name}}
+                          {% if target.up_id %}
+                          <a href="http://layers.openembedded.org/layerindex/recipe/{{target.up_id}}/" class="icon-share get-info"></a>
+                          {% endif %}
+                        </td>
+                        <td>{{target.version}}</td>
+                        <td>{{target.summary}}</td>
+                        <td><button class="btn btn-block build-target-btn" data-target-name="{{target.name}}" {% if layer_in_project == 0 %}disabled="disabled"{% endif %} >Build Target</button></td>
+                      </tr>
+                      {% endfor %}
+                    </tbody>
+                  </table>
+
+                  <!-- Show pagination controls -->
+                  <div class="pagination">
+                    <ul>
+                      {%if targets.has_previous %}
+                      <li><a href="?tpage={{targets.previous_page_number}}{{request.GET.limit}}#targets">&laquo;</a></li>
+                      {%else%}
+                      <li class="disabled"><a href="#">&laquo;</a></li>
+                      {%endif%}
+                      {% for i in targets.paginator.page_range %}
+                      <li {%if i == targets.number %} class="active" {%endif%}><a href="?tpage={{i}}#targets">{{i}}</a></li>
+                      {% endfor %}
+                      {%if targets.has_next%}
+                      <li><a href="?tpage={{targets.next_page_number}}#targets">&raquo;</a></li>
+                      {%else%}
+                      <li class="disabled"><a href="#">&raquo;</a></li>
+                      {%endif%}
+                    </ul>
+                    <div class="pull-right">
+                      <span class="help-inline" style="padding-top:5px;">Show rows:</span>
+                      <select style="margin-top:5px;margin-bottom:0px;" class="pagesize">
+                        {% with "10 25 50 100 150" as list%}
+                        {% for i in list.split %}
+                        {% if request.session.limit == i %}
+                        <option value="{{i}}" selected>{{i}}</option>
+                        {% else %}
+                        <option value="{{i}}">{{i}}</option>
+                        {% endif %}
+                        {% endfor %}
+                        {% endwith %}
+                      </select>
+                    </div>
+                  </div>
+                  {% endif %}
+                  {% endif %}
+                </div>
+
+
+                <div name="machines" id="machines" class="tab-pane">
+                  {% if total_machines == 0 %}
+                  <div class="alert alert-info">
+                    <strong>There is no machine data for {{layerversion.layer.name}} ... yet</strong> <br />
+                    Toaster learns about layers as they are built. Once you have used {{layerversion.layer.name}} in a build, Toaster will show you
+                    here the machines it provides.
+                  </div>
+                  {% else %}
+
+                  <div class="row-fluid">
+
+                  {% if machines.paginator.count == 0 %}
+                  <div class="alert">
+                    <h3>No machines found</h3>
+                  {% endif %}
+
+                {# only show the search form if we have more than 10 results #}
+                  {% if machines.paginator.count > 10 or request.GET.machines_search %}
+                    {% if machines.paginator.count == 0 %}
+                      <form class="input-append">
+                    {% else %}
+                      <form class="navbar-search input-append pull-left">
+                    {% endif %}
+
+                      <input type="text" id="machine-search" name="machines_search" placeholder="Search machines" class="input-xlarge" value="{{request.GET.machines_search}}">
+                        {% if request.GET.machines_search %}
+                        <a class="add-on btn" id="machine-search-clear">
+                          <i class="icon-remove"></i>
+                        </a>
+                        {% endif %}
+                        <button type="submit" class="btn">Search</button>
+                      </form>
+                    {% endif %}
+
+                    {% if machines.paginator.count == 0 %}
+                      <!-- end alert -->
+                     </div>
+                     <!-- end row-fluid -->
+                     </div>
+                    {% else %}
+
+                    <div class="pull-right">
+                      <span class="help-inline" style="padding-top:5px;">Show rows:</span>
+                      <select style="margin-top:5px;margin-bottom:0px;" class="pagesize">
+                        {% with "10 25 50 100 150" as list%}
+                        {% for i in list.split %}
+                        {% if request.session.limit == i %}
+                        <option value="{{i}}" selected>{{i}}</option>
+                        {% else %}
+                        <option value="{{i}}">{{i}}</option>
+                        {% endif %}
+                        {% endfor %}
+                      {% endwith %}
+                    </select>
+                  </div>
+                </div>
+
+                <table class="table table-bordered table-hover">
+                  <thead>
+                      <tr>
+                        <th>
+                          <i class="icon-question-sign get-help" title="The machine is the hardware for which you are building"></i>
+                          Machine
+                          {% if request.GET.machines_search %}
+                          <span class="badge badge-info">{{machines.paginator.count}}</span>
+                          {% endif %}
+                        </th>
+                        <th>Description</th>
+                        <th>Select machine</th>
+                      </tr>
+                    </thead>
+                    <tbody>
+                      {% for machine in machines %}
+                      <tr>
+                        <td>{{machine.name}}</td>
+                        <td>{{machine.description}}</td>
+                        <td><button class="btn btn-block select-machine-btn" data-machine-name="{{machine.name}}" {% if layer_in_project == 0 %}disabled="disabled"{% endif %}}>Select machine</button></td>
+                      </tr>
+                      {% endfor %}
+                    </tbody>
+                  </table>
+
+                  <!-- Show pagination controls -->
+                  <div class="pagination">
+                    <ul>
+                      {%if machines.has_previous %}
+                      <li><a href="?mpage={{machines.previous_page_number}}{{request.GET.limit}}#machines">&laquo;</a></li>
+                      {%else%}
+                      <li class="disabled"><a href="#">&laquo;</a></li>
+                      {%endif%}
+                      {% for i in machines.paginator.page_range %}
+                      <li {%if i == machines.number %} class="active" {%endif%}><a href="?mpage={{i}}#machines">{{i}}</a></li>
+                      {% endfor %}
+                      {%if machines.has_next%}
+                      <li><a href="?mpage={{machines.next_page_number}}#machines">&raquo;</a></li>
+                      {%else%}
+                      <li class="disabled"><a href="#">&raquo;</a></li>
+                      {%endif%}
+                    </ul>
+                    <div class="pull-right">
+                      <span class="help-inline" style="padding-top:5px;">Show rows:</span>
+                      <select style="margin-top:5px;margin-bottom:0px;" class="pagesize">
+                        {% with "10 25 50 100 150" as list%}
+                        {% for i in list.split %}
+                        {% if request.session.limit == i %}
+                        <option value="{{i}}" selected>{{i}}</option>
+                        {% else %}
+                        <option value="{{i}}">{{i}}</option>
+                        {% endif %}
+                        {% endfor %}
+                        {% endwith %}
+                      </select>
+                    </div>
+                  </div>
+                  {% endif %}
+                  {% endif %}
+                  </div>
+              </div>
+            </div>
+            <div class="row span4 well">
+              <h2>About {{layerversion.layer.name}}</h2>
+              <dl>
+
+                <dt>
+                  Summary
+                  <i class="icon-question-sign get-help" title="One-line description of the layer"></i>
+                </dt>
+                <dd>
+                  <span class="muted" style="display:none">Not set</span>
+                  <span class="current-value">{{layerversion.layer.summary}}</span>
+                  <form style="display:none; margin-bottom:20px">
+                    <textarea class="span12" rows="2">{% if layerversion.layer.summary %}{{layerversion.layer.summary}}{% endif %}</textarea>
+                    <button class="btn change-btn" data-layer-prop="summary" type="button">Save</button>
+                    <a href="#" class="btn btn-link cancel">Cancel</a>
+                  </form>
+                  <i class="icon-pencil"></i>
+                  <span class="icon-trash delete-current-value" data-toggle="tooltip" title="Delete"></span>
+                </dd>
+                <dt>
+                  Description
+                </dt>
+                <dd>
+                  <span class="muted" style="display:none">Not set</span>
+                  <span class="current-value">{{layerversion.layer.description}}</span>
+                  <form style="display:none; margin-bottom:20px">
+                    <textarea class="span12" rows="6">{% if layerversion.layer.description %}{{layerversion.layer.description}}{% endif %}</textarea>
+                    <button class="btn change-btn" data-layer-prop="description" type="button" >Save</button>
+                    <a href="#" class="btn btn-link cancel">Cancel</a>
+                  </form>
+                  <i class="icon-pencil"></i>
+                  <span class="icon-trash delete-current-value" data-toggle="tooltip" title="Delete"></span>
+                </dd>
+                </dd>
+                {% if layerversion.layer.up_id %}
+                <dt>Layer index</dt>
+                <dd>
+                  <a href="http://layers.openembedded.org/layerindex/branch/{{layerversion.up_branch.name}}/layer/{{layerversion.layer.name}}"/>layer index link</a>
+
+                </dd>
+                {% endif %}
 
+           </dl>
+         </div>
 
+          </div>
+       </div>
+   </div>
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/layers_dep_modal.html b/lib/toaster/toastergui/templates/layers_dep_modal.html
index b03fd0b..8222027 100644
--- a/lib/toaster/toastergui/templates/layers_dep_modal.html
+++ b/lib/toaster/toastergui/templates/layers_dep_modal.html
@@ -18,7 +18,16 @@
     </div>
 
 <script>
+  /* projectId: current project
+   * layer: Object representing the parent layer { id: .. name: ... url }
+   * dependencies: array of dependency layer objects { id: .. name: ..}
+   * title: optional override for title
+   * body: optional override for body
+   * addToProject: Whether to add layers to project on accept
+   * successAdd: function to run on success
+   */
 function show_layer_deps_modal(projectId, layer, dependencies, title, body, addToProject, successAdd) {
+
     // update layer name
     if (title) {
       $('#dependencies_modal #title').text(title);
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 6e1b0ab..5c969f8 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -94,6 +94,7 @@ urlpatterns = patterns('toastergui.views',
 
         url(r'^xhr_datatypeahead/$', 'xhr_datatypeahead', name='xhr_datatypeahead'),
         url(r'^xhr_importlayer/$', 'xhr_importlayer', name='xhr_importlayer'),
+        url(r'^xhr_updatelayer/$', 'xhr_updatelayer', name='xhr_updatelayer'),
 
 
         # default redirection
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 8c21ca4..7a9d662 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2336,6 +2336,50 @@ if toastermain.settings.MANAGED:
 
         return HttpResponse(jsonfilter({"error": "ok", "imported_layer" : { "name" : layer.name, "id": layer_version.id },  "deps_added": layers_added }), content_type = "application/json")
 
+    def xhr_updatelayer(request):
+
+        def error_response(error):
+            return HttpResponse(jsonfilter({"error": error}), content_type = "application/json")
+
+        if not request.POST.has_key("layer_version_id"):
+            return error_response("Please specify a layer version id")
+        try:
+            layer_version_id = request.POST["layer_version_id"]
+            layer_version = Layer_Version.objects.get(id=layer_version_id)
+        except:
+            return error_response("Cannot find layer to update")
+
+
+        if request.POST.has_key("vcs_url"):
+            layer_version.layer.vcs_url = request.POST["vcs_url"]
+        if request.POST.has_key("dirpath"):
+            layer_version.dirpath = request.POST["dirpath"]
+        if request.POST.has_key("commit"):
+            layer_version.commit = request.POST["commit"]
+        if request.POST.has_key("up_branch"):
+            layer_version.up_branch_id = int(request.POST["up_branch"])
+
+        if request.POST.has_key("add_dep"):
+            lvd = LayerVersionDependency(layer_version=layer_version, depends_on_id=request.POST["add_dep"])
+            lvd.save()
+
+        if request.POST.has_key("rm_dep"):
+            rm_dep = LayerVersionDependency.objects.get(layer_version=layer_version, depends_on_id=request.POST["rm_dep"])
+            rm_dep.delete()
+
+        if request.POST.has_key("summary"):
+            layer_version.layer.summary = request.POST["summary"]
+        if request.POST.has_key("description"):
+            layer_version.layer.description = request.POST["description"]
+
+        try:
+            layer_version.layer.save()
+            layer_version.save()
+        except:
+            return error_response("Could not update layer version entry")
+
+        return HttpResponse(jsonfilter({"error": "ok",}), content_type = "application/json")
+
 
 
     def importlayer(request):
@@ -2439,8 +2483,53 @@ if toastermain.settings.MANAGED:
 
     def layerdetails(request, layerid):
         template = "layerdetails.html"
+        limit = 10
+
+        if request.GET.has_key("limit"):
+            request.session['limit'] = request.GET['limit']
+
+        if request.session.has_key('limit'):
+            limit = request.session['limit']
+
+        layer_version = Layer_Version.objects.get(pk = layerid)
+
+        # Targets tab query functionality
+        if request.GET.has_key('targets_search'):
+            targets = Paginator(Recipe.objects.filter(layer_version=layer_version,name__icontains=request.GET['targets_search']).order_by("name"), limit)
+        else:
+            targets = Paginator(Recipe.objects.filter(layer_version=layer_version).order_by("name"), limit)
+
+        if request.GET.has_key("tpage"):
+          try:
+              targets = targets.page(request.GET['tpage'])
+          except EmptyPage:
+              targets = targets.page(targets.num_pages)
+        else:
+            targets = targets.page(1)
+
+        # Machines tab query functionality
+        if request.GET.has_key('machines_search'):
+          machines = Paginator(Machine.objects.filter(layer_version=layer_version,name__icontains=request.GET['machines_search']).order_by("name"), limit)
+        else:
+          machines = Paginator(Machine.objects.filter(layer_version=layer_version).order_by("name"), limit)
+
+        if request.GET.has_key("mpage"):
+          try:
+            machines = machines.page(request.GET['mpage'])
+          except EmptyPage:
+            machines = machines.page(machines.num_pages)
+        else:
+            machines = machines.page(1)
+
         context = {
-            'layerversion': Layer_Version.objects.get(pk = layerid),
+            'layerversion': layer_version,
+            'layer_in_project' : ProjectLayer.objects.filter(project_id=request.session['project_id'],layercommit=layerid).count(),
+            'yocto_compat': Branch.objects.filter(layer_source=layer_version.layer_source),
+            'machines': machines,
+            'targets': targets,
+            'total_targets': Recipe.objects.filter(layer_version=layer_version).count(),
+
+            'total_machines': Machine.objects.filter(layer_version=layer_version).count(),
         }
         return render(request, template, context)
 
@@ -2972,3 +3061,6 @@ else:
 
     def xhr_importlayer(request):
         raise Exception("page not available in interactive mode")
+
+    def xhr_updatelayer(request):
+        raise Exception("page not available in interactive mode")
-- 
1.9.1


