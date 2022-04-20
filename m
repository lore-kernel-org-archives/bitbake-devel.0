Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059DAC54F3D
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:08 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web12.7559.1650460944513547156
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=C2cIVLav;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id i20so2222982wrb.13
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JLynCYJlUkdO+NxDVBbLTENpwfD/FtQA2myc4RLQJqc=;
        b=C2cIVLavWDQ1h/+MqEXuXBA+A9NQFuD8VVwOQrN87N/KY4hoG86gEC72cSWUUiOxpP
         xeB01I9V20k1qP2okhh+rjmSwI4fft3oUXRchGd+UoXz3ARQll5inWwYhqjRozuNZ7Jh
         y4AYgvTl1mP67JWsN92zFMRb6J8N6vDiIlijI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLynCYJlUkdO+NxDVBbLTENpwfD/FtQA2myc4RLQJqc=;
        b=0WY9qLVIcLGdIb9GUykOS33IiXo3V+mbYzFBjLZuOWyA0wBWrI6Ai1Mcz4kJtbPN4B
         QWVEDpt4YBJPEcgrBPtXLLRObCF0uMm2VaBiBHIHP0EEsMbphuLV1sKM3AigjsSiF/W0
         JB/i93nLrp6r8uZSOg8/tZw/30yZaHmKm3kWLREvaQbD6Fw+YJoHzzu5pa8SyiuI8rfW
         w1FEkywgikLtuaf0C/FJEOWVtZdpeE+EdRXy0hu/Xh1t6bCFjKs+zXjqul+eKveVTnUg
         G/OczpSA2tAKa0gjKLrJtoND3RT9S6uXd5xmqQ6hsfAzRHUbhdMedMsiTn/GOqQhINta
         jKyg==
X-Gm-Message-State: AOAM533EIzpIvJ805AgdijjyTJTStzt/2IWnSGn1vxkJ4qYKK1LJjflf
	F7wG8mV4l39ui8UGuls8CSd2fkMzLOVSnQ==
X-Google-Smtp-Source: 
 ABdhPJxumPfvWpLcmvflekZySwDBb9JhuBNvKr0sCtjC4DjJpBug39gAvLtDvuZUEgtfzOBgOoiFDw==
X-Received: by 2002:adf:f2cb:0:b0:20a:77c2:3958 with SMTP id
 d11-20020adff2cb000000b0020a77c23958mr15222028wrp.589.1650460942696;
        Wed, 20 Apr 2022 06:22:22 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:9745:8b8f:81da:af07])
        by smtp.gmail.com with ESMTPSA id
 a7-20020adffb87000000b00207982c7f4dsm15213265wrr.67.2022.04.20.06.22.21
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:22:22 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 10/11] runqueue: Drop pointless variable assignment
Date: Wed, 20 Apr 2022 14:22:04 +0100
Message-Id: <20220420132205.2530591-10-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
References: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 16:46:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13652

This is set at the start of the loop anyway so it does nothing. Drop
the pointless code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a7a84630d7..a4e82f375c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2664,7 +2664,6 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
             sq_revdeps_squash[point] = set()
             if point in rqdata.runq_setscene_tids:
                 sq_revdeps_squash[point] = tasks
-                tasks = set()
                 continue
             for dep in rqdata.runtaskentries[point].depends:
                 if point in sq_revdeps[dep]:
-- 
2.32.0


