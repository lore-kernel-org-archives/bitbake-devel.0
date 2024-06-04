Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B641C25B78
	for <webhook@archiver.kernel.org>; Tue,  4 Jun 2024 14:28:11 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.23069.1717511286995462303
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Jun 2024 07:28:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DSiK28uY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4213b94b8b5so22175625e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Jun 2024 07:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717511285; x=1718116085; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fuP5u9Q8awMP84BONylqqzQeYwLsCknEbIKHBhs8HTs=;
        b=DSiK28uYtzI/qI1mD9ddCTRPk8WfKeexajd5OIpgn4+tDHGHGhyZCM9ZjbRddCFFOJ
         2j4qb+keY3CGVae8+HvBQJPVMyuuJOaVCWBwegkLf5T7lE1p1eexBUcuGv2Huv1r0bTt
         1WatrT6zQvTUpVlXlkKX+2d26rxqKjIT/Q6oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717511285; x=1718116085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuP5u9Q8awMP84BONylqqzQeYwLsCknEbIKHBhs8HTs=;
        b=u82Fve7iLe0JG1L47IgePJ+tNjq0WG9Tq96dwq26hwziOgziWYBwwURDzI//IyUXOB
         ldTbV7puBycl8cWOmJyMT0u4wMGpjHZmOdEIRi42mcgj+5i2WqJ5RXjCmDplQgtvs/uv
         fy1JRyVdtE4C8Tm7KOMmXVvZCmxQzKTQeRJfcOj4Y8CD2aTZ3J2x5hqXaruxA5Msg3nR
         dWKuDJdymlRrgsWP8QIuFadnffdsv46wq2dBdiWO0Hfou+In+pFQq4WZgscaGrF7ZRtn
         Etr5onfIsOXdd2CTiQ3a5piFE82NaMr2ZtzfODpaUOxXCGTbDxHwYzop1gElTOopf66I
         2Qlw==
X-Gm-Message-State: AOJu0Yw5BNgyHYiRzbHQMa0YUiP7qrnma9XZ0CUso9/G3VdtwlgGbYqS
	v922P5o0NGlNcu+rm3vJrCYF789HfzhC07DKjye6SInEcFejDJM46D8lspNH12eik9bNlsNyceA
	p
X-Google-Smtp-Source: AGHT+IEY6oU4QBt7ZYiQAzUtF+v5+ttUQMomvXTZf8uTGuv4Ygksoc/+k3cSeDbSjwDEwqSjpfbhwQ==
X-Received: by 2002:a05:600c:35c5:b0:41a:a4b1:c098 with SMTP id 5b1f17b1804b1-4212e076530mr108548275e9.19.1717511285071;
        Tue, 04 Jun 2024 07:28:05 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9a5c:ae3c:1b90:53c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42135c9dc18sm122043595e9.1.2024.06.04.07.28.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 07:28:04 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] siggen: Drop copy_unihashes function
Date: Tue,  4 Jun 2024 15:28:02 +0100
Message-Id: <20240604142803.3658144-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Jun 2024 14:28:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16316

The code in OE-Core using this has been replaced with something more fit
for purpose. Drop these function calls as they were never a great idea in the
first place and cause IO slowdown for runqueue needing to sync the cache.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 92066da00c..89b70fb6a4 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -201,9 +201,6 @@ class SignatureGenerator(object):
     def save_unitaskhashes(self):
         return
 
-    def copy_unitaskhashes(self, targetdir):
-        return
-
     def set_setscene_tasks(self, setscene_tasks):
         return
 
@@ -418,9 +415,6 @@ class SignatureGeneratorBasic(SignatureGenerator):
     def save_unitaskhashes(self):
         self.unihash_cache.save(self.unitaskhashes)
 
-    def copy_unitaskhashes(self, targetdir):
-        self.unihash_cache.copyfile(targetdir)
-
     def dump_sigtask(self, mcfn, task, stampbase, runtime):
         tid = mcfn + ":" + task
         mc = bb.runqueue.mc_from_tid(mcfn)

