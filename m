Return-Path: <3JxKbXAMKDaIYCMIQQING.EQODKVDCMG-FGXGNNKUVU.QRGPGODGFFGF.QTI@flex--wak.bounces.google.com>
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com
	[209.85.222.202])
	by mail.openembedded.org (Postfix) with ESMTP id C6DF86C3A9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Mar 2019 06:03:18 +0000 (UTC)
Received: by mail-qk1-f202.google.com with SMTP id v2so13707671qkf.21
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Mar 2019 23:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=date:message-id:mime-version:subject:from:to:cc;
	bh=c8vomXit3+EiTiovQCD0pjc/hdV9rUzf9pJMti2JNag=;
	b=DPY+Ls9msWN5OQhtNkH1N/76EH11Tvy50LIlVpF5HCtqwz2KWr2U/KFPmHCRQM1sHH
	5Aw6ZIZNyjm5BXe2WYGAd+9WcRLA6U6MZhv3BtRysonOEBk+xaG/Y6BO9Yt7yiDiwYNR
	n+BEd8gRqWYxydAH22KHN8sL4zIgkYXsRmb8ATpPHqGaFVtfpWuGMuJGH6VHbwaNue1M
	QxRYJcaRSu6j74h1lLBA68JJf799p2dVSoFmj3Uj/Bp43shPzoMgGzOQJ1+7GTEd+nga
	TliZrSCqtoyBLq+TiQ0EeA8pLrIR9GoRCl/C4STC/mJG8v6jm0k6w6BZoUTezHFEOq8z
	JLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
	bh=c8vomXit3+EiTiovQCD0pjc/hdV9rUzf9pJMti2JNag=;
	b=I/ymzzIo8kg8mdskUJIbjgv0QwlNXkZlcEGQecC4W/I5ncunbRMitRk22ZAGrMYBMx
	J3FCE547tJgG668zCbcGbKMF/YumTyRj7rFUbkIPTfh+RWwLU7XXFONIyYAjZF45bj5d
	fmn1af1hUrJh+ZjUdK8dIKEDxONGmXFVBZTTOZM6ukwDSOn8cj2TpLhV3kbQQWxOacwZ
	sBIJxCeh8qUwoItvouMAumhlkGRTwbe7In0ZdiceU+W0WWVsCkU9wwU/bc3AOX7j3ijt
	Sbgvha1Ss5pn9aSne5cMQfxYeFJzhwTd+aC6U9EJ58TaGRzxy8lHavsDPOIMOLF4wv61
	d7+A==
X-Gm-Message-State: APjAAAUr6ioDhbuA8otwwCLIKwum0DkFkw/oPAbG89HMVOvUXqgHidc+
	Eby2TrS+Z73vTQLNzpn82FIN8G8M6UpzKKT3MT0AobYfGfmNpc2BAsNlHh7kqxoTBEs1zMFxNOB
	zixRxg4FCjte/QTPOc1VSeomar589ZBUyxKu8xSQDRYhjtwM1kVyes+LzvCADG61DhwzVV08o
X-Google-Smtp-Source: APXvYqzc6xGx6lONil23zinBmF6QmQ63aUkCgEn7NnuWTEB+inRd06zEu2o76/2ElRUpDAMX219ZEXk=
X-Received: by 2002:ae9:d881:: with SMTP id
	u123mr13087311qkf.294.1553666599684; 
	Tue, 26 Mar 2019 23:03:19 -0700 (PDT)
Date: Tue, 26 Mar 2019 23:03:16 -0700
Message-Id: <20190327060316.136092-1-wak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0
From: "William A. Kennington III" <wak@google.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] gitsm: Check all submodules for updates
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
X-List-Received-Date: Wed, 27 Mar 2019 06:03:18 -0000
Content-Type: text/plain; charset="UTF-8"

Currently, our gitsm fetcher is inheriting the need_update function from
the git fetcher. This results in our do_fetch checking for updates only
if the SRCREV is missing from the top-level project.

Unfortunately, this doesn't take into account the dependent SRCREVs
missing from submodules due to a lack of the submodule existing
during the first checkout, or arbitrary download cache purges of
submodule data.

The most trivial way to encounter this is to have gitsm fetch a software
project before and after adding submodules. When it goes to use the
update that has submodules it will think that it has all of the needed
revisions since it checked the top-level repo. However none of those
submodules will exist in the downloads cache since they weren't included
in the original commit.

Tested:
    Ran the unit test suite with just the new unit test to make sure it
    fails repeatedly. Then applied the fix and ran it some more to
    ensure the fix works.

Signed-off-by: William A. Kennington III <wak@google.com>
---
 lib/bb/fetch2/gitsm.py | 24 ++++++++++++++++++++++++
 lib/bb/tests/fetch.py  | 19 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index b21fed26..f1ecd170 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -36,6 +36,7 @@ from   bb.fetch2.git import Git
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
 from   bb.fetch2 import Fetch
+from   bb.fetch2 import FetchData
 from   bb.fetch2 import BBFetchException
 
 class GitSM(Git):
@@ -147,6 +148,29 @@ class GitSM(Git):
 
         return submodules != []
 
+    def need_update(self, ud, d):
+        if Git.need_update(self, ud, d):
+            return True
+        class NeedUpdateException(Exception):
+            pass
+        def need_update_submodule(ud, url, module, modpath, d):
+            url += ";bareclone=1;nobranch=1"
+            lud = FetchData(url, d, False)
+            lud.setup_localpath(d)
+            if lud.lockfile:
+                lf = bb.utils.lockfile(lud.lockfile)
+            try:
+                if lud.method.need_update(lud, d):
+                    raise NeedUpdateException
+            finally:
+                if lud.lockfile:
+                    bb.utils.unlockfile(lf)
+        try:
+            self.process_submodules(ud, ud.clonedir, need_update_submodule, d)
+            return False
+        except NeedUpdateException:
+            return True
+
     def download(self, ud, d):
         def download_submodule(ud, url, module, modpath, d):
             url += ";bareclone=1;nobranch=1"
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 25732627..429998b3 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -942,6 +942,25 @@ class FetcherNetworkTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')
 
+    def test_git_submodule_update_CLI11(self):
+        """ Prevent regression on update detection not finding missing submodule, or modules without needed commits """
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=cf6a99fa69aaefe477cc52e3ef4a7d2d7fa40714"
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+
+        # CLI11 that pulls in a newer nlohmann-json
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=49ac989a9527ee9bb496de9ded7b4872c2e0e5ca"
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        # Previous cwd has been deleted
+        os.chdir(os.path.dirname(self.unpackdir))
+        fetcher.unpack(self.unpackdir)
+
+        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/googletest/config')), msg='Missing submodule config "extern/googletest"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')
+
     def test_git_submodule_aktualizr(self):
         url = "gitsm://github.com/advancedtelematic/aktualizr;branch=master;protocol=git;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
         fetcher = bb.fetch.Fetch([url], self.d)
-- 
2.21.0


