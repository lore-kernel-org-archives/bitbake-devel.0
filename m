Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21E5CDB474
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 15:23:59 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.219742.1697556231247469196
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Oct 2023 08:23:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ETVsmUys;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: rybczynska@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso4952060f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Oct 2023 08:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697556229; x=1698161029; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qrgpEpXPBiX8TAtrOMYycWdXjpwy9XnmAQooN2zOzaE=;
        b=ETVsmUysnvmSHjIi71+pf7Y0nXKDQ4zjPaRsnyXdgGI7dDN3i2F29AcOz0ceZjm/ec
         h4aMQ6yWA+qIr7Kzl4X4htOm4Pt28Wg/skGJuo26QhqTNVhzIpFCte0xl7RiZ75TKnPD
         n5uNHqSRsqpBAsacE9OArs8/wRENVtQ1O7wwMuYF6yjNgvisCTLBKmxw9Hu7+uHtdWam
         SPMs9Tpp/vS/F8IfLE+3ZJ0cxMVAPDIRGbNLD/LehYAjYkO1GhmLKwQvtdaHAdYCVt/7
         g7oF9Z7dZPqR2NFdc4qrxXBqzwB1HJs0R/KhB/6Bg8DFGMGccVlU6iyQNidBBf36XC8F
         bHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556229; x=1698161029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrgpEpXPBiX8TAtrOMYycWdXjpwy9XnmAQooN2zOzaE=;
        b=l3USLTF84c71S0DhEjKLekr59SsfwbK2RC5WUqvQA+6k7WSxVnYbUJJjmF2ZdIM3NS
         8FZj/CTr7BUWLvJWGeKyKmW2IMRqRmYl/YiHiQf54gFlxaoG8w4tGFu6Sqi3uwD/ArUS
         fAEidsPLLhPgsN5XiBc34Il4uxrqr/3Sa/CUq9cmI0zes4+/KjtlGuVqk/L9Q536B4Xa
         wsC/qwmWW+ndxHeR6mk4fSODebNdhjlJJ/wLitBnCvw8OpsjX6qi5KHlN4Yok+x10E3n
         0+Z3TcVeWu91Hk0FwBMK/Ji2vNHaFJJmRZWF7MxFhAKinunulyocZrUdgVCOnukpvsHH
         9URA==
X-Gm-Message-State: AOJu0YxnB6BPKYHMUl9mAsUCNMuWuBCE0D0Vzaq9vi4kF2VGGz7dHoCR
	jJ4XFs44EPQs4JGzuNTCiC5maHkMK1I=
X-Google-Smtp-Source: AGHT+IHrhV0xks3sBM49VVVjZrvw+rkC8RuhmmUs7IdengT+ALR7XaElaLQ3CK9IVWHyF4UQSOtGmQ==
X-Received: by 2002:adf:f741:0:b0:32d:8246:5c67 with SMTP id z1-20020adff741000000b0032d82465c67mr2364247wrp.29.1697556228907;
        Tue, 17 Oct 2023 08:23:48 -0700 (PDT)
Received: from localhost.localdomain (91-161-217-16.subs.proxad.net. [91.161.217.16])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d4a44000000b003232f167df5sm1884568wrs.108.2023.10.17.08.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 08:23:48 -0700 (PDT)
From: Marta Rybczynska <rybczynska@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Marta Rybczynska <rybczynska@gmail.com>,
	Marta Rybczynska <marta.rybczynska@syslinbit.com>
Subject: [PATCH] Add SECURITY.md
Date: Tue, 17 Oct 2023 17:23:29 +0200
Message-Id: <20231017152329.26594-1-rybczynska@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Oct 2023 15:23:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15253

Add a SECURITY.md filr with hints for security researchers and other
parties who might report potential security vulnerabilities.

Signed-off-by: Marta Rybczynska <marta.rybczynska@syslinbit.com>
---
 SECURITY.md | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 SECURITY.md

diff --git a/SECURITY.md b/SECURITY.md
new file mode 100644
index 00000000..900da76e
--- /dev/null
+++ b/SECURITY.md
@@ -0,0 +1,17 @@
+How to Report a Vulnerability?
+==============================
+
+Please send a message to security AT yoctoproject DOT org, including as many details
+as possible: the layer or software module affected, the recipe and its version,
+and any example code, if available.
+
+Branches maintained with security fixes
+---------------------------------------
+
+See [https://wiki.yoctoproject.org/wiki/Stable_Release_and_LTS Stable release and LTS]
+for detailed info regarding the policies and maintenance of Stable branch.
+
+The [https://wiki.yoctoproject.org/wiki/Releases Release page] contains a list of all
+releases of the Yocto Project. Versions in grey are no longer actively maintained with
+security patches, but well-tested patches may still be accepted for them for
+significant issues.
-- 
2.39.2


