Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157E5C282D1
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 14:18:06 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.54193.1741011477872667423
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Mar 2025 06:17:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gv5Zy1+u;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bbd711eedso10442975e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 06:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741011476; x=1741616276; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yD9Gw/B8vGHBjf0nX8VGzsu6jaCaO9h0BRciHuq59kU=;
        b=gv5Zy1+uwD1xMUJOEjKITg37PPcsIq0ZEMXZ5mi1Fdfk7eLe2FC4mbsgHYaOAX4+/I
         rseLvehw/28eIGI1PqKp2tYP1uVDBXx4iAYZNMzzB6y2R/G2p3DslAyyI2BpRnSFPtp5
         OuHmMIEiW+uxIGAle36+rbWmuLi4Jwb8qTZew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741011476; x=1741616276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yD9Gw/B8vGHBjf0nX8VGzsu6jaCaO9h0BRciHuq59kU=;
        b=q4Ho8av/LP1yI3ECDpQNlVcf16vx3/lvLcdw3s8c2gt0ZZ513hmacqD4y0oBdnhQqa
         zllcSckUudrVGsFQ9jP/jl7D0qmiL/BRe2mKQ+cB5coNf76btQVbrYD07OW0XHcytoK7
         moP/iIIRPZ3+wt1XRodzRNzzkBscKu8+d4HR73/zAf3W/uU0Y5bJ5XuyPEYNXno6cdqw
         D0yywgys8sMncqGeEotgKUXXr1zo49EPvlzvhg9W8xILM8H1kOtIu8tJhk+lVaTbUdal
         Lz2pl+NTdYUGs0mUfzRZP4utn2yMd5vY8ZVBQmUMocZARneSRzDIjmq8ncDdoJdm99bh
         vuOg==
X-Gm-Message-State: AOJu0YzzScpAk8Sjb+Rhsa5RVh6VvkI5LJUDRMLa+hgzNCzDPZPRfGP/
	V1+9rRrEp9wweTcxlNaSXrS0XGwkdjmK2TeVDeWKgHXjouko9i2CJgKEV6CEajt4900ftm0DG0Q
	/
X-Gm-Gg: ASbGncuxR9q3D9L4QN32hvnOk76a/X265e2RafhsNNkiOsnCakW7+fu+VaGIvRkhOr/
	nWcrbM//jdbYvimO7KXO+29CAnMvSQvW4MVs5RNly8IVPdmM/FxDLN70NHTgDuROMxa55Y7VvtH
	sxFgm4DqYiPEBRXglB/xoU7AxLb5c0k5Acne5aw1/X7/SbgRtxXaVlz6aSlBg2oLmVh0Mq+cZIV
	3j4JvvLN3c+4InIRVPoX5V3fGeRngRzi3xRXlL9yvNdaQUovj8VSRiYKtN8Ol7ByRkl+Y5hZ5YX
	/2mRK40fc8oD2EiND2eXQmEAikommNNV0ZNgMKOL1B9w/9l0SjqmDtTZzVMHaENIk1ZZmnLF
X-Google-Smtp-Source: AGHT+IFqlxa/9YBcBOEklVB9gJzXC1CByXWoD4hOW2xD2U4ngUe60Bsp/HsnVDsS2Bx0r8X4JP2g2g==
X-Received: by 2002:a05:600c:4e49:b0:439:8e3d:fb58 with SMTP id 5b1f17b1804b1-43ba74a0f4fmr127213805e9.11.1741011475747;
        Mon, 03 Mar 2025 06:17:55 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c70:3037:60d2:90d7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7a2asm14761953f8f.37.2025.03.03.06.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 06:17:55 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Mark Hatle <mark.hatle@amd.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>
Subject: [PATCH] bitbake: runqueue: Verify mcdepends are valid
Date: Mon,  3 Mar 2025 14:17:54 +0000
Message-ID: <20250303141754.1677963-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 14:18:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17380

From: Mark Hatle <mark.hatle@amd.com>

In order to avoid a potentially confusing backtrace, check that the mcdepend
is valid when we add it.

