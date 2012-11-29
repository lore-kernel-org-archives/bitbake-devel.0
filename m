Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Te1ak-0004n9-Jv for bitbake-devel@lists.openembedded.org;
	Thu, 29 Nov 2012 11:43:54 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qATATNrg023162
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Nov 2012 10:29:23 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 22465-01 for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Nov 2012 10:29:19 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qATATGPW023155
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Nov 2012 10:29:18 GMT
Message-ID: <1354184946.4943.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 29 Nov 2012 10:29:06 +0000
Mime-Version: 1.0
X-Mailer: Evolution 3.2.3-0ubuntu6 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] data_smart: Improve get_hash to account for overrides and key expansion
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
X-List-Received-Date: Thu, 29 Nov 2012 10:43:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

An issue was uncovered where changing:

IMAGE_INSTALL_append = "X"

to

IMAGE_INSTALL_append = "X Y"

in local.conf would not get noticed by bitbake. The issue is that
the configuration hash doesn't account for overrides or key expansion.

This patch improves get_hash to account for these. This means the hash
does account for changes like the above.

[YOCTO #3503]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index ec3c04e..fb8d9d5 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -474,12 +474,16 @@ class DataSmart(MutableMapping):
 
     def get_hash(self):
         data = {}
-        config_whitelist = set((self.getVar("BB_HASHCONFIG_WHITELIST", True) or "").split())
-        keys = set(key for key in iter(self) if not key.startswith("__"))
+        d = self.createCopy()
+        bb.data.expandKeys(d)
+        bb.data.update_data(d)
+
+        config_whitelist = set((d.getVar("BB_HASHCONFIG_WHITELIST", True) or "").split())
+        keys = set(key for key in iter(d) if not key.startswith("__"))
         for key in keys:
             if key in config_whitelist:
                 continue
-            value = self.getVar(key, False) or ""
+            value = d.getVar(key, False) or ""
             data.update({key:value})
 
         data_str = str([(k, data[k]) for k in sorted(data.keys())])




