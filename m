Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D89C4167D
	for <webhook@archiver.kernel.org>; Wed,  8 Nov 2023 22:05:00 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.105597.1699481090690294075
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Nov 2023 14:04:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GOPoW6Sm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4079ed65582so931435e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Nov 2023 14:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699481089; x=1700085889; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iq2XsGRn4ikXiRWtqXAmNcskUB0X74jq0q5iwsjGXfg=;
        b=GOPoW6SmDrs9y/NM6o4Dfo+RP9dybPVthtwgzQZ/lXGYWaQqB2UqFrUe1prlf4WGJB
         P8Re8hfUmaslA1tD745obAnihLmTzd28Ik1ROphlkeAV9tObCNE8V5ogLt3HJrugkSun
         myFVPm1tYlae+nIXvbU65MLt/Qa7V1rnTyj7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699481089; x=1700085889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iq2XsGRn4ikXiRWtqXAmNcskUB0X74jq0q5iwsjGXfg=;
        b=QEQd7WRyZ8OUhGNDfzlgMj+SerVpVcEyvsMwOhmj4Ocf0xQo6F4iGa09RzmjTbqZnX
         iLtvBMBSpgfLrOw2zO2GMZWrp/EbYOODWXYb7l2SVKvat+EhjCJ2C3+ayNTg2JJjd+iq
         u2D4RfDx82Y+0we+mfGlHwtgelhjvdPEyks3raukdQh+1gwaQTiIHcgWytGWpmPelCFh
         fd+NOMEpfLSjvU2h7JczCOIKlQPw0XBEFIuC9ChLbJQDAKeatQw978J8mkwtKLqriZSA
         +k5YBhdschhJMQtve3ZxYZw/01MjF21u6TM3NrEdiz3t/YRyJ3ydLsQOjcEOE3Kx+hUa
         P5Fw==
X-Gm-Message-State: AOJu0YxwksV9s/G2ej8QJkW9T2AkCIm3LwdUOOqd0SKGRIzGco2mjgnd
	7K6ZyS7xoL1lEbLCRb9EEcU0mwXxmjBT0WtwesI=
X-Google-Smtp-Source: AGHT+IEcGTtyR6stEJDfqAol9uSbC1fSs++skyEPSAPwGURlcjv6h72ebtuY4e/KUepiltTLRqce+w==
X-Received: by 2002:a5d:43c7:0:b0:32d:b051:9a27 with SMTP id v7-20020a5d43c7000000b0032db0519a27mr2495908wrr.20.1699481088699;
        Wed, 08 Nov 2023 14:04:48 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:7d6a:4777:87ed:703e])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d5503000000b003233b554e6esm5853531wrv.85.2023.11.08.14.04.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 14:04:48 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] runqueue: Fix runall option for setscene tasks
Date: Wed,  8 Nov 2023 22:04:46 +0000
Message-Id: <20231108220447.1557586-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Nov 2023 22:05:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15450

If --runall is used with setscene tasks, it will still skip them if it
can. By marking the tasks as targets, this avoids that skipping
and means --runall deploy_source_date_epoch works as expected for
example.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 1029eec07a..074edd0763 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1021,6 +1021,7 @@ class RunQueueData:
 
                 for tid in list(runall_tids):
                     mark_active(tid, 1)
+                    self.target_tids.append(tid)
                     if self.cooker.configuration.force:
                         invalidate_task(tid, False)
 
-- 
2.39.2


