Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 22428774B1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Dec 2016 17:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBLH6YRP001647; Wed, 21 Dec 2016 17:06:35 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GtUjbhm3oFiC; Wed, 21 Dec 2016 17:06:35 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBLH6TNT001594
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Dec 2016 17:06:30 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cJkLV-0006ua-HA; Wed, 21 Dec 2016 17:06:29 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Dec 2016 17:06:25 +0000
Message-Id: <1482339985-26495-7-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1482339985-26495-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1482339985-26495-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 7/7] cookerdata: Convert multiconfig to use BB_CURRENT_MC
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
X-List-Received-Date: Wed, 21 Dec 2016 17:06:38 -0000

People are struggling with multiconfig as the point the conf file
is injected into the data store is not what people expect. We can't
really use a post config since that is too late and we can't really
use a pre config file since that is too early. In OE terms, we need
something right around the local.conf point so it behaves in a similar
way.

A way to handle this is to set the new variable BB_CURRENT_MC to be the
currently selected multiconfig, then the metadata itself can choose
when to inject the approriate configuration.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index c6e958b..d9eab56 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -289,7 +289,7 @@ class CookerDataBuilder(object):
 
             multiconfig = (self.data.getVar("BBMULTICONFIG") or "").split()
             for config in multiconfig:
-                mcdata = self.parseConfigurationFiles(['conf/multiconfig/%s.conf' % config] + self.prefiles, self.postfiles)
+                mcdata = self.parseConfigurationFiles(self.prefiles, self.postfiles, config)
                 bb.event.fire(bb.event.ConfigParsed(), mcdata)
                 self.mcdata[config] = mcdata
 
@@ -305,8 +305,9 @@ class CookerDataBuilder(object):
     def _findLayerConf(self, data):
         return findConfigFile("bblayers.conf", data)
 
-    def parseConfigurationFiles(self, prefiles, postfiles):
+    def parseConfigurationFiles(self, prefiles, postfiles, mc = "default"):
         data = bb.data.createCopy(self.basedata)
+        data.setVar("BB_CURRENT_MC", mc)
 
         # Parse files for loading *before* bitbake.conf and any includes
         for f in prefiles:
-- 
2.7.4


