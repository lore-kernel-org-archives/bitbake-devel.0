Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QcWtP-0007r2-U1
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jul 2011 08:07:56 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 Jun 2011 23:03:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,456,1304319600"; d="scan'208";a="21321696"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.228])
	by azsmga001.ch.intel.com with ESMTP; 30 Jun 2011 23:03:04 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jun 2011 23:02:47 -0700
Message-Id: <dadace9c070cb585eff83df44147afbfa0c83628.1309499227.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
Subject: [PATCH 01/10] ui/hob: Fixed the "build again" hang.
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
X-List-Received-Date: Fri, 01 Jul 2011 06:07:56 -0000

From: Lianhao Lu <lianhao.lu@intel.com>

Using gobject.threads_init() instead of gtk.gdk.threads_init(). These
two modes are conflict to each other. Using gobject.threads_init()
allows only the main thread to touch GUI(gtk) part.

Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index ab6022b..175e5bd 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -76,7 +76,7 @@ class MainWindow (gtk.Window):
         label.show()
         response = dialog.run()
         dialog.destroy()
-        if not response == gtk.RESPONSE_YES:
+        if response == gtk.RESPONSE_YES:
             self.model.reset() # NOTE: really?
             self.nb.set_current_page(0)
         return
@@ -555,7 +555,6 @@ class MainWindow (gtk.Window):
 
 def main (server, eventHandler):
     gobject.threads_init()
-    gtk.gdk.threads_init()
 
     taskmodel = TaskListModel()
     handler = HobHandler(taskmodel, server)
-- 
1.7.5.4



