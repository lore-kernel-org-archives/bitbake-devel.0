Return-Path: <kergoth@gmail.com>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
	by mail.openembedded.org (Postfix) with ESMTP id 882DF77D5B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 21:47:03 +0000 (UTC)
Received: by mail-pg0-f67.google.com with SMTP id i63so8984164pgd.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 14:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=td4CYEIlWggSCZXQrd7ObAfQ7CPXwQG/JbrzXKNsn+A=;
	b=o4DoxgT5aORsHkUH9Na+trGW7neVod7RqAIGstQq8VEvo7l8rqoFI2AFQalix/yoPX
	yJ65pF3GGZ/OsDreyMGvq1oNYQNBDZizJB1JGwG8e9Vc+gQWpeyS6M2Ptaew46Nh0AED
	o8DNtPoE4T0wALaZz9GXB1Mk51NsTg/feDG2wUSnuTQAOoB0gf5BmRCm0ZStpcjRcK4O
	X6nKLg8kNm3YfotsBHJW2dAQRfMSZQF3S6oOc5hCYyxOV89LeqFzfCfmE7xePVYCEzrG
	bHf1mFpyTdZ+YGo+yhvHOOTtT0uqC4DxbeKLxXTRf+/ZMlWYS70WMqAmBBPvtvre9wWJ
	v+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=td4CYEIlWggSCZXQrd7ObAfQ7CPXwQG/JbrzXKNsn+A=;
	b=PjNkKp6XpfEvLUJTktgJkT1gN4JMaONRh4RzPXrYjD0C49d3XJCiEd3n0VjenAtXyH
	Ucq9dVH0/U4h1zh12UGKFaVad79WI+XjbWa1G6LZxXDnagmwFFhPDskoNazY2SDAhQ5S
	FDyk6WxnlVUxNXhvpcQTh5zznYKGMLAx0chUdnrMkHY60s23f6sEzbOgyBOrPqAGYDG0
	z/DWbohJlzZyl8I+idBCsGB8QJb+/Y52UwdX6OvknZCt9ioE7Y2viauu4PWli1kCGp+j
	iMBbS7y6bHm+LnOqJzEkJ67eQICLDADZPNW/JWjziW2MsI486Vru3/2fdJH4GldA7fHZ
	7gvw==
X-Gm-Message-State: AODbwcC97IaSKqrQ4pWUQBzuaDITu+/JV3v5r3uNxbVSakmPiPDVC/gZ
	gsyzlndfhBj7C75cmfI=
X-Received: by 10.98.75.6 with SMTP id y6mr6764196pfa.157.1494625624426;
	Fri, 12 May 2017 14:47:04 -0700 (PDT)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id
	v63sm1244051pfi.133.2017.05.12.14.47.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 12 May 2017 14:47:03 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 13 May 2017 02:46:33 +0500
Message-Id: <b4ca8fa8422818f7d09fbb1988bc189d2a8e7b52.1494623828.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <cover.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
In-Reply-To: <cover.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 8/8] fetch/git: add support for removing arbitrary revs for shallow
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
X-List-Received-Date: Fri, 12 May 2017 21:47:03 -0000

In certain cases, it's valuable to be able to exert more control over what
history is removed, beyond srcrev+depth. As one example, you can remove most
of the upstream kernel history from a kernel repository, keeping predominently
the non-publically-accessible content. If the repository is private, the
history in that repo couldn't be restored via `git fetch --unshallow`, but
upstream history could be.

Example usage:

    # Remove only these revs, not at a particular depth
    BB_GIT_SHALLOW_DEPTH_pn-linux-foo = "0"
    BB_GIT_SHALLOW_REVS_pn-linux-foo = "v4.1"

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/git.py  | 18 +++++++++++++-
 lib/bb/tests/fetch.py | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index aa972c5c..534c93d3 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -196,6 +196,8 @@ class Git(FetchMethod):
             depth_default = 1
         ud.shallow_depths = collections.defaultdict(lambda: depth_default)
 
+        revs_default = d.getVar("BB_GIT_SHALLOW_REVS", True)
+        ud.shallow_revs = []
         ud.branches = {}
         for pos, name in enumerate(ud.names):
             branch = branches[pos]
@@ -213,7 +215,14 @@ class Git(FetchMethod):
                         raise bb.fetch2.FetchError("Invalid depth for BB_GIT_SHALLOW_DEPTH_%s: %s" % (name, shallow_depth))
                     ud.shallow_depths[name] = shallow_depth
 
+            revs = d.getVar("BB_GIT_SHALLOW_REVS_%s" % name)
+            if revs is not None:
+                ud.shallow_revs.extend(revs.split())
+            elif revs_default is not None:
+                ud.shallow_revs.extend(revs_default.split())
+
         if (ud.shallow and
+                not ud.shallow_revs and
                 all(ud.shallow_depths[n] == 0 for n in ud.names)):
             # Shallow disabled for this URL
             ud.shallow = False
@@ -261,6 +270,9 @@ class Git(FetchMethod):
             if ud.bareclone:
                 tarballname = "%s_bare" % tarballname
 
