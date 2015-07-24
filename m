Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6FF1175791
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jul 2015 10:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6OAfwSp020952 for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jul 2015 11:41:58 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id t85iQATUhBkf for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jul 2015 11:41:58 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6OAfipl020943
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jul 2015 11:41:55 +0100
Message-ID: <1437734504.821.152.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 24 Jul 2015 11:41:44 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] data_smart: Improve override history logging
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
X-List-Received-Date: Fri, 24 Jul 2015 10:41:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Calling record() for each override alteration is slow. Since we now expand
overrides dynamically we don't have to record the log data at each alteration,
we can instead print it directly from the existing data stores at variable
history print time using the exact same data stores.

This massively improves performance of the data store when parsing
with bitbake -e for example, it will improve memory overhead as well.

The only downside is that VariableHistory has to poke into the datastore
for some of its data but that seems an acceptable tradeoff rather than
double caching.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 59dca0a..950279b 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -202,7 +202,7 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
         return False
 
     if all:
-        d.varhistory.emit(var, oval, val, o)
+        d.varhistory.emit(var, oval, val, o, d)
 
     if (var.find("-") != -1 or var.find(".") != -1 or var.find('{') != -1 or var.find('}') != -1 or var.find('+') != -1) and not all:
         return False
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index da846fc..24735f9 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -252,10 +252,22 @@ class VariableHistory(object):
         else:
             return []
 
-    def emit(self, var, oval, val, o):
+    def emit(self, var, oval, val, o, d):
         #if var == 'copy':
         #    return
         history = self.variable(var)
+
+        # Append override history
+        if var in d.overridedata:
+            for (r, override) in d.overridedata[var]:
+                for event in self.variable(r):
+                    loginfo = event.copy()
+                    if 'flag' in loginfo and not loginfo['flag'].startswith("_"):
+                        continue
+                    loginfo['variable'] = var
+                    loginfo['op'] = 'override[%s]:%s' % (override, loginfo['op'])
+                    history.append(loginfo)
+
         commentVal = re.sub('\n', '\n#', str(oval))
         if history:
             if len(history) == 1:
@@ -503,15 +515,6 @@ class DataSmart(MutableMapping):
                 # Force CoW by recreating the list first
                 self.overridedata[shortvar] = list(self.overridedata[shortvar])
                 self.overridedata[shortvar].append([var, override])
-            for event in self.varhistory.variable(var):
-                if 'flag' in loginfo and not loginfo['flag'].startswith("_"):
-                    continue
-                loginfo = event.copy()
-                loginfo['variable'] = shortvar
-                loginfo['op'] = 'override[%s]:%s' % (override, loginfo['op'])
-                loginfo['nodups'] = True
-                self.varhistory.record(**loginfo)
-
             override = None
             if "_" in shortvar:
                 override = var[shortvar.rfind('_')+1:]



