Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web11.32194.1620656200536472940
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 May 2021 07:16:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=Rqr3YFwz;
 spf=softfail (domain: sakoman.com, ip: 209.85.167.181, mailfrom: steve@sakoman.com)
Received: by mail-oi1-f181.google.com with SMTP id l6so15945565oii.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 May 2021 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6rRsUzvw3peXD2zWq2wGgk67Vu6ip+y3VBhOC5cEsHA=;
        b=Rqr3YFwzd9IJU9TzEt+Uu68qZNa3bN8v6Uz7w6R5/wYTieDQFpl5+sCJkYtKv7sucM
         H8Hx2FZs0HMR5GPUKZtLwFwL0sVH5QmfFghUSv5shLGuh8MJb3ivwuhWEHIMTqxt2Zzc
         AFidt6YtY/XV69j9ShlpZxVFYOykgItzJFW6htD0pRiEZxOUj572wj9vGu/fRur3jPtD
         AdP8SS0juSzBbdY3JzXo1iGDXkUEnTPYwprJj7yuDK8Dx7eVFcdQPGX9jf7wBD73VlGi
         dDpohJWtReJEo77dADW1lfEeKbUdvoBZJNnzgBR0umxh2XVU/X/b7uXsqQG8PthCb36h
         FC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6rRsUzvw3peXD2zWq2wGgk67Vu6ip+y3VBhOC5cEsHA=;
        b=eF92o3CzKUSCuym12yyvfyg6JZ7GWMW9U9vaQlXYlvMp0QBrSyafcbBUNejzZvwQXF
         y5AD90fKjEykyBPl9hO60Ed4ESF16pNhrruqdkBnDaAKos93ybhqvUe3SJZ+ovEhBaRz
         IZNs2xeN4HxHj6pHbSo866AuNbtz7M5OaJNrbAtJK+NK/8zg7WhGldg5APptN1p5lju0
         p8vMuyFaa/6VZPgNKaigFItiJX3CDVMtUVjVy+SaVGOOBh8B/71RLCbez4xCdmYMuq2a
         h9sZccqs/s7+t9BHHCql/V+LKT0UIrEQqlk/cErU8t0zaSlPXnZb+KtJpCQJgOeT86xb
         72Ng==
X-Gm-Message-State: AOAM532p+cFYRddX6OxnEGhGUSCnO/9eKebkFan3wg3eJQDSfdI8xf62
	2lo0XmkvBfwSGlQ+LIwml/LKYrDusbOjqH9cqLg=
X-Google-Smtp-Source: ABdhPJygP9036hD7iZ0mTMubiHow0cx/c1dyKEaKYdLIpeHyYNrXnmSvsaKFG0S4MA4sKlo2lwQxMA==
X-Received: by 2002:a05:6808:8d:: with SMTP id s13mr18783380oic.170.1620656199277;
        Mon, 10 May 2021 07:16:39 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain ([172.243.4.16])
        by smtp.gmail.com with ESMTPSA id g106sm2401303otg.77.2021.05.10.07.16.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:16:38 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/4] bitbake: tests/fetch: fix test execution without .gitconfig
Date: Mon, 10 May 2021 04:15:16 -1000
Message-Id: <8b23e8eecca15965b3fccf0a182143c9c6792658.1620655927.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620655927.git.steve@sakoman.com>
References: <cover.1620655927.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikko Rapeli <mikko.rapeli@bmw.de>

A CI user validating changes does not have any git push rights or
even a .gitconfig file so fix tests so that they run
by setting the user.name and user.email for the repo before
committing changes.

Fixes errors like:

ERROR: test_that_unpack_throws_an_error_when_the_git_clone_nor_shallow_tarball_exist (bb.tests.fetch.GitShallowTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/builder/src/base/poky/bitbake/lib/bb/tests/fetch.py", line 2055, in test_that_unpack_throws_an_error_when_the_git_clone_no
r_shallow_tarball_exist
    self.add_empty_file('a')
  File "/home/builder/src/base/poky/bitbake/lib/bb/tests/fetch.py", line 1562, in add_empty_file
    self.git(['commit', '-m', msg, path], cwd)
  File "/home/builder/src/base/poky/bitbake/lib/bb/tests/fetch.py", line 1553, in git
    return bb.process.run(cmd, cwd=cwd)[0]
  File "/home/builder/src/base/poky/bitbake/lib/bb/process.py", line 184, in run
    raise ExecutionError(cmd, pipe.returncode, stdout, stderr)
bb.process.ExecutionError: Execution of 'git commit -m a a' failed with exit code 128:

*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 9453c90d..9a4f5f11 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -845,6 +845,8 @@ class FetcherNetworkTest(FetcherTest):
                                    prefix='gitfetch_localusehead_')
         src_dir = os.path.abspath(src_dir)
         bb.process.run("git init", cwd=src_dir)
