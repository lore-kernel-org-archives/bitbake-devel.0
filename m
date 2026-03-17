Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E43FD7065
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 10:09:00 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.72449.1773742130212197032
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Mar 2026 03:08:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ja4gbJBn;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9CFAF4E42645
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Mar 2026 10:08:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 562DA60050;
	Tue, 17 Mar 2026 10:08:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C988A10450450;
	Tue, 17 Mar 2026 11:08:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773742127; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QDdtqu20O4WqinqGWbwx8ikZqH+xw4msVCf8rItarbQ=;
	b=ja4gbJBnmC9275x6SEtW72a99qxtDyIOX1spTvGaLdpwEi/53UUR62LuqRaxoS275hObZu
	82udHMI/nlBmRPVNF/th+PJBtK7B4SBpfapB7S4PW/9+RoYEWWHgmRoTzsVcCzwbqodQpV
	On5PvEyMjppms3MWtgguSuK/FU411YHCLsSOUcQnIZnLxEGZq1SKMVHoil4h4DtnqPXpFX
	knWbKAiZxrWOkM4GRRgOXL7pBpGOq7BCJLu8zluvTzT1DRs22JCuUwAGRKkQ/dJvv2jZU/
	+G6+d1w2vuTkU0eKMScKePpxuBW0Cd+CIzezkKzFuOxCQ9lBPAsqs7/jaPDPjA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 17 Mar 2026 11:08:37 +0100
Subject: [PATCH 2/5] doc/setversions.py: simplify the get_current_version()
 function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-docs-releases-json-v1-2-492d0b256349@bootlin.com>
References: <20260317-docs-releases-json-v1-0-492d0b256349@bootlin.com>
In-Reply-To: <20260317-docs-releases-json-v1-0-492d0b256349@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6618;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=BbwKzVuiJq6T2z7hybisISWhmCbokJGR5W/ACCpgeiQ=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpuSgr4E/ciHrYME0bAjaFRT2gnigtx1T2p0com
 /KU7U2MWhOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCabkoKwAKCRDRgEFAKaOo
 NrS5EACTeTLaastEs2PTB7GnBLKRgJp4MwA8xIZEoreQJeGkVcpN9FpTW/dNkbt8YEiCH9sqC43
 peyuoyPuj7dZ/l6ZSRx0IHzCkysB0wbKDd7JfxoeC39Rc1/KXHdXzcwiBeeU3wP+J8OmapeSNwU
 t0cARHD9o0Z0azrcVSGiABMA31/RYwiEf1KX/DVjVT7mVQQ2JHrdhqqfP/2wn5fQ6X5YudsxEAi
 9Eu1M50YqVWcDi3BZyxU/z901ogvoAjzNRwIwL4QkbHqLrRSya+PYK+B8mZnK2xAcn7PWvg8ecr
 x5GMwSxbgb3kt95GMDN46vS1WFmZTEC1AJgEL2zvg74ZBPUc648WgV0XlrtXhIkUe/aUE3UIY2p
 B55JbXYXqWijSvNZMzQmoX23ovEebc5ijdcbyo5yQF0wL6ygte706Tx5K/pxAaWMpfOdcnyra2I
 QTSlc2wg2PNJtKW+pHniIiHgRgxjblq6qbyMXydn/GuQGjlWbmBJ1rmEY/T1Gbfbxg9t8VVHr9O
 jNYK8y+p3iX+tfN/8Qe3Xs9wXWhtKw4lFblTS5S8aG/vNGdkXjGT4LF+gMFReOES5gJJO5cVjxR
 R39Ct++nLbwSFpvZcebHSMKE16stKWhnLwFef6V+L0Wmb1SFu8j6MdX3VA03HNABei3pkZXr3oV
 Hm3MPlOc1kze1lg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Mar 2026 10:09:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19161

While this was inspired with yocto-docs' set_versions.py file[1], some
of the logic here can be simplified with early returns.

As a consequence of these early returns, move the print() call showing
the computed version to the conf.py file.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/conf.py        |  1 +
 doc/setversions.py | 90 +++++++++++++++++++++++++-----------------------------
 2 files changed, 42 insertions(+), 49 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index 40a022eaa00..315fb7d06a7 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -26,6 +26,7 @@ sys.path.insert(0, os.path.abspath('.'))
 import setversions
 
 current_version = setversions.get_current_version()
+print(f"Version calculated to be {current_version}")
 
 # String used in sidebar
 version = 'Version: ' + current_version
