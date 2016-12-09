Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id E47D871D76
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Dec 2016 16:53:10 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id t79so32674452wmt.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 09 Dec 2016 08:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=NZ5fPqepNy1tfcDqLIOIxgIwOsHSwxtN+90eAzTnFH0=;
	b=N5sVZkpM3Q9aYuL4cFrewuahIFz7TswFEVcpADbuTQ5iDtebNtb+P3qPVXFbK8kwEY
	cN1KRsI6ZelPI+5ZhvuyjyeQcCxWlgPx46j9nYH/v2WBJoDRIez3b3UxExJWQKs4vTVI
	4owLYLcH0IoGs1gmMkks9nxXpcYo7SjdMb5Ev10NDn3mPYWYq+g1gfq6CWAbhORIDLIm
	v06kG5LBu202PY+AreiBBZCXJq1En3o4YvAZmdMozbu6Kb8tzrexWxVMYlEFmaZxqs+n
	nekp/Lgmf8379LCQobkVqizFwAwk/m1IlyzFBDhkPVq63i1a8eQSYHSbSQ8hLqIYJfol
	0LBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=NZ5fPqepNy1tfcDqLIOIxgIwOsHSwxtN+90eAzTnFH0=;
	b=ImGqX9LnuOt0ik4UYwVzAe8Xcf8Px0dB93yvqlNNZ8rVGH4PDcjcaQlLtrUUQBrHTG
	wU4tGw3ELlC/0fvnex97dS9sP4FqRHJL59nEJcEs4mHZDoHwWcoTcfCgrNfPfc7ZzxI1
	eWqD2kdYNCw8t0RweGEmVLdrVGpqh+KXrt5IoF7W48+XFq+h+4QPWKIqelAhwwS/bpHC
	0+HMXyorpDAgMHworStxSuPbCPOx65Lane1UNJli8raAq2c7OIYl5qLIsnIPK7aF8Pmo
	ncbnoYvt9SylOjYgHC7n8iAUEWvJy9DUuJBd25AvpLcffgaub+xo3oWDHyzIdoJVCoAP
	WuKA==
X-Gm-Message-State: AKaTC01QL03vRuVehw3RCnhuDueKTfO1lvSM+YB29Ypg3MlkSuquFeDE/BJNMXV01CEm5Ra4
X-Received: by 10.28.54.3 with SMTP id d3mr7300732wma.34.1481302391646;
	Fri, 09 Dec 2016 08:53:11 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	ke6sm43170601wjb.21.2016.12.09.08.53.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 09 Dec 2016 08:53:11 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Dec 2016 16:52:50 +0000
Message-Id: <1481302375-7985-10-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
References: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 09/14] toaster: importlayer Add git revision typeahead to that input field
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
X-List-Received-Date: Fri, 09 Dec 2016 16:53:11 -0000

Add the front end mechanism to load the typeahead for the git revision
field on importing a layer.
Also fix one indentation issue and update the js test.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/css/default.css     |  1 -
 lib/toaster/toastergui/static/js/importlayer.js   | 29 ++++++++++++++++++-----
 lib/toaster/toastergui/static/js/tests/test.js    |  2 +-
 lib/toaster/toastergui/templates/importlayer.html |  5 +++-
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index ff24e8c..5cd7e21 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -210,7 +210,6 @@ fieldset.fields-apart-from-layer-name { margin-top: 20px; }
 #import-layer-name,
 #layer-subdir { width: 20%; }
 #layer-git-repo-url { width: 40%; }
-#layer-git-ref { width: 32%; }
 #local-dir-path { width: 45%; }
 #layer-dependency { width: 16em; }
 #layer-deps-list { margin-top: 0; }
diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index 4784c65..b3f094e 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -45,7 +45,7 @@ function importLayerPageInit (ctx) {
     function(layer) {
     if (layer.results.length > 0) {
       currentLayerDepSelection = layer.results[0];
-      layerDepBtn.click();
+        layerDepBtn.click();
     }
   });
 
@@ -333,19 +333,36 @@ function importLayerPageInit (ctx) {
     check_form();
   });
 
-  /* Have a guess at the layer name */
+  /* Setup 'blank' typeahead */
+  libtoaster.makeTypeahead(gitRefInput,
+                           ctx.xhrGitRevTypeAheadUrl,
+                           { git_url: null }, function(){});
+
+
   vcsURLInput.focusout(function (){
+    if (!$(this).val())
+      return;
+
     /* If we a layer name specified don't overwrite it or if there isn't a
      * url typed in yet return
      */
-    if (layerNameInput.val() || !$(this).val())
-      return;
-
-    if ($(this).val().search("/")){
+    if (!layerNameInput.val() && $(this).val().search("/")){
       var urlPts = $(this).val().split("/");
+      /* Add a suggestion of the layer name */
       var suggestion = urlPts[urlPts.length-1].replace(".git","");
       layerNameInput.val(suggestion);
     }
+
+    /* Now actually setup the typeahead properly with the git url entered */
+    gitRefInput._typeahead('destroy');
+
+    libtoaster.makeTypeahead(gitRefInput,
+                             ctx.xhrGitRevTypeAheadUrl,
+                             { git_url: $(this).val() },
+                             function(selected){
+                               gitRefInput._typeahead("close");
+                             });
+
   });
 
   function radioDisplay() {
diff --git a/lib/toaster/toastergui/static/js/tests/test.js b/lib/toaster/toastergui/static/js/tests/test.js
index d7953de..f3bf8d7 100644
--- a/lib/toaster/toastergui/static/js/tests/test.js
+++ b/lib/toaster/toastergui/static/js/tests/test.js
@@ -144,7 +144,7 @@ QUnit.test("Make typeaheads", function(assert){
 /* Page init functions */
 
 QUnit.test("Import layer page init", function(assert){
-  assert.throws(importLayerPageInit());
+  assert.throws(importLayerPageInit({ xhrGitRevTypeAheadUrl: "url" }));
 });
 
 QUnit.test("Project page init", function(assert){
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index bd507b5..afbeb94 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -14,6 +14,7 @@
   $(document).ready(function (){
     var ctx = {
       xhrLayerUrl : "{% url 'xhr_layer' project.id %}",
+      xhrGitRevTypeAheadUrl : "{% url 'xhr_gitrevtypeahead' %}",
     };
 
     try {
@@ -112,8 +113,10 @@
           Git revision
           <span class="glyphicon glyphicon-question-sign get-help" title="You can provide a Git branch, a tag or a commit SHA as the revision"></span>
         </label>
-        <input type="text" class="form-control" id="layer-git-ref" required>
+        <span style="display: block">
+        <input type="text" class="form-control" id="layer-git-ref" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" required>
         <span class="help-inline" style="display:none;" id="invalid-layer-revision-hint"></span>
+        </span>
       </div>
     </fieldset>
 
-- 
2.7.4


