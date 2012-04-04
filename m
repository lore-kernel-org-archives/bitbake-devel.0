Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SFELN-0007WZ-Hr
	for bitbake-devel@lists.openembedded.org;
	Wed, 04 Apr 2012 02:45:01 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 03 Apr 2012 17:35:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="137319125"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.117])
	by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2012 17:35:42 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Apr 2012 17:35:41 -0700
Message-Id: <44c725f736689467b237b57d5c2bfe4f7d937bc5.1333499344.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1333499343.git.josh@linux.intel.com>
References: <cover.1333499343.git.josh@linux.intel.com>
In-Reply-To: <cover.1333499343.git.josh@linux.intel.com>
References: <cover.1333499343.git.josh@linux.intel.com>
Subject: [PATCH 1/1] lib/bb/ui/hob: exit cleanly if the required pygtk version isn't available
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
X-List-Received-Date: Wed, 04 Apr 2012 00:45:01 -0000

Hob uses API from pygtk 2.22, therefore check to see whether this
version is available and exit cleanly if not.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index e72ab23..1321ebb 100755
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -20,10 +20,19 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-import gobject
-import gtk
 import sys
 import os
+requirements = "FATAL: pygtk (version 2.22.0 or later) and pygobject are required to use Hob"
+try:
+    import gobject
+    import gtk
+    import pygtk
+    pygtk.require('2.0') # to be certain we don't have gtk+ 1.x !?!
+    ver = gtk.pygtk_version
+    if ver  < (2, 22, 0):
+        sys.exit("%s (you have pygtk %s.%s.%s)." % (requirements, ver[0], ver[1], ver[2]))
+except ImportError as exc:
+    sys.exit("%s (%s)." % (requirements, str(exc)))
 sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(__file__))))
 try:
     import bb
-- 
1.7.7.6



