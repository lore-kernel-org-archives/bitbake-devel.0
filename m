Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
	[209.85.192.194])
	by mail.openembedded.org (Postfix) with ESMTP id 37B1B77D29
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 21:46:51 +0000 (UTC)
Received: by mail-pf0-f194.google.com with SMTP id u26so8302046pfd.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 14:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=Kxuhp8JRWjTNmUCpuBht3TbEhfHehT5b71nS0sWtgkI=;
	b=A51bBTBpxN40BDVgHRuWeXnDXxl79UVOd+aRLl4vU0x+kNFoIeeu9Ps2pvjj/GMV4h
	0bSEow6i8Qde3ez2HRKP3KddDDNmrmym4NzZnQBPXC6qVBUokBaxiBgrgJBkKoE171s4
	/hl30/RR2u5BrzRnDADGjE1p+15yYul4+CN+fJ1RiA6N/GWmoRIIv2OYxxSNdr39L5/k
	0qZgA2wWEB/pt8+IsVVWB8+vTc2FPGkIu40e9J7fwvc8tg5MNf0c94jJ/IDZnSL4T/TJ
	rGRPDDO3e+tARwsqQbKP/C+w//hsAqvxjNHcd0no4BN/nJLfT6H+v1ZEl9lyz7qFAcfO
	QtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Kxuhp8JRWjTNmUCpuBht3TbEhfHehT5b71nS0sWtgkI=;
	b=XDKlV6llfuPRqXjj4O5bs4QE9l+1Vswciq971jsbKkb4GynH/GNl7prNh10iMtGh+4
	5aRtc6PabqFLslhMBhW7qpOcXR174KSuWVRS097U8ksKl364mFk55nl+ozKsjayufLvA
	FAGzQJcWEgOwcGw0dcsd53V5iM2yoUAvmUZ2wK+he8LfiUKnKGBNowvojWOr6Iy3fM4/
	nIV1u2yJP0BOVm2qdsowQwEi+L21S3+ZZLnFx/k6dd5yqg4bBOqrjPwCwK6l1hzl1BSV
	20aWm0XQr3vJgTfwhyRKbLMRHjTKQw0VfcHKNxAXSjZkP/DS6FLrvo7vXQYNbDM3xZFh
	sIbg==
X-Gm-Message-State: AODbwcAxrtRWZFcLBDtufe0KB43ggPmyyvJDTdu3WSocUJW2r4VN8Cb3
	KJ0f6KofF0vC1w==
X-Received: by 10.99.96.70 with SMTP id u67mr6623300pgb.101.1494625613252;
	Fri, 12 May 2017 14:46:53 -0700 (PDT)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id
	v63sm1244051pfi.133.2017.05.12.14.46.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 12 May 2017 14:46:52 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 13 May 2017 02:46:29 +0500
Message-Id: <1c766032583861ddb58d523f4dc245487696d3b0.1494623828.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <cover.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
In-Reply-To: <cover.1494623828.git.chris_larson@mentor.com>
References: <cover.1494623828.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 4/8] fetch/git: support per-branch/per-url depths for shallow
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
X-List-Received-Date: Fri, 12 May 2017 21:46:52 -0000

Allow the user to explicitly adjust the depth for named urls/branches. The
un-suffixed BB_GIT_SHALLOW_DEPTH is used as the default.

Example usage:

    BB_GIT_SHALLOW_DEPTH = "1"
    BB_GIT_SHALLOW_DEPTH_doc = "0"
    BB_GIT_SHALLOW_DEPTH_meta = "0"

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/git.py  | 61 +++++++++++++++++++++++++++++++++------------------
 lib/bb/tests/fetch.py | 35 +++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 23 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 0412f9ff..250109bf 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -70,6 +70,7 @@ Supported SRC_URI options are:
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
+import collections
 import errno
 import os
 import re
@@ -178,12 +179,43 @@ class Git(FetchMethod):
         if ud.bareclone:
             ud.cloneflags += " --mirror"
 
+        ud.shallow = d.getVar("BB_GIT_SHALLOW") == "1"
+
+        depth_default = d.getVar("BB_GIT_SHALLOW_DEPTH")
+        if depth_default is not None:
+            try:
+                depth_default = int(depth_default or 0)
+            except ValueError:
+                raise bb.fetch2.FetchError("Invalid depth for BB_GIT_SHALLOW_DEPTH: %s" % depth_default)
+            else:
+                if depth_default < 0:
+                    raise bb.fetch2.FetchError("Invalid depth for BB_GIT_SHALLOW_DEPTH: %s" % depth_default)
+        else:
+            depth_default = 1
+        ud.shallow_depths = collections.defaultdict(lambda: depth_default)
+
         ud.branches = {}
         for pos, name in enumerate(ud.names):
             branch = branches[pos]
             ud.branches[name] = branch
             ud.unresolvedrev[name] = branch
 
