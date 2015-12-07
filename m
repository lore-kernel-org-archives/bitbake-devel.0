Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 1B53460124
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Dec 2015 16:06:38 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 07 Dec 2015 08:06:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,395,1444719600"; d="scan'208";a="866426558"
Received: from jamullin-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.16.98])
	by orsmga002.jf.intel.com with ESMTP; 07 Dec 2015 08:06:37 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Dec 2015 16:06:01 +0000
Message-Id: <1449504361-17499-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: return back 'New project' button
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
X-List-Received-Date: Mon, 07 Dec 2015 16:06:39 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

The button was removed by mistake in merging modes patchset.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/templates/base.html | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/toaster/toastergui/templates/base.html b/bitbake/lib/toaster/toastergui/templates/base.html
index 8081f06..e56bb34 100644
--- a/bitbake/lib/toaster/toastergui/templates/base.html
+++ b/bitbake/lib/toaster/toastergui/templates/base.html
@@ -108,6 +108,9 @@
             </li>
           </ul>
           <span class="pull-right divider-vertical"></span>
+          <div class="btn-group pull-right">
+            <a class="btn" id="new-project-button" href="{% url 'newproject' %}">New project</a>
+          </div>
         </div>
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


