Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51114D2E016
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 07:17:39 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.58199.1764891789095182106
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Dec 2025 15:43:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RsHzBxiy;
 spf=pass (domain: gmail.com, ip: 209.85.216.50, mailfrom: swami310@gmail.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3410c86070dso1137883a91.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Dec 2025 15:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764891788; x=1765496588; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4qd2ZSENIdutxyWcV7WgbuJ/FP7zn8+ZSwYr7HVqBB4=;
        b=RsHzBxiy0+9jWW6SRhCgd/GZUu0jy8mFFPjzsG9KjXJNDU/nffVTlLCk+sKopU/Oi1
         kd2h79mFCASZ1VT5oY+ZIVlasu1V2PbXcv4INoM+9npVQwnEH8dQUE4UHcz8i5Jkz+kL
         sf27CVt1MRcnjZgN+hvZYXg2daJAhhiWsmP0qZb2V64tpAlZPaNsk9J8pjpdRmxaa/Eg
         Rh31EkJQTj7q34CM/gVEESwuswsKFxf89Ufzko4IJ/O2z5HZWeLLCWWUXHavKXuWPf6B
         kiORWJd336kNFp/95LMjjF/GkktYXkZc/G83lh9+8eMJfgsV8meqG5hL/Rxsfz4ZhKxr
         HK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764891788; x=1765496588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qd2ZSENIdutxyWcV7WgbuJ/FP7zn8+ZSwYr7HVqBB4=;
        b=N/n9csq57jlEiKrqtqu75h2SdTbl1O50/Ju5Suyo3CjVa1uCMCJFCT1IXKLAv20CC+
         B3sPqgpopwjrtOqCk3fl9ZhXWk3ISkx/NsYT2+4W555YKsxLx+PMIHMlUeBXKwSxBaGA
         W3nkq26xOOpVRUMvPCkJZGPTAnrHy1ZrU88BsVp/q7MBc5EREtHPxyz3KaJS9h9BH8rz
         wiKcKXdn+zRyHGTk0UPxfvwCVqU9Sq5MeoZaAY8BYbCiA0RFr5FGYgDRz05tWCT6IgG4
         69RDCavlEUOHn0huuuTvv1xjK7Aa7r4hU3G9Kn9pUkQzocXs9QuB8UoizCivc3HvDSm5
         a99A==
X-Gm-Message-State: AOJu0Yz7i7wOxFE3N16HaBtIL2z51o8dNFR9wZcG9uR41YqdJACp/FX1
	YAqval8E/8JBBOofHVn5gng4InIHcfIlZjPX7HQkiUMz3qQJA5idjNjQ+FHV/9Uw
X-Gm-Gg: ASbGnctgqMMnpw+BTLSsQGkrMkeu+SFlu5stetFJENAr/6CBUImomRYhzE9iF+wjH6Q
	uUKskOL96gmDjw7MUg4eemuWnFjngyLJFvqrFB8EqC0/KFq8WrzlWFt2iLhFsfC3guNwaJc9iFf
	ZYsgO2NOLAvTnmrPUMUbJ9OvkAiiacG+SzHQZ1RRNC/ByCIAHr7cq9olPwtfcMOJLOYno1aB9g4
	cfz6S1hI+ljMS5/3xUbEhpCRbopDYn75/ZG+eskuEs09f8L2Ucz0yGM3/678zWKO4j9OoCKJlpZ
	eQXEQ38aC/UunvhCMf6VblNE4UMpTYdNO+JD2jqthDyXIpm3DF5EF7r1ZheRZupxXBoFaVP24ok
	UDCNeXzwdoCFVVP1jQ6rd8TAI87vm1lpZKOif7IyXYAnFHPQ6tIyrYo2dcpOpS8QHcnIiZJPi/g
	L5mWrFmAkBXJnLksHkZYLZGPcBYrkcUE7B1Atwy7gIoDYjYf4=
X-Google-Smtp-Source: AGHT+IFk+w0CD85eWI0j7a9TjJAYS8dqUp2DScvUY1YMFTE5/ecMAuQ39ERAOCQyk5JsLEnv592oAQ==
X-Received: by 2002:a17:90b:4b09:b0:33e:2d0f:4793 with SMTP id 98e67ed59e1d1-349125bec4dmr8986421a91.11.1764891788037;
        Thu, 04 Dec 2025 15:43:08 -0800 (PST)
Received: from lenovo-ThinkPad-T480.. ([2405:201:e00e:f828:365a:16f1:1160:b7d9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-349128be266sm3540389a91.0.2025.12.04.15.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 15:43:07 -0800 (PST)
From: "Swami" <swami310@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	docs@lists.yoctoproject.org
Cc: michael.opdenacker@rootcommit.com,
	Swami <swami310@gmail.com>
Subject: [PATCH v6] bitbake-user-manual: Documenting BB_CMDLINE
Date: Fri,  5 Dec 2025 05:12:40 +0530
Message-ID: <20251204234240.7224-1-swami310@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Dec 2025 07:17:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18545

Add documentation for the internal read-only variable :term:`BB_CMDLINE`.
Fixes [YOCTO #15746]
Signed-off-by: Swaminathan K <swami310@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 734c7858a..32860ec0c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -116,6 +116,10 @@ overview of their function and contents.
       Specifies if SSL certificates should be checked when fetching. The default
       value is ``1`` and certificates are not checked if the value is set to ``0``.
 
+   :term:`BB_CMDLINE`
+      :term:`BB_CMDLINE` is an internal variable and is read-only. It captures
+      the exact command line used for the current invocation of BitBake.
+
    :term:`BB_HASH_CODEPARSER_VALS`
       Specifies values for variables to use when populating the codeparser cache.
       This can be used selectively to set dummy values for variables to avoid

