Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE72CDDE5E
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:20 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.5154.1729677617213458339
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=P86FwB6I;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so66131805e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677615; x=1730282415; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/MXpi+yDHIgl/Il3shp5cVCqoupFl6+bjb8mY3u6mQ=;
        b=P86FwB6I4rjsflaWxHtPJ80kIrCl0VmLs9KowHswOqxhMs8soxIoQs7FfB2ZzMt6NG
         SATAFknBJM9RrO+kOYVxiffebeXdmX/jcZSfEmehPnKmhOy8So9u2FFB1v/6/NlWRXbW
         TZ3+4W6Mucihm0n5JGcAaTgoFeskCaDvUZdCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677615; x=1730282415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/MXpi+yDHIgl/Il3shp5cVCqoupFl6+bjb8mY3u6mQ=;
        b=k9JL1MlQgVcxi7og/8yTpIygjjBxFuAJaw24hmsoVdv9ySwsKSppIoATp4FZ6BUKpA
         OpJWxE4n5PQe3RBkqLsSetRXsWrryjt9txPmDKU+JcfqX5/LONr4O9AHdohUBgeDNpBT
         yLJzHz7dbZRQg+4Suj6GLcEqKkyv9cN82NuRDQ+ZdlMbURP07HCF/KeZuyTNUA2SMa/O
         sZq7Glne1emVUbOxWY3nQdZI12KZdOKpFW8Q8L54BLd8qgaY9IaHUJWnfdWaainyYx3P
         FvOsSgD4lJR5p6IMLU3La6KbvwITMCORCGP4vUj/lzaYayOAUe/9bHaNQm0Cn2AMCw54
         QUsQ==
X-Gm-Message-State: AOJu0YzzvQDFLzUAc0Jo/7ib6iz5E7SJiKTTR0q05lxZ4GkxVtiefahV
	zDWY06fknKRqW/z5t5HVZZkBV1MfjTYvnDJ/v6kJ1HyfgPyzb5Onyln4zNjEokLfHIQ+Z5mOKjn
	2
X-Google-Smtp-Source: AGHT+IF52SHqZqdN0xcJywvWSPLrrGMtNFiADK7FmYnSRFqXbEurxK4parqXuzJ7nMH46GFc2YgKig==
X-Received: by 2002:a05:600c:4ec7:b0:430:5887:c238 with SMTP id 5b1f17b1804b1-4318414a117mr14747815e9.11.1729677615165;
        Wed, 23 Oct 2024 03:00:15 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:14 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 23/28] toaster/tests/functional/util: Avoid test hangs
Date: Wed, 23 Oct 2024 10:59:44 +0100
Message-ID: <20241023095949.3351980-23-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16714

If the element never exists, the timeout is never incremented and the test
hangs indefinitely. Fix the exception handling to avoid that and allow
the timeout to happen.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/functional/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/tests/functional/utils.py b/lib/toaster/tests/functional/utils.py
index 8e81c29984..d8394708e8 100644
--- a/lib/toaster/tests/functional/utils.py
+++ b/lib/toaster/tests/functional/utils.py
@@ -36,7 +36,7 @@ def wait_until_build(test_instance, state):
             if 'failed' in str(build_state).lower():
                 break
         except NoSuchElementException:
-            continue
+            pass
         except TimeoutException:
             break
         start_time += 1

