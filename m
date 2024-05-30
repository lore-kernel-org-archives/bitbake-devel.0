Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465BBC25B74
	for <webhook@archiver.kernel.org>; Thu, 30 May 2024 15:41:47 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
 by mx.groups.io with SMTP id smtpd.web11.12852.1717083697269613631
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 May 2024 08:41:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EjUFYv9D;
 spf=pass (domain: gmail.com, ip: 209.85.161.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b9735d7ab4so589894eaf.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 May 2024 08:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717083696; x=1717688496; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wnu2FFgad3A1NOtOtZwU0Yzer+un4KYFB23wV7AVhpw=;
        b=EjUFYv9DYzmiCMW0YYYY2tWLdgLf5+DRSl6TadzKuhyKgD/y+PjL0vd+Sljb9zj1JM
         s8CMTIfVI/+XBajJAyaSHs+dmf8Z0LL0/0RMqKXI4ZMEc8FA6Wm2oP6NWFnfOpyEtIxQ
         VTbfYMGssHJ4lX+peHRAT1tfpY6kFD8Nv2Of4FCCjkW/VwZETieZPe6dsTgCbgQIqzrI
         buC8tF0ZOsGd2oVTEtGTd7Kii1DjGN6+Mv+PQGOMy2M9Xct2ZsIVtI8hsdYO25iuLgIB
         zY28lIC3B7yz2VONO5rwA+xfC39JOiw2PReQ5DDIxK/CuBHltx82zdwtBG4szL56Er8h
         33nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717083696; x=1717688496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wnu2FFgad3A1NOtOtZwU0Yzer+un4KYFB23wV7AVhpw=;
        b=n4AmKBeJW6GcGO8bSyZd8II7vnGDRVtGqvHPvgCpS5od6zMBltmkObaE6PQLQPYf1X
         LZwHUTQCVlDTzMei+CQTzOdmqU/XO5tkPU+1XeQaiwAVFGxXh7SB/3hDvXzL06l+Mejd
         WqxQIYyH8a4XBIgvBIG0y/Vw64ZZjpiupFJ/hPtzZpf+mEjvdrthSvqVWN54Pfji3plD
         dy+BuXNnayvx7W7wqV9i7ErwmoSu3bFNi04fd60iEiCoYkKWa+wx9zLXlhy4Jq5SHtd1
         bOqoQGMEjX3cqMeZCL+8UDN9hD5Z6QhSLTAdCi4gFLDUkphmcVB1BP0csbMxm4FnI9MU
         Z4Bw==
X-Gm-Message-State: AOJu0YwfzZptsqVLKa3pm9ofWWN8sAP0OpTWWiUKumQbrXsGyiiZlzJX
	Zz6HjTgXuK7u4TJk25BPGOkeePRdq3wTUfsKxQwFwHez61O2YFAOe3CyLQ==
X-Google-Smtp-Source: AGHT+IHCG0WYeaRnmOVf2Bq1UG8AjUM42gOaJa1xG8DnalOtVCN8RWRVPE6MmCodWtsX+rwZ1YnmnQ==
X-Received: by 2002:a05:6820:1c8e:b0:5b9:d8ab:2e34 with SMTP id 006d021491bc7-5b9ec722c63mr2503026eaf.5.1717083695789;
        Thu, 30 May 2024 08:41:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::125b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b96c6d60f1sm3184813eaf.45.2024.05.30.08.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:41:35 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 3/3] siggen: Batch unihash_exists checks
Date: Thu, 30 May 2024 09:41:27 -0600
Message-ID: <20240530154127.792582-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240530154127.792582-1-JPEWhacker@gmail.com>
References: <20240530154127.792582-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 May 2024 15:41:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16291

Similar to looking up unihashes, use the batch API when checking if a
unihash exists to speed up lookups

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 79f347db303..92066da00c9 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -671,20 +671,20 @@ class SignatureGeneratorUniHashMixIn(object):
         if len(query) == 0:
             return {}
 
-        uncached_query = {}
+        query_keys = []
         result = {}
         for key, unihash in query.items():
             if unihash in self.unihash_exists_cache:
                 result[key] = True
             else:
-                uncached_query[key] = unihash
+                query_keys.append(key)
 
-        with self.client() as client:
-            uncached_result = {
-                key: client.unihash_exists(value) for key, value in uncached_query.items()
-            }
+        if query_keys:
+            with self.client() as client:
+                query_result = client.unihash_exists_batch(query[k] for k in query_keys)
 
-        for key, exists in uncached_result.items():
+        for idx, key in enumerate(query_keys):
+            exists = query_result[idx]
             if exists:
                 self.unihash_exists_cache.add(query[key])
             result[key] = exists
-- 
2.43.2


