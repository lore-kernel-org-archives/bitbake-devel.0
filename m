Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SfI06-0000n5-QO
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 23:54:47 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5ELi97m025689
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jun 2012 14:44:09 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Thu, 14 Jun 2012 14:44:08 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Jun 2012 16:44:03 -0500
Message-ID: <1339710244-6755-3-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339710244-6755-1-git-send-email-jason.wessel@windriver.com>
References: <1339710244-6755-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v2 2/3] fetch2: Allow local git trees as pre-mirrors
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
X-List-Received-Date: Thu, 14 Jun 2012 21:54:47 -0000
Content-Type: text/plain

There is a strong desire to store the raw git trees in a pre-mirror
such that they can easily get updated externally as well as to contain
local branches.

Today the git.py implements a mirrortarball check within the base
fetch2 class.  If the check is moved into the git.py additional
checking can be done for a "file://..." url to look for a local git
archive and then fall back to the mirrortarball.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/fetch2/__init__.py |    5 ++++-
 lib/bb/fetch2/git.py      |   12 ++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 324eef2..1bd4ee4 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -201,7 +201,9 @@ def uri_replace(ud, uri_find, uri_replace, d):
                     result_decoded[loc] = re.sub(i, uri_replace_decoded[loc], uri_decoded[loc])
                 if uri_find_decoded.index(i) == 2:
                     basename = None
-                    if ud.mirrortarball:
+                    if ud.mirrorcheck:
+                        basename = ud.mirrorcheck.getbasename(ud, result_decoded[0], result_decoded[loc])
+                    elif ud.mirrortarball:
                         basename = os.path.basename(ud.mirrortarball)
                     elif ud.localpath:
                         basename = os.path.basename(ud.localpath)
@@ -648,6 +650,7 @@ class FetchData(object):
         self.localpath = None
         self.lockfile = None
         self.mirrortarball = None
+        self.mirrorcheck = None
         self.basename = None
         (self.type, self.host, self.path, self.user, self.pswd, self.parm) = decodeurl(data.expand(url, d))
         self.date = self.getSRCDate(d)
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 07d722a..f34a1e8 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -138,13 +138,23 @@ class Git(FetchMethod):
         if ud.rebaseable:
             for name in ud.names:
                 gitsrcname = gitsrcname + '_' + ud.revisions[name]
+        ud.mirrorcheck = self
+        ud.mirror = gitsrcname
         ud.mirrortarball = 'git2_%s.tar.gz' % (gitsrcname)
         ud.fullmirror = os.path.join(d.getVar("DL_DIR", True), ud.mirrortarball)
         gitdir = d.getVar("GITDIR", True) or (d.getVar("DL_DIR", True) + "/git2/")
+        ud.gitdir = gitdir
         ud.clonedir = os.path.join(gitdir, gitsrcname)
 
         ud.localfile = ud.clonedir
 
+    def getbasename(self, ud, proto, location):
+        # First check if there is a local git archive else return the
+        # mirrortarball name.
+        if proto == "file" and os.path.exists(os.path.join(location, ud.mirror, "objects")):
+            return ud.mirror
+        return os.path.basename(ud.mirrortarball)
+
     def localpath(self, url, ud, d):
         return ud.clonedir
 
@@ -166,6 +176,8 @@ class Git(FetchMethod):
             return True
         if os.path.exists(ud.clonedir):
             return False
+        if not os.path.exists(ud.gitdir):
+            bb.utils.mkdirhier(ud.gitdir)
         return True
 
     def download(self, loc, ud, d):
-- 
1.7.10



