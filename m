Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SJlzz-0005h1-Mu
	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Apr 2012 15:29:43 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 16 Apr 2012 06:20:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="89550300"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 16 Apr 2012 06:20:17 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Apr 2012 21:17:19 +0800
Message-Id: <3880b5f056e6a522fee8a7589fb20d4c0da36c91.1334582048.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334582048.git.dongxiao.xu@intel.com>
References: <cover.1334582048.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334582048.git.dongxiao.xu@intel.com>
References: <cover.1334582048.git.dongxiao.xu@intel.com>
Subject: [PATCH 2/2] data_smart: Improve the calculation of config hash
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
X-List-Received-Date: Mon, 16 Apr 2012 13:29:44 -0000

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



