Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SAXco-0000Mz-Mq
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 03:19:38 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 21 Mar 2012 19:10:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="131778630"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.222])
	by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2012 19:10:39 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 19:10:35 -0700
Message-Id: <2f70813e177d483b83392a775ca5bad4c7f7f629.1332381654.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332381654.git.josh@linux.intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
In-Reply-To: <cover.1332381654.git.josh@linux.intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
Subject: [PATCH 10/10] lib/bb/ui/crumbs/hig: disable removal of meta-hob layer
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
X-List-Received-Date: Thu, 22 Mar 2012 02:19:38 -0000

The Hob GUI requires the meta-hob layer to function so prevent its removal
as we do with the core meta layer.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hig.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 05ac8d4..38f0f80 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -1007,7 +1007,7 @@ class LayerSelectionDialog (CrumbsDialog):
         # Trailing slashes are uncommon in bblayers.conf but confuse os.path.basename
         path.rstrip('/')
         name = os.path.basename(path)
-        if name == "meta":
+        if name == "meta" or name == "meta-hob":
             cell.set_sensitive(False)
             cell.set_property('pixbuf', None)
             cell.set_property('mode', gtk.CELL_RENDERER_MODE_INERT)
@@ -1028,6 +1028,8 @@ class LayerSelectionDialog (CrumbsDialog):
         name = os.path.basename(path)
         if name == "meta":
             cell.set_property('markup', "<b>Core layer for images: it cannot be removed</b>\n%s" % path)
+        elif name == "meta-hob":
+            cell.set_property('markup', "<b>Core layer for Hob: it cannot be removed</b>\n%s" % path)
         else:
             cell.set_property('text', path)
 
-- 
1.7.7.6



