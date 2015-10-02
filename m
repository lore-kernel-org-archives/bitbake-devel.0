Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 75359766F3
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Oct 2015 13:43:38 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 02 Oct 2015 06:43:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,623,1437462000"; d="scan'208";a="802180869"
Received: from mhalasin-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.25.78])
	by fmsmga001.fm.intel.com with ESMTP; 02 Oct 2015 06:43:36 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Oct 2015 14:43:26 +0100
Message-Id: <1443793406-24349-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: Remove project name from latest project builds
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
X-List-Received-Date: Fri, 02 Oct 2015 13:43:45 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The 'latest builds' list in the project builds page does not
need to show the project name, since it lists only builds
for the selected project.

This patch removes the redundant project name.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/templates/mrb_section.html | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/mrb_section.html b/bitbake/lib/toaster/toastergui/templates/mrb_section.html
index 2fefe4b..ad90e82 100644
--- a/bitbake/lib/toaster/toastergui/templates/mrb_section.html
+++ b/bitbake/lib/toaster/toastergui/templates/mrb_section.html
@@ -18,13 +18,15 @@
   {% endif %}
   <div id="latest-builds">
   {% for build in mru %}
-    <div class="alert {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%} project-name ">
+  <div class="alert {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%}
+    {% if mrb_type != 'project' %}
+    project-name">
        <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-important{%else%}label-info{%endif%}">
          <a href={% url 'project' build.project.pk %}>
            {{build.project.name}}
          </a>
        </span>
-
+    {% endif %}
         <div class="row-fluid">
             <div class="span3 lead">
     {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
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


