Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S1AhC-0007bw-Co
	for bitbake-devel@lists.openembedded.org;
	Sat, 25 Feb 2012 07:01:26 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 24 Feb 2012 21:53:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="110641961"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.27])
	by azsmga001.ch.intel.com with ESMTP; 24 Feb 2012 21:53:00 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Feb 2012 21:52:58 -0800
Message-Id: <e321d0a6b4c40f0f2c13a191ae1ddf7165c45ff4.1330149082.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1330149082.git.josh@linux.intel.com>
References: <cover.1330149082.git.josh@linux.intel.com>
In-Reply-To: <cover.1330149082.git.josh@linux.intel.com>
References: <cover.1330149082.git.josh@linux.intel.com>
Subject: [PATCH 1/1] crumbs: add back progress implementation for depexp
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
X-List-Received-Date: Sat, 25 Feb 2012 06:01:26 -0000

The commit which introduced the new hob UI also deleted this class
which is used by depexp.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/progress.py |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 lib/bb/ui/crumbs/progress.py

diff --git a/lib/bb/ui/crumbs/progress.py b/lib/bb/ui/crumbs/progress.py
new file mode 100644
index 0000000..0c7ad96
--- /dev/null
+++ b/lib/bb/ui/crumbs/progress.py
@@ -0,0 +1,20 @@
+import gtk
+
+class ProgressBar(gtk.Dialog):
+    def __init__(self, parent):
+
+        gtk.Dialog.__init__(self, flags=(gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT))
+        self.set_title("Parsing metadata, please wait...")
+        self.set_default_size(500, 0)
+        self.set_transient_for(parent)
+        self.progress = gtk.ProgressBar()
+        self.vbox.pack_start(self.progress)
+        self.show_all()
+
+    def update(self, x, y):
+        self.progress.set_fraction(float(x)/float(y))
+        self.progress.set_text("%2d %%" % (x*100/y))
+
+    def pulse(self):
+        self.progress.set_text("Loading...")
+        self.progress.pulse()
-- 
1.7.7.6



