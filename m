Return-Path: <freesilicon@gmail.com>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
	[209.85.128.196])
	by mail.openembedded.org (Postfix) with ESMTP id F185B78681
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Nov 2017 15:25:10 +0000 (UTC)
Received: by mail-wr0-f196.google.com with SMTP id o88so14730991wrb.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Nov 2017 07:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=LLDNAVh/PeAfkRvD0K8yNdI+kmS5o1IQGmYcxOTHmVA=;
	b=IvWIahIYhgBs7+VwRZW/h8rDCKUtZ8SnZAWJwtoFMrCP5mRQ7bGbIN4ftCY0ZsvcvY
	zQOrD42QHcO5ae92u2JUVUdTayD0huMS28Sertk1Lmzx+j2B/Uv/au85t7WxlMK4pOPS
	rDvwXGNLHDOX4eFrbX+e2kZF5uH0BBRwM/A/9sOeMo8qsaDodnu4kykmcfWlhadQ+2jF
	Fbvw3p8jIhORWuLkqniGA6NYcCwIKCK5Icp7m+MmCvoE5253Tl+uxNDwqF0UzTWb2ldn
	SOGN43JKu9hqiHXLxNncWPVZoMnxU2S9HiTC+F9d9uQgTJzrg2gURlrk6HlwdPKQ3irB
	jRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=LLDNAVh/PeAfkRvD0K8yNdI+kmS5o1IQGmYcxOTHmVA=;
	b=kzh62uz4IqwkJ3knjmPz+e7giXepAYSHXp15KqTGIOVbG6/tz/m66Z+W0gm44RlNZV
	bjxsyFEGHA5lEHfQpMNKGrDcW0rkq4TOsjZfYUooewnIAfkBwgOSFJ/lJ1Jifob68mf3
	Ao1wqLBI62VW7WXWcX5RcWXkCo8fpoTS+MYuEqQ/aoU91gymsoe3Haadig7Y7phkb7HY
	H3J4nyaY8UDCmMeC3hG9fVeNHnovAzGKlJXk86nc0jYc2ukAiqYMzDABucIzVEk/jE7j
	oHsXR1N2zqXU9mQL4AGfANEB1xIc37V0glqRhGl2s8gVDZWyh/cTgg9fWssA11Eyxy51
	SaEA==
X-Gm-Message-State: AJaThX4TUBRLfL7N1K0JGunUhVVTH95A7Qxl/ATVGH68lt+94Q7SjQ17
	rc5l/sBT6kea1UqPkkhq3IYjroxK
X-Google-Smtp-Source: AGs4zMaf6EVku6+foKLPyFls9Nc5ijB+J34bnewdU0YtMMoUqhoRvFtkGO2ASKBc94QoYLFPOkkQ2g==
X-Received: by 10.223.173.67 with SMTP id p61mr6977970wrc.226.1510586711329;
	Mon, 13 Nov 2017 07:25:11 -0800 (PST)
Received: from crde-port-20.cahors.local ([185.47.80.46])
	by smtp.gmail.com with ESMTPSA id
	l16sm20192454wma.19.2017.11.13.07.25.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 13 Nov 2017 07:25:10 -0800 (PST)
From: David Vincent <freesilicon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Nov 2017 16:24:03 +0100
Message-Id: <20171113152404.21785-2-freesilicon@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171113152404.21785-1-freesilicon@gmail.com>
References: <20171113151617.20905-1-freesilicon@gmail.com>
	<20171113152404.21785-1-freesilicon@gmail.com>
Subject: [PATCH v3 1/2] fetch/git: fix per-branch unpacking
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
X-List-Received-Date: Mon, 13 Nov 2017 15:25:11 -0000

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
 lib/bb/tests/fetch.py | 28 ++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 5 deletions(-)

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
index 7d7c5d7f..7ec83fac 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -663,6 +663,34 @@ class FetcherNetworkTest(FetcherTest):
         self.d.setVar("PREMIRRORS", "%s git://%s;protocol=file \n" % (dummyurl, self.sourcedir))
         self.gitfetcher(dummyurl, dummyurl)
 
+    @skipIfNoNetwork
+    def test_gitfetch_multi_one_uri(self):
+        rev = "be393f247a08c0a4a50a6a76b8fd57f78295d2a1"
+        rev1 = "85596c9af3bb6407159c6c8de229cbe275aa74ea"
+        rev2 = "28249c42701f9156a0b3153d72d7e46dacab37cb"
+        self.d.setVar("SRCREV_rev1", rev1)
+        self.d.setVar("SRCREV_rev2", rev2)
+        url = "git://git.openembedded.org/bitbake;name=rev1,rev2;branch=1.34,1.36"
+        fetcher = bb.fetch.Fetch([url], self.d);
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        stdout = bb.process.run("git rev-parse master",
+        cwd=os.path.join(self.unpackdir, "git"))
+        unpack_rev = stdout[0].strip()
+        self.assertEqual(unpack_rev, rev);
+        stdout = bb.process.run("git rev-parse HEAD",
+        cwd=os.path.join(self.unpackdir, "git"))
+        unpack_rev = stdout[0].strip()
+        self.assertEqual(unpack_rev, rev1);
+        stdout = bb.process.run("git rev-parse 1.34",
+        cwd=os.path.join(self.unpackdir, "git"))
+        unpack_rev = stdout[0].strip()
+        self.assertEqual(unpack_rev, rev1);
+        stdout = bb.process.run("git rev-parse 1.36",
+        cwd=os.path.join(self.unpackdir, "git"))
+        unpack_rev = stdout[0].strip()
+        self.assertEqual(unpack_rev, rev2);
+
     @skipIfNoNetwork()
     def test_git_submodule(self):
         fetcher = bb.fetch.Fetch(["gitsm://git.yoctoproject.org/git-submodule-test;rev=f12e57f2edf0aa534cf1616fa983d165a92b0842"], self.d)
-- 
2.13.6


