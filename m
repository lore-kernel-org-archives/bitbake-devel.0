Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R6BSg-0000IM-1d
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Sep 2011 03:18:54 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 20 Sep 2011 18:13:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,414,1312182000"; d="scan'208";a="53811751"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.183])
	by fmsmga001.fm.intel.com with ESMTP; 20 Sep 2011 18:13:33 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Sep 2011 18:13:26 -0700
Message-Id: <d2b9167a7b0eb3fcb31d64f915beef41aac659a5.1316567365.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.2
In-Reply-To: <cover.1316567365.git.josh@linux.intel.com>
References: <cover.1316567365.git.josh@linux.intel.com>
In-Reply-To: <cover.1316567365.git.josh@linux.intel.com>
References: <cover.1316567365.git.josh@linux.intel.com>
Subject: [PATCH 1/2] ui/crumbs/runningbuild: fix log messages right-click menu
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
X-List-Received-Date: Wed, 21 Sep 2011 01:18:54 -0000

Pass the correct callback name to the connect method.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/runningbuild.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/runningbuild.py b/lib/bb/ui/crumbs/runningbuild.py
index e429715..bd0cbf0 100644
--- a/lib/bb/ui/crumbs/runningbuild.py
+++ b/lib/bb/ui/crumbs/runningbuild.py
@@ -325,7 +325,7 @@ class RunningBuildTreeView (gtk.TreeView):
                     menu = gtk.Menu()
                     menuitem = gtk.MenuItem("Copy")
                     menu.append(menuitem)
-                    menuitem.connect("activate", self.copy_handler, (model, it))
+                    menuitem.connect("activate", self.clipboard_handler, (model, it))
                     menuitem.show()
                     menuitem = gtk.MenuItem("Send log to pastebin")
                     menu.append(menuitem)
-- 
1.7.6.2



