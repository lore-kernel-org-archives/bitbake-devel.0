Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEBFC36000
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 19:55:39 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.4058.1742414132019817574
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Mar 2025 12:55:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=h7LfnMCQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso140065e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 12:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742414130; x=1743018930; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=w25zwi4wWlGplUqdCymEEpF/STBS8TmAZ0ndjsPy0js=;
        b=h7LfnMCQjoGC12EBPno08YptdT3DrubGke5SpMCMa9V3QiFxtu+XBtk4vokWwi9vzx
         GM24Iri3oxy+MhmNqYowvKlFIzIr6xtfvjCTcqLIdJ52kBCnMD6S3aavMtrYx7rB8rk2
         VAxSXyYoV8ys2bH5BS83dgVMajlwt6fGDVZxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742414130; x=1743018930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w25zwi4wWlGplUqdCymEEpF/STBS8TmAZ0ndjsPy0js=;
        b=NditM+jf9TeYH2dJQrLtkl1SA/Me481bf6VkAox4wpUTnH+/L2zWpT9dI2by8VM7q0
         cDZqJV/pw+WL+KkIkgf0tSb0HjKLdo9GKRr3fux/GQriP2R6DDaYGRHchZYGT3QJP308
         DWE3kHdpfc3uM5DJBrDXedCcyx7bs7saBblu0+RpGDrM44QKjrqefgqBeTUwa4AB1Z1q
         gVlpCkYBLGu67MKIRxAfkc/MZ47PWH16H0O43JrkaVjYwzwCOc0G/bSGx5mD4pzmT85E
         cGiqSXKBLXpIIFcaW9VTjGJehkZQAyxF0HPi5jS+rZptH1rUfV35NJ1kQ8PSpw5hq4oH
         jNCg==
X-Gm-Message-State: AOJu0YxhAt0jN/Ub/tWyPqnj8Z4+nci3Dpl98jqNBjlAhKSRz1xfbE+z
	lG2HQMeOukQNEvmQ6Y6jpbS+x+ixikWaP1bfk0LFYq/mXPTDKoNNEImKPNKQVeGHsoPb2oGAWwe
	7
X-Gm-Gg: ASbGnctbEaGt5X6mF9ccFo3FeVYSwUNUmevhtn9VAyVNswDcF6mLCWxFNyjF3WJQrnD
	YHyjT+AbOezwBABd+xgDf2WwZVBx393Y7+HqPVeJBPNw+cpji8kHX7tkJ4oQBAeCZOUS61LCgc7
	hFr6mpGaRU6rRm5IjXEusc4Yn6eckoLPzOUEMHnAjPExEr/uBqe6W/EeH856I1RwGy8I4T9sTAQ
	XOOPxqN5+KAA7VRFwc6OhpOLTYKCSbawI733llET5lsbBcYCUDCquz0J+0wt/TDoZ0k0CFVy5LT
	iMTTOVPoJbfjauI8t3x5Zf1pNSjqglexxj+646LnKOnEn3iGWjrg2iOk1v2d/9+mLwO6hMhT7Dp
	WjHsQo6I=
X-Google-Smtp-Source: AGHT+IH3Iaf7aXwn44Es4ojYW4jxwzfz7Mnzj+7NAxAKbMsPrP6A1WQrYWDGOd0gV+kT3F65aMHfHQ==
X-Received: by 2002:a05:600c:2057:b0:43d:4686:5cfb with SMTP id 5b1f17b1804b1-43d46865f9dmr19793725e9.27.1742414129530;
        Wed, 19 Mar 2025 12:55:29 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:dad:b471:9c34:4577])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7e9f8asm21678421f8f.81.2025.03.19.12.55.28
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:55:28 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] lib/bb: Bump minimum version requirement to 3.9
Date: Wed, 19 Mar 2025 19:55:27 +0000
Message-ID: <20250319195527.860295-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 19:55:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17473

Since Ubuntu 20.04 is heading to EoL and that we're having other issues
on that platform needing buildtools anyway, we're about to lose the
last python 3.8 platform we were supporting.

Bump the minimum version to 3.9 since there are many developers wanting
access to newer python features.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 876f7e3976..d3e90d03be 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -12,8 +12,8 @@
 __version__ = "2.9.1"
 
 import sys
-if sys.version_info < (3, 8, 0):
-    raise RuntimeError("Sorry, python 3.8.0 or later is required for this version of bitbake")
+if sys.version_info < (3, 9, 0):
+    raise RuntimeError("Sorry, python 3.9.0 or later is required for this version of bitbake")
 
 if sys.version_info < (3, 10, 0):
     # With python 3.8 and 3.9, we see errors of "libgcc_s.so.1 must be installed for pthread_cancel to work"

