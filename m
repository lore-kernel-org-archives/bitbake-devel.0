Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D6FE77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 22:57:12 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.4543.1736549823997040818
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Jan 2025 14:57:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=3qxW9NeP;
 spf=pass (domain: smile.fr, ip: 209.85.128.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso18784055e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 14:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1736549822; x=1737154622; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n67qZIS3cIasDCrU9J9goz+tOJkkw66szrsBiA7Bxso=;
        b=3qxW9NePC1L+xvEOSeHnduniq/OWrXFYo7ouExCY1WhtzGzAtpDFKIjs8LKXiXPbHI
         tgu7zW/j8l9f8tIUSHpTpsWP9WX0qxPL92UP3fSj927fs6LX9dMnhAvc6qs9YVV/0wsw
         tqY1RBhUACE3XyCOL1IOdzHjgFUrjiCGiKYng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549822; x=1737154622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n67qZIS3cIasDCrU9J9goz+tOJkkw66szrsBiA7Bxso=;
        b=wa2cm92CaaQt4Ne7gPWFuf0uI1U+MXIPmJRq+RO3qH2O4QLHqc6KjLvEQ8YMuxQWPO
         0DG57bNCpYexk/sSrGLvktvNUggtnaL/zfQV7OZJamKQcpSPGZGT5qzq8t0+UTGq2cfD
         Q88D+1iFgxs5bnMXqe6gt7Eg/86EEkXiCgw1SO6oJg3+Q7rzOz9+wBBy64uZZVVtN3Gg
         DMXEYvPTKgDUIfbT97Jofoi58eOxn8VKWC1RNXczLWmrFn4NK1b6spQGsZ5wp/BnKBMM
         odhERVdDWI4vXZxlfBE8/1WNgFMw230H03OYkdyMFSbOJByr/4pl6xub6TYPBdLkpm75
         2DMg==
X-Gm-Message-State: AOJu0YzSZ1KnA8PofFRrLLdHr4sb9peDbDyZ4epjfNKv7MdPHV5kRtAp
	2XPjFNASnuOYDc2qe698UiBUM+fTaRaH9TDBNVt8etWYRsNCqA2aXaacZJbGIKKovZ+tgppTNEF
	ydG8=
X-Gm-Gg: ASbGncsX7fBFJhKpNxmRm7UtoM+LrzA7lGg3vGIreWj54DKXLnOCGUOq+elTYhD551Y
	ZCklOmoZAWqw1tkCTmqh61NgPUh97JBttEjjcFSD4M7pRx36kcFRWLYorZQ8Ufhx3Hnxm4+IFOv
	HFKOBYfyHeN6x8fmKtsS9r+NRH2fHxZMzN9kfEw6rbfk7pI2IJcRYQGdrjy6BN+R8yrlK4knkdv
	5eLPGf9op8JYkycytsskDjb/P8J3OPh2VEHuLHlLLU0/kZTPCWFpwy29vQ1mzvI4yga6N2GGtox
	yuvvnMYCQ62AHFyZ841HqVZyNGxI0hi6eiF7ZnRy9pvMn7TmseKVtHx2+LxilDk=
X-Google-Smtp-Source: AGHT+IG1puTkL8tSBDFtqS1IgJ5MkYfBzIFvtT4SCNmu/wG374YtKqx7qQPxtaZHBzQzhyJpzo0TPw==
X-Received: by 2002:a05:600c:4e46:b0:436:488f:50a with SMTP id 5b1f17b1804b1-436e26be5aemr124662055e9.17.1736549821699;
        Fri, 10 Jan 2025 14:57:01 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.home (2a01cb000deef000bdfc82d7e16362a9.ipv6.abo.wanadoo.fr. [2a01:cb00:dee:f000:bdfc:82d7:e163:62a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0f69sm98727805e9.13.2025.01.10.14.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:57:01 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>,
	=?UTF-8?q?Ghislain=20Mang=C3=A9?= <ghislain.mange@smile.fr>,
	Ola Nilsson <ola.x.nilsson@axis.com>
Subject: [PATCH v2 2/2] data_smart: fix ??= operator for variable flags
Date: Fri, 10 Jan 2025 23:56:52 +0100
Message-Id: <20250110225652.3892828-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110225652.3892828-1-yoann.congal@smile.fr>
References: <20250110225652.3892828-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 22:57:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17012

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
 

