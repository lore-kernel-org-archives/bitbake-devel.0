Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68EFCD6E5F
	for <webhook@archiver.kernel.org>; Sun, 31 May 2026 18:27:58 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12243.1780252069728062153
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 31 May 2026 11:27:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YxSuNQOY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45eee266c6cso2209846f8f.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 31 May 2026 11:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780252068; x=1780856868; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxgH/hSX18S2Op8jbGHNs+WU8jb9Ew/kwnISk8KOvok=;
        b=YxSuNQOYyd2VmbW0ZJxFyvIzR/P9MbWHPrrBLp/B1JP+7iDed53qf0hND47nIitGQS
         qF89ES/Dso1cJakg4BLwTDHZh7ADu7Dcwmqvbf+2JnnQXXHYwb2QvOcJRC7WqK1fxfPn
         J6nIqn/NpcPGsHK2eG2o5NlYHWaCPSliWpulo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780252068; x=1780856868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pxgH/hSX18S2Op8jbGHNs+WU8jb9Ew/kwnISk8KOvok=;
        b=KEuUeszLU+LYiu4onzCu/ynS8h6Ad1HC+gTxwKqaOD3fGYQbKbkQHU8M+vBPM+XR+X
         R25/XARk0t3nlY+gBrzAGR5lU7cwi4PSC15L0ugaiCJBtXIUHrOImVJBEdD9OaK8X6ly
         Cf69Dy3prhA/eVxkv73FbS0d6qYzTclYKSAgSzdWqloa6FLTBObXp0qqEdvU1k+9T3an
         3+OXqccRSR3n4ZgEBZBvrG5FzgLNaH02kkR13J1VezU5Cm3nC2573SE/cliII4G25f89
         8xG13Hh1z4tjNnT449OQv4D2M1QqcCfIH1cBcbp44eoMZKXHnKK4UVqSJ3WBW+5UDjHH
         tgyg==
X-Gm-Message-State: AOJu0YwJ+32CJTu8+qNl8C51UsgJgQynE94VgSOD5EGEV9Vl0r5M32TF
	vIkM1Ab9NV4hogjhmsJijMJTNhAqaVMHef3z4MbevwPuD55vCmPXQWjjQmSpJFVuEUiRZivmYBW
	WuKDe
X-Gm-Gg: Acq92OEUAUR9Ny8JBAVfvJflgIA3Ec+fA7F+I8HWvEJl2UWFxkfpwJC+Aq/EyahUupz
	eo4OgeQvV2RE1AQc16LVu4gsTeIj0s+Z68EooBcdf1eU4yLAp0xIpbPpNTtIdEQIIp+z/Wcn4po
	Ou7Igm8+NbxFNj1ncG0vLtpDsAHlKC+sZ1pC75AoT1Hg8MTudooqIcr3V4oBQsu43ymSeRmbEJb
	tJhFTbgYenSusP90P1xJ/kJyOoE8Ih2rnu3SIwn3386NkDgEj8IvSPNoH3nUkAXUu+OrNh5SlOl
	x5rmnX+0UyO9gJSwWP/9BDGZin7xBpBZW7O9yRQ+xXAyKHO+1mbJvERTaK4uzoUy+/mReTN/BGi
	+fHtP8dZBwXyr40sfCzDwsz7Z1FQErQAQU3zIYsfJsUZS/EueXfIyjl1mLVSnztJWgd3bmwwtf5
	pI9ZtGfdxVAsy3iRpvDjN9FxKKHPW0xDbd9jM5SgygFCIAKIq68VAV+5N2Xtp4/j4=
X-Received: by 2002:a5d:6049:0:b0:45e:ea68:5237 with SMTP id ffacd0b85a97d-45ef6b138e9mr11796207f8f.11.1780252067454;
        Sun, 31 May 2026 11:27:47 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:229e:2449:eb7c:dbd2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354bb62sm18563488f8f.19.2026.05.31.11.27.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 11:27:45 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/6] tests/{fetch,setup}: Convert string commands to lists
