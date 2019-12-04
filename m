Return-Path: <pascal.huerst@gmail.com>
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
	[209.85.208.42])
	by mail.openembedded.org (Postfix) with ESMTP id 5EAA37F362
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Dec 2019 09:16:01 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id j17so5989357edp.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Dec 2019 01:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Soy51/V3bnIThjA4EOobLZ9L8xBpwsrE+SANHdy3XsI=;
	b=tw7/Kg7HpLy9cH5W3+TtBixsyTfAfRkOfhAMvT9uWDHPViMYw/lqppBV2oCYOe5qyu
	mFjeCux0WPpo0/lOxR4eLfO2LJ0wiey/ZepB6KW40rEj7qavbrAahPnPb6JlHrBS8N+C
	EXMOeyT3Fc7Q5HwMce74CC/nmPFdsDrldWMju+a6n8GwuCoKo7+grZ3P8a5rYTbLY6wr
	z9xk/XW/VLhbnL3ZVk+d5/18JESkgi4zzOQGC5ldGe8P8SE0ZAWltm0Vxd7O2EC7MDEv
	kgHL5wwFWzzPSOegHcLwFAB8VoM28SDXPU975m2vaJk4K5XHOiP2isqwnNsfWrsZRAGy
	ErQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Soy51/V3bnIThjA4EOobLZ9L8xBpwsrE+SANHdy3XsI=;
	b=fRTM2uG1v4G29nrfE18DLYPrFjUZZFR30TM3tldNOZWsqHegCgOEFhwyjtAZfaJ1bO
	KppuCVmSsWGFM2Ts1uIyAsthfrPsTAE6L9k/WkmqlTOyDsqxu6tzQeV7AwhX9XFydZpO
	YTOhQMeERhHlLV8xXYkDATaut58fM1rBgWL7B4B4xRgg5f2BNNbvlzhidD8/ZReD1Jug
	K02HcgUVzuEQr169bTVPQSESA+m0HYVy6uYIugccUXU9ZLt6Nvnm5gQTqUDw/EVBH37h
	7B/vN8+vCleyrexDGn2r+/G2BFgFc8xfp7ShmOcdE+ATI2bzs03sPYkZYOKpLyWGT362
	CkiQ==
X-Gm-Message-State: APjAAAUwdK3PVaNEvdIchXi/nAKRNI28cy1asESRqTbBwqR9XFWJK++i
	VleRuqUJPYgwTKsI3Yb5u9Z9m+bV
X-Google-Smtp-Source: APXvYqwBOez9l5CjbQWqVN/Uy5uLTebq76AVbh4OCWZcnILSAWhgYAULyc22hCQOQHGhNke+5zKMwg==
X-Received: by 2002:a05:6402:1b11:: with SMTP id
	by17mr2827917edb.13.1575450961839; 
	Wed, 04 Dec 2019 01:16:01 -0800 (PST)
Received: from t470s-local.localdomain ([194.162.236.226])
	by smtp.gmail.com with ESMTPSA id q2sm72455eje.63.2019.12.04.01.16.01
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 04 Dec 2019 01:16:01 -0800 (PST)
From: pascal.huerst@gmail.com
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Dec 2019 10:15:40 +0100
Message-Id: <20191204091540.28005-1-pascal.huerst@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Subject: [PATCH v1] bitbake: fetch2/git: add SRC_URI option versiontag
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
X-List-Received-Date: Wed, 04 Dec 2019 09:16:01 -0000
Content-Transfer-Encoding: 8bit

From: Pascal Huerst <pascal.huerst@gmail.com>

Use latest_versionstring() to find the latest tagged release for use with
AUTOREV. This can be useful, if you want to build the latest tagged release
instead of a branch. UPSTREAM_CHECK_GITTAGREGEX can be used to specify a
version format.

Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
---
 bitbake/lib/bb/fetch2/git.py  | 24 ++++++++++++++++++++----
 bitbake/lib/bb/tests/fetch.py | 18 ++++++++++++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index fa41b078f1..3091619475 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -47,6 +47,11 @@ Supported SRC_URI options are:
    referring to commit which is valid in tag instead of branch.
    The default is "0", set nobranch=1 if needed.
 
+- versiontag
+   Use latest_versionstring() to find the latest tagged release for use with
+   AUTOREV. Implies nobranch. Check UPSTREAM_CHECK_GITTAGREGEX on how to specify
+   your version format.
+
 - usehead
    For local git:// urls to use the current branch HEAD as the revision for use with
    AUTOREV. Implies nobranch.
@@ -150,6 +155,8 @@ class Git(FetchMethod):
 
         ud.nobranch = ud.parm.get("nobranch","0") == "1"
 
+        ud.versiontag = ud.parm.get("versiontag","0") == "1"
+
         # usehead implies nobranch
         ud.usehead = ud.parm.get("usehead","0") == "1"
         if ud.usehead:
@@ -161,9 +168,20 @@ class Git(FetchMethod):
         ud.bareclone = ud.parm.get("bareclone","0") == "1"
         if ud.bareclone:
             ud.nocheckout = 1
-  
+
+        # versiontag implies nobranch
+        if ud.versiontag:
+            ud.nobranch = 1
+
+        ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0"
+
         ud.unresolvedrev = {}
         branches = ud.parm.get("branch", "master").split(',')
+
+        if ud.versiontag:
+            upversion, revision = self.latest_versionstring(ud, d)
+            d.setVar("SRCREV", revision)
+
         if len(branches) != len(ud.names):
             raise bb.fetch2.ParameterError("The number of name and branch parameters is not balanced", ud.url)
 
@@ -221,8 +239,6 @@ class Git(FetchMethod):
         if ud.usehead:
             ud.unresolvedrev['default'] = 'HEAD'
 
-        ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0"
-
         write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0"
         ud.write_tarballs = write_tarballs != "0" or ud.rebaseable
         ud.write_shallow_tarballs = (d.getVar("BB_GENERATE_SHALLOW_TARBALLS") or write_tarballs) != "0"
@@ -674,7 +690,7 @@ class Git(FetchMethod):
             if tag == None:
                 continue
 
-            tag = tag.group('pver')
+            tag = tag.group(0)
             tag = tag.replace("_", ".")
 
             if verstring and bb.utils.vercmp(("0", tag, ""), ("0", verstring, "")) < 0:
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 83fad3ff0d..175f0abd61 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -996,6 +996,24 @@ class FetcherNetworkTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility/testtools/umock-c/deps/ctest/README.md')), msg='Missing submodule checkout')
         self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility/testtools/umock-c/deps/testrunner/readme.md')), msg='Missing submodule checkout')
 
+    @skipIfNoNetwork()
+    def test_git_versiontag(self):
+        """ If versiontag is set in SRC_URI, it should fetch the latest release tag, using UPSTREAM_CHECK_GITTAGREGEX. If unset, standard format vX.X.X is used"""
+
+        url = "git://git.yoctoproject.org/git/poky;protocol=https;versiontag=1"
+
+        self.d.setVar('SRCREV', '${AUTOREV}')
+        self.d.setVar('AUTOREV', '${@bb.fetch2.get_autorev(d)}')
+        self.d.setVar('UPSTREAM_CHECK_GITTAGREGEX', "([a-z]+)-([0-9]+).([0-9]+).([0-9]+)")
+
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+
+        os.chdir(os.path.dirname(self.unpackdir))
+        fetcher.unpack(self.unpackdir)
+
+        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
+
 class SVNTest(FetcherTest):
     def skipIfNoSvn():
         import shutil
-- 
2.23.0