diff --git a/doc/setversions.py b/doc/setversions.py
index 2ec68ac9945..4130df67695 100755
--- a/doc/setversions.py
+++ b/doc/setversions.py
@@ -41,8 +41,6 @@ YOCTO_MAPPING = {
 BB_RELEASE_TAG_RE = re.compile(r"^[0-9]+\.[0-9]+\.[0-9]+$")
 
 def get_current_version():
-    ourversion = None
-
     # Test tags exist and inform the user to fetch if not
     try:
         subprocess.run(["git", "show", f"{LTSSERIES[0]}.0"],
@@ -50,63 +48,57 @@ def get_current_version():
     except subprocess.CalledProcessError:
         sys.exit("Please run 'git fetch --tags' before building the documentation")
 
-
     # Try and figure out what we are
     tags = subprocess.run(["git", "tag", "--points-at", "HEAD"],
                           stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                           universal_newlines=True).stdout
     for t in tags.split():
         if re.match(BB_RELEASE_TAG_RE, t):
-            ourversion = t
-            break
+            return t
 
-    if ourversion:
-        # We're a tagged release
-        components = ourversion.split(".")
-    else:
-        # We're floating on a branch
-        branch = subprocess.run(["git", "branch", "--show-current"],
-                                stdout=subprocess.PIPE, stderr=subprocess.PIPE,
-                                universal_newlines=True).stdout.strip()
-
-        if branch == "" or branch not in list(YOCTO_MAPPING.keys()) + ["master", "master-next"]:
-            # We're not on a known release branch so we have to guess. Compare the
-            # numbers of commits from each release branch and assume the smallest
-            # number of commits is the one we're based off
-            possible_branch = None
-            branch_count = 0
-            for b in itertools.chain(YOCTO_MAPPING.keys(), ["master"]):
-                result = subprocess.run(["git", "log", "--format=oneline", "HEAD..origin/" + b],
-                                        stdout=subprocess.PIPE, stderr=subprocess.PIPE,
-                                        universal_newlines=True)
-                if result.returncode == 0:
-                    count = result.stdout.count('\n')
-                    if not possible_branch or count < branch_count:
-                        print("Branch %s has count %s" % (b, count))
-                        possible_branch = b
-                        branch_count = count
-            if possible_branch:
-                branch = possible_branch
-            else:
-                branch = "master"
-            print("Nearest release branch estimated to be %s" % branch)
+    # We're floating on a branch
+    branch = subprocess.run(["git", "branch", "--show-current"],
+                            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
+                            universal_newlines=True).stdout.strip()
 
-        if branch == "master":
-            ourversion = "dev"
-        elif branch == "master-next":
-            ourversion = "next"
+    if branch == "" or branch not in list(YOCTO_MAPPING.keys()) + ["master", "master-next"]:
+        # We're not on a known release branch so we have to guess. Compare the
+        # numbers of commits from each release branch and assume the smallest
+        # number of commits is the one we're based off
+        possible_branch = None
+        branch_count = 0
+        for b in itertools.chain(YOCTO_MAPPING.keys(), ["master"]):
+            result = subprocess.run(["git", "log", "--format=oneline", "HEAD..origin/" + b],
+                                    stdout=subprocess.PIPE, stderr=subprocess.PIPE,
+                                    universal_newlines=True)
+            if result.returncode == 0:
+                count = result.stdout.count('\n')
+                if not possible_branch or count < branch_count:
+                    print("Branch %s has count %s" % (b, count))
+                    possible_branch = b
+                    branch_count = count
+        if possible_branch:
+            branch = possible_branch
         else:
-            ourversion = branch
-            head_commit = subprocess.run(["git", "rev-parse", "--short", "HEAD"],
-                                         stdout=subprocess.PIPE, stderr=subprocess.PIPE,
-                                         universal_newlines=True).stdout.strip()
-            branch_commit = subprocess.run(["git", "rev-parse", "--short", branch],
-                                            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
-                                            universal_newlines=True).stdout.strip()
-            if head_commit != branch_commit:
-                ourversion += f" ({head_commit})"
+            branch = "master"
+        print("Nearest release branch estimated to be %s" % branch)
+
+    if branch == "master":
+        return "dev"
+
+    if branch == "master-next":
+        return "next"
+
+    ourversion = branch
+    head_commit = subprocess.run(["git", "rev-parse", "--short", "HEAD"],
+                                 stdout=subprocess.PIPE, stderr=subprocess.PIPE,
+                                 universal_newlines=True).stdout.strip()
+    branch_commit = subprocess.run(["git", "rev-parse", "--short", branch],
+                                   stdout=subprocess.PIPE, stderr=subprocess.PIPE,
+                                   universal_newlines=True).stdout.strip()
+    if head_commit != branch_commit:
+        ourversion += f" ({head_commit})"
 
-    print("Version calculated to be %s" % ourversion)
     return ourversion
 
 def write_switchers_js(js_in, js_out, current_version):

-- 
2.53.0


