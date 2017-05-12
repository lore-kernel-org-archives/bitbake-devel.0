Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196])
	by mail.openembedded.org (Postfix) with ESMTP id CC50177D43
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 21:46:57 +0000 (UTC)
Received: by mail-pf0-f196.google.com with SMTP id n23so7195190pfb.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 14:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=Uu0YQzHqAfOHNfBjQR046mB3T5PnlO7n6u2aN8c8eEg=;
	b=b9zGZPx5GnUB23+BCeMEo+IPMPn5+eCj/2Lq2hXY0zP5Z3rGkpSMV3aPVECc3P+5UT
	JA27OUWb0xMjJZ8MaqB3iWK+yB1KcNs0URGMwY/0Hz0AdIRm6n7vIWzpajp4cQaP6rPc
	Z8kHOGUu8LVTF+fvhTY+lvpFwZIbYPJNL/w1/z9XIZze09NDcYdZhsyDxoCqD35vw3t5
	CH2NsCzo6hUrVMJkDiXtuul9C9W9vHced6/hozXBJq6K3MCGzalTQqAn/375feAlHrwm
	00ql4+R2Fn/UNeSBLzY0kWuaplHAVQib7bG+OsUdYKAZMJSIfXjtxErqVC3ZjyxrUR0U
	jSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Uu0YQzHqAfOHNfBjQR046mB3T5PnlO7n6u2aN8c8eEg=;
	b=mjyRu13oOXm0xIddTTCjIlWl0H6J8HjT8zkLK8gRhENC8MVmAYcVAl0As/F60edPGn
	gyze+RcHb+XQtHqJMGmDRhz9TPjm4CoHyGuPmalEv1n56tNVmlJkqN7JbAgLDB0Zc9+J
	uKxcuC1HSBPwtebskIM5KwwNNEljQCaz08QaD56mTvTaBrbRzLWuYiRYL6B1UiphVoaY
	u1Tw+tEsadJbz/tfWeEOTmV9rW8xxUBCdwwBO4dkw2LNGEB2eHT1Mb9iLb0yYyGVxhYw
	lr1aQiebME1IwZiMnTApdrkVG+gMGUE1Qj8Ohf/NZxDrfcqTAqt5gNSoh32j/AfTFi9q
	R3bw==
X-Gm-Message-State: AODbwcBvTXmkKngt8rxvPzpeKs8l/FHxIgzUu/Xma3oqXN18SY9PVrbw
	hAcx+VVi14+PiIb39ik=
X-Received: by 10.99.151.9 with SMTP id n9mr6663164pge.199.1494625618894;
	Fri, 12 May 2017 14:46:58 -0700 (PDT)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id
	v63sm1244051pfi.133.2017.05.12.14.46.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 12 May 2017 14:46:57 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 13 May 2017 02:46:31 +0500
Message-Id: <9a674afd4d31b51fb8c7cddc40a8bfe55890095f.1494623828.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <cover.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
In-Reply-To: <cover.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 6/8] fetch/gitsm: add support for shallow mirror tarballs
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
X-List-Received-Date: Fri, 12 May 2017 21:46:58 -0000

When we're building from a shallow mirror tarball, we don't want to do
anything with ud.clonedir, as it's not being used when we unpack. As such,
disable updating the submodules in that case. Also include the repositories in
.git/modules in the shallow tarball. It does not actually make the submodule
repositories shallow at this time.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/gitsm.py | 17 +++++++++++------
 lib/bb/tests/fetch.py  | 31 +++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index a95584c8..0aff1008 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -117,14 +117,19 @@ class GitSM(Git):
     def download(self, ud, d):
         Git.download(self, ud, d)
 
-        submodules = self.uses_submodules(ud, d, ud.clonedir)
-        if submodules:
-            self.update_submodules(ud, d)
+        if not ud.shallow or ud.localpath != ud.fullshallow:
+            submodules = self.uses_submodules(ud, d, ud.clonedir)
+            if submodules:
+                self.update_submodules(ud, d)
+
+    def clone_shallow_local(self, ud, dest, d):
+        super(GitSM, self).clone_shallow_local(ud, dest, d)
+
+        runfetchcmd('cp -fpPRH "%s/modules" "%s/"' % (ud.clonedir, os.path.join(dest, '.git')), d)
 
     def unpack(self, ud, destdir, d):
         Git.unpack(self, ud, destdir, d)
-        
-        submodules = self.uses_submodules(ud, d, ud.destdir)
-        if submodules:
+
+        if self.uses_submodules(ud, d, ud.destdir):
             runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d, workdir=ud.destdir)
             runfetchcmd(ud.basecmd + " submodule update --init --recursive", d, workdir=ud.destdir)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 3e2ce530..2a9019b0 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1027,12 +1027,14 @@ class GitShallowTest(FetcherTest):
             cwd = self.gitdir
         return bb.process.run(cmd, cwd=cwd)[0]
 
-    def add_empty_file(self, path, msg=None):
+    def add_empty_file(self, path, cwd=None, msg=None):
         if msg is None:
             msg = path
-        open(os.path.join(self.srcdir, path), 'w').close()
-        self.git(['add', path], self.srcdir)
-        self.git(['commit', '-m', msg, path], self.srcdir)
+        if cwd is None:
+            cwd = self.srcdir
+        open(os.path.join(cwd, path), 'w').close()
+        self.git(['add', path], cwd)
+        self.git(['commit', '-m', msg, path], cwd)
 
     def fetch(self, uri=None):
         if uri is None:
@@ -1211,6 +1213,27 @@ class GitShallowTest(FetcherTest):
         self.assertRefs(['master', 'origin/master'])
         self.assertRevCount(1)
 
+    def test_shallow_submodules(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+
+        smdir = os.path.join(self.tempdir, 'gitsubmodule')
+        bb.utils.mkdirhier(smdir)
+        self.git('init', cwd=smdir)
+        self.add_empty_file('asub', cwd=smdir)
+
+        self.git('submodule init', cwd=self.srcdir)
+        self.git('submodule add file://%s' % smdir, cwd=self.srcdir)
+        self.git('submodule update', cwd=self.srcdir)
+        self.git('commit -m submodule -a', cwd=self.srcdir)
+
+        uri = 'gitsm://%s;protocol=file;subdir=${S}' % self.srcdir
+        fetcher, ud = self.fetch_shallow(uri)
+
+        self.assertRevCount(1)
+        assert './.git/modules/' in bb.process.run('tar -tzf %s' % os.path.join(self.dldir, ud.mirrortarballs[0]))[0]
+        assert os.listdir(os.path.join(self.gitdir, 'gitsubmodule'))
+
     def test_shallow_multi_one_uri(self):
         # Create initial git repo
         self.add_empty_file('a')
-- 
2.11.1


