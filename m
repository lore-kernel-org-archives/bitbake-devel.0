Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799D3C43334
	for <webhook@archiver.kernel.org>; Fri,  8 Jul 2022 20:54:21 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web12.4223.1657313655123249015
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Jul 2022 13:54:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=PywDgFfq;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: ptsneves@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id
 v10-20020a05600c15ca00b003a2db8aa2c4so1374511wmf.2
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Jul 2022 13:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G7gGLdmwAwgw3gtzDJBTzKbzmy53rt/DiKpbfvlmbno=;
        b=PywDgFfqSWck9XhD8Wlp8UWRN1OIEl9XMUyhmggxe7F6uvU+zat+C/Cag44/ejV9zu
         8rbCxcoe2hFl5PS0Ff6FAVCmHQIQeY1NGF+9FKHijgvMP2QyJGvWrSykORxX2bYgaSMz
         0juAuX2UdePyaVaGt50DZx722PcHyB9eOUGpTgeXUFVEefnAf7fbfW6eVvPUFLHFKJPy
         t7OXBByBP1bJZ0U7AAgqAhr70lKHecKtZPocoDONIM6PRf69d6s4D6WG0Xj5xL+cAOx3
         X+ajc/LsnyA20FNItGYrhibBWRzom8rL/zBOkMZRQJ330wzkjQSY1uq6STxvbyTpLuyM
         2lMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G7gGLdmwAwgw3gtzDJBTzKbzmy53rt/DiKpbfvlmbno=;
        b=fIuxizNv+nj3jDFJm6C11msyJx27BucEDiTmVzIYBnZCT1aPTlFIhbnaF+UGYWW2PS
         fo8sdB6MlEU+xM3kbf9AqW1/Gf0DSHmA8mnxNK6nPSwkj+9H6fpsGarKiH31ouvvZKzd
         9RCJ+txBdmxI+nY59DsIvb2Uflaog5ShbqbMyHQ27rkuhnaVHyIMU1jgnxGK0rxHC0pT
         NgfzXCWClz2+BUjjEAd0PgSG7Pab+zsamOytd2T8dLj7tpG3G4ytdb5/6QkFdHgNvHqn
         eLnEIz4a2FcSD7m4VZV0pVuD6IefMc7qKZKvAuKOpbDF4bTB+4fM3yQSeiesMgnFz/p3
         ZOIg==
X-Gm-Message-State: AJIora92dQoDmtDpIv8X8QSw68EowyNBrDE8eI1CoqzzVzOmJ8mH5UlA
	yhfxuJkohDklpEO3aVRlpnpzGZO3FM6O
X-Google-Smtp-Source: 
 AGRyM1v1djWfbyf8aqpNryztzM7mx5hnR7auyM41EXP3+uC5iVxqH8YtVtdrpG1tqDi3bdPfZv3THQ==
X-Received: by 2002:a05:600c:3553:b0:3a0:519b:4b96 with SMTP id
 i19-20020a05600c355300b003a0519b4b96mr1684377wmq.61.1657313653547;
        Fri, 08 Jul 2022 13:54:13 -0700 (PDT)
Received: from localhost.localdomain (83.11.75.211.ipv4.supernova.orange.pl.
 [83.11.75.211])
        by smtp.gmail.com with ESMTPSA id
 o14-20020a05600c510e00b003971fc23185sm3037891wms.20.2022.07.08.13.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 13:54:12 -0700 (PDT)
From: Paulo Neves <ptsneves@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paulo Neves <ptsneves@gmail.com>
Subject: [PATCH 1/2] fetch2: local files only in DL_DIR becomes fatal error
Date: Fri,  8 Jul 2022 22:54:06 +0200
Message-Id: <20220708205407.1680137-1-ptsneves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Jul 2022 20:54:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13812

When trying to checksum local files, if a given file is not found
anywhere else than the DL_DIR then this means that the the build is
inconsistent, and unreproducible.

This also means that if the DL_DIR is removed or not available the
build does not know how to fetch the file and will fail. With this
commit we fail earlier and consistently on this condition.

Signed-off-by: Paulo Neves <ptsneves@gmail.com>
---
 lib/bb/fetch2/__init__.py | 4 +++-
 lib/bb/tests/fetch.py     | 7 +++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index ac557176..5f05278a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1233,7 +1233,9 @@ def get_checksum_file_list(d):
                 if f.startswith(dl_dir):
                     # The local fetcher's behaviour is to return a path under DL_DIR if it couldn't find the file anywhere else
                     if os.path.exists(f):
-                        bb.warn("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR" % (d.getVar('PN'), os.path.basename(f)))
+                        bb.fatal(("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR."
+                            " This means there is no way to get the file except for an orphaned copy"
+                            " in DL_DIR.") % (d.getVar('PN'), os.path.basename(f)))
                     else:
                         bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN'), os.path.basename(f)))
                 filelist.append(f + ":" + str(os.path.exists(f)))
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index ee41bff4..3ebd9fd7 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -693,6 +693,13 @@ class FetcherLocalTest(FetcherTest):
         flst.sort()
         return flst
 
+    def test_local_checksum_fails_if_only_in_dldir(self):
+        with open(os.path.join(self.dldir, "on_dl_dir"), "wb"):
+            pass
+        self.d.setVar("SRC_URI", "file://on_dl_dir")
+        with self.assertRaises(bb.BBHandledException):
+            bb.fetch.get_checksum_file_list(self.d)
+
     def test_local(self):
         tree = self.fetchUnpack(['file://a', 'file://dir/c'])
         self.assertEqual(tree, ['a', 'dir/c'])
-- 
2.25.1


