Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E45CFD376
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 07:34:28 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2581.1764660741745141977
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Dec 2025 23:32:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MdR6XRRZ;
 spf=pass (domain: gmail.com, ip: 209.85.214.173, mailfrom: swami310@gmail.com)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29555b384acso57692735ad.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Dec 2025 23:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764660741; x=1765265541; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kgH0kR1nFtxBlXf+FFDytk9gq8kxDROLf0Js0utIu7s=;
        b=MdR6XRRZAUXqAqTuQOSKdaQrssrUgMye8HU7yfNZLZoGQQvREks9SdH/eQRnkGuWwF
         DGYbwGMj7iiLExQzX5nhZvTUuKa7hiDFepBmjn4oiTA1qtV/2LO4W2N/qp2wXfdeRSGZ
         fMRQXkZZfF8HcLqLzPH9YKShS2d50YqEfTbf6Dv36oed3AJhTxaj0XKjXFo364cZ5GVt
         p9xrDT/KCvUabp+r2O1OSTrLDTErGa1gccncbJgy/UyXOCLTdEntq1DYh5dZFlNe0usU
         tobhLF1kLzrRskCbnbmyIGCYM3uKcj6EckFk9IvH+ZArXrGrj+762VyAU4joQu82N21/
         IMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764660741; x=1765265541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgH0kR1nFtxBlXf+FFDytk9gq8kxDROLf0Js0utIu7s=;
        b=jCSzu+xAMrUmulnFLErIYueeKvTkaQyJJP5GZOz5gKo2fgW2JMlOpWf71XyU1DvuYV
         E8ny0UFuNCik+CJySy9WMXFeUvOxehAo47+cMyH4ae+H3wEW4q2AkCzd1DrxncM7n51e
         Yw26bvuwMmdSfxT1XQTWl48KiMFwkYUQRTmGo6DXhTCMsBQR14fDVBblfFGJJCOZV/Uy
         aTdm17hn3c/qnL0zK4JGTaU0kuXm92EyfvyzzAVMp3hdtArjMkuamanJg++Vow2rubFS
         k2TgEmGBtluNiS0+fZpMON4wtctcNcsb1URDM0W2kDTCti0jIXCdS8hYAfhTJlw0tOnz
         nVXg==
X-Gm-Message-State: AOJu0YzbU1e+rDFVP2RRkqeP0KuEgev2yb0JQuXR3ao3e5KXFfeUBaRx
	9LR7/mupyWlmCHNOGZJjto3+1ng9LU/DQN6PGYpdzlZTH1I8RUIGnM6RZq+UMQ==
X-Gm-Gg: ASbGncu7YERaVXzht35FDfTsQiQ2R7/Uc/6F4xdISln9yFvCZ/PhVbia1eZKq+WuGga
	Tli0OZXMMU/JNBXjwkaavRephOaUqDX1eILF5LOHIShX1FIpYdEetfjOT0+Jh0v/KyhFS9nzV5i
	1z95so4ynTZMcEDJ9APUn3bEDf6+KDYwwc5v2pXWxOxwcupXc6xzLP9cudsx9iTJSk68cu9BGrn
	VXtDo2tFf3qJgW6UkU1AXBCMdzqHXWNS4R4cN7rksY34SANUBuvYUQUdN3labpE69LbU+kTE3wB
	6j35lHB5ozRIrXZ1Fip4FzbqAfKwfSUwa0Dww0IpCPhBTKlv8AR5jZhLJTj8FpP3aPQcn84JB/a
	dorWYiyDCc8FqlJdhWFcPJS/bWOLbtKvhG3RuXY4V3x8RL9eBM3elawroFrcZTycXCy9pDUGD0S
	bbtizSUxkyzouXFHoHOUHpTna4idfOJklEXBnB
X-Google-Smtp-Source: AGHT+IGA0jvLMH48L6Z/KXXKP8nUS4q+tbJCsLqMZeBqcxkuvPZTy4KTAXdYhxCCE/xufIrdQVPqBA==
X-Received: by 2002:a17:903:1b4d:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-29b6c3c30d4mr425658605ad.7.1764660740707;
        Mon, 01 Dec 2025 23:32:20 -0800 (PST)
Received: from lenovo-ThinkPad-T480.. ([2405:201:e00e:f828:5c52:5a3d:b109:1650])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb27653sm146635445ad.50.2025.12.01.23.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 23:32:20 -0800 (PST)
From: swami310@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Swami <swami310@gmail.com>
Subject: [PATCH] Documenting BB_CMDLINE
Date: Tue,  2 Dec 2025 13:01:40 +0530
Message-ID: <20251202073141.16223-1-swami310@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Dec 2025 07:34:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18505

Signed-off-by: Swaminathan K <swami310@gmail.com>
Upstream-Status: Submitted
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 734c7858a..5e14e40b4 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -116,6 +116,10 @@ overview of their function and contents.
       Specifies if SSL certificates should be checked when fetching. The default
       value is ``1`` and certificates are not checked if the value is set to ``0``.
 
+   :term:`BB_CMDLINE`
+        BB_CMDLINE is an internal variable and is read-only. It captures the exact
+        command line used for the current invocation of bitbake 
+      
    :term:`BB_HASH_CODEPARSER_VALS`
       Specifies values for variables to use when populating the codeparser cache.
       This can be used selectively to set dummy values for variables to avoid

