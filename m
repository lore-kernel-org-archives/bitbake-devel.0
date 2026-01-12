Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54964C9EC8C
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 13:04:33 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32175.1768223070454586314
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Jan 2026 05:04:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KhgEOIRT;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so2943512f8f.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Jan 2026 05:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768223069; x=1768827869; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hdqtuWOZPocisiw0ivyfpEO7qmiwAmXp/Bet1HYBRpw=;
        b=KhgEOIRTwmwjGowJplix02H7kkZm4Hnx/J1pa2n+EMfK5Dt3Jmrq0jYlRjKYBCr0v6
         kqXTAk7DeNqJTyWbqVDGLtjPzQMBSbC9e22ICvshDkWhx/ZRtzMOywiaeF/oJF0CvkEM
         4rLsIhf19fFizeBClVDppj2LV9i6Ruw0RVFXknAhpasnv7mARn4us9hi1a5nXWEhnjO6
         1ZF7iScwAUvrp+qQdhaB1MRAW6h+or3BMvShXFL5zHnH9Vufu143F6ifOzCAiPTdo51w
         zWDSoVtilgQEXUeVEEVtBWEd4eqgSc85MCoZrfDkGgVVl1axEZlqGoS5Ootr84XPJJgW
         ttbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768223069; x=1768827869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdqtuWOZPocisiw0ivyfpEO7qmiwAmXp/Bet1HYBRpw=;
        b=DDFda+RZjqPd09Uet+Mz6EAAI25SwihipPaSZR9comFJ+g5GfcYDOQzxGGdc9D1E4L
         pMUv+eCFGMhuhPXYNTSL1Mrd+Q4W02kTl2PRT8dS3PYIvJdeKMz7BsV945YXE94ajStB
         KwY+167S03ic28LyZeyJYd1EpRugSUfR5FbpH6IK5vczCRpdM/WjIMPnxyfaVPp4gRH1
         4oj9eko5LZq4yPKPSm1niHAhbRkzDibNRlrNZ51jEKk8rfuiGM5S9/gbPHjmQMvyBNzn
         Bf8omXqD51r6LXOgnnNfMNbQug2U+5Xk6nzpUUoXWYW/XHD3zc+pWA2Ci1HTahiSwNa3
         crZw==
X-Gm-Message-State: AOJu0YyMM3kv6aD2Iin64mVJuqCouVjkY0xvgP2xepVoBLOAfKLc7VMl
	HcPiEgwSQ2hLvrA3eoKeFI8JRMxbeeONafVQ8EMJ2AZjyNkRG+XSPVcLJZ7iROaB
X-Gm-Gg: AY/fxX5APGwm4bopocTfApyLOWLGl0hQ/f2blnu2/EMvA2kV9FG65B2co+WrBV3bndo
	Qmywk5cXir/VTMlfar3qB4nh7TwjjcI5WKeOiGjSXNf0tc97BZlnJpXbrFY9VpvO/FQ+g46gjeO
	R9LpySeRNyjKKTwPprr3qpnG4RdFYz/593HXoVc3z9oITbRTuXhxPKHnkATa+bnFtjRk1u0HwyS
	pekGdnmG4jkhcHccshPcNzXsgQEyUOOqMIzeHG4f+2HqCT/sGUhVJB8/s4/4VLIeNTXLmYvCIDt
	TbhVI2Iwy0MkiDKJHMZWkWbyjUe2WeyH3a9L5SgbP1S3QhQMAlgzgi2tYm5A3WhbE7txpno8hCD
	l6oIjua5mN3zlrD+YTJAHE+sSEYX5/drdz3O256sApemUckJj5k4+ls22dxYtYukmpgana3xV4d
	oT+3rS1wkxDGPPakpVYwOvRxzax/+Yj8xi+vMF8TYAt0QVmRA=
X-Google-Smtp-Source: AGHT+IEnb+WPqsXN6f8eycifsQyjmy5xHu6wFkSW88WzdA3GGgxqJ8Tj+eQv/tlrLgp4iPSO/qDl3A==
X-Received: by 2002:a05:6000:2510:b0:431:342:ad42 with SMTP id ffacd0b85a97d-432c379b6f9mr23598922f8f.44.1768223068663;
        Mon, 12 Jan 2026 05:04:28 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0daa84sm38531371f8f.2.2026.01.12.05.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 05:04:28 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 1/2] cooker: use BB_HASHSERVE_DB_DIR for hash server database location