+        bb.process.run("git config user.email 'you@example.com'", cwd=src_dir)
+        bb.process.run("git config user.name 'Your Name'", cwd=src_dir)
         bb.process.run("git commit --allow-empty -m'Dummy commit'",
                        cwd=src_dir)
         # Use other branch than master
@@ -1328,6 +1330,8 @@ class GitMakeShallowTest(FetcherTest):
         self.gitdir = os.path.join(self.tempdir, 'gitshallow')
         bb.utils.mkdirhier(self.gitdir)
         bb.process.run('git init', cwd=self.gitdir)
+        bb.process.run('git config user.email "you@example.com"', cwd=self.gitdir)
+        bb.process.run('git config user.name "Your Name"', cwd=self.gitdir)
 
     def assertRefs(self, expected_refs):
         actual_refs = self.git(['for-each-ref', '--format=%(refname)']).splitlines()
@@ -1451,6 +1455,8 @@ class GitShallowTest(FetcherTest):
 
         bb.utils.mkdirhier(self.srcdir)
         self.git('init', cwd=self.srcdir)
+        self.git('config user.email "you@example.com"', cwd=self.srcdir)
+        self.git('config user.name "Your Name"', cwd=self.srcdir)
         self.d.setVar('WORKDIR', self.tempdir)
         self.d.setVar('S', self.gitdir)
         self.d.delVar('PREMIRRORS')
@@ -1684,6 +1690,8 @@ class GitShallowTest(FetcherTest):
         smdir = os.path.join(self.tempdir, 'gitsubmodule')
         bb.utils.mkdirhier(smdir)
         self.git('init', cwd=smdir)
+        self.git('config user.email "you@example.com"', cwd=smdir)
+        self.git('config user.name "Your Name"', cwd=smdir)
         # Make this look like it was cloned from a remote...
         self.git('config --add remote.origin.url "%s"' % smdir, cwd=smdir)
         self.git('config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"', cwd=smdir)
@@ -1714,6 +1722,8 @@ class GitShallowTest(FetcherTest):
         smdir = os.path.join(self.tempdir, 'gitsubmodule')
         bb.utils.mkdirhier(smdir)
         self.git('init', cwd=smdir)
+        self.git('config user.email "you@example.com"', cwd=smdir)
+        self.git('config user.name "Your Name"', cwd=smdir)
         # Make this look like it was cloned from a remote...
         self.git('config --add remote.origin.url "%s"' % smdir, cwd=smdir)
         self.git('config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"', cwd=smdir)
@@ -1756,7 +1766,7 @@ class GitShallowTest(FetcherTest):
             self.git('annex init', cwd=self.srcdir)
             open(os.path.join(self.srcdir, 'c'), 'w').close()
             self.git('annex add c', cwd=self.srcdir)
-            self.git('commit -m annex-c -a', cwd=self.srcdir)
+            self.git('commit --author "Foo Bar <foo@bar>" -m annex-c -a', cwd=self.srcdir)
             bb.process.run('chmod u+w -R %s' % os.path.join(self.srcdir, '.git', 'annex'))
 
             uri = 'gitannex://%s;protocol=file;subdir=${S}' % self.srcdir
@@ -2032,6 +2042,8 @@ class GitLfsTest(FetcherTest):
 
         bb.utils.mkdirhier(self.srcdir)
         self.git('init', cwd=self.srcdir)
+        self.git('config user.email "you@example.com"', cwd=self.srcdir)
+        self.git('config user.name "Your Name"', cwd=self.srcdir)
         with open(os.path.join(self.srcdir, '.gitattributes'), 'wt') as attrs:
             attrs.write('*.mp3 filter=lfs -text')
         self.git(['add', '.gitattributes'], cwd=self.srcdir)
-- 
2.25.1

