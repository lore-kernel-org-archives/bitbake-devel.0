Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 52C4E7422C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Sep 2015 09:40:26 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 08 Sep 2015 02:40:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,489,1437462000"; d="scan'208";a="557427798"
Received: from almacarr-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.11.248])
	by FMSMGA003.fm.intel.com with ESMTP; 08 Sep 2015 02:40:23 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Sep 2015 10:40:19 +0100
Message-Id: <bd677b2f71699bb5e1acc43a904e805fc64bc877.1441705002.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <f5290147ed6e226f39004b18c867e1ed2042c354.1441705002.git.elliot.smith@intel.com>
References: <f5290147ed6e226f39004b18c867e1ed2042c354.1441705002.git.elliot.smith@intel.com>
In-Reply-To: <cover.1441705002.git.elliot.smith@intel.com>
References: <cover.1441705002.git.elliot.smith@intel.com>
Subject: [PATCH 2/3] toaster: fix project names in latest builds
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
X-List-Received-Date: Tue, 08 Sep 2015 09:40:26 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Make sure that the project name we show for each build
in the latest builds section of the all builds page:

* Has the same styles as the build, depending on the
build status (in progress, failed or success)

* Links to the project page

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/mrb_section.html | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 903635d..57a6f9b 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -13,7 +13,11 @@
   <div id="latest-builds">
   {% for build in mru %}
     <div class="alert {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%} project-name ">
-       <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-danger{%else%}label-info{%endif%}"> {{build.project.name}} </span>
+       <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-important{%else%}label-info{%endif%}">
+         <a href={% url 'project' build.project.pk %}>
+           {{build.project.name}}
+         </a>
+       </span>
 
         <div class="row-fluid">
             <div class="span3 lead">
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


