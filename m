Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SDNy9-0002EZ-5t
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 00:37:25 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Mar 2012 15:28:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="123312765"
Received: from unknown (HELO shamshir.jf.intel.com) ([10.7.198.148])
	by orsmga001.jf.intel.com with ESMTP; 29 Mar 2012 15:28:13 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 15:28:09 -0700
Message-Id: <f04d09bdeff577f5c6557d7b14902095e0600625.1333060005.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1333060005.git.josh@linux.intel.com>
References: <cover.1333060005.git.josh@linux.intel.com>
In-Reply-To: <cover.1333060005.git.josh@linux.intel.com>
References: <cover.1333060005.git.josh@linux.intel.com>
Subject: [PATCH 2/3] lib/bb/ui/crumbs/hobpages: change title from HOB to Hob
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
X-List-Received-Date: Thu, 29 Mar 2012 22:37:25 -0000

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobpages.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobpages.py b/lib/bb/ui/crumbs/hobpages.py
index 024737d..d8e59c4 100755
--- a/lib/bb/ui/crumbs/hobpages.py
+++ b/lib/bb/ui/crumbs/hobpages.py
@@ -35,7 +35,7 @@ class HobPage (gtk.VBox):
         self.builder_width, self.builder_height = self.builder.size_request()
 
         if not title:
-            self.title = "HOB -- Image Creator"
+            self.title = "Hob -- Image Creator"
         else:
             self.title = title
 
-- 
1.7.7.6



