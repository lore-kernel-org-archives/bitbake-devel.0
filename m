Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id CD83E770D8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Feb 2016 09:08:44 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 22 Feb 2016 01:08:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,483,1449561600"; 
	d="scan'208,217";a="921077011"
Received: from mmisiak-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.31.233])
	by fmsmga002.fm.intel.com with ESMTP; 22 Feb 2016 01:08:44 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 09:08:32 +0000
Message-Id: <6a8294aab59563cd1d747764d140787648218458.1456131920.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1456131920.git.elliot.smith@intel.com>
References: <cover.1456131920.git.elliot.smith@intel.com>
Subject: [PATCH 1/9] toaster: comment out project release change
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
X-List-Received-Date: Mon, 22 Feb 2016 09:08:45 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Although the support for building more than one release and how we
handle the build directories is the subject of lively discussion, we all
seem to agree on removing the ability to change the release of a
project. The feature is currently not working but exposed to users,
which is not a happy state of affairs.

This patch comments out the controls that give access to the release
changing functionality to hide them from users, but does not touch
anything else. Once all moving pieces start to settle down, we can make
a final decision regarding this feature, and clean up the code
accordingly.

[YOCTO #8917]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/templates/project.html | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index cc4745b..1256768 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -24,7 +24,9 @@
   });
 </script>
 
-<div id="change-release-modal" class="modal hide fade in" tabindex="-1" role="dialog" aria-labelledby="change-release-modal" aria-hidden="false">
+<!-- Comment out the ability to change the project release, until we decide what to do this functionality -->
+
+<!--div id="change-release-modal" class="modal hide fade in" tabindex="-1" role="dialog" aria-labelledby="change-release-modal" aria-hidden="false">
   <div class="modal-header">
     <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
     <h3>Changing Yocto Project release to <span class="proposed-release-change-name"></span></h3>
@@ -39,7 +41,7 @@
     <button id="change-release-and-rm-layers" data-dismiss="modal" type="submit" class="btn btn-primary">Change release and delete layers</button>
     <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
   </div>
-</div>
+</div-->
 
 
 <div class="row-fluid" id="project-page" style="display:none">
@@ -79,12 +81,19 @@
     <div class="well well-transparent">
       <h3>Project release</h3>
 
-      <p class="lead"><span id="project-release-title"></span> <i title="" data-original-title="" id="release-change-toggle" class="icon-pencil"></i></p>
+      <p class="lead"><span id="project-release-title"></span>
+
+      <!-- Comment out the ability to change the project release, until we decide what to do with this functionality -->
 
-      <form class="form-inline" id="change-release-form" style="display:none;">
+      <!--i title="" data-original-title="" id="release-change-toggle" class="icon-pencil"></i-->
+      </p>
+
+      <!-- Comment out the ability to change the project release, until we decide what to do with this functionality -->
+
+      <!--form class="form-inline" id="change-release-form" style="display:none;">
         <select></select>
         <button class="btn" style="margin-left:5px;" id="change-release-btn">Change</button> <a href="#" id="cancel-release-change" class="btn btn-link">Cancel</a>
-      </form>
+      </form-->
     </div>
   </div>
 
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


