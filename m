Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73863CEF171
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 12:36:41 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.8048.1728390993800310447
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Oct 2024 05:36:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dOeOgQlo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37ccfba5df5so3622926f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 05:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728390992; x=1728995792; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdsHgCCNMzMQBiS01W4ReITWN+XfIodgK31FIy1hvJA=;
        b=dOeOgQloKrUFhSIutXzxJ5KKsijJtHD3v7omeCQeoPs0S/CGpgcli1gZz6aCcj6/0x
         2ZZ1sJ9IfuQyUgBWH4tDULCPVfuXxkeu3CNTTRzAO6PzzLFF1pSkRoxDfTEY19cSxbOz
         pch3zGGnY9SFw7dr8Odtx8vSuV3xtwgtucf9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728390992; x=1728995792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdsHgCCNMzMQBiS01W4ReITWN+XfIodgK31FIy1hvJA=;
        b=JpWc8lwl40iGhymLJQ/PEQfw6jJcF8uFgJiIT2YAKsnU6qP9vQDe38h55cTxUsRxTZ
         fXvJwg4XOT9mmhiVSbQwNHge0d0K2Lygbt0TaC9EMTcBHtXAlgpwX5JzBcttGxnuHGFX
         1FAGCqm4fC1OdxTjWRqyXqGPsuhEryQvuIU5Mgvx11PBtfoHUcab7XtqCRJNhqUHRRG9
         abQjoMjb2BzZKo7Mjxa/i254wz5ImYwmAb/rGte5tjdtSTSWnhfj0UnDwPNx5CcafM4P
         M88+l48mbpWf0p6/5G3ZZBWl+NVx9KTDZSPMzUCSWC+vCOriNMacTy0qizzABRTvWOZi
         M5FA==
X-Gm-Message-State: AOJu0YxOCLjijNs566aPkwcVqekG5Bn4hj0xPjIIaGChgEoqNJEwYIm3
	WemU+URHztCXMCDON7B8IWVURuCSrsz/pn32BHXR6h35boZ60H+Hw7GsSddOhtD8mKiPuCW/8ZK
	p
X-Google-Smtp-Source: AGHT+IHclc4pIT2JjKiJYuGdif1Z9DsRwkaNckN97OEn1qli86A3SLyY7tnOoKQiykfS0ZeNbhjf+g==
X-Received: by 2002:a5d:5c87:0:b0:37d:2f6b:a08b with SMTP id ffacd0b85a97d-37d2f6ba46cmr1005474f8f.28.1728390991974;
        Tue, 08 Oct 2024 05:36:31 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3f9a:5ae5:8636:3d57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a47esm8019492f8f.28.2024.10.08.05.36.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:36:31 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 5/8] bb/exceptions: Drop obsolete 2.6 code
Date: Tue,  8 Oct 2024 13:36:24 +0100
Message-ID: <20241008123627.252307-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
References: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 12:36:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16658

In python 3 we should always have named tuples in this context. Drop
the obsolete exception handling.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/exceptions.py | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/lib/bb/exceptions.py b/lib/bb/exceptions.py
index 801db9c82f..acf546de1d 100644
--- a/lib/bb/exceptions.py
+++ b/lib/bb/exceptions.py
@@ -38,14 +38,8 @@ def _get_frame_args(frame):
     """Get the formatted arguments and class (if available) for a frame"""
     arginfo = inspect.getargvalues(frame)
 
-    try:
-        if not arginfo.args:
+    if not arginfo.args:
             return '', None
-    # There have been reports from the field of python 2.6 which doesn't 
-    # return a namedtuple here but simply a tuple so fallback gracefully if
-    # args isn't present.
-    except AttributeError:
-        return '', None
 
     firstarg = arginfo.args[0]
     if firstarg == 'self':

