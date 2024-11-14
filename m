Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647DED6A250
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 22:18:28 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.6944.1731622698269449664
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Nov 2024 14:18:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Oorh1ycB;
 spf=pass (domain: smile.fr, ip: 209.85.128.54, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-432d866f70fso9863115e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 Nov 2024 14:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1731622696; x=1732227496; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBxZVUeCI96ycUxfu2XPdSH2Y2dsNEOUKePFBKd7kx8=;
        b=Oorh1ycB+m06kNTNWv8KV4ZAktk5st9xq5QVGz0HBc49Yo88CK2u40DBNY+ODoKgSL
         jDeUzrMIJ/KDeq8Tse28VbiJMwLRVLB0keJxgwtFNY4Km2SNTfEpZ+kNlxM6AW0QAYJ1
         q1rqDjcoPrENTZLiyHkNrewcgmK/3KjGY4s6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731622696; x=1732227496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBxZVUeCI96ycUxfu2XPdSH2Y2dsNEOUKePFBKd7kx8=;
        b=wstydzP13XWd8aZeqSbrvVll/P+6RhI2jQW5RkODp/XvHXZZbo4H5jYH/d0PkpiDJi
         v9Hvmp3zcuCB2yFKlBE8zk58jpAhzNFLLkzS97ntBP79Bp4yQX1jSpKnAPlt9TWESSnG
         G+Hx8Ds0tBHCJsNhPCwXcpK2CBej1H1W4qPpeSE1YjiVTA0FMq5rKbk5H8L+OBTdZ4FD
         ag5LSHdlJPCmKa1wfqFapDAetPuxD5634m5Ut1fTIMiwL9+Tr4Fn4R3Kam+X2JHcOwQP
         RRng1dJUo4OxSW7mB71kJrXkfDM2o5hBZrQdfMgxiRWr4xvvTqzj2/iRfcNkXm5DIxQg
         oaCg==
X-Gm-Message-State: AOJu0YxMbQCUBwFftT7OlZqBwOLFiWHmNe7UzRDC9RoG9DXhk4aJJALW
	TZnCzVtz5k1E/brqHKR8UxcsoGMIrz7IGU3BLFuYEY4oFifbR5NOuQ16fe6PQsJo5AM99xav2nz
	V
X-Google-Smtp-Source: AGHT+IGoO+LFwU7wj2jV+NQYWUDA5kNTlITUj9D/YX8shOJjTHJAP/B4dL0PSDO7DBKOB0mUgwLnkw==
X-Received: by 2002:a05:600c:1c23:b0:430:5356:ac92 with SMTP id 5b1f17b1804b1-432df721a19mr2712635e9.7.1731622696404;
        Thu, 14 Nov 2024 14:18:16 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.local ([2a04:cec0:11fb:21bd:1f18:7aa1:7b8e:5f4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae4c125sm2578731f8f.110.2024.11.14.14.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 14:18:16 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH v2 2/2] bitbake-getvar: use finalizeData tinfoil API to get identical result to "bitbake -e"
Date: Thu, 14 Nov 2024 23:17:27 +0100
Message-Id: <20241114221725.3826753-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241114221725.3826753-1-yoann.congal@smile.fr>
References: <20241114221725.3826753-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Nov 2024 22:18:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16802

From: Yoann Congal <yoann.congal@smile.fr>

Fixes [YOCTO #15638]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
v1->v2: Only call finalizeData() in the "not -r" case. In the "-r" case,
the data is already finalized and calling finalizeData() overwrite
correct data.
---
 bin/bitbake-getvar | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
index 8901f99ae..20c0b696f 100755
--- a/bin/bitbake-getvar
+++ b/bin/bitbake-getvar
@@ -43,7 +43,9 @@ if __name__ == "__main__":
             d = tinfoil.parse_recipe(args.recipe)
         else:
             tinfoil.prepare(quiet=2, config_only=True)
-            d = tinfoil.config_data
+            # Expand keys and run anonymous functions to get identical result to
+            # "bitbake -e"
+            d = tinfoil.finalizeData()
 
         value = None
         if args.flag:

