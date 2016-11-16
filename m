Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8D3FC6003C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Nov 2016 11:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uAGBKme6013897 for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Nov 2016 11:20:48 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TV64xgizyHPE for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Nov 2016 11:20:48 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uAGBKgke013892
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Nov 2016 11:20:43 GMT
Message-ID: <1479295242.28508.8.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 16 Nov 2016 11:20:42 +0000
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] data_smart: Default to expansion for getVar/getVarFlags
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
X-List-Received-Date: Wed, 16 Nov 2016 11:20:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

We've been building to this for a while, default to return expanded
values for getVar/getVarFlags.

We can then go through and remove the "True" option to many of the
calls to this function, all function calls should have a default by now
though since the parameter has been required for a while.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 67c0248..49223a4 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -565,7 +565,7 @@ class DataSmart(MutableMapping):
                 if len(shortvar) == 0:
                     override = None
 
-    def getVar(self, var, expand, noweakdefault=False, parsing=False):
+    def getVar(self, var, expand=True, noweakdefault=False, parsing=False):
         return self.getVarFlag(var, "_content", expand, noweakdefault, parsing)
 
     def renameVar(self, key, newkey, **loginfo):
@@ -662,7 +662,7 @@ class DataSmart(MutableMapping):
                 self.dict["__exportlist"]["_content"] = set()
             self.dict["__exportlist"]["_content"].add(var)
 
-    def getVarFlag(self, var, flag, expand, noweakdefault=False, parsing=False):
+    def getVarFlag(self, var, flag, expand=True, noweakdefault=False, parsing=False):
         local_var = self._findVar(var)
         value = None
         if flag == "_content" and var in self.overridedata and not parsing:



