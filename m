Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29912.1793868568245253056
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Nov 2026 00:49:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google2 header.b=YI8mfa5X;
 spf=pass (domain: smile.fr, ip: 209.85.128.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso7331315e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Nov 2026 00:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google2; t=1793868566; x=1794473366; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SdhyeBhA3+/CtUEmu9/DmUkNDOd8igNCUX45Ae/7hcM=;
        b=YI8mfa5XwZYJghjpm01KIWFSS7AnJw5o8f6x9t/Wf+PUXNPavLumIKFpw3jcWqtBij
         gw7xJBiyEELO4rI9gyWeM/ukpRRGaK/vfcW6dwjlb9Puc+5Gn2LTJShirh9PYDYtvYsP
         C4sdFa9vuFKbBTP1BwdBiUTkXBHN+CC28PxC6gxc54eGnQbUnWfxi+RdR65TUfk2lxv9
         qjuLHEV7ltWyP7Woj/xPnSK16XaSYBcbxkk6LDzRZ5qDOtTji/zk4QisKbX45nOwjmsd
         ZvVLTvMUjENPmkfnojcaxsIVc/1qTYY9AU1O/WIG1NWBhn8raqH2/jBByxheL587+wcR
         KOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793868566; x=1794473366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SdhyeBhA3+/CtUEmu9/DmUkNDOd8igNCUX45Ae/7hcM=;
        b=1BDtXLxNf+rAguQ9JL1QFk8vyqw4qTTkWXxqM2c068D5jL9mE+f74RrMr3ShEqHUXT
         25LQnkdB/Jj5OPUfrhZanpfY8PTNFEapqobKyK9oxA/2QQ7QAiZAeRprsKWCqir/Zh6e
         nXRVHPTz4HJudRarC+5w042v/m9mJyBfSvtbt7i0gGwv2kxnoeEdH9EdZ9Fiqev7Nf20
         MXUDWk+pyUigPMnQQO4D1Hx3wQW9BcuiLriCl7ZiSqQ7p2a9GGnh2YV43jg464o4CJBH
         JWREmFT41Dn4+gAh57XbLbbR1nxghGQCGOnycAyJPwCUZpvTasFn0od6nNejo1NzyAxf
         P4zg==
X-Gm-Message-State: APuU4Z8KmOlincxUKU7QqmxlKLcVlEbEtMnHeOcRay4mOZCAc4eqRZJW
	nCLl5/v9fuu+lbuYR0MZdfqTiIP5Ne1AzcASkDy1pKNLrza1DPaqirRCmJBq9R4GST3IzRP5V6e
	s5aDw0UE=
X-Gm-Gg: AYBFou1XIBSNJiyt/g4POdcRxNDLv6cO2ClinUB1gJi6GEUIQL4kmTYJxw9DPqOnVCv
	XcaA9BXlH4z3UtLNDbHQALhX+A8YVwzdAXupjTag36iokBCy6MVX9kwNvXl0xRBXFHMKBjcSqyp
	vGBFywND1cFObb8OYLDk/epTmq8lDlcxaks0sVPJjAYJx2mIn1F6T7NrIiqNWQTuWBCJDI5iiMa
	HXEHWJOgca+2aH8dAXkvl8P8M5bWCW2GSYMa7RWacY6QSx9lZmSVLOpjSt8dE4dZ3Or9RHcxbwr
	bOv7fG03NPiavnBhs/71FfarxBHktZjfRXThRxAMGSNmCQUtdK01W9t3CXa4vvUUvNQMj2NNdGQ
	hswZFfGdRNzfCxwGsQ82s3C4NoUbGjrsrtbED2EY46qmy4XeO7bJtdWCBlJKn7Z2eDTc9B1nRsL
	fb6kPHHrbGKuD0H8wZiPojFxlR8ez76IuUM1x7x2KTi/XXNQiCZL7buuPugar73jvridYcWG+Xv
	9GyOm954PVYJFPt0rxi4/1vh0YQnMRsDdTL8FDI/DRxqPyRbpy7YCi26J7hxr7eimkbQ0PJ8cqa
	8IwBwWTKxHkCIXNH7yD4a0v6+Wb9SQd66wkLaimkQS64vRLODaF2/28OcHgbXyg7EWtye3vJA9d
	jxH866aoP4E0zq4Vgk7YZ8MXHFmQY
X-Received: by 2002:a05:600c:8b6a:b0:4a1:e6c8:ff74 with SMTP id 5b1f17b1804b1-4ac17e10acemr380032025e9.29.1793868566390;
        Thu, 05 Nov 2026 00:49:26 -0800 (PST)
Return-Path: <yoann.congal@smile.fr>
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fedc09675sm8631012f8f.55.2026.11.05.00.49.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:49:26 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][blacksail][2.20][PATCH 1/1] server/process: Fix lock owner prefix check during shutdown
Date: Thu,  5 Nov 2026 09:49:23 +0100
Message-ID: <7f7ae8cd58993a389adbd130b07ea5de8415d2f9.1793868515.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793868515.git.yoann.congal@smile.fr>
References: <cover.1793868515.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 05 Nov 2026 08:49:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20396
Content-Type: text/plain; charset="utf-8"

