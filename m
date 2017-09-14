Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 1646178633
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Sep 2017 00:06:28 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v8F06TlT014132
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Sep 2017 17:06:30 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Thu, 14 Sep 2017 17:06:29 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Sep 2017 16:58:15 -0700
Message-ID: <cd949a2a16832f6f94e620c965d7b71b88908f8a.1505433280.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1505433280.git.David.Reyna@windriver.com>
References: <cover.1505433280.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 1/2] toaster: reserve HEAD from imported layers
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
X-List-Received-Date: Fri, 15 Sep 2017 00:06:29 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

The HEAD reference in Toaster layers are reserved for the
"Local Yocto Project" layers, stored at the top directory.
Imported layers are not allowed to use this since they are
managed differently - for example the 'remotes' will collide.

Fix the add layer handler to not drop the data fields when it
is a git repo.

Explicitly inform the user when an internal Toaster error is
returned via AJAX, so that they know why clicking the layer add
button did not do anything.

[YOCTO #9924]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/api.py                     |  6 +++---
 lib/toaster/toastergui/static/js/importlayer.js   | 17 ++++++++++++++---
 lib/toaster/toastergui/templates/importlayer.html |  2 +-
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index cb8f0f3..ab6ba69 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -293,14 +293,14 @@ class XhrLayer(View):
                 layer_source=LayerSource.TYPE_IMPORTED)
 
             # Local layer
-            if 'local_source_dir' in layer_data:
+            if ('local_source_dir' in layer_data) and layer.local_source_dir:
                 layer.local_source_dir = layer_data['local_source_dir']
             # git layer
             elif 'vcs_url' in layer_data:
                 layer.vcs_url = layer_data['vcs_url']
                 layer_version.dirpath = layer_data['dir_path']
-                layer_version.commit = layer_data['get_ref']
-                layer_version.branch = layer_data['get_ref']
+                layer_version.commit = layer_data['git_ref']
+                layer_version.branch = layer_data['git_ref']
 
             layer.save()
             layer_version.save()
diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index b3f094e..59652b9 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -176,6 +176,8 @@ function importLayerPageInit (ctx) {
           success: function (data) {
             if (data.error != "ok") {
               console.log(data.error);
+              /* let the user know why nothing happened */
+              alert(data.error)
             } else {
               createImportedNotification(data);
               window.location.replace(libtoaster.ctx.projectPageUrl);
@@ -244,9 +246,18 @@ function importLayerPageInit (ctx) {
         enable_import_btn(true);
       }
 
-      if ($("#git-repo-radio").prop("checked") &&
-          vcsURLInput.val().length > 0 && gitRefInput.val().length > 0) {
-        enable_import_btn(true);
+      if ($("#git-repo-radio").prop("checked")) {
+        if (gitRefInput.val().length > 0 &&
+            gitRefInput.val() == 'HEAD') {
+          $('#invalid-layer-revision-hint').show();
+          $('#layer-revision-ctrl').addClass('has-error');
+          enable_import_btn(false);
+        } else if (vcsURLInput.val().length > 0 &&
+                   gitRefInput.val().length > 0) {
+          $('#invalid-layer-revision-hint').hide();
+          $('#layer-revision-ctrl').removeClass('has-error');
+          enable_import_btn(true);
+        }
       }
     }
 
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index afbeb94..7e5253e 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -115,8 +115,8 @@
         </label>
         <span style="display: block">
         <input type="text" class="form-control" id="layer-git-ref" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" required>
-        <span class="help-inline" style="display:none;" id="invalid-layer-revision-hint"></span>
         </span>
+        <span class="help-block has-error" style="display:none;" id="invalid-layer-revision-hint">The "HEAD" branch is reserved (only allowed for the "Local Yocto Project" layers)</span>
       </div>
     </fieldset>
 
-- 
1.9.1


