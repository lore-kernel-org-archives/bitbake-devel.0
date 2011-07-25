Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QlQJr-0005y1-Ce
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Jul 2011 20:55:59 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 25 Jul 2011 11:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,264,1309762800"; d="scan'208";a="29903201"
Received: from vorpal.jf.intel.com ([10.7.199.57])
	by orsmga002.jf.intel.com with ESMTP; 25 Jul 2011 11:51:41 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Jul 2011 11:56:12 -0700
Message-Id: <aeb1b4abed5522f7e7153ec2a2edb8c29fbda4e5.1311620081.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311620081.git.josh@linux.intel.com>
References: <cover.1311620081.git.josh@linux.intel.com>
In-Reply-To: <cover.1311620081.git.josh@linux.intel.com>
References: <cover.1311620081.git.josh@linux.intel.com>
Subject: [PATCH 4/4] cooker: only append files once
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
X-List-Received-Date: Mon, 25 Jul 2011 18:55:59 -0000

A list can contain the same value twice, therefore only append to the
appendlist for a recipe if the append file is not already in the list.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/cooker.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 94e8d09..1f305d9 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1205,7 +1205,8 @@ class BBCooker:
             base = os.path.basename(f).replace('.bbappend', '.bb')
             if not base in self.appendlist:
                self.appendlist[base] = []
-            self.appendlist[base].append(f)
+            if f not in self.appendlist[base]:
+                self.appendlist[base].append(f)
 
         # Find overlayed recipes
         # bbfiles will be in priority order which makes this easy
-- 
1.7.6



