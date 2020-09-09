Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
 by mx.groups.io with SMTP id smtpd.web10.8188.1599689346416550406
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Sep 2020 15:09:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=acjD5RVk;
 spf=pass (domain: gmail.com, ip: 209.85.210.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f49.google.com with SMTP id n61so3654813ota.10
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Sep 2020 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OXNTnh1pAbfq7c1Ky4iL6G7VeU4vVGHdws4rFf6lb2I=;
        b=acjD5RVkmGRm6hCFRUq2JlRpjWRipdKDfwTcGzEeTlppYqPfh8SqtmvhKNYezWLu3h
         gzKhTvukvIO8j3jHu4fvwsAALUzGwnQ/j5adlpuyyjpGuARhBCpZtJnhwjqd4lPWBEar
         J3LCseVAX0C6YISXzMrq59kZxm6Kunri75sRsOi/yBA8O0RCGr6P1CPjtN0ZG+Lt2OEm
         zGJlSy0FQK661VYHBrbH6VDr8mOvGQ/X/1768DxZw8bX7F3NeLKCf3LFks83ozJQ8k2w
         1rRjLt2SojKnIfRRcrwzOvkI/RrVCScukRtHfkUNQw0CveV6qbjp6enwz65/23dgxl+S
         0c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OXNTnh1pAbfq7c1Ky4iL6G7VeU4vVGHdws4rFf6lb2I=;
        b=g/X4lTUrDFkkNqi2nrXAzTGj4PTpq/BhQHldrMD2Rvri1AY1B7ENQX6hfsF3KObxJf
         VvS5EXiiA7fcXbeqT0qaMikLk1VurIyueqi4w9rMhka+fAWvX1CVZnlWyJzXWTC1rWD7
         fdQbzkxoKm/EzCApui/QdB1cEr8cFw5YhsF3IdgpLSNnb2KbLyV75zrRtwNDqmk35xmm
         iN/UEE2M8mqkHIrwjalp91/O4MDkfJVXWhpsMMF8QTyHYgsvbQv/kxIR+4fV9KQLwSqu
         pHTbWUp4sQdne5C9IlOS2ppGBqweCHBU79bGTVRpZn0SAzIJd9Pxa2dwg+vk1QndrAhS
         jEhA==
X-Gm-Message-State: AOAM531rnt4jzRKAeRCiM7xrBjzSLfzZ8Me+EH2M7b4khw4eZyAUMhvQ
	bktGvupktKs/fz5rpV1cbRzMyvFVwQE=
X-Google-Smtp-Source: ABdhPJwjV8icQAsv+El07/PUkH7vDTRilNmzNlFmt5/AiHwauNdBAZgDxbhFfnACpxVLgfqU9bfB1Q==
X-Received: by 2002:a9d:1d08:: with SMTP id m8mr2172337otm.49.1599689345389;
        Wed, 09 Sep 2020 15:09:05 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:7282:816:6ef9:8e8c])
        by smtp.gmail.com with ESMTPSA id n61sm551895otn.34.2020.09.09.15.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 15:09:04 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake: Add parsing torture test
Date: Wed,  9 Sep 2020 17:09:01 -0500
Message-Id: <20200909220901.29740-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a contrib/ script that repeatedly runs bitbake and interrupts
parsing to try and reproduce parsing deadlocks.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/contrib/bbparse-torture.py | 89 ++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100755 bitbake/contrib/bbparse-torture.py

diff --git a/bitbake/contrib/bbparse-torture.py b/bitbake/contrib/bbparse-torture.py
new file mode 100755
index 0000000000..c25d547bb8
--- /dev/null
+++ b/bitbake/contrib/bbparse-torture.py
@@ -0,0 +1,89 @@
+#! /usr/bin/env python3
+#
+# Copyright (C) 2020 Joshua Watt <JPEWhacker@gmail.com>
+#
+# SPDX-License-Identifier: MIT
+
+import argparse
+import os
+import random
+import shutil
+import signal
+import subprocess
+import sys
+import time
+
+
+def try_unlink(path):
+    try:
+        os.unlink(path)
+    except:
+        pass
+
+
+def main():
+    def cleanup():
+        shutil.rmtree("tmp/cache", ignore_errors=True)
+        try_unlink("bitbake-cookerdaemon.log")
+        try_unlink("bitbake.sock")
+        try_unlink("bitbake.lock")
+
+    parser = argparse.ArgumentParser(
+        description="Bitbake parser torture test",
+        epilog="""
+        A torture test for bitbake's parser. Repeatedly interrupts parsing until
+        bitbake decides to deadlock.
+        """,
+    )
+
+    args = parser.parse_args()
+
+    if not "BUILDDIR" in os.environ:
+        print(
+            "'BUILDDIR' not found in the environment. Did you initialize the build environment?"
+        )
+        return 1
+
+    os.chdir(os.environ["BUILDDIR"])
+
+    run_num = 0
+    while True:
+        if run_num % 100 == 0:
+            print("Calibrating wait time...")
+            cleanup()
+
+            start_time = time.monotonic()
+            r = subprocess.run(["bitbake", "-p"])
+            max_wait_time = time.monotonic() - start_time
+
+            if r.returncode != 0:
+                print("Calibration run exited with %d" % r.returncode)
+                return 1
+
+            print("Maximum wait time is %f seconds" % max_wait_time)
+
+        run_num += 1
+        wait_time = random.random() * max_wait_time
+
+        print("Run #%d" % run_num)
+        print("Will sleep for %f seconds" % wait_time)
+
+        cleanup()
+        with subprocess.Popen(["bitbake", "-p"]) as proc:
+            time.sleep(wait_time)
+            proc.send_signal(signal.SIGINT)
+            try:
+                proc.wait(45)
+            except subprocess.TimeoutExpired:
+                print("Run #%d: Waited too long. Possible deadlock!" % run_num)
+                proc.wait()
+                return 1
+
+            if proc.returncode == 0:
+                print("Exited successfully. Timeout too long?")
+            else:
+                print("Exited with %d" % proc.returncode)
+
+
+if __name__ == "__main__":
+    sys.exit(main())
-- 
2.28.0

