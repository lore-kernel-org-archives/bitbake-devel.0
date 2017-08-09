Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4856A77DCC
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Aug 2017 22:48:57 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v79MmteK031943
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Wed, 9 Aug 2017 23:48:57 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dfZmZ-0007S9-Vd; Wed, 09 Aug 2017 23:48:55 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Aug 2017 23:48:52 +0100
Message-Id: <1502318935-28608-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Wed, 09 Aug 2017 23:48:57 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 1/4] cooker: Track directories searched for bbappend/bb files
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
X-List-Received-Date: Wed, 09 Aug 2017 22:48:58 -0000

Some of the directories searched by BBFILES are not currently being added
to the inotify watch list. This can mean that added append files are not
noticed leading to misleading metadata results when using
BB_SERVER_TIMEOUT != 0.

We use glob to expand the BBFILES references and without writing our own
implentation, figuring out the directories it searches is hard. We use
some horrible hacks here to intecept the listdir calls, I'm open
to better ways to handle this but this does ensure we have the right
watches set.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 3740c61..ea4df26 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1192,7 +1192,7 @@ class BBCooker:
             bf = os.path.abspath(bf)
 
         self.collection = CookerCollectFiles(self.bbfile_config_priorities)
-        filelist, masked = self.collection.collect_bbfiles(self.data, self.data)
+        filelist, masked, searchdirs = self.collection.collect_bbfiles(self.data, self.data)
         try:
             os.stat(bf)
             bf = os.path.abspath(bf)
@@ -1482,7 +1482,11 @@ class BBCooker:
                     self.recipecaches[mc].ignored_dependencies.add(dep)
 
             self.collection = CookerCollectFiles(self.bbfile_config_priorities)
-            (filelist, masked) = self.collection.collect_bbfiles(self.data, self.data)
+            (filelist, masked, searchdirs) = self.collection.collect_bbfiles(self.data, self.data)
+
+            # Add inotify watches for directories searched for bb/bbappend files
+            for dirent in searchdirs:
+                self.add_filewatch([[dirent]])
 
             self.parser = CookerParser(self, filelist, masked)
             self.parsecache_valid = True
@@ -1654,6 +1658,18 @@ class CookerCollectFiles(object):
             collectlog.error("no recipe files to build, check your BBPATH and BBFILES?")
             bb.event.fire(CookerExit(), eventdata)
 
+        # We need to track where we look so that we can add inotify watches. There
+        # is no nice way to do this, this is horrid. We intercept the os.listdir()
+        # calls while we run glob().
+        origlistdir = os.listdir
+        searchdirs = []
+
+        def ourlistdir(d):
+            searchdirs.append(d)
+            return origlistdir(d)
+
+        os.listdir = ourlistdir
+
         # Can't use set here as order is important
         newfiles = []
         for f in files:
@@ -1671,6 +1687,8 @@ class CookerCollectFiles(object):
                     if g not in newfiles:
                         newfiles.append(g)
 
+        os.listdir = origlistdir
+
         bbmask = config.getVar('BBMASK')
 
         if bbmask:
@@ -1729,7 +1747,7 @@ class CookerCollectFiles(object):
                 topfile = bbfile_seen[base]
                 self.overlayed[topfile].append(f)
 
-        return (bbfiles, masked)
+        return (bbfiles, masked, searchdirs)
 
     def get_file_appends(self, fn):
         """
-- 
2.7.4


