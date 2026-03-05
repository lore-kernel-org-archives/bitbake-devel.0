Return-Path: <pmi183@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D904F33A8D
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 15:19:55 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46648.1772723986833322233
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Mar 2026 07:19:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ehz6y4Nj;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: pmi183@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4837634de51so35441615e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Mar 2026 07:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772723985; x=1773328785; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dFHkzGKyjlJ6KEbIEqkTMss8p+T+XTQVE1HJ0hg1vYo=;
        b=ehz6y4NjF/41ZLj2XDkTP/bWRHVpXfC6D5w/KxVuhz0xKA0DjRKL6txtDo1MuM2CLZ
         DBjZvWxfItdHoNu5L73nojFzU96qmR7LlqXm866uEWEmYWtEtlJ1QZkBRfPCYxxUr07y
         y9tMTSTm04s3crRHxuQQBW/aUlUmddy1/3hoPjhGO87HDtiImJRs087feQSAIpGu5v+f
         X7a8NGrtNM/pSYb9lVYowEXz7igFy4ipw2NmEwnhXu5jpXm2jy/oizmcQ4ldP9bjIR4X
         lntGhhi5sq002ybhetsD0M6GUxFhUjtcaMuweidkcuHEpALAod1iW0rRCc9WuXECyJWA
         6YBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772723985; x=1773328785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFHkzGKyjlJ6KEbIEqkTMss8p+T+XTQVE1HJ0hg1vYo=;
        b=DfEQLqbCprvTIETqWRCj3PpVM0/pxx8CW7N1Qp31L0kAKvA6/tH5yl7Blc8+Nb2sJx
         UMt6g9Kg46cm1/Axj/wYx6F1jPQ38xhsQ14i7fNjTzoPTiiTgBaaxiAUYVMXXADxquEM
         sWbGKXP5rCl4JS4WuJ/qT4uwgT8mAlzxtJupxo9HnKxcKCqZFuQA51W/GeebLO1NiXOA
         QKmZGG1ACNXsjvk2zc4tMvWdWv6b8qNNxAASAGKD5xDHAdI9BaR6uksMA8lUf7eCsrmF
         X2iUVF4HvVFtlWT02Yk4o5SZc+fRRDlRYfsVgsZLTkKGXUEbsS1HFhBfHxK804FiPr1O
         aC3w==
X-Gm-Message-State: AOJu0YyM+d/yfypRpmifMRR34u4PWelYpOtQuutzXyKyZK8OSKizNB38
	zk1OZsALqsQUuFSRf488jMvboMAc+i+x0cY3tOpPw04yzrfZa6CdAKn2J1mjYtNb
X-Gm-Gg: ATEYQzxs6kUpItdL430KkRf0GPVVitvAj3s4KMg8WCOBdqxhUmDhwbpW/hAElKXo360
	LzbmJj9YdZJlP4a2q0HmLJaa5UgV57/xpO7VZdwaQDb5kKgZG/B1reJ5We0kxWT6OTtpu0lD7kd
	WZk+szEt2RmzL/sIB4Jtq1x+D0DSbdv6ERdPztjgpXmy/A8kUTdH/n84HONpvkValGq78lEmURP
	lYIbt5y2eFH2GARKJJHmObh7H0ETCQM3JpfnCcow78yfpwyFS9yKgsXAguJi+a3BThikwq+3cVQ
	+4Rh6f+oQLjUya/yuIcFl4xwDmRbmn1DCq5tJ9TZOcjgC8+7Vl3qQHHKZeQJFNtRV7xqRo3ZIJS
	qVikn/O/ng3nEZWk51oFmfUsms8uyh8708HZdH24JdNO3pX4DPny763ykIRyudIe7ku7kYdP1Nt
	+ta36JNKukcatp98JAGxfLrUwnPCEvEwn6tTXvmSmL+MZ5Uc/+k0XTAqn31GOsSmIX5+sOSBzds
	0Ot
X-Received: by 2002:a05:600c:a087:b0:485:110f:5b7f with SMTP id 5b1f17b1804b1-48519888e6amr107610605e9.19.1772723984878;
        Thu, 05 Mar 2026 07:19:44 -0800 (PST)
Received: from pedro-P1-Gen-8.criticaltechworks.com ([213.205.68.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fae4a68sm42050005e9.9.2026.03.05.07.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 07:19:44 -0800 (PST)
From: Pedro Ferreira <pmi183@gmail.com>
X-Google-Original-From: Pedro Ferreira <pedro.ms.ferreira@ctw.bmwgroup.com>
To: bitbake-devel@lists.openembedded.org
Cc: Pedro Ferreira <pmi183@gmail.com>,
	Pedro Ferreira <Pedro.MS.Ferreira@ctw.mbwgroup.com>
Subject: [PATCH v2] fetch2: avoid reuse download filenames
Date: Thu,  5 Mar 2026 15:19:41 +0000
Message-ID: <20260305151941.835215-1-pedro.ms.ferreira@ctw.bmwgroup.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Mar 2026 15:19:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19109

From: Pedro Ferreira <pmi183@gmail.com>

When fetch task runs and while running checksum validation
detects that for a source file the checksum mismatches,
instead of aborting, its allowing to move aside and download again.
This might allow users to taint the source files instead of acting
as a safe mechanism to fix some issue occurred on the download stage.

Signed-off-by: Pedro Ferreira <Pedro.MS.Ferreira@ctw.mbwgroup.com>
---
 lib/bb/fetch2/__init__.py | 11 ++++-------
 lib/bb/tests/fetch.py     |  4 +---
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index aaefd8602..1484f5422 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -716,13 +716,10 @@ def verify_donestamp(ud, d, origud=None):
                 p.dump(checksums)
         return True
     except ChecksumError as e:
-        # Checksums failed to verify, trigger re-download and remove the
-        # incorrect stamp file.
-        logger.warning("Checksum mismatch for local file %s\n"
-                       "Cleaning and trying again." % ud.localpath)
-        if os.path.exists(ud.localpath):
-            rename_bad_checksum(ud, e.checksum)
-        bb.utils.remove(ud.donestamp)
+        # If there is a checksum mismatch, it is likely because the file
+        # is being tainted or some corruption is occurring when downloading.
+        # Download cache should be cleaned up before trying again.
+        bb.fatal("Checksum mismatch for local file %s\n" % ud.localpath)
     return False
 
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 74eb73472..8f371234b 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -899,10 +899,8 @@ class FetcherNoNetworkTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz")))
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz.done")))
         fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/test-file.tar.gz"], self.d)
-        with self.assertRaises(bb.fetch2.NetworkAccess):
+        with self.assertRaises(bb.BBHandledException):
             fetcher.download()
-        # the existing file should not exist or should have be moved to "bad-checksum"
-        self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz")))
 
     def test_nochecksums_missing(self):
         self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz")))
-- 
2.43.0


