Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1Safsu-0001xi-LJ
	for bitbake-devel@lists.openembedded.org;
	Sat, 02 Jun 2012 06:24:16 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 01 Jun 2012 21:13:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="173895782"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2012 21:13:49 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  2 Jun 2012 12:54:36 +0800
Message-Id: <5b4c1d6a5c75f186454ed87614e4e9926f5b2d3a.1338612620.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1338612620.git.shane.wang@intel.com>
References: <cover.1338612620.git.shane.wang@intel.com>
Subject: [PATCH 1/3] Hob: lower the limitation for PyGTK
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
X-List-Received-Date: Sat, 02 Jun 2012 04:24:16 -0000

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/hob.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/hob.py b/bitbake/lib/bb/ui/hob.py
index 97f54ef..9ec32b1 100755
--- a/bitbake/lib/bb/ui/hob.py
+++ b/bitbake/lib/bb/ui/hob.py
@@ -30,7 +30,7 @@ try:
     pygtk.require('2.0') # to be certain we don't have gtk+ 1.x !?!
     gtkver = gtk.gtk_version
     pygtkver = gtk.pygtk_version
-    if gtkver  < (2, 20, 0) or pygtkver < (2, 22, 0):
+    if gtkver  < (2, 20, 0) or pygtkver < (2, 21, 0):
         sys.exit("%s,\nYou have Gtk+ %s and PyGtk %s." % (requirements,
                 ".".join(map(str, gtkver)),
                 ".".join(map(str, pygtkver))))
-- 
1.7.6



