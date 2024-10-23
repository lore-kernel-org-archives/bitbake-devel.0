Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC64CDDE42
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:09 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.5146.1729677599703658958
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TmyaXrgo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4314a26002bso72856645e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 02:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677598; x=1730282398; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ly2tjwbquGn6oPbLMnzzW9tlwgWxk5nEctjLh7eyQiw=;
        b=TmyaXrgoYel0CdgK+hXT/3maJrXhihXrhjASFX6P7KN/PiMJq1kl5MIKK6h80GqVVP
         9Tlk+NGRuOjNch5cNB2NKeEA3MX2fAnuG9nMow6eN9X7vnLz9uzwB//VG7DL3BU9GHM8
         6nhDp0JQYOnFRxxEdXaB1zCcm8DqufBwYK3VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677598; x=1730282398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ly2tjwbquGn6oPbLMnzzW9tlwgWxk5nEctjLh7eyQiw=;
        b=mP20/29TiFtOtSdPSnBrAQIAtqNyw/3sVtlNvugP1S4z3ZPghLIyg6pTQuIgH6BG7O
         DmSvv2Cllhw1pj0WMpqPVeu8OgWY88uSbgV8vejHRwMSapvBnoqFXd2bKtSUvOVRAjKF
         HOi88XauuMGsLYWoBdFNEcWNWWmo0v/QVhxE9e5gBywiz5sk0iXfF/Sp6BUGJHzRDWRf
         CeJXOPINxSiaz6Fxg7x2SNWVhLmNhmGwdJSXBmVW9L9IBX362muWMY35LsIt7o0o16wJ
         Bwq/jTHAUo/+x499yCF1h9IlkofUCdhuxU1txm1cxxQux/elvj/FQIkD3XXquGzV9CjQ
         zG6A==
X-Gm-Message-State: AOJu0YxCVSohGqCix/bpP5/ZXvijXlmbpV7IgNsE8ttleINkoFrzcm+v
	3yHDPT8qsRCraKG4DpdMVGYdE4bFMXo2kutKCnxDakM7Vx38g152gKzs2OSCJIhYkcdE2rCk/ss
	7
X-Google-Smtp-Source: AGHT+IEvLdKLTnzZz6Z9RIZv6UHdbYBrhQ8ozZip89IZM8z58faa10YSVjucdE0mOXYfW/71TsplFQ==
X-Received: by 2002:a05:600c:1d9b:b0:431:4e82:ffa6 with SMTP id 5b1f17b1804b1-43184188334mr19252305e9.24.1729677597792;
        Wed, 23 Oct 2024 02:59:57 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.02.59.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:59:57 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 07/28] toaster/tests/browser: Increase the default wait timeout
Date: Wed, 23 Oct 2024 10:59:28 +0100
Message-ID: <20241023095949.3351980-7-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16698

Rather than hardcoded poll and sleep values, we want an overall long timeout
and to drop all the other 'sleeping' code.

To facilitate this, increase the overall timeout so we can then start to
remove the other values.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/browser/selenium_helpers_base.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index 2725f13382..b060133b1d 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -90,7 +90,7 @@ class Wait(WebDriverWait):
     Subclass of WebDriverWait with predetermined timeout and poll
     frequency. Also deals with a wider variety of exceptions.
     """
-    _TIMEOUT = 10
+    _TIMEOUT = 20
     _POLL_FREQUENCY = 0.5
 
     def __init__(self, driver, timeout=_TIMEOUT, poll=_POLL_FREQUENCY):

