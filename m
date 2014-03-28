Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 7CC1D6B4F7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 11:06:34 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2SB6ULY013549 for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 11:06:30 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 26D8A_04_vjK for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 11:06:29 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2SB6Pi8013544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 11:06:26 GMT
Message-ID: <1396004778.24890.172.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Mar 2014 11:06:18 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Only change self.data if it exists
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
X-List-Received-Date: Fri, 28 Mar 2014 11:06:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

With the change to more optimal default featureset behaviour, a race was
exposed by hob where the code may try and change self.data before it
exists. This change avoids that.

When the datastore is created, the cooker configuration is used so
data tracking is correctly handled regardless.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index e81d887..5d3ac60 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -207,11 +207,13 @@ class BBCooker:
 
     def enableDataTracking(self):
         self.configuration.tracking = True
-        self.data.enableTracking()
+        if hasattr(self, "data"):
+            self.data.enableTracking()
 
     def disableDataTracking(self):
         self.configuration.tracking = False
-        self.data.disableTracking()
+        if hasattr(self, "data"):
+            self.data.disableTracking()
 
     def modifyConfigurationVar(self, var, val, default_file, op):
         if op == "append":



