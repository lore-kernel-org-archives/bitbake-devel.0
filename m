Return-Path: <nathan@nathanrossi.com>
Received: from mail-pl0-f65.google.com (mail-pl0-f65.google.com
	[209.85.160.65])
	by mail.openembedded.org (Postfix) with ESMTP id 374BE78816
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Feb 2018 14:04:36 +0000 (UTC)
Received: by mail-pl0-f65.google.com with SMTP id j19so6262428pll.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Feb 2018 06:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=nathanrossi.com; s=google;
	h=date:message-id:from:to:cc:subject:mime-version
	:content-transfer-encoding;
	bh=86MLOWc9sA5aUkqCOC/eiZ+ykN4EyJ0kNpJe+U3FQFs=;
	b=a2E0UIgvo950I5fQTr7EeFqmuGdnBu/fkVbHEA/iE477YfWsfbAht8Hc0W2L164q/Z
	WCAfkhCxRZSNrlV5eg8nCZa+jlF1wVKsmcNp1mYcZFGV7xX+UwvWIMGTWC2+NftxWDCu
	Qzb+LbJjej1Y6Ez5KcMltgzqQTz+vv7y+fNSVmbVneJW4mxzVUKbqSXQjhAzUDGsww1X
	Ysk8OvLH/g1Q2XVKhVasodppZO1bqxKlCmL2d2jA49fqV1KmgsWs+SNxKkUfmpNkSiN2
	R2IK9qvmBr00tixxRysp/UO4YYhCPwCv2vnHhCiUxzRDV9q20fTtIMCQLtwfV4xZfin6
	xX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:message-id:from:to:cc:subject:mime-version
	:content-transfer-encoding;
	bh=86MLOWc9sA5aUkqCOC/eiZ+ykN4EyJ0kNpJe+U3FQFs=;
	b=JHYD7R0ikmsxrfE8xhl1Gh5/XnUfBC03wi/4SCDw8pVVu3WGRKTmF+PEDylXUYF6O7
	f7xBhpwLG+t87d9OA/Jz1rjjSaVuOU0aPBhMF7U+1T3XyhD+TU7xEPI91M+V7ZKI2J+5
	60SKyF9Xcw4Oe8iy+q1wNXtrWNO3mJN+R2vPnzvZ0Oh5poIRCk/gTWcKPtjsU/CP37zD
	/y+djMH67/JIry5Ph//KQIl7nu/rcP6umvv2vN6MGKEhi160n+hdEERkh2vDcXwM4chb
	wXY+xKvk1nLeV0RNqG4bfpVGOCBgPmrRNPbtP7xq3R4S/LSNxHhSBHyXtDy9tLVSdieb
	Pl3A==
X-Gm-Message-State: AKwxyteVhCBeXT2K1hJa6jYeRwVMzjhiGtymEhAW4Xh0NfgfcnjZ+Bfx
	N7gRyuZVvwsKdamAplEem/wCKn+VuaQ=
X-Google-Smtp-Source: AH8x224YG0+ykJvna9ueVlM6jpMUDcQRSDLKDI0Hh1jN3WiAMiT/gXWiBDdqh7HnqlrYj14EBvFN8g==
X-Received: by 2002:a17:902:6e88:: with SMTP id
	v8-v6mr35614632plk.374.1517580278255; 
	Fri, 02 Feb 2018 06:04:38 -0800 (PST)
Received: from [127.0.1.1] (CPE-101-163-12-83.lnse6.cha.bigpond.net.au.
	[101.163.12.83]) by smtp.gmail.com with ESMTPSA id
	65sm4570070pfm.152.2018.02.02.06.04.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 02 Feb 2018 06:04:37 -0800 (PST)
Date: Sat, 03 Feb 2018 00:04:30 +1000
Message-Id: <20180202140430.3503-1-nathan@nathanrossi.com>
From: Nathan Rossi <nathan@nathanrossi.com>
To: bitbake-devel@lists.openembedded.org
MIME-Version: 1.0
Subject: [PATCH] fetch/git: Use 'git-make-shallow' from bin directory
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
X-List-Received-Date: Fri, 02 Feb 2018 14:04:37 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Move the code that existed in tests/fetch.py for determining the path to
'git-make-shallow' into the git module and reference it.

This ensures that 'git-make-shallow' is always available and the desired
version regardless of the path variable or whether git exposes the
command.

Signed-off-by: Nathan Rossi <nathan@nathanrossi.com>
---
 lib/bb/fetch2/git.py  | 5 ++++-
 lib/bb/tests/fetch.py | 5 +----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index d34ea1de29..35e0db56cf 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -125,6 +125,9 @@ class GitProgressHandler(bb.progress.LineFilterProgressHandler):
 
 
 class Git(FetchMethod):
+    bitbake_dir = os.path.abspath(os.path.join(os.path.dirname(os.path.join(os.path.abspath(__file__))), '..', '..', '..'))
+    make_shallow_path = os.path.join(bitbake_dir, 'bin', 'git-make-shallow')
+
     """Class to fetch a module or modules from git repositories"""
     def init(self, d):
         pass
@@ -446,7 +449,7 @@ class Git(FetchMethod):
                 shallow_branches.append(r)
 
         # Make the repository shallow
-        shallow_cmd = ['git', 'make-shallow', '-s']
+        shallow_cmd = [self.make_shallow_path, '-s']
         for b in shallow_branches:
             shallow_cmd.append('-r')
             shallow_cmd.append(b)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 7051a54b42..d711c77d35 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -978,9 +978,6 @@ class FetchCheckStatusTest(FetcherTest):
 
 
 class GitMakeShallowTest(FetcherTest):
-    bitbake_dir = os.path.join(os.path.dirname(os.path.join(os.path.abspath(__file__))), '..', '..', '..')
-    make_shallow_path = os.path.join(bitbake_dir, 'bin', 'git-make-shallow')
-
     def setUp(self):
         FetcherTest.setUp(self)
         self.gitdir = os.path.join(self.tempdir, 'gitshallow')
@@ -1009,7 +1006,7 @@ class GitMakeShallowTest(FetcherTest):
     def make_shallow(self, args=None):
         if args is None:
             args = ['HEAD']
-        return bb.process.run([self.make_shallow_path] + args, cwd=self.gitdir)
+        return bb.process.run([bb.fetch2.git.Git.make_shallow_path] + args, cwd=self.gitdir)
 
     def add_empty_file(self, path, msg=None):
         if msg is None:
-- 
2.15.1


