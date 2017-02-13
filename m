Return-Path: <rpjday@crashcourse.ca>
X-Greylist: delayed 629 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 13 Feb 2017 12:01:07 UTC
Received: from smtp484.redcondor.net (smtp484.redcondor.net [208.80.204.84])
	by mail.openembedded.org (Postfix) with ESMTP id 753DB71A72
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Feb 2017 12:01:07 +0000 (UTC)
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by smtp484.redcondor.net ({c48374e7-08df-40d9-a0de-96cc9883a037})
	via TCP (outbound) with ESMTPS id 20170213115037659_0484
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Feb 2017 11:50:37 +0000
X-RC-FROM: <rpjday@crashcourse.ca>
X-RC-RCPT: <bitbake-devel@lists.openembedded.org>
Received: from [216.191.234.70] (port=28452 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1cdF9L-00077q-F7 for bitbake-devel@lists.openembedded.org;
	Mon, 13 Feb 2017 06:50:31 -0500
Date: Mon, 13 Feb 2017 06:50:29 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@uk63952.mitel.com
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.20.1702130648100.8363@uk63952.mitel.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
X-MAG-OUTBOUND: ccj.redcondor.net@64.235.106.9/32
Subject: [PATCH] fetch2: Rename "setup_revisons" to "setup_revisions"
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
X-List-Received-Date: Mon, 13 Feb 2017 12:01:09 -0000
Content-Type: text/plain; charset=US-ASCII


For spelling's sake, rename Python routine "setup_revisons" to
"setup_revisions."

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  since this actually modifies code, i'm fine if someone decides it's
not worth the churn. i believe i got all of them.

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 525f47e..21afc2a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1247,7 +1247,7 @@ class FetchData(object):
         self.donestamp = basepath + '.done'
         self.lockfile = basepath + '.lock'

-    def setup_revisons(self, d):
+    def setup_revisions(self, d):
         self.revisions = {}
         for name in self.names:
             self.revisions[name] = srcrev_internal_helper(self, d, name)
diff --git a/lib/bb/fetch2/bzr.py b/lib/bb/fetch2/bzr.py
index 72264af..0f1c420 100644
--- a/lib/bb/fetch2/bzr.py
+++ b/lib/bb/fetch2/bzr.py
@@ -45,7 +45,7 @@ class Bzr(FetchMethod):
         relpath = self._strip_leading_slashes(ud.path)
         ud.pkgdir = os.path.join(data.expand('${BZRDIR}', d), ud.host, relpath)

-        ud.setup_revisons(d)
+        ud.setup_revisions(d)

         if not ud.revision:
             ud.revision = self.latest_revision(ud, d)
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index f7a0c01..39eb907 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -186,7 +186,7 @@ class Git(FetchMethod):

         ud.write_tarballs = ((d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0") != "0") or ud.rebaseable

-        ud.setup_revisons(d)
+        ud.setup_revisions(d)

         for name in ud.names:
             # Ensure anything that doesn't look like a sha256 checksum/revision is translated into one
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index 7e9afce..ddbebb5 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -67,7 +67,7 @@ class Hg(FetchMethod):
         else:
             ud.proto = "hg"

-        ud.setup_revisons(d)
+        ud.setup_revisions(d)

         if 'rev' in ud.parm:
             ud.revision = ud.parm['rev']
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index 0f0d739..e00cca9 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -87,7 +87,7 @@ class Perforce(FetchMethod):
         cleanedhost = ud.host.replace(':', '.')
         ud.pkgdir = os.path.join(ud.dldir, cleanedhost, cleanedpath)

-        ud.setup_revisons(d)
+        ud.setup_revisions(d)

         ud.localfile = data.expand('%s_%s_%s.tar.gz' % (cleanedhost, cleanedpath, ud.revision), d)

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index d6feeb2..cabc290 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -64,7 +64,7 @@ class Svn(FetchMethod):
         ud.pkgdir = os.path.join(data.expand('${SVNDIR}', d), ud.host, relpath)
         ud.moddir = os.path.join(ud.pkgdir, ud.module)

-        ud.setup_revisons(d)
+        ud.setup_revisions(d)

         if 'rev' in ud.parm:
             ud.revision = ud.parm['rev']

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


