Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3F8F4BB6B
	for <webhook@archiver.kernel.org>; Tue, 24 Feb 2026 17:55:05 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26402.1771955701956615815
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Feb 2026 09:55:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DZe00e0r;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-436309f1ad7so4511948f8f.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 24 Feb 2026 09:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771955700; x=1772560500; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4CZ5lRl0MaRrTEjuRQQEOu9GszwbDBpol5+U2pR+mvo=;
        b=DZe00e0rlVGSYSeNwmY+PlcY4WJDK4Z2tAIjH7PXgz/lG48dIE8+nHTR+4bD9wQieD
         QLW30dXhpvOa2SViOO4EkvsQxFgONLzD7o4+jANW4BzkemdNeaPEXMbayHAYoC5laPHW
         e3tJH7nkCcZik2Xm0z+l1YEbE1qdPVdP0vEsB2D0L82uc3WpY9ntGib3OExziWv8mbHe
         1XqbVvy25dbG7ztqaf76+YNmfF9R3HGmyhd9KP5tj6A6r+IJgxOZn4yAJWzmj791DfrO
         B6lkO150O3alJxJLqnHrXoGTAlBwzfdBKM2czWxrPu7Ft7yrP2oRLxk6o2asgwFGTpPU
         TBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771955700; x=1772560500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CZ5lRl0MaRrTEjuRQQEOu9GszwbDBpol5+U2pR+mvo=;
        b=e/Aen3w+cnPcijW0VWWy9g9Q7EOkVlTB1Hac09qtcEL3iv6srKy/4Mi1AE5jPRK2VX
         Jv0RRHu0gI9sp6IoiYwfww8Pnflwp2zA0A/tE6Hoaq+bF2XqlMG75yJZGCd/Yf1wVW2z
         fX1F69HGZivb8dayO8CwEvj7OFOxfPp2AR4GgMGCHXtWZN9BytZk1tSb3PREiJC/CHIA
         Vjad51DyN/+hZJ7Vwvkz8qCxX01lhQ9SUto6jqH/KMlNEqPxGbkauV016k1BxblnwzmP
         u4Cbmq1FS+SlG9CF/qvy7KaIr3UO/2sxbeZrOu8u0iNrjXot75kM9oXHKUXM/52ROsgl
         VRWw==
X-Gm-Message-State: AOJu0YyxCZ8h0AdUMn/gMpPRcE6gtC0/m7AkPphfLrkyvH47qp6+F31r
	jqx486bYUzPux6oXgWFyyVgWr9ISz+ag9pJ17DzblAfybhFa3n/crWDiHTvkig==
X-Gm-Gg: ATEYQzwKeosugpE4lOZbOtzH3egMuovJhTgNaE7NR4pvvOdY4TethhitAEFBXlsGC5v
	eFUzE43R245FiZTOlB94mkxy86inCrqTsQWDAFTKIOhBt33nOkTBwEGJG2BWw9imXLKc9b6MrhB
	tvOi4OpGIhDU3aIKtRLOX0Zoz4VEcB0+F6N0Opd2xDcoNcFnF3mIG1ElsCEZ2Bp4zMBiw+LFx3h
	xo0ZiWcljiBrYRNzAKNgWzDCeCGWCo2skDv24uwd/UZ+nmxSqhfMI8Kp/aILOlLXf+S3zhNQTCl
	xEja/Li2ZTy0VkrYf4Q/laqMx5XzKn6+uLsGvzdtWRZA3PiVLUQMtxrukAnsiqN5wA/c6gPqsIj
	9BY7H5U+7pEupWuNyzX87E2ZRKQTb+FW7/218NBnDs5grnJfe+msTo+5hNI/ArhA02FpCBPLitn
	FEzZhfLCu3VaHjziaSDRGSSQDEe7wL6BCIFIlor1qeGmmVN9xQTSdAPBnGu8Y=
X-Received: by 2002:adf:f0d1:0:b0:439:84cb:288d with SMTP id ffacd0b85a97d-43984cb2a3amr4371468f8f.41.1771955699855;
        Tue, 24 Feb 2026 09:54:59 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43986aa2f84sm5699689f8f.7.2026.02.24.09.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 09:54:59 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2] cooker: warn when sstate is outside of build dir, but hash equiv database is inside it
Date: Tue, 24 Feb 2026 18:54:55 +0100
Message-ID: <20260224175455.2135473-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Feb 2026 17:55:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19084

From: Alexander Kanavin <alex@linutronix.de>

This should help with the long-standing usability problem: when
someone tweaks the configuration to put sstate somewhere else than
the default (so that it can be shared between local builds, or over NFS),
they should also share the hash equivalency database, but there would not
be any indication to do so.

This will issue a warning and recommend to start a dedicated hash equivalency
server (if sstate is on NFS), or set BB_HASHSERVE_DB_DIR (if it isn't).

Signed-off-by: Alexander Kanavin <alex@linutronix.de>

---
v2: guard against relevant variables not being defined
---
 lib/bb/cooker.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 4b6ba3196..88be266bc 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -336,6 +336,25 @@ cannot be on a NFS mount due to potential NFS locking issues between sqlite clie
 If you need to share the database between several computers, set up a permanently running hash equivalency server
 according to https://docs.yoctoproject.org/dev-manual/hashequivserver.html""".format(bb_hashserve_db_dir))
                 dbdir = bb_hashserve_db_dir or self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")
+
+                topdir = self.data.getVar("TOPDIR")
+                sstatedir = self.data.getVar("SSTATE_DIR")
+                if (dbdir and topdir and sstatedir and dbdir.startswith(topdir) and not sstatedir.startswith(topdir)):
+                    if utils.is_path_on_nfs(sstatedir):
+                        bb.warn("""Sstate directory is on a shared NFS (it is set via SSTATE_DIR to {}),
+but hash equivalency database is inside this particular build directory {}.
+
+This will prevent sstate reuse, and it is recommended to set up a permanently running hash equivalency server
+according to https://docs.yoctoproject.org/dev-manual/hashequivserver.html""".format(sstatedir, topdir))
+                    else:
+                        bb.warn("""Sstate directory is shared between several builds (it is set via SSTATE_DIR to {}),
+but hash equivalency database is inside this particular build directory {}.
+
+This will prevent sstate reuse, and it is recommended to set the location for the database to a common path
+via BB_HASHSERVE_DB_DIR, for example:
+
+BB_HASHSERVE_DB_DIR = \"${{SSTATE_DIR}}\"""".format(sstatedir, topdir))
+
                 os.makedirs(dbdir, exist_ok=True)
                 dbfile = dbdir + "/hashserv.db"
                 upstream = self.data.getVar("BB_HASHSERVE_UPSTREAM") or None
-- 
2.47.3


