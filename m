Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89668C636D6
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 14:52:07 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.10818.1677077517540107845
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Feb 2023 06:51:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=d28WMbdE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id o4so8007787wrs.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Feb 2023 06:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+94sRI1KD5v8NO5tcHDwpi+b3j49JvzTK8UgAgRtiI=;
        b=d28WMbdEFap55Zal4gpAwdzoBmdo94PrkxRBpfWvaqC3l97subEPD8+jzknQUDjAyU
         6tbhSDps/YSj4d+tDu95OGJS/UsRdKqIWao82sKAVPE0ouAIK13DHNiFzjaS/79L2YyB
         CyiD5ON6JhzvMwcZrjQHFoYx3FEGhArW5+AnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+94sRI1KD5v8NO5tcHDwpi+b3j49JvzTK8UgAgRtiI=;
        b=EwuRFVr3R5khvUZcX73Pbnjnkls2dKihuuWvADkltT4ZUSWTdITg7nZTlmAMJ1LZeZ
         9P7z5ypHy7AztSvJgSMDSSafysrh7O/UgrvA06X6Ty1Q+jNnL4qNSeQHztrRvLctk5YD
         SnuG3Ik/iNdKzUCOHJBYLvFGtDmmkAbuu8ssHWe6teBiW8QwAR1y84t3KJqJUTJOjfTu
         mPYIIQZFIAmpmlRkSr9m3WZxQfEkdJluMaVrFwkYYMLksN5T1DZdac6adxRQbhjDHJ9B
         V++BH77dIppqEMc/HVq2j/LlcfYA2TNn3Gz9RPTv7gjLt0NPMUiNcSkaQC+i/JxK3G+t
         dffA==
X-Gm-Message-State: AO0yUKUpa5Sh/+8EYsS0qO/rFAyY8F7vvImZGToHUO9aJUvzAvx9mCDy
	3aj1MN+n+2EAkChlLPXVOxzxa6lWxQfF8FVc
X-Google-Smtp-Source: AK7set+AE1ejeJlkIBA7ZuN7MuRRlLLcjNpnhMJ451lkpKXEobZxPmvo1dXztNd7tCPNCBl/HE9Qlw==
X-Received: by 2002:a5d:4dce:0:b0:2c4:503:7afc with SMTP id f14-20020a5d4dce000000b002c405037afcmr8339651wru.7.1677077515557;
        Wed, 22 Feb 2023 06:51:55 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d5d1:6a95:9b62:17ab])
        by smtp.gmail.com with ESMTPSA id x17-20020adff651000000b002c563b124basm7787058wrp.103.2023.02.22.06.51.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 06:51:55 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] bitbake: Bump to version 2.3.1
Date: Wed, 22 Feb 2023 14:51:53 +0000
Message-Id: <20230222145153.581307-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222145153.581307-1-richard.purdie@linuxfoundation.org>
References: <20230222145153.581307-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Feb 2023 14:52:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14478

So that OE-Core can depend on bb.event.check_for_interrupts(), bump our
verison number to a development series version.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake        | 2 +-
 lib/bb/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index f869eb4854..21fb100e9a 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -27,7 +27,7 @@ from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 
 bb.utils.check_system_locale()
 
-__version__ = "2.2.0"
+__version__ = "2.3.1"
 
 if __name__ == "__main__":
     if __version__ != bb.__version__:
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 4e90964173..56be5a831e 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-__version__ = "2.2.0"
+__version__ = "2.3.1"
 
 import sys
 if sys.version_info < (3, 8, 0):
-- 
2.37.2


