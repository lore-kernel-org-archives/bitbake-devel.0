Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93C4CA0EEB
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 22:48:25 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web10.2603.1755816495116684543
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Aug 2025 15:48:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Q50FosZh;
 spf=pass (domain: gmail.com, ip: 209.85.218.53, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb72d5409so227497566b.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 15:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755816493; x=1756421293; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YnDpq8yTR7od425LJbh0b/saBn/d+8oXOgh5R9BoCcU=;
        b=Q50FosZhexDVwPEDOyyY9umCBkGvArFZy2Kprs0dr2CDHh8kspiIsTaQ/JuV256UiD
         L50w7as6TI2fOfFJ+MsuODr/ABPqwMwhoEPy68Nl5E52C9rYVqswdfvp0X30rwtATkKT
         8QdEXIpT2wjLeyIDOiCpBPPXCwDzzEsNaMpsenst3DOc/30x2ac7LXahIhMVuPAlx74A
         kJ6ZwX8Gq1IXgWOgx8FR/uA2vwKFcgR4QecR+y3Tp0y0RT9ZUYy59+Q2D2PgkhXq/qGR
         iCQjjomCQNw5yFlbC+P8ShpXRwtSSwyOuA2CuljqPdufNnpyckvWydt/fuRFJgail7BR
         IHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755816493; x=1756421293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YnDpq8yTR7od425LJbh0b/saBn/d+8oXOgh5R9BoCcU=;
        b=dmFpsAYjD7E58gApe9pbEgwEcSu/CFakHEVR2ugR/iCyxymElryFnzX2OU3MNbdn+P
         8gJ6KIOBKxCUp9mIoeaVYxA6TVKxMUOgUGNW3SAjz8bCQ2OYvUnr3DuxLtXWLB0PZe8f
         PtR8bsdE0fBumFsqdIsAfi3WVaEYLPIIGhsaTeZ7d2zIm43f8LyQ5EJau269lFtGS96T
         scLA83k/EJWGF9Ed1fd294fcFmHwEWnttDOg6Rga7X0TMH42/H1yaz/TDz6d0uaVED3i
         FAlJ1Gyxpw3k84LWoJbJu1QUlhyN0U5As8YxUp9pvhJuuaOXHxLrvWCdcMrUB4UR2f3x
         DegA==
X-Gm-Message-State: AOJu0Yxucl/H4v79S0JumiUEOyjyDDfCtPLgIhcpjSiZQLCk3AAnzN3X
	A3u5+3hHasOXg+JT9igkXrH5EHgDjExqh5mEivGRnS5SUJ9LvcnzQ9Uw5jxLtw==
X-Gm-Gg: ASbGncsOJ47DTSI1Zvjuz+AnhItZ+J9OkwsT/wMGP15HgJfY2CFMXFlpCMURUrirFg/
	uE2cSs1SjvU9mmmWGLSPUaMT/fAD8Eg1xwPinmELuMZV58/49xFWLO4R1lHxDhS+kRhfDHA/aUA
	E6MNbk+H1LUG9KrHgz1KySbAVDf5fqjGKCm72BjAlppm6ZR03UdJQ+9/wmRmT3LcDo7k+bpq9wm
	Ps3aCRVCni+9dE6bqBGnpNTRLwiHE1hS9N656GP+3v+qnt/XwoOLiof9Xb2fGiSYH+jTyUfRDe/
	ddb/VCAiSxagB8CDauK2FclsCneN0PqKRYtFTxz0wXVPaEPjmER3VRAfw8VicuvPgZLCg7t7LPy
	C1Udbmx/ePnoDLLTYI2zVzXNsgkzlDzJ01MRdcBaHtVvDuEXZoqMpUZs5
X-Google-Smtp-Source: AGHT+IFqHRLtbtMnYQ5JTxuCOzjKuYh0bgQEKOy9kKDlNt6zpEeDqJq5UVLKcPLwXvIB88jWalYOvA==
X-Received: by 2002:a17:907:3cc1:b0:af9:8cbf:6053 with SMTP id a640c23a62f3a-afe28fe85e1mr59640666b.6.1755816493319;
        Thu, 21 Aug 2025 15:48:13 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afded4c9befsm470217666b.97.2025.08.21.15.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 15:48:12 -0700 (PDT)
From: martin.jansa@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [2.12][RFC][PATCH] bitbake: Bump version to 2.12.1
Date: Fri, 22 Aug 2025 00:48:07 +0200
Message-ID: <20250821224807.1696405-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 22:48:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17912

From: Martin Jansa <martin.jansa@gmail.com>

To indicate compatibility with python 3.14

[YOCTO #15858]

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
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

