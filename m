Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id E25E8770D8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Feb 2016 09:08:46 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 22 Feb 2016 01:08:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,483,1449561600"; d="scan'208";a="921077031"
Received: from mmisiak-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.31.233])
	by fmsmga002.fm.intel.com with ESMTP; 22 Feb 2016 01:08:47 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 09:08:34 +0000
Message-Id: <5eb2be7a0bd07fbe07e9b0b66009b24cdefebcbe.1456131920.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <6a8294aab59563cd1d747764d140787648218458.1456131920.git.elliot.smith@intel.com>
References: <6a8294aab59563cd1d747764d140787648218458.1456131920.git.elliot.smith@intel.com>
In-Reply-To: <cover.1456131920.git.elliot.smith@intel.com>
References: <cover.1456131920.git.elliot.smith@intel.com>
Subject: [PATCH 3/9] toaster: apply error class to name field
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
X-List-Received-Date: Mon, 22 Feb 2016 09:08:47 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The form for naming new custom images shows you an error message when
the name already exists or you include an invalid character in it. But
when an error appears, the input field was missing the red highlight.

This patch applies the right class to the form controls whenever an
error message is shown.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/static/js/newcustomimage_modal.js | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/toaster/toastergui/static/js/newcustomimage_modal.js b/lib/toaster/toastergui/static/js/newcustomimage_modal.js
index 0b9d31a..328997a 100644
--- a/lib/toaster/toastergui/static/js/newcustomimage_modal.js
+++ b/lib/toaster/toastergui/static/js/newcustomimage_modal.js
@@ -36,6 +36,7 @@ function newCustomImageModalInit(){
   function showError(text){
     invalidNameHelp.text(text);
     invalidNameHelp.show();
+    nameInput.parent().addClass('error');
   }
 
   nameInput.on('keyup', function(){
@@ -47,9 +48,11 @@ function newCustomImageModalInit(){
     if (nameInput.val().search(/[^a-z|0-9|-]/) != -1){
       showError(invalidMsg);
       newCustomImgBtn.prop("disabled", true);
+      nameInput.parent().addClass('error');
     } else {
       invalidNameHelp.hide();
       newCustomImgBtn.prop("disabled", false);
+      nameInput.parent().removeClass('error');
     }
   });
 }
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


