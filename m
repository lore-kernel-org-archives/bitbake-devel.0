Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 32E0560053
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Sep 2015 18:18:27 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 21 Sep 2015 11:03:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,568,1437462000"; d="scan'208";a="649377346"
Received: from routhe-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.18.247])
	by orsmga003.jf.intel.com with ESMTP; 21 Sep 2015 11:02:05 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 Sep 2015 19:01:09 +0100
Message-Id: <1442858469-8737-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: remove time from builds in progress
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
X-List-Received-Date: Mon, 21 Sep 2015 18:18:29 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

In the 'latest builds' section of the all builds page,
completed builds show the time they completed at. Builds
in progress should not display such time, since they
haven't completed yet.

This patch removes the time information that was showing
for builds in progress, whatever that time actually was.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/templates/mrb_section.html | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/mrb_section.html b/bitbake/lib/toaster/toastergui/templates/mrb_section.html
index 396fb8e..c5e9c87 100644
--- a/bitbake/lib/toaster/toastergui/templates/mrb_section.html
+++ b/bitbake/lib/toaster/toastergui/templates/mrb_section.html
@@ -38,6 +38,7 @@
                 </a>
     {% endif %}
             </div>
+    {% if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
             <div class="span2 lead">
                 {% if build.completed_on|format_build_date  %}
                     {{ build.completed_on|date:'d/m/y H:i' }}
@@ -45,6 +46,7 @@
                     {{ build.completed_on|date:'H:i' }}
                 {% endif %}
             </div>
+    {% endif %}
     {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
             <div class="span2 lead">
       {% if  build.errors.count %}
@@ -79,7 +81,7 @@
             </div>
     {%endif%}
     {%if build.outcome == build.IN_PROGRESS %}
-            <div class="span4">
+            <div class="span4 offset1">
                 <div class="progress" style="margin-top:5px;" data-toggle="tooltip" title="{{build.completeper}}% of tasks complete">
                     <div style="width: {{build.completeper}}%;" class="bar"></div>
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


