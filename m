Return-Path: <eng.redamaher@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6184BCA5FC1
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 19:43:16 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22423.1790797389737784165
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Sep 2026 12:43:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=JU83xxY3;
 spf=pass (domain: gmail.com, ip: 74.125.225.140, mailfrom: eng.redamaher@gmail.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so32519525e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Sep 2026 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790797388; x=1791402188; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kyp/y/bYmJlOfeeamQNWZG/IaUc6yU0PSrKHJscTnKw=;
        b=JU83xxY3f25uaxA4kkRGDQa38rmsI8x6pvHrRwT4fLzfzljQjKm0DhMDKuqocKRKl8
         N1TiTeU+jJ98ZtRWORgsOeVlb8FXdb5xhymjsCij8WMHeFDXghuySnGiFuLW5Q4jJyG+
         gNG1J/KZV93EMAiOGkuOJlKCAB19rymRIzXt5FUb2r2zZ3F8NHNjNTfo/hwQiUmS5U8u
         QsAtB5rd3013mpb3V1A098EAtGiJwFfe7rKykcORx9wcdg5Z9eBGsIXjA+P9ugrQOWdX
         SnUA13SLyeB/2yY3jZJtG8hRKkdihdk0VHI5dMHLgVFAzM3b43KTGEcdf80DV150Fnkb
         TfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790797388; x=1791402188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kyp/y/bYmJlOfeeamQNWZG/IaUc6yU0PSrKHJscTnKw=;
        b=qVH57EWIth0ZeHrulXfclhxuUKV6rTjEy3wuXCK0GoIyQM1SikUqWtLLgbSxVdsKzM
         1hX2+TO8FdjCaEwganZWU3Q2KVwTVSFzFZ9aPiZkzmRhHyf2jX1qhUQiR4yyq/a/X2+A
         IWHb5RD/+vxSsNHfhP0jNEe2ZsuvkyKHsjXyBVsZaMWRi+MflylWjHEsgSbf+9ZMAYt3
         v/FaUxR/bAJE3exu9Caenob+eInbzhkgW748ENdwfh8+bzCbA7HwPoCC/KaDlrwINpxO
         OR0a64yojRwCPmQtAseEF130cWbSYljQ3dY/IZ3vx4sYDuNd8LqbYF6PZe0/AXWqxMAs
         J7Mg==
X-Gm-Message-State: AFuF++lq9ZHeyWD5PYKVfks4KFCjqIo5Pd8PdwGPN9sdNR1aLc1tE9PW
	fcRCE6JErU7Gh8QZ3/WnQc+t9Z5vQy3wo+s4UZc7QXzkoKIBvEmpZyMxsWiUdw==
X-Gm-Gg: AYBFou3KnTIRRval3FA575cKEr1i/2Lb3pRMnvmYAY3indXBmfQBlo3jRLKHh/Q4aOW
	GB1xtSBiSHq+YPU17xa3I6kACj9q8fRDMp4L0edOb7MIklIkrpBHJevxo9CnjvOZao2mgpZeu7E
	WGx9MRxjhQn/cmHcg20+iIjBWISFfJ5w8busZx4Hj1u5xOS6RIWBTOZN/BsEsD0ddRct99DRG8l
	hlTDcTtYN+ApNxszL1zkaWv8YEEN01qvu4DPn8k1gMfJYoE3LzZeSsocqtjXx+0nkiEwZIBF4M/
	ZsIXhiwLbT98A6SCBr3l/UV8xofTcPMAbcLBNYulUCFE1Rm7uYthPj2BZlOgBdMEq/lTh2e95Q+
	vUrFMFso9SeVSxAoNxmDDlDYrNG7p5le4kR4GfNItPuCihjAF09NL1cSjMTnL5CjMiOOa3ZS2lD
	raxpMmpNmOmQSzqruXeX8k+H2ss+7VhoRYK94dyWwgI/NG7KFNTZFByKDvsXcxa9isspozk0UTT
	6qenK7L3w==
X-Received: by 2002:a05:600c:a00b:b0:4a0:1c69:f607 with SMTP id 5b1f17b1804b1-4a01c69f64dmr24969455e9.29.1790797387905;
        Wed, 30 Sep 2026 12:43:07 -0700 (PDT)
Received: from infinity.. ([102.40.16.91])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48b068bd8c9sm1312124f8f.2.2026.09.30.12.43.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:43:07 -0700 (PDT)
From: Reda Maher <eng.redamaher@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/process: Fix lock owner prefix check during shutdown
Date: Wed, 30 Sep 2026 22:43:06 +0300
Message-ID: <20260930194306.8490-1-eng.redamaher@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Sep 2026 19:43:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20285

Pass a tuple to str.startswith() when checking a contended lock during shutdown. The list raises TypeError before the server can retry its own lock or recognize a replacement server.

Add a deterministic shutdown regression test covering PID-only and XML-RPC lock records, including a replacement PID sharing the old PID's prefix. Verified failure before the fix and success with bitbake-selftest bb.tests.server afterwards.

AI-Generated: Uses GitHub Copilot

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
Signed-off-by: Reda Maher <eng.redamaher@gmail.com>
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
-- 
2.53.0


