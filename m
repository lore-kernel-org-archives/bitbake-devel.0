Return-Path: <freesilicon@gmail.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail.openembedded.org (Postfix) with ESMTP id 8D19C782C0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Oct 2017 15:43:56 +0000 (UTC)
Received: by mail-wm0-f66.google.com with SMTP id u138so4754632wmu.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Oct 2017 08:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ZELrbF5HRAg/KjyXYDdIONf6SC6fNtl7yci5AK1CD0M=;
	b=cGK1f16Q+cdrSBIznGLfLgLxutxbB3Vy8wUpU/pjJSebOU1AY/qIhKnoyWVffzzkIE
	HrVYsXgC5vnC/injUJ8YT2Q0eewW77O9fl/akTyU3kR/7OsibvR+aomtbeLgf7gqkIWZ
	TFODdGpF7sHUIC5y/9+XpphwtU4wB+A0EvXBv2dk9MPto8ZG8iOizxFe48L+YpwPY79w
	YyAnS8N5vxK2uCHPaBjSYyzn5DZm70gn1bLAq0Dxy/xJiIfD7fGaD/Rne0Jz01Od8CGW
	MKtYReTzAKDedDNqoDjWMcGlxDf4mqWV010sjvoVBRvaSpG5g5fb0bZPvPw5SjhIWdvd
	sDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ZELrbF5HRAg/KjyXYDdIONf6SC6fNtl7yci5AK1CD0M=;
	b=Vm48Bymk/nYEd1cywgzYWRmwhRrm5rw1x/30vX0XuYJBKYEmuS5vqKgz19Mim8J6++
	jhnLtCP4jjvJrcDJCmnZlo1RPeW0RTjvadSCOCU8iA8B4HAWX2vtBvKkRnhkr57hJ8ZT
	DTnubG5c4dY9FmR0eIlPe8ooC5ZnCIFan9hn0U6fYD8qWFa0P5+hFZU7MOB6m8e1IRRB
	imqmO5Ch2ZbhAaLGSY7Dlp4kFgpvUFfWzeOffWc22xNuhWqJnWEFosJChVHQuXSosNwX
	AVOqq9gpA0ZUBaiPfdI+pN2Vtmg9n0VHxYieSGqNTONJ0zIdIxE/b0bvPIkWFX0QqW/k
	kLVQ==
X-Gm-Message-State: AMCzsaW5t9RrmbcX88EN+vBGNYitXFwH4tv5RRly8dEtR2UOOjQxhR0e
	Ph2OUO04ljjJttJhMFnTcuM2tFw6
X-Google-Smtp-Source: ABhQp+SHIwi7pPDh2Pafe+pRTcpefFIQj+nDqJYKcT6PTdIz9eJaeOypdR6uu3TcZs/5xENgcN4GKA==
X-Received: by 10.28.34.3 with SMTP id i3mr4286757wmi.94.1508255037022;
	Tue, 17 Oct 2017 08:43:57 -0700 (PDT)
Received: from crde-port-20.cahors.local ([185.47.80.46])
	by smtp.gmail.com with ESMTPSA id
	y129sm9932991wmg.42.2017.10.17.08.43.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 17 Oct 2017 08:43:56 -0700 (PDT)
From: David Vincent <freesilicon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Oct 2017 17:43:15 +0200
Message-Id: <20171017154316.18464-2-freesilicon@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171017154316.18464-1-freesilicon@gmail.com>
References: <20171017112748.10968-1-freesilicon@gmail.com>
	<20171017154316.18464-1-freesilicon@gmail.com>
Subject: [PATCH v2 1/2] fetch/git: fix per-branch unpacking
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
X-List-Received-Date: Tue, 17 Oct 2017 15:43:56 -0000

Create branches for each user-supplied name when running checkout and
set start point of branch to the resolved revision.

