Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C908AC3DA6E
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 14:27:25 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.7952.1704724044600879825
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jan 2024 06:27:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hAg5GJ4g;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so21736005e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 08 Jan 2024 06:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704724043; x=1705328843; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmBWhkhhYdwXDnT5uZDZQfHSGCxyagA0gXlwAQj+Pic=;
        b=hAg5GJ4g8VpjCbJxf7qpZtPFh3TboEb51mSswNzPEo7k7qZfg7xJ6p68C7g+bp5MuX
         Edn3dIkN8u3o1gHLczc2kl97XHQS9FzXSmlX+h7H5msqWVUoP02CLwLD5mF+p3gNbsAl
         3j4u+tvkaa1uastTYfjLA/QHnTNlXzxp/ZgJWM+mQZmCV0hVdRWEAy6jSogWbtgN1Wyn
         e0e9K9+Fz+X1FkbB1JFDyI/qIMLwqhKU3398EkhLAgZV6M1Hlr5mitVrGr/0wtjVPwVL
         BRcoIYsz/QU7gVHAML27sXpenI2QQJSMXB/0CMvCDhG4juG+Vouxb3zEkaOTfO/tF9GX
         rMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704724043; x=1705328843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmBWhkhhYdwXDnT5uZDZQfHSGCxyagA0gXlwAQj+Pic=;
        b=cIXROg34zrK5tkcj8/qgx3nWf7pxhStW5aQqBkp9tbKc4IXSnI+m+DJD7mSDI0NWs0
         0OT9vNM+8UyuAxCyQ3FNnbfVTDd/ZYN5FzBBGXdL8fbTHycPXNrDCXmB8iyf9hdjYTA2
         XxzclUQQ8fElpR/Mmi6oVK1+4TIzy4ZX4y2qNOKePw85DqArGSPYPIjl3ayzSwOWVBOT
         lBzsrAOy1Oy/GMgZRJUvqjOquSYuJlHtGA2fPiXvqQSFvLzmi1RDFLsqt0bsjf2a0qEN
         NEjNxJDl+XB/rBnrBlqpn5bwPf1VQSVc43hr4kK94DYjKLKZ3+ALC7vqSKJE4LNZ27eI
         mMHw==
X-Gm-Message-State: AOJu0Yy9PuxaPDwlk8RlmUfsfei4wu44uYjFrLYqSiseZ6rjJ9NTO6VC
	bV2rcjTvwKk7sNOgM6DDe5BKyBNkA0o=
X-Google-Smtp-Source: AGHT+IHXPjwCnVJH/XFghLdevUaDgc1+Gmjc381WHM3GWnIBLx71Yp0IJzSJgz5casE4mEILAruL4w==
X-Received: by 2002:a05:600c:1551:b0:40c:34e1:72ef with SMTP id f17-20020a05600c155100b0040c34e172efmr1875327wmg.84.1704724042775;
        Mon, 08 Jan 2024 06:27:22 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id b22-20020a05600c4e1600b0040e4abe5386sm945355wmq.21.2024.01.08.06.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:27:21 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 2/2] fetch/wget/checkstatus(): include the URL in debugging output about status check failure
Date: Mon,  8 Jan 2024 15:26:48 +0100
Message-Id: <20240108142648.2293370-2-alex@linutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108142648.2293370-1-alex@linutronix.de>
References: <20240108142648.2293370-1-alex@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Jan 2024 14:27:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15751

Previously the output wasn't useful for finding out what was the actual
URL that failed, particularly in heavily multi-threaded invocations:

DEBUG: checkstatus() urlopen failed: HTTP Error 404: Not Found

With this change, the problem is described specifically:

DEBUG: checkstatus() urlopen failed for http://cdn.jsdelivr.net/yocto/sstate/all/universal/4f/91/sstate:gettext-minimal-native:x86_64-linux:0.22.4:r0:x86_64:11:4f91b650ebd7be601cbd0e3a37a8cc6385a3f4ee616f931969b50709ed8bf044_create_spdx.tar.zst: HTTP Error 404: Not Found

This will help with CDN cache tests in particular. When some object
isn't available, we need to know why: 4xx error, 5xx error, timeout
error or any other issue.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index dc883176104..dc025800e65 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -375,7 +375,7 @@ class Wget(FetchMethod):
                     return self.checkstatus(fetch, ud, d, False)
                 else:
                     # debug for now to avoid spamming the logs in e.g. remote sstate searches
-                    logger.debug2("checkstatus() urlopen failed: %s" % e)
+                    logger.debug2("checkstatus() urlopen failed for %s: %s" % (uri,e))
                     return False
 
         return True
-- 
2.39.2


