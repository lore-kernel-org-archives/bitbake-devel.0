Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E55BCCA47B
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 11:28:51 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.6345.1657798129208874494
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Jul 2022 04:28:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=BOWHBStT;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: ptsneves@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id b26so2167942wrc.2
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Jul 2022 04:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3cxtUwNY+jTIPw9Iqvi4HTEXjSNwcmvpyCuH5u9aYPg=;
        b=BOWHBStTp5SxZLR469mu7HvNDMEo61gYQwiEYL+9znEuyOzCi0NizhVa+lMT5G/DJ3
         eBpyZc2mBT+mQSdOa6HR5rT6/Mh63mKHJ8gUEDHXBJ9c1DlkIvzfbDDAl9CyOnrLOcZM
         C2XWDcjeRUw5xZ5wUFRDEFXt4dJd7VdgMPFl58c0kgZOmZlUgCNN+9mEvTFJldVs30kM
         HdnZoxcaRb/sn82e6j6n9Rk6Ts9lRHBUrL1uYUdIy3hWoAFW+MnqTkaiHhcub9aYe8b2
         vtU1AJG458uBMd3gQiSVqlLfD0aHM0QRVdXxVgVbbntL4iyDAYqVNH4NhGTl1uwcysxX
         +A5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3cxtUwNY+jTIPw9Iqvi4HTEXjSNwcmvpyCuH5u9aYPg=;
        b=cfQYdi0q9l3bZhj/W1yl9t6+N/eCK7vYfnanKki9vMhPOTYCzgSuaBvM0xa1+7020L
         3k9UjBexFGWGY+8PjstUVe0a5poPKAIYxavZ16uGQ8Gi3hk+5GTVXu4ju5sxoUvDj7B4
         TNx+nEDhw7FCBS6lratLpWfCbEQ9T9jQX/RunGOb76WpKMx513Ha8sbn17oeYiyxmpNu
         6Xmq3aWO/sE9DZc9H/aeRUWRFM0bgl7wM4brQ+j9PQnn4KV/TfjRwyGEfCS1SgD2mIcD
         UjaSxMnl5kZcsBFNB8ZoJ3pBN1rRrutb5pr2c6CZOe6QPxcAIObI8uuSPQnrOlTftEXz
         KXhw==
X-Gm-Message-State: AJIora9FrszEHKgPcrFkLfWDybddgsRH9/NOTOSs6IfHnw8kcGf4jC1f
	vVsJu72rEtf6D3k+wVCgr5Y/I+RxVvRr
X-Google-Smtp-Source: 
 AGRyM1tD/2YmJe2T6tXxtLWhPV98zmWlT1bc2gu1hSb3Vocb0w6lragF3Q4OgYYDAfDli3oGdElW8A==
X-Received: by 2002:a5d:5915:0:b0:21d:93a9:7311 with SMTP id
 v21-20020a5d5915000000b0021d93a97311mr7337437wrd.103.1657798127735;
        Thu, 14 Jul 2022 04:28:47 -0700 (PDT)
Received: from localhost.localdomain (83.11.65.125.ipv4.supernova.orange.pl.
 [83.11.65.125])
        by smtp.gmail.com with ESMTPSA id
 r129-20020a1c2b87000000b003a2eacc8179sm1595336wmr.27.2022.07.14.04.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 04:28:47 -0700 (PDT)
From: Paulo Neves <ptsneves@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paulo Neves <ptsneves@gmail.com>
Subject: [PATCH v2 2/2] fetch: bb.fatal when trying to checksum non-existing
 files.
Date: Thu, 14 Jul 2022 13:28:35 +0200
Message-Id: <20220714112835.38220-2-ptsneves@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714112835.38220-1-ptsneves@gmail.com>
References: <20220714112835.38220-1-ptsneves@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Jul 2022 11:28:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13827

If the local fetcher was not able to find the file anywhere but it
was included in the SRC_URI for checksumming just make it a fatal
error.

Signed-off-by: Paulo Neves <ptsneves@gmail.com>
---
 lib/bb/fetch2/__init__.py | 4 +++-
 lib/bb/tests/fetch.py     | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index ef0b18a1..05e453cb 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1239,7 +1239,9 @@ def get_checksum_file_list(d):
                             "\nThe following paths were searched:"
                             "\n%s") % (d.getVar('PN'), os.path.basename(f), '\n'.join(paths)))
                     else:
-                        bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN'), os.path.basename(f)))
+                        bb.fatal(("Unable to get checksum for %s SRC_URI entry %s: file could not be found"
+                            "\nThe following paths were searched:"
+                            "\n%s") % (d.getVar('PN'), os.path.basename(f), '\n'.join(paths)))
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


