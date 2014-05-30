Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 77FF36FB66
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 14:54:10 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s4UEs5rR012130 for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:54:05 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1Wz4lBRx4ckX for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:54:05 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s4UEs11N012064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:54:02 +0100
Message-ID: <1401461633.31309.49.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 30 May 2014 15:53:53 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cookerdata: Improve error handling
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
X-List-Received-Date: Fri, 30 May 2014 14:54:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If we see errors during parsing, firstly its bad to show a traceback
for an expansion error so lets suppress this.

Secondly, raise a BBHandledException instead of a SystemExit to show
we've informed the user about the condition (printing a traceback in the
default unknown case).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index b9b9e16..60a6d51 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -227,10 +227,13 @@ class CookerDataBuilder(object):
         try:
             self.parseConfigurationFiles(self.prefiles, self.postfiles)
         except SyntaxError:
-            sys.exit(1)
+            raise bb.BBHandledException
+        except bb.data_smart.ExpansionError as e:
+            logger.error(str(e))
+            raise bb.BBHandledException
         except Exception:
             logger.exception("Error parsing configuration files")
-            sys.exit(1)
+            raise bb.BBHandledException
 
     def _findLayerConf(self, data):
         return findConfigFile("bblayers.conf", data)