Date: Sun, 31 May 2026 19:27:39 +0100
Message-ID: <20260531182743.2412946-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531182743.2412946-1-richard.purdie@linuxfoundation.org>
References: <20260531182743.2412946-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 31 May 2026 18:27:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19573

String commands have to be processed by subprocess using shell=True which
is suboptimal for all kinds of reasons, including quoting. Convert to use
a list for self.git() to improve efficiency and the robustness of code. It
also means copy and paste will be more likely to use the preferred form.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 105 ++++++++++++++++++++----------------------
 lib/bb/tests/setup.py |  34 +++++++-------
 2 files changed, 68 insertions(+), 71 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index ebc80aa8cce..626876ed07b 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -429,16 +429,13 @@ class FetcherTest(unittest.TestCase):
             bb.utils.prunedir(self.tempdir)
 
     def git(self, cmd, cwd=None):
-        if isinstance(cmd, str):
-            cmd = 'git -c safe.bareRepository=all ' + cmd
-        else:
-            cmd = ['git', '-c', 'safe.bareRepository=all'] + cmd
+        cmd = ['git', '-c', 'safe.bareRepository=all'] + cmd
         if cwd is None:
             cwd = self.gitdir
         return bb.process.run(cmd, cwd=cwd)[0]
 
     def git_init(self, cwd=None):
-        self.git('init', cwd=cwd)
+        self.git(['init'], cwd=cwd)
         # Explicitly set initial branch to master as
         # a common setup is to use other default
         # branch than master.
@@ -1884,7 +1881,7 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('b')
         self.assertRevCount(2, cwd=self.srcdir)
 
-        srcrev = self.git('rev-parse HEAD', cwd=self.srcdir).strip()
+        srcrev = self.git(['rev-parse', 'HEAD'], cwd=self.srcdir).strip()
         self.d.setVar('SRCREV', srcrev)
         uri = self.d.getVar('SRC_URI').split()[0]
         uri = '%s;nobranch=1;bare=1' % uri
@@ -1951,7 +1948,7 @@ class GitShallowTest(FetcherTest):
         fetcher, ud = self.fetch()
 
         # Ensure we have a current mirror tarball, but an out of date clone
-        self.git('update-ref refs/heads/master refs/heads/master~1', cwd=ud.clonedir)
+        self.git(['update-ref', 'refs/heads/master', 'refs/heads/master~1'], cwd=ud.clonedir)
         self.assertRevCount(2, cwd=ud.clonedir)
 
         # Fetch and unpack, from the current tarball, not the out of date clone
@@ -1978,12 +1975,12 @@ class GitShallowTest(FetcherTest):
 
         self.fetch_shallow()
         self.assertRevCount(1)
-        assert not self.git('fsck --dangling')
+        assert not self.git(['fsck', '--dangling'])
 
     def test_shallow_srcrev_branch_truncation(self):
         self.add_empty_file('a')
         self.add_empty_file('b')
-        b_commit = self.git('rev-parse HEAD', cwd=self.srcdir).rstrip()
+        b_commit = self.git(['rev-parse', 'HEAD'], cwd=self.srcdir).rstrip()
         self.add_empty_file('c')
         self.assertRevCount(3, cwd=self.srcdir)
 
@@ -1992,7 +1989,7 @@ class GitShallowTest(FetcherTest):
 
         # The 'c' commit was removed entirely, and 'a' was removed from history
         self.assertRevCount(1, ['--all'])
-        self.assertEqual(self.git('rev-parse HEAD').strip(), b_commit)
+        self.assertEqual(self.git(['rev-parse', 'HEAD']).strip(), b_commit)
         assert os.path.exists(os.path.join(self.gitdir, 'a'))
         assert os.path.exists(os.path.join(self.gitdir, 'b'))
         assert not os.path.exists(os.path.join(self.gitdir, 'c'))
@@ -2000,7 +1997,7 @@ class GitShallowTest(FetcherTest):
     def test_shallow_ref_pruning(self):
         self.add_empty_file('a')
         self.add_empty_file('b')
