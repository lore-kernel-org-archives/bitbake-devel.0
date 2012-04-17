Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SK3rV-00057q-Ub
	for bitbake-devel@lists.openembedded.org;
	Tue, 17 Apr 2012 10:34:10 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 17 Apr 2012 01:24:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="130551072"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 17 Apr 2012 01:24:42 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Apr 2012 16:21:39 +0800
Message-Id: <7d00234c6c0ce79d4a07816216c43ab4400340e2.1334650694.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334650694.git.dongxiao.xu@intel.com>
References: <cover.1334650694.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334650694.git.dongxiao.xu@intel.com>
References: <cover.1334650694.git.dongxiao.xu@intel.com>
Subject: [PATCH 4/4] Hob: Set the "stop" button insensitive before hide it
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 17 Apr 2012 08:34:10 -0000

If user stops a build, we need to firstly set the button insensitive and
then hide it. This ensures the button's init status is "insensitive" in
next build.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builddetailspage.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/builddetailspage.py b/lib/bb/ui/crumbs/builddetailspage.py
index 6d8b509..51e6a4a 100755
--- a/lib/bb/ui/crumbs/builddetailspage.py
+++ b/lib/bb/ui/crumbs/builddetailspage.py
@@ -238,6 +238,7 @@ class BuildDetailsPage (HobPage):
         self.builder.stop_build()
 
     def hide_stop_button(self):
+        self.stop_button.set_sensitive(False)
         self.stop_button.hide()
 
     def scroll_to_present_row(self, model, path, iter, v_adj, treeview):
-- 
1.7.4.1



