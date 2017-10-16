Return-Path: <freesilicon@gmail.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail.openembedded.org (Postfix) with ESMTP id 99883780C8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Oct 2017 21:48:58 +0000 (UTC)
Received: by mail-wm0-f65.google.com with SMTP id f4so118929wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Oct 2017 14:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=WQrAvoB5laNyuQQPQ1Lwss84dYd2M5SnJwG4txw5LE4=;
	b=MCNDA8j2X/W8OpeHk6D6yQG8vINTHLptqLmOIiBRaCxVNkzaQjVva73f7dw+Wlu/FL
	XLVyhIaDGGtOirJIt8IGNaw3q8CjC9H68KJOqbuMQ9PNn29YhNw7z9U5Sd6vbJXL9vb4
	CTs/qnzhUwI84VHZ3eobEIRfECw0MaeNyffes/Qevy8g8cdiGiqpsUhpxFk8RZf+VBSm
	Bf8TnZgf4QUx5DlCtOBJ1ACsy1vvzPtcAASW101nD6iLxLcBlo9becLbPFliLi8Z9iAn
	NZGOP2ZsQheKTw96cUzpZHayheANpLnXyV/mvuE2NCCP+GKBkGvOCqZpxd8edYjSoCxi
	Tl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=WQrAvoB5laNyuQQPQ1Lwss84dYd2M5SnJwG4txw5LE4=;
	b=OpYMLukhOsODeVlf1XPqjViSmfKJZYxfnfn8IDwZCFb9EjjYQ+TuAyTat6PyDTEmdD
	Uxf12SuSBUdE4czWwfXuEyVfff8tFfkdkeXPKTglsSm64q1QSPpQN1CL01MYf+gWERXf
	wyxW42rwWZRHspkVAn8iv2V6ZVCecfFOL+datigQl4l4mS7Q4HdmrYJwZTLRUdzEKICK
	FnsLBeFKvu6NSPq72kYwB0HTntfdwn8pqpxxzIYxr+4aokeM6t/7EmzZXTmqyY8mzJcL
	2j9YqshfK757+Z/2ZobsPtb+aPxZV/0opTyac1jr0QzG/kZ5Xdvec88QKPwi1F3q1oSA
	komw==
X-Gm-Message-State: AMCzsaVk3dtbgPrBCC+C77dBAeRVX2BHu4jU9ZQW8bcNn/wuFm2jEx8j
	JiQX3bqePs9ax22TijMc3Nco0SEj
X-Google-Smtp-Source: ABhQp+T6XZsO88Y0OGJxtAaPWSNUW7K7S18o+JpK2JaOi1DPo0H4Sn6WDe/R+mq3QCp/AgUfBJay3A==
X-Received: by 10.28.185.75 with SMTP id j72mr2013355wmf.138.1508190538960;
	Mon, 16 Oct 2017 14:48:58 -0700 (PDT)
Received: from crde-port-20.cahors.local ([37.172.87.59])
	by smtp.gmail.com with ESMTPSA id r134sm61916wmf.3.2017.10.16.14.48.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 16 Oct 2017 14:48:58 -0700 (PDT)
From: David Vincent <freesilicon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Oct 2017 23:48:03 +0200
Message-Id: <20171016214803.20047-1-freesilicon@gmail.com>
X-Mailer: git-send-email 2.14.2
X-Mailman-Approved-At: Fri, 27 Oct 2017 14:42:08 +0000
Subject: [PATCH] fetch/git: fix per-branch unpacking
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
X-List-Received-Date: Mon, 16 Oct 2017 21:48:58 -0000

Create branches for each user-supplied name when running checkout and
set start point of branch to the resolved revision.

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


