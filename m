Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1QxwPD-00019t-AD
	for bitbake-devel@lists.openembedded.org;
	Mon, 29 Aug 2011 09:37:15 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 29 Aug 2011 00:31:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,295,1312182000"; d="scan'208";a="43427786"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.52])
	by azsmga001.ch.intel.com with ESMTP; 29 Aug 2011 00:31:17 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Aug 2011 15:33:58 +0800
Message-Id: <a27f9fa325927a2b0c2204f648f762463c62a8f0.1314603042.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1314603042.git.dongxiao.xu@intel.com>
References: <cover.1314603042.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1314603042.git.dongxiao.xu@intel.com>
References: <cover.1314603042.git.dongxiao.xu@intel.com>
Subject: [PATCH 1/1] data_smart.py: make use of expand cache in getVar()
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
X-List-Received-Date: Mon, 29 Aug 2011 07:37:15 -0000

Currently if passing expand=True to getVar() function, it will pass the
handling to getVarFlag(), which doesn't get any benefit from the expand
cache.

Call the expand() function separately in getVar() to make use of the
expand cache, which can decrease the parsing time by 40%.
(from current 49s to 27s)

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/data_smart.py |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 301f9e3..d8ba24f 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -268,7 +268,12 @@ class DataSmart(MutableMapping):
         self.dict[var]["content"] = value
 
     def getVar(self, var, expand=False, noweakdefault=False):
-        return self.getVarFlag(var, "content", expand, noweakdefault)
+        value = self.getVarFlag(var, "content", False, noweakdefault)
+
+        # Call expand() separately to make use of the expand cache
+        if expand and value:
+            return self.expand(value, var)
+        return value
 
     def renameVar(self, key, newkey):
         """
-- 
1.7.1



