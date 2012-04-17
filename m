Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SK2qb-00048K-JH
	for bitbake-devel@lists.openembedded.org;
	Tue, 17 Apr 2012 09:29:09 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 17 Apr 2012 00:19:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="130527675"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 17 Apr 2012 00:19:43 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Apr 2012 15:16:43 +0800
Message-Id: <4b11b96fa644084391a9f3090f9b1ac5e9b71766.1334646853.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334646853.git.dongxiao.xu@intel.com>
References: <cover.1334646853.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334646853.git.dongxiao.xu@intel.com>
References: <cover.1334646853.git.dongxiao.xu@intel.com>
Subject: [PATCH 2/3] data_smart: Improve the calculation of config hash
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
X-List-Received-Date: Tue, 17 Apr 2012 07:29:09 -0000

For config hash, we put the keys in structure of "set()", which is not
order sensitive. Therefore when calculating the md5 value for config
hash, we need to identify the order of the keys.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/data_smart.py |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 2c200db..27fb7d9 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -462,13 +462,14 @@ class DataSmart(MutableMapping):
         self.delVar(var)
 
     def get_hash(self):
-        data = ""
+        data = {}
         config_whitelist = set((self.getVar("BB_HASHCONFIG_WHITELIST", True) or "").split())
         keys = set(key for key in iter(self) if not key.startswith("__"))
         for key in keys:
             if key in config_whitelist:
                 continue
             value = self.getVar(key, False) or ""
-            data = data + key + ': ' + str(value) + '\n'
+            data.update({key:value})
 
-        return hashlib.md5(data).hexdigest()
+        data_str = str([(k, data[k]) for k in sorted(data.keys())])
+        return hashlib.md5(data_str).hexdigest()
-- 
1.7.4.1



