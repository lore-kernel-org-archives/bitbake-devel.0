Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D9ECC73CF2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jul 2015 22:28:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6MMSUAU013382 for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jul 2015 23:28:30 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zoLcWv9oTgG0 for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jul 2015 23:28:30 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6MMSHte013375
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jul 2015 23:28:29 +0100
Message-ID: <1437604097.821.79.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 22 Jul 2015 23:28:17 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] data_smart: Add CoW approach for overridedata
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
X-List-Received-Date: Wed, 22 Jul 2015 22:28:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Using deepcopy() caused a major performance regression. Turns
out we can work with a shallow copy as long as we force the
recreation of any list that we change, effectively a poor mans
CoW. This isn't too invasive and avoids the huge overhead of
deepcopy so this seems like the best way to have performance and
a working data store.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 86cdeb5..c0a2a57 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -314,6 +314,9 @@ class DataSmart(MutableMapping):
         self.expand_cache = {}
 
         # cookie monster tribute
+        # Need to be careful about writes to overridedata as
+        # its only a shallow copy, could influence other data store
+        # copies!
         self.overridedata = {}
         self.overrides = None
         self.overridevars = set(["OVERRIDES", "FILE"])
@@ -507,6 +510,8 @@ class DataSmart(MutableMapping):
             if shortvar not in self.overridedata:
                 self.overridedata[shortvar] = []
             if [var, override] not in self.overridedata[shortvar]:
+                # Force CoW by recreating the list first
+                self.overridedata[shortvar] = list(self.overridedata[shortvar])
                 self.overridedata[shortvar].append([var, override])
             for event in self.varhistory.variable(var):
                 if 'flag' in loginfo and not loginfo['flag'].startswith("_"):
@@ -587,6 +592,8 @@ class DataSmart(MutableMapping):
             while override:
                 try:
                     if shortvar in self.overridedata:
+                        # Force CoW by recreating the list first
+                        self.overridedata[shortvar] = list(self.overridedata[shortvar])
                         self.overridedata[shortvar].remove([var, override])
                 except ValueError as e:
                     pass
@@ -806,7 +813,9 @@ class DataSmart(MutableMapping):
 
         data.overrides = None
         data.overridevars = copy.copy(self.overridevars)
-        data.overridedata = copy.deepcopy(self.overridedata)
+        # Should really be a deepcopy but has heavy overhead.
+        # Instead, we're careful with writes.
+        data.overridedata = copy.copy(self.overridedata)
 
         return data
 



