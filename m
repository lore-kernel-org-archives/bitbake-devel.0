Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
	[209.85.192.173])
	by mail.openembedded.org (Postfix) with ESMTP id 07DD5718EE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 16:27:32 +0000 (UTC)
Received: by mail-pd0-f173.google.com with SMTP id ft15so3350175pdb.32
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 08:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=CilThNzQCK5iS3+wPq1RHj4MGt0iSCGdKHoFgyn7/9U=;
	b=DVoW1DdDnxrInV1w7QpOeFe92eTvmjVKKFVLE6PlP0/a/j8d1FPhvS4jAHcByt4fry
	yTwKhko18HTGuDQVMOvCJmMqj9mZ46caPledUrYXY3Kcvzu+w62W9FOUQqbNuwWr6Rm/
	ONfqbqH07bWTOZhSM7NOjywjJT6+YZDUBpqqIaa+9TsHzXJFzj2kQNMw3nwNOEI9KzJe
	X9MoBcV4+pp0+NdmvCvd8Dk1zMQocRfeEG729Bt9dvI6crA3QR+lfCqfNNEMcwqbF+2f
	gRUGBjB6puVkrpyahBCcSkggNMTn9BnLfrpGiEgTuHgOjzDAXagiM86r9oEHUU2Dl1ta
	OAlg==
X-Gm-Message-State: ALoCoQlgg8gWhKb2tlhRgkUiEsTrAnatpiT4tEzCUgidxfYPeZstdQjaBTJYQO9C637T7Szq6v8C
X-Received: by 10.70.26.35 with SMTP id i3mr58186752pdg.84.1416500853297;
	Thu, 20 Nov 2014 08:27:33 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	gz10sm2503169pac.23.2014.11.20.08.27.31 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 20 Nov 2014 08:27:32 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 7EE97564130; Thu, 20 Nov 2014 16:27:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Nov 2014 16:27:20 +0000
Message-Id: <cdf6178ae3675b40afca9f08d491ca1b7e45914e.1416500715.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
References: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1416500715.git.alexandru.damian@intel.com>
References: <cover.1416500715.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 04/11] toaster: Create libtoaster.js with some utility functions
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
X-List-Received-Date: Thu, 20 Nov 2014 16:27:34 -0000

From: Michael Wood <michael.g.wood@intel.com>

