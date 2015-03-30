Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id F3C2D73C5A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Mar 2015 12:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t2UCTmCk004374 for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Mar 2015 13:29:48 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hLZ4rl6htjCb for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Mar 2015 13:29:48 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t2UCTXt1004371
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Mar 2015 13:29:44 +0100
Message-ID: <1427718573.14020.299.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 30 Mar 2015 13:29:33 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Ensure bbappend files are processed in a determistic order
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
X-List-Received-Date: Mon, 30 Mar 2015 12:29:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

self.appendlist is a dict and as such unordered. This can lead to cases
where appends with different names (e.g. x_%.bbappend vs. x_123.bbappend)
can be reordered in application which in turn reorders the variables
that those bbappend files might touch. Reorderd variables changes the sstate
cache signatures causing real world issues.

To avoid this, use a list for the append files instead.

This patch is conservative and just adds a new data structure alongside
the existing one and uses it to resolve the core issue. Later patches
(post release) can handle some of the wider but less problematic ones
(e.g. issues in bitbake-layers flatten).

[YOCTO #7511]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 68aa532..b0f4e4b 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1576,6 +1576,7 @@ class CookerExit(bb.event.Event):
 class CookerCollectFiles(object):
     def __init__(self, priorities):
         self.appendlist = {}
+        self.bbappends = []
         self.appliedappendlist = []
         self.bbfile_config_priorities = priorities
 
@@ -1670,6 +1671,7 @@ class CookerCollectFiles(object):
         # Build a list of .bbappend files for each .bb file
         for f in bbappend:
             base = os.path.basename(f).replace('.bbappend', '.bb')
+            self.bbappends.append((base, f))
             if not base in self.appendlist:
                self.appendlist[base] = []
             if f not in self.appendlist[base]:
@@ -1695,11 +1697,11 @@ class CookerCollectFiles(object):
         """
         filelist = []
         f = os.path.basename(fn)
-        for bbappend in self.appendlist:
+        for b in self.bbappends:
+            (bbappend, filename) = b
             if (bbappend == f) or ('%' in bbappend and bbappend.startswith(f[:bbappend.index('%')])):
                 self.appliedappendlist.append(bbappend)
-                for filename in self.appendlist[bbappend]:
-                    filelist.append(filename)
+                filelist.append(filename)
         return filelist
 
     def collection_priorities(self, pkgfns, d):
@@ -1719,10 +1721,10 @@ class CookerCollectFiles(object):
                 unmatched.add(regex)
 
         def findmatch(regex):
-            for bbfile in self.appendlist:
-                for append in self.appendlist[bbfile]:
-                    if regex.match(append):
-                        return True
+            for b in self.bbappends:
+                (bbfile, append) = b
+                if regex.match(append):
+                    return True
             return False
 
         for unmatch in unmatched.copy():



