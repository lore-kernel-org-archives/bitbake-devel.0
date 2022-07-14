Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E52DC43334
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 11:28:51 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.6343.1657798123969776710
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Jul 2022 04:28:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=QNg1pSh8;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: ptsneves@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id
 r127-20020a1c4485000000b003a2fb7c1274so2441322wma.1
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Jul 2022 04:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4NdluZLnS2KVdRRI5vD9EXAww9k3hXzMiKncjlelBQc=;
        b=QNg1pSh80z07dUWsl1f48/bWVbyki6gNubesWqHVr6b8Xw+onEWkzeflWy4r8v3WM5
         tW568MPDE2J8SA6MjoYANQOm5CyzrET3oTR2z6nLtZXrnhtvbS2AfZbzD8Ejgv+loFk3
         aOI+CT3ms3v/+KtOJkVQwA7/Gh229dDMO7jTZQl2MaAzB59A2uOp3/jPLhwRNEuq3nvC
         dVdEaLeFHm8UQ44mYD/YC6IifpB7n83BzqaOXJWSSU5Jgt1DidtSv43mr7BfGwskNhhd
         g1dEnaeh3zPo8C9dP1xsM1rbMseleZq6tKGcFEIK3VoRBE3fJI11utO8gx9VrLsuvJDA
         EqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4NdluZLnS2KVdRRI5vD9EXAww9k3hXzMiKncjlelBQc=;
        b=IbMzGecEd5lZBMEtVQ/m52n3DN7kbl5MpJboy0zG6ehvpoGSZYByBg0NQjbFlaAtk3
         5+tme3b/GSTAjXDbqfnvZSiO501zvSCvRoiXjdLi7CJ1iOeJBe84/LCUrRYLHvW+roPN
         s4UTxzj8SR4cKdyYVseNn2kOKWYxSCWEsngJ98eJqGuPwvN6hZ0HLA+DB5lzAQybDfoc
         8pa/vsWCHlQeNzbocjRN0pQf4/ngvdtaO/xtBbHSddyk539hMxkHc1D5a1rGBp/AX8/B
         kuDOAa1SGm4w70yRhLQtDK71wQDllIeldeTWYsPwyWlkvdfp4eISlE+rWf+KvwomMj5K
         odvg==
X-Gm-Message-State: AJIora9t4wJ2VYKe7gvCIN+m0Ihbj3bex3UjxjOS3teRUECjv8Tt1rpe
	NjlaevPmp2q2BrrXQtPTvGTqKoqmDYKj
X-Google-Smtp-Source: 
 AGRyM1tZ0FEKtqgWIUP0G3wrfhespQHSrThFBS2xm2GEM/L49U6yeJD4H4E3fpK5+nCq4rc2R3DmqQ==
X-Received: by 2002:a05:600c:1d18:b0:3a2:ef8b:1471 with SMTP id
 l24-20020a05600c1d1800b003a2ef8b1471mr8702189wms.202.1657798122297;
        Thu, 14 Jul 2022 04:28:42 -0700 (PDT)
Received: from localhost.localdomain (83.11.65.125.ipv4.supernova.orange.pl.
 [83.11.65.125])
        by smtp.gmail.com with ESMTPSA id
 r129-20020a1c2b87000000b003a2eacc8179sm1595336wmr.27.2022.07.14.04.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 04:28:41 -0700 (PDT)
From: Paulo Neves <ptsneves@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paulo Neves <ptsneves@gmail.com>
Subject: [PATCH v2 1/2] fetch2: local files only in DL_DIR becomes fatal error
Date: Thu, 14 Jul 2022 13:28:34 +0200
Message-Id: <20220714112835.38220-1-ptsneves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Jul 2022 11:28:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13826

When trying to checksum local files, if a given file is not found
anywhere else than the DL_DIR then this means that the the build is
inconsistent, and unreproducible.

This also means that if the DL_DIR is removed or not available the
build does not know how to fetch the file and will fail. With this
commit we fail earlier and consistently on this condition.

Signed-off-by: Paulo Neves <ptsneves@gmail.com>
---
 lib/bb/fetch2/__init__.py | 6 +++++-
 lib/bb/tests/fetch.py     | 7 +++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index ac557176..ef0b18a1 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1233,7 +1233,11 @@ def get_checksum_file_list(d):
                 if f.startswith(dl_dir):
                     # The local fetcher's behaviour is to return a path under DL_DIR if it couldn't find the file anywhere else
                     if os.path.exists(f):
-                        bb.warn("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR" % (d.getVar('PN'), os.path.basename(f)))
+                        bb.fatal(("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR."
+                            " This means there is no way to get the file except for an orphaned copy"
+                            " in DL_DIR."
+                            "\nThe following paths were searched:"
+                            "\n%s") % (d.getVar('PN'), os.path.basename(f), '\n'.join(paths)))
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


