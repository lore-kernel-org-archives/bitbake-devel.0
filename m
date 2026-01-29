Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD98D61009
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 11:52:07 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13020.1769687518443402622
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Jan 2026 03:51:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KmowFp6+;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4807068eacbso7373865e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Jan 2026 03:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769687517; x=1770292317; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hdqtuWOZPocisiw0ivyfpEO7qmiwAmXp/Bet1HYBRpw=;
        b=KmowFp6+MBKKmjihxrcs6UkSvCoija10w1hf2dwpCzKs4AOq18jTPfIT1C125rtt5P
         noZZqFzD4Z0eSGSiNYTU2ToF3ssTTd5Nd6//FpuFH8+4sopZiedI/v7pHExu/Jra72be
         nTqumSTHLg7HugDxQzmZiItU/WqseANsddLl8axbutgO+50XwBaZi3Zt90NBd+jJY0tp
         Y/yjbXH1x6loyMFCHrIBYXcihQDgei5uUaLSL+KgSFz5Nz+Ku1AZ/9ZVxAkXfLuCbOuG
         DvJz+ryEpqmOFXNrTmu3cZZdQe8aYvjb5uSxRpp1r5Yoq246BqEAVa/W3xaLcxJIepf4
         +3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769687517; x=1770292317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdqtuWOZPocisiw0ivyfpEO7qmiwAmXp/Bet1HYBRpw=;
        b=kjWjyw3pO7iCMicMZA4XqFDQHQUBfSuxPXssl+h0ef1D0HL3wmqpQQyZ0d9sT034SJ
         YGaQIvEiNU3wIAQUA9RmkJxijl12F4jxUVAZGWSFag+A94qJ6+GwgwnyJNzGUwKb2gYG
         gjNy3iPY+UdxQ10KKV8Or+Z9+arVaoo0KGF1OweVYlHQ90pZCQlnkErnfXECHFaLQ1Yo
         XFpp3sww3IoRDKT801hKA3DGQnj7jxUY2iUxkZH+ZGz0t4Jj1JBIT3TIzZo8aOr8SgDF
         W7AV+5zmQCr0ifmeSNyLO8x9jj4lCS4UX5gDXFwU06Z94LPKHStEGKVxErGENSQitFY2
         wVAw==
X-Gm-Message-State: AOJu0YwUSUs7UN+W3EyTy2zDZ36dSKxF8jUCJ4ovN4aLpPctki9wKH84
	S+3ESYdIS1YorhpIHtRn9QK7JARtQmAGKqe7rVd4K6MOZV6AKVt97YdPjkoKEw==
X-Gm-Gg: AZuq6aLAHdcy0nRvtPSirRWEvyP01O9exrjJrkCxxaTqpiuFPreahnYfa+B444Wt4sG
	vfk9zLV2aGrsTWJ38ChB/SPywv4VUVL/dY+uQFUpB+lDGO6SvQ+S3nHQYrxC3rH1bBAMgjjzTuD
	UYef3C8oxW/i2uqLR4qa/OHD7U1GPmvGqdKhfJfzRDnEWg3h5+n/pAAZ2Y+NkjBj+lhS++14oDN
	ep1h94ctc/ZS9WcyBu5N8AE79ejl/ZpegNkA+vjmShxO1gkMkkxMG9D+KwPfhPxuHRuQxnT5r7f
	7uQSi/eqej/NqbWzfY3TxqFWUJXT7pu/xMPXrrUR2IS07lLxMFfLtkY3APYyCKPJYk0WOjfdu1g
	WQl9b27vHuJ61oCysOzRpgPRjckLTy/6uG0Y1I1r6NZY4aAj/87kMUm5eK3BduO+jd1SBzqjGQw
	8o6nP5oim4gfaIE2mJksDqmm+mmidT50OTWVmMV0hvPukx/os=
X-Received: by 2002:a05:600c:4746:b0:46f:d682:3c3d with SMTP id 5b1f17b1804b1-48069c32541mr122413655e9.13.1769687516489;
        Thu, 29 Jan 2026 03:51:56 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-481a5dddb2asm2177085e9.8.2026.01.29.03.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 03:51:56 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 1/2] cooker: use BB_HASHSERVE_DB_DIR for hash server database location
Date: Thu, 29 Jan 2026 12:51:42 +0100
Message-ID: <20260129115143.4185990-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Jan 2026 11:52:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18931

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