-        self.git('branch a_branch', cwd=self.srcdir)
+        self.git(['branch', 'a_branch'], cwd=self.srcdir)
         self.assertRefs(['master', 'a_branch'], cwd=self.srcdir)
         self.assertRevCount(2, cwd=self.srcdir)
 
@@ -2017,15 +2014,15 @@ class GitShallowTest(FetcherTest):
         bb.utils.mkdirhier(smdir)
         self.git_init(cwd=smdir)
         # Make this look like it was cloned from a remote...
-        self.git('config --add remote.origin.url "%s"' % smdir, cwd=smdir)
-        self.git('config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"', cwd=smdir)
+        self.git(['config', '--add', 'remote.origin.url', '"%s"' % smdir], cwd=smdir)
+        self.git(['config', '--add', 'remote.origin.fetch', '"+refs/heads/*:refs/remotes/origin/*"'], cwd=smdir)
         self.add_empty_file('asub', cwd=smdir)
         self.add_empty_file('bsub', cwd=smdir)
 
-        self.git('submodule init', cwd=self.srcdir)
-        self.git('-c protocol.file.allow=always submodule add file://%s' % smdir, cwd=self.srcdir)
-        self.git('submodule update', cwd=self.srcdir)
-        self.git('commit -m submodule -a', cwd=self.srcdir)
+        self.git(['submodule', 'init'], cwd=self.srcdir)
+        self.git(['-c', 'protocol.file.allow=always', 'submodule', 'add', 'file://%s' % smdir], cwd=self.srcdir)
+        self.git(['submodule', 'update'], cwd=self.srcdir)
+        self.git(['commit', '-m', 'submodule', '-a'], cwd=self.srcdir)
 
         uri = 'gitsm://%s;protocol=file;subdir=${S};branch=master' % self.srcdir
         fetcher, ud = self.fetch_shallow(uri)
@@ -2047,15 +2044,15 @@ class GitShallowTest(FetcherTest):
         bb.utils.mkdirhier(smdir)
         self.git_init(cwd=smdir)
         # Make this look like it was cloned from a remote...
-        self.git('config --add remote.origin.url "%s"' % smdir, cwd=smdir)
-        self.git('config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"', cwd=smdir)
+        self.git(['config', '--add', 'remote.origin.url', '"%s"' % smdir], cwd=smdir)
+        self.git(['config', '--add', 'remote.origin.fetch', '"+refs/heads/*:refs/remotes/origin/*"'], cwd=smdir)
         self.add_empty_file('asub', cwd=smdir)
         self.add_empty_file('bsub', cwd=smdir)
 
-        self.git('submodule init', cwd=self.srcdir)
-        self.git('-c protocol.file.allow=always submodule add file://%s' % smdir, cwd=self.srcdir)
-        self.git('submodule update', cwd=self.srcdir)
-        self.git('commit -m submodule -a', cwd=self.srcdir)
+        self.git(['submodule', 'init'], cwd=self.srcdir)
+        self.git(['-c', 'protocol.file.allow=always', 'submodule', 'add', 'file://%s' % smdir], cwd=self.srcdir)
+        self.git(['submodule', 'update'], cwd=self.srcdir)
+        self.git(['commit', '-m', 'submodule', '-a'], cwd=self.srcdir)
 
         uri = 'gitsm://%s;protocol=file;subdir=${S};branch=master' % self.srcdir
 
@@ -2085,10 +2082,10 @@ class GitShallowTest(FetcherTest):
         def test_shallow_annex(self):
             self.add_empty_file('a')
             self.add_empty_file('b')
-            self.git('annex init', cwd=self.srcdir)
+            self.git(['annex', 'init'], cwd=self.srcdir)
             open(os.path.join(self.srcdir, 'c'), 'w').close()
