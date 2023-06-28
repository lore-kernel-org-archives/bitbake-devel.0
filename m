Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35925EB64D7
	for <webhook@archiver.kernel.org>; Wed, 28 Jun 2023 11:26:27 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web10.13633.1687951580284297042
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jun 2023 04:26:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=TfrailCT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso4933879e87.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jun 2023 04:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1687951578; x=1690543578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yKyS6iI1XfaLMy9osnnvTbimbndD6k7FEXU9GJi8pJc=;
        b=TfrailCTn0YNgUrinUwvnpEG+aeUcjv3+khz3u3NfONfP0gJaarA/+07ZbxvCCFV5c
         qajlE07yKpGULBB1Bvf9g5WPuSrhsqqQp4oax4L3ciDDlTXbMDRMqvO2FfSfxJovXi9B
         waXai0vYDm43YaY+bqL0Up477PC463vzXF0Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687951578; x=1690543578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKyS6iI1XfaLMy9osnnvTbimbndD6k7FEXU9GJi8pJc=;
        b=KLXCLCuclyoIH0T+ecONegswhzQOEh34nipxOmOADxSjenI0ZB9zuYrGicA/BrbWGj
         GgXtJquaYLs6WIfFUJ+XIq31qbzv13zqAljRAhVD+ZQnszZo++gF9ZO4VfYZk1uTZ7vI
         Tqle5/Nl4s8X4+uB2JZf/+BWYSOJtPrMHsKifS1KetUvWQt0HO8sGb6qW+dlQ6k1cQWG
         OkImEM62wlKOwyP6X5kwdXDt7nR53H9qrfSml1rEzCooRjqkVeHwMsq2DLoJ/hgjlyBA
         FC1PAElo7O0rmbU5xgE/sFd2zY+cU0p/kWYSYikP6H4D4HzSoRjW0PbtfSRZAK1B+Kzk
         Dm3A==
X-Gm-Message-State: AC+VfDzNeXMB6qmEgGCRn4r6b5SR0H8uqRUvWjHnPv/zpp8gC0O1y8Xg
	d+zoE3AMU4MMGkS1OjPcs4mlr5VpvhCNIYZKEM8=
X-Google-Smtp-Source: ACHHUZ7jXlBcCQ4G9ck3t5m1EGMT4LZG1Z/Ebx67eA0Or+N5wCxmOijKD2eFQV6+0Iqep0Jq6b7Uqg==
X-Received: by 2002:ac2:4bd0:0:b0:4fb:b11:c99e with SMTP id o16-20020ac24bd0000000b004fb0b11c99emr7611266lfq.56.1687951577739;
        Wed, 28 Jun 2023 04:26:17 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a71a:20d6:74fc:9334])
        by smtp.gmail.com with ESMTPSA id x19-20020a1c7c13000000b003fbb0c01d4bsm1613382wmc.16.2023.06.28.04.26.17
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:26:17 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Fix deferred task/multiconfig race issue
Date: Wed, 28 Jun 2023 12:26:16 +0100
Message-Id: <20230628112616.2502709-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jun 2023 11:26:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14866

If there are several multiconfigs in play for example a non-multiconfig with
a task with one hash and then three multiconfigs for the same task, different
architectures but the same hash (different to the non-mc), the three mcs
will be deferred until after the non-mc task but then will all run together
and race against each other.

Change the code to re-enable deferred tasks one at a time. This way, if they do
race, they won't run in parallel against each other.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 0bb3bc20ab..241a746ebb 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1991,11 +1991,19 @@ class RunQueueExecute:
                 self.setbuildable(revdep)
                 logger.debug("Marking task %s as buildable", revdep)
 
-        for t in self.sq_deferred.copy():
+        found = None
+        for t in sorted(self.sq_deferred.copy()):
             if self.sq_deferred[t] == task:
-                logger.debug2("Deferred task %s now buildable" % t)
-                del self.sq_deferred[t]
-                update_scenequeue_data([t], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
+                # Allow the next deferred task to run. Any other deferred tasks should be deferred after that task.
+                # We shouldn't allow all to run at once as it is prone to races.
+                if not found:
+                    bb.note("Deferred task %s now buildable" % t)
+                    del self.sq_deferred[t]
+                    update_scenequeue_data([t], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
+                    found = t
+                else:
+                    bb.note("Deferring %s after %s" % (t, found))
+                    self.sq_deferred[t] = found
 
     def task_complete(self, task):
         self.stats.taskCompleted()
-- 
2.39.2