+            shallow_depth = d.getVar("BB_GIT_SHALLOW_DEPTH_%s" % name)
+            if shallow_depth is not None:
+                try:
+                    shallow_depth = int(shallow_depth or 0)
+                except ValueError:
+                    raise bb.fetch2.FetchError("Invalid depth for BB_GIT_SHALLOW_DEPTH_%s: %s" % (name, shallow_depth))
+                else:
+                    if shallow_depth < 0:
+                        raise bb.fetch2.FetchError("Invalid depth for BB_GIT_SHALLOW_DEPTH_%s: %s" % (name, shallow_depth))
+                    ud.shallow_depths[name] = shallow_depth
+
+        if (ud.shallow and
+                all(ud.shallow_depths[n] == 0 for n in ud.names)):
+            # Shallow disabled for this URL
+            ud.shallow = False
+
         if ud.usehead:
             ud.unresolvedrev['default'] = 'HEAD'
 
@@ -222,23 +254,6 @@ class Git(FetchMethod):
         mirrortarball = 'git2_%s.tar.gz' % gitsrcname
         ud.fullmirror = os.path.join(dl_dir, mirrortarball)
         ud.mirrortarballs = [mirrortarball]
-
-        ud.shallow = d.getVar("BB_GIT_SHALLOW") == "1"
-        if ud.shallow:
-            ud.shallow_depth = d.getVar("BB_GIT_SHALLOW_DEPTH")
-            if ud.shallow_depth is not None:
-                try:
-                    ud.shallow_depth = int(ud.shallow_depth or 0)
-                except ValueError:
-                    raise bb.fetch2.FetchError("Invalid depth for BB_GIT_SHALLOW_DEPTH: %s" % ud.shallow_depth)
-                else:
-                    if not ud.shallow_depth:
-                        ud.shallow = False
-                    elif ud.shallow_depth < 0:
-                        raise bb.fetch2.FetchError("Invalid depth for BB_GIT_SHALLOW_DEPTH: %s" % ud.shallow_depth)
-            else:
-                ud.shallow_depth = 1
-
         if ud.shallow:
             tarballname = gitsrcname
             if ud.bareclone:
@@ -246,10 +261,12 @@ class Git(FetchMethod):
 
             for name, revision in sorted(ud.revisions.items()):
                 tarballname = "%s_%s" % (tarballname, ud.revisions[name][:7])
-                if not ud.nobranch:
-                    tarballname = "%s-%s" % (tarballname, ud.branches[name])
+                depth = ud.shallow_depths[name]
+                if depth:
+                    tarballname = "%s-%s" % (tarballname, depth)
 
-            tarballname = "%s-%s" % (tarballname, ud.shallow_depth)
+            if not ud.nobranch:
+                tarballname = "%s_%s" % (tarballname, "_".join(sorted(ud.branches.values())).replace('/', '.'))
 
             fetcher = self.__class__.__name__.lower()
             ud.shallowtarball = '%sshallow_%s.tar.gz' % (fetcher, tarballname)
@@ -370,7 +387,9 @@ class Git(FetchMethod):
         to_parse, shallow_branches = [], []
         for name in ud.names:
             revision = ud.revisions[name]
-            to_parse.append('%s~%d^{}' % (revision, ud.shallow_depth - 1))
+            depth = ud.shallow_depths[name]
+            if depth:
+                to_parse.append('%s~%d^{}' % (revision, depth - 1))
 
             # For nobranch, we need a ref, otherwise the commits will be
             # removed, and for non-nobranch, we truncate the branch to our
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 019f22a1..0b0116b4 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1122,6 +1122,27 @@ class GitShallowTest(FetcherTest):
         self.fetch_shallow(disabled=True)
         self.assertRevCount(2)
 
+    def test_shallow_depth_default_override(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.assertRevCount(2, cwd=self.srcdir)
+
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '2')
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH_default', '1')
+        self.fetch_shallow()
+        self.assertRevCount(1)
+
+    def test_shallow_depth_default_override_disable(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.add_empty_file('c')
+        self.assertRevCount(3, cwd=self.srcdir)
+
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH_default', '2')
+        self.fetch_shallow()
+        self.assertRevCount(2)
+
     def test_current_shallow_out_of_date_clone(self):
         # Create initial git repo
         self.add_empty_file('a')
@@ -1206,13 +1227,15 @@ class GitShallowTest(FetcherTest):
         uri = self.d.getVar('SRC_URI', True).split()[0]
         uri = '%s;branch=master,a_branch;name=master,a_branch' % uri
 
-        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '2')
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH_master', '3')
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH_a_branch', '1')
         self.d.setVar('SRCREV_master', '${AUTOREV}')
         self.d.setVar('SRCREV_a_branch', '${AUTOREV}')
 
         self.fetch_shallow(uri)
 
-        self.assertRevCount(3, ['--all'])
+        self.assertRevCount(4, ['--all'])
         self.assertRefs(['master', 'origin/master', 'origin/a_branch'])
 
     def test_shallow_clone_preferred_over_shallow(self):
@@ -1262,6 +1285,14 @@ class GitShallowTest(FetcherTest):
         with self.assertRaises(bb.fetch2.FetchError):
             self.fetch()
 
+    def test_shallow_invalid_depth_default(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH_default', '-12')
+        with self.assertRaises(bb.fetch2.FetchError):
+            self.fetch()
+
     if os.environ.get("BB_SKIP_NETTESTS") == "yes":
         print("Unset BB_SKIP_NETTESTS to run network tests")
     else:
-- 
2.11.1


