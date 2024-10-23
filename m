Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7FBCDDE52
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:30 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.5157.1729677621765799374
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HxLkHRN3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so46835325e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677620; x=1730282420; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOWYG90B39N1cdeq8H1D0gItqrifO4IYIeb2WImPEhs=;
        b=HxLkHRN35+584dtPTknNpWYnGXLqx5vPEQRGcse9AN1UXib8RJxqeQpCqPix+CzAic
         Cf28i9bHZ/b+7zHiHCR+osDfV2to5cQqh1yXWftWRsnnN3wEfq7ByWvftJiXw5E164Dt
         njRCa0bsbKXxAzbg7M6w5N/vn8l+wxRVUn+GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677620; x=1730282420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOWYG90B39N1cdeq8H1D0gItqrifO4IYIeb2WImPEhs=;
        b=TYowGTSG9hpEeU8PCDvkPVlRChK+HrJ47bwAp2+LVHyXi7rs0NhlRHL/3CdFAmMvNg
         rvwn/fcJMD3lYvODEMQJYzKAgGGPYtOP7nZvdX0abaZNQEVy4C00cn3SB7RIkcY6iXEy
         TDfVhDAIDboMf/4sx+AHmJyVLf8EVeLh9fqA73G3bjPyGtWh6sFUtb2QTNkVMy/zPxYi
         hiFKgbAAhocsqoNyH2U+/IDvoIuvROeHsHXneVuw4ffCM+vfM4GIimiURG1QbedCxhSY
         X6uFT3SjN8qNF5IB00kgwFk5KyXThw31WcbkafPhTsNpOdHuD6/aJPbv9C7Bt5UXUpCA
         RrxQ==
X-Gm-Message-State: AOJu0YwZr4kAPzQapwaCkDABvEiPTbL64o24XHrOv7yqJiZhAUt0EEE4
	W/INtmJXUrogpFw0VYi7hv2aSj8Nn46xfvQbQUJIp6x3ItI2g2qBu3fWJheRyHrmetRrwNud3X9
	y
X-Google-Smtp-Source: AGHT+IHxaMGzFcfGThVZfQFOl4ExocohUV+Gk06XTYsSsc8geicHCDAquDJVZp2R0/fWNWKVcrLp7w==
X-Received: by 2002:a05:600c:3543:b0:431:6153:a246 with SMTP id 5b1f17b1804b1-4318414a3d9mr18077355e9.13.1729677619935;
        Wed, 23 Oct 2024 03:00:19 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.18
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:19 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 28/28] toaster/tests/selenium_helper_base: Dump a screenshot into tmp upon failure
Date: Wed, 23 Oct 2024 10:59:49 +0100
Message-ID: <20241023095949.3351980-28-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16719

If we fail to have an element display, dump a screenshot into /tmp since
debugging these issues is painful and a screenshot can help a lot.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/browser/selenium_helpers_base.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index 6953541ab5..798aa9e448 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -122,6 +122,7 @@ class Wait(WebDriverWait):
             if time.time() > end_time:
                 break
 
+        self._driver.get_screenshot_as_file("/tmp/toaster-failing-screenshot-%s.png" % int(time.time()))
         raise TimeoutException(message)
 
     def until_not(self, method, message=''):

