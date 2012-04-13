Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SIpzp-0000YN-3h
	for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 01:33:41 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 13 Apr 2012 16:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130756368"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.191])
	by azsmga001.ch.intel.com with ESMTP; 13 Apr 2012 16:24:14 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Apr 2012 16:24:10 -0700
Message-Id: <4f66d9fee5688a26c25cf4a0b2864bcc30d1a0ad.1334359239.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1334359238.git.josh@linux.intel.com>
References: <cover.1334359238.git.josh@linux.intel.com>
In-Reply-To: <cover.1334359238.git.josh@linux.intel.com>
References: <cover.1334359238.git.josh@linux.intel.com>
Subject: [PATCH 4/4] hob: update required pygtk to 2.22.0 and gtk+ to 2.20.0
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
X-List-Received-Date: Fri, 13 Apr 2012 23:33:41 -0000

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 6cd9579..97f54ef 100755
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -30,7 +30,7 @@ try:
     pygtk.require('2.0') # to be certain we don't have gtk+ 1.x !?!
     gtkver = gtk.gtk_version
     pygtkver = gtk.pygtk_version
-    if gtkver  < (2, 18, 0) or pygtkver < (2, 16, 0):
+    if gtkver  < (2, 20, 0) or pygtkver < (2, 22, 0):
         sys.exit("%s,\nYou have Gtk+ %s and PyGtk %s." % (requirements,
                 ".".join(map(str, gtkver)),
                 ".".join(map(str, pygtkver))))
-- 
1.7.7.6



