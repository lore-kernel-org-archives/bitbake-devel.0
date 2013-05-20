Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1UeSBh-0006MC-2w
	for bitbake-devel@lists.openembedded.org;
	Mon, 20 May 2013 17:39:54 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 20 May 2013 08:20:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,707,1363158000"; d="scan'208";a="244169590"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.12.168])
	by AZSMGA002.ch.intel.com with ESMTP; 20 May 2013 08:20:20 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 May 2013 16:20:16 +0100
Message-Id: <f477bbdb42266bde95fdf4f43156edc08190cb98.1369063091.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1369063091.git.paul.eggleton@linux.intel.com>
References: <cover.1369063091.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1369063091.git.paul.eggleton@linux.intel.com>
References: <cover.1369063091.git.paul.eggleton@linux.intel.com>
Subject: [1.18][PATCH 3/3] data_smart.py: add some internal bitbake variables to configuration hash
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
X-List-Received-Date: Mon, 20 May 2013 15:40:07 -0000
X-List-Received-Date: Mon, 20 May 2013 15:40:07 -0000

From: Laurentiu Palcu <laurentiu.palcu@intel.com>

Take __BBTASKS, __BBHANDLERS and __BBANONFUNCS into account when
computing the configuration hash.

[YOCTO #4447]

(Bitbake master rev: 260ced7452405fc43ce3d9dd6798236aa07cc716)

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/data_smart.py | 10 ++++++++++
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
1.8.1.2



