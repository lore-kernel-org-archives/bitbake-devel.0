Return-Path: <robbinvandamme@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D256C5AD49
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 14:14:47 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.22098.1748528085812570763
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 May 2025 07:14:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YlfXBvKr;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: robbinvandamme@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450d37d4699so2515535e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 May 2025 07:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748528084; x=1749132884; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ajZn79Cc8d5si6GVWBQM7gFwEgSxM3J+zzPMlG7MXuQ=;
        b=YlfXBvKrezkAwtgGfOXcszEouh4+OVv8NItgsBFalRIREpfRERghzq7SFo42lbsmKd
         +E7K5jRiS+mm17fFMaTpudwzFoUVxdzkqr9VUsVCpN4qyJ+s3AaAoK4pJqBU9x4z/5HC
         xD8WhxkSxqHm7Tq8+FzqMxqJIWGbt/8bLgOHSJkeQVfoY6MOY/foT/X4QDjSED5LQb6E
         KxuivMe0YUC9JLFxP0aaJifz9jXr+F0Y7yLE+neKJ5i4CZl0JUM0Fpypd2E2ZAWQZBob
         HVuLMKfLSnQc4OH5s4pVo7Ib9QIhTrzrRxLCAOlysAtlXxRvmL19yFSKHpzd9jjwWhPk
         TOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748528084; x=1749132884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajZn79Cc8d5si6GVWBQM7gFwEgSxM3J+zzPMlG7MXuQ=;
        b=UHzAge6dbV9fXYkqqrWYGAPHjh+vKhypZCx11cCynuJOMV8ED9yrmmCsDb7lmg49eE
         yk1zX1ynqukN0gyWJLyqNVBc2Mr85O8H4UGA9JGx6PAeJfWUL4v9590Teq0A6R/9rt3M
         t2g2Qyk7QrXKJe0dCSmALijhKieGPnevWN/YG2QM6YVBO+KIPlezAvHH2rU9KCtRs86a
         1zCgQZBB46v2099oohsPJujAJWWQJfUXgtc+2rqMJa53HYF4tyRvVQaUjQ+vnXQNfNTD
         Xv7CHknQfcsjgALMiTDIx+ql1813cBM/uIFZGuFfKZrVsMVeRJt47Sne2pXxBhoUGWcg
         WP7Q==
X-Gm-Message-State: AOJu0YxU1nTk0IKFlWLcvfTBNIa3/LZmvP70djJzpET6eAoZ979/ae/T
	o2sPILUJNsc3qR342A1SlC/utJHJTvkjxwu/7i8MG+lCjyL0hdS1MMplGtCAlw==
X-Gm-Gg: ASbGnctbKtIaB3RXzVYNgrtJsJSQhCOkyQr8kpkqwjnyvuN1mF9aSfrvMNp7zocUUHg
	1ikYLVDjZems2VY8IMTg6itFQ8vvce7wOScsDqXB6+Z5QHsU3C7FqO0975TKQ/hBZ+EnkmswxBL
	imZpF4jk5mhtp1j5qpsY6Dan0dJPwzBzV989DQqRihzNa75uYbXtw9wiFAHMnKiZAGVk0vyBZie
	J/q52WfYkYWNqAlrCpqzhqNpVbKojF/YGoaQBJVmSr87xNPI17pvXrK8HhRJT45gGohgJvIYD/J
	QvM6O287Oi/2d37aMDdyc2pudXXH7T2uDhekU1AiH+/WiFIr0/cP+XU5IuPfb0bA2jepwMSPkb1
	hsTK0PgatKHkXmCDeo4Lo/iR7eRA=
X-Google-Smtp-Source: AGHT+IHI0OW4DFQIKC/FGiRgLlM2XpdjZJf1LdosftuX0KhO1J56PvSu+KWjItYAPQ/fzT9LbJ7Ceg==
X-Received: by 2002:a05:600c:5396:b0:43b:c0fa:f9dd with SMTP id 5b1f17b1804b1-45072a49ea7mr56625505e9.25.1748528083812;
        Thu, 29 May 2025 07:14:43 -0700 (PDT)
Received: from PC-G502T14.localdomain (78-20-31-164.access.telenet.be. [78.20.31.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe74111sm2183476f8f.56.2025.05.29.07.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 07:14:43 -0700 (PDT)
From: Robbin Van Damme <robbinvandamme@gmail.com>
X-Google-Original-From: Robbin Van Damme <robbin.vandamme@renson.be>
To: bitbake-devel@lists.openembedded.org
Cc: Robbin Van Damme <robbin.vandamme@renson.be>,
	Robbin Van Damme <robbinvandamme@gmail.com>
Subject: [PATCH v2] [YOCTO #15882] Add question mark to mark the start of the AZ_SAS query parameters.
Date: Thu, 29 May 2025 16:14:18 +0200
Message-ID: <20250529141418.1939172-1-robbin.vandamme@renson.be>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 May 2025 14:14:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17654

Signed-off-by: Robbin Van Damme <robbinvandamme@gmail.com>
---
 lib/bb/fetch2/az.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
index 346124a8b..327273379 100644
--- a/lib/bb/fetch2/az.py
+++ b/lib/bb/fetch2/az.py
@@ -36,7 +36,7 @@ class Az(Wget):
 
         az_sas = d.getVar('AZ_SAS')
         if az_sas and az_sas not in ud.url:
-            ud.url += az_sas
+            ud.url += f'?{az_sas}'
 
         return Wget.checkstatus(self, fetch, ud, d, try_again)
 
@@ -62,7 +62,7 @@ class Az(Wget):
         az_sas = d.getVar('AZ_SAS')
 
         if az_sas:
-            azuri = '%s%s%s%s' % ('https://', ud.host, ud.path, az_sas)
+            azuri = '%s%s%s?%s' % ('https://', ud.host, ud.path, az_sas)
         else:
             azuri = '%s%s%s' % ('https://', ud.host, ud.path)
 
-- 
2.43.0


