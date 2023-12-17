Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0279BC3DA6E
	for <webhook@archiver.kernel.org>; Sun, 17 Dec 2023 13:11:37 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.18158.1702818692581408301
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 17 Dec 2023 05:11:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=O9jzsTMM;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3365424df34so1308878f8f.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 17 Dec 2023 05:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702818691; x=1703423491; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=++Kptv4oR2kk7uDL2qnxcCcSFI1p+Fq3jW2RBFWta/8=;
        b=O9jzsTMMt7iiByHnTwGZg+dC5xipZtlQd8AMtVKamc8EpBt/tUypU9lOvgJTI4ta1D
         7Rb5VOJTKJoG/N6KbKvvP1a7PcjvmjQBQAav8ff9ZoJVp+csTaceOzs9EO+lXnmVGHqm
         86auk7XyS9FKH4Z2QoHHyShxNV8QCxzd8aeZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702818691; x=1703423491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++Kptv4oR2kk7uDL2qnxcCcSFI1p+Fq3jW2RBFWta/8=;
        b=kT2C49qOd9IYqCiXfl3f9ZQx4WEHYzw3ntF/S4U1gdLhb0AX6P8WZAj+ca16ku5BOC
         tBErCGwbR/phcB6FbIhls8mxtoch9x8EwCHKLL0rXd+WtwWf6cnjtHMJNbgxCIQZ6nSU
         Lwph1EaqxEv1a1F5fl3s0vqkVdGkgvOGiO0nV1D9QDE8RBGXtQzkYZHnHNUJbhcBLDZY
         JwdPfMUVAqR67J4Xfc5AdeI8HWCmswFdCxbe/AI/P6qqYSvOzwVeoKCf85vPN6gbfQyN
         acF4wXcBIQ5BDam/aMjchu1RoQl5eUfvvRmfoqc2lIZUvyhU0I2WdnPovKHRdjoBGZgw
         pY2w==
X-Gm-Message-State: AOJu0YzlMG2Sb5vUkb6murPg1Qj9uFk+EN45jzwcreC5TrxQHGuefUDZ
	U8M4dFpxFlchaRTh/AX5O09ccYVh+wHQMj8KMg4=
X-Google-Smtp-Source: AGHT+IHMlfyMw6VynMpJV8utdPOTGpdYAyUEAgwXtrHmoi3k0HOAwBqe1hrjZmjtfpnuxSyuWF44Rg==
X-Received: by 2002:adf:dd8a:0:b0:336:5fd5:6bd2 with SMTP id x10-20020adfdd8a000000b003365fd56bd2mr1293412wrl.127.1702818690503;
        Sun, 17 Dec 2023 05:11:30 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c690:9059:96b:687e])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d4046000000b003365637e113sm6069420wrp.113.2023.12.17.05.11.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 05:11:30 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] utils: Fix mkdir with PosixPath
Date: Sun, 17 Dec 2023 13:11:29 +0000
Message-Id: <20231217131129.3217772-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 17 Dec 2023 13:11:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15693

Avoid:
    Exception: AttributeError: 'PosixPath' object has no attribute 'find'

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index d299b2efdb..52a136f809 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -759,7 +759,7 @@ def mkdirhier(directory):
     """Create a directory like 'mkdir -p', but does not complain if
     directory already exists like os.makedirs
     """
-    if directory.find('${') != -1:
+    if '${' in directory:
         bb.fatal("Directory name {} contains unexpanded bitbake variable. This may cause build failures and WORKDIR polution.".format(directory))
     try:
         os.makedirs(directory)
-- 
2.39.2


