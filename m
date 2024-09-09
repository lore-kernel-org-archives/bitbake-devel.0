Return-Path: <danismostlikely@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62092ECE57A
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 15:42:25 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web11.56493.1725896537629659567
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Sep 2024 08:42:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=D9FuRqqK;
 spf=pass (domain: gmail.com, ip: 209.85.222.178, mailfrom: danismostlikely@gmail.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a99a46af10so209433185a.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Sep 2024 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725896536; x=1726501336; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lWiokkcPB0YfkioJpnkJhm1qIMP3a/7MNUv8JJeD59M=;
        b=D9FuRqqKU6aNnyysbxYjjgG1Uca9SmxJOwqEwY8x9x2bGXsPI7PVrgMBanu17i0HSD
         z69VN3IfJ2A7/q6kqlUtwykuA9fdZS3fbvULLUCgyHMbbgmuQItC2jJTf54y8OEcrJzo
         MEPrL1363QYYtc7laeWbystnF24cJ4VjpbZ1vKkQBmjwAutx8HnREL/YExqfoKyxLMeh
         y4mKNfZXF7qG+TUVmxwgneLERrHGcD3L5zQoNX46ml1a5n/+NIxSAQPbCiajeRs1gcs0
         d/UuTRa0PPpLrOrezBoWRT8c9xY86oGJoHhe+ezG4Wq4/BgXnvv10jzmh627Yqs5DCdO
         342g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725896536; x=1726501336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWiokkcPB0YfkioJpnkJhm1qIMP3a/7MNUv8JJeD59M=;
        b=Ctfwxkop6dqZ+ugOtUW8pAFK4k/haoHBTde4WMR3A+Ufd1VbO+gDHrgWVF3ElCWHPk
         QeScx+vEWMTibJ5XLicUH/yInY/urYDZmcBtDyDUhFcK+TfvYwOE7rntFbDs7DcrNRQE
         vFitTQeRyuZXzf8STRjN5Ez9p21fTcYYplFZQyCzJ2Eer0zFgtBVucACeKRsGWE3tNhh
         42QhOAAMjHg6QmahKSt23IibGdLhMbX5J1A6CyHMt3uxx2AH2RrPtm4EU9e87kLHLzF+
         EDPEzgoATd22hzdXFZenU9L/boVTCKSBVy0E2yNyePFz/76jybvKO/ZJLeqeK4nKKmSp
         I/aw==
X-Gm-Message-State: AOJu0Yz8hzW+98Vc/+VoP8eJ90/aWbPJkRRZdGjAuAUQHgtVOn43IVbp
	PBKE0R1FsXQryvCsuKNu5e3c2fjNYRSUy7F0+sIrGdqsm8raflcBYaXQTQ==
X-Google-Smtp-Source: AGHT+IG4mRb99YsW2arklI7mjYgtXKlt/8vW4ghO+DVA+PSTWtmX2hNsYV6A0AXj+vBPmtKlO8KyHA==
X-Received: by 2002:a05:6214:5901:b0:6c3:463b:e1e1 with SMTP id 6a1803df08f44-6c5283fb9camr171827176d6.26.1725896536404;
        Mon, 09 Sep 2024 08:42:16 -0700 (PDT)
Received: from nebuchadnezzar.home.dankm.pro ([204.83.204.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534778c3esm21818896d6.114.2024.09.09.08.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 08:42:16 -0700 (PDT)
From: Dan McGregor <danismostlikely@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Dan McGregor <dan.mcgregor@usask.ca>
Subject: [PATCH] prserv: increment 9 to 10 correctly
Date: Mon,  9 Sep 2024 09:41:51 -0600
Message-ID: <20240909154151.3635741-1-danismostlikely@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Sep 2024 15:42:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16548

From: Dan McGregor <dan.mcgregor@usask.ca>

Previously, incrementing "0.9" would result in "0.1.0", which
generally gets recognised as a lower version number. Even more
surprising, incrementing "0.99" returned "0.1.0.0".

This is due to the behaviour of the list function on a string
object; it adds each character as an element in a new list,
causing the new string '10' to become the list [ '1', '0' ].

Instead of converting a string to a list, add the string to a
new list, and concatenate it with the existing list slice. And
provide test cases for "0.9" -> "0.10" and related edge cases.

Signed-off-by: Dan McGregor <dan.mcgregor@usask.ca>
---
 lib/prserv/__init__.py | 2 +-
 lib/prserv/tests.py    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/prserv/__init__.py b/lib/prserv/__init__.py
index a817b03c1e1..ffc5a40a287 100644
--- a/lib/prserv/__init__.py
+++ b/lib/prserv/__init__.py
@@ -34,7 +34,7 @@ def increase_revision(ver):
          logger.critical("Unable to increase revision value %s: %s" % (ver, e))
          raise e
 
-    return ".".join(fields[0:-1] + list(str(val + 1)))
+    return ".".join(fields[0:-1] + [ str(val + 1) ])
 
 def _revision_greater_or_equal(rev1, rev2):
     """Compares x.y.z revision numbers, using integer comparison
diff --git a/lib/prserv/tests.py b/lib/prserv/tests.py
index 8765b129f28..df0c0030039 100644
--- a/lib/prserv/tests.py
+++ b/lib/prserv/tests.py
@@ -84,6 +84,8 @@ class FunctionTests(unittest.TestCase):
         self.assertEqual(increase_revision("1.0"), "1.1")
         self.assertEqual(increase_revision("1.1.1"), "1.1.2")
         self.assertEqual(increase_revision("1.1.1.3"), "1.1.1.4")
+        self.assertEqual(increase_revision("9"), "10")
+        self.assertEqual(increase_revision("1.9"), "1.10")
         self.assertRaises(ValueError, increase_revision, "1.a")
         self.assertRaises(ValueError, increase_revision, "1.")
         self.assertRaises(ValueError, increase_revision, "")
-- 
2.46.0


