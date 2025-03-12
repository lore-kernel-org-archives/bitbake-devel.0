Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE51DC28B2E
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 19:48:26 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web10.4389.1741808896709311299
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Mar 2025 12:48:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=Hb4k10jD;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.44, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff087762bbso446924a91.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Mar 2025 12:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1741808896; x=1742413696; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMCZk0yjOTvYCyrcPdg79b3+goU14UWPfDvSrzjEG+w=;
        b=Hb4k10jDfWxS4xPE6QM19A8K2hpi63g8h4LeK45KcGaIYCjKd84EkWoWuABplwd35F
         cWMFScQzrLBxQyHX7ZCjsqx+JC3PUwECNw1zPnhiDIdoRAOsN8xGuic7JMhjWrGnF5Mq
         EdbWBLNttQyG/TfX48tDmxgM60GKwsnN3u40Xw3/MSQDV/ckUFXig1n96y9huVCE6S0y
         qLIjiZn96jCG6WviUK5v3zKHwfdH5CPJLUeNvqQ5robOxKfntnsu1rYnYIfo/40T9ITW
         szDLDCSr7RocnHOaaTQuHonaFr7gLQ5cAC2nwwo2/urmJjhNXa8ENj0VbEdSfyR+AdYv
         z/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741808896; x=1742413696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMCZk0yjOTvYCyrcPdg79b3+goU14UWPfDvSrzjEG+w=;
        b=XOGj1JRbXPNNUpaVDPUxpQA0Y56qRk3heoKLlE3Wc//p0qpAwvxIpDzm3Tj/6B+wfw
         bHhkxeAFoV39+4FJ0yQ8nlSMnPnLg3Tg1+yFbw9LfCQ3H8aDcgxPCXtmLc3ODBRYHKh0
         Av/7OPfM3XAq7I1wocqk5ijKGBfLJou6aEFcdEPJYZbk7+XRQ+fXid7wokG8EqM+MEoX
         6APF7aS5saI2qRMwNMORsf158vG8hxqUiXGuw0mRhxSbArybtCAKtBvEHANXwN27rqRN
         SAPU9wTCFIWMPsA/ZJb7znQkBam44lNh4x1RtS7xNAAV7yeRff9xaZ7Vghv+c2McmUnr
         lsUA==
X-Gm-Message-State: AOJu0YwQ+6eBYBfWzHTpys9r/y9N8U15T8AJNhZ5vdckIDXRs/HpnnLT
	orxmqkpViDzU/cQPwzdbhGX/l5N317d+sv06xhkN/mrgiPQG89y4I5ar3Pv+tAta6TXpFfxq3ow
	1
X-Gm-Gg: ASbGncuGDi7lStWCpZjP1QPqbFHJna8J1M8FJXwJ6GmdrtPVvezTVn+BXqvSrFwBRD0
	pCO1wwOt5A++59eCOEer5b1np8jcPtt70f7uGn1c2Vbsn8NMt1+BspvWzEx53CnZua3MW14UTqi
	KDXy+4QAWISb/QwkAxLZiJ/bkgFoA/8Jw70BCb9Bq3bHwhZQqylynMmx+WeIiQOpG4yhXkBeuoA
	eik39/9ptOLCBYvrOyWYMkwTbTYf3chWaprN08jxGANPIz4H+5zgziv8n49lLu0OQylCst6if6n
	zBoKUdM1hyx52FXKj/ZZtu6lPHdwYrFb3Pc=
X-Google-Smtp-Source: AGHT+IFoOHdfjS/EhNU6IFbfX/klE2D91K6QBSKqvwN1vHpIp0ESNWEaaw4rBxrecWxn6FA5a6hDFg==
X-Received: by 2002:a17:90b:17d1:b0:2ff:570d:88c5 with SMTP id 98e67ed59e1d1-300ff0d4742mr12589259a91.9.1741808895752;
        Wed, 12 Mar 2025 12:48:15 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:5779:a397:ba1c:2b0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e98adsm120700855ad.90.2025.03.12.12.48.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:48:15 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 1/1] siggen.py: Improve taskhash reproducibility
Date: Wed, 12 Mar 2025 12:48:07 -0700
Message-ID: <da5f41996687e18b78d9c9845e621d832115aa1e.1741808747.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741808747.git.steve@sakoman.com>
References: <cover.1741808747.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Mar 2025 19:48:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17438

From: Paulo Neves <paulo@myneves.com>

file checksums are part of the data checksummed
to generate the task hash. The list of file checksums
was not ordered.

In this commit we make sure the task hash checksum takes
a list of checksum data that is ordered by unique file name
thus guaranteeing reproducibility.

Signed-off-by: Paulo Neves <paulo@myneves.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/siggen.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 0a9ce0ede..828729d8b 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -331,7 +331,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         for dep in self.runtaskdeps[tid]:
             data += self.get_unihash(dep)
 
-        for (f, cs) in self.file_checksum_values[tid]:
+        for (f, cs) in sorted(self.file_checksum_values[tid], key=clean_checksum_file_path):
             if cs:
                 if "/./" in f:
                     data += "./" + f.split("/./")[1]
@@ -393,7 +393,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         if runtime and tid in self.taskhash:
             data['runtaskdeps'] = self.runtaskdeps[tid]
             data['file_checksum_values'] = []
-            for f,cs in self.file_checksum_values[tid]:
+            for f,cs in sorted(self.file_checksum_values[tid], key=clean_checksum_file_path):
                 if "/./" in f:
                     data['file_checksum_values'].append(("./" + f.split("/./")[1], cs))
                 else:
@@ -720,6 +720,12 @@ class SignatureGeneratorTestMulticonfigDepends(SignatureGeneratorBasicHash):
     name = "TestMulticonfigDepends"
     supports_multiconfig_datacaches = True
 
+def clean_checksum_file_path(file_checksum_tuple):
+    f, cs = file_checksum_tuple
+    if "/./" in f:
+        return "./" + f.split("/./")[1]
+    return f
+
 def dump_this_task(outfile, d):
     import bb.parse
     fn = d.getVar("BB_FILENAME")
-- 
2.43.0