-            self.git('annex add c', cwd=self.srcdir)
-            self.git('commit --author "Foo Bar <foo@bar>" -m annex-c -a', cwd=self.srcdir)
+            self.git(['annex', 'add', 'c'], cwd=self.srcdir)
+            self.git(['commit', '--author', '"Foo Bar <foo@bar>"', '-m', 'annex-c', '-a'], cwd=self.srcdir)
             bb.process.run('chmod u+w -R %s' % self.srcdir)
 
             uri = 'gitannex://%s;protocol=file;subdir=${S};branch=master' % self.srcdir
@@ -2180,7 +2177,7 @@ class GitShallowTest(FetcherTest):
     def test_shallow_extra_refs(self):
         self.add_empty_file('a')
         self.add_empty_file('b')
-        self.git('branch a_branch', cwd=self.srcdir)
+        self.git(['branch', 'a_branch'], cwd=self.srcdir)
         self.assertRefs(['master', 'a_branch'], cwd=self.srcdir)
         self.assertRevCount(2, cwd=self.srcdir)
 
@@ -2193,8 +2190,8 @@ class GitShallowTest(FetcherTest):
     def test_shallow_extra_refs_wildcard(self):
         self.add_empty_file('a')
         self.add_empty_file('b')
-        self.git('branch a_branch', cwd=self.srcdir)
-        self.git('tag v1.0', cwd=self.srcdir)
+        self.git(['branch', 'a_branch'], cwd=self.srcdir)
+        self.git(['tag', 'v1.0'], cwd=self.srcdir)
         self.assertRefs(['master', 'a_branch', 'v1.0'], cwd=self.srcdir)
         self.assertRevCount(2, cwd=self.srcdir)
 
@@ -2253,14 +2250,14 @@ class GitShallowTest(FetcherTest):
         # Create initial git repo
         self.add_empty_file('a')
         self.add_empty_file('b')
-        self.git('checkout -b a_branch', cwd=self.srcdir)
+        self.git(['checkout', '-b', 'a_branch'], cwd=self.srcdir)
         self.add_empty_file('c')
         self.add_empty_file('d')
-        self.git('checkout master', cwd=self.srcdir)
-        self.git('tag v0.0 a_branch', cwd=self.srcdir)
+        self.git(['checkout', 'master'], cwd=self.srcdir)
+        self.git(['tag', 'v0.0', 'a_branch'], cwd=self.srcdir)
         self.add_empty_file('e')
-        self.git('merge --no-ff --no-edit a_branch', cwd=self.srcdir)
-        self.git('branch -d a_branch', cwd=self.srcdir)
+        self.git(['merge', '--no-ff', '--no-edit', 'a_branch'], cwd=self.srcdir)
+        self.git(['branch', '-d', 'a_branch'], cwd=self.srcdir)
         self.add_empty_file('f')
         self.assertRevCount(7, cwd=self.srcdir)
 
@@ -2285,7 +2282,7 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('a')
         self.add_empty_file('b')
         fetcher, ud = self.fetch(self.d.getVar('SRC_URI'))
-        self.git('tag v0.0 master', cwd=self.srcdir)
+        self.git(['tag', 'v0.0', 'master'], cwd=self.srcdir)
         self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
         self.d.setVar('BB_GIT_SHALLOW_REVS', 'v0.0')
 
@@ -2333,9 +2330,9 @@ class GitShallowTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_bitbake(self):
-        self.git('remote add --mirror=fetch origin https://github.com/openembedded/bitbake', cwd=self.srcdir)
-        self.git('config core.bare true', cwd=self.srcdir)
-        self.git('fetch', cwd=self.srcdir)
+        self.git(['remote', 'add', '--mirror=fetch', 'origin', 'https://github.com/openembedded/bitbake'], cwd=self.srcdir)
+        self.git(['config', 'core.bare', 'true'], cwd=self.srcdir)
+        self.git(['fetch'], cwd=self.srcdir)
 
         self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
         # Note that the 1.10.0 tag is annotated, so this also tests
@@ -2345,8 +2342,8 @@ class GitShallowTest(FetcherTest):
         self.fetch_shallow()
 
         # Confirm that the history of 1.10.0 was removed
