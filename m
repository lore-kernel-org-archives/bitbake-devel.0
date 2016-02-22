Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 09B997570D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Feb 2016 09:08:53 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 22 Feb 2016 01:08:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,483,1449561600"; 
	d="scan'208,217";a="921077081"
Received: from mmisiak-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.31.233])
	by fmsmga002.fm.intel.com with ESMTP; 22 Feb 2016 01:08:53 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 09:08:38 +0000
Message-Id: <0e4035832318ef9daac72decbea374e40c2ccdc6.1456131920.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <6a8294aab59563cd1d747764d140787648218458.1456131920.git.elliot.smith@intel.com>
References: <6a8294aab59563cd1d747764d140787648218458.1456131920.git.elliot.smith@intel.com>
In-Reply-To: <cover.1456131920.git.elliot.smith@intel.com>
References: <cover.1456131920.git.elliot.smith@intel.com>
Subject: [PATCH 7/9] toaster: make 'configuration' the first tab
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
X-List-Received-Date: Mon, 22 Feb 2016 09:08:53 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Our project pages have 4 tabs: builds, configuration, import layer and
new custom image. Even though we treat the 'configuration' as the
default tab, it comes second after the builds tab.

That's a bit strange: the default tab should be the first one listed.
This patch changes the tab order to put 'configuration' first.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/templates/projecttopbar.html | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/templates/projecttopbar.html b/lib/toaster/toastergui/templates/projecttopbar.html
index 5bc1ac4..268a99e 100644
--- a/lib/toaster/toastergui/templates/projecttopbar.html
+++ b/lib/toaster/toastergui/templates/projecttopbar.html
@@ -44,17 +44,17 @@
 {% if not project.is_default %}
   <div id="project-topbar">
     <ul class="nav nav-pills">
-      <li>
-        <a href="{% url 'projectbuilds' project.id %}">
-          Builds ({{project.get_number_of_builds}})
-        </a>
-      </li>
       <li id="topbar-configuration-tab">
         <a href="{% url 'project' project.id %}">
           Configuration
         </a>
       </li>
       <li>
+        <a href="{% url 'projectbuilds' project.id %}">
+          Builds ({{project.get_number_of_builds}})
+        </a>
+      </li>
+      <li>
         <a href="{% url 'importlayer' project.id %}">
           Import layer
         </a>
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