+            if ud.shallow_revs:
+                tarballname = "%s_%s" % (tarballname, "_".join(sorted(ud.shallow_revs)))
+
             for name, revision in sorted(ud.revisions.items()):
                 tarballname = "%s_%s" % (tarballname, ud.revisions[name][:7])
                 depth = ud.shallow_depths[name]
@@ -413,7 +425,11 @@ class Git(FetchMethod):
             runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision), d, workdir=dest)
 
         # Map srcrev+depths to revisions
-        shallow_revisions = runfetchcmd("%s rev-parse %s" % (ud.basecmd, " ".join(to_parse)), d, workdir=dest).splitlines()
+        parsed_depths = runfetchcmd("%s rev-parse %s" % (ud.basecmd, " ".join(to_parse)), d, workdir=dest)
+
+        # Resolve specified revisions
+        parsed_revs = runfetchcmd("%s rev-parse %s" % (ud.basecmd, " ".join('"%s^{}"' % r for r in ud.shallow_revs)), d, workdir=dest)
+        shallow_revisions = parsed_depths.splitlines() + parsed_revs.splitlines()
 
         # Apply extra ref wildcards
         all_refs = runfetchcmd('%s for-each-ref "--format=%%(refname)"' % ud.basecmd,
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 73f7b3f7..343ae8fe 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1259,6 +1259,33 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('c')
         self.add_empty_file('d')
         self.git('checkout master', cwd=self.srcdir)
+        self.git('tag v0.0 a_branch', cwd=self.srcdir)
+        self.add_empty_file('e')
+        self.git('merge --no-ff --no-edit a_branch', cwd=self.srcdir)
+        self.add_empty_file('f')
+        self.assertRevCount(7, cwd=self.srcdir)
+
+        uri = self.d.getVar('SRC_URI', True).split()[0]
+        uri = '%s;branch=master,a_branch;name=master,a_branch' % uri
+
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
+        self.d.setVar('BB_GIT_SHALLOW_REVS', 'v0.0')
+        self.d.setVar('SRCREV_master', '${AUTOREV}')
+        self.d.setVar('SRCREV_a_branch', '${AUTOREV}')
+
+        self.fetch_shallow(uri)
+
+        self.assertRevCount(5)
+        self.assertRefs(['master', 'origin/master', 'origin/a_branch'])
+
+    def test_shallow_multi_one_uri_depths(self):
+        # Create initial git repo
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.git('checkout -b a_branch', cwd=self.srcdir)
+        self.add_empty_file('c')
+        self.add_empty_file('d')
+        self.git('checkout master', cwd=self.srcdir)
         self.add_empty_file('e')
         self.git('merge --no-ff --no-edit a_branch', cwd=self.srcdir)
         self.add_empty_file('f')
@@ -1375,6 +1402,38 @@ class GitShallowTest(FetcherTest):
         self.d.setVar('BB_GIT_SHALLOW_EXTRA_REFS', 'refs/tags/*')
         self.fetch()
 
+    def test_shallow_remove_revs(self):
+        # Create initial git repo
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.git('checkout -b a_branch', cwd=self.srcdir)
+        self.add_empty_file('c')
+        self.add_empty_file('d')
+        self.git('checkout master', cwd=self.srcdir)
+        self.git('tag v0.0 a_branch', cwd=self.srcdir)
+        self.add_empty_file('e')
+        self.git('merge --no-ff --no-edit a_branch', cwd=self.srcdir)
+        self.git('branch -d a_branch', cwd=self.srcdir)
+        self.add_empty_file('f')
+        self.assertRevCount(7, cwd=self.srcdir)
+
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
+        self.d.setVar('BB_GIT_SHALLOW_REVS', 'v0.0')
+
+        self.fetch_shallow()
+
+        self.assertRevCount(5)
+
+    def test_shallow_invalid_revs(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
+        self.d.setVar('BB_GIT_SHALLOW_REVS', 'v0.0')
+
+        with self.assertRaises(bb.fetch2.FetchError):
+            self.fetch()
+
     if os.environ.get("BB_SKIP_NETTESTS") == "yes":
         print("Unset BB_SKIP_NETTESTS to run network tests")
     else:
@@ -1383,11 +1442,16 @@ class GitShallowTest(FetcherTest):
             self.git('config core.bare true', cwd=self.srcdir)
             self.git('fetch --tags', cwd=self.srcdir)
 
-            self.d.setVar('BB_GIT_SHALLOW_DEPTH', '100')
+            self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
+            # Note that the 1.10.0 tag is annotated, so this also tests
+            # reference of an annotated vs unannotated tag
+            self.d.setVar('BB_GIT_SHALLOW_REVS', '1.10.0')
 
             self.fetch_shallow()
 
+            # Confirm that the history of 1.10.0 was removed
             orig_revs = len(self.git('rev-list master', cwd=self.srcdir).splitlines())
             revs = len(self.git('rev-list master').splitlines())
             self.assertNotEqual(orig_revs, revs)
             self.assertRefs(['master', 'origin/master'])
+            self.assertRevCount(orig_revs - 1758)
-- 
2.11.1


