Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B65CDDE54
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:20 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.5152.1729677613331943733
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JPN+MJPK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43163667f0eso50974695e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677611; x=1730282411; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVyW7ugoMg9S14L8pvKIO+VjclJYvy1k0Oqvvi2qSAg=;
        b=JPN+MJPKogpgQYOUJ5v7Wb1aA3y3ZZUeweMsdhz93llCx0EqKDHVATViZ1y2+WM1h6
         Meb2vg5gvh/JNlk1wnEpvknZjWJGkh6XxTgBbMxrtc974zJWdmvzyF1QAVyqNPR0kLW7
         FIkjsZYhkRWxQB1f0XxFsk9wdPw+90c368ff0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677611; x=1730282411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVyW7ugoMg9S14L8pvKIO+VjclJYvy1k0Oqvvi2qSAg=;
        b=Ckm8Y9UsbgoMiW9ddkanpsyhbLu6BhUSbkD3rETpkjY62UrcD/ivbvk6heP5RG3ig+
         IkdbjrUgVFHa0WYZ+4lbzGsKoDk5W6efxAemYXnfYpA9A0XSt2G5QVBK1+GVKw/76lTQ
         4d/lYkikLyzy+1dvbiT5qH1VcwOCDrNW6TJfcd+9Ei2t/MXQk4BTsmBEcWCfcyee2qvz
         MhAn+zSWlImy8pIA+TWg6o0T7W1JdVkmsKwvZvgvy/e0wTfnm0a5hPZi8gxkX0z3iGwX
         +4scYLikcXiYnNLZNYafoiOu3qTp8a90lBBwYNIaTHAPbDF1Xk8RlRJRJGLDpF2Zx4ld
         PYmw==
X-Gm-Message-State: AOJu0Yw63X0eBO8gdCMdVZmEFYqNl5Aq8+rHN7HewcwLH65SUmha53YM
	PI+0lpta0XcJne2q8YH43dT1V+kqUKJbJit07ZsduYSblGFmeQIs97on3aRibyZt8qxMPWEBDjG
	s
X-Google-Smtp-Source: AGHT+IEd6QrceQHNCWlTeRn6fPU9U6ubA7QNcBXVYIfaVIxWEPbAuNCYoNmtcX+qyebEIFiYVGRXsQ==
X-Received: by 2002:a05:600c:3b05:b0:431:54f3:11b1 with SMTP id 5b1f17b1804b1-4318424d1f6mr15455405e9.34.1729677611318;
        Wed, 23 Oct 2024 03:00:11 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:10 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 19/28] functional/utils: Drop unused code from wait_until_build_cancelled
Date: Wed, 23 Oct 2024 10:59:40 +0100
Message-ID: <20241023095949.3351980-19-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16710

The code modifying the build object requires direct database access
which is potentially problematic. It was being run on a database which
was being reset after changes anyway so the code effectively did nothing.
Remove it as it is unneeded.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/functional/utils.py | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/toaster/tests/functional/utils.py b/lib/toaster/tests/functional/utils.py
index 7269fa1805..8e81c29984 100644
--- a/lib/toaster/tests/functional/utils.py
+++ b/lib/toaster/tests/functional/utils.py
@@ -48,7 +48,6 @@ def wait_until_build_cancelled(test_instance):
     """
     timeout = 30
     start_time = 0
-    build = None
     while True:
         try:
             if start_time > timeout:
@@ -64,11 +63,7 @@ def wait_until_build_cancelled(test_instance):
             if 'failed' in str(build_state).lower():
                 break
             if 'cancelling' in str(build_state).lower():
-                # Change build state to cancelled
-                if not build:  # get build object only once
-                    build = Build.objects.last()
-                    build.outcome = Build.CANCELLED
-                    build.save()
+                pass
             if 'cancelled' in str(build_state).lower():
                 break
         except NoSuchElementException:

