Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3308CD6E61
	for <webhook@archiver.kernel.org>; Sun, 31 May 2026 18:27:58 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12305.1780252070226742570
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 31 May 2026 11:27:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RSVlE07D;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ee6d32402so1796341f8f.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 31 May 2026 11:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780252068; x=1780856868; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAhk2t2u1b/BBq2YHbGtaHwwS5uj7SENGEaRAX0KsT0=;
        b=RSVlE07DvkkxndtkCxwgQ/p7T5VwlT4ewQooDmdGCTGglddZxbN13cX4A0uiPRnMGI
         +KgVZiZe6BqlQaSRDlpQjW6FuobfaphT6lNSVVS5LJcmkORgdQn8ZwzhE+BR5ZidCd4Z
         ON0Mtz0i0KjRkTUXjvfP4XO7gKbBI7Jm2kR08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780252068; x=1780856868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OAhk2t2u1b/BBq2YHbGtaHwwS5uj7SENGEaRAX0KsT0=;
        b=AMKTXtkDNaT10IT3B8HQSlKX6aWqJ9e0nC96zyfOCWk1xTukLZIolAofDyLZI39Y7v
         HSsCqClGTWmsqPH9TjTYjdwQ0YF6RhWerMGBczA31yeU8mFJDriaGTOeJAU0y6kg3Rh4
         PmGuvWGVY4kDaHRe5tAEkEjxxxf4NBm32QFhnIQfk1I8A2gABELPP6gWA861FeunTLgA
         XaAo9NucCyrJFReKID+C/kWyd+Ga8smUbXmzF4Brjbp8wiHQvQQMUxOhlFeoa4TQS5jr
         3dGGlsm6Wr4TWjdjiFLoxtBBEgTP/OkJbJv9Cm+qH6pFiCw2puKUNolD/7KZozmnacRg
         EKDQ==
X-Gm-Message-State: AOJu0Yz0ddehvhZkYgFnrme5LMHwzLrK1AF1u1UkCiWFpgzkY7lXTe7C
	sjwXZqfbmfv4/6OmdB0nBzHwhoRkHjC3fOx5ZY77KKsb5U5CoYKUwxwsM1/RWyueIfUgB/0xNq6
	FiIV9
X-Gm-Gg: Acq92OEc2KWdcPYQUJukhwYQsBQVzBOJ6mycFtUwEOU/LroSn7IJ8xKxsnxbXjEuznF
	CMzneEm7LGFSdfS1D3E1qnI2Q18WYCyyh5MTrm2bDEHhIsMvLQW/blezAJ91dTKFtt9MMUUKWxi
	fSZSqS/rJtb1LUHDB49WeVUtuzKEz1qndGsbjZo8m0qvUtLTAdoCi1eTl2imoMfilYzZi3C7GQ7
	w6h7Nta+RnsSrnvnDO4kdKpNF6RvIhjl9vn7BQusYsFpj4N6S3MP1jjITfiTdX7rkOnR/CbHzAi
	4PfzWhdjJKoJapGCE78HZRy/RLILE8ud+Vg4F5dQumE3AC9W5VQSm7RKHJsNm1igDQoqJK0QSdS
	0pEKLlNybx2tZWcDfNj+BfZ4Zskp9eUsxJ784rq/fEp1DExmix6YHwzOxGKRS5W8qJQRPBQ6Ptj
	0QRRlnHQFzrooeNcudOL0qK58+NOHQj3XKsu0YwOehlrMNsIXPF4ohz3h1EsoNiW4=
X-Received: by 2002:a05:6000:2812:b0:45e:f29d:d42d with SMTP id ffacd0b85a97d-45ef6b5fd92mr11260898f8f.25.1780252068336;
        Sun, 31 May 2026 11:27:48 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:229e:2449:eb7c:dbd2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354bb62sm18563488f8f.19.2026.05.31.11.27.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 11:27:47 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/6] lib/bb: Convert string commands to bb.process.run to lists where possible
Date: Sun, 31 May 2026 19:27:40 +0100
Message-ID: <20260531182743.2412946-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531182743.2412946-1-richard.purdie@linuxfoundation.org>
References: <20260531182743.2412946-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 31 May 2026 18:27:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19574

String commands have to be processed by subprocess using shell=True which
is suboptimal for all kinds of reasons, including quoting. Convert to use
a list where possible to improve efficiency and the robustness of code. It
also means copy and paste will be more likely to use the preferred form.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 32 ++++++++++++++++----------------
 lib/bb/tests/setup.py |  2 +-
 lib/bb/utils.py       |  2 +-
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 626876ed07b..95cf6c414bb 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -425,7 +425,7 @@ class FetcherTest(unittest.TestCase):
         if os.environ.get("BB_TMPDIR_NOCLEAN") == "yes":
             print("Not cleaning up %s. Please remove manually." % self.tempdir)
         else:
-            bb.process.run('chmod u+rw -R %s' % self.tempdir)
+            bb.process.run(['chmod', 'u+rw', '-R', self.tempdir])
             bb.utils.prunedir(self.tempdir)
 
     def git(self, cmd, cwd=None):
@@ -698,7 +698,7 @@ class CleanTarballTest(FetcherTest):
         fetcher.download()
 
         fetcher.unpack(self.unpackdir)
-        mtime = bb.process.run('git log --all -1 --format=%ct',
+        mtime = bb.process.run(['git', 'log', '--all', '-1', '--format=%ct'],
                 cwd=os.path.join(self.unpackdir, 'git'))
         self.assertEqual(len(mtime), 2)
         mtime = int(mtime[0])
@@ -733,9 +733,9 @@ class FetcherLocalTest(FetcherTest):
         os.makedirs(os.path.join(self.localsrcdir, 'dir', 'subdir'))
         touch(os.path.join(self.localsrcdir, 'dir', 'subdir', 'e'))
         touch(os.path.join(self.localsrcdir, r'backslash\x2dsystemd-unit.device'))
-        bb.process.run('tar cf archive.tar -C dir .', cwd=self.localsrcdir)
-        bb.process.run('tar czf archive.tar.gz -C dir .', cwd=self.localsrcdir)
-        bb.process.run('tar cjf archive.tar.bz2 -C dir .', cwd=self.localsrcdir)
+        bb.process.run(['tar', 'cf', 'archive.tar', '-C', 'dir', '.'], cwd=self.localsrcdir)
+        bb.process.run(['tar', 'czf', 'archive.tar.gz', '-C', 'dir', '.'], cwd=self.localsrcdir)
+        bb.process.run(['tar', 'cjf', 'archive.tar.bz2', '-C', 'dir', '.'], cwd=self.localsrcdir)
         self.d.setVar("FILESPATH", self.localsrcdir)
 
     def make_ar_package(self, package_name, data_member="data.tar"):
@@ -1341,18 +1341,18 @@ class SVNTest(FetcherTest):
         repo_dir = tempfile.mkdtemp(dir=self.tempdir,
                                    prefix='svnfetch_localrepo_')
         repo_dir = os.path.abspath(repo_dir)
-        bb.process.run("svnadmin create project", cwd=repo_dir)
+        bb.process.run(['svnadmin', 'create', 'project'], cwd=repo_dir)
 
         self.repo_url = "file://%s/project" % repo_dir
-        bb.process.run("svn import --non-interactive -m 'Initial import' %s %s/trunk" % (src_dir, self.repo_url),
+        bb.process.run(['svn', 'import', '--non-interactive', '-m', 'Initial import', src_dir, "%s/trunk" % self.repo_url],
                        cwd=repo_dir)
 
-        bb.process.run("svn co %s svnfetch_co" % self.repo_url, cwd=self.tempdir)
+        bb.process.run(['svn', 'co', self.repo_url, 'svnfetch_co'], cwd=self.tempdir)
         # Github won't emulate SVN anymore (see https://github.blog/2023-01-20-sunsetting-subversion-support/)
         # Use still accessible svn repo (only trunk to avoid longer downloads)
-        bb.process.run("svn propset svn:externals 'bitbake https://svn.apache.org/repos/asf/serf/trunk' .",
+        bb.process.run(['svn', 'propset', 'svn:externals', "'bitbake https://svn.apache.org/repos/asf/serf/trunk'", "."],
                        cwd=os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
-        bb.process.run("svn commit --non-interactive -m 'Add external'",
+        bb.process.run(['svn', 'commit', '--non-interactive', '-m', 'Add external'],
                        cwd=os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
 
         self.src_dir = src_dir
@@ -1854,7 +1854,7 @@ class GitShallowTest(FetcherTest):
         # fetch and unpack, from the shallow tarball
         bb.utils.remove(self.gitdir, recurse=True)
         if os.path.exists(ud.clonedir):
-            bb.process.run('chmod u+w -R "%s"' % ud.clonedir)
+            bb.process.run(['chmod', 'u+w', '-R', ud.clonedir])
             bb.utils.remove(ud.clonedir, recurse=True)
             bb.utils.remove(ud.clonedir.replace('gitsource', 'gitsubmodule'), recurse=True)
 
@@ -2086,13 +2086,13 @@ class GitShallowTest(FetcherTest):
             open(os.path.join(self.srcdir, 'c'), 'w').close()
             self.git(['annex', 'add', 'c'], cwd=self.srcdir)
             self.git(['commit', '--author', '"Foo Bar <foo@bar>"', '-m', 'annex-c', '-a'], cwd=self.srcdir)
-            bb.process.run('chmod u+w -R %s' % self.srcdir)
+            bb.process.run(['chmod', 'u+w', '-R', self.srcdir])
 
             uri = 'gitannex://%s;protocol=file;subdir=${S};branch=master' % self.srcdir
             fetcher, ud = self.fetch_shallow(uri)
 
             self.assertRevCount(1)
-            assert './.git/annex/' in bb.process.run('tar -tzf %s' % os.path.join(self.dldir, ud.mirrortarballs[0]))[0]
+            assert './.git/annex/' in bb.process.run(['tar', '-tzf', os.path.join(self.dldir, ud.mirrortarballs[0])])[0]
             assert os.path.exists(os.path.join(self.gitdir, 'c'))
 
     def test_shallow_clone_preferred_over_shallow(self):
@@ -3492,7 +3492,7 @@ class FetchPremirroronlyLocalTest(FetcherTest):
         self.git_init(cwd=self.gitdir)
         for i in range(0):
             self.git_new_commit()
-        bb.process.run('tar -czvf {} .'.format(os.path.join(self.mirrordir, self.mirrorname)), cwd =  self.gitdir)
+        bb.process.run(['tar', '-czvf', os.path.join(self.mirrordir, self.mirrorname), '.'], cwd=self.gitdir)
 
     def git_new_commit(self):
         import random
@@ -3502,7 +3502,7 @@ class FetchPremirroronlyLocalTest(FetcherTest):
             testfile.write("File {} from branch {}; Useless random data {}".format(self.testfilename, branch, random.random()))
         self.git(['add', self.testfilename], self.gitdir)
         self.git(['commit', '-a', '-m', "\"This random commit {} in branch {}. I'm useless.\"".format(random.random(), branch)], self.gitdir)
-        bb.process.run('tar -czvf {} .'.format(os.path.join(self.mirrordir, self.mirrorname)), cwd =  self.gitdir)
+        bb.process.run(['tar', '-czvf', os.path.join(self.mirrordir, self.mirrorname), '.'], cwd=self.gitdir)
         return self.git(["rev-parse", "HEAD"], self.gitdir).strip()
 
     def git_new_branch(self, name):
@@ -3572,7 +3572,7 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
         os.makedirs(self.clonedir)
         self.git(["clone", "--bare", self.giturl], self.clonedir)
         self.git(["update-ref", "HEAD", "15413486df1f5a5b5af699b6f3ba5f0984e52a9f"], self.gitdir)
-        bb.process.run('tar -czvf {} .'.format(os.path.join(self.mirrordir, self.mirrorname)), cwd =  self.gitdir)
+        bb.process.run(['tar', '-czvf', os.path.join(self.mirrordir, self.mirrorname), '.'], cwd=self.gitdir)
         shutil.rmtree(self.clonedir)
 
     @skipIfNoNetwork()
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index ad829c7ab65..57d5752b0ed 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -92,7 +92,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
 
     def runbbsetup(self, cmd):
         bbsetup = os.path.abspath(os.path.dirname(__file__) +  "/../../../bin/bitbake-setup")
-        return bb.process.run("{} --global-settings {} {}".format(bbsetup, os.path.join(self.tempdir, 'global-config'), cmd))
+        return bb.process.run([bbsetup, '--global-settings', os.path.join(self.tempdir, 'global-config')] + cmd)
 
 
     def _add_json_config_to_registry_helper(self, name, sources):
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index b04ff6ffc76..f03c950af5a 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -2293,5 +2293,5 @@ def is_path_on_nfs(path):
             path = os.path.dirname(path)
 
     import bb.process
-    fstype = bb.process.run("stat -f -c %T {}".format(path))[0].strip()
+    fstype = bb.process.run(['stat', '-f', '-c', '%T', path])[0].strip()
     return fstype == "nfs"