Date: Mon, 12 Jan 2026 14:04:17 +0100
Message-ID: <20260112130418.3166002-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Jan 2026 13:04:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18732

From: Alexander Kanavin <alex@linutronix.de>

If unset, the existing behavior is preseved.

The use case is sharing the database in bitbake-setup's driven builds
without having to set up/start/stop a common single server shared
between them (this is added to bitbake-setup in the next commit).

Also create the specified directory if it doesn't yet exist.

Add a check that the directory is not on a NFS path, and error out then,
guiding the user to set up a standalone hash equivalency server.

Note: the check runs 'stat' executable with a format string parameter,
ensuring it prints only the filesystem type and nothing else.
Python's standard library does not have a statfs() wrapper,
and using ctypes to call into it would've required delicate,
crash-prone data type definitions, full of magic numbers.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 .../bitbake-user-manual-ref-variables.rst     | 23 +++++++++++++++++++
 lib/bb/cooker.py                              | 11 ++++++++-
 lib/bb/utils.py                               |  8 +++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index af911f306..4b3b10d46 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -475,6 +475,29 @@ overview of their function and contents.
       equivalences that correspond to Share State caches that are
       only available on specific clients.
 
+   :term:`BB_HASHSERVE_DB_DIR`
+      When :term:`BB_HASHSERVE` is set to ``auto``, bitbake will use
+      a private location inside a particular build directory for the sqlite
+      database file that holds hash equivalency data.
+
+      This variable allows using a different path, which can be shared
+      between multiple build directories and bitbake instances
+      that operate on them. This enables using a common ``${SSTATE_DIR}``
+      together with common hash equivalency data for local builds, without having to
+      separately manage a hash equivalency server.
+
+      .. note::
+
+         This variable cannot be set to a NFS mount and bitbake will error out then.
+         The reason is that NFS implementations can have file locking issues, which
+         can cause data loss and corruption when there are multiple writers operating
+         on a file at the same time as explained in https://sqlite.org/faq.html#q5
+
+         If you'd like to share hash equivalency data between multiple computers, you
+         need to set up a hash equivalency server separately and point :term:`BB_HASHSERVE`
+         to it. See https://docs.yoctoproject.org/dev-manual/hashequivserver.html for
+         additional information.
+
    :term:`BB_HASHSERVE_UPSTREAM`
       Specifies an upstream Hash Equivalence server.
 
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index fa7747d64..4b6ba3196 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -328,7 +328,16 @@ class BBCooker:
         if self.data.getVar("BB_HASHSERVE") == "auto":
             # Create a new hash server bound to a unix domain socket
             if not self.hashserv:
-                dbfile = (self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")) + "/hashserv.db"
+                bb_hashserve_db_dir = self.data.getVar("BB_HASHSERVE_DB_DIR")
+                if bb_hashserve_db_dir and utils.is_path_on_nfs(bb_hashserve_db_dir):
+                    bb.fatal("""Hash equivalency database location (set via BB_HASHSERVE_DB_DIR to {})
+cannot be on a NFS mount due to potential NFS locking issues between sqlite clients, per https://sqlite.org/faq.html#q5
+
+If you need to share the database between several computers, set up a permanently running hash equivalency server
+according to https://docs.yoctoproject.org/dev-manual/hashequivserver.html""".format(bb_hashserve_db_dir))
+                dbdir = bb_hashserve_db_dir or self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")
+                os.makedirs(dbdir, exist_ok=True)
+                dbfile = dbdir + "/hashserv.db"
                 upstream = self.data.getVar("BB_HASHSERVE_UPSTREAM") or None
                 if upstream:
                     try:
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 366836bfc..974611bc7 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -2264,3 +2264,11 @@ def lock_timeout_nocheck(lock):
         if l:
             lock.release()
         sigmask(signal.SIG_SETMASK, s)
+
+def is_path_on_nfs(path):
+    """
+    Returns True if ``path`` argument is on a NFS mount.
+    """
+    import bb.process
+    fstype = bb.process.run("stat -f -c %T {}".format(path))[0].strip()
+    return fstype == "nfs"
-- 
2.47.3


