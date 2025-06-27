Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE52EC77B7F
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 09:16:15 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.9271.1751015767983318322
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Jun 2025 02:16:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cqtaEm31;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so10282875e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 27 Jun 2025 02:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751015766; x=1751620566; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2eNXSBz028RPH9Q7FA5bB6TBdD8mkMFfjSGeMofwWr8=;
        b=cqtaEm31mAJ2T1Zg19nd5v2CI4mevW8Oqo1jPLZWmOFK9U/rnCP1iuAWFRmI1WJkdM
         wpwQtwtzy2m7sCOHci5ntBPNZ98JVewGKa3PeueRgFtciku6M/2RpVbuic+s0kmpTLg5
         9ww5sasBh/w5dXoVOFxAcqthgDIA/0iF5iXHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751015766; x=1751620566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eNXSBz028RPH9Q7FA5bB6TBdD8mkMFfjSGeMofwWr8=;
        b=u++xHVs3mJGocLM9zlTO04HE7ZV5A97PFtRgcjpqaibyo8hKd3HQlv8Y0glgAXRkr9
         ge2DuLb/80icyKjTN24jCnCcgjIAFm8ANcowR28g9zjOaMy+Hz+IpHLy4AURyPcbxbjn
         LSPaGTdWBeWYz+GFR+2dXg8bY7s66iZwy+8pqCPJC3EeHTWa7KQ5G+yAlPLrorLpYa4G
         b8NlmuyzGgEaj2/NcRQP2uZY/RTR3DOowob4gLCj005D3wggp0noupLCN9aSvi2koW59
         rNXyxDZCymK+ZqFLvljUS0ORhejoMHUb42EidhiZj4bW0TiFdMygFxzd7eukee8lT8mJ
         Ty7A==
X-Gm-Message-State: AOJu0YyGnXAqty2uHZe3RHASgx32Y1YsAnlyzRToVpEtiTiJsfdFyt9c
	xF2c+Sw7slkfvcjRr3o/nWVJLNrbsyZO6XnhnOhAFQbksOmPsC/udijCtL/qSd+HxStfdtBUOkc
	4nRW2
X-Gm-Gg: ASbGncve9hfx0Ic7DgijpuZ8x46QiB4exvdqk2ZMADYhbGW7cUrLm4aN/GBQ66jWcOl
	S3gDH4/y14eKxXItvosnQcmTDTCDw+gCS+IcnP/ALeKjeAiAEYpi+y0t5e5GuZ4BJj8ugPllGgC
	NqRtz9+bj9S4bxUMbNUXikaBF2dc8qd940XYYltqTVHG2Idbyc6drTF2iBHl1Ex59CcqE/kRW9N
	V73HHPTOpTzfngC13vprBZdXKF/NiP4VZOE9fx7d7ZAwbJ/icHEJOMMJ9k8/zNJbFh6XNrYQjqj
	EB7OR6w0+MeDnljMxFVCKo/LVbWkA26ETv7D8HZLQoLF9P+IjExLMwnCS05AOnO/a4UX/Eqiivc
	psM9VO5n/UnFv5+I=
X-Google-Smtp-Source: AGHT+IFZnURSx5XQP7IMJS6sMhM4ebuw8fjr8Qy57s4StPwWCYR6d7DuZNriZf0w07owVbW4LkVPbg==
X-Received: by 2002:a05:600c:1d1f:b0:453:8042:ba47 with SMTP id 5b1f17b1804b1-453921f420cmr7954485e9.19.1751015765885;
        Fri, 27 Jun 2025 02:16:05 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ef04:c18a:8ac7:33db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fa8aasm2124584f8f.27.2025.06.27.02.16.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:16:05 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] utils: Refactor filemode variable conversion to a function
Date: Fri, 27 Jun 2025 10:16:04 +0100
Message-ID: <20250627091604.3275870-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Jun 2025 09:16:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17719

We have other places in the code where we need to take filemode/mask
information from a bitbake variable and turn it into a real python
number. Turn this internal code into public API in bb.utils and
add some tests for it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker    |  7 ++-----
 lib/bb/tests/utils.py | 11 +++++++++++
 lib/bb/utils.py       | 10 ++++++++++
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 35fa1ab62be..9f33195176f 100755
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
+        bb.utils.to_filemode(umask)
 
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
index a2806fd360d..01f7cf81f46 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1211,6 +1211,16 @@ def which(path, item, direction = 0, history = False, executable=False):
         return "", hist
     return ""
 
+def to_filemode(input):
+    """
+    Take a bitbake variable contents defining a file mode and return
+    the proper python representation of the number
+    """
+    # umask might come in as a number or text string..
+    if type(input) is int:
+        return input
+    return int(input, 8)
+
 @contextmanager
 def umask(new_mask):
     """

