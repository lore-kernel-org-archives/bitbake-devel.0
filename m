Return-Path: <sivakumar.bs@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E27C43458
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 11:06:30 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90887.1783076781627664520
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Jul 2026 04:06:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gdJNndCl;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: sivakumar.bs@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-381b831d535so54430a91.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Jul 2026 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076781; x=1783681581; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4lAMA9Tc5RWVJSAKyhvqmRvwIPowHLD6otP3IETIRX0=;
        b=gdJNndCl5yItIv0cVcOOjxwHzGCy/pEQLv6DK1axSbebKucIje5KWCPRw5Mzu5OLi5
         BhGhVP0M2oAoWmdwY28TLrqADp69GMJEUrVISH3N0UvPbI9K76gamInBikZUY1kCZ/OB
         SqcIXfY+i/QrulEHLWq5fTcWe6OHKS49HcrlYaFlcLzEwpEymyKpAvbzRQnXiyi2Jc43
         358hYVYHrNwVFQ6E5u5QgIVmeOlyAjTxzfqB1LHe1MO3a8YGGfkr/n1fLjIQQHvC0Q5L
         baflJTMMaJ3P4lJ1UHB6g+6UBa3y/6yFQy3NP8DglYCktLAF8+WneIpWBMTerlavseHm
         qo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076781; x=1783681581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4lAMA9Tc5RWVJSAKyhvqmRvwIPowHLD6otP3IETIRX0=;
        b=fIgu7nih3feDr2l7VeOPm514SeNROulFTjqJ5F6cYrJvRN+qzTNA3j4RwF/Kd4xcls
         eF6zVTEUN1cOT3e4YlPldLIH9e6opYx7FsrVfUcpU34kDdl3TKSEER30DsUm+ALz0Xxv
         S0g7sTQPoagUUYLWdWayOxXtzBc/6WbsK/1JKjIyegMyJXUaZS22edJMdOlWLNqMOL3v
         W0vk6KHnC2aaKeViy5B/XPfMuD6t0bA/30T+EhOUDZBEAIaPnps8IEYEMwmvn2DTn9Wn
         IkrrVQXWQMiAiDlhw8C1wssnqFuBFcFMS1bKXamsNwVvW9W/fDkLZULepk7BBS/xcRH+
         6hQQ==
X-Gm-Message-State: AOJu0YwDacrPkmp0HO7Y/DX/uwKyeWkfiN1HhBGtyQJn4Z/EhBspJ7Y0
	Uuvy7vo+OPfhr69YHCZm4yFl6s69HVn4k5iYrUOzZedp9SlUZbw+MkOX+zraYmViUwZb/g==
X-Gm-Gg: AfdE7cnRxwSgRsZ60eOXtR8dk5w4B1BkE3oDBzYeC4cTSrSe+yrKrYBnS4NIykFj9d5
	u9ftrCE7c/IcA2o30jNrwfj1kKySCbhr1Toy9ZKIyVQGCv13cSXFE2aX0jE+Yl/9Dys6JXlCIZS
	7AEqgSSbuhHKiFaGT7u0KxKTyVUyVBYhAFVEMXJwOcsn3I7cbWKFF/c0wDYHw3k1iXSTKZUl0cm
	A3E0eGxjKhiLsA7ChjF8ZBfz414T4VKKkyeC3DkJxjIOxUjUeE6sim3+P5eudt7ROmlCnFXG94o
	3W+gw6Qu4bRvEoF1hVVXyfM9hBWqOOV1w7hqgoRJzvi3wSOZG1m1o99y4VjQT9UdL8QOjtNoklD
	4Ih2sSpC54I6/KibaZrrSrbNtz8VGs7oi8TsuEeTiVXaSZPys7Jq4VOcnQu8GWd0UEgFjrr8GE6
	Mor/2Om9KHEDn2r5umj82CjYl7xdlzwSHnsvZLx/wsKerJVPrVX/o/mG4cXg==
