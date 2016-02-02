Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4A92B7730B;
	Tue,  2 Feb 2016 23:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u12NsShv006340; Tue, 2 Feb 2016 23:55:41 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TkeDc1XP1zrt; Tue,  2 Feb 2016 23:55:41 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u12NtbCj006438
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 2 Feb 2016 23:55:38 GMT
Message-ID: <1454457337.27087.142.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 02 Feb 2016 23:55:37 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>
Subject: [PATCH] data_smart: Drop default expand=False to getVarFlag [API change]
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
X-List-Received-Date: Tue, 02 Feb 2016 23:55:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

At some point in the future, getVarFlag should expand by default. To
get there from the current position, we need a period of time where the
expand parameter is mandatory.

This patch starts that process. Clear errors will result from any code
which doesn't provide this. Layers can be fixed with an expression
like:

sed -e 's:\(\.getVarFlag([^,()]*, [^,()]*\)):\1, False):g' -i `grep -ril getVar *`

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 79bec1b..d61ad53 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -663,7 +663,7 @@ class DataSmart(MutableMapping):
                 self.dict["__exportlist"]["_content"] = set()
             self.dict["__exportlist"]["_content"].add(var)
 
-    def getVarFlag(self, var, flag, expand=False, noweakdefault=False, parsing=False):
+    def getVarFlag(self, var, flag, expand, noweakdefault=False, parsing=False):
         local_var = self._findVar(var)
         value = None
         if flag == "_content" and var in self.overridedata and not parsing:



