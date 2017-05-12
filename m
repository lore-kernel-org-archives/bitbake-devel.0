Return-Path: <kergoth@gmail.com>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
	by mail.openembedded.org (Postfix) with ESMTP id E4CA677D29
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 21:46:54 +0000 (UTC)
Received: by mail-pg0-f68.google.com with SMTP id h64so4262346pge.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 14:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=qg368w16W2kWYksiHPysek76STASdeWEK5nEdzcVO5A=;
	b=N27XMlsRY83QaATwWeSUWTuzu6LqZq/5GD+7hK+gryZHcBL5CijKcmPLtXw5kGznLQ
	2BPGkJVI/oLgBYMF02VnYXpFfY98qrl/trJ7qfMYZAeWaA811Lej/D1HCpwkiCSU73SW
	15N14k/2dvzcHz6HIe13uASZCovuUX4UVoI9z5I3/h+D+wFQZwO/Vlzw8yRgp4v2lmtP
	JudrmseRVyNc0XiMBGW58gWS16cyep3jCU2Et3bLz/XbeUo8XsHh/g7+cZhZla7/waiu
	GfM/r8lZUrvTsjYYPDczUp5hCTo6NhLGUavCyFSmtMV8mexwZ4NLeI7ueYaYg0KFb9mi
	ZE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=qg368w16W2kWYksiHPysek76STASdeWEK5nEdzcVO5A=;
	b=ZZSFBBanAvpETvStlIOuCBVoT39ipzcMqSm8VKC922JeBGlIz82cCH1FflZz3/4Jns
	L+QkYzpDDsCUyDJW+IcyRIYyJV/Qn5xhxm5jZI6vVJta5i0IPyD8vk0huCPjLnp5PfsA
	xULrJ7/rN/Q4q3Vvz9o4eMb/RPSxTe5kCpYdEY0bNfoPpMuZLbUxKLvOmHhb4wl/fHL+
	mUGGzw8Ef8x587/7pBvo0viaA0OT4fLihGGeU8iu7LhDMYy97BpowqEMb42nqLU+BD5m
	xH47LsQXubeUcRgIpKD2QRT5+AAbVSfWyF641jX8vAl92dwhbnOBjXg+/3r+6T8+XLjc
	w/iw==
X-Gm-Message-State: AODbwcAiwlPPAgCmfghLSiDWVGP7bRP2SVuUH4iR0e79CFjDQczs0PwE
	YJES7fUVmmU1Eg==
X-Received: by 10.99.39.194 with SMTP id n185mr6579602pgn.15.1494625616085;
	Fri, 12 May 2017 14:46:56 -0700 (PDT)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id
	v63sm1244051pfi.133.2017.05.12.14.46.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 12 May 2017 14:46:54 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 13 May 2017 02:46:30 +0500
Message-Id: <57fc90550504cbdb2b843126aa22fc79d0340608.1494623828.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <cover.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
In-Reply-To: <cover.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 5/8] fetch/git: add support for keeping extra refs for shallow
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
X-List-Received-Date: Fri, 12 May 2017 21:46:55 -0000

By default, all unused refs (branches & tags) are removed from the repository,
as shallow processing scales with the number of refs it has to process. Add
the ability to explicitly specify additional refs to keep. This is
particularly useful for recipes with custom checkout processes, or whose
git-based versioning requires a tag be available (i.e. for `git describe
--tags`). The new `BB_GIT_SHALLOW_EXTRA_REFS` variable is a space-separated
list of refs, fully specified, and support wildcards.

Example usages:

    BB_GIT_SHALLOW_EXTRA_REFS = "refs/tags/v1.0"
    BB_GIT_SHALLOW_EXTRA_REFS += "refs/heads/*"

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/git.py  | 22 +++++++++++++++++++++-
 lib/bb/tests/fetch.py | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 250109bf..aa972c5c 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -72,6 +72,7 @@ Supported SRC_URI options are:
 
 import collections
 import errno
+import fnmatch
 import os
 import re
 import subprocess
@@ -180,6 +181,7 @@ class Git(FetchMethod):
             ud.cloneflags += " --mirror"
 
         ud.shallow = d.getVar("BB_GIT_SHALLOW") == "1"
+        ud.shallow_extra_refs = (d.getVar("BB_GIT_SHALLOW_EXTRA_REFS") or "").split()
 
         depth_default = d.getVar("BB_GIT_SHALLOW_DEPTH")
         if depth_default is not None:
@@ -265,8 +267,13 @@ class Git(FetchMethod):
                 if depth:
                     tarballname = "%s-%s" % (tarballname, depth)
 
+            shallow_refs = []
             if not ud.nobranch:
-                tarballname = "%s_%s" % (tarballname, "_".join(sorted(ud.branches.values())).replace('/', '.'))
+                shallow_refs.extend(ud.branches.values())
+            if ud.shallow_extra_refs:
+                shallow_refs.extend(r.replace('refs/heads/', '').replace('*', 'ALL') for r in ud.shallow_extra_refs)
+            if shallow_refs:
+                tarballname = "%s_%s" % (tarballname, "_".join(sorted(shallow_refs)).replace('/', '.'))
 
             fetcher = self.__class__.__name__.lower()
             ud.shallowtarball = '%sshallow_%s.tar.gz' % (fetcher, tarballname)
@@ -408,6 +415,19 @@ class Git(FetchMethod):
         # Map srcrev+depths to revisions
         shallow_revisions = runfetchcmd("%s rev-parse %s" % (ud.basecmd, " ".join(to_parse)), d, workdir=dest).splitlines()
 
+        # Apply extra ref wildcards
+        all_refs = runfetchcmd('%s for-each-ref "--format=%%(refname)"' % ud.basecmd,
+                               d, workdir=dest).splitlines()
+        for r in ud.shallow_extra_refs:
+            if not ud.bareclone:
+                r = r.replace('refs/heads/', 'refs/remotes/origin/')
+
+            if '*' in r:
+                matches = filter(lambda a: fnmatch.fnmatchcase(a, r), all_refs)
+                shallow_branches.extend(matches)
+            else:
+                shallow_branches.append(r)
+
         # Make the repository shallow
         shallow_cmd = ['git', 'make-shallow', '-s']
         for b in shallow_branches:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 0b0116b4..3e2ce530 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1293,6 +1293,48 @@ class GitShallowTest(FetcherTest):
         with self.assertRaises(bb.fetch2.FetchError):
             self.fetch()
 
+    def test_shallow_extra_refs(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.git('branch a_branch', cwd=self.srcdir)
+        self.assertRefs(['master', 'a_branch'], cwd=self.srcdir)
+        self.assertRevCount(2, cwd=self.srcdir)
+
+        self.d.setVar('BB_GIT_SHALLOW_EXTRA_REFS', 'refs/heads/a_branch')
+        self.fetch_shallow()
+
+        self.assertRefs(['master', 'origin/master', 'origin/a_branch'])
+        self.assertRevCount(1)
+
+    def test_shallow_extra_refs_wildcard(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.git('branch a_branch', cwd=self.srcdir)
+        self.git('tag v1.0', cwd=self.srcdir)
+        self.assertRefs(['master', 'a_branch', 'v1.0'], cwd=self.srcdir)
+        self.assertRevCount(2, cwd=self.srcdir)
+
+        self.d.setVar('BB_GIT_SHALLOW_EXTRA_REFS', 'refs/tags/*')
+        self.fetch_shallow()
+
+        self.assertRefs(['master', 'origin/master', 'v1.0'])
+        self.assertRevCount(1)
+
+    def test_shallow_missing_extra_refs(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+
+        self.d.setVar('BB_GIT_SHALLOW_EXTRA_REFS', 'refs/heads/foo')
+        with self.assertRaises(bb.fetch2.FetchError):
+            self.fetch()
+
+    def test_shallow_missing_extra_refs_wildcard(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+
+        self.d.setVar('BB_GIT_SHALLOW_EXTRA_REFS', 'refs/tags/*')
+        self.fetch()
+
     if os.environ.get("BB_SKIP_NETTESTS") == "yes":
         print("Unset BB_SKIP_NETTESTS to run network tests")
     else:
-- 
2.11.1


