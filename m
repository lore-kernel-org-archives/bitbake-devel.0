Return-Path: <armccurdy@gmail.com>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
	by mail.openembedded.org (Postfix) with ESMTP id A5EE672F7A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Feb 2017 23:14:15 +0000 (UTC)
Received: by mail-pg0-f68.google.com with SMTP id s67so2454195pgb.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Feb 2017 15:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=3218FzJgVJbW09G8f652WQ/RfmHLTTvAM+09hQkHJ+M=;
	b=lW+g4IXDULZTrDjFv6DYp1p4wGse7KL++Sbdf5UEI6+uYCJXthz+YIFj5wGOvDaVN1
	/dcVNpgSby0N4nm9h41g42BGlgg2MjOTpGdUsxN/kxGIj51/ZgfbQZ0cGDh6cuBUgbaH
	xBJnU7xaA8uEpkfE/myhWglsWn+J9/KM4LyzXAai51H57za5csP/l043mN11EenJi3AL
	GpZcoV9Q6DLkFesy6fvkZTJIqPlygeWdi9BD844nWlb5BQC9sUqx5I4mI/AEU1dHEFxV
	VyVrxrhKGZZtDL3QrH9zOBok0C+PxBTa7B0u1VilNoWNqp6ZL+F+4CxExpGiCPGxmyuc
	DTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=3218FzJgVJbW09G8f652WQ/RfmHLTTvAM+09hQkHJ+M=;
	b=HAu5pS1Gd9ukwTdammHXjOrNXSn9ymoetPGMNpeaFLMAQUaTX8Y9IBVFYzf7fuyguC
	Twko2SF7faeFGBcB1csq6jA/36MqJQxApKIVUoM2ZsKggCuF4yWFKFgUiUxioM3GAa+Q
	Vg8piJ/c3a6e/Etym5Cl1bSlIIB+4Zyl0nCWXFiekqMnyxJBVeRLP9I1VMYVKtVie3YE
	WoL/ijHGo6neYVFw3firR3xlZEDj1hJzoDsjsZO2uzl83PNswQBxR/Zs1+2XtUSuRiFi
	JWongFV3wPmnLbdWG71utmBlCaLU/ZrDjDhIzY+xztFzc6AMskqOfld+Sur6N+lRqiRD
	FgdQ==
X-Gm-Message-State: AMke39nRr+y8jDb6PMuNcJr6g8bhgU5kxdecxwgDx5dhMFD/XyG5IjCm0y8wucVHpv/bMA==
X-Received: by 10.99.45.2 with SMTP id t2mr12343050pgt.209.1488237256434;
	Mon, 27 Feb 2017 15:14:16 -0800 (PST)
Received: from e6520.guest-wifi.scl.liberty.com ([4.16.80.121])
	by smtp.gmail.com with ESMTPSA id
	n123sm32709017pga.9.2017.02.27.15.14.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 27 Feb 2017 15:14:15 -0800 (PST)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Feb 2017 15:14:09 -0800
Message-Id: <1488237249-13752-1-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] fetch2: don't use deprecated bb.data APIs
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
X-List-Received-Date: Mon, 27 Feb 2017 23:14:15 -0000

Cleanup some more usage of bb.data APIs in the fetchers.

Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
---
 lib/bb/fetch2/bzr.py       | 7 +++----
 lib/bb/fetch2/clearcase.py | 1 -
 lib/bb/fetch2/cvs.py       | 2 +-
 lib/bb/fetch2/git.py       | 1 -
 lib/bb/fetch2/gitannex.py  | 1 -
 lib/bb/fetch2/gitsm.py     | 1 -
 lib/bb/fetch2/hg.py        | 1 -
 lib/bb/fetch2/local.py     | 1 -
 lib/bb/fetch2/osc.py       | 5 ++---
 lib/bb/fetch2/perforce.py  | 3 +--
 lib/bb/fetch2/repo.py      | 1 -
 lib/bb/fetch2/sftp.py      | 2 --
 lib/bb/fetch2/ssh.py       | 1 -
 lib/bb/fetch2/svn.py       | 5 ++---
 lib/bb/fetch2/wget.py      | 5 ++---
 15 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/lib/bb/fetch2/bzr.py b/lib/bb/fetch2/bzr.py
