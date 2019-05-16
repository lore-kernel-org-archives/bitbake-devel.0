Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id B08277DFD6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 May 2019 10:46:49 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x4GAkEUY024465
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 16 May 2019 03:46:25 -0700
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.439.0;
	Thu, 16 May 2019 03:46:04 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 16 May 2019 06:46:03 -0400
Message-ID: <20190516104603.154796-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Subject: [PATCH] svn.py: Stop SVN from directly pulling from an external layer w/o fetcher
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
X-List-Received-Date: Thu, 16 May 2019 10:46:49 -0000
Content-Type: text/plain

Add a new option to the svn fetcher url "externals=allowed".  This will allow
a user to enable svn co w/ externals.  However, this does avoid the fetcher,
network access and mirror systems.

By default we no longer allow externals in the checkout.  This ensures a
deterministic download.  The system does attempt to identify SVN repos that
have externals enabled, and will warn the user.  It is up to the user to
determine if these are necessary for the recipe.  They may disable the warning
by adding "externals=nowarn" to the url.

In the future we would like to parse this list and see if the items are already
in the SRC_URI for that recipe, but with SVN being in limited use these days
that extra work is likely not worth the trouble.

Add test cases that generated a local SVN tree, with an external source
set to github bitbake in svn format.  One test case checks that externals are
ignored, and one checks that they in downloaded.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
v2:
 Refactored the test case to use --non-interactive option to try to avoid
 the controlling terminal failure.

 Update the warning message to give more information, as well as a way to
 disable the message if the recipe has already verified it is ok.

v1:
 This was done in response to the patch from Krzysztof Zawadzki and the resulting
 discussion to make this the default instead of optional.

 lib/bb/fetch2/svn.py  | 19 +++++++++++++++
 lib/bb/tests/fetch.py | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index baeb0e7..59ce931 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -91,6 +91,13 @@ class Svn(FetchMethod):
             svncmd = "%s log --limit 1 %s %s://%s/%s/" % (ud.basecmd, " ".join(options), proto, svnroot, ud.module)
         else:
             suffix = ""
+
+            # externals may be either 'allowed' or 'nowarn', but not both.  Allowed
+            # will not issue a warning, but will log to the debug buffer what has likely
+            # been downloaded by SVN.
+            if not ("externals" in ud.parm and ud.parm["externals"] == "allowed"):
+                options.append("--ignore-externals")
+
             if ud.revision:
                 options.append("-r %s" % ud.revision)
                 suffix = "@%s" % (ud.revision)
@@ -136,6 +143,18 @@ class Svn(FetchMethod):
                 bb.fetch2.check_network_access(d, svnfetchcmd, ud.url)
                 runfetchcmd(svnfetchcmd, d, workdir=ud.pkgdir)
 
+            if not ("externals" in ud.parm and ud.parm["externals"] == "nowarn"):
+                # Warn the user if this had externals (won't catch them all)
+                output = runfetchcmd("svn propget svn:externals", d, workdir=ud.moddir)
+                if output:
+                    if "--ignore-externals" in svnfetchcmd.split():
+                        bb.warn("%s contains svn:externals." % ud.url)
+                        bb.warn("These should be added to the recipe SRC_URI as necessary.")
+                        bb.warn("svn fetch has ignored externals:\n%s" % output)
+                        bb.warn("To disable this warning add ';externals=nowarn' to the url.")
+                    else:
+                        bb.debug(1, "svn repository has externals:\n%s" % output)
+
             scmdata = ud.parm.get("scmdata", "")
             if scmdata == "keep":
                 tar_flags = ""
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 6bdf041..803dc6b 100644
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
+        bb.process.run("svn import --non-interactive -m 'Initial import' %s %s/trunk" % (src_dir, self.repo_url),
+                       cwd=repo_dir)
+
+        bb.process.run("svn co %s svnfetch_co" % self.repo_url, cwd=self.tempdir)
+        # Github will emulate SVN.  Use this to check if we're downloding...
+        bb.process.run("svn propset svn:externals 'bitbake http://github.com/openembedded/bitbake' .",
+                       cwd=os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
+        bb.process.run("svn commit --non-interactive -m 'Add external'",
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


