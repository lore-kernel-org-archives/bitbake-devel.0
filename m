Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qp6fo-0007D4-5u
	for bitbake-devel@lists.openembedded.org;
	Fri, 05 Aug 2011 00:45:52 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 04 Aug 2011 15:41:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,320,1309762800"; d="scan'208";a="34615628"
Received: from vorpal.jf.intel.com ([10.7.199.75])
	by orsmga002.jf.intel.com with ESMTP; 04 Aug 2011 15:41:20 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  4 Aug 2011 15:46:00 -0700
Message-Id: <3d66d4e64a6352c01662a24ee957eddcd3fde7fc.1312497858.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312497858.git.josh@linux.intel.com>
References: <cover.1312497858.git.josh@linux.intel.com>
In-Reply-To: <cover.1312497858.git.josh@linux.intel.com>
References: <cover.1312497858.git.josh@linux.intel.com>
Subject: [PATCH 1/2] bb/ui/hob: reset event handler once build complete
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
X-List-Received-Date: Thu, 04 Aug 2011 22:45:52 -0000

The HobEventHandler passes events on to RunningBuild when a build is in
progress. This patch resets the HobEventHandler to handle events when the
build is complete.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index a38868f..5906251 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -450,6 +450,8 @@ class MainWindow (gtk.Window):
         self.nb.set_current_page(0)
 
     def build_complete_cb(self, running_build):
+        # Have the handler process BB events again
+        self.handler.building = None
         self.stopping = False
         self.back.connect("clicked", self.back_button_clicked_cb)
         self.back.set_sensitive(True)
-- 
1.7.6