index 0f1c420..16123f8 100644
--- a/lib/bb/fetch2/bzr.py
+++ b/lib/bb/fetch2/bzr.py
@@ -27,7 +27,6 @@ import os
 import sys
 import logging
 import bb
-from bb import data
 from bb.fetch2 import FetchMethod
 from bb.fetch2 import FetchError
 from bb.fetch2 import runfetchcmd
@@ -43,14 +42,14 @@ class Bzr(FetchMethod):
         """
         # Create paths to bzr checkouts
         relpath = self._strip_leading_slashes(ud.path)
-        ud.pkgdir = os.path.join(data.expand('${BZRDIR}', d), ud.host, relpath)
+        ud.pkgdir = os.path.join(d.expand('${BZRDIR}'), ud.host, relpath)
 
         ud.setup_revisions(d)
 
         if not ud.revision:
             ud.revision = self.latest_revision(ud, d)
 
-        ud.localfile = data.expand('bzr_%s_%s_%s.tar.gz' % (ud.host, ud.path.replace('/', '.'), ud.revision), d)
+        ud.localfile = d.expand('bzr_%s_%s_%s.tar.gz' % (ud.host, ud.path.replace('/', '.'), ud.revision))
 
     def _buildbzrcommand(self, ud, d, command):
         """
@@ -58,7 +57,7 @@ class Bzr(FetchMethod):
         command is "fetch", "update", "revno"
         """
 
-        basecmd = data.expand('${FETCHCMD_bzr}', d)
+        basecmd = d.expand('${FETCHCMD_bzr}')
 
         proto =  ud.parm.get('protocol', 'http')
 
diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index 8df8f53..36beab6 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -65,7 +65,6 @@ import os
 import sys
 import shutil
 import bb
-from   bb import data
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import runfetchcmd
diff --git a/lib/bb/fetch2/cvs.py b/lib/bb/fetch2/cvs.py
index 64c50c2..490c954 100644
--- a/lib/bb/fetch2/cvs.py
+++ b/lib/bb/fetch2/cvs.py
@@ -63,7 +63,7 @@ class Cvs(FetchMethod):
         if 'fullpath' in ud.parm:
             fullpath = '_fullpath'
 
-        ud.localfile = bb.data.expand('%s_%s_%s_%s%s%s.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.tag, ud.date, norecurse, fullpath), d)
+        ud.localfile = d.expand('%s_%s_%s_%s%s%s.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.tag, ud.date, norecurse, fullpath))
 
     def need_update(self, ud, d):
         if (ud.date == "now"):
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 0a5785d..0779e80 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -76,7 +76,6 @@ import re
 import bb
 import errno
 import bb.progress
-from   bb    import data
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
diff --git a/lib/bb/fetch2/gitannex.py b/lib/bb/fetch2/gitannex.py
index 4937a10..c66c211 100644
--- a/lib/bb/fetch2/gitannex.py
+++ b/lib/bb/fetch2/gitannex.py
@@ -22,7 +22,6 @@ BitBake 'Fetch' git annex implementation
 
 import os
 import bb
-from   bb import data
 from   bb.fetch2.git import Git
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 939fb3f..a95584c 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -31,7 +31,6 @@ NOTE: Switching a SRC_URI from "git://" to "gitsm://" requires a clean of your r
 
 import os
 import bb
-from   bb    import data
 from   bb.fetch2.git import Git
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index ddbebb5..b5f2686 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -29,7 +29,6 @@ import sys
 import logging
 import bb
 import errno
-from bb import data
 from bb.fetch2 import FetchMethod
 from bb.fetch2 import FetchError
 from bb.fetch2 import MissingParameterError
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index 8377888..2ff7723 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -29,7 +29,6 @@ import os
 import urllib.request, urllib.parse, urllib.error
 import bb
 import bb.utils
-from   bb import data
 from   bb.fetch2 import FetchMethod, FetchError
 from   bb.fetch2 import logger
 
diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
index 26f88e1..2b4f7d9 100644
--- a/lib/bb/fetch2/osc.py
+++ b/lib/bb/fetch2/osc.py
@@ -10,7 +10,6 @@ import  os
 import  sys
 import logging
 import  bb
-from    bb       import data
 from    bb.fetch2 import FetchMethod
 from    bb.fetch2 import FetchError
 from    bb.fetch2 import MissingParameterError
@@ -47,7 +46,7 @@ class Osc(FetchMethod):
             else:
                 ud.revision = ""
 
-        ud.localfile = data.expand('%s_%s_%s.tar.gz' % (ud.module.replace('/', '.'), ud.path.replace('/', '.'), ud.revision), d)
+        ud.localfile = d.expand('%s_%s_%s.tar.gz' % (ud.module.replace('/', '.'), ud.path.replace('/', '.'), ud.revision))
 
     def _buildosccommand(self, ud, d, command):
         """
