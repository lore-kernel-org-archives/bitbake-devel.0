Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEBDCD5BA4
	for <webhook@archiver.kernel.org>; Tue, 19 May 2026 23:34:02 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1022.1779233637399871256
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 May 2026 16:33:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=D2KIoLbL;
 spf=pass (domain: smile.fr, ip: 209.85.221.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43fe608cb92so2604078f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 May 2026 16:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779233635; x=1779838435; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LHdB/uOKajKDnXtuLwxCZC08y2L5uxMgG7Njw7Dw1U=;
        b=D2KIoLbLoiGtveMht49GbG5F00/9GjBHZ+YQZ3HCbH4+ssV8RbyhRtjcE5F/KdgDKz
         lTfSQhe8osLGhwlF+Y/lFc85gIPxTChK6DLT1gW4ENf+W9OYI4oaAa0p8xRrkRl2QA42
         qD4cc5zAlbsPVF3OPBpnnqOf3/TnjawS7PK/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779233635; x=1779838435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5LHdB/uOKajKDnXtuLwxCZC08y2L5uxMgG7Njw7Dw1U=;
        b=BaP4ZHx30L3ELMkuDpHIezQ/7mbOBkf0WrNM4L6N7vdpcozrGt10GFSnjPqEgq4rC5
         5OgvmrZ2L5xsDNO44JYHBzwXbnFC8VSSzqlvNeluoLeUm0S0k7T99PB0UtV+jVElZ+2k
         1Zs1cnJ5kTGjaNRfgPHaSewvC/CSAsA/W2OXCioLYsgQYkv0KGzGWH1Ko2CHX0x2kv/I
         vnFHjd0czJ1jo3XmvZxg2BlzDt7paobiRHM6z43tdwPLLuRATk3936cuvmAQr9cjuQr7
         QGgPeI4H/9JBteOxZKsEAA2O/E+OpZUFhO1Q656Ub8WyUz88oXSVS5PV73LEDLv8vGpP
         +7SA==
X-Gm-Message-State: AOJu0YzB/cGohEufbZV9DdhRcsHZj0PE0X7nAC4BE2ovnQv4e3HBguIn
	rKqBR6FTELISNbEEHQS6u2V5MjzMWAg4gjscZUDOJInTeQcJdz3JzJxOgqPIUUQ5xUKK3U/pLB+
	TU8Qh
X-Gm-Gg: Acq92OGLtL1s8dwWBa8h2gGRDLZ01UIFAFIf1EJzZ8FBb95tJ0P8bXdTlF8XFggpZZ1
	poCM/9FSgLKDUp2cbHZQOyOk78++FLIcrMCrTVBzWP0SReRVJxmavhr55Ie7l+j2gY2GgXnf0Vx
	1L2nKfHyFwUMc84dRhk494MfwMRGsTTM/55pi149qc3a/cRrqMKmI+78BMBDvMgyFM3Xy96cGfN
	orgUS/H8+5McNAif/pzk9kv6w/ZktJA8A5IKtUZ2Lzurm+9hdWim5hLv9JLmp+l8PyGQL0hrL+T
	N4ciTj/Yzz/f6fK7EY8sRoKDoCI0IOtxwL5JXegH8HYORNz8BVh5e8bPnYD8QD1NAOzje3LvrEf
	0f/K8iMSdjRXSDgUlCJf3Rg8uFAUhVAxhkIV0UliXImZrPpW+5XH8OS8Npe7sf/Mt16A+SYCm2N
	P6zGABp7Iq2Q5yMpmVP5efkSosnRTvnJpbOV9Cfcm4I4oaqSJqJsVpKAcx1qDVqpcEshddcGRxb
	Cq5zogh7cfRMMczROtiba1KfmfxVHKzPoF6TQ==
X-Received: by 2002:a05:600c:4e46:b0:48a:75b9:5e07 with SMTP id 5b1f17b1804b1-48fe60d576dmr345294105e9.11.1779233635543;
        Tue, 19 May 2026 16:33:55 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88495sm349517665e9.4.2026.05.19.16.33.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:33:55 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 2/3] b4-config: add send-prefixes for 2.18/wrynose
Date: Wed, 20 May 2026 01:33:45 +0200
Message-ID: <1b64da8f2a7d93908ea79eb839291ab7f6febdbc.1779233514.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779233514.git.yoann.congal@smile.fr>
References: <cover.1779233514.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 May 2026 23:34:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19545

From: Yoann Congal <yoann.congal@smile.fr>

That might help new users send correct first stable patches.

Cc: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 .b4-config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.b4-config b/.b4-config
index 047f0b94a..4d9ab7bd0 100644
--- a/.b4-config
+++ b/.b4-config
@@ -2,3 +2,4 @@
   send-series-to = bitbake-devel@lists.openembedded.org
   send-auto-cc-cmd = ./contrib/b4-wrapper-bitbake.py send-auto-cc-cmd
   prep-pre-flight-checks = disable-needs-checking
+  send-prefixes = 2.18

