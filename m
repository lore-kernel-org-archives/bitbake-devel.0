Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BFDC433FE
	for <webhook@archiver.kernel.org>; Sun, 13 Nov 2022 23:30:16 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web08.52.1668382213748756333
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Nov 2022 15:30:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=NG50xNYK;
 spf=pass (domain: gmail.com, ip: 209.85.215.176, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f176.google.com with SMTP id f3so2457235pgc.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 13 Nov 2022 15:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHipGZxiffY/h2ka4lJe2MrOSBsPu+HpfqFtTrjTAJU=;
        b=NG50xNYKJVA7SM277VMIYm6OMWNd0AgtnLgkj697+E1T+c/Cq13Ol7AbqsOc0n6TOx
         uDBK3iogcpXpjf4HrDymAtYPSMNHWuwinzhbrsImqK4xmmxV4Tgvn2zrh206Z+uxuDDW
         jP8a03Wcq3qu0mn/GFpZg//ZD1MQf3hyEbBkE/0o+4MwQTfIqa6KE4XDZ+toY4qljvBC
         VqKwU0P9t1DPFuRSG4TvJhLI0rH/U3CSFU1xF0qMt1+rsa8cNtOf8iSUQfVvvCAcLenK
         3IbgjEsja2ehI5B6/xjY7QFAmL3BPZz6OvqSlzfvuBFyU3I3kaSLDeOKveW1fE22p6y5
         sjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHipGZxiffY/h2ka4lJe2MrOSBsPu+HpfqFtTrjTAJU=;
        b=36Adf+dhGaAiLijwHkNUfBPA3Zrhdr7ffbY6ITKC+Nz3ti2HGBBzWVu/jk5HxtZrfK
         1Lv/NE7jICwKUnW9U2XpoFg/bq4dmHQbTGFwSO/ya8kjpwvEc1vDfias4xi2ujtTFWNE
         hhvZjBxAfI7A2x1DQKDvUV53FCuNBSDLboCrZIFul8YWLrx1jIW0ZG6gYmQYwzXCrT0/
         gCQkO2EW+LSIBmSEm+z4BksBJtDBjIrjqIxkYBV9r94CWE53GldrtWedbisRsoH3QWxK
         NfUB8TGXHCfWnh7JI6TpAuS3eKKufyqJNvYEbxGPdC3emwgHa1EWFze9FsXLjQjg+/Lp
         sNeg==
X-Gm-Message-State: ANoB5pkU8doBZwHoerBEFwVAg09iDFZHwSyFwmLvShCG1lk/a0S/3EHB
	oQaQQLL2cMVI9iEjzJbNX1ubcvDTtLuotg==
X-Google-Smtp-Source: AA0mqf4wc4CEX7EcDHmIIi1eJuTPl66e8v3oZ/ddbwGjSGTHP7GkO1pHIycVyJ6yV7+mbYt7V/+Yeg==
X-Received: by 2002:a63:5415:0:b0:470:4523:1b90 with SMTP id i21-20020a635415000000b0047045231b90mr9741962pgb.463.1668382212548;
        Sun, 13 Nov 2022 15:30:12 -0800 (PST)
Received: from chiron.hsd1.or.comcast.net ([2601:1c0:ca00:cea0:4998:ee9c:6c85:68ed])
        by smtp.gmail.com with ESMTPSA id c129-20020a621c87000000b00561b3ee73f6sm5404438pfc.144.2022.11.13.15.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 15:30:12 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Subject: [PATCH 1/3] toaster: fixtures/README: django 1.8 -> 3.2
Date: Sun, 13 Nov 2022 15:30:01 -0800
Message-Id: <20054aaad11f52427b4a97602dcbd7d8518cbcdd.1668381699.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1668381699.git.tim.orling@konsulko.com>
References: <cover.1668381699.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 13 Nov 2022 23:30:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14078

We should reference the docs for the current LTS version we are using.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/toaster/orm/fixtures/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/fixtures/README b/lib/toaster/orm/fixtures/README
index 1b1c660aa..7cd745e26 100644
--- a/lib/toaster/orm/fixtures/README
+++ b/lib/toaster/orm/fixtures/README
@@ -27,4 +27,4 @@ Data can be provided in XML, JSON and if installed YAML formats.
 
 Use the django management command manage.py loaddata <your fixture file>
 For further information see the Django command documentation at:
-https://docs.djangoproject.com/en/1.8/ref/django-admin/#django-admin-loaddata
+https://docs.djangoproject.com/en/3.2/ref/django-admin/#django-admin-loaddata
-- 
2.34.1


