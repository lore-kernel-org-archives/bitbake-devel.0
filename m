Return-Path: <Jhonata.poma@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D23CD37AF
	for <webhook@archiver.kernel.org>; Sun, 10 May 2026 12:00:29 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28663.1778414426959941702
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 May 2026 05:00:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=CdaRn3Q0;
 spf=pass (domain: gmail.com, ip: 209.85.218.53, mailfrom: jhonata.poma@gmail.com)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8f97c626aaso582541466b.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 10 May 2026 05:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778414425; x=1779019225; darn=lists.openembedded.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=suXeQDpYO3CgWHBVGXWVIBm92ZIV0aMXhWgAC2mSL+s=;
        b=CdaRn3Q0WY2JrXvMZIuJPtZbaLBkd9JIiEbjkJCbyLKM+DPEET0JM6ecf/mvj6vGa1
         HaYuQUmL5CyiGEUQKymD723ksf3lUUK5LESH32ez+o9OqJe24t2811UITOxzkLIoKi10
         4QOxkuLTcjrtLN1VH09/Go7kGBuNJT6al9LxMtUMX7KrJKXVYMc9hb7UIr2D3+/LH1Vr
         GI04xdyII2E6YsY+ddjJRR/fVF5I0ADAn3T0IVgs+dT2HbA4L3Q2W0xfeetL/M2wir06
         1Jz1QUBc3CGETnaNBPMax4MBjLPLMYOJ/QNvfF0IYxNcC66bRsG786Pb+TG0FsVIbU1q
         Xnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778414425; x=1779019225;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suXeQDpYO3CgWHBVGXWVIBm92ZIV0aMXhWgAC2mSL+s=;
        b=lh1RgVIsQ1b1NT+dd8HJy+M+90PgLDHjKBmxAnAw3MINFcPzPq2E9sb0GRS41Zb+tT
         lQhRVJ14vUf022rITS/bhIvPNmWNhv8Ywx4VMrfXQVdPdsF1ZPVI06HrD6sIlUt00+yk
         gIOhW0P5C0bd5WN+QxeKk93Yp29wVnzL8O/hebwwzUPfvk+O7bglcmDTOZJ7joETn3Qz
         55i/JIRB5dbnNfjn4sfszWfpXcb3izM8X7+W1m3iYNa1FyaD8oxqpXeqU9Fy9jP2F56o
         BSfY6HZYGmqHifMiDP7DBbdURH89zXZQ6RVeIJNbQc20HiEsBMMExN1RIiuJntIIFwRR
         E61Q==
X-Gm-Message-State: AOJu0YxRP5YXs5XfP+1zo90SKZsIgfjhdmo89kKiOfijeYGmu85s5kAZ
	wBrBknMdwY1HiFB1Ya98jq2pU3q4tOqBBqKIi2I2r3VUe4NyixZmYgUD
X-Gm-Gg: Acq92OHX4oi3iEiGfvj9zW9uWYBJZgUPWdLAW40XYtKWn9Qz7/oGDHhIW6gI6auacGs
	Std2y+RWox7VMtHqCiBYrqqVaOLf5uO7GSPYLCzERaNwZVBKB8n1We7/0eBLk9z/Xcg5Gqrz3lv
	I22tM5gUQa+650PPgl5T41hTLperoAKCeA0rmCOfEjI+zOpwY8A6aS2ZkaCjUwA1QCLTNYB31U1
	EKwMx2VAARtClrBgpJtVwivgJn4dqEXei+VN4dcOFpnUzInX221TCnn+hFFg0CI5C8gtUwsySjC
	CFI50hlQYgwvqTCS4afiiz2YiFD+esi3ce0gexq1iN0rGzLVF2bnI8Q77gZG3/I4cDQAwQuS3u1
	QOLOIaVctJILlU/Ue1imVOAbhinDnCw6pZg/FYmVB3srhtd35LnKl6OOdcK4pD3CgRnCzyFhHx6
	PalrxNXfdq/82BMIgwp+PKEylwZngJXfd6L2Pmq6eoyGFiw1NVcb50qh7Xfz5c418jPTCzVRFnk
	n3+8GtpMmZMKsX6k5TR6jPQBQ==
X-Received: by 2002:a17:907:3cc4:b0:baa:65b:fe43 with SMTP id a640c23a62f3a-bcaacd36a29mr549077066b.38.1778414424647;
        Sun, 10 May 2026 05:00:24 -0700 (PDT)
