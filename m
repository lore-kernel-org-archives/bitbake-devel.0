Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CBAC7618B
	for <webhook@archiver.kernel.org>; Tue, 14 Mar 2023 20:31:47 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.6203.1678825904837659294
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Mar 2023 13:31:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=mAlXxU6r;
 spf=pass (domain: gmail.com, ip: 209.85.214.171, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f171.google.com with SMTP id h8so17866822plf.10
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Mar 2023 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678825904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHipGZxiffY/h2ka4lJe2MrOSBsPu+HpfqFtTrjTAJU=;
        b=mAlXxU6rvho8FAys05V6wQqEPLtGigTndG/qczNJJfsjMbh4UE3erGPGDQ6ncNEnBp
         hDZh90i1imk3kfW1iOFjiG55K14VXGrXeqv+yGf/+L70kSJruRvwjh//n/ll5FgXtPpj
         JSJJLJcgGT1qPVRVlKv86UNUisu1fbN/bm78VHXSzjEK38lY+Y/DAUq796l3dBVXNGVd
         PioZHjeli+oAGVEK9nevXAy9yGM3kYkzZPQKzWCu74wAW6ZyUQIfrSPH/zjDVhnHV+S5
         ZDFpSC5bwksq72/JKayOXtaOA3vEqb/WPX8wUlUELR3IVo6+IXSBIN65phgH3mkXYSD0
         XXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678825904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHipGZxiffY/h2ka4lJe2MrOSBsPu+HpfqFtTrjTAJU=;
        b=SP+Fw5qcHRvh0fFCUO/+wE8bNBxJJiQz82GvcXzeBIgzamlzt7ZN2WJnjo/+CDXpMW
         kaU+ot+he4TUpV1oq7VgaHyfZomZMmMiPLhyO7RvJ3q/UyHfjvl4Vt9fJb/QXNgI99mZ
         0ENN2EgBSuQ/0E/aQGJk3+N8SHERlcbex9ceKJWONBAvIkGWlYp7l/sG+vVbnUQR9Z64
         shKR/Pxmntf9bVg+dwa4KnieTanikA92gukFblsgu5iWTjHxyW6ywTRtO6ZSbekM210J
         FapbW/HeT8f6nXWeWKOia9ypJPv7ulBrgo+RArQ6T28O9+wFIqRuu7eM5KAfra2P64S4
         BaeA==
X-Gm-Message-State: AO0yUKW2Yuye2CmGI8zi3kLQwWdywMS8XdtiCtBUs/8MgiKO+0VdaOOr
	zLXDSgGqPtmqM6wqPLpwjdLd8fj+gTw=
X-Google-Smtp-Source: AK7set/2xSpjH+MYN9tjB2Oyrsuk3gmQKkM6wJ+hKcm6BgDJJ888WDlagUKWV4ycUJWuPGSDw3x/CA==
X-Received: by 2002:a17:903:41cb:b0:19c:fc0a:567b with SMTP id u11-20020a17090341cb00b0019cfc0a567bmr254960ple.12.1678825903639;
        Tue, 14 Mar 2023 13:31:43 -0700 (PDT)
Received: from chiron.. ([2601:1c0:ca00:cea0:155f:ded0:e803:df3c])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902ac8f00b001a076568da9sm215464plr.216.2023.03.14.13.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:31:43 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: steve@sakoman.com
Subject: [langdale][2.2][PATCH 1/3] toaster: fixtures/README: django 1.8 -> 3.2
Date: Tue, 14 Mar 2023 13:31:28 -0700
Message-Id: <7e8e6e41a339f479ffece40320a8f89d2ae9453c.1678825322.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1678825322.git.tim.orling@konsulko.com>
References: <cover.1678825322.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Mar 2023 20:31:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14557

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


