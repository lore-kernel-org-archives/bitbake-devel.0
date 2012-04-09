Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SHAMM-00076R-1J
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 10:54:02 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 09 Apr 2012 01:44:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="151415300"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 09 Apr 2012 01:44:45 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 16:41:58 +0800
Message-Id: <ccb22c39f4aeb8e310f9a6f8e0f9c55c18ac6891.1333960654.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333960654.git.dongxiao.xu@intel.com>
References: <cover.1333960654.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333960654.git.dongxiao.xu@intel.com>
References: <cover.1333960654.git.dongxiao.xu@intel.com>
Subject: [PATCH 2/6] data_smart: Improve the calculation of config hash
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
X-List-Received-Date: Mon, 09 Apr 2012 08:54:02 -0000

The order of keys are not sensitive for config hash, so we need to
identify its order while calculating the md5 value.

While for certain values, order is also not sensitive (for example,
BBINCLUDED), we also need to identify its order while calculating md5
value.

This could fix the problem that Martin Jansa reported in the mailing
list:

http://lists.linuxtogo.org/pipermail/bitbake-devel/2012-March/002122.html

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/data_smart.py |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 2c200db..cc61a03 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -462,13 +462,17 @@ class DataSmart(MutableMapping):
         self.delVar(var)
 
     def get_hash(self):
-        data = ""
+        data = {}
         config_whitelist = set((self.getVar("BB_HASHCONFIG_WHITELIST", True) or "").split())
+        config_sort = set((self.getVar("BB_HASHCONFIG_SORT", True) or "").split())
         keys = set(key for key in iter(self) if not key.startswith("__"))
         for key in keys:
             if key in config_whitelist:
                 continue
             value = self.getVar(key, False) or ""
-            data = data + key + ': ' + str(value) + '\n'
+            if key in config_sort:
+                value = " ".join(sorted(value.split()))
+            data.update({key:value})
 
-        return hashlib.md5(data).hexdigest()
+        data_str = str([(k, data[k]) for k in sorted(data.keys())])
+        return hashlib.md5(data_str).hexdigest()
-- 
1.7.4.1



