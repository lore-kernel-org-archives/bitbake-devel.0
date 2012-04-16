Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SJhM3-0006Av-Ke
	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Apr 2012 10:32:12 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 16 Apr 2012 01:22:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="154059316"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 16 Apr 2012 01:22:48 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Apr 2012 16:53:27 +0800
Message-Id: <395e04713e9714aeedb15553de9334a48403a495.1334565351.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1334565351.git.shane.wang@intel.com>
References: <cover.1334565351.git.shane.wang@intel.com>
Subject: [PATCH 1/2] Hob: fixed the issue that the notebook overlay-scrollbar is overlapped
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
X-List-Received-Date: Mon, 16 Apr 2012 08:32:12 -0000

From: Liming An <limingx.l.an@intel.com>

In those systems which had use gtk overlay-scrollbar feature,such as
Ubuntu 11.10, we have the issue with the multiple overlaped scrollbar in
'Recipe View' notebook or 'Package View' notebook, this patch is going to
fix it.

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index a42cdec..490de4a 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -165,7 +165,6 @@ class HobViewTable (gtk.VBox):
 
         scroll = gtk.ScrolledWindow()
         scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
-        scroll.set_shadow_type(gtk.SHADOW_IN)
         scroll.add(self.table_tree)
         self.pack_start(scroll, True, True, 0)
 
-- 
1.7.6



