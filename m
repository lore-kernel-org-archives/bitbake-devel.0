Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <laurentiu.palcu@intel.com>) id 1UYHPJ-0005rh-JK
	for bitbake-devel@lists.openembedded.org;
	Fri, 03 May 2013 16:56:22 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 03 May 2013 07:37:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,605,1363158000"; d="scan'208";a="297106375"
Received: from lpalcu-linux.rb.intel.com ([10.237.105.165])
	by azsmga001.ch.intel.com with ESMTP; 03 May 2013 07:37:18 -0700
From: Laurentiu Palcu <laurentiu.palcu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 May 2013 17:37:17 +0300
Message-Id: <1367591837-9516-1-git-send-email-laurentiu.palcu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] data_smart.py: add some internal bitbake variables to configuration hash
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
X-List-Received-Date: Fri, 03 May 2013 14:56:23 -0000

Take __BBTASKS, __BBHANDLERS and __BBANONFUNCS into account when
computing the configuration hash.

[YOCTO #4447]

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@intel.com>
---
 bitbake/lib/bb/data_smart.py |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 5bf11e5..2fd8ccd 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -738,5 +738,15 @@ class DataSmart(MutableMapping):
             value = d.getVar(key, False) or ""
             data.update({key:value})
 
+        for key in ["__BBTASKS", "__BBANONFUNCS", "__BBHANDLERS"]:
+            bb_list = d.getVar(key, False) or []
+            bb_list.sort()
+            data.update({key:str(bb_list)})
+
+            if key == "__BBANONFUNCS":
+                for i in bb_list:
+                    value = d.getVar(i, True) or ""
+                    data.update({i:value})
+
         data_str = str([(k, data[k]) for k in sorted(data.keys())])
         return hashlib.md5(data_str).hexdigest()
-- 
1.7.9.5