-        orig_revs = len(self.git('rev-list master', cwd=self.srcdir).splitlines())
-        revs = len(self.git('rev-list master').splitlines())
+        orig_revs = len(self.git(['rev-list', 'master'], cwd=self.srcdir).splitlines())
+        revs = len(self.git(['rev-list', 'master']).splitlines())
         self.assertNotEqual(orig_revs, revs)
         self.assertRefs(['master', 'origin/master'])
         self.assertRevCount(orig_revs - 1760)
@@ -2378,10 +2375,10 @@ class GitShallowTest(FetcherTest):
     def test_shallow_succeeds_with_tag_containing_slash(self):
         self.add_empty_file('a')
         self.add_empty_file('b')
-        self.git('tag t1/t2/t3', cwd=self.srcdir)
+        self.git(['tag', 't1/t2/t3'], cwd=self.srcdir)
         self.assertRevCount(2, cwd=self.srcdir)
 
-        srcrev = self.git('rev-parse HEAD', cwd=self.srcdir).strip()
+        srcrev = self.git(['rev-parse', 'HEAD'], cwd=self.srcdir).strip()
         self.d.setVar('SRCREV', srcrev)
         uri = self.d.getVar('SRC_URI').split()[0]
         uri = '%s;tag=t1/t2/t3' % uri
@@ -2743,18 +2740,18 @@ class FetchLocallyMissingTagFromRemote(FetcherTest):
         # then add a tag to this repo, and fetch it again, without
         # changing SRC_REV, but by adding ';tag=tag1` to SRC_URI
         # the new tag should be fetched and unpacked
-        srcrev = self.git('rev-parse HEAD', cwd=self.srcdir).strip()
+        srcrev = self.git(['rev-parse', 'HEAD'], cwd=self.srcdir).strip()
         self.d.setVar('SRCREV', srcrev)
         src_uri = self.d.getVar('SRC_URI')
         self._fetch_and_unpack(src_uri)
 
-        self.git('tag -m -a tag1', cwd=self.srcdir)
+        self.git(['tag', '-m', '-a', 'tag1'], cwd=self.srcdir)
 
         src_uri = '%s;tag=tag1' % self.d.getVar('SRC_URI').split()[0]
         self.d.setVar('SRC_URI', src_uri)
         self._fetch_and_unpack(src_uri)
 
-        output = self.git('log --pretty=oneline -n 1 refs/tags/tag1', cwd=self.gitdir)
+        output = self.git(['log', '--pretty=oneline', '-n', '1', 'refs/tags/tag1'], cwd=self.gitdir)
         assert "fatal: ambiguous argument" not in output
 
 
@@ -3500,20 +3497,20 @@ class FetchPremirroronlyLocalTest(FetcherTest):
     def git_new_commit(self):
         import random
         os.unlink(os.path.join(self.mirrordir, self.mirrorname))
-        branch = self.git("branch --show-current", self.gitdir).split()
+        branch = self.git(["branch", "--show-current"], self.gitdir).split()
         with open(os.path.join(self.gitdir, self.testfilename), "w") as testfile:
             testfile.write("File {} from branch {}; Useless random data {}".format(self.testfilename, branch, random.random()))
-        self.git("add {}".format(self.testfilename), self.gitdir)
-        self.git("commit -a -m \"This random commit {} in branch {}. I'm useless.\"".format(random.random(), branch), self.gitdir)
+        self.git(['add', self.testfilename], self.gitdir)
+        self.git(['commit', '-a', '-m', "\"This random commit {} in branch {}. I'm useless.\"".format(random.random(), branch)], self.gitdir)
         bb.process.run('tar -czvf {} .'.format(os.path.join(self.mirrordir, self.mirrorname)), cwd =  self.gitdir)
-        return self.git("rev-parse HEAD", self.gitdir).strip()
+        return self.git(["rev-parse", "HEAD"], self.gitdir).strip()
 
     def git_new_branch(self, name):
         self.git_new_commit()
