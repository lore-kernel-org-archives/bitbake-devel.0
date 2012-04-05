Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SFraK-0001vm-VR
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 20:39:06 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 05 Apr 2012 11:29:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="129138840"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.114])
	by orsmga002.jf.intel.com with ESMTP; 05 Apr 2012 11:29:41 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  5 Apr 2012 11:29:38 -0700
Message-Id: <4eb4b6236f3a6b082ccd1306de21e08037c86041.1333650445.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1333650445.git.josh@linux.intel.com>
References: <cover.1333650445.git.josh@linux.intel.com>
In-Reply-To: <cover.1333650445.git.josh@linux.intel.com>
References: <cover.1333650445.git.josh@linux.intel.com>
Subject: [PATCH 3/3] hob: update required versions of (py)gtk et al
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
X-List-Received-Date: Thu, 05 Apr 2012 18:39:06 -0000

With the previous two changes we now work on Gtk+ 2.18 and PyGtk 2.16

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 1321ebb..6cd9579 100755
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -22,15 +22,18 @@
 
 import sys
 import os
-requirements = "FATAL: pygtk (version 2.22.0 or later) and pygobject are required to use Hob"
+requirements = "FATAL: Gtk+, PyGtk and PyGobject are required to use Hob"
 try:
     import gobject
     import gtk
     import pygtk
     pygtk.require('2.0') # to be certain we don't have gtk+ 1.x !?!
-    ver = gtk.pygtk_version
-    if ver  < (2, 22, 0):
-        sys.exit("%s (you have pygtk %s.%s.%s)." % (requirements, ver[0], ver[1], ver[2]))
+    gtkver = gtk.gtk_version
+    pygtkver = gtk.pygtk_version
+    if gtkver  < (2, 18, 0) or pygtkver < (2, 16, 0):
+        sys.exit("%s,\nYou have Gtk+ %s and PyGtk %s." % (requirements,
+                ".".join(map(str, gtkver)),
+                ".".join(map(str, pygtkver))))
 except ImportError as exc:
     sys.exit("%s (%s)." % (requirements, str(exc)))
 sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(__file__))))
-- 
1.7.7.6



