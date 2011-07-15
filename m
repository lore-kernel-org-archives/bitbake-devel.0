Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qhow2-00046x-6W
	for bitbake-devel@lists.openembedded.org;
	Fri, 15 Jul 2011 22:24:30 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 15 Jul 2011 13:20:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,210,1309762800"; d="scan'208";a="27770695"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.32])
	by azsmga001.ch.intel.com with ESMTP; 15 Jul 2011 13:20:25 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jul 2011 13:20:14 -0700
Message-Id: <eff8e39b291184845f7f5f67e85809d9729b74cf.1310761024.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1310761024.git.josh@linux.intel.com>
References: <cover.1310761024.git.josh@linux.intel.com>
In-Reply-To: <cover.1310761024.git.josh@linux.intel.com>
References: <cover.1310761024.git.josh@linux.intel.com>
Subject: [PATCH 2/6] ui/crumbs/hobprefs: add missing import
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
X-List-Received-Date: Fri, 15 Jul 2011 20:24:30 -0000

glib.idle_add is used so the glib module must be imported

Fixes [YOCTO #1248]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobprefs.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobprefs.py b/lib/bb/ui/crumbs/hobprefs.py
index f186410..779c14a 100644
--- a/lib/bb/ui/crumbs/hobprefs.py
+++ b/lib/bb/ui/crumbs/hobprefs.py
@@ -19,6 +19,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import gtk
+import glib
 from bb.ui.crumbs.configurator import Configurator
 
 class HobPrefs(gtk.Dialog):
-- 
1.7.6



