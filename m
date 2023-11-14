Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5802CC2BB86
	for <webhook@archiver.kernel.org>; Tue, 14 Nov 2023 23:34:55 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.874.1700004893700748916
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Nov 2023 15:34:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eUAjicvA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-32df66c691dso3649760f8f.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Nov 2023 15:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1700004892; x=1700609692; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1a4BKhXs8TWX9F9zm3EdncrTzCTKCR1yu0GguiRqKs=;
        b=eUAjicvA+rzX1Mm4y1p4T6vHf6eTKs1omVYkza6iNddW7YOLADUL1yjlu/nlDCJ1lE
         g28vVNDLYzPZrsD9Gjgh3yZZQXb59XNh4009E/FlfvVwdwmwyBrdneac7QQchvYnpQ4q
         K/ZPYgXXAO4J+q8lqp9pqtPhe1K9VSyCqY+WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700004892; x=1700609692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1a4BKhXs8TWX9F9zm3EdncrTzCTKCR1yu0GguiRqKs=;
        b=o31EtGlEdnu6VEQ7/59KsUAMkWX2wJE9NMSBQGVsWApWnpaSZSynTj8K6wCt/X2zsT
         io7ShiBukz8sipYDxpwcr5eFqHUMn6Z8Ksfgds4RKhsv21sNNDUS4lW1l2HU6quXvdo2
         z8JUGeeUvQBte/eUm7HGgJOegYQTGopAY76ArC8uWVzuoHMdcyakY0JhPhK5LuQ7Qm0V
         dpP12/DDtkU0m4Lc6uHImK9IgTK6XDeULjzVKSE8AgHfo+bBtGA0IexDdkH3TZslSN4h
         Ifh5d6dmG7lh+W1fCgz4ScU9PAdERGyO+HMy6bsrMnCmRRUSK0hz2HeU7bXZuywxKyqA
         jgfQ==
X-Gm-Message-State: AOJu0Yx9eHAx8b2mrN3Ec9Rkdzmvme9HBZgvRuAOtSIJ2uKevfz8kpD1
	GgHe7GcC4n72rrc26XkQHO5PkxJ45lB72gi0Y2o=
X-Google-Smtp-Source: AGHT+IEc5+i965PDhDcSbMfVk2tz2CFmTjMpi6AEq4/MPofQ12Iu8lUcnb2s/4rb+qCV3ZnVc49cew==
X-Received: by 2002:a5d:670a:0:b0:32f:7b99:2ed with SMTP id o10-20020a5d670a000000b0032f7b9902edmr8586796wru.22.1700004892138;
        Tue, 14 Nov 2023 15:34:52 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bbf9:c35a:2291:eb7c])
        by smtp.gmail.com with ESMTPSA id f15-20020a5d50cf000000b0032f78feb826sm8930203wrt.104.2023.11.14.15.34.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 15:34:51 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] tox.ini: Add py 3.11 and 3.12
Date: Tue, 14 Nov 2023 23:34:49 +0000
Message-Id: <20231114233449.2567899-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231114233449.2567899-1-richard.purdie@linuxfoundation.org>
References: <20231114233449.2567899-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Nov 2023 23:34:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15528

Some of the autobuilder workers have python 3.11 or in the future 3.12.
Add these to allow toaster tests to work on those platforms.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tox.ini | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/tox.ini b/lib/toaster/tox.ini
index 8c0fe17181..d058558b05 100644
--- a/lib/toaster/tox.ini
+++ b/lib/toaster/tox.ini
@@ -1,5 +1,5 @@
 [tox]
-envlist = py38, py39, py310
+envlist = py38, py39, py310, py311, py312
 skipsdist = True
 toxworkdir = {env:TOX_WORKDIR:.tox}
 passenv = *
-- 
2.39.2


