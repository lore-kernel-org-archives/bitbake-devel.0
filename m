Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81CBCAC599
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 13:10:12 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.22525.1758114603404188637
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Sep 2025 06:10:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DefLqeve;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3eb0a50a60aso2413305f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758114602; x=1758719402; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YUojhRnwpJwI9EKyAa96JG2YcUrna4iRkpYyAyJ28cM=;
        b=DefLqevegqc0mQIwaJBlt7xREAovQM3AofW3KnjinkXog1NlQuUfaz9HBGhZ2B9641
         clU0FtH9NGcqCpfu61ITsMnvb7uGrvEepmenZhZlfQIE/WpcY77x5KGtYdsEenWjzKIJ
         EOoHSfetOZpUS/+Qw/8+muN+INDZU7rbX7N6QbnWe91aKZd9w8wuR0vV4d3Pn1tYmofn
         igxf/R9YYW0/BAbHk6UBRcnnS52GfB3BmpZ3oGoayavbmHOMWgwYRZjiOeO36kxszyvg
         N9THPJDtAK7Ty3Sr2EPPaCabDh/kMOONEifB3DV/o0WFb0OZHyrSfxszCPg5jUEWp0Tn
         6XSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758114602; x=1758719402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUojhRnwpJwI9EKyAa96JG2YcUrna4iRkpYyAyJ28cM=;
        b=hwgfho7ng8fH/lxy/v73BINXmaXdPHJdjFxjBAWIrBMWZwDJer8jc1bZ02m8Nbgevd
         onSDg9qIncYAHxiGLOuHIndlWypU21lERm8tUVhVtu02JwKPAa1rV+9BWWwWrhI1Aguw
         dw4GANOh2pTQqvCEpgALoRr0Jv4/H5bh1bFhn+CAY5T8+/n64AfLinKH+2GJG3LbHVE5
         rTRhIQLXeL6VidwenTtEYXTsAbbseEYcEj6Gw1zJkzL1HwCbSGMddIOpzrJOVFWe0G5V
         ctHIeyAKd0ieIBUh3auRiPcH+qX9Jhjumf/cCjUiEEFKSKkT5l/q5Tj0ADFjcUddnNEI
         mE8A==
X-Gm-Message-State: AOJu0YzbhF+oAeE6BwpOzz41uhJRl3GLeuCLb4dH5U2I3Q2YlZ30O11D
	nD2kIkkzyfyFju8OYNYed80Qr5ccqAMA9amBi1HtzTes2ZaBTsADuFgbiQa1pA==
X-Gm-Gg: ASbGnctMBqUMWt4Nm3+9rEh7OcgGpffC2a88L1n8MDiF7TL/B75sG27JMQx706TtW/n
	xf/MYKz9okSSo8b/8VKaMWUOMOk0fN8bG6j19G6DTx/Ho/+Y+bTwP/fImUh6FWCAOPbXV9Z/CDx
	koF3ONOy9FIzHS9NYesKqqCWC9l1NJHVcGYxW+5T+yV/gpTlmqfHpefqqgukMeaCjV8PmXhVAO4
	1Ch7qV8Ws6Sp21SOyo866dBoXcKSUdxS5O6RTdBk9TXk/JiC56KwVz+rTwoEvTmkRE02h6OAZNe
	wC2bRriB320gUEcGGHleC6j8waqZwwuUJfCxL8JcdIqyXQVAh3doPZO83BwE6M7ddqEqTjNxjwM
	dtR2t2c4usym9RGzC/MdpH68T9xD45qH6i4wjqtzsW33A9THuhMgzJKRSBE1xVrUF0Yw=
X-Google-Smtp-Source: AGHT+IHkVTIcsKnBVf18uSUST3pZ4uBOinEkpMsrYCdL0jw5sWRb00iDJf/Ht81Av2QD8h0XNYo66Q==
X-Received: by 2002:a5d:5886:0:b0:3ec:6259:5096 with SMTP id ffacd0b85a97d-3ecdf9e2d10mr2069275f8f.21.1758114601456;
        Wed, 17 Sep 2025 06:10:01 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46136daf992sm41987415e9.1.2025.09.17.06.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:10:00 -0700 (PDT)
From: martin.jansa@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [2.12][PATCHv2] bitbake: Bump version to 2.12.4
Date: Wed, 17 Sep 2025 15:09:56 +0200
Message-ID: <20250917130956.2489968-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 13:10:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18053

From: Martin Jansa <martin.jansa@gmail.com>

To indicate compatibility with python 3.14

[YOCTO #15858]

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 bin/bitbake        | 2 +-
 lib/bb/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 09cbb54e8..207de4751 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -27,7 +27,7 @@ from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 
 bb.utils.check_system_locale()
 
-__version__ = "2.12.0"
+__version__ = "2.12.4"
 
 if __name__ == "__main__":
     if __version__ != bb.__version__:
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 605355e1a..175a82b50 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-__version__ = "2.12.0"
+__version__ = "2.12.4"
 
 import sys
 if sys.version_info < (3, 9, 0):