@@ -55,7 +54,7 @@ class Osc(FetchMethod):
         command is "fetch", "update", "info"
         """
 
-        basecmd = data.expand('${FETCHCMD_osc}', d)
+        basecmd = d.expand('${FETCHCMD_osc}')
 
         proto = ud.parm.get('protocol', 'ocs')
 
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index e00cca9..3debad5 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -26,7 +26,6 @@ BitBake 'Fetch' implementation for perforce
 import os
 import logging
 import bb
-from   bb import data
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import logger
@@ -89,7 +88,7 @@ class Perforce(FetchMethod):
 
         ud.setup_revisions(d)
 
-        ud.localfile = data.expand('%s_%s_%s.tar.gz' % (cleanedhost, cleanedpath, ud.revision), d)
+        ud.localfile = d.expand('%s_%s_%s.tar.gz' % (cleanedhost, cleanedpath, ud.revision))
 
     def _buildp4command(self, ud, d, command, depot_filename=None):
         """
diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index 24dcebb..1be91cc 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -25,7 +25,6 @@ BitBake "Fetch" repo (git) implementation
 
 import os
 import bb
-from   bb    import data
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
 
diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index da857dd..81884a6 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -62,12 +62,10 @@ SRC_URI = "sftp://user@host.example.com/dir/path.file.txt"
 import os
 import bb
 import urllib.request, urllib.parse, urllib.error
-from bb import data
 from bb.fetch2 import URI
 from bb.fetch2 import FetchMethod
 from bb.fetch2 import runfetchcmd
 
-
 class SFTP(FetchMethod):
     """Class to fetch urls via 'sftp'"""
 
diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index e668b0d..6047ee4 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -43,7 +43,6 @@ IETF secsh internet draft:
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import re, os
-from   bb import data
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import logger
diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 3271be3..3f172ee 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -28,7 +28,6 @@ import sys
 import logging
 import bb
 import re
-from   bb import data
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import MissingParameterError
@@ -61,7 +60,7 @@ class Svn(FetchMethod):
 
         # Create paths to svn checkouts
         relpath = self._strip_leading_slashes(ud.path)
-        ud.pkgdir = os.path.join(data.expand('${SVNDIR}', d), ud.host, relpath)
+        ud.pkgdir = os.path.join(d.expand('${SVNDIR}'), ud.host, relpath)
         ud.moddir = os.path.join(ud.pkgdir, ud.module)
 
         ud.setup_revisions(d)
@@ -69,7 +68,7 @@ class Svn(FetchMethod):
         if 'rev' in ud.parm:
             ud.revision = ud.parm['rev']
 
-        ud.localfile = data.expand('%s_%s_%s_%s_.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.path.replace('/', '.'), ud.revision), d)
+        ud.localfile = d.expand('%s_%s_%s_%s_.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.path.replace('/', '.'), ud.revision))
 
     def _buildsvncommand(self, ud, d, command):
         """
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 1cc445a..0c61dfa 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -33,7 +33,6 @@ import logging
 import bb
 import bb.progress
 import urllib.request, urllib.parse, urllib.error
-from   bb import data
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import logger
@@ -84,9 +83,9 @@ class Wget(FetchMethod):
         else:
             ud.basename = os.path.basename(ud.path)
 
-        ud.localfile = data.expand(urllib.parse.unquote(ud.basename), d)
+        ud.localfile = d.expand(urllib.parse.unquote(ud.basename))
         if not ud.localfile:
-            ud.localfile = data.expand(urllib.parse.unquote(ud.host + ud.path).replace("/", "."), d)
+            ud.localfile = d.expand(urllib.parse.unquote(ud.host + ud.path).replace("/", "."))
 
         self.basecmd = d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -t 2 -T 30 --passive-ftp --no-check-certificate"
 
-- 
1.9.1


