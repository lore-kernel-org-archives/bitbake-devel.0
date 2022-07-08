Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C18C433EF
	for <webhook@archiver.kernel.org>; Fri,  8 Jul 2022 20:54:31 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web08.4146.1657313661435294857
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Jul 2022 13:54:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=n8+h0Byt;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: ptsneves@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id z12so22405809wrq.7
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Jul 2022 13:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikXLTjU896AmoA4TlhnzCbkB/zu4jZ4h+6ZpXwOf30M=;
        b=n8+h0BytEwJv9TNBjHvBDq0Zpn0xbE0kDVQ13xwIA95+78Q/WO1ctoWDHOV44WyPj5
         cw/3dWjGWoqlh5b9gyyjaigubv/C2ArfqcPLzmjQM//9VXjO0UtXmnhRTKpubns1x6FZ
         LrKABzTk8tdz8+F27vFrQfYhPG0La+mXmIdbeXmRkh0TKrDYBNG8BB0lHs/EdaQImfqJ
         DmycuWZFJv5IvrJH3mCIscRl7lugOOxbCR2us3T6tt6qeIc9+COfmEEx8+QVU9jY8XEl
         eaUgkzleqyxTeBuUdmd+b8i5jPs5HoYDrRWuKqBIHR3MAuxHv0sapJw5zjLCuHWhpvAA
         NjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikXLTjU896AmoA4TlhnzCbkB/zu4jZ4h+6ZpXwOf30M=;
        b=0gqLdPCa9GO02KrqKJc5etXT8mT+EeX8be4tqCpSP5f9gz/Bw2+brB9oGyStWlGPut
         ZbezamBpVbGHzBGUgZt9wQE9FLRNbkV4wO70zqEAZrszfQETI0oE48ve+uNXxXaih7lw
         jiJLJkJcec0FIABPHY1DBB1yJu1aoUvsmQq+rDsepdA5YvI51qK6kqgI6gS6JyQpCypA
         wOPkLdB+0fPR7YiGBa1hzQUNX3tL/bWsA4TrCZPmcLBBULf1cdlOcgogioYSjpS3VVDc
         MOfBitFjw9YvISTbUrCNhPT2gDjnbS+KZADY3DMtzGMP/5eqWk8w1cAMkQGjBtupJYl6
         jwIA==
X-Gm-Message-State: AJIora+d6iWisM6MrKfRjA10O8GmfUJE8tYMOioSUl/qx9JfoXHOsFjh
	Z4847XyaATrzfrjqIElgMvTcVetWPyrs
X-Google-Smtp-Source: 
 AGRyM1ty4HH8EATjWN/v9xsAqwdKBEq9AqjxayMqEiERwc73WBlC/rhYryLD8LIWR6Mdckf2yLqCKQ==
X-Received: by 2002:adf:dd01:0:b0:21d:6df2:be30 with SMTP id
 a1-20020adfdd01000000b0021d6df2be30mr5259044wrm.255.1657313659761;
        Fri, 08 Jul 2022 13:54:19 -0700 (PDT)
Received: from localhost.localdomain (83.11.75.211.ipv4.supernova.orange.pl.
 [83.11.75.211])
        by smtp.gmail.com with ESMTPSA id
 o14-20020a05600c510e00b003971fc23185sm3037891wms.20.2022.07.08.13.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 13:54:19 -0700 (PDT)
From: Paulo Neves <ptsneves@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paulo Neves <ptsneves@gmail.com>
Subject: [PATCH 2/2] fetch: bb.fatal when trying to checksum non-existing
 files.
Date: Fri,  8 Jul 2022 22:54:07 +0200
Message-Id: <20220708205407.1680137-2-ptsneves@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708205407.1680137-1-ptsneves@gmail.com>
References: <20220708205407.1680137-1-ptsneves@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Jul 2022 20:54:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13813

If the local fetcher was not able to find the file anywhere but it
was included in the SRC_URI for checksumming just make it a fatal
error.
---
 lib/bb/fetch2/__init__.py | 2 +-
 lib/bb/tests/fetch.py     | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 5f05278a..8184b55e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1237,7 +1237,7 @@ def get_checksum_file_list(d):
                             " This means there is no way to get the file except for an orphaned copy"
                             " in DL_DIR.") % (d.getVar('PN'), os.path.basename(f)))
                     else:
-                        bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN'), os.path.basename(f)))
+                        bb.fatal("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN'), os.path.basename(f)))
                 filelist.append(f + ":" + str(os.path.exists(f)))
 
     return " ".join(filelist)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 3ebd9fd7..5b577b06 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -700,6 +700,11 @@ class FetcherLocalTest(FetcherTest):
         with self.assertRaises(bb.BBHandledException):
             bb.fetch.get_checksum_file_list(self.d)
 
+    def test_local_checksum_fails_no_file(self):
+        self.d.setVar("SRC_URI", "file://404")
+        with self.assertRaises(bb.BBHandledException):
+            bb.fetch.get_checksum_file_list(self.d)
+
     def test_local(self):
         tree = self.fetchUnpack(['file://a', 'file://dir/c'])
         self.assertEqual(tree, ['a', 'dir/c'])
-- 
2.25.1


