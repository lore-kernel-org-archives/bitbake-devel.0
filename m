Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FF3CAC587
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 16:56:52 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.24165.1757523403800428763
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Sep 2025 09:56:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=vrbkkoDe;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.177, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7725fb32e1bso7637842b3a.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1757523403; x=1758128203; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RWGFL9MjqdnlHRjjY5chdRZndhtV7JlVhcmVtM/+Uo=;
        b=vrbkkoDe4PQ1kRHg+uNzcDUjc+vOebgE6TOWEeA1TSHZZKj3I+uCXezmuVM95zKNwk
         osCHbxl8Rv0ziYAv3JDVzHRJUoPcxai4PZScMtfjdhnmhB2j3RV7Az+Hljl4Zq9F6JVv
         r8s98+/IaPmMkc/5VC+/R0ESEwbPBlz5StFHygt8eXdiqN4MXONUbur5LhpE5tJQ8NXP
         ePTIu+qH6sIXEUQCnD+b1iuk9r5Y/AZeZluZAtZ9UOy1OVZnCQW9h/cCBvXGY4g7gLWL
         pHfCLA/LjzjONhJ7XGwuXEYZ6n7PuV5dop8huHGBmRQrdtVLzADWIsi2x8BFraJPcguM
         oVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757523403; x=1758128203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RWGFL9MjqdnlHRjjY5chdRZndhtV7JlVhcmVtM/+Uo=;
        b=GYjj/zDPcAYRPa4lHcMp0Go/sZU/30GuDoqbO8ywrAHy/a7trVgQLjrdybIBR7n4ON
         fZHMdx5u0uoAsgVwDYsBYejq5aKhRS4dcWUIYZkc4yMSwIOXN/A+/xJdpRKmQaMSWySd
         M90tXgipegA0w9TjwlDix+uoYgamWApg4HSkTFJtQqSUUBCQ9Goj2+8WAxIHlxNy7ZsS
         bId29KX/kwumFMtXkIatCkQWro9t2rfx6tDqBxeBOUIWWqHFx0b4VLOOFsjhWpv6XTdD
         bQb8/hiXXBydabJxUIed1OAuwDFWiWbO1l19DFXhV8/g+8DkzHwAUeZ4XPpTjhecSxZT
         Kaqg==
X-Gm-Message-State: AOJu0YxD/Y/FKfmhQGQiQlUXf6VaH4IJjl6YUj+ktJSbPmyn6YnRbNHf
	b6f+XL94Nc1ZKUW8DR5sRoOiDg36z6uOMXmiFTZA+45/1r0lagTFDCgSDFKosyfbbf48bhOzkZY
	pl8kK
X-Gm-Gg: ASbGncv4KkcnHC+lIJZ1LOz30hxfDbkIiHsPt4wv1nkU/RfggYykD7PMcVmPoJQRe9G
	+PooBDvMu2hY9S8W6EcYTt5VtkO8vawTUGaUItkdsm0TxOJp5EtilTA7yxK5DX7uc7VpPvz1zbI
	XqIvgWhNenpNLVtc7HOHfnCEbD2f09rMqiRC+dvdAz2KtbQxCEd1Rb9Z/8Nim3ez+qObJSfKFfd
	nZ/hmkX+8MF3pM1Kpy1N4TWVjvWToMo67MDwcSw4HF1zdbsugcS8CgiKfT8jI2vng3MxTJFdH54
	1QZw5pr3CH+KsV58alecDFWICpVTclDcKdf/hbX7eLrzePHh2TrPdQD+Ic+O/k6OjwF4Ua82YH5
	etUT90pdf5UZ5Z6RR1HjzMPMe
X-Google-Smtp-Source: AGHT+IF/FexmA0EtXQ3RCLh/dseZgI0G5orcgG2psKGtJ6mCMuHjrWHVovUlbHAjXAC7LRfSuHuKuQ==
X-Received: by 2002:a05:6a00:84e:b0:771:f69a:c426 with SMTP id d2e1a72fcca58-7742ddadc99mr23710225b3a.14.1757523403007;
        Wed, 10 Sep 2025 09:56:43 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:5b33:a32c:9e59:27d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77466118071sm5673608b3a.24.2025.09.10.09.56.42
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:56:42 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 2/3] bitbake: Bump version to 2.8.1
Date: Wed, 10 Sep 2025 09:56:34 -0700
Message-ID: <5d7f7fc9633d3c380f095e7b22ac0dab1492c846.1757523235.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757523235.git.steve@sakoman.com>
References: <cover.1757523235.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 16:56:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18005

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
index f494eaa13..a2a42a3f6 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -27,7 +27,7 @@ from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 
 bb.utils.check_system_locale()
 
-__version__ = "2.8.0"
+__version__ = "2.8.1"
 
 if __name__ == "__main__":
     if __version__ != bb.__version__:
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index f59c2515b..3fb2ec5d1 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-__version__ = "2.8.0"
+__version__ = "2.8.1"
 
 import sys
 if sys.version_info < (3, 8, 0):
-- 
2.43.0


