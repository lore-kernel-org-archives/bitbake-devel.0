Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F29C433FE
	for <webhook@archiver.kernel.org>; Mon, 25 Oct 2021 21:31:10 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web08.3573.1635197469041224320
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Oct 2021 14:31:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MyzBdmLj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id w15so11624596wra.3
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Oct 2021 14:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WUayZqgvvsEaAtDLN1X4l4t60nN/9RaXTUcuhjKy5oQ=;
        b=MyzBdmLj3hosPZmFSLFzYqWbRj6EkS0GBPvFnRlT7Zg+l+UB6ON/11V47Ap3tLP73+
         xXoE6INbjE6dAnqG76jRDeRpVQ/lK2yHKAWBErgz+6Fpg/sBeCp+MPHhRRdnICNY9m82
         SfHSwE2v58KMg2yTR2bxRD2/igaKuAbBBvBQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WUayZqgvvsEaAtDLN1X4l4t60nN/9RaXTUcuhjKy5oQ=;
        b=wDuWKB4hbTn8ydek1SxC3xgpFx1DaDuH60GqXIW4cGkc0hwY4gsbD/sjv4tcVEm/fd
         cCxqehucvvs86uuEm30/oZvq3ZrP85VqKQKLsSPUjid0a57N+xiUPWDE9skOz7bBFOWz
         smRB2EkP4K635mfC4G3ECBgFmhBI9nG8Dt5O5XLU1NonTpikEK25n6bxOGIYJhBXo58W
         vl3lqgQLJvGGvDidpqZHE34sG7LBqaA2NizpHd5xXWZ5IvV9wcT1VF8GeEGqKzwGn4F7
         BMqmKOE4wiRYSXoAcuQ4A1jTsNhLsyqCeDhqUsqvLPU67n51U3fiIDkOBL/48WylmplS
         d2dQ==
X-Gm-Message-State: AOAM532v2mG4ih8y6El6gYUbhQ+G0vv3om3aUaFhXWVhUjwWL83+cCYj
	WeM1m2lQoSSTQoe0gRWL6hcjvr7nHZ6Rkg==
X-Google-Smtp-Source: 
 ABdhPJwNAdI5VJo5dQ50u1Qj8zFl5FYMsZ7JN07nNytbLRQJo/A7Hh3kNFPq+/sh7W23hh9vrctEhw==
X-Received: by 2002:a5d:64a6:: with SMTP id m6mr27152884wrp.100.1635197467223;
        Mon, 25 Oct 2021 14:31:07 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:6b9e:385e:1583:4f40])
        by smtp.gmail.com with ESMTPSA id
 d3sm18095317wrb.36.2021.10.25.14.31.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:31:07 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/runqueue: Drop python version test decorators
Date: Mon, 25 Oct 2021 22:31:06 +0100
Message-Id: <20211025213106.3283255-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Oct 2021 21:31:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12828

Our minimum python version is 3.6 so these are now unneeded.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/runqueue.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index 4f335b8f19..5b6ada886a 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -278,7 +278,6 @@ class RunQueueTests(unittest.TestCase):
                        ["mc_2:a1:%s" % t for t in rerun_tasks]
             self.assertEqual(set(tasks), set(expected))
 
-    @unittest.skipIf(sys.version_info < (3, 5, 0), 'Python 3.5 or later required')
     def test_hashserv_single(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             extraenv = {
@@ -304,7 +303,6 @@ class RunQueueTests(unittest.TestCase):
 
             self.shutdown(tempdir)
 
-    @unittest.skipIf(sys.version_info < (3, 5, 0), 'Python 3.5 or later required')
     def test_hashserv_double(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             extraenv = {
@@ -329,7 +327,6 @@ class RunQueueTests(unittest.TestCase):
 
             self.shutdown(tempdir)
 
-    @unittest.skipIf(sys.version_info < (3, 5, 0), 'Python 3.5 or later required')
     def test_hashserv_multiple_setscene(self):
         # Runs e1:do_package_setscene twice
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
-- 
2.32.0


