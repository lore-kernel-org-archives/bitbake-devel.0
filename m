Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web09.1805.1614724037987597014
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Mar 2021 14:27:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TrsNiuCX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id w7so3507087wmb.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Mar 2021 14:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Js7R3H9NaAHV/Hy0l4a0CII3v4bZJPLzml05MPTPrY=;
        b=TrsNiuCXSFtkMdbJgwkkC8c3nwF9TL1QQqv+kMeGjUe+spzixuYu/8UaVTWMfDT2du
         Bsd7sjWzCPizGDr9oBTEBgZraC8O+HZQ6s/uby8Ru8MQxhe4fc8sZDCiURqkbEVJ/NnA
         4/SiflevUrGFD7QfNs/5rkCCcNec8i4BvmTrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Js7R3H9NaAHV/Hy0l4a0CII3v4bZJPLzml05MPTPrY=;
        b=NQvMbgTgZ5lXI3U1ZXFSV+k/JOOh0MoG3LGPuG/JUS4bUuIjLihT0QOgqj+7MtVRyH
         CQ4tr6A5+uuVVxdBYn/sdL9XVGLOMTPL/aO5TD7Yx4IM+IJDUw3MoQcoEsPD6CMxuErA
         qtnia0MoWkLtuWxcWG95EFL4+c1uaskyqutQkOdgHy1+96BAEoVl4MFHtOfcyKGNDrdx
         RCIVuk+qNYKJx45xF9gVSbKeDzIJ64cR9iwp1jYEIMUWLFhPxnZYcBb7TW1ffrm3Ehxg
         ayAp/qKLQVX32pMCY1E/s76fn/Ph9AGjkyYzhCduoBQOV6qpWJB5VxdjUQPrzGTCiZfG
         dPOw==
X-Gm-Message-State: AOAM532KDfJnlBJMUnuljovOn9bb5NTzFPjcPWJROt+oxJKnoyayYi8I
	7E7+4NK85njpvcIybCQdMFCjGHX9bJXUnA==
X-Google-Smtp-Source: ABdhPJy+5Oja/Y0zPJ/UkNYj3KL//a19ZpUYYfHzYVSKrNrVTf7JhstiESIMXen5WsRxkMjkM4T7+Q==
X-Received: by 2002:a1c:bac2:: with SMTP id k185mr6140532wmf.148.1614724036084;
        Tue, 02 Mar 2021 14:27:16 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:fd4c:95a0:62b1:7d53])
        by smtp.gmail.com with ESMTPSA id v5sm3910388wmh.2.2021.03.02.14.27.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 14:27:15 -0800 (PST)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] __init__.py: Fix bitbake debug log handling
Date: Tue,  2 Mar 2021 22:27:14 +0000
Message-Id: <20210302222714.2249345-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a while I've been puzzled as to why debug logging from runqueue wouldn't
appear on the console with -DD. The logic in the bbdebug handling is inverted
so fix it and now we see the expected messages from runqueue with -D and -DD.

This should then let us debug other issues using those log messages.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 84a9051c13..afce5ccb87 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -58,7 +58,7 @@ class BBLoggerMixin(object):
         if not bb.event.worker_pid:
             if self.name in bb.msg.loggerDefaultDomains and loglevel > (bb.msg.loggerDefaultDomains[self.name]):
                 return
-            if loglevel > bb.msg.loggerDefaultLogLevel:
+            if loglevel < bb.msg.loggerDefaultLogLevel:
                 return
         return self.log(loglevel, msg, *args, **kwargs)
 
-- 
2.27.0

