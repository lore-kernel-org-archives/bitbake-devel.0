Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C9CD0D7B0
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 14:52:00 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.13763.1728658312300209234
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Oct 2024 07:51:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Wyt40rGb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so724659f8f.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Oct 2024 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728658310; x=1729263110; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81m1+GFaJ3p61U35GjNk8jTZLUNV7mKdgjWmTChBKyY=;
        b=Wyt40rGbnYaM95KP/cFQ+UTqj1E6bxQu9JVvWBlSjl6sUxitjGigxN50hJ3KJBb5XB
         tpHP4F4t2O/pQDCSDujLYHhViCiwn+Awt6E/ynYbvXUiOVwXxvshQZ63lBVVmTw8JZwh
         moEE82nbaRtGAh2SwPfWMOb/ExX79haem3OMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658310; x=1729263110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81m1+GFaJ3p61U35GjNk8jTZLUNV7mKdgjWmTChBKyY=;
        b=GtlqcLr3avWXIiEG5FVgStfCAmzDB/FZZQnMqAW/fjLQhbI429YGV84oSkutidMoVe
         umtN/82i2CIMTlVa+D+DhEVvYCy+XBzxbEJrtXyK5ApwHLbSHjfrE58spEuBceqNdMQv
         cjTlZNkp4PW5hhWZBga7dwUJxf9LppnNlyy1yZDQUlSYSYiSF2c9q7U8YYxkpWrJlONZ
         WqCFBpmjPL9ZusUAKH0aSYAAKCLxjCvmYwtdJsyad83Ijo2/cPH5FZ80WJa0o8EqUef2
         Zvc21JAjyi4COd4rbInYxl8V99qzdQWP58732OpX+2axEbHFnKZ9ezXsKUxawL+lvbYc
         sQMQ==
X-Gm-Message-State: AOJu0YzXGH74j2JPLCDPF48FsxHz7EN0ybLDuzYmx35HAFiqaja9648E
	o2mmHlYYxxyW4OYu7e13HKp4laBmXT1oPQG1a5qAsDrM6hREBty8s4kEGfl/P+nVZARGO6+zWAO
	9
X-Google-Smtp-Source: AGHT+IFiJRdV5+e2BOiGJwNDng47ouKuILFzQs/Exe2RooEB87b2klujO4lOydU92q/tb79Vl5pOzQ==
X-Received: by 2002:a5d:4403:0:b0:37c:cd38:c51e with SMTP id ffacd0b85a97d-37d5519911emr1964673f8f.1.1728658310505;
        Fri, 11 Oct 2024 07:51:50 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8145:ba6d:a6de:28af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd032sm4142053f8f.30.2024.10.11.07.51.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:51:50 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] toaster/tests/selenium_helper_base: Dump a screenshot into tmp upon failure
Date: Fri, 11 Oct 2024 15:51:47 +0100
Message-ID: <20241011145148.800080-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011145148.800080-1-richard.purdie@linuxfoundation.org>
References: <20241011145148.800080-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Oct 2024 14:52:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16670

If we fail to have an element display, dump a screenshot into /tmp since
debugging these issues is painful and a screenshot can help a lot.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/browser/selenium_helpers_base.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index 22d4085b24..cc746511c3 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -122,6 +122,7 @@ class Wait(WebDriverWait):
             if time.time() > end_time:
                 break
 
+        self._driver.get_screenshot_as_file("/tmp/toaster-failing-screenshot-%s.png" % int(time.time()))
         raise TimeoutException(message)
 
     def until_not(self, method, message=''):