X-Received: by 2002:a17:90b:2f83:b0:381:528a:808a with SMTP id 98e67ed59e1d1-381528a8397mr1227175a91.27.1783076780845;
        Fri, 03 Jul 2026 04:06:20 -0700 (PDT)
Received: from naduvan.timesys.com ([117.98.163.108])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd2350sm21505882eec.23.2026.07.03.04.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:06:20 -0700 (PDT)
From: Siva Balasubramanian <sivakumar.bs@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: randy.macleod@windriver.com,
	Siva Balasubramanian <sivakumar.bs@gmail.com>,
	Oliver Feilner <oliver.feilner@yaskawa.eu>
Subject: [bitbake-devel][PATCH] fetch2: give every FetchData a default unpack_tracer
Date: Fri,  3 Jul 2026 16:36:12 +0530
Message-Id: <20260703110612.294043-1-sivakumar.bs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Jul 2026 11:06:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19816

Fetch() sets an unpack_tracer attribute on the FetchData objects it
manages, but the per-mirror FetchData objects created in
build_mirroruris() are constructed directly and never get one. When a
mirror is used for a git recipe that needs Git LFS, git.py's download()
performs a checkout (via Git.unpack()) on the mirror's FetchData to
materialise the LFS objects, and that unpack path dereferences
ud.unpack_tracer, failing with:

    AttributeError: 'FetchData' object has no attribute 'unpack_tracer'

so PREMIRRORS/MIRRORS fetching is broken for git-lfs sources.

Fix this at the source by initialising unpack_tracer to a
DummyUnpackTracer in FetchData.__init__(), so the attribute always
exists. Fetch() still overrides it with the real (possibly
user-configured via BB_UNPACK_TRACER_CLASS) tracer for the URLs it
manages; the mirror FetchData objects only perform an internal,
throwaway checkout that should not be traced anyway.

Add a MirrorUriTest regression test asserting the mirror FetchData
objects carry an unpack_tracer.

Reported-by: Oliver Feilner <oliver.feilner@yaskawa.eu>

[YOCTO #15948]

Signed-off-by: Siva Balasubramanian <sivakumar.bs@gmail.com>
---
 lib/bb/fetch2/__init__.py |  6 ++++++
 lib/bb/tests/fetch.py     | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index ce7456b60..28d3d50d4 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1325,6 +1325,12 @@ class FetchData(object):
         self.mirrortarballs = []
         self.basename = None
         self.basepath = None
+        # Default to a no-op tracer. Fetch() replaces this with the real
+        # (possibly user-configured) unpack tracer for the URLs it manages,
+        # but FetchData objects created elsewhere (e.g. the per-mirror ones
+        # built in build_mirroruris()) must still have the attribute so that
+        # fetcher unpack methods invoked on them do not raise AttributeError.
+        self.unpack_tracer = DummyUnpackTracer()
         (self.type, self.host, self.path, self.user, self.pswd, self.parm) = decodeurl(d.expand(url))
         self.date = self.getSRCDate(d)
         self.url = url
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index ebc80aa8c..f9c7e3116 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -530,6 +530,17 @@ class MirrorUriTest(FetcherTest):
         uris, uds = bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
         self.assertEqual(uris, ['file:///somepath/downloads/bitbake-1.0.tar.gz', 'file:///someotherpath/downloads/bitbake-1.0.tar.gz'])
 
+    def test_mirror_uds_have_unpack_tracer(self):
+        # The per-mirror FetchData objects must carry an unpack_tracer, otherwise
+        # fetcher unpack methods (e.g. the git-lfs checkout done for a mirror)
+        # raise AttributeError. See YOCTO #15948.
+        fetcher = bb.fetch.FetchData("http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
+        mirrors = bb.fetch2.mirror_from_string(self.mirrorvar)
+        uris, uds = bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
+        self.assertTrue(uds)
+        for ud in uds:
+            self.assertTrue(hasattr(ud, "unpack_tracer"))
+
     def test_urilist2(self):
         # Catch https:// -> files:// bug
         fetcher = bb.fetch.FetchData("https://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
-- 
2.34.1


