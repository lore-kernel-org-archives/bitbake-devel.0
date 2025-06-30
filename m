Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14024C7EE39
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 07:52:47 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.33883.1751269963659240166
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Jun 2025 00:52:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JaYpoTFj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so3206401f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Jun 2025 00:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751269962; x=1751874762; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Em87ddsSQjKtLVQUt8IRt1bBylxPTAmFw1K7YBc++s=;
        b=JaYpoTFjTPVoNrFyAYlqOfQk1pcY3K++1iVLnshDmEMxHtftd9OAPHXD2cmLD/JVQY
         fii7GS9a2UewXpMx+O7wzsoK4vfNT56A1gTpknot8Z2StuhZQuPQ0F5NkEQQVRmPj0DF
         9aVJryEGxgTVp6w0MpHFYP8xP7En230q3hRYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751269962; x=1751874762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Em87ddsSQjKtLVQUt8IRt1bBylxPTAmFw1K7YBc++s=;
        b=AaZrPPmSJfUdTgJPwgcp9axxh1E7gmveXotDCUobmBoRZOXnLLgZWerzRD8MLfY4Ww
         9P8TJZio6fIC9ltcU2+zuObCrSS1STSN9rqahIAW4qp8qWng1sg+/P1+mA9V34WRa4tN
         k1VLkrJOa7zRlv1azCs++YmaqKPlih6el1qHFMEGUccNbKCh03RGGikIhZE73hFJYyPz
         ESY2ON4Ry/zW8QtzCKpp256XcquH+0V40ut3dvpOUe4zysWEcSfEaAtdDV2znO2dxIL9
         WRY+U70g2pBAHTbpXAHO9O0uPA+64FMxfd3MkF7lgCUmcieBsLwQSKYM6IAX8bSOKm2o
         uxhQ==
X-Gm-Message-State: AOJu0Yx/IK8LR+toCT8SRlmbp0rdqigM9c/yV2QjVy8rb75eMkh69S85
	1iZnbXnKn+Xj7OG0AxOHpJKEUDSS/OF76GVeZPB2otMfTQVeNx7MbiZFQ6CVTS2SQqM/X08jG4n
	Hcozc
X-Gm-Gg: ASbGncvBFEP0nU0Pusm0biSpSbJEAZcSUB/G7DrRmGBKK+PEhwq0EsY+/boTXqm0mN4
	ZgZBLXS0fj2AvFCzxGtr2KNbejkES8jyxoazQ8VePGLXKqdBb12/Us9qumZbXoBWTF5GYz504mS
	UIivyvyzWtXK/ywXzsyOpoSnSZT/1FHtREmY4S+SfeFewLAWBI3KWsZ0rb03oqqxS3adgEDfQF5
	IHsH0Zx1EX7TozKJxhBmHXIA5iXCoWWmcp2nZc+81mEWOQy9jHfkNOZkOewoibXiEZ5mQtXK3+b
	nBH3meHWxvN+vbi2CpoMMjUPuFOzU3OGuLfAkKlLipjePu7mvEA1u3EplnQ/j68SvlEf3+r5s4S
	orchfefYnS4UlP1Gn0YJSNfsIPg==
X-Google-Smtp-Source: AGHT+IGXvvHlQQ39QX9JPERtUWfi+4xkPv0qKCPdXaZEbT5SVb95flwcYA6auE7j/AFlZSCocW+QTw==
X-Received: by 2002:a05:6000:230f:b0:3a5:24cc:6d5e with SMTP id ffacd0b85a97d-3a6f30fc1admr12569255f8f.3.1751269961413;
        Mon, 30 Jun 2025 00:52:41 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:7e4f:7802:84c8:7b76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52be0sm9823079f8f.64.2025.06.30.00.52.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:52:40 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] utils: Refactor filemode variable conversion to a function
Date: Mon, 30 Jun 2025 08:52:39 +0100
Message-ID: <20250630075239.3408124-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Jun 2025 07:52:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17725

We have other places in the code where we need to take filemode/mask
information from a bitbake variable and turn it into a real python
number. Turn this internal code into public API in bb.utils and
add some tests for it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker    |  7 ++-----
 lib/bb/tests/utils.py | 11 +++++++++++
 lib/bb/utils.py       | 17 +++++++++++++++++
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 35fa1ab62be..d2b146a6a92 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -182,11 +182,8 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
     elif workerdata["umask"]:
         umask = workerdata["umask"]
     if umask:
-        # umask might come in as a number or text string..
-        try:
-             umask = int(umask, 8)
-        except TypeError:
-             pass
+        # Convert to a python numeric value as it could be a string
+        umask = bb.utils.to_filemode(umask)
 
     dry_run = cfg.dry_run or runtask['dry_run']
 
diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index 48e61dfcea0..52b7bf85bf4 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -692,3 +692,14 @@ class EnvironmentTests(unittest.TestCase):
         self.assertIn("A", os.environ)
         self.assertEqual(os.environ["A"], "this is A")
         self.assertNotIn("B", os.environ)
+
+class FilemodeTests(unittest.TestCase):
+    def test_filemode_convert(self):
+        self.assertEqual(0o775, bb.utils.to_filemode("0o775"))
+        self.assertEqual(0o775, bb.utils.to_filemode(0o775))
+        self.assertEqual(0o775, bb.utils.to_filemode("775"))
+        with self.assertRaises(ValueError):
+            bb.utils.to_filemode("xyz")
+        with self.assertRaises(ValueError):
+            bb.utils.to_filemode("999")
+
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index a2806fd360d..1cc74ed5466 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1211,6 +1211,23 @@ def which(path, item, direction = 0, history = False, executable=False):
         return "", hist
     return ""
 
+def to_filemode(input):
+    """
+    Take a bitbake variable contents defining a file mode and return
+    the proper python representation of the number
+
+    Arguments:
+
+    -  ``input``: a string or number to convert, e.g. a bitbake variable
+       string, assumed to be an octal representation
+
+    Returns the python file mode as a number
+    """
+    # umask might come in as a number or text string..
+    if type(input) is int:
+        return input
+    return int(input, 8)
+
 @contextmanager
 def umask(new_mask):
     """

