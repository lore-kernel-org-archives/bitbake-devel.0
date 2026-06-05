Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A699CD6E7C
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 22:09:33 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5925.1780697363458499794
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2026 15:09:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=GUmeG7qQ;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b64c8311so27351085e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 15:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1780697362; x=1781302162; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAXvcSdq55gnr4v2kgz/3OKXZwUTXkrQgLP1HfsohD4=;
        b=GUmeG7qQOZwmZeeg8GXzbqa7j9d1GdI6fu0Ov7PBo4trJuU8OcSAQRxlF1Y0dZ/oxk
         X4YnT8kbu6tlfmpRVTTEpjMWebCjSp0tqidDtWk8UQs4cqRvYcOP8Yp266K2fK7iHYD+
         Y4+v7oSrMSwbpyNRKvVyT7p3pk3+9PQ2sXGRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780697362; x=1781302162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HAXvcSdq55gnr4v2kgz/3OKXZwUTXkrQgLP1HfsohD4=;
        b=NDLizYDgZr9AWnMOVRLT0RL0nwhaG7u/XRlY9cZf8iT5gxDWKIRuI4Vl8ZLtJfWsbA
         2OS6j9Ze2u7++JLbE3RrZ18P6IDNEqlHFl1Zp05ntnZLnuYpRsqPCvqGwrlmAULDKys3
         Qcesm5ClfZgjH5eG2Deo6O9lTvvn8+GxqHi0NpBJbheT6OCKqygT6tP9PGNQul9WXCYm
         mgjFVCO7c4j6unZwshNV5E4oCZ0j/DFcUKhlwMytNIBrVtr7AKcccLLORUdXrAQ/CChB
         CtPPwMu7v5+ie6h310FK27pbBOJ1gvaEt99iNkFJukLSeDy0vbP/vNMpYSkngH8edM+c
         r58A==
X-Gm-Message-State: AOJu0YwUO0etvYEA8BY1NaQWfuVrZ0q7sc2S+7VxCzF7w5aXAHUw55JT
	Qd64j4SSLoUME/FY+CMSLQrmm7mRm1RFHz5Inp+3Pfe5umcIpkiYbesowJ4D2uFcknDP3b7eSXJ
	GRF5p
X-Gm-Gg: Acq92OGc94Tyk/kCeYdZ+vD15UAYxhrv/YjJifELtSIon+q42jdZeNGf8uQvv4Wh3xX
	DKfpoegRW2FOLFp0N4KDz/E3vczn2oj1Kgv4dU7AHLH24jHtD6mISXV/7rGXyyQv/v051oxyK2d
	RWfzll0ZhOOMn/jEJhFp8VvIBWRNh9UF7AkMQCOt1vVRIFIq7NczixB5uj3XQjg3hDE72ePsrxS
	RCzienCZIMbPM7NUm61iLHUXsfehocv8ElCkR+4qPPjTVJAdlbLfOdkkpHOw9zsbgXuqaDGX+2i
	HwGehy7QLCQNp9Y8kb1eYr7s5fdA9xKJIkbSPTiUax5ZfFcyz8F+9ZP+vnYAu6v5hm3NBuY/Xda
	neV6a6iJ0mLSywARrTqeipNq9+UWDefU5mDUnnQGMBZ2NogxBgM5vae072khXjKX6YOy3V83mUW
	QdsJT/n+YhtrUS3I0xdu0BwqYAjNchkWBOXI2kt4OXYyVczY8A4kjTgQYia45voNt5Gbm8t2aCj
	eiSqB5pKKpqVHbD0ULpNazf03U0YunHFu1YSKk=
X-Received: by 2002:a05:600c:6384:b0:490:acb8:1490 with SMTP id 5b1f17b1804b1-490c2591e5cmr88638005e9.4.1780697361893;
        Fri, 05 Jun 2026 15:09:21 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00b3e1ccc1be2b2798.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:b3e1:ccc1:be2b:2798])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd502sm182367015e9.11.2026.06.05.15.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:09:21 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][wrynose][2.18][PATCH 3/4] fetch2/git: quote shallow extra ref arguments
Date: Sat,  6 Jun 2026 00:08:57 +0200
Message-ID: <fbef06952456cd250c4ada39ae3893e1e9e003e1.1780696925.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780696925.git.yoann.congal@smile.fr>
References: <cover.1780696925.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 22:09:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19619

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
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/git.py  |  6 ++++--
 lib/bb/tests/fetch.py | 30 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index ecf4340b1..5134ec04c 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -645,9 +645,11 @@ class Git(FetchMethod):
 
         for ref in extra_refs:
             ref_fetch = ref.replace('refs/heads/', '').replace('refs/remotes/origin/', '').replace('refs/tags/', '')
-            runfetchcmd("%s fetch origin --depth 1 %s" % (ud.basecmd, ref_fetch), d, workdir=dest)
+            runfetchcmd("%s fetch origin --depth 1 -- %s" %
+                        (ud.basecmd, shlex.quote(ref_fetch)), d, workdir=dest)
             revision = runfetchcmd("%s rev-parse FETCH_HEAD" % ud.basecmd, d, workdir=dest)
-            runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision), d, workdir=dest)
+            runfetchcmd("%s update-ref %s %s" %
+                        (ud.basecmd, shlex.quote(ref), revision), d, workdir=dest)
 
         # The url is local ud.clonedir, set it to upstream one
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=dest)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 589a4655e..cc133c1f5 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2215,6 +2215,36 @@ class GitShallowTest(FetcherTest):
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