-        head = self.git("rev-parse HEAD", self.gitdir).strip()
-        self.git("checkout -b {}".format(name), self.gitdir)
+        head = self.git(["rev-parse", "HEAD"], self.gitdir).strip()
+        self.git(["checkout", "-b", name], self.gitdir)
         newrev = self.git_new_commit()
-        self.git("checkout {}".format(head), self.gitdir)
+        self.git(["checkout", head], self.gitdir)
         return newrev
 
     def test_mirror_multiple_fetches(self):
@@ -3573,8 +3570,8 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
     def make_git_repo(self):
         self.mirrorname = "git2_git.yoctoproject.org.fstests.tar.gz"
         os.makedirs(self.clonedir)
-        self.git("clone --bare {}".format(self.giturl), self.clonedir)
-        self.git("update-ref HEAD 15413486df1f5a5b5af699b6f3ba5f0984e52a9f", self.gitdir)
+        self.git(["clone", "--bare", self.giturl], self.clonedir)
+        self.git(["update-ref", "HEAD", "15413486df1f5a5b5af699b6f3ba5f0984e52a9f"], self.gitdir)
         bb.process.run('tar -czvf {} .'.format(os.path.join(self.mirrordir, self.mirrorname)), cwd =  self.gitdir)
         shutil.rmtree(self.clonedir)
 
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 638d56d3bb3..ad829c7ab65 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -22,12 +22,12 @@ class BitbakeSetupTest(FetcherTest):
 
         os.makedirs(self.registrypath)
         self.git_init(cwd=self.registrypath)
-        self.git('commit --allow-empty -m "Initial commit"', cwd=self.registrypath)
+        self.git(['commit', '--allow-empty', '-m', "Initial commit"], cwd=self.registrypath)
 
         self.testrepopath = os.path.join(self.tempdir, "test-repo")
         os.makedirs(self.testrepopath)
         self.git_init(cwd=self.testrepopath)
