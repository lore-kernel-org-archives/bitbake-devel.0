Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 69E4F65CC2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 May 2016 10:43:45 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 19 May 2016 03:43:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,334,1459839600"; 
	d="scan'208,217";a="980343638"
Received: from gfois-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.8.121])
	by orsmga002.jf.intel.com with ESMTP; 19 May 2016 03:43:46 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 May 2016 11:43:31 +0100
Message-Id: <1463654612-30647-2-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1463654612-30647-1-git-send-email-elliot.smith@intel.com>
References: <1463654612-30647-1-git-send-email-elliot.smith@intel.com>
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 2/3] toaster: projectconf Small tweaks to IMAGE_FSTYPES form
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
X-List-Received-Date: Thu, 19 May 2016 10:43:45 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

Add a label to clarify the purpose of the first input field, replace <p>
with <label> for the second set of controls, and give some top margin to
the validation message.

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/templates/projectconf.html | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/projectconf.html b/bitbake/lib/toaster/toastergui/templates/projectconf.html
index c007859..dd7d30c 100644
--- a/bitbake/lib/toaster/toastergui/templates/projectconf.html
+++ b/bitbake/lib/toaster/toastergui/templates/projectconf.html
@@ -62,13 +62,14 @@
                 <span id="image_fstypes">{{fstypes}}</span>
                 <i class="icon-pencil" id="change-image_fstypes-icon"></i>
                 <form id="change-image_fstypes-form" style="display:none;">
+                    <label>Type the image types you want to build:</label>
                     <div class="input-append" id="validate-image_fstypes">
                         <input type="text" class="input-xlarge" id="new-imagefs_types">
                         <button id="apply-change-image_fstypes" type="button" class="btn">Save</button>
                         <button id="cancel-change-image_fstypes" type="button" class="btn btn-link">Cancel</button>
                     </div>
-                    </br><span class="help-block error" style="display:none;" id="hintError-image-fs_type">A valid image type cannot include underscores.</span>
-                    <p>Choose from known image types</p>
+                    <p class="help-block error" style="display:none;margin-top:10px;" id="hintError-image-fs_type">A valid image type cannot include underscores</p>
+                    <label>Or choose from known image types:</label>
                     <input id="filter-image_fstypes" type="text" placeholder="Search image types" class="span4">
                     <div id="all-image_fstypes" class="scrolling">
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


