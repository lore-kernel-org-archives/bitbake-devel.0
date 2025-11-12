Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27B1CD342C
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 17:24:19 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2994.1762968257661153941
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 09:24:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DUoRKBSc;
 spf=pass (domain: gmail.com, ip: 209.85.161.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-657044fea68so411974eaf.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 09:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762968257; x=1763573057; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b666XxHNU1QCYOxIFKtCcAHD35XB02pAMYGGU/KKM3k=;
        b=DUoRKBScqZnRky8QAwSAfgkC0KpcOg8ee5/F+AvRzhY36F40tS5csNFDE3yR7x4ZGz
         cXbHL9R5fJCNtTKafQg/Uag8nFhmTxvM7oWFIQH6E+Wz8QuEbGrw7Av6aSL8xxG3dTpc
         mmP+ZyMPm0LFtpyqnHEE3gn+8aVpbnUfVfUMYpTAhEmZsh6elE80bjwzWB2Qbig/rQFa
         yr+FbYfzvQPTxtjv2HaefFGZzBAu0rKu2KfVq1r8erZrXwNYOUqln10JVEEfYPv3sPb8
         HtzNMbDTtby9Rx1no+UWeZuk5m/k1TEOR6wd4JkwsSSdeAs2gdyr+0XviFROEhTo+Grb
         6+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762968257; x=1763573057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b666XxHNU1QCYOxIFKtCcAHD35XB02pAMYGGU/KKM3k=;
        b=xU6AJKWsWr9pPGSCPlABvSrXWFevNR+ZisTo51xgtqO1ORO8BqiTt4WgKHzaj4h/kW
         yV1A3cdoTlrpLB8cFwo9te3XHev/3D63RKmiUgOBTfm7E2iwl2S+5SEJW6iwzLakp/Tl
         vQGs5/2rS2czNhMfm/q+RDeGx7a0gGfSf8T0b/cODuHGfUsk1fC+LZKwTH2f1rq20vZH
         HqSMWEx0oEfBHV0GIN05085/ly0OJUJf12Kq9RV1yxlETVz/v7X6CE6oARa+nuzq0Dkk
         iOivYHYLQziy/v2K1+Im40EhiWfpvSfFo4bhPSEElSzOvrHDT8FFupHNB0WbzKRxLF/U
         zyzg==
X-Gm-Message-State: AOJu0YykRHuSTLfo61f9JIwtN/xhuyjFDzsrtprp9sUwxvm59iY1iQH5
	38YsMiNfzCLo2+ngkEpxaeuEkNU4DQ7yxMmczhXy47QdH8jJSax7BAH+dIlGZw==
X-Gm-Gg: ASbGncsPiE/00/cfQX2Cmuy7ncsYWB/UKFCd9ARHH8vCzqhHj+10XeZEG6KmHaed4B6
	No+oqPzuT8EcJQ7cCYq7di/I2FsE7FEkDkc231WxOXk1AFb6Dl0aEjSmYXbZ41USyfIdeuYIT5N
	748nOlqRDiM3SW+08US7F7fbj5DQ3040SEya1SQWy9YF/TnHIcgWbsypzEHTq+fb8/EJaNA6Zir
	5js1jOAtMdJur/F5cfqovZmagi1lh50g1zicc5whvBLNF9l0nBYIEcZiZi0idV7foH4IbM+w6BY
	zhZSPu3i1sgTFaq0Gwp85Y1lQNXfKgT+Uc7AGvdefDaq+FTBIF2fo1xUR+nrJQ2UP4I/svcVW/k
	+rx4uCYebT5eoETSQ3X6lwWo41kWzgWCIEb7bm3qRXfLa6l4Ug2MmgS/LU7Mse1LrSAO2wXUZ9w
	==
X-Google-Smtp-Source: AGHT+IEGv74sBSxWexnkxbQ2ZZJisYSVQ6rqcw+QIrdO6PLOPhx4USW0yt9X6grcLJgpZORDtTayKQ==
X-Received: by 2002:a05:6808:6f94:b0:43f:5f02:2f30 with SMTP id 5614622812f47-45086404f81mr135312b6e.4.1762968256677;
        Wed, 12 Nov 2025 09:24:16 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::51c7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57d5928sm8804092eaf.13.2025.11.12.09.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 09:24:16 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2] bitbake-setup: Prompt setup directory name
Date: Wed, 12 Nov 2025 10:24:13 -0700
Message-ID: <20251112172413.3763712-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111172522.2838760-1-JPEWhacker@gmail.com>
References: <20251111172522.2838760-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 17:24:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18362

If the setup directory is not specified on the command line, prompt the
user if they would like to change it. This allows the user to use an
alternative name (e.g. a terser one) at setup time.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-setup | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index c32381e50..3df8f120b 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -466,7 +466,16 @@ def init_config(top_dir, settings, args, d):
     upstream_config = obtain_config(top_dir, settings, args, source_overrides, d)
     print("\nRun 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(" ".join(upstream_config['non-interactive-cmdline-options'])))
 
-    setupdir = os.path.join(os.path.abspath(top_dir), args.setup_dir_name or "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_")))
+    if args.setup_dir_name:
+        setup_dir_name = args.setup_dir_name
+    else:
+        setup_dir_name = "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_"))
+        if not args.non_interactive:
+            n = input(f"Enter setup directory name: [{setup_dir_name}] ")
+            if n:
+                setup_dir_name = n
+
+    setupdir = os.path.join(os.path.abspath(top_dir), setup_dir_name)
     if os.path.exists(os.path.join(setupdir, "layers")):
         print(f"Setup already initialized in:\n    {setupdir}\nUse 'bitbake-setup status' to check if it needs to be updated, or 'bitbake-setup update' to perform the update.\nIf you would like to start over and re-initialize in this directory, remove it, and run 'bitbake-setup init' again.")
         return
-- 
2.51.1


