Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id D68196F60F
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Mar 2014 17:02:26 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s29H1l5u020242
	for <bitbake-devel@lists.openembedded.org>; Sun, 9 Mar 2014 17:02:22 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3RjXX3ULmLSt for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Mar 2014 17:02:22 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s29H2EmK020270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 9 Mar 2014 17:02:18 GMT
Message-ID: <1394384528.7883.9.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 09 Mar 2014 10:02:08 -0700
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker/command: Add setFeatures command
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
X-List-Received-Date: Sun, 09 Mar 2014 17:02:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Add a command to allow backends to set particular 'features' on the
cooker (server).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index e30d21d..3788207 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -257,6 +257,13 @@ class CommandsSync:
         mask = params[3]
         return bb.event.set_UIHmask(handlerNum, llevel, debug_domains, mask)
 
+    def setFeatures(self, command, params):
+        """
+        Set the cooker features to include the passed list of features
+        """
+        features = params[0]
+        command.cooker.setFeatures(features)
+
 class CommandsAsync:
     """
     A class of asynchronous commands
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 96f05b5..8d63195 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -149,6 +149,14 @@ class BBCooker:
 
         self.parser = None
 
+    def setFeatures(self, features):
+        original_featureset = list(self.featureset)
+        for feature in features:
+            self.featureset.setFeature(feature)
+        bb.debug(1, "Features set %s (was %s)" % (original_featureset, list(self.featureset)))
+        if (original_featureset != list(self.featureset)):
+            self.reset()
+
     def initConfigurationData(self):
 
         self.state = state.initial



