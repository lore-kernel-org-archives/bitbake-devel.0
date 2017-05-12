Return-Path: <kergoth@gmail.com>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
	by mail.openembedded.org (Postfix) with ESMTP id 9933877D4F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 21:47:00 +0000 (UTC)
Received: by mail-pg0-f66.google.com with SMTP id i63so8984051pgd.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 14:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=mb4xf6DNIru7OxWWEp+fHoEDbajKmZ6ufI64yvJum9E=;
	b=FqeEfNiJUspSLezh9Y17twKkOPCvwslGpA0ShXUBXBtUAQw6Dh+5ox2suF7STftusi
	wBA1sMiX4nJh5AxCHiwFezaK7JVuksndIKwMVdgZedLAOd7KCaYMJUw4cVyWYpWEZMW1
	q0irEtZxJDujeeCkJgQnYZTlI5ocl8XzOgXnN/iDVPKeyiW2bav9sDukfIbnSSFq1rOQ
	LMLVf8g5mV9qHpHsqTdr5Q/u50tk/vsIU1tXq8K/0+4G63m2KzIJnofU3zVgzTOKoy9T
	q1oTMFbjaDYKzHMEIHplZqXUvHRpwER6+V4Bc5Xg5xKRtFT8uqpoUwINb9r4p5iLXaI2
	/XHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=mb4xf6DNIru7OxWWEp+fHoEDbajKmZ6ufI64yvJum9E=;
	b=PazBVKWK1ZTDT0SloN94UJUUHMMlMnMHH7Ph/tbMiST2h0wYjmPxobc33IJDao00+S
	GPqs/1cHa3heY0fGbaoLk6ZJeHyjPKH/dXdODAcmJT70KUxzGdxH/xyl/3ZA9dNCrRs1
	02mSsOFMyGE7jQU4gKWOgcK9YuiZqF7BISjfJuemf6eFVxyb3NdSgwNHoiP/2dJVvTzp
	MrUA6Y6feiD9HSl0iv9+Kg5zBcYKWI8+vzEw/GqEUVFeRowba74BpD3w2MPedzDUkgnT
	9BmsbfeYzYhisGghw1p4fT68fVpHgUq5cHl5OrGWpMlI/NJGg/iNlmDve8nrKTsl4d5C
	vEPw==
X-Gm-Message-State: AODbwcA8QNKf34RG3JYJR/LA/7SQ0mEs6HAuP5+4p21FKRMMsswp3R61
	w4j4mVu8nEsr1HPO7RQ=
X-Received: by 10.98.155.154 with SMTP id e26mr6848155pfk.24.1494625621657;
	Fri, 12 May 2017 14:47:01 -0700 (PDT)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id
	v63sm1244051pfi.133.2017.05.12.14.46.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 12 May 2017 14:47:00 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 13 May 2017 02:46:32 +0500
Message-Id: <d36af5c91ca168179a050a7a23cdcaf87130417f.1494623828.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <cover.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
In-Reply-To: <cover.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 7/8] fetch/gitannex: add support for shallow mirror tarballs
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
X-List-Received-Date: Fri, 12 May 2017 21:47:00 -0000

When we're building from a shallow mirror tarball, we don't want to do
anything with ud.clonedir, as it's not being used when we unpack. As such,
disable updating annex in that case. Also include annex files in the shallow
tarball.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/gitannex.py | 23 ++++++++++++++++++++---
 lib/bb/tests/fetch.py     | 17 +++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/gitannex.py b/lib/bb/fetch2/gitannex.py
index c66c2114..a9b69caa 100644
--- a/lib/bb/fetch2/gitannex.py
+++ b/lib/bb/fetch2/gitannex.py
@@ -33,6 +33,11 @@ class GitANNEX(Git):
         """
         return ud.type in ['gitannex']
 
+    def urldata_init(self, ud, d):
+        super(GitANNEX, self).urldata_init(ud, d)
+        if ud.shallow:
+            ud.shallow_extra_refs += ['refs/heads/git-annex', 'refs/heads/synced/*']
+
     def uses_annex(self, ud, d, wd):
         for name in ud.names:
             try:
@@ -55,9 +60,21 @@ class GitANNEX(Git):
     def download(self, ud, d):
         Git.download(self, ud, d)
 
-        annex = self.uses_annex(ud, d, ud.clonedir)
-        if annex:
-            self.update_annex(ud, d, ud.clonedir)
+        if not ud.shallow or ud.localpath != ud.fullshallow:
+            if self.uses_annex(ud, d, ud.clonedir):
+                self.update_annex(ud, d, ud.clonedir)
+
+    def clone_shallow_local(self, ud, dest, d):
+        super(GitANNEX, self).clone_shallow_local(ud, dest, d)
+
+        try:
+            runfetchcmd("%s annex init" % ud.basecmd, d, workdir=dest)
+        except bb.fetch.FetchError:
+            pass
+
+        if self.uses_annex(ud, d, dest):
+            runfetchcmd("%s annex get" % ud.basecmd, d, workdir=dest)
+            runfetchcmd("chmod u+w -R %s/.git/annex" % (dest), d, quiet=True, workdir=dest)
 
     def unpack(self, ud, destdir, d):
         Git.unpack(self, ud, destdir, d)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 2a9019b0..73f7b3f7 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1234,6 +1234,23 @@ class GitShallowTest(FetcherTest):
         assert './.git/modules/' in bb.process.run('tar -tzf %s' % os.path.join(self.dldir, ud.mirrortarballs[0]))[0]
         assert os.listdir(os.path.join(self.gitdir, 'gitsubmodule'))
 
+    if any(os.path.exists(os.path.join(p, 'git-annex')) for p in os.environ.get('PATH').split(':')):
+        def test_shallow_annex(self):
+            self.add_empty_file('a')
+            self.add_empty_file('b')
+            self.git('annex init', cwd=self.srcdir)
+            open(os.path.join(self.srcdir, 'c'), 'w').close()
+            self.git('annex add c', cwd=self.srcdir)
+            self.git('commit -m annex-c -a', cwd=self.srcdir)
+            bb.process.run('chmod u+w -R %s' % os.path.join(self.srcdir, '.git', 'annex'))
+
+            uri = 'gitannex://%s;protocol=file;subdir=${S}' % self.srcdir
+            fetcher, ud = self.fetch_shallow(uri)
+
+            self.assertRevCount(1)
+            assert './.git/annex/' in bb.process.run('tar -tzf %s' % os.path.join(self.dldir, ud.mirrortarballs[0]))[0]
+            assert os.path.exists(os.path.join(self.gitdir, 'c'))
+
     def test_shallow_multi_one_uri(self):
         # Create initial git repo
         self.add_empty_file('a')
-- 
2.11.1


