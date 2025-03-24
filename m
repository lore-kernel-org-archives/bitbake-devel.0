Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F99C36002
	for <webhook@archiver.kernel.org>; Mon, 24 Mar 2025 17:41:34 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.45501.1742838088716576699
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Mar 2025 10:41:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UvtahhB8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso25225865e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Mar 2025 10:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742838086; x=1743442886; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BYSWk1JoT+bBWRZU4Grj4XSAq1n8+dabwQ6XOqHwRh8=;
        b=UvtahhB86t9N9eBE3oLLWC7rVRdUjo+epZAtfJxzhf4bWfyipyj9FdXbQ0/YmFI9zO
         h6cpL3VKDcUPKnHVxwOq2OqyzBmMqlcsFH9Ox2sok7r9/u/eEBOFX8xTl05Gq11Q8z3Y
         PAOd99lmr1Y2L3GNh9U7BCifK/RsWUVIj/irg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838086; x=1743442886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYSWk1JoT+bBWRZU4Grj4XSAq1n8+dabwQ6XOqHwRh8=;
        b=Ob+IY4Mf46MslJCcSoqcu6ayK+GyL1TpRWpXGuCoGZO7ttn/68fx48N3vi+z3QVlSm
         OaUI/SRfedegP0WvPpbXa9BcjVHdDK+ohVCN38gVnoE29pBSia0tZIRSS9cPjgG0GyNl
         CXvgco1uHb3Kl5qoMJrF3W6WQmHnq57OcR5PwW1S3vsNrroMVJV4y95QblmlX/F3+RgG
         Pid1/3UKK5gd0OHtTwjuBnSm8Cf143l19CTW6nU2E8TWwFwd8ZpBnMz0Mww1yKLXM0qU
         NQm3sypDkKODU9pgjLFQZFZ/JZwoD8bIizyhrDEI9gI70H1+UGBo4al6o53Ch2zHxWQ+
         KmNQ==
X-Gm-Message-State: AOJu0YzIJBySVm1pEg7V+kQalmJTfM1KSU8wdxfjaBljoL3VktuPvEJj
	C2qH7GK7M8FOEgS2J7Jv/On28d/7w5vHJjwu2raS6nMri7aB834rF6BHgH11+ZP9xJAXcgHai97
	u
X-Gm-Gg: ASbGncvAKE8Plhir1ux+A09g8XUWNVk1eiTwbIslY3FHoJy+7AvGkd2Qu6b17k5KuGN
	5UmE+lcmqCuAOi7r2XS2KeUxFPmEtdFlQUJ44SYyL23/0zgIxNwsSLzC5xVbkTp7XkbR49Y6q9z
	umEIhwfVqH755JeatcBq7/devK+1FkAFhG4y+0LGqk3uoS/8feEE+IfSuiCdrc39ppbJLok+/HW
	U+MzCQVTQjB/7uG9OljEqnvUfLZ+BxQ4R1A8Rlc73ql5rQ6k4L6PoUxly0i83ygxe+6OJb0zTE9
	d/QS9O8KcGn/fB2dV1LYZOaU8/sfaG1hvwtGTqF2RMiXqEZBhxY25pNQX4cKFePhS92myeq2
X-Google-Smtp-Source: AGHT+IGZC5fGkqJ0IkRe6WYjpjfLIRvBaz5IAjHfN6W8MpzzDkgklUUCj7SEanNUdUzftvyd6FwOgA==
X-Received: by 2002:a05:600c:ac6:b0:43c:fa24:8721 with SMTP id 5b1f17b1804b1-43d5677bbabmr92823495e9.17.1742838086307;
        Mon, 24 Mar 2025 10:41:26 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:24f9:315d:dc7:9e14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd277d5sm128137755e9.19.2025.03.24.10.41.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:41:24 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake: Bump version to 2.9.2
Date: Mon, 24 Mar 2025 17:41:23 +0000
Message-ID: <20250324174123.401420-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Mar 2025 17:41:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17483

After the fetcher revisions changes, we need a new version marker to
match this with in OE-Core.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake        | 2 +-
 lib/bb/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 8622a7bf94..b3026b494d 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -27,7 +27,7 @@ from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 
 bb.utils.check_system_locale()
 
-__version__ = "2.9.1"
+__version__ = "2.9.2"
 
 if __name__ == "__main__":
     if __version__ != bb.__version__:
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index d3e90d03be..aa60a49342 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-__version__ = "2.9.1"
+__version__ = "2.9.2"
 
 import sys
 if sys.version_info < (3, 9, 0):

