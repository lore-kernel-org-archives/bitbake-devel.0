Return-Path: <t-maiaxiao@linux.microsoft.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8158BC43334
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 17:46:40 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mx.groups.io with SMTP id smtpd.web11.87168.1657043191384948989
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Jul 2022 10:46:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linux.microsoft.com header.s=default header.b=eGhcmZsH;
 spf=pass (domain: linux.microsoft.com, ip: 13.77.154.182,
 mailfrom: t-maiaxiao@linux.microsoft.com)
Received: from
 dev-maia-1804.xf424dz31loulooynwcnvdc1yg.xx.internal.cloudapp.net (unknown
 [20.98.104.149])
	by linux.microsoft.com (Postfix) with ESMTPSA id B0AB220DDC9D;
	Tue,  5 Jul 2022 10:46:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0AB220DDC9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1657043190;
	bh=Qn0uHdRmOmYWlDDBu+dSmkvfI++zu2wY4iEozyLAIfk=;
	h=From:To:Cc:Subject:Date:From;
	b=eGhcmZsHIi7Rt4zxtyBREpO7vp+momC17j86pcIsNbn+aCBDX81RsON13B8xVvBFR
	 pl68mjDEtlaQZSdwMDp0Bhs19w3KIO5DzVILij4J+gKBrgoKDSI4HwGBL0bOzR4wIc
	 wgOZcIxXwpzFd6mnuqvhDMPcnXzLMV4M25wxHdrQ=
From: Maia Xiao <t-maiaxiao@linux.microsoft.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paul Eggleton <Paul.Eggleton@microsoft.com>
Subject: [PATCH] fetch2/git: Check srcrev exists in checkstatus()
Date: Tue,  5 Jul 2022 17:46:30 +0000
Message-Id: <20220705174630.13360-1-t-maiaxiao@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Jul 2022 17:46:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13799

Currently we only check that we can list the remote, but do not validate
if the srcrev actually exists. Now we ensure that the rev exists by
attempting to shallow clone it from the remote.

Fixes [YOCTO #11199].

Signed-off-by: Maia Xiao <t-maiaxiao@linux.microsoft.com>
---
 lib/bb/fetch2/git.py  | 28 +++++++++++++++++++++++-----
 lib/bb/tests/fetch.py | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 07b3d9a7..99780de8 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -832,8 +832,26 @@ class Git(FetchMethod):
             return True, str(rev)
 
     def checkstatus(self, fetch, ud, d):
-        try:
-            self._lsremote(ud, d, "")
-            return True
-        except bb.fetch2.FetchError:
-            return False
+        repourl = self._get_repo_url(ud)
+        for name in ud.names:
+            tmpdir = tempfile.mkdtemp()
+            revision = ud.revisions[name]
+
+            try:
+                # Initialise an empty git repo for shallow fetching
+                runfetchcmd("%s init" % ud.basecmd, d, workdir=tmpdir)
+                runfetchcmd("%s remote add origin %s" %
+                            (ud.basecmd, shlex.quote(repourl)),
+                            d,
+                            workdir=tmpdir)
+
+                # Try to fetch only the specified srcrev
+                runfetchcmd("%s fetch -f --progress --depth 1 origin %s" %
+                            (ud.basecmd, revision),
+                            d,
+                            workdir=tmpdir)
+            except bb.fetch2.FetchError:
+                return False
+            finally:
+                bb.utils.remove(tmpdir, recurse=True)
+        return True
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index ee41bff4..00def1bd 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1478,6 +1478,40 @@ class FetchCheckStatusTest(FetcherTest):
 
         connection_cache.close_connections()
 
+    @skipIfNoNetwork()
+    def test_git_checkstatus(self):
+        CHECKSTATUS_GOOD_REPO = "git://git.yoctoproject.org/yocto-docs;branch=master"
+        CHECKSTATUS_GOOD_HASH = "2bd14d3810a68082ce01b459cf2799d796a32e63"
+
+        def do_git_checkstatus(url, srcrev):
+            self.d.setVar("SRCREV", srcrev)
+            fetch = bb.fetch2.Fetch([url], self.d)
+            ud = fetch.ud[url]
+            m = ud.method
+            return m.checkstatus(fetch, ud, self.d)
+
+        # Valid URI + SRCREV returns true
+        ret = do_git_checkstatus(CHECKSTATUS_GOOD_REPO, CHECKSTATUS_GOOD_HASH)
+        self.assertTrue(ret,
+                        msg="URI %s, can't check status" %
+                        (CHECKSTATUS_GOOD_REPO))
+
+        # Unavailable server returns false
+        invalid_git_uri = 'git://git.test.invalid/yocto-docs;branch=master'
+        ret = do_git_checkstatus(invalid_git_uri, CHECKSTATUS_GOOD_HASH)
+        self.assertFalse(
+            ret,
+            msg="URI %s, checkstatus() returns true for invalid Git server" %
+            (invalid_git_uri))
+
+        # Invalid/disappeared SRCREV returns false
+        rev_bad = "f" * 40
+        ret = do_git_checkstatus(CHECKSTATUS_GOOD_REPO, rev_bad)
+        self.assertFalse(
+            ret,
+            msg="URI %s, REF %s, checkstatus() returns true for invalid ref" %
+            (CHECKSTATUS_GOOD_REPO, rev_bad))
+
 
 class GitMakeShallowTest(FetcherTest):
     def setUp(self):
-- 
2.17.1


