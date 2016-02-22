Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 70EB1770D8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Feb 2016 09:08:45 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 22 Feb 2016 01:08:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,483,1449561600"; 
	d="scan'208,217";a="921077024"
Received: from mmisiak-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.31.233])
	by fmsmga002.fm.intel.com with ESMTP; 22 Feb 2016 01:08:46 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 09:08:33 +0000
Message-Id: <f3ab412d99f6ce12614175578851c41989fd7060.1456131920.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <6a8294aab59563cd1d747764d140787648218458.1456131920.git.elliot.smith@intel.com>
References: <6a8294aab59563cd1d747764d140787648218458.1456131920.git.elliot.smith@intel.com>
In-Reply-To: <cover.1456131920.git.elliot.smith@intel.com>
References: <cover.1456131920.git.elliot.smith@intel.com>
Subject: [PATCH 2/9] toaster: fix custom image name form
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

The placeholder text in the form where you name your new custom images
didn't display fully. This patch fixes the styles so that the text shows
properly. It also changes the text itself to make it a bit shorter.

[YOCTO #9122]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/static/css/default.css              | 2 +-
 lib/toaster/toastergui/templates/newcustomimage_modal.html | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index b674a9d..c5a580f 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -197,7 +197,7 @@ table p { margin-bottom: 0 }
 .configuration-alert p { margin-bottom: 0px; }
 .project-form { margin-top: 10px; }
 .add-layers .btn-block + .btn-block, .build .btn-block + .btn-block { margin-top: 0px; }
-input.huge { font-size: 17.5px; padding: 11px 19px; }
+input.huge { font-size: 17.5px; padding: 11px; min-width: 60%; }
 .build-form { margin-bottom: 0px; }
 .build-form .input-append { margin-bottom: 0px; }
 .build-form .btn-large { padding: 11px 35px; }
diff --git a/lib/toaster/toastergui/templates/newcustomimage_modal.html b/lib/toaster/toastergui/templates/newcustomimage_modal.html
index fed489f..b1b5148 100644
--- a/lib/toaster/toastergui/templates/newcustomimage_modal.html
+++ b/lib/toaster/toastergui/templates/newcustomimage_modal.html
@@ -22,7 +22,7 @@
       <span class="help-block span8">Image names must be unique. They should not contain spaces or capital letters, and the only allowed special character is dash (-).<p></p>
       </span></div>
     <div class="control-group controls">
-      <input type="text" class="huge span5" placeholder="Type the name, something like 'core-image-myimage'" required>
+      <input type="text" class="huge" placeholder="Type the custom image name" required>
         <span class="help-block error" id="invalid-name-help" style="display:none"></span>
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


