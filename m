Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 06B55772C6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Nov 2015 13:48:47 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 13 Nov 2015 05:48:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,287,1444719600"; d="scan'208";a="836998454"
Received: from lquinn-mobl2.amr.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.6.239])
	by fmsmga001.fm.intel.com with ESMTP; 13 Nov 2015 05:48:48 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Nov 2015 13:48:36 +0000
Message-Id: <544b0b474c0e69ac50ee90c602ebdfe82b73fd13.1447422301.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <8088ff54a9e386f47c332fa71d5db59efe2d5d34.1447422301.git.elliot.smith@intel.com>
References: <8088ff54a9e386f47c332fa71d5db59efe2d5d34.1447422301.git.elliot.smith@intel.com>
In-Reply-To: <cover.1447422301.git.elliot.smith@intel.com>
References: <cover.1447422301.git.elliot.smith@intel.com>
Subject: [PATCH 3/4] toaster: projecttopbar Use the project in context to get num builds
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
X-List-Received-Date: Fri, 13 Nov 2015 13:48:47 -0000

From: Michael Wood <michael.g.wood@intel.com>

Use the project in the template context rather than ajax request to get
the number of ended builds.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/templates/projecttopbar.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/projecttopbar.html b/lib/toaster/toastergui/templates/projecttopbar.html
index 7a6bfef..3afd445 100644
--- a/lib/toaster/toastergui/templates/projecttopbar.html
+++ b/lib/toaster/toastergui/templates/projecttopbar.html
@@ -28,7 +28,7 @@
     <ul class="nav nav-pills">
       <li>
         <a href="{% url 'projectbuilds' project.id %}">
-          Builds (<span class="total-builds">0</span>)
+          Builds ({{project.get_number_of_builds}})
         </a>
       </li>
       <li id="topbar-configuration-tab">
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


