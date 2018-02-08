Return-Path: <andrej.valek@siemens.com>
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
	by mail.openembedded.org (Postfix) with ESMTP id BC24971BB9
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Feb 2018 10:21:13 +0000 (UTC)
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id w18ALDue019451
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 8 Feb 2018 11:21:14 +0100
Received: from dev.sbt.siemens.com (sk1d124c.siemens.sk [163.242.57.217])
	by mail3.siemens.de (8.15.2/8.15.2) with ESMTP id w18ALDQ3007057;
	Thu, 8 Feb 2018 11:21:13 +0100
Received: from dev.sbt.siemens.com (localhost [127.0.0.1])
	by dev.sbt.siemens.com (Postfix) with ESMTP id A5DBDCDBD8;
	Thu,  8 Feb 2018 11:21:13 +0100 (CET)
From: Andrej Valek <andrej.valek@siemens.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  8 Feb 2018 11:20:57 +0100
Message-Id: <1518085257-20782-1-git-send-email-andrej.valek@siemens.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <54c4f060-bfe9-f8f7-c141-c80f1aef1705@siemens.com>
References: <54c4f060-bfe9-f8f7-c141-c80f1aef1705@siemens.com>
Subject: [PATCH] feat(wget_autorev): add autorev feature for wget
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
X-List-Received-Date: Thu, 08 Feb 2018 10:21:14 -0000

Hello everybody,

I was trying to make first working get_srcrev function implementation.
But I have foundded some problems. When some recipe has multiple entries
in SRC_URI with svn/git/http and also SRCREV is set. Fetch method just
loops over entries and try to recognize them. The problem is that, SRCREV
is set, but it's has to be matching only with the svn. So urldata_init is
going to create the revision, even if SRCREV is not valid.

This stuff needs to be also enabled in meta/classes/base.bbclass .

Could someone help me with this problem and bring this feature upstream?

Thank you,
Andrej

---
 lib/bb/fetch2/wget.py | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 8f505b6..5b5af84 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -34,6 +34,7 @@ import errno
 import bb
 import bb.progress
 import urllib.request, urllib.parse, urllib.error
+import hashlib
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import logger
@@ -90,6 +91,11 @@ class Wget(FetchMethod):
 
         self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -t 2 -T 30 --passive-ftp --no-check-certificate"
 
+        # setup revision if it is enabled
+        srcrev = d.getVar("SRCREV")
+        if srcrev and srcrev != "INVALID":
+            ud.setup_revisons(d)
+
     def _runwget(self, ud, d, command, quiet, workdir=None):
 
         progresshandler = WgetProgressHandler(d)
@@ -98,6 +104,15 @@ class Wget(FetchMethod):
         bb.fetch2.check_network_access(d, command, ud.url)
         runfetchcmd(command + ' --progress=dot -v', d, quiet, log=progresshandler, workdir=workdir)
 
+    def supports_srcrev(self):
+        return True
+
+    def _revision_key(self, ud, d, name):
+        """
+        Return a unique key for the url
+        """
+        return ud.type + ":" + ud.localfile
+
     def download(self, ud, d):
         """Fetch urls"""
 
@@ -579,6 +594,35 @@ class Wget(FetchMethod):
 
         return package_custom_regex_comp
 
+    def _latest_revision(self, ud, d, name):
+        """
+        Return the latest upstream revision number
+        """
+        fetchcmd = self.basecmd
+        # redirect stderr to stdout instead of writing into file
+        fetchcmd += " --server-response --spider " + ud.url.split(";")[0] + " 2>&1"
+        revision = ""
+
+        try:
+            bb.fetch2.check_network_access(d, fetchcmd)
+            output = runfetchcmd(fetchcmd, d, False)
+            # get modified timestamp
+            output = re.search(r'(Last-Modified:\ )(.*)', output).group(2)
+            revision =  hashlib.md5(output).hexdigest()
+        except Exception as e:
+            bb.warn("Error gettig timestamp %s" % e)
+
+        return revision
+
+    def sortable_revision(self, ud, d, name):
+        """
+        Return a sortable revision number which in our case is the revision number
+        """
+        return False, self._build_revision(ud, d)
+
+    def _build_revision(self, ud, d):
+        return ud.revision
+
     def latest_versionstring(self, ud, d):
         """
         Manipulate the URL and try to obtain the latest package version
-- 
2.1.4


