Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id E0B8471D64
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Oct 2016 15:49:44 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga101.fm.intel.com with ESMTP; 28 Oct 2016 08:49:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,410,1473145200"; d="scan'208";a="895138304"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga003.jf.intel.com with ESMTP; 28 Oct 2016 08:49:45 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 4578E6A4006;
	Fri, 28 Oct 2016 08:49:08 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Oct 2016 18:48:46 +0300
Message-Id: <cf99016e3ec656e790ac4ce7bd2a68157f3e0747.1477669487.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <9f194bc2e4eb2c366782ae6ac9a111c6157d8b01.1477669486.git.ed.bartosh@linux.intel.com>
References: <9f194bc2e4eb2c366782ae6ac9a111c6157d8b01.1477669486.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1477669486.git.ed.bartosh@linux.intel.com>
References: <cover.1477669486.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 5/8] toaster: test browser test_layerdetails_page add wait_until_visible
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
X-List-Received-Date: Fri, 28 Oct 2016 15:49:45 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add an additional wait_until_visible for the save buttons as firefox
animates this into view so slowly we get a race on them being visible

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/tests/browser/test_layerdetails_page.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/toaster/tests/browser/test_layerdetails_page.py
index 6392d1e..f24fb09 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -91,9 +91,10 @@ class TestLayerDetailsPage(SeleniumTestCase):
         for btn in self.find_all("dd .glyphicon-edit"):
             btn.click()
 
-        # Wait for the inputs to become visible
+        # Wait for the inputs to become visible after animation
         self.wait_until_visible("#layer-git input[type=text]")
         self.wait_until_visible("dd textarea")
+        self.wait_until_visible("dd .change-btn")
 
         # Edit each value
         for inputs in self.find_all("#layer-git input[type=text]") + \
-- 
2.1.4


