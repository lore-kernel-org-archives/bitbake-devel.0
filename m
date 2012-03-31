Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SDmtt-0004o1-2y
	for bitbake-devel@lists.openembedded.org;
	Sat, 31 Mar 2012 03:14:41 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 30 Mar 2012 18:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="148061241"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.226])
	by fmsmga002.fm.intel.com with ESMTP; 30 Mar 2012 18:05:34 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Mar 2012 18:05:29 -0700
Message-Id: <72c1e44f0bc8b40583d16ff8b396faf8cf62fed9.1333155656.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1333155656.git.josh@linux.intel.com>
References: <cover.1333155656.git.josh@linux.intel.com>
In-Reply-To: <cover.1333155656.git.josh@linux.intel.com>
References: <cover.1333155656.git.josh@linux.intel.com>
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
X-List-Received-Date: Sat, 31 Mar 2012 01:14:41 -0000

Hob uses API from pygtk 2.22, therefore check to see whether this
version is available and exit cleanly if not.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index e72ab23..2f595cb 100755
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -20,10 +20,17 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-import gobject
-import gtk
 import sys
 import os
+try:
+    import gobject
+    import gtk
+    import pygtk
+    pygtk.require('2.0') # to be certain we don't have gtk+ 1.x !?!
+    if gtk.pygtk_version < (2, 22, 0):
+        sys.exit("FATAL: PyGtk version 2.22.x or later is required to use Hob")
+except:
+    sys.exit("FATAL: PyGtk (version 2.22.x or later) is required to use Hob")
 sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(__file__))))
 try:
     import bb
-- 
1.7.7.6