Replace main.js with libtoaster. This can be a place for common
functionality for toaster. Calling it lib... makes it more obvious as
well as helps with code readability due to the namespacing.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js | 237 +++++++++++++++++++++++++
 lib/toaster/toastergui/static/js/main.js       | 111 ------------
 lib/toaster/toastergui/templates/base.html     |  29 +--
 3 files changed, 239 insertions(+), 138 deletions(-)
 create mode 100644 lib/toaster/toastergui/static/js/libtoaster.js
 delete mode 100644 lib/toaster/toastergui/static/js/main.js

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
new file mode 100644
index 0000000..b899b8d
--- /dev/null
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -0,0 +1,237 @@
+
+/* All shared functionality to go in libtoaster object.
+ * This object really just helps readability since we can then have
+ * a traceable namespace.
+ */
+var libtoaster = (function (){
+
+  /* makeTypeahead parameters
+   * elementSelector: JQuery elementSelector string
+   * xhrUrl: the url to get the JSON from expects JSON in the form:
+   *  { "list": [ { "name": "test", "detail" : "a test thing"  }, .... ] }
+   * xhrParams: the data/parameters to pass to the getJSON url e.g.
+   *  { 'type' : 'projects' } the text typed will be passed as 'value'.
+   *  selectedCB: function to call once an item has been selected one
+   *  arg of the item.
+   */
+  function _makeTypeahead (jQElement, xhrUrl, xhrParams, selectedCB) {
+
+    jQElement.typeahead({
+        source: function(query, process){
+          xhrParams.value = query;
+          $.getJSON(xhrUrl, this.options.xhrParams, function(data){
+            return process (data.list);
+          });
+        },
+        updater: function(item) {
+          var itemObj = this.$menu.find('.active').data('itemObject');
+          selectedCB(itemObj);
+          return item;
+        },
+        matcher: function(item) {  return ~item.name.toLowerCase().indexOf(this.query.toLowerCase()); },
+        highlighter: function (item) {
+          if (item.hasOwnProperty('detail'))
+            /* Use jquery to escape the value as text into a span */
+            return $('<span></span>').text(item.name+' '+item.detail).get(0);
+          return $('<span></span>').text(item.name).get(0);
+        },
+        sorter: function (items) { return items; },
+        xhrUrl: xhrUrl,
+        xhrParams: xhrParams,
+    });
+
+
+    /* Copy of bootstrap's render func but sets selectedObject value */
+    function customRenderFunc (items) {
+      var that = this;
+
+      items = $(items).map(function (i, item) {
+        i = $(that.options.item).attr('data-value', item.name).data('itemObject', item);
+        i.find('a').html(that.highlighter(item));
+        return i[0];
+      });
+
+      items.first().addClass('active');
+      this.$menu.html(items);
+      return this;
+    }
+
+    jQElement.data('typeahead').render = customRenderFunc;
+  };
+
+  /*
+   * url - the url of the xhr build */
+  function _startABuild (url, project_id, targets, onsuccess, onfail) {
+    var data;
+
+    if (project_id)
+      data = 'project_id='+project_id+'&targets='+targets;
+    else
+      data = 'targets='+targets;
+
+    $.ajax( {
+        type: "POST",
+        url: url,
+        data: data,
+        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+        success: function (_data) {
+          if (_data.error != "ok") {
+            console.log(_data.error);
+          } else {
+            if (onsuccess != undefined) onsuccess(_data);
+          }
+        },
+        error: function (_data) {
+          console.log("Call failed");
+          console.log(_data);
+          if (onfail) onfail(data);
+    } });
+  };
+
+  return {
+    reload_params : reload_params,
+    startABuild : _startABuild,
+    makeTypeahead : _makeTypeahead,
+  }
+})();
+
+/* keep this in the global scope for compatability */
+function reload_params(params) {
+    uri = window.location.href;
+    splitlist = uri.split("?");
+    url = splitlist[0], parameters=splitlist[1];
+    // deserialize the call parameters
+    if(parameters){
+        cparams = parameters.split("&");
+    }else{
+        cparams = []
+    }
+    nparams = {}
+    for (i = 0; i < cparams.length; i++) {
+        temp = cparams[i].split("=");
+        nparams[temp[0]] = temp[1];
+    }
+    // update parameter values
+    for (i in params) {
+        nparams[encodeURIComponent(i)] = encodeURIComponent(params[i]);
+    }
+    // serialize the structure
+    callparams = []
+    for (i in nparams) {
+        callparams.push(i+"="+nparams[i]);
+    }
+    window.location.href = url+"?"+callparams.join('&');
+}
+
+
+/* Things that happen for all pages */
+$(document).ready(function() {
+
+    /*
+     * PrettyPrint plugin.
+     *
+     */
+    // Init
+    prettyPrint();
+
+    // Prevent invalid links from jumping page scroll
+    $('a[href=#]').click(function() {
+        return false;
+    });
+
+
+    /* Belen's additions */
+
+    // turn Edit columns dropdown into a multiselect menu
+    $('.dropdown-menu input, .dropdown-menu label').click(function(e) {
+        e.stopPropagation();
+    });
+
+    // enable popovers in any table cells that contain an anchor with the
+    // .btn class applied, and make sure popovers work on click, are mutually
+    // exclusive and they close when your click outside their area
+
+    $('html').click(function(e){
+        $('td > a.btn').popover('hide');
+    });
+
+    $('td > a.btn').popover({
+        html:true,
+        placement:'left',
+        container:'body',
+        trigger:'manual'
+    }).click(function(e){
+        $('td > a.btn').not(this).popover('hide');
+        // ideally we would use 'toggle' here
+        // but it seems buggy in our Bootstrap version
+        $(this).popover('show');
+        e.stopPropagation();
+    });
+
+    // enable tooltips for applied filters
+    $('th a.btn-primary').tooltip({container:'body', html:true, placement:'bottom', delay:{hide:1500}});
+
+    // hide applied filter tooltip when you click on the filter button
+    $('th a.btn-primary').click(function () {
+        $('.tooltip').hide();
+    });
+
+    // enable help information tooltip
+    $(".get-help").tooltip({container:'body', html:true, delay:{show:300}});
+
+    // show help bubble only on hover inside tables
+    $(".hover-help").css("visibility","hidden");
+    $("th, td").hover(function () {
+        $(this).find(".hover-help").css("visibility","visible");
+    });
+    $("th, td").mouseleave(function () {
+        $(this).find(".hover-help").css("visibility","hidden");
+    });
+
+    // show task type and outcome in task details pages
+    $(".task-info").tooltip({ container: 'body', html: true, delay: {show: 200}, placement: 'right' });
+
+    // linking directly to tabs
+    $(function(){
+          var hash = window.location.hash;
+          hash && $('ul.nav a[href="' + hash + '"]').tab('show');
+
+          $('.nav-tabs a').click(function (e) {
+            $(this).tab('show');
+            $('body').scrollTop();
+          });
+    });
+
+    // toggle for long content (variables, python stack trace, etc)
+    $('.full, .full-hide').hide();
+    $('.full-show').click(function(){
+        $('.full').slideDown(function(){
+            $('.full-hide').show();
+        });
+        $(this).hide();
+    });
+    $('.full-hide').click(function(){
+        $(this).hide();
+        $('.full').slideUp(function(){
+            $('.full-show').show();
+        });
+    });
+
+    //toggle the errors and warnings sections
+    $('.show-errors').click(function() {
+        $('#collapse-errors').addClass('in');
+    });
+    $('.toggle-errors').click(function() {
+        $('#collapse-errors').toggleClass('in');
+    });
+    $('.show-warnings').click(function() {
+        $('#collapse-warnings').addClass('in');
+    });
+    $('.toggle-warnings').click(function() {
+        $('#collapse-warnings').toggleClass('in');
+    });
+    //show warnings section when requested from the previous page
+    if (location.href.search('#warnings') > -1) {
+        $('#collapse-warnings').addClass('in');
+    }
+});
diff --git a/lib/toaster/toastergui/static/js/main.js b/lib/toaster/toastergui/static/js/main.js
deleted file mode 100644
index eef6b46..0000000
--- a/lib/toaster/toastergui/static/js/main.js
+++ /dev/null
@@ -1,111 +0,0 @@
-$(document).ready(function() {
-
-    /*
-     * PrettyPrint plugin.
-     *
-     */
-    // Init
-    prettyPrint();
-
-    // Prevent invalid links from jumping page scroll
-    $('a[href=#]').click(function() {
-        return false;
-    });
-
-
-    /* Belen's additions */
-
-	// turn Edit columns dropdown into a multiselect menu
-	$('.dropdown-menu input, .dropdown-menu label').click(function(e) {
-		e.stopPropagation();
-	});
-
-    // enable popovers in any table cells that contain an anchor with the
-    // .btn class applied, and make sure popovers work on click, are mutually
-	// exclusive and they close when your click outside their area
-
-	$('html').click(function(e){
-		$('td > a.btn').popover('hide');
-	});
-
-	$('td > a.btn').popover({
-		html:true,
-		placement:'left',
-		container:'body',
-		trigger:'manual'
-	}).click(function(e){
-		$('td > a.btn').not(this).popover('hide');
-		// ideally we would use 'toggle' here
-		// but it seems buggy in our Bootstrap version
-		$(this).popover('show');
-		e.stopPropagation();
-	});
-
-	// enable tooltips for applied filters
-	$('th a.btn-primary').tooltip({container:'body', html:true, placement:'bottom', delay:{hide:1500}});
-
-	// hide applied filter tooltip when you click on the filter button
-	$('th a.btn-primary').click(function () {
-		$('.tooltip').hide();
-	});
-
-	// enable help information tooltip
-    $(".get-help").tooltip({container:'body', html:true, delay:{show:300}});
-
-	// show help bubble only on hover inside tables
-	$(".hover-help").css("visibility","hidden");
-	$("th, td").hover(function () {
-		$(this).find(".hover-help").css("visibility","visible");
-	});
-	$("th, td").mouseleave(function () {
-		$(this).find(".hover-help").css("visibility","hidden");
-	});
-
-    // show task type and outcome in task details pages
-    $(".task-info").tooltip({ container: 'body', html: true, delay: {show: 200}, placement: 'right' });
-
-	// linking directly to tabs
-	$(function(){
-  		var hash = window.location.hash;
-  		hash && $('ul.nav a[href="' + hash + '"]').tab('show');
-
-  		$('.nav-tabs a').click(function (e) {
-    		$(this).tab('show');
-			$('body').scrollTop();
-  		});
-	});
-
-	// toggle for long content (variables, python stack trace, etc)
-    $('.full, .full-hide').hide();
-    $('.full-show').click(function(){
-    	$('.full').slideDown(function(){
-        	$('.full-hide').show();
-        });
-        $(this).hide();
-    });
-    $('.full-hide').click(function(){
-    	$(this).hide();
-        $('.full').slideUp(function(){
-            $('.full-show').show();
-        });
-    });
-
-    //toggle the errors and warnings sections
-    $('.show-errors').click(function() {
-        $('#collapse-errors').addClass('in');
-    });
-    $('.toggle-errors').click(function() {
-        $('#collapse-errors').toggleClass('in');
-    });
-    $('.show-warnings').click(function() {
-        $('#collapse-warnings').addClass('in');
-    });
-    $('.toggle-warnings').click(function() {
-        $('#collapse-warnings').toggleClass('in');
-    });
-    //show warnings section when requested from the previous page
-    if (location.href.search('#warnings') > -1) {
-        $('#collapse-warnings').addClass('in');
-    }
-        
-});
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index f377081..1b9edfd 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -18,36 +18,11 @@
 </script>
 <script src="{% static 'js/prettify.js' %}">
 </script>
-<script src="{% static 'js/main.js' %}">
+<script src="{% static 'js/libtoaster.js' %}">
+</script>
 </script>
 <script>
-function reload_params(params) {
-    uri = window.location.href;
-    splitlist = uri.split("?");
-    url = splitlist[0], parameters=splitlist[1];
-    // deserialize the call parameters
-    if(parameters){
-        cparams = parameters.split("&");
-    }else{
-        cparams = []
-    }
-    nparams = {}
-    for (i = 0; i < cparams.length; i++) {
-        temp = cparams[i].split("=");
-        nparams[temp[0]] = temp[1];
-    }
-    // update parameter values
-    for (i in params) {
-        nparams[encodeURIComponent(i)] = encodeURIComponent(params[i]);
-    }
-    // serialize the structure
-    callparams = []
-    for (i in nparams) {
-        callparams.push(i+"="+nparams[i]);
-    }
-    window.location.href = url+"?"+callparams.join('&');
 
-}
 </script>
 
 {% block extraheadcontent %}
-- 
1.9.1


