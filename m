Return-Path: <freesilicon@gmail.com>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
	[209.85.128.194])
	by mail.openembedded.org (Postfix) with ESMTP id 9C6297016E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Oct 2017 11:28:16 +0000 (UTC)
Received: by mail-wr0-f194.google.com with SMTP id l24so1294379wre.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Oct 2017 04:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=WQrAvoB5laNyuQQPQ1Lwss84dYd2M5SnJwG4txw5LE4=;
	b=CJMgITC8xpnyaeFuPY8HCX57AXGgkpVDL3UaCK/pU2OgzznXJ0evblZcztzoTE+Fzf
	+daLhTRp5gNotTcSqvL8eqhvVwuoNjWiB38QCgYZT46lcTQOSsvz+X2+Dbi84gWXx6MS
	wTqg4qK6ahgGxOENeZN0zhk0WKKWCkYKOENjEc4d4wlXuvFCPLmlwequdnO6wVWPIfZl
	Q+FwctogQYz8LgNYZXsoVGNwdROHZLrzd4ByCnQeCSJ++zG3beLQlWj7KKeXcNR6wa4s
	RROtAEzoy+QuF/ogqv0t/p6wMlVxVliCGGG1s/mOlnitXhze0C46j2SjyJ+SuuVoBTLz
	wiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=WQrAvoB5laNyuQQPQ1Lwss84dYd2M5SnJwG4txw5LE4=;
	b=Pb0MoCtGkxtPHVHkswkizt6oIUjAKbJURG3V4NmiFybMXVwpA7jrS/5N423TdIQgr5
	gYtQLml3vOD4QljCNOS1/PRI3p4e/tesX9EBPJLJQjsE0wQF3LsuXbYiqkZQ78A+M7AF
	sRp8EQRYZqbRVaLVu5fJWnIJfvPd55KfhOyiKuvSEAJksTI8RCup1QExO2q13KfSsKEd
	ti65pJrG0qxqiHmEiVkpDKqZuovTH1fXhg+tE2ZWd5wD9yYB0LlhcgS3J95Eg2cdDWAQ
	Vxdnj6HsAD0y6i+HnbBm6e7QMtkLa3DU/a/etNQUTsMsIQsCxrdlj/AA7Tr6NfxZykhT
	3Pig==
X-Gm-Message-State: AMCzsaVf8BEV318/ZUu7z2JKmyDzoSeehhWPhWRjWKMEvo5W2FrZkxQ2
	42Fa01zD+OLaZaN4nZXbXMVkAUq0
X-Google-Smtp-Source: ABhQp+RtT4OejESghO5l7ea326ubl0igNTFTVyzgJj4K0JR+sJAuMrL9+rLYuBgE2hqR4RrihJRrpw==
X-Received: by 10.223.184.69 with SMTP id u5mr3461996wrf.33.1508239697117;
	Tue, 17 Oct 2017 04:28:17 -0700 (PDT)
Received: from crde-port-20.cahors.local ([185.47.80.46])
	by smtp.gmail.com with ESMTPSA id o3sm9545623wmg.3.2017.10.17.04.28.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 17 Oct 2017 04:28:16 -0700 (PDT)
From: David Vincent <freesilicon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Oct 2017 13:27:48 +0200
Message-Id: <20171017112748.10968-1-freesilicon@gmail.com>
X-Mailer: git-send-email 2.14.2
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
X-List-Received-Date: Tue, 17 Oct 2017 11:28:16 -0000

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


