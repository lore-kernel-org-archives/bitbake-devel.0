Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8875CA0FED
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 15:55:22 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.22662.1757519718994062842
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Sep 2025 08:55:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=NO3u2KCP;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.176, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445806df50so61802285ad.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1757519718; x=1758124518; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOSSG13RoEWg1vaiqnySprILZu2RAUDdQ+pQMjsOAKc=;
        b=NO3u2KCPpbVp6ppI/oPkAk6wMW9skWB34M+haLQlD5sm+Ndn99OeCjlEoDt4PwvbXs
         boVCCu76CLIqscrVzORxrF3+2jKAg04jphfE9IrvnFXYPlTOJa2OCTMK4uua5/1u6AEn
         t2aQYy8aGkCAFcxiDGT8mm/rWj8GRTDfgUEuKZTP7uG5MBNxjiNbmJrzF2SfKq/UVbye
         qb0GiqwKyK0x2RB3k0Ac9aJ93Fp0VPK4RwJPbgt0/QGuC9kLuIg1G6ntO6ITxPtBMx2D
         /opPFhS/tRdj+8sA+CtbJb1mr1QvNmjZf8TFlF6bA1Lp20nIXIFnPVkIXDNm3V/tNGwT
         hwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757519718; x=1758124518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOSSG13RoEWg1vaiqnySprILZu2RAUDdQ+pQMjsOAKc=;
        b=XcDhnRaHmEIF8ciHWAfQPhBBNyEFgXqnTR9FLQlZIG5SclqVTZo2KjrC4X9kVKEB5J
         L5iYMbtuge+Enc5KZicDAvp9V9hexyF86qs9RIOJP0HryjnghK04YAYArTrCeSsDB/v4
         pDpiE2riCI1V9DQ89CmovFpGzMjtsO5FNBegFYILBMJeY5Mxx6lvU7tE1FXyYSrD3zmX
         3OyYmqzi/+9e/WZK2s67nI/oUBxp5wYD/YGqDSj2hOpZ51v/aV5GZhwvXD3zte71cQA7
         xAbdHng5RDegH1noLfFXamOsQJsBHeDT/9QQKXx0XPPHcg7XUqxhPXSFbfkUiBZFo0vS
         Zs+A==
X-Gm-Message-State: AOJu0YyEHjrkX6u+pz/ArbGAccunOY656DvU+V6ovb//FOKYrsxFu9D/
	LCkyGDjmVr4Hvr2tEgUv7wqzw62YJY4nZoe+A5yYJdBri/cNbeFrAciJF1Rp8SQxcbBV5wzkaSc
	uosTy
X-Gm-Gg: ASbGncuwofZYcB3mElImX9FmiaC7/siT6H3n7jzaGsRhGXLHSUDs1KRhp9gWvdL0qZA
	o0Rwl4TdIQP19x2827cGf3gr2kU+qG/R9B+KD3j51NOXi4LczMQizrqjQqJf2wq12rWwk+9SusA
	3EAPQRVubLzoltT5KWvDaJxFsgLi13ZOjw47+613xdY54D/JHMpaBgADPfYv6pIjvvpv12EPr2T
	L5bPa+wWwBc0e8AefBDNWZcEEVrXdYEoJw+Yvoi0NQMwg1tI1+6gSuzla0vuOBohSYZOIPsAR1h
	lSbFP8B266lhQg2Hse4viwCgaBXM9IQdPQgGVsFbZ6QpyB+gLJenGn9TsGwIiIl7RUw7EWZnelK
	2riipvR4YC4R7UuqoQlrzQKrL
X-Google-Smtp-Source: AGHT+IHruNpKQdJRpHrGVk7VmQIrDc/AONUpICG9OwIc1WjcszlKJTJpaU9vVzg74gq7W/I4fo7byg==
X-Received: by 2002:a17:902:f786:b0:24b:74da:6273 with SMTP id d9443c01a7336-2516f04e031mr222023675ad.3.1757519718212;
        Wed, 10 Sep 2025 08:55:18 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:5b33:a32c:9e59:27d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2acff3efsm31211655ad.123.2025.09.10.08.55.17
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:55:17 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][walnascar][2.12][PATCH 2/2] bitbake: Bump version to 2.12.1
Date: Wed, 10 Sep 2025 08:55:10 -0700
Message-ID: <a7d07075ed20f11a9bc068b495d739cab71b07c6.1757519577.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757519577.git.steve@sakoman.com>
References: <cover.1757519577.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 15:55:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17999

From: Martin Jansa <martin.jansa@gmail.com>

To indicate compatibility with python 3.14

[YOCTO #15858]

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 bin/bitbake        | 2 +-
 lib/bb/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 09cbb54e8..05b6ba742 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -27,7 +27,7 @@ from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 
 bb.utils.check_system_locale()
 
-__version__ = "2.12.0"
+__version__ = "2.12.1"
 
 if __name__ == "__main__":
     if __version__ != bb.__version__:
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 605355e1a..eba7b8fdd 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-__version__ = "2.12.0"
+__version__ = "2.12.1"
 
 import sys
 if sys.version_info < (3, 9, 0):
-- 
2.43.0