-        self.git('commit --allow-empty -m "Initial commit"', cwd=self.testrepopath)
+        self.git(['commit', '--allow-empty', '-m', "Initial commit"], cwd=self.testrepopath)
 
         oeinitbuildenv = """BBPATH=$1
 export BBPATH
@@ -176,8 +176,8 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         os.makedirs(os.path.join(self.registrypath, os.path.dirname(name)), exist_ok=True)
         with open(os.path.join(self.registrypath, name), 'w') as f:
             f.write(config)
-        self.git('add {}'.format(name), cwd=self.registrypath)
-        self.git('commit -m "Adding {}"'.format(name), cwd=self.registrypath)
+        self.git(['add', name], cwd=self.registrypath)
+        self.git(['commit', '-m', "Adding " + name], cwd=self.registrypath)
         return json.loads(config)
 
     def add_json_config_to_registry(self, name, rev, branch):
@@ -214,8 +214,8 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         if script:
             st = os.stat(fullname)
             os.chmod(fullname, st.st_mode | stat.S_IEXEC)
-        self.git('add {}'.format(name), cwd=self.testrepopath)
-        self.git('commit -m "Adding {}"'.format(name), cwd=self.testrepopath)
+        self.git(['add', name], cwd=self.testrepopath)
+        self.git(['commit', '-m', "Adding " + name], cwd=self.testrepopath)
 
     def config_is_unchanged(self, setuppath):
         os.environ['BBPATH'] = os.path.join(setuppath, 'build')
@@ -238,7 +238,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         with open(os.path.join(setuppath, 'config', "sources-fixed-revisions.json")) as f:
             sources_fixed_revisions = json.load(f)
         self.assertTrue('test-repo' in sources_fixed_revisions['sources'].keys())
-        revision = self.git('rev-parse HEAD', cwd=self.testrepopath).strip()
+        revision = self.git(['rev-parse', 'HEAD'], cwd=self.testrepopath).strip()
         self.assertEqual(revision, sources_fixed_revisions['sources']['test-repo']['git-remote']['rev'])
 
         if "oe-template" in bitbake_config:
@@ -397,7 +397,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         prev_test_file_content = test_file_content
         test_file_content = 'modified-in-branch\n'
         branch = "another-branch"
-        self.git('checkout -b {}'.format(branch), cwd=self.testrepopath)
+        self.git(['checkout', '-b', branch], cwd=self.testrepopath)
         self.add_file_to_testrepo('test-file', test_file_content)
         json_1 = self.add_json_config_to_registry('test-config-1.conf.json', branch, branch)
         for c in variants:
@@ -427,7 +427,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         prev_test_file_content = test_file_content
         test_file_content = 'modified-in-branch-no-bb-conf-update\n'
         branch = "another-branch-no-bb-conf-update"
-        self.git('checkout -b {}'.format(branch), cwd=self.testrepopath)
+        self.git(['checkout', '-b', branch], cwd=self.testrepopath)
         self.add_file_to_testrepo('test-file', test_file_content)
         json_1 = self.add_json_config_to_registry('test-config-1.conf.json', branch, branch)
         for c in variants:
@@ -473,7 +473,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
 
         prev_path = self.testrepopath
         self.testrepopath = prev_path + "-2"
-        self.git("clone {} {}".format(prev_path, self.testrepopath), cwd=self.tempdir)
+        self.git(['clone', prev_path, self.testrepopath], cwd=self.tempdir)
         json_1 = self.add_local_json_config_to_registry('test-config-1.conf.json', self.testrepopath)
         os.environ['BBPATH'] = os.path.join(setuppath, 'build')
         out = self.runbbsetup("update --update-bb-conf='yes'")
@@ -499,8 +499,8 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         ## edit a file and make a commit such that no rebase conflicts occur
         with open(os.path.join(layer_path, 'local-modification'), 'w') as f:
             f.write('locally-modified-again\n')
-        self.git('add .', cwd=layer_path)
-        self.git('commit -m "Adding a local modification"', cwd=layer_path)
+        self.git(['add', '.'], cwd=layer_path)
+        self.git(['commit', '-m', 'Adding a local modification'], cwd=layer_path)
         test_file_content = "modified-again-and-again\n"
         self.add_file_to_testrepo('test-file', test_file_content)
         out = self.runbbsetup("update --update-bb-conf='yes'")
@@ -509,8 +509,8 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         ## edit a file and make a commit in a way that causes a rebase conflict
         with open(os.path.join(layer_path, 'test-file'), 'w') as f:
             f.write('locally-modified\n')
-        self.git('add .', cwd=layer_path)
-        self.git('commit -m "Adding a local modification"', cwd=layer_path)
+        self.git(['add', '.'], cwd=layer_path)
+        self.git(['commit', '-m', 'Adding a local modification'], cwd=layer_path)
         test_file_content = "remotely-modified\n"
         self.add_file_to_testrepo('test-file', test_file_content)
         with self.assertRaisesRegex(bb.process.ExecutionError, "Merge conflict in test-file"):
@@ -688,7 +688,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         with open(os.path.join(layer_path, 'test-file')) as f:
             self.assertEqual(f.read(), 'upstream-v2\n',
                              "re-cloned layer must contain the upstream content")
-        status = self.git('status --porcelain', cwd=layer_path).strip()
+        status = self.git(['status', '--porcelain'], cwd=layer_path).strip()
         self.assertEqual(status, '',
                          "re-cloned layer must have no local modifications")
         del os.environ['BBPATH']
@@ -703,8 +703,8 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         # Commit a local change that touches the same file as the next upstream commit.
         with open(os.path.join(conflict_layer, 'test-file'), 'w') as f:
             f.write('conflicting-local\n')
-        self.git('add test-file', cwd=conflict_layer)
-        self.git('commit -m "Local conflicting change"', cwd=conflict_layer)
+        self.git(['add', 'test-file'], cwd=conflict_layer)
+        self.git(['commit', '-m', 'Local conflicting change'], cwd=conflict_layer)
 
         # Advance upstream with a conflicting edit.
         self.add_file_to_testrepo('test-file', 'conflicting-upstream\n')

