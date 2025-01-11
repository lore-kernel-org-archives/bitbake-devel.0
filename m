Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC85E7719C
	for <webhook@archiver.kernel.org>; Sat, 11 Jan 2025 14:14:07 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.15946.1736604845586635659
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 Jan 2025 06:14:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=KTXW9K+u;
 spf=pass (domain: smile.fr, ip: 209.85.128.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43635796b48so18584945e9.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 11 Jan 2025 06:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1736604843; x=1737209643; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaERss/gfVKIO0pTeJahuWD5ax6P6cNhNgDIf7Se8yg=;
        b=KTXW9K+u8sABUhT/hXAcgJ98DzU8Wcgs6f8r2AsSffJ2uvPSh/dx/2A41A7stkDwU+
         XiOKQralLqmCZj6c2DQXKYb29nGgM1AiQxi0U0FicvrOkxR0A+mIFkrRCXyZnIeIdL1G
         aRKeg/5T9+mOifar+6Q97LdH4v68wU0qEX0u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736604843; x=1737209643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaERss/gfVKIO0pTeJahuWD5ax6P6cNhNgDIf7Se8yg=;
        b=Crrx+IDzo8goHxIx//DyT7Ri9yPk/PY0M/BZ+wwnIl80YgKHfeR0FQOATB9y6PHE+k
         fWlUL03SVphwmFoeQGOAhMKY3Xbv9Rxko99JRIbXMnA2F8wFK8WKIHn9If6RCPRHWb6E
         o8YCV+I+Enn1VHGFGu1ppdClKsMycL8vSyBE//a9rIY4Zp1odBynC9tLfWlx23GQpQnM
         vpW1hKuZZCQjqmIQgMmROA2/KdJytuik4T7vcJuiPUneBwv+Uq8LrXUCDl+Oo8r8DSih
         KDF2dknzS3IDZ2gFXuNwWkUxLMX9pmadX+G8ksWU3DEJWFg+szyc2ZPSIbg6uDqxTah7
         6P9w==
X-Gm-Message-State: AOJu0YygFn/nLdkzjMC4sw6zK8t+TOHmRxVMX/ycMUg06dgLYi9SGcdg
	DQefws11EEzK6MMyak9mxx8oTkb7ILsZXKD0jcTRI3GOPKJaXh2bDHa0OJSKGHAEjJZiWYy2G8e
	SU08=
X-Gm-Gg: ASbGnctvoevlCTg8uTAyNxFq2jRThG7ukvAJt00FDGdYLlBJ65VMDhpSXEWxaDTtMfN
	6TPBup7yumGf+RtYfPlFPPGNbz6lTZxQ3/5jaYV+Yi+4aQXKliKiyQsWsuBYIORqoG7h4lwP2MK
	F656J15ucZl7blQb7ZoR3rSWbJt9c5v5PmmgJ/a52UyzHZigvBmhfk33ZHX3Fa3kWBfX8XV7JDw
	rWdUNkYKQm+kZRGtEUgHQ+hK53GyDm6YIbzg8j5fB9y0BsA3U8MqfhH5y9Bjp5+P5LHaxyHmA8L
	GYyhxA0CK2U7eoiolOxq64mNzUfoi6GDKB2++1/VG2iIQm877Nfl/VKqMzTwMkw=
X-Google-Smtp-Source: AGHT+IFJ1X+m1R1H2aBSWmp008W4jImyf9pp7NWCWNWKKRlEzHWlKt6lHitmvbcCWNgn1Z0YGNFI/Q==
X-Received: by 2002:a05:600c:1c9b:b0:434:ffb2:f9cf with SMTP id 5b1f17b1804b1-436e9d80fc4mr86271115e9.14.1736604843251;
        Sat, 11 Jan 2025 06:14:03 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.home (2a01cb000deef000bdfc82d7e16362a9.ipv6.abo.wanadoo.fr. [2a01:cb00:dee:f000:bdfc:82d7:e163:62a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436f67192a1sm15110325e9.27.2025.01.11.06.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 06:14:02 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>,
	=?UTF-8?q?Ghislain=20Mang=C3=A9?= <ghislain.mange@smile.fr>,
	Ola Nilsson <ola.x.nilsson@axis.com>
Subject: [PATCH v3 2/2] data_smart: fix ??= operator for variable flags
Date: Sat, 11 Jan 2025 15:13:51 +0100
Message-Id: <20250111141351.3993834-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250111141351.3993834-1-yoann.congal@smile.fr>
References: <20250111141351.3993834-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Jan 2025 14:14:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17016

From: Yoann Congal <yoann.congal@smile.fr>

??= operator works for variable value by defining a "_defaultval" flag.

Use something similar for flags: For the default value of the flag
"flag_name", define a flag "_defaultval_flag_flagname" that is used when
reading flag_name but no other value has been set.

Fixes [YOCTO #15685]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
Reviewed-by: Ghislain Mangé <ghislain.mange@smile.fr>
Suggested-by: Ola Nilsson <ola.x.nilsson@axis.com>
---
v2->v3: no change
v1->v2:
* Refactor condition from Ghislain's suggestion
* Added Suggested-by: Ola Nilsson <ola.x.nilsson@axis.com> since they
  correctly pointed out the fix location.
---
 lib/bb/data_smart.py | 2 ++
 lib/bb/parse/ast.py  | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index c6049d578..897ceeb32 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -827,6 +827,8 @@ class DataSmart(MutableMapping):
                 value = copy.copy(local_var[flag])
             elif flag == "_content" and "_defaultval" in local_var and not noweakdefault:
                 value = copy.copy(local_var["_defaultval"])
+            elif "_defaultval_flag_"+flag in local_var and not noweakdefault:
+                value = copy.copy(local_var["_defaultval_flag_"+flag])
 
 
         if flag == "_content" and local_var is not None and ":append" in local_var and not parsing:
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 2f6c6a005..30ede008d 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -152,7 +152,10 @@ class DataNode(AstNode):
 
         flag = None
         if 'flag' in groupd and groupd['flag'] is not None:
-            flag = groupd['flag']
+            if groupd["lazyques"]:
+                flag = "_defaultval_flag_"+groupd['flag']
+            else:
+                flag = groupd['flag']
         elif groupd["lazyques"]:
             flag = "_defaultval"
 

