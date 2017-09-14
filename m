Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 94E4F78633
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Sep 2017 00:06:29 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v8F06UZ6029891
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Sep 2017 17:06:30 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Thu, 14 Sep 2017 17:06:30 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Sep 2017 16:58:16 -0700
Message-ID: <57e0ee2bb50db3b3f1024603c6d3e49fd7be16f7.1505433280.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1505433280.git.David.Reyna@windriver.com>
References: <cover.1505433280.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 2/2] toaster: allow dots in user path names
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

The dot '.' character should be allowed in the user paths for
local non-git layers, DL_DIR, and SSTATE_DIR.

[YOCTO #10650]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/static/js/importlayer.js   | 2 +-
 lib/toaster/toastergui/templates/importlayer.html | 2 +-
 lib/toaster/toastergui/templates/projectconf.html | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index 59652b9..2964839 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -418,7 +418,7 @@ function importLayerPageInit (ctx) {
       var input = $(this);
       var reBeginWithSlash = /^\//;
       var reCheckVariable = /^\$/;
-      var re = /([ <>\\|":\.%\?\*]+)/;
+      var re = /([ <>\\|":%\?\*]+)/;
 
       var invalidDir = re.test(input.val());
       var invalidSlash = reBeginWithSlash.test(input.val());
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index 7e5253e..97d52c7 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -126,7 +126,7 @@
         <label for="local-dir-path" class="control-label">Enter the absolute path to the layer directory</label>
         <input type="text" class="form-control" id="local-dir-path" required/>
         <p class="help-block" id="hintError-dir-path-starts-with-slash" style="display:none;">The absolute path must start with "/".</p>
-        <p class="help-block" id="hintError-dir-path" style="display:none;">The directory path cannot include spaces or any of these characters: . \ ? % * : | " " &lt; &gt;</p>
+        <p class="help-block" id="hintError-dir-path" style="display:none;">The directory path cannot include spaces or any of these characters: \ ? % * : | " " &lt; &gt;</p>
       </div>
     </fieldset>
 
diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index 0e9712b..933c588 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -41,7 +41,7 @@
       </div>
       <button id="apply-change-dl_dir" class="btn btn-default" type="button">Save</button>
       <button id="cancel-change-dl_dir" type="button" class="btn btn-link">Cancel</button>
-      <p class="help-block" id="hintError-dl_dir" style="display:none;">The directory path cannot include spaces or any of these characters: . \ ? % * : | " " &lt; &gt;</p>
+      <p class="help-block" id="hintError-dl_dir" style="display:none;">The directory path cannot include spaces or any of these characters: \ ? % * : | " " &lt; &gt;</p>
       <p class="help-block" id="hintError-initialChar-dl_dir" style="display:none;">The directory path should either start with a /, e.g. /home/toaster/downloads; or with a variable, e.g. ${TOPDIR}/downloads.</p>
     </form>
     </dd>
@@ -151,7 +151,7 @@
       </div>
       <button id="apply-change-sstate_dir" class="btn btn-default" type="button">Save</button>
       <button id="cancel-change-sstate_dir" type="button" class="btn btn-link">Cancel</button>
-      <p class="help-block" id="hintError-sstate_dir" style="display:none;">The directory path cannot include spaces or any of these characters: . \ ? % * : | " " &lt; &gt;</p>
+      <p class="help-block" id="hintError-sstate_dir" style="display:none;">The directory path cannot include spaces or any of these characters: \ ? % * : | " " &lt; &gt;</p>
       <p class="help-block" id="hintError-initialChar-sstate_dir" style="display:none;">The directory path should either start with a /, e.g. /home/toaster/sstate-cache; or with a variable, e.g. ${TOPDIR}/sstate-cache.</p>
     </form>
     </dd>
@@ -594,7 +594,7 @@ $(document).ready(function() {
       var input = $(this);
       var reBeginWithSlash = /^\//;
       var reCheckVariable = /^\$/;
-      var re = /([ <>\\|":\.%\?\*]+)/;
+      var re = /([ <>\\|":%\?\*]+)/;
       var invalidDir = re.test(input.val());
       var invalidSlash = reBeginWithSlash.test(input.val());
       var invalidVar = reCheckVariable.test(input.val());
@@ -961,7 +961,7 @@ $(document).ready(function() {
       var input = $(this);
       var reBeginWithSlash = /^\//;
       var reCheckVariable = /^\$/;
-      var re = /([ <>\\|":\.%\?\*]+)/;
+      var re = /([ <>\\|":%\?\*]+)/;
       var invalidDir = re.test(input.val());
       var invalidSlash = reBeginWithSlash.test(input.val());
       var invalidVar = reCheckVariable.test(input.val());
-- 
1.9.1