This fixes the following scenario:
When working with a Yocto Linux kernel, it may be required to merge
feature branches in a machine branch (using scc 'merge' functionality).
The current code checks out the machine branch correctly but feature
branches are checked out to the tip of their remote counterpart not to
the provided SRCREV. This is due to the fact that git fetcher does not
provide the same behavior for all branches and only handles the first
one.

Signed-off-by: David Vincent <freesilicon@gmail.com>
---
 lib/bb/fetch2/git.py  | 12 +++++++-----
 lib/bb/tests/fetch.py | 27 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 5ef8cd69..e71551ff 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -482,11 +482,13 @@ class Git(FetchMethod):
                             workdir=destdir)
                 runfetchcmd("%s checkout-index -q -f -a" % ud.basecmd, d, workdir=destdir)
             elif not ud.nobranch:
-                branchname =  ud.branches[ud.names[0]]
-                runfetchcmd("%s checkout -B %s %s" % (ud.basecmd, branchname, \
-                            ud.revisions[ud.names[0]]), d, workdir=destdir)
-                runfetchcmd("%s branch %s --set-upstream-to origin/%s" % (ud.basecmd, branchname, \
-                            branchname), d, workdir=destdir)
+                for idx, name in enumerate(ud.names):
+                    checkoutcmd = 'checkout -B' if not idx else 'branch -f'
+                    branchname =  ud.branches[name]
+                    runfetchcmd("%s %s %s %s" % (ud.basecmd, checkoutcmd, branchname, \
+                                ud.revisions[name]), d, workdir=destdir)
+                    runfetchcmd("%s branch %s --set-upstream-to origin/%s" % (ud.basecmd, branchname, \
+                                branchname), d, workdir=destdir)
             else:
                 runfetchcmd("%s checkout %s" % (ud.basecmd, ud.revisions[ud.names[0]]), d, workdir=destdir)
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 209b13f6..217cd88b 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -647,6 +647,33 @@ class FetcherNetworkTest(FetcherTest):
             self.d.setVar("PREMIRRORS", "%s git://%s;protocol=file \n" % (dummyurl, self.sourcedir))
             self.gitfetcher(dummyurl, dummyurl)
 
+        def test_gitfetch_multi_one_uri(self):
+            rev = "be393f247a08c0a4a50a6a76b8fd57f78295d2a1"
+            rev1 = "85596c9af3bb6407159c6c8de229cbe275aa74ea"
+            rev2 = "28249c42701f9156a0b3153d72d7e46dacab37cb"
+            self.d.setVar("SRCREV_rev1", rev1)
+            self.d.setVar("SRCREV_rev2", rev2)
+            url = "git://git.openembedded.org/bitbake;name=rev1,rev2;branch=1.34,1.36"
+            fetcher = bb.fetch.Fetch([url], self.d);
+            fetcher.download()
+            fetcher.unpack(self.unpackdir)
+            stdout = bb.process.run("git rev-parse master",
+                                    cwd=os.path.join(self.unpackdir, "git"))
+            unpack_rev = stdout[0].strip()
+            self.assertEqual(unpack_rev, rev);
+            stdout = bb.process.run("git rev-parse HEAD",
+                                    cwd=os.path.join(self.unpackdir, "git"))
+            unpack_rev = stdout[0].strip()
+            self.assertEqual(unpack_rev, rev1);
+            stdout = bb.process.run("git rev-parse 1.34",
+                                    cwd=os.path.join(self.unpackdir, "git"))
+            unpack_rev = stdout[0].strip()
+            self.assertEqual(unpack_rev, rev1);
+            stdout = bb.process.run("git rev-parse 1.36",
+                                    cwd=os.path.join(self.unpackdir, "git"))
+            unpack_rev = stdout[0].strip()
+            self.assertEqual(unpack_rev, rev2);
+
         def test_git_submodule(self):
             fetcher = bb.fetch.Fetch(["gitsm://git.yoctoproject.org/git-submodule-test;rev=f12e57f2edf0aa534cf1616fa983d165a92b0842"], self.d)
             fetcher.download()
-- 
2.14.2


