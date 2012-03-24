Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SBEtu-0001JU-3H
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 01:32:10 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 23 Mar 2012 17:23:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="121096266"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.82])
	by orsmga001.jf.intel.com with ESMTP; 23 Mar 2012 17:23:10 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Mar 2012 17:23:05 -0700
Message-Id: <e750e728f211db865fcd1740cc1fa19a23485128.1332545580.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
In-Reply-To: <cover.1332545580.git.josh@linux.intel.com>
References: <cover.1332545580.git.josh@linux.intel.com>
Subject: [PATCH 7/9] lib/bb/ui/crumbs/persistenttooltip: ensure a reasonable minimum size
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
X-List-Received-Date: Sat, 24 Mar 2012 00:32:10 -0000

The persistent tooltip looks a little weird when it's too small, request
that the toolkit and WM give it a reasonable minimum size.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/persistenttooltip.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/persistenttooltip.py b/lib/bb/ui/crumbs/persistenttooltip.py
index e184062..69e059b 100644
--- a/lib/bb/ui/crumbs/persistenttooltip.py
+++ b/lib/bb/ui/crumbs/persistenttooltip.py
@@ -73,6 +73,9 @@ class PersistentTooltip(gtk.Window):
         self.set_position(gtk.WIN_POS_MOUSE)
         self.set_opacity(0.95)
 
+        # Ensure a reasonable minimum size
+        self.set_geometry_hints(self, 100, 50)
+
         # Draw our label and close buttons
         hbox = gtk.HBox(False, 0)
         hbox.show()
-- 
1.7.7.6



