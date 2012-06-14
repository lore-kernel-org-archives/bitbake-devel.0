Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1Sf0bg-0006Cf-7C
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 05:20:24 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5E39ljN009205
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Jun 2012 20:09:47 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Wed, 13 Jun 2012 20:09:46 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 13 Jun 2012 22:09:40 -0500
Message-ID: <1339643381-23026-4-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339643381-23026-1-git-send-email-jason.wessel@windriver.com>
References: <1339643381-23026-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/4] fetch2: Allow local git trees as pre-mirrors
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 14 Jun 2012 03:20:24 -0000
Content-Type: text/plain

There is a strong desire to store the raw git trees in a pre-mirror
such that they can easily get updated externally as well as to contain
local branches.

This patch adds another type of pre-mirror rule that is "git" based.

The syntax looks like:
  PREMIRRORS_append := "\
     git://.*/.* git://${LAYERDIR}/downloads/git/ \n"

The syntax for typical tar.gz compressed git tree is:
  PREMIRRORS_append := "\
     git://.*/.* file://${LAYERDIR}/downloads/git/ \n"

The new pre-mirror type also requires the creation of the GITDIR at
the pre-mirror check time or the git clone and git checks will fail
with obscure errors.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/fetch2/__init__.py |    8 +++++++-
 lib/bb/fetch2/git.py      |    4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 324eef2..68025a3 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -202,7 +202,13 @@ def uri_replace(ud, uri_find, uri_replace, d):
                 if uri_find_decoded.index(i) == 2:
                     basename = None
                     if ud.mirrortarball:
-                        basename = os.path.basename(ud.mirrortarball)
+                        # Transpose a git uri to a file uri and check if there
+                        # is a local mirror durring the premirror checks
+                        if ud.mirror and uri_find_decoded[0] == "git":
+                            result_decoded[0] = "file"
+                            basename = os.path.basename(ud.mirror)
+                        else:
+                            basename = os.path.basename(ud.mirrortarball)
                     elif ud.localpath:
                         basename = os.path.basename(ud.localpath)
                     if basename and result_decoded[loc].endswith("/"):
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index ecc5e0d..1ad9213 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -138,9 +138,11 @@ class Git(FetchMethod):
         if ud.rebaseable:
             for name in ud.names:
                 gitsrcname = gitsrcname + '_' + ud.revisions[name]
+        ud.mirror = gitsrcname
         ud.mirrortarball = 'git2_%s.tar.gz' % (gitsrcname)
         ud.fullmirror = os.path.join(d.getVar("DL_DIR", True), ud.mirrortarball)
         gitdir = d.getVar("GITDIR", True) or (d.getVar("DL_DIR", True) + "/git2/")
+        ud.gitdir = gitdir
         ud.clonedir = os.path.join(gitdir, gitsrcname)
 
         ud.localfile = ud.clonedir
@@ -166,6 +168,8 @@ class Git(FetchMethod):
             return True
         if os.path.exists(ud.clonedir):
             return False
+        if not os.path.exists(ud.gitdir):
+            bb.utils.mkdirhier(ud.gitdir)
         return True
 
     def download(self, loc, ud, d):
-- 
1.7.10



