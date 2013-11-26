Return-Path: <valentin.popa@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id E7F966D750
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Nov 2013 09:29:46 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 26 Nov 2013 01:29:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,773,1378882800"; d="scan'208";a="434194246"
Received: from vpopa-desktop.rb.intel.com ([10.237.105.58])
	by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2013 01:29:45 -0800
From: Valentin Popa <valentin.popa@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Nov 2013 11:30:41 +0200
Message-Id: <150ecc46f3a7f5d52a800fe116f9ad267f3078f0.1385457669.git.valentin.popa@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <cover.1385457669.git.valentin.popa@intel.com>
References: <cover.1385457669.git.valentin.popa@intel.com>
In-Reply-To: <cover.1385457669.git.valentin.popa@intel.com>
References: <cover.1385457669.git.valentin.popa@intel.com>
Subject: [PATCH 1/1] Hob: force notebook refresh
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
X-List-Received-Date: Tue, 26 Nov 2013 09:29:47 -0000

Redraw the entire notebook widget after
number-of-issues drawable is incremented
(because for this case, the notebook widget
doesn't refresh it's children automatically).

[YOCTO #5596]

Signed-off-by: Valentin Popa <valentin.popa@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 1899956..7fc690e 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -185,6 +185,7 @@ class BuildDetailsPage (HobPage):
     def show_issues(self):
         self.num_of_issues += 1
         self.notebook.show_indicator_icon("Issues", self.num_of_issues)
+        self.notebook.queue_draw()
 
     def reset_issues(self):
         self.num_of_issues = 0
-- 
1.8.3.2


