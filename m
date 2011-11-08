Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RNq67-0007Zz-Gw for bitbake-devel@lists.openembedded.org;
	Tue, 08 Nov 2011 19:08:35 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pA8I2KZb003498
	for <bitbake-devel@lists.openembedded.org>; Tue, 8 Nov 2011 18:02:20 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02982-09 for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Nov 2011 18:02:16 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pA8I2CZr003492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>; Tue, 8 Nov 2011 18:02:13 GMT
Message-ID: <1320775335.10843.104.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 08 Nov 2011 18:02:15 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH RFC] data_smart: Add appendVar/prependVar functions
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
X-List-Received-Date: Tue, 08 Nov 2011 18:08:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This patch adds appendVar and prependVar functions to the data store
meaning python code would no longer have to do the getVar, append and
the setVar dance that much of the current python code does.

It also adds corresponding variants for flags.

Currently there is no spacing added by these functions. That could be
added as a parameter if desired.

If these functions turn out to be hotspots in the code, there are tricks
that could potentially be used to increase the speed of these specific
operations within the datastore.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index d8ba24f..aa25c0a 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -298,6 +298,14 @@ class DataSmart(MutableMapping):
 
         self.delVar(key)
 
+    def appendVar(self, key, value):
+        value = (self.getVar(key, False) or "") + value
+        self.setVar(key, value)
+
+    def prependVar(self, key, value):
+        value = value + (self.getVar(key, False) or "")
+        self.setVar(key, value)
+
     def delVar(self, var):
         self.expand_cache = {}
         self.dict[var] = {}
@@ -333,6 +341,14 @@ class DataSmart(MutableMapping):
         if var in self.dict and flag in self.dict[var]:
             del self.dict[var][flag]
 
+    def appendVarFlag(self, key, flag, value):
+        value = (self.getVarFlag(key, flag, False) or "") + value
+        self.setVarFlag(key, flag, value)
+
+    def prependVarFlag(self, key, flag, value):
+        value = value + (self.getVarFlag(key, flag, False) or "")
+        self.setVarFlag(key, flag, value)
+
     def setVarFlags(self, var, flags):
         if not var in self.dict:
             self._makeShadowCopy(var)



