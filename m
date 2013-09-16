Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 8B252605F2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 21:54:00 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM87Nx029322; Mon, 16 Sep 2013 23:08:08 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id urr0Jtfup-ST; Mon, 16 Sep 2013 23:08:08 +0100 (BST)
Received: from ted (bebox.config [93.97.175.187] (may be forged))
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM85jr029301
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 16 Sep 2013 23:08:06 +0100
Received: from richard by ted with local (Exim 4.80)
	(envelope-from <richard@dan.rpsys.net>)
	id 1VLgjr-0002ZZ-L8; Mon, 16 Sep 2013 22:53:47 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Sep 2013 22:53:24 +0100
Message-Id: <1379368413-9808-7-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 07/16] data: Cache an list of export variables
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 16 Sep 2013 21:54:01 -0000

Compute a cache of the list of potential export variables so
that we don't have to compute the list from scratch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py       | 2 +-
 lib/bb/data_smart.py | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index beaf089..ecac66c 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -342,7 +342,7 @@ def build_dependencies(key, keys, shelldeps, vardepvals, d):
 def generate_dependencies(d):
 
     keys = set(key for key in d if not key.startswith("__"))
-    shelldeps = set(key for key in keys if d.getVarFlag(key, "export") and not d.getVarFlag(key, "unexport"))
+    shelldeps = set(key for key in d.getVar("__exportlist", False) if d.getVarFlag(key, "export") and not d.getVarFlag(key, "unexport"))
     vardepvals = set(key for key in keys if d.getVarFlag(key, "vardepvalue"))
 
     deps = {}
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index a6a4b6c..1bb186e 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -578,6 +578,13 @@ class DataSmart(MutableMapping):
         if flag == "defaultval" and '_' in var:
             self._setvar_update_overrides(var)
 
+        if flag == "unexport" or flag == "export":
+            if not "__exportlist" in self.dict:
+                self._makeShadowCopy("__exportlist")
+            if not "_content" in self.dict["__exportlist"]:
+                self.dict["__exportlist"]["_content"] = set()
+            self.dict["__exportlist"]["_content"].add(var)
+
     def getVarFlag(self, var, flag, expand=False, noweakdefault=False):
         local_var = self._findVar(var)
         value = None
-- 
1.8.1.2


