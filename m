Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S21sX-00039o-7q
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Feb 2012 15:48:41 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 27 Feb 2012 06:39:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="112246817"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 27 Feb 2012 06:38:59 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Feb 2012 22:37:32 +0800
Message-Id: <a5c0bd3087873d7b3faa9801315eb12460301cd5.1330353017.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1330353017.git.dongxiao.xu@intel.com>
References: <cover.1330353017.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1330353017.git.dongxiao.xu@intel.com>
References: <cover.1330353017.git.dongxiao.xu@intel.com>
Subject: [PATCH 1/1] data_smart.py: Uses BB_HASHCONFIG_WHITELIST to filter unnecessary variables
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
X-List-Received-Date: Mon, 27 Feb 2012 14:48:41 -0000

Adopt the BB_HASHCONFIG_WHITELIST as a exclusion list for variables that are
not needed in cache hash calculation.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
CC: Christopher Larson <kergoth@gmail.com>
CC: Martin Jansa <martin.jansa@gmail.com>
CC: Andreas Oberritter <obi@opendreambox.org>
---
 lib/bb/data_smart.py |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 24c7a8f..7765f81 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -463,20 +463,12 @@ class DataSmart(MutableMapping):
 
     def get_hash(self):
         data = ""
-        keys = iter(self)
+        config_whitelist = set((self.getVar("BB_HASHCONFIG_WHITELIST", True) or "").split())
+        keys = set(key for key in iter(self) if not key.startswith("__"))
         for key in keys:
-            if key in ["TIME", "DATE"]:
+            if key in config_whitelist:
                 continue
-            if key == "__depends":
-                deps = list(self.getVar(key, False))
-                deps.sort()
-                value = [deps[i][0] for i in range(len(deps))]
-            elif key == "PATH":
-                path = list(set(self.getVar(key, False).split(':')))
-                path.sort()
-                value = " ".join(path)
-            else:
-                value = self.getVar(key, False) or ""
+            value = self.getVar(key, False) or ""
             data = data + key + ': ' + str(value) + '\n'
 
         return hashlib.md5(data).hexdigest()
-- 
1.7.4.1



