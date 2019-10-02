Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id 3C5797EFD5
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Oct 2019 09:28:55 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id f22so6177556wmc.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Oct 2019 02:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=LHQJ/lR6f0W8kfSg7QAJUtTtsah8gs017uDrQGP3J1c=;
	b=bdmq8SvAWukbV0mhpVAyBZ70I5V4CLrTah6F4T4TJVJSLEw2CpAn3ll2TLVk0LBV37
	pXP3icMFhCy8IHUGviqr48wa2bpnpqJc7zcZKlx12tXd0k4m2ktSzrGePHPcVkiW+iwF
	km17Pd8KdGuW+HWgZs0LDH849CyGYxIzfxQ1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=LHQJ/lR6f0W8kfSg7QAJUtTtsah8gs017uDrQGP3J1c=;
	b=h64NWr5/UmjmAiLcTsTWR38GA0mMrIodGEmKXmZOuPZvQL9fTspofHeymZDbYqkGrJ
	gCAhKzt3SEU64DF1HGaxhJcAnqQva7FnOGtthXRUVxAy6A2k00k9t+iCJPKvIY6zbYiG
	UK7+joJpfE6G3gqsW4qZVcKnqlDACpAv7oh79FTRVfjjL1cmitaVascbyXbqCzcPoa7o
	5CvuNCZvUBJQ5tOMYdBwPg1YYpg138jnnYIZuJEiY5ML7AZg+0Ik10R1VIE1AYQqx6HO
	oE7wBKYXKLOU70rroXjjJNc+sF6BHbk3wY6jVYNSSW3fm6GeBnNEd7BsgBwfnxaqLVz9
	+vyA==
X-Gm-Message-State: APjAAAUq8yEMM6A4nwtTt0Cfx5w2+48BFo5hO9GE7Hog+mrFTXXxD2/f
	PjHWiuxJ7KaCO9lkwaMVaBVze1nY/Jw=
X-Google-Smtp-Source: APXvYqyayOApSdlFUT6xiTpHSIWI+mFO3oLHVsdqeicL3jk9exSVqdfa1Z16xUOox7cGIGRr+ZrDTQ==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr2168743wml.40.1570008535558; 
	Wed, 02 Oct 2019 02:28:55 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	u25sm5294414wml.4.2019.10.02.02.28.54
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 02 Oct 2019 02:28:55 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Oct 2019 10:28:53 +0100
Message-Id: <20191002092853.21251-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] tests/runqueue: Fix hashserve shutdown race
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 02 Oct 2019 09:28:55 -0000
Content-Transfer-Encoding: 8bit

The hashserve can delete its socket whilst the cleanup us happening leading to
backtraces and test failures.

Add code to avoid this race condition.

[YOCTO #13542]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/runqueue.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index 50b3392bc1..5e6439156d 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -12,6 +12,7 @@ import os
 import tempfile
 import subprocess
 import sys
+import time
 
 #
 # TODO:
@@ -257,6 +258,8 @@ class RunQueueTests(unittest.TestCase):
                         'a1:package_write_ipk_setscene', 'a1:package_qa_setscene']
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     @unittest.skipIf(sys.version_info < (3, 5, 0), 'Python 3.5 or later required')
     def test_hashserv_double(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
@@ -280,6 +283,7 @@ class RunQueueTests(unittest.TestCase):
                         'a1:package_write_rpm_setscene', 'b1:package_write_ipk_setscene', 'a1:packagedata_setscene']
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
 
     @unittest.skipIf(sys.version_info < (3, 5, 0), 'Python 3.5 or later required')
     def test_hashserv_multiple_setscene(self):
@@ -309,3 +313,11 @@ class RunQueueTests(unittest.TestCase):
             for i in expected:
                 self.assertEqual(tasks.count(i), 1, "%s not in task list once" % i)
 
+            self.shutdown(tempdir)
+
+    def shutdown(self, tempdir):
+        # Wait for the hashserve socket to disappear else we'll see races with the tempdir cleanup
+        while os.path.exists(tempdir + "/hashserve.sock"):
+            time.sleep(0.5)
+
+
-- 
2.20.1