From: Reda Maher <eng.redamaher@gmail.com>

Pass a tuple to str.startswith() when checking a contended lock during shutdown. The list raises TypeError before the server can retry its own lock or recognize a replacement server.

Add a deterministic shutdown regression test covering PID-only and XML-RPC lock records, including a replacement PID sharing the old PID's prefix. Verified failure before the fix and success with bitbake-selftest bb.tests.server afterwards.

AI-Generated: Uses GitHub Copilot

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
Signed-off-by: Reda Maher <eng.redamaher@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(cherry picked from commit 1763256342ae4d7f8028e8222400c6fc8c24d4a3)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 bin/bitbake-selftest     |  1 +
 lib/bb/server/process.py |  2 +-
 lib/bb/tests/server.py   | 57 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 lib/bb/tests/server.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 855abb1f0..e5a68ba1d 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -35,6 +35,7 @@ tests = ["bb.tests.codeparser",
          "bb.tests.fetch_import",
          "bb.tests.parse",
          "bb.tests.runqueue",
+         "bb.tests.server",
          "bb.tests.setup",
          "bb.tests.siggen",
          "bb.tests.utils",
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index d0f73590c..a103b0987 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -377,7 +377,7 @@ class ProcessServer():
                 lock = bb.utils.lockfile(lockfile, shared=False, retry=False, block=False)
                 if not lock:
                     newlockcontents = get_lock_contents(lockfile)
-                    if not newlockcontents[0].startswith([f"{os.getpid()}\n", f"{os.getpid()} "]):
+                    if not newlockcontents[0].startswith((f"{os.getpid()}\n", f"{os.getpid()} ")):
                         # A new server was started, the lockfile contents changed, we can exit
                         serverlog("Lockfile now contains different contents, exiting: " + str(newlockcontents))
                         return
diff --git a/lib/bb/tests/server.py b/lib/bb/tests/server.py
new file mode 100644
index 000000000..a1ec76e19
--- /dev/null
+++ b/lib/bb/tests/server.py
@@ -0,0 +1,57 @@
+#
+# BitBake Tests for server/process.py
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import os
+import tempfile
+import unittest
+from unittest.mock import Mock, patch
+
+from bb.server.process import ProcessServer
+
+
+class ProcessServerTests(unittest.TestCase):
+    def test_shutdown_contended_lock(self):
+        pid = os.getpid()
+        for owner in (str(pid), str(pid) + "0"):
+            for suffix in ("\n", " 127.0.0.1:12345\n"):
+                with self.subTest(owner=owner, suffix=suffix):
+                    with tempfile.TemporaryDirectory() as tmpdir:
+                        lockname = os.path.join(tmpdir, "bitbake.lock")
+                        sockname = os.path.join(tmpdir, "bitbake.sock")
+                        with open(lockname, "w") as stream:
+                            stream.write(owner + suffix)
+                        with open(sockname, "w"):
+                            pass
+
+                        lock = Mock()
+                        sock = Mock()
+                        server = ProcessServer(lock, lockname, sock, sockname,
+                                               0, (None, None))
+                        server.cooker = Mock()
+                        server.quit = True
+                        acquired_lock = Mock()
+                        own_lock = owner == str(pid)
+                        attempts = [None, acquired_lock] if own_lock else [None]
+
+                        with patch("bb.server.process.bb.utils.set_process_name"), \
+                             patch("bb.server.process.os.path.exists", return_value=True), \
+                             patch("bb.server.process.bb.utils.lockfile", side_effect=attempts) as acquire, \
+                             patch("bb.server.process.bb.utils.unlockfile") as unlock, \
+                             patch("bb.server.process.time.sleep") as sleep, \
+                             patch("bb.server.process.serverlog"):
+                            server.main()
+
+                        lock.close.assert_called_once_with()
+                        sock.close.assert_called_once_with()
+                        server.cooker.shutdown.assert_called_once_with(True, idle=False)
+                        self.assertEqual(acquire.call_count, 2 if own_lock else 1)
+                        acquire.assert_called_with(lockname, shared=False, retry=False, block=False)
+                        if own_lock:
+                            sleep.assert_called_once_with(0.1)
+                            unlock.assert_called_once_with(acquired_lock)
+                        else:
+                            sleep.assert_not_called()
+                            unlock.assert_not_called()