Received: from [127.0.0.2] ([89.150.155.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcb600e26d9sm293556266b.17.2026.05.10.05.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 05:00:24 -0700 (PDT)
From: Jhonata Poma-Hansen <jhonata.poma@gmail.com>
Date: Sun, 10 May 2026 14:00:21 +0200
Subject: [PATCH] fetch2: honour PATH placeholder on cross-scheme PREMIRROR
 rewrites
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-b4-yocto-14156-v1-1-b31433816463@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFRzAGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0MD3SQT3cr85JJ8XUMTQ1MzXQMTE3MTSxMLIxNzIyWgpoKi1LTMCrC
 B0bG1tQC2Ac+9YAAAAA==
X-Change-ID: 20260510-b4-yocto-14156-044749482472
To: bitbake-devel@lists.openembedded.org
Cc: richard.purdie@linuxfoundation.org, niqingliang2003@gmail.com, 
 alex.kanavin@gmail.com, Jhonata Poma-Hansen <jhonata.poma@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7164;
 i=jhonata.poma@gmail.com; h=from:subject:message-id;
 bh=ChsP0QALuzG+jo0VlCLDgmvry2+0t4yWoc++hXEkiD0=;
 b=owGbwMvMwCX21S6Y7aK9oS7jabUkhiyG4nDPa1+6RdTlHxn/2VZQMpljV5FFbQFb6KprfjMXf
 z5pblzYUcrCIMbFICumyOJz9nEPt+LHHf8f7rgMM4eVCWQIAxenAEyE24Xhf9XBaQtUyr6/P6LX
 J1bv9Lxxir2FMHv8h31sm/lUT8Yq8zAyvLvxbBqLj1XOUdY8qU9/FfMM3m78/Taw4ADTa9OFJg5
 NfAA=
X-Developer-Key: i=jhonata.poma@gmail.com; a=openpgp;
 fpr=4CCDE38C0B21F1B8FFE1B8D3F53E5306D13F312D
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 May 2026 12:00:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19488

When a PREMIRROR rule rewrites a fetch URL to a different scheme
(typically gitsm:// -> git:// for an on-disk checkout), uri_replace()
unconditionally treats the rewrite as a mirrortarball mapping: it
substitutes the source URL's path basename with the canonical mirror
tarball name (git2_<host>.<repo>.tar.gz) and drops the source URL
parameters. That is correct for tarball mirrors but breaks the case
where the user redirects to a checkout location using HOST/PATH
placeholders.

niqingliang2003 reported this on YOCTO #14156 (2025-07-18) with a
PREMIRROR of:

  gitsm://.*/.*  git:///mnt/datum/repositories/HOST/PATH;protocol=file

For the input:

  gitsm://github.com/libjxl/libjxl.git;protocol=https;nobranch=1

the rewrite produces:

  git:///mnt/datum/repositories/github.com/libjxl/git2_github.com.libjxl.libjxl.git.tar.gz;protocol=file

instead of the user-intended:

  git:///mnt/datum/repositories/github.com/libjxl/libjxl.git;protocol=file;nobranch=1

The mirror fetch then fails because the resulting URL has no nobranch
or branch parameter and no actual tarball exists at the path.

When the replacement template references the PATH placeholder, the
user has explicitly asked for the source path to appear in the
rewritten URL. In that case, skip the mirrortarball-basename override
and carry the source URL parameters through. Existing PREMIRROR rules
that do not use PATH (the canonical tarball-mirror layout) continue
to work unchanged.

A new selftest, MirrorUriTest.test_gitsm_premirror_path_placeholder,
captures the exact niqingliang2003 repro shape so a regression in
this area becomes a unit-level failure rather than a runtime mirror
fetch error.

The dict-driven test_urireplace and the broader
GitDownloadDirectoryNamingTest / TarballNamingTest /
GitShallowTarballNamingTest / CleanTarballTest / FetcherLocalTest /
FetcherNoNetworkTest suites all stay green with this change (42 of
42 relevant fetch tests pass on master + this patch; network-only
tests not run).

Note for reviewers: a wider bitbake-selftest run shows 4 pre-existing
GitShallowTest errors triggered by local git environment
(commit.gpgsign + empty editor config); they reproduce on the parent
commit and are not related to this change.

Signed-off-by: Jhonata Poma-Hansen <jhonata.poma@gmail.com>
---
 lib/bb/fetch2/__init__.py | 22 +++++++++++++++++++++-
 lib/bb/tests/fetch.py     | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f7d5dfe9..a697daa5 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -485,6 +485,10 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
             # User/password in the replacement is just a straight replacement
             result_decoded[loc] = uri_replace_decoded[loc]
         elif (re.match(regexp, uri_decoded[loc])):
+            # Snapshot the replacement template before placeholder substitution
+            # so we can later detect whether the user explicitly asked for the
+            # source PATH to be preserved (YOCTO #14156).
+            replace_template = uri_replace_decoded[loc] if loc == 2 else None
             if not uri_replace_decoded[loc]:
                 result_decoded[loc] = ""
             else:
@@ -495,7 +499,23 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
             if loc == 2:
                 # Handle path manipulations
                 basename = None
-                if uri_decoded[0] != uri_replace_decoded[0] and mirrortarball:
+                # If the replacement template references the PATH placeholder
+                # the user has explicitly asked for the source path to be
+                # preserved in the rewritten URL (e.g. a cross-scheme PREMIRROR
+                # redirect to a checkout location, not a tarball mirror). In
+                # that case, suppress the mirrortarball-basename override and
+                # carry the source URL parameters through (YOCTO #14156).
+                # The substring check is on the pre-substitution template, so a
+                # source URL whose path coincidentally contains "PATH" will not
+                # trigger a false positive. Cross-scheme rewrites that rely on
+                # an absolute literal target path (no PATH placeholder) still
+                # take the mirrortarball-basename path; widening to those is
+                # left for a follow-up if a real-world rule turns up.
+                user_path_explicit = (replace_template is not None
+                                      and "PATH" in replace_template)
+                if (uri_decoded[0] != uri_replace_decoded[0]
+                        and mirrortarball
+                        and not user_path_explicit):
                     # If the source and destination url types differ, must be a mirrortarball mapping
                     basename = os.path.basename(mirrortarball)
                     # Kill parameters, they make no sense for mirror tarballs
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 86dd9299..66cb2d97 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -566,6 +566,27 @@ class MirrorUriTest(FetcherTest):
                                 'https://bbbb/B/B/B/bitbake/bitbake-1.0.tar.gz',
                                 'http://aaaa/A/A/A/B/B/bitbake/bitbake-1.0.tar.gz'])
 
+    def test_gitsm_premirror_path_placeholder(self):
+        # YOCTO #14156: when a PREMIRROR rewrites a gitsm:// URL to a
+        # different scheme but uses the HOST/PATH placeholders to redirect
+        # to a checkout location (not a tarball), the rewritten URL must
+        # land on the user-specified checkout path, not on the canonical
+        # mirror-tarball filename. niqingliang2003 reported (2025-07-18) a
+        # case where bitbake produced
+        # 'git:///mnt/datum/repositories/github.com/libjxl/git2_github.com.libjxl.libjxl.git.tar.gz'
+        # for a PREMIRROR rule of
+        # 'gitsm://.*/.* git:///mnt/datum/repositories/HOST/PATH;protocol=file',
+        # which is unfetchable.
+        src = "gitsm://github.com/libjxl/libjxl.git;protocol=https;nobranch=1;rev=" + ("1" * 40)
+        find = "gitsm://.*/.*"
+        replace = "git:///mnt/datum/repositories/HOST/PATH;protocol=file"
+        expected = "git:///mnt/datum/repositories/github.com/libjxl/libjxl.git;protocol=file;nobranch=1;rev=" + ("1" * 40)
+        ud = bb.fetch.FetchData(src, self.d)
+        ud.setup_localpath(self.d)
+        mirrors = bb.fetch2.mirror_from_string("%s %s" % (find, replace))
+        newuris, _ = bb.fetch2.build_mirroruris(ud, mirrors, self.d)
+        self.assertEqual([expected], newuris)
+
 
 class GitDownloadDirectoryNamingTest(FetcherTest):
     def setUp(self):

---
base-commit: df3295f016a74a1414b8af5adb9f2a3967c365b6
change-id: 20260510-b4-yocto-14156-044749482472

Best regards,
-- 
Jhonata Poma-Hansen <jhonata.poma@gmail.com>


