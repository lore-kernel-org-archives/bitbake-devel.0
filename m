Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED025E9A04E
	for <webhook@archiver.kernel.org>; Wed, 18 Feb 2026 13:15:41 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11588.1771420537929904333
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Feb 2026 05:15:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=mamjmGUx;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 51531C211D2
	for <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 13:15:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 65B906074B
	for <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 13:15:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA23410368B8E;
	Wed, 18 Feb 2026 14:15:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771420536; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ev4DfHpYsx39ok5s2cor/WtMF8lP+iWvNdX187dNy28=;
	b=mamjmGUxKFA9qpB/D6etRw6wHzdSeSseEQ9CMW+MHeMeZanoFf9k7U9825aBt80kyG/WjY
	n8Bz9fZoHcKJyRShYGqUtFW6JJeFNUAS+VY9VYeHEWJmOuZ+70F+G4GCK+KAygdKKM93xS
	Pft05oxraPFiB4DVpuU7LTDhhoSVfS+htJgIYapZ8iA1yS42PC4wDrv3k1F+9KRBdj9+F9
	BsfYlkWp7ncL7q1otmSB8ML+9/HMM1GOPjlcIAgo+spA1TDvXDg9Hnj3ne9sqpiI4tThU+
	v+D/zEj2ZBkwo0KQ7Fp2dZXdvqTgX4EdzX6tUtxB04yl6iCKkuJ8FSVkqHnXrw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 18 Feb 2026 14:15:28 +0100
Subject: [PATCH v2 3/4] bitbake-setup: print colored diffs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-improve-bbsetup-readability-v2-3-351584e5df9c@bootlin.com>
References: <20260218-improve-bbsetup-readability-v2-0-351584e5df9c@bootlin.com>
In-Reply-To: <20260218-improve-bbsetup-readability-v2-0-351584e5df9c@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3535;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=jbM+2WoZ5OGtfQPoPYPIqXJ3RRrE+F4vjwACRmzV8cI=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBplbt17Hus0K98IAe0PWTo70a1SOMDZzpbk9r0h
 /da6Y0wLqWJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaZW7dQAKCRDRgEFAKaOo
 NmW4EADAkT6djWrpZ7/8UREMNm346PCYV1LqZqXQ8HvxvvWDj+npA8rIG4RwfwGdJ4yWM+k+bAz
 SHR3KXjJEQ0AxHbATr9WKIfKzN3dCPO9xWNjnpJVYpKcbLg6buw3Uiy+mgw9knloEzTaZzfDbSP
 RMolC0M6SpnnEToqaFSCM98WYoWfMtKUkWrMcvAKbtTe/YRSLrLpyHmswZi26dNm0rKQuno2sw5
 +/8Iis4yRv6dCseATIxLT8Kbb5P8x3izH2skFCNh2ozUnDXCGNYjlzQslxAfGuJle+V4cfQr+3V
 dnaq5kUiZKLhjSlRVvZ2KzZ6N8Upmc3RDnFgZHjSjWYUsAkdpuvwDgnVO2STfMvL9AAtdoaoYJw
 tUrlv5A10uf2p+cgVFFd6PQ95O6s3mxjbI10VhIZOu8izqhg5fQ2cRrbE0QkTF5E7x6w35R5STv
 8pcGn2mvI2L7GUjsct/1aZ0G5ywSjuf3bN0n496FKsexE0cgeX4M6SLCyZuZqjB0yjCxefX1ft3
 HfLhQAD4lm/SdNztnvueOS8jSLw+MS0KhycS5ZU4K35AIutKnPhDzkEFkMfcQTVpvFkFEd0TsqM
 MMMgL+++Irjm7yQvxM+hf7g+RvWFxje54KsvgfypkbP68FRlKIcHWVlsB2DXmIl8ZfM/W0tK/7B
 jZsuIOi5Pw3b5CQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 13:15:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19061

Define a new run_git_diff() function that can be used to print diffs
between two paths (files or directories), or show a diff in a Git
repository. This function also uses color_enabled() to force showing
color or not in the subprocess. Replace the different calls of `diff`
and `git diff` by this helper function.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 9b0ecc8d0e4..e456aa93bf3 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -69,6 +69,39 @@ def print_configs(prompt: str, choices: list[str], descriptions: list[str] = [])
         msg += f" {descriptions[n]}"
         logger.plain(msg)
 
+def run_git_diff(revision: str = "", path1: str = "", path2: str = "", repo_path: str = "") -> str:
+    """
+    Run git diff from either the current working directory, or in the path
+    specified by repo_path.
+    Then, run git diff with either:
+    - no argument,
+    - or a revision,
+    - or two files / two directories.
+    """
+    assert not (revision and (path1 or path2)), \
+        "run_git_diff can only be called with a revision or two paths, not both"
+    assert not (path1 and not path2), \
+        "run_git_diff only received one path, two expected"
+
+    path = f"-C {repo_path}" if repo_path else ""
+    color = "--color=always" if color_enabled() else "--color=never"
+    git_cmd = f"git {path} diff {color}"
+    if revision:
+        git_cmd += f" {revision}"
+    elif path1:
+        git_cmd += f" {path1} {path2}"
+
+    diff = ""
+    try:
+        diff = bb.process.run(f"{git_cmd}")[0].strip()
+    except bb.process.ExecutionError as e:
+        if e.exitcode == 1:
+            diff = e.stdout
+        else:
+            raise e
+
+    return diff
+
 # If bitbake is from a release tarball or somewhere like pypi where
 # updates may not be straightforward, prefer to use the git repo as the
 # default registry
@@ -202,7 +235,7 @@ be preserved in a backup directory.""".format(r_name, r_path))
         status = bb.process.run('git -C {} status --porcelain'.format(r_path))[0]
         if status:
             return True
-        diff = bb.process.run('git -C {} diff {}'.format(r_path, rev))[0]
+        diff = run_git_diff(revision=rev, repo_path=r_path)
         if diff:
             return True
         return False
@@ -728,7 +761,9 @@ def init_config(top_dir, settings, args):
 
 def get_diff(file1, file2):
     try:
-        bb.process.run('diff -uNr {} {}'.format(file1, file2))
+        bb.process.run('diff --color={} -uNr {} {}'.format("always" if BBSETUP_COLOR else "never",
+                                                           file1,
+                                                           file2))
     except bb.process.ExecutionError as e:
         if e.exitcode == 1:
             return e.stdout
@@ -786,7 +821,7 @@ def build_status(top_dir, settings, args, d, update=False):
     new_upstream_config = obtain_config(top_dir, registry, args, source_overrides, d)
 
     write_upstream_config(confdir, new_upstream_config)
-    config_diff = bb.process.run('git -C {} diff'.format(confdir))[0]
+    config_diff = run_git_diff(repo_path=confdir)
 
     if config_diff:
         logger.plain('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))

-- 
2.52.0


