Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 2407960746
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Mar 2016 12:12:47 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 24 Mar 2016 05:12:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,385,1455004800"; 
	d="scan'208,217";a="917905765"
Received: from unknown (HELO lp.ger.corp.intel.com) ([10.252.9.87])
	by orsmga001.jf.intel.com with ESMTP; 24 Mar 2016 05:12:46 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Mar 2016 12:12:10 +0000
Message-Id: <1458821531-10484-2-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1458821531-10484-1-git-send-email-elliot.smith@intel.com>
References: <1458821531-10484-1-git-send-email-elliot.smith@intel.com>
Cc: Dave Lerner <dave.lerner@windriver.com>
Subject: [PATCH 2/3] toaster: new customise package-remove modal dlg
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
X-List-Received-Date: Thu, 24 Mar 2016 12:12:47 -0000

From: Dave Lerner <dave.lerner@windriver.com>

For customised image package removal, show a different modal dialog that
lists ALL of the packages dependent on this package, with a Remove All
button - implying that all of the dependents will be removed.

[YOCTO #9121]

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/templates/customrecipe.html | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/customrecipe.html b/bitbake/lib/toaster/toastergui/templates/customrecipe.html
index 8cce919..4b58992 100644
--- a/bitbake/lib/toaster/toastergui/templates/customrecipe.html
+++ b/bitbake/lib/toaster/toastergui/templates/customrecipe.html
@@ -66,13 +66,14 @@
     <h3><span class="package-to-rm-name"></span> reverse dependencies</h3>
   </div>
   <div class="modal-body">
-    <p>Based on information from a previous build it is likely that <strong class="package-to-rm-name"></strong> may be added again as the following packages directly depend on it for your custom image:</p>
+    <p> <strong class="reverse-deps-count"></strong> <span class="reverse-deps-package"></span> in your image <span class="reverse-deps-depends"></span> on <strong class="package-to-rm-name"></strong>:</p>
     <ul id="package-reverse-dep-list">
     </ul>
+    <p>In order to remove <strong class="package-to-rm-name"></strong>, you must remove <span class="reverse-deps-this"></span> <strong class="reverse-deps-count"></strong> <span class="reverse-deps-package"></span> as well.</p>
   </div>
   <div class="modal-footer">
     <p class="help-block text-left">Total package size: <strong id="package-reverse-deps-total-size"></strong></p>
-    <button id="rm-package-reverse-deps-modal-btn" type="submit" class="btn btn-primary" data-dismiss="modal">Remove package</button>
+    <button id="rm-package-reverse-deps-modal-btn" type="submit" class="btn btn-primary" data-dismiss="modal">Remove all <span class="reverse-deps-count-plus1"></button>
     <button class="btn" data-dismiss="modal">Cancel</button>
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