Add a test case to ensure invalid configurations are caught and trigger an
error.

[RP: Reworked test case to simplify and improve code]
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py                        |  2 ++
 lib/bb/tests/runqueue-tests/recipes/g1.bb |  2 ++
 lib/bb/tests/runqueue-tests/recipes/h1.bb |  0
 lib/bb/tests/runqueue.py                  | 11 ++++++++++-
 4 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 lib/bb/tests/runqueue-tests/recipes/g1.bb
 create mode 100644 lib/bb/tests/runqueue-tests/recipes/h1.bb

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ad4ce0b0e2..8fadc8338e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -729,6 +729,8 @@ class RunQueueData:
                 if mc == frommc:
                     fn = taskData[mcdep].build_targets[pn][0]
                     newdep = '%s:%s' % (fn,deptask)
+                    if newdep not in taskData[mcdep].taskentries:
+                        bb.fatal("Task mcdepends on non-existent task %s" % (newdep))
                     taskData[mc].taskentries[tid].tdepends.append(newdep)
 
         for mc in taskData:
diff --git a/lib/bb/tests/runqueue-tests/recipes/g1.bb b/lib/bb/tests/runqueue-tests/recipes/g1.bb
new file mode 100644
index 0000000000..3c7dca0257
--- /dev/null
+++ b/lib/bb/tests/runqueue-tests/recipes/g1.bb
@@ -0,0 +1,2 @@
+do_build[mcdepends] = "mc::mc-1:h1:do_invalid"
+
diff --git a/lib/bb/tests/runqueue-tests/recipes/h1.bb b/lib/bb/tests/runqueue-tests/recipes/h1.bb
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index cc87e8d6a8..74f5ded2e6 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -26,7 +26,7 @@ class RunQueueTests(unittest.TestCase):
     a1_sstatevalid = "a1:do_package a1:do_package_qa a1:do_packagedata a1:do_package_write_ipk a1:do_package_write_rpm a1:do_populate_lic a1:do_populate_sysroot"
     b1_sstatevalid = "b1:do_package b1:do_package_qa b1:do_packagedata b1:do_package_write_ipk b1:do_package_write_rpm b1:do_populate_lic b1:do_populate_sysroot"
 
-    def run_bitbakecmd(self, cmd, builddir, sstatevalid="", slowtasks="", extraenv=None, cleanup=False):
+    def run_bitbakecmd(self, cmd, builddir, sstatevalid="", slowtasks="", extraenv=None, cleanup=False, allowfailure=False):
         env = os.environ.copy()
         env["BBPATH"] = os.path.realpath(os.path.join(os.path.dirname(__file__), "runqueue-tests"))
         env["BB_ENV_PASSTHROUGH_ADDITIONS"] = "SSTATEVALID SLOWTASKS TOPDIR"
@@ -41,6 +41,8 @@ class RunQueueTests(unittest.TestCase):
             output = subprocess.check_output(cmd, env=env, stderr=subprocess.STDOUT,universal_newlines=True, cwd=builddir)
             print(output)
         except subprocess.CalledProcessError as e:
+            if allowfailure:
+                return e.output
             self.fail("Command %s failed with %s" % (cmd, e.output))
         tasks = []
         tasklog = builddir + "/task.log"
@@ -314,6 +316,13 @@ class RunQueueTests(unittest.TestCase):
                        ["mc_2:a1:%s" % t for t in rerun_tasks]
             self.assertEqual(set(tasks), set(expected))
 
+            # Check that a multiconfig that doesn't exist rasies a correct error message
+            error_output = self.run_bitbakecmd(["bitbake", "g1"], tempdir, "", extraenv=extraenv, cleanup=True, allowfailure=True)
+            self.assertIn("non-existent task", error_output)
+            # If the word 'Traceback' or 'KeyError' is in the output we've regressed
+            self.assertNotIn("Traceback", error_output)
+            self.assertNotIn("KeyError", error_output)
+
             self.shutdown(tempdir)
 
     def test_hashserv_single(self):

