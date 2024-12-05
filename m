Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83449E7716D
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 16:39:44 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.16280.1733416781045492198
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Dec 2024 08:39:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FWJCOPSS;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso1080807f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 08:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733416779; x=1734021579; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rK9y802Yall2lViE6YKaILaNPI/JW8MHA4E8hGsJbcw=;
        b=FWJCOPSSS5qVG+l6j6PORllLgwoOxQk6ahHSpeurVx/wGIIXw0sZJj+g7IJe0e+V3G
         XlP1YlIxSwWFLAFxiTeh7JX7uoLgHVOsoGsMBWylq21iIJdmcswcWCoJZEDhVh0RlZOq
         1Q3PccJrfT4p9UKuZyW6bBLhYjaGjPxuo4ibMgs2yilRH999LL0/3CwyZnbck3CpvS/n
         5Sps3Xw0VoE/gg/tMDuqv1jrX0bgOeg2GRETXcpkW3RQVnGbXaL1Hczp/1y4z/fYopEt
         BvjlqOtMT0SDO2OWxOgDsUR/HU+yR4qKG+g0DuVc6MDYA4tNFSQ3hfe5KyR4r1xX5NBU
         Xxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733416779; x=1734021579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rK9y802Yall2lViE6YKaILaNPI/JW8MHA4E8hGsJbcw=;
        b=qGktBZEn+RiWVcEryjb80SiI1E705tjZe2j4RvnIDY9fxikmt1R+5xunuxNGRdKP+Q
         ORHwVKIoZ86+WeHk0OLsq88GTqX1HIWpI51zBY3HkAcJfc8Hwe/u/w16NpXcwG+WFXb5
         pQA5B1psjBRsc8C+5HGz0ykob53CURdvc0aIEAfWe8ZzEigCQX+kWSmbQI40fO/yzToY
         VL0KUJPNgVLoEq4u7DXVWnBRnzOWGSioEXQ4BZStrXlE/oodz229wMQ4tISyPM0fXAuY
         LhD8eggyS1OjYGClyFa+JN59i2FxpvBjabVTO8/gDm3AX6FrDnMvyRAqlgtT4US6nk/t
         BUhg==
X-Gm-Message-State: AOJu0Yy5WX+cdwMpdiav0XkUgSNhaFiLa0bzxOIJRyxvqq7+CqmLJ4tU
	OszgvRNOZ8RRxwEWm4cTBFcnXc3DVfoMxpIUsa6I5vDcdQxkun9d5ffnpQ==
X-Gm-Gg: ASbGncvET58f+jaYYfv/fd/aNrS7134uJgMj4LHzm/ZtKFXg8J2qBd78ng/u3Lj04CJ
	9KuxpBfD72u4YWirYRx5+Ob0dQ/vhljwrnoIHRaJEs431oHOdKnh/dymnQo8V+wiCyqyT+MczdE
	GwynjLMKjJqPRvECurr3oRy8uYLB1/f2v8e06xlbWuLywqrrpFx9GqgEOWuNtAmK6nZy7+VPvFK
	DYziQQ6HvmeBpDgCjAVxQt9TJ5RLS845fWYss0/MAaBuiu6B6eL0fd68PUOTWdmOfFQjDzZxycJ
	Lv32wkgcams=
X-Google-Smtp-Source: AGHT+IE2uNPYHtVqtzQfSbeJAhfYwDW1t4jXWUQCm+dd0t6lpzIaN0P4aGHpABleDUhd6SgSKk551w==
X-Received: by 2002:a05:6000:78d:b0:385:d7f9:f157 with SMTP id ffacd0b85a97d-385fd4350fdmr12289437f8f.36.1733416779102;
        Thu, 05 Dec 2024 08:39:39 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386219095desm2338468f8f.64.2024.12.05.08.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 08:39:38 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v4 1/3] parse/ConfHandler: allow / in variable flags
Date: Thu,  5 Dec 2024 17:39:30 +0100
Message-Id: <20241205163932.4049957-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 16:39:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16880

From: Alexander Kanavin <alex@linutronix.de>

This is beneficial for config fragments, as their names
are specified via flags, and those names can include slashes:

BB_CONF_FRAGMENT_SUMMARY[init/systemd] = "This fragment enables systemd as an init manager"

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/parse/parse_py/ConfHandler.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 7826dee7d3d..27665443dd4 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -21,7 +21,7 @@ __config_regexp__  = re.compile( r"""
     ^
     (?P<exp>export\s+)?
     (?P<var>[a-zA-Z0-9\-_+.${}/~:]+?)
-    (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]*)\])?
+    (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@/]*)\])?
 
     \s* (
         (?P<colon>:=) |
-- 
2.39.5


