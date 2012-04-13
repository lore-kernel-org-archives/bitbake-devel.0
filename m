Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1SIcFe-0003aC-VN
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Apr 2012 10:53:07 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 13 Apr 2012 01:43:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="88643278"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.110])
	by AZSMGA002.ch.intel.com with ESMTP; 13 Apr 2012 01:43:43 -0700
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Apr 2012 16:37:18 +0800
Message-Id: <ecf8c3991f8ec465f509b40146974dd52b153841.1334306019.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1334306019.git.lianhao.lu@intel.com>
References: <cover.1334306019.git.lianhao.lu@intel.com>
Subject: [PATCH 1/1] Hob: Added required packages for toolchain.
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
X-List-Received-Date: Fri, 13 Apr 2012 08:53:07 -0000

Added the requried packages task-core-standalone-sdk-target(-dbg) for
building toolchain.

Fixed bug [YOCTO #2274]

Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
---
 lib/bb/ui/crumbs/hoblistmodel.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
index f5e3740..dd93e2a 100644
--- a/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/lib/bb/ui/crumbs/hoblistmodel.py
@@ -42,6 +42,8 @@ class PackageListModel(gtk.TreeStore):
                                 ()),
     }
 
+    __toolchain_required_packages__ = ["task-core-standalone-sdk-target", "task-core-standalone-sdk-target-dbg"]
+
     def __init__(self):
 
         self.contents = None
@@ -389,7 +391,7 @@ class PackageListModel(gtk.TreeStore):
                     child_it = self.iter_next(child_it)
             it = self.iter_next(it)
 
-        return packagelist
+        return list(set(packagelist + self.__toolchain_required_packages__));
     """
     Return the selected package size, unit is B.
     """
-- 
1.7.0.4



