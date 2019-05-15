Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 5DF217DE9C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 May 2019 18:03:18 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x4FI2gBA031538
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 15 May 2019 11:02:52 -0700
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.439.0;
	Wed, 15 May 2019 11:02:31 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 15 May 2019 14:02:30 -0400
Message-ID: <20190515180230.187728-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Subject: [RFC PATCH] svn.py: Stop SVN from directly pulling from an external layer w/o fetcher
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
X-List-Received-Date: Wed, 15 May 2019 18:03:18 -0000
Content-Type: text/plain

Add a new option to the svn fetcher url "externals=allowed".  This will allow
a user to enable svn co w/ externals.  However, this does avoid the fetcher,
network access and mirror systems.

By default we no longer allow externals in the checkout.  This ensures a
deterministic download.  The system does attempt to identify SVN repos that
have externals enabled, and will warn the user.

In the future we would like to parse this list and see if the items are already
in the SRC_URI for that recipe, but with SVN being in limited use these days
that extra work is likely not worth the trouble.

Add test cases that generated a local SVN tree, with an external source
set to github bitbake in svn format.  One test case checks that externals are
ignored, and one checks that they in downloaded.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 This was done in response to the patch from Krzysztof Zawadzki and the resulting
 discussion to make this the default instead of optional.

 lib/bb/fetch2/svn.py  | 12 +++++++++
 lib/bb/tests/fetch.py | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index baeb0e7..08e4510 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -91,6 +91,10 @@ class Svn(FetchMethod):
             svncmd = "%s log --limit 1 %s %s://%s/%s/" % (ud.basecmd, " ".join(options), proto, svnroot, ud.module)
         else:
             suffix = ""
+
+            if not ("externals" in ud.parm and ud.parm["externals"] == "allowed"):
+                options.append("--ignore-externals")
+
             if ud.revision:
                 options.append("-r %s" % ud.revision)
                 suffix = "@%s" % (ud.revision)
@@ -136,6 +140,14 @@ class Svn(FetchMethod):
                 bb.fetch2.check_network_access(d, svnfetchcmd, ud.url)
                 runfetchcmd(svnfetchcmd, d, workdir=ud.pkgdir)
 
+            # Warn the user if this had externals (won't catch them all)
+            output = runfetchcmd("svn propget svn:externals", d, workdir=ud.moddir)
+            if output:
+                if "--ignore-externals" in svnfetchcmd.split():
+                    bb.warn("svn repository has ignored externals:\n%s" % output)
+                else:
+                    bb.debug(1, "svn repository has externals:\n%s" % output)
+
             scmdata = ud.parm.get("scmdata", "")
             if scmdata == "keep":
                 tar_flags = ""
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 6bdf041..d6b85cf 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -991,6 +991,73 @@ class FetcherNetworkTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility/testtools/umock-c/deps/ctest/README.md')), msg='Missing submodule checkout')
         self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility/testtools/umock-c/deps/testrunner/readme.md')), msg='Missing submodule checkout')
 
+class SVNTest(FetcherTest):
+
+    def setUp(self):
+        """ Create a local repository """
+
+        super(SVNTest, self).setUp()
+
+        # Create something we can fetch
+        src_dir = tempfile.mkdtemp(dir=self.tempdir,
+                                   prefix='svnfetch_srcdir_')
+        src_dir = os.path.abspath(src_dir)
+        bb.process.run("echo readme > README.md", cwd=src_dir)
+
+        # Store it in a local SVN repository
+        repo_dir = tempfile.mkdtemp(dir=self.tempdir,
+                                   prefix='svnfetch_localrepo_')
+        repo_dir = os.path.abspath(repo_dir)
+        bb.process.run("svnadmin create project", cwd=repo_dir)
+
+        self.repo_url = "file://%s/project" % repo_dir
+        bb.process.run("svn import --editor-cmd 'cp %s/README.md' %s %s/trunk" % (src_dir, src_dir, self.repo_url), cwd=repo_dir)
+
+        print("local checkout %s" % os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
+        bb.process.run("svn co %s svnfetch_co" % self.repo_url, cwd=self.tempdir)
+        # Github will emulate SVN.  Use this to check if we're downloding...
+        bb.process.run("svn propset svn:externals 'bitbake http://github.com/openembedded/bitbake' .",
+                       cwd=os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
+        bb.process.run('svn commit -m "Add external"',
+                       cwd=os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
+
+        self.src_dir = src_dir
+        self.repo_dir = repo_dir
+
+    def tearDown(self):
+        os.chdir(self.origdir)
+        if os.environ.get("BB_TMPDIR_NOCLEAN") == "yes":
+            print("Not cleaning up %s. Please remove manually." % self.tempdir)
+        else:
+            bb.utils.prunedir(self.tempdir)
+        
+    @skipIfNoNetwork()
+    def test_noexternal_svn(self):
+        # Always match the rev count from setUp (currently rev 2)
+        url = "svn://%s;module=trunk;protocol=file;rev=2" % self.repo_url.replace('file://', '')
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        os.chdir(os.path.dirname(self.unpackdir))
+        fetcher.unpack(self.unpackdir)
+
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'trunk')), msg="Missing trunk")
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'trunk', 'README.md')), msg="Missing contents")
+        self.assertFalse(os.path.exists(os.path.join(self.unpackdir, 'trunk/bitbake/trunk')), msg="External dir should NOT exist")
+        self.assertFalse(os.path.exists(os.path.join(self.unpackdir, 'trunk/bitbake/trunk', 'README')), msg="External README should NOT exit")
+
+    def test_external_svn(self):
+        # Always match the rev count from setUp (currently rev 2)
+        url = "svn://%s;module=trunk;protocol=file;externals=allowed;rev=2" % self.repo_url.replace('file://', '')
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        os.chdir(os.path.dirname(self.unpackdir))
+        fetcher.unpack(self.unpackdir)
+
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'trunk')), msg="Missing trunk")
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'trunk', 'README.md')), msg="Missing contents")
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'trunk/bitbake/trunk')), msg="External dir should exist")
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'trunk/bitbake/trunk', 'README')), msg="External README should exit")
+
 class TrustedNetworksTest(FetcherTest):
     def test_trusted_network(self):
         # Ensure trusted_network returns False when the host IS in the list.
-- 
1.8.3.1


