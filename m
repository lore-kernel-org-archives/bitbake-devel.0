Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8687CCD8C83
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 22:12:53 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5826.1780697564771390728
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2026 15:12:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=FSIMa5PJ;
 spf=pass (domain: smile.fr, ip: 209.85.128.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b64c8311so27369205e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 15:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1780697563; x=1781302363; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60g9egT3/DS+InHaazxkLVGr0N3CVnZgWUMKI05kvow=;
        b=FSIMa5PJqa8udpqeLB+QObpPTzvKL411aTq6vXJejyh2QlIA8QOEpevwMJjW2YfGhJ
         eMEH+TboEKSPpEpkVF4a1yxE9Xt9rvrwY7J8SzXsvTBG3/lmZVam0F6RyF7YqfVBxDrP
         dMVYwOF73DU3C2P1ZBmzG8I8CU/0g7tL98DIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780697563; x=1781302363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=60g9egT3/DS+InHaazxkLVGr0N3CVnZgWUMKI05kvow=;
        b=ge2J+bqtHptihM/Bh8aWNSzPP65QLt/9EHmpP2e7/L5yIEQXNy9lFg0vudhootZy0H
         w+okYWYZBoN6tb4X2zHcywwNZHINvprcNsxArsUSqs4Kkts9Gj4Em2nVqs1ZY8eG/GQX
         qkJquaiocjt0ficUxpCKxLs9lck4BLusbVITi686nrYBv/i+pNa1IxvHaIPekNMrX6/6
         kablfx2wu/2GCLWn8K5MhdtUef3PoD2kzh2LaGSHlzz3i5qx6v0UkTRLAadv6kcnNWaG
         f+3gvNvOSS0NDOSuSMPTaI+ZmiCHU7erL9t10DB+5s6glpIJhMm6OWH4Pe2oERwC76ba
         iY3Q==
X-Gm-Message-State: AOJu0YwgjeiqH5rgsZwg3rClMQiXPpxVD2gQXVuUxIiL5hykg9HkTR2g
	WoiuI1JpyT8YhdmwwSZJin5SFS9Zx6QgZ1ae+vY4v0mhmCo6lEDHAntdoa3wyrlnLV4ZYRkywjx
	UJDPC
X-Gm-Gg: Acq92OEOLA7+9oFDa/4+kn9PNCxtziFVH60WPxQW0wCEUnnCzV58d0J7l0L5gZlTE5E
	G+sa4lk/dSjSdHCz3MmnVBZ1pHWmjBcwgbLoNaKF7YXDKFQlSobaJsa3vjKi+2PilalFtSFcrQp
	2uUmo6SfLTppApQz/r9yrZXxFfV2YQtqtCHCyVqKYs+lk20wYya5aosfSfVFSjCCUmw1JXojkT6
	PwM/bxJxgaU2hw0gmLnVGQhCk2cKtn8C3yLpvfB935YZmYANixdnY7URL1xOgYqW1rnENW+rUYa
	HuC0RcGwppxthkBmQOYDCMGtSoCtZxD1fQ1L1praQ6QR8peX5DomIwHkbfCZPxcaPxhOPqrJawK
	BiroLcrvEWHEU0L99czAPy3lJFMVye/7tq2Tua4TFlbmiYPRapnt9ue869ZoVczCzB3BHiZn7Oe
	yxQ13bY13z3/0XIKknQhCoOdILMSZ9LDJmXHTZbe1olPxm3YSwWCFBGoXwKj6jO5vmuhKv3Q0Oe
	YgvMfRW7slL8qcmyv6b47ztptJoxMmmIG3fNd0=
X-Received: by 2002:a5d:5270:0:b0:446:96b1:f53 with SMTP id ffacd0b85a97d-4603051261dmr6909114f8f.26.1780697563096;
        Fri, 05 Jun 2026 15:12:43 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00b3e1ccc1be2b2798.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:b3e1:ccc1:be2b:2798])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm30770393f8f.6.2026.06.05.15.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:12:42 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][scarthgap][2.8][PATCH 3/4] fetch2/git: quote shallow extra ref arguments
Date: Sat,  6 Jun 2026 00:12:27 +0200
Message-ID: <6d3f8bd4ddc955b49eaa124e0724ea589da30646.1780697470.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780697470.git.yoann.congal@smile.fr>
References: <cover.1780697470.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 22:12:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19624

From: Anders Heimer <anders.heimer@est.tech>

BB_GIT_SHALLOW_EXTRA_REFS can include wildcard entries. Matching refs
advertised by the remote are later passed to git fetch and update-ref
while creating shallow tarballs.

Quote the generated command arguments and pass the fetched ref after --
so shell metacharacters and option-like ref names are not interpreted as
command syntax or git fetch options.

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit e9a06f79d9ec767c9d95470be78b006d6fd0d59c)
[YC: Only the quote part of the master patch applies.
The "--" part does not. This part is handled by bin/git-make-shallow
which only pass arguments to git rev-list and rev-parse through arrays]
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/git.py  |  2 +-
 lib/bb/tests/fetch.py | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index a3b1a2ada..d8e31284e 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -602,7 +602,7 @@ class Git(FetchMethod):
         shallow_cmd = [self.make_shallow_path, '-s']
         for b in shallow_branches:
             shallow_cmd.append('-r')
-            shallow_cmd.append(b)
+            shallow_cmd.append(shlex.quote(b))
         shallow_cmd.extend(shallow_revisions)
         runfetchcmd(subprocess.list2cmdline(shallow_cmd), d, workdir=dest)
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 37e4eb9f4..2d95ef87d 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2206,6 +2206,36 @@ class GitShallowTest(FetcherTest):
         self.assertRefs(['master', 'origin/master', 'v1.0'])
         self.assertRevCount(1)
 
+    def test_shallow_extra_refs_wildcard_shell_quoted(self):
+        self.add_empty_file('a')
+        marker = os.path.join(self.tempdir, 'ref-command-marker')
+        ref = 'refs/tags/poc;touch${IFS}%s' % marker
+        self.git(['update-ref', ref, 'HEAD'], cwd=self.srcdir)
+
+        self.d.setVar('BB_GIT_SHALLOW_EXTRA_REFS', 'refs/tags/*')
+        self.fetch_shallow()
+
+        self.assertFalse(os.path.exists(marker))
+        self.assertRefs(['master', 'origin/master', ref])
+
+    def test_shallow_extra_refs_wildcard_fetch_options(self):
+        self.add_empty_file('a')
+        marker = os.path.join(self.tempdir, 'ref-option-marker')
+        helper = os.path.join(self.tempdir, 'upload-pack-helper')
+        with open(helper, 'w') as f:
+            f.write('#!/bin/sh\n')
+            f.write('touch "%s"\n' % marker)
+            f.write('exec git-upload-pack "$@"\n')
+        os.chmod(helper, 0o755)
+        ref = 'refs/tags/--upload-pack=%s' % helper
+        self.git(['update-ref', ref, 'HEAD'], cwd=self.srcdir)
+
+        self.d.setVar('BB_GIT_SHALLOW_EXTRA_REFS', 'refs/tags/*')
+        self.fetch_shallow()
+
+        self.assertFalse(os.path.exists(marker))
+        self.assertRefs(['master', 'origin/master', ref])
+
     def test_shallow_missing_extra_refs(self):
         self.add_empty_file('a')
         self.add_empty_file('b')

