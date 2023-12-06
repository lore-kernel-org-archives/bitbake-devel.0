Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58D4C10F07
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 14:45:08 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.33046.1701873899844912612
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Dec 2023 06:45:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Q5racu9i;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c0f3a7717so30016825e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 06:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701873898; x=1702478698; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kXDiw6y/3XHbTijnHx6yLn6mGzC+TAApS/iLJf6bQw=;
        b=Q5racu9iQLATVvxoFhl3zKpzg6D43iEVMhTB3at59yL+b/+Ln5zWHiXVL5vEBr66w1
         AfYdRQ/pfz86k9sdESalGdKjNuG9APTXFnNbShZkmf8ADgc+IIOCBqFunjRE7V+/Kywk
         /8qeqdB3fI3Ep5dSTxEWltIjp9HWTQsycn5+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701873898; x=1702478698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kXDiw6y/3XHbTijnHx6yLn6mGzC+TAApS/iLJf6bQw=;
        b=aLiEmRw8pGEqz8I3bieoAGCacBhlFGShNoxXiG9SEa5VLPjA3OTU/MW2YPtDIu57D8
         h9zAma2pLv3XLwlu8YI7kAynNJBBeKqxcUUytmGSbHutg/YWXF3Bbq/lvfVUsbAmXkgH
         yyyr9MHv+IT7pdh9BFcjJLGbMN1fZ0l7vdhFn24Aq3mRBu/SPq8gRVIYsX8IRbckIwfV
         xSOcvGpCRwVpCAglH7H4LC0pf42/otmoVlJTkC8l2eVdC+OJymcteE4jpwrlgcR76Tiw
         P5CHVIUij91RFG5hFM5zS3oXY3jn5/xFy3wVlQO1+RMDtTJ88gVuGn0uOwp+uAcg9HTV
         E9Nw==
X-Gm-Message-State: AOJu0YyTndkc1HYhJtKThw6UIaAqEWgICPR5Go/RcBkN50pQlpRf3WWe
	Nbo/wP21bAv/9B/gW8gKHOOtWIPaad3rCKdUYS8=
X-Google-Smtp-Source: AGHT+IGz/iMKFn/sTN5i2yoTnr949CPjmjPlp55Mcdl1ls4hXkai1ZLpn/2Kzu6eT2mybjw30Av0qQ==
X-Received: by 2002:a05:600c:35c7:b0:40b:5e59:f724 with SMTP id r7-20020a05600c35c700b0040b5e59f724mr335286wmq.150.1701873898117;
        Wed, 06 Dec 2023 06:44:58 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3cca:8f76:d5f9:e02c])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c458c00b0040b4b66110csm22108082wmo.22.2023.12.06.06.44.57
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:44:57 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] toastermain/settings: Avoid python filehandle closure warnings
Date: Wed,  6 Dec 2023 14:44:55 +0000
Message-Id: <20231206144455.1604879-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206144455.1604879-1-richard.purdie@linuxfoundation.org>
References: <20231206144455.1604879-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 14:45:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15620

Switch to using with blocks when accessing files to ensure file
descriptors are closed and avoid python warnings.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/toastermain/settings.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 3c12359366..e06adc5a93 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -89,14 +89,17 @@ else:
                 from pytz.exceptions import UnknownTimeZoneError
                 try:
                     if pytz.timezone(zonename) is not None:
-                        zonefilelist[hashlib.md5(open(filepath, 'rb').read()).hexdigest()] = zonename
+                        with open(filepath, 'rb') as f:
+                            zonefilelist[hashlib.md5(f.read()).hexdigest()] = zonename
                 except UnknownTimeZoneError as ValueError:
                     # we expect timezone failures here, just move over
                     pass
             except ImportError:
-                zonefilelist[hashlib.md5(open(filepath, 'rb').read()).hexdigest()] = zonename
+                with open(filepath, 'rb') as f:
+                    zonefilelist[hashlib.md5(f.read()).hexdigest()] = zonename
 
-    TIME_ZONE = zonefilelist[hashlib.md5(open('/etc/localtime', 'rb').read()).hexdigest()]
+    with open('/etc/localtime', 'rb') as f:
+        TIME_ZONE = zonefilelist[hashlib.md5(f.read()).hexdigest()]
 
 # Language code for this installation. All choices can be found here:
 # http://www.i18nguy.com/unicode/language-identifiers.html
-- 
2.39.2


