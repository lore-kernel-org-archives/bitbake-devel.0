Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA15EA4FCB
	for <webhook@archiver.kernel.org>; Mon, 23 Feb 2026 14:31:25 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36147.1771857083731817086
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Feb 2026 06:31:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nrM3gzXT;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48371bb515eso55954895e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Feb 2026 06:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771857082; x=1772461882; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zYjKOxMjXvsa9JSShmMXAbMvBcWe3utK8wK73pU7Ofw=;
        b=nrM3gzXTKOilQCjDdbGlxBnCdtwuw5VoDFSI8yxUX0bWeUXf361E48bSVBCPBzC8Uo
         VMJnXtlxs7q3PIMF+n+onZQO/gUviM46Xf6P5OF6nnQqvv+lDpTQeAH/UggVBUhoCCSY
         1KKLAVezRqEtUfAmpr9Z9eNMEHjBGGZ+Eo7MFJ2Kj4McEjWlDjY8f0XJQH49y9VMbGfd
         QMHsP2uKsjROC1bBjuR7cqpppRFOrecRKruq29PDoOKRMmNX3SYrvowyK9IGusgAkM1K
         DImGX+JLzlzbknRiZyqEPc3gVf8IxmAmgh69hqbxs7HG4Z/UhHD/0xIdRGW2LdF9nYer
         apew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771857082; x=1772461882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYjKOxMjXvsa9JSShmMXAbMvBcWe3utK8wK73pU7Ofw=;
        b=D/Lf9p4G28Tg80ndv1dEYYfh/kMc6xIfuCge16mcnzPAyF3s8YziyalmZbgxiWuu69
         I6k21zzZy3qSxxlGx+hydT8nfdKE61Eo6ZPzDUZgjz2SYIdrmkdpWgZFSuudHzNf5tIe
         lcQYb6UQ7LhaY2tRN7EjdLCMTkbf0E3Tn1yFanNxQeNX3uAS4Vww6YL4iWIB1huA6Faz
         uDaUoa2g2kx8CtD9QePqn/ST4tEe1b/z+KgPf2sXq/DD2hovhVG1npP8amWliR8BmXuS
         9Lhkkcott6nuFrE09/lk2Eh7uYq7vyG7d7ubUpomrxuFax5hv187v4u/PwyIYGoLh+0N
         GxiA==
X-Gm-Message-State: AOJu0YzsDYX0ZDEtgUWY6OJtScR+36F+YyOy5/a37FbkF3MlJ+RQhY4z
	UoqAptHDxE75pnsnFVRqcTWByFi/nKetX8rEJ18Dnvxa3dYIajBjVGduel3lPw==
X-Gm-Gg: AZuq6aKBNQna4/SGmeeh/POd2aZp+grArGcYBB+3EhJkdq6FXzPfva5MYa1GHq2wqGY
	JL68ssmcCdaFXKZlSfaSgq7Ksr8b4Anw2qZBuPVsjFYjR/2hDPl3XAoA/JeLUbVRxh+WHJ9jAn9
	tnHVGQXBEWxjivK/scPpWT8L09EebeBGdCAyLPILt+aBIZn/OEGfkq2po+lATV0ih1wzHwqjWPX
	5XfCx8kvjWSGDC7c4+LXImHa9n6CACAFCTGXkSw62z/vxKTjm++OhWy/2gkn8dgyRhLACwEpfZn
	jCZ2BZh4YXfmwCuQo1Er4Yid3eGnOvStrZlCGhy7hDOogCZUAwSykgt+cmR+eoAvM6Gemr8PmAE
	SN5689D21HmPbDeDA7m4D3C/jLYn2fcOyImgh/ND9vxH1EN+H6i6WJvJ9IQtQZeK+loBQf02fhO
	IAqwPaXIMBGPuutuzexGHtdFWFYSlRlW8t9QIMv4PRjejVgShR8vCQFQ3ueVw=
X-Received: by 2002:a05:600c:450c:b0:47d:73a4:45a7 with SMTP id 5b1f17b1804b1-483a96377b1mr142620435e9.24.1771857081705;
        Mon, 23 Feb 2026 06:31:21 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bc0e3sm247924455e9.5.2026.02.23.06.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:31:21 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] cooker: warn when sstate is outside of build dir, but hash equiv database is inside it
Date: Mon, 23 Feb 2026 15:31:18 +0100
Message-ID: <20260223143118.1533806-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Feb 2026 14:31:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19078

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
 lib/bb/cooker.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 4b6ba3196..5703eaed4 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -336,6 +336,25 @@ cannot be on a NFS mount due to potential NFS locking issues between sqlite clie
 If you need to share the database between several computers, set up a permanently running hash equivalency server
 according to https://docs.yoctoproject.org/dev-manual/hashequivserver.html""".format(bb_hashserve_db_dir))
                 dbdir = bb_hashserve_db_dir or self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")
+
+                topdir = self.data.getVar("TOPDIR")
+                sstatedir = self.data.getVar("SSTATE_DIR")
+                if (dbdir.startswith(topdir) and not sstatedir.startswith(topdir)):
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


