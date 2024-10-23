Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D47CDDE52
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:20 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.5165.1729677619481071775
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VRhRCGq2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso66927935e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677618; x=1730282418; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VBAi2U/sUJNhWrRjNykO3zFI4hTAlvcPSGwTaj9vYk=;
        b=VRhRCGq2hfVf/jgqWo/KkP3e0XciQsshQE64ftyFUk1BJ93Oxte0/GNJO3lcc2k6OP
         j/w+nkCk/YbAxD/y844eAMAt8xobAd1Hig0LF7FdpWzw+31qBuZLLnZjefdhV9MkhU9p
         4u+ozkoxL4F4r/UK6M5kxi3gaLeRC4TMqBeqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677618; x=1730282418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VBAi2U/sUJNhWrRjNykO3zFI4hTAlvcPSGwTaj9vYk=;
        b=WRt6qjssktKntEwlaPQwipS3/h7Ujabp3CDh6fU69jVTxBz4VICIO4+l3hNk+VffBN
         jp8nDGlZFESL3Ph4IsDsG/mheeig51vjMvrY54jvOY+ynLxnAm08FxhSL24eb/vrgVdn
         9zCJG4sqfpsNL/SwNv/ZFPO9No+sTNQKgzLsEE6mQnnR2eNKmnk/j7X5ijMAsCjQoUGr
         WQF6ZaZOWr7nTSamI7KwpWN0huWPGGeK2Pg6jX+t42wImzC8dp147g6glJ+0JMRoVSc1
         fhN94dHHwMExg9mPDRHOtD3qK0Mggn5q06nyyfVKjCiAO3lhCsBIkFwtwHdxLmPf9unE
         ZNUA==
X-Gm-Message-State: AOJu0Yx2rSv2eyWPT5F/2sCnvGwgdbmCA4Pca5BMhRejxKrXy2krTMoH
	pZQwL67yN0a6i8Lt2rO27vxIlrbdIQ4y7khTSfyLB+MtgVEF4sJdOgKYGCR1fijpovyTgu1NgDX
	P
X-Google-Smtp-Source: AGHT+IEHzSINc7HZCFcx4LB3GGc4hSNAf2qmNJtszbuzfTz7n6sSwefXyGOiVD2iUXpVCxAZJtPnvA==
X-Received: by 2002:a05:600c:1c12:b0:42f:7ed4:4c26 with SMTP id 5b1f17b1804b1-43184143ef6mr18317345e9.12.1729677617678;
        Wed, 23 Oct 2024 03:00:17 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:17 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 26/28] tests/toaster/functional/utils: Handle WebDriverException
Date: Wed, 23 Oct 2024 10:59:47 +0100
Message-ID: <20241023095949.3351980-26-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16717

Fix the exception handling in the cancel builds function.

This involved adding WebDriverException which sometimes occurs but
also correcting the other exception handlers to continue to increment
the timeout to avoid test hangs.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/functional/utils.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/tests/functional/utils.py b/lib/toaster/tests/functional/utils.py
index d8394708e8..72345aef9f 100644
--- a/lib/toaster/tests/functional/utils.py
+++ b/lib/toaster/tests/functional/utils.py
@@ -8,7 +8,7 @@
 
 
 from time import sleep
-from selenium.common.exceptions import NoSuchElementException, StaleElementReferenceException, TimeoutException
+from selenium.common.exceptions import NoSuchElementException, StaleElementReferenceException, TimeoutException, WebDriverException
 from selenium.webdriver.common.by import By
 
 from orm.models import Build
@@ -66,12 +66,14 @@ def wait_until_build_cancelled(test_instance):
                 pass
             if 'cancelled' in str(build_state).lower():
                 break
-        except NoSuchElementException:
-            continue
-        except StaleElementReferenceException:
-            continue
         except TimeoutException:
             break
+        except NoSuchElementException:
+            pass
+        except StaleElementReferenceException:
+            pass
+        except WebDriverException:
+            pass
         start_time += 1
         sleep(1) # take a breath and try again
 

