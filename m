Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2974C87FCF
	for <webhook@archiver.kernel.org>; Sun, 10 Aug 2025 22:24:01 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.35347.1754864640786928402
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Aug 2025 15:24:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=h/ERACUI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b783d851e6so3293767f8f.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 10 Aug 2025 15:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1754864638; x=1755469438; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/4sFs4InRIAyoXviRoYGlJw5vq69gwsdIb6aPOmTFY=;
        b=h/ERACUIyQcBE3bhjhVu5p/K6VeslfLb/GRLcSE+Qm62/PtoCrqKYtFAozTu78D68n
         YRYjv2agmmEWDsH6F7fSbboXS37iOLxm7BRJkROnWMk6BKeAAD1i3xm4yhtfMi+1dIQg
         d5A04ySN9gnmpco/7X5Ytk+caDIQ7Gb1MFYaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754864638; x=1755469438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/4sFs4InRIAyoXviRoYGlJw5vq69gwsdIb6aPOmTFY=;
        b=nHGl5lvlCr6m/bsWMTCvAb8g9VquT1GGAo+bqJsY+9AN4AfCrVixGMyjbKMOuHwZTy
         PvJx5aGSmYmC/oaTRpVooQDQGEvsMSwEWkv9CRdPrjReIf/tSpekFvZ0A0PaUYFtFqKD
         NVaJ8sFHQDPM5m8uD42jQmv6FMkwA7nZcng2w3XlxyKPEce4s2aEUoWApzlmka6FEvzy
         o0mD8SFkJeNzUwXFyGG1RdzmqrSQtYyBQsxjuobn7CD6mLLOO2CCUL+PFYspoLh4du8V
         eEv8UBB/rC3BqZNNy1HHI4PMPg1tSDKbKxBTzCQKjlHbd1fMs96d8tOIdt+KAbIMksIm
         g+cw==
X-Gm-Message-State: AOJu0Yzw8EoJjcyDVJwCjnpu64eE8yr3tgWQKQjfwN6b+Eg31zE3QZ0n
	BF/G8PRIeYGMcmhT7m82R4fOaSt+KXQHhDtXVyXQ9wkAZkfN/Fw2ozs4WeEQ19607YLReCmObwg
	V41GW
X-Gm-Gg: ASbGncsMa36FE4kYxFFL/G/kGoP73BAUZbyCBXZhQx2Kk7S9OKjaa0ClVA+rfXZh8+Z
	FK9b364+XfHT3f2Ak0H9Lv6GGE5QUh+SQoW9OV0Swmc/E/6AL2A9HEydqN0eeaI0Sg0kU54FCIf
	AGNIsYXtHd7EUHC+/2Myfi0mAZN9U4R4wZZ9CGTTmRu19P8Dfu8rQb2pr0mmsJuEcEEeTBQbvSZ
	hXFJs17dYJgADdUGL7ujnlVX+1tLkVrz1fT+6Fcx9aj2JghCt2sW88CtBn5ooGmYdW/3NwN9GQd
	m2G8pPzVzOnwqbzaxy8+WbDDPPcL1q+5gzO7G9fxl3ELAJO3aURJWEfXIp/RBNGwnTQSoZqMiLd
	vmLazlJL24FPTix+gOpbvwDLAoTUDVr0hJzhlC/0Wm4uu+asFMEw=
X-Google-Smtp-Source: AGHT+IFslZ+MnVRIiwg1qam5T0Byv1JmU/RrqYd+B/MJFXB9C6eHdBn75Rv+tnme7z0mgZ6OLjSqiQ==
X-Received: by 2002:a05:6000:310a:b0:3b7:9dc1:74bf with SMTP id ffacd0b85a97d-3b900b74bf5mr9270809f8f.35.1754864638524;
        Sun, 10 Aug 2025 15:23:58 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:2db4:de3e:1e1f:36bf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0cd2c90sm274039325e9.17.2025.08.10.15.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:23:57 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH 2/3] data_smart: Add setVarFilter function to implement variabl filtering
Date: Sun, 10 Aug 2025 23:23:53 +0100
Message-ID: <20250810222355.2486772-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250810222355.2486772-1-richard.purdie@linuxfoundation.org>
References: <20250810222355.2486772-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Aug 2025 22:24:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17851

Adds a new setVarFilter() API to the data store allowing filters to be
applied to variables.

Note that filters are applied to the non-override part of the variable name
so a filter set against RDEPENDS would apply against RDEPENDS:${PN} and
friends.

The filter function is applied before returning the final variable value.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 8e7dd983841..2e0d3085882 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -24,6 +24,7 @@ from collections.abc import MutableMapping
 import logging
 import hashlib
 import bb, bb.codeparser
+import bb.filter
 from bb   import utils
 from bb.COW  import COWDictBase
 
@@ -427,6 +428,7 @@ class DataSmart(MutableMapping):
 
         self.inchistory = IncludeHistory()
         self.varhistory = VariableHistory(self)
+        self.filters = {}
         self._tracking = False
         self._var_renames = {}
         self._var_renames.update(bitbake_renamed_vars)
@@ -678,6 +680,7 @@ class DataSmart(MutableMapping):
 
         srcflags = self.getVarFlags(key, False, True) or {}
         for i in srcflags:
+
             if i not in (__setvar_keyword__):
                 continue
             src = srcflags[i]
@@ -895,6 +898,12 @@ class DataSmart(MutableMapping):
                 if expand:
                     value = parser.value
 
+        if value and expand and flag == "_content":
+            basevar = var.split(":")[0]
+            if basevar in self.filters:
+                value = bb.filter.apply_filters(value, [self.filters[basevar],])
+                parser.value = value
+
         if parser:
             self.expand_cache[cachename] = parser
 
@@ -1000,6 +1009,7 @@ class DataSmart(MutableMapping):
         data.varhistory = self.varhistory.copy()
         data.varhistory.dataroot = data
         data.inchistory = self.inchistory.copy()
+        data.filters = self.filters.copy()
 
         data._tracking = self._tracking
         data._var_renames = self._var_renames
@@ -1028,6 +1038,15 @@ class DataSmart(MutableMapping):
             if referrervalue and isinstance(referrervalue, str) and ref in referrervalue:
                 self.setVar(key, referrervalue.replace(ref, value))
 
+    def setVarFilter(self, var, filter):
+        if filter:
+            self.filters[var] = filter
+        else:
+            try:
+                del self.filters[var]
+            except KeyError:
+                pass
+
     def localkeys(self):
         for key in self.dict:
             if key not in ['_data']:

