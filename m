Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0CFC07545
	for <webhook@archiver.kernel.org>; Tue, 24 Oct 2023 11:38:48 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.15887.1698147527944891569
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Oct 2023 04:38:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=h3OMMPKw;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: rybczynska@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40859c464daso25269405e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 24 Oct 2023 04:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698147525; x=1698752325; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wmsAXMZicXABBxPem3XA3haf305Zdr2tFcaxjEylI50=;
        b=h3OMMPKwYaLVvpbVza7ahHlVKHxumZXytfjezhm8FsM4gNqlOkoCFcXTJw8uuPqmtS
         ZEQbAEON7rjtFM4zkl2pnwsuoiGG7o8EeVQDpcVlvBtt99Z2zEF5RuGItFBC3Uf3KJPw
         +tZLlskO6PWlWtMqYG+iCYxXINT7bjCoGQSORKqeMWtMh93P4x7zkEGAmFH5igNiC+lU
         za865RchxN/FfSNW7zos29vJ8BoFV03UcszFJi5V48+sfqhC5X1SJXiiePU95/ksegbe
         2ySohjRmq9LrOAcoZje0ANnjqYVeg2fjMRf40ngdpRL5oFkJClQl2sBuyQwnQY3MEUNE
         AnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698147525; x=1698752325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmsAXMZicXABBxPem3XA3haf305Zdr2tFcaxjEylI50=;
        b=d/ij/Gj2XrruemQhyirLPY8TWfdr1V6ktndnLjOSGQWgEsaQZ8JJOtktRhW9Hk+qdX
         OUwn6yjqDnejP6QkPzRu2GyFezPLyVT7k7h/3k7BURlIHAMOPAQJxhX1Avs/cup8hjSr
         SEA+GtqwdQZU88IwsfLDZk7I8OH9vQPJLfGqSOgtzScKh5b55ezt41DqzdB3odW18QqU
         WgCW+i5ZfKHI2VTzcGaKOBJRaBMwIXN9wCdq9hZQ7esQl+mp812F2pTG3dHU34BcA3KH
         EwrcF+DSQGvrG2TZ1hHckTHTAcnADjX1FWDPQJ+ZvRbdKfR/0FfyZOwfnlleWloU1uBD
         EKJg==
X-Gm-Message-State: AOJu0YyR5HVN4UwFZg46YwAn8BYyx6O1DA5eijVh7WnLT+1Fw7Z5hR11
	yoIal2V1tK1Jphps/pKbTouQ5lZDtec=
X-Google-Smtp-Source: AGHT+IHAry2H3M7Xqe5GZDqPB+kMr//N4zQCfVb1IDi55IXS1pJ55N6Fb9xGRMc11O6K8iIujUIl4Q==
X-Received: by 2002:a05:600c:a07:b0:405:3251:47a1 with SMTP id z7-20020a05600c0a0700b00405325147a1mr8733320wmp.40.1698147524673;
        Tue, 24 Oct 2023 04:38:44 -0700 (PDT)
Received: from localhost.localdomain (91-161-217-16.subs.proxad.net. [91.161.217.16])
        by smtp.gmail.com with ESMTPSA id je20-20020a05600c1f9400b004063ea92492sm12027559wmb.22.2023.10.24.04.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 04:38:43 -0700 (PDT)
From: Marta Rybczynska <rybczynska@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Marta Rybczynska <rybczynska@gmail.com>,
	Marta Rybczynska <marta.rybczynska@syslinbit.com>
Subject: [PATCH v2][bitbake] SECURITY.md: add file
Date: Tue, 24 Oct 2023 13:38:38 +0200
Message-Id: <20231024113838.3964-1-rybczynska@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Oct 2023 11:38:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15279

Add a SECURITY.md file with hints for security researchers and other
parties who might report potential security vulnerabilities.

Signed-off-by: Marta Rybczynska <marta.rybczynska@syslinbit.com>
---
 SECURITY.md | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 SECURITY.md

diff --git a/SECURITY.md b/SECURITY.md
new file mode 100644
index 00000000..7d2ce1f6
--- /dev/null
+++ b/SECURITY.md
@@ -0,0 +1,24 @@
+How to Report a Potential Vulnerability?
+========================================
+
+If you would like to report a public issue (for example, one with a released
+CVE number), please report it using the
+[https://bugzilla.yoctoproject.org/enter_bug.cgi?product=Security Security Bugzilla].
+If you have a patch ready, submit it following the same procedure as any other
+patch as described in README.md.
+
+If you are dealing with a not-yet released or urgent issue, please send a
+message to security AT yoctoproject DOT org, including as many details as
+possible: the layer or software module affected, the recipe and its version,
+and any example code, if available.
+
+Branches maintained with security fixes
+---------------------------------------
+
+See [https://wiki.yoctoproject.org/wiki/Stable_Release_and_LTS Stable release and LTS]
+for detailed info regarding the policies and maintenance of Stable branches.
+
+The [https://wiki.yoctoproject.org/wiki/Releases Release page] contains a list of all
+releases of the Yocto Project. Versions in grey are no longer actively maintained with
+security patches, but well-tested patches may still be accepted for them for
+significant issues.
-- 
2.39.2


