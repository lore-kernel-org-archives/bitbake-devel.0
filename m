Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QoQA1-0006Dv-Tu
	for bitbake-devel@lists.openembedded.org;
	Wed, 03 Aug 2011 03:22:14 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 02 Aug 2011 18:17:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,307,1309762800"; d="scan'208";a="33627962"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.215])
	by orsmga002.jf.intel.com with ESMTP; 02 Aug 2011 18:17:47 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Aug 2011 18:17:37 -0700
Message-Id: <d1d6bfab1789d8c0a4faa109bcc06b3cefe62620.1312334047.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312334047.git.josh@linux.intel.com>
References: <cover.1312334047.git.josh@linux.intel.com>
In-Reply-To: <cover.1312334047.git.josh@linux.intel.com>
References: <cover.1312334047.git.josh@linux.intel.com>
Subject: [PATCH 4/6] ui/crumbs/runningbuild: add optional readonly mode, default off
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
X-List-Received-Date: Wed, 03 Aug 2011 01:22:14 -0000

In b947e7aa405966262c0614cae02e7978ec637095 Bob started to introduce code
for a right-click menu, whilst most of the code is non-invasive it does
enable the editable property of the gtk.TreeView which can be confusing.

This change adds a readonly parameter, defaulting to False, to the
RunningBuildTreeView which if True will prevent the editable property from
being set.

CC: Bob Foerster <robert@erafx.com>
Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/runningbuild.py |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/runningbuild.py b/lib/bb/ui/crumbs/runningbuild.py
index c4d6d33..2399ff3 100644
--- a/lib/bb/ui/crumbs/runningbuild.py
+++ b/lib/bb/ui/crumbs/runningbuild.py
@@ -277,8 +277,9 @@ class RunningBuildTreeView (gtk.TreeView):
     __gsignals__ = {
         "button_press_event" : "override"
         }
-    def __init__ (self):
+    def __init__ (self, readonly=False):
         gtk.TreeView.__init__ (self)
+        self.readonly = readonly
 
         # The icon that indicates whether we're building or failed.
         renderer = gtk.CellRendererPixbuf ()
@@ -290,7 +291,7 @@ class RunningBuildTreeView (gtk.TreeView):
         self.message_renderer = gtk.CellRendererText ()
         self.message_column = gtk.TreeViewColumn ("Message", self.message_renderer, text=3)
         self.message_column.add_attribute(self.message_renderer, 'background', 5)
-        self.message_renderer.set_property('editable', 5)
+        self.message_renderer.set_property('editable', (not self.readonly))
         self.append_column (self.message_column)
 
     def do_button_press_event(self, event):
-- 
1.7.6



