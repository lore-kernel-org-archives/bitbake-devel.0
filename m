Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEE9C282EC
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 22:09:56 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.6382.1741212590807466945
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Mar 2025 14:09:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=Y0Koq/bd;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.169, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2235189adaeso835285ad.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Mar 2025 14:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1741212590; x=1741817390; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLXwYhqo7UMpagMu+O73c/oE62mOwy1Vn8DQXRT55zo=;
        b=Y0Koq/bdh+AIN/zEdyoKrxAS6pZ8kk8CwDBBAMxPeCrb/9pEdhudzsMrREaz2d+OB3
         dR7TCoMyZ28OKXZ3omtwZH4/fcNqA1knN2kvSrWzFul3QHmjfztdfPgOe+BCCkaysU3B
         sCYmypN8DsgAQipMJjyT+XLQr23oZmezkgXwwbabSfGwYQGHLFGLOpxqxbgQTMl0yjVN
         D7xvVrLUK+xyPEvC8UZNw8vcqxtKYXlFnvEsCXjHhKBQ3WVy4uIgBid7G3dqGJAbSH5l
         wfHP0m8lDVJOr/UzPFnRKzbDCPqzyDqcHVpb93QvhPv0gkYjc061SrUFV6usM8NsgUE9
         4/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741212590; x=1741817390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLXwYhqo7UMpagMu+O73c/oE62mOwy1Vn8DQXRT55zo=;
        b=JMvll/0TOAHRH3koVREdcwH1w341X4sBh6Ti0NvG7mhK0OLPkzEUg7feFCu2GKlB9n
         nXxWccE4CRPHGYegidcGcO7DWhcCacnwiw12rGwjEcLseBfxgLgdLz7lSowzcHTAMb0w
         504Fo1k/rNgPB/2cmTKR0+smzyt2rNoyazNgVlaMD431OsLigt3VGuHPaqSihWwfCiib
         bGw6FyNEafMdlFuxwVkVS5qKQ9sec84kg1CY0wLT7KwOE8Wo8yyFZ8KuO7tFtzK/65AP
         MigxjtBJMaS6qbfjG1Btqcc4bgGY/7PxgxCiJSOdcT7/SeVTXRQutkfHbaDEbGEeQWIw
         HaKg==
X-Gm-Message-State: AOJu0YwAFkLmLLynNNDPjSmh5HVrgCKbgWxQfytXns/Oz3oAMTDYmPyT
	PYdN3ILDins7dwW3fxOIO6NNbxcph0yPjca2+2sqJLcuKiZw8+bG3aIvJoiccbS8E0M/rOQAzqD
	e
X-Gm-Gg: ASbGncvrm/nRyZLWDD8fzvplEBc+3X12JMnVPXfCDM75/2qi6c1V3NMECygXaSx3CSI
	QFsTQ2IanFu/E9Qf8iWNr6zH+9UT1onj/K+WvNkoGAtIEQ1WXvLe4HQWRm9sxBYvBzk5UqdvYWy
	nvUIvJ0If2tf9syhPfaEm8NK9rw9biHACqxbQiLE6gwiraVAiAhMD38VBkynlIyl2XrqD+R08Ab
	uP/lZp+ZjkYIOC4WNotoPhaQK9jaunTangNus5X0s3CtyTZqEWhnvw1mfWGAvMJkiwyYnqqkcY1
	+p8jxU9f7X8FOLlOUWfdBG3s4VDdgPRlST0=
X-Google-Smtp-Source: AGHT+IEIk7f+D+Z7cFd0gO5OCNOEyI4sHq7pFuQYJJKY9NUuDFKT6dFhE6pSqWchn54C8owbDuNfHw==
X-Received: by 2002:a17:903:2d0:b0:215:b1e3:c051 with SMTP id d9443c01a7336-224094410bdmr13783775ad.11.1741212590077;
        Wed, 05 Mar 2025 14:09:50 -0800 (PST)
Received: from hexa.. ([2602:feb4:3b:2100:2308:d28:2350:a5eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d35a4sm118602405ad.35.2025.03.05.14.09.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 14:09:49 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 3/4] utils: Add signal blocking for lock_timeout
Date: Wed,  5 Mar 2025 14:09:28 -0800
Message-ID: <ec72e9e6cc268e5e6af89f8c627b4c5409c65048.1741206585.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741206585.git.steve@sakoman.com>
References: <cover.1741206585.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Mar 2025 22:09:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17390

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We never want to exit whilst holding these locks as it deadlocks all python
threads. Add signal blocking around the lock critical part so a signal
shouldn't cause such an exit.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a097755c671e2b530dea6200a94b39fa9dca246c)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/utils.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 83e832c33..da026fe5b 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1860,6 +1860,7 @@ def path_is_descendant(descendant, ancestor):
 @contextmanager
 def lock_timeout(lock):
     try:
+        s = signal.pthread_sigmask(signal.SIG_BLOCK, signal.valid_signals())
         held = lock.acquire(timeout=5*60)
         if not held:
             bb.server.process.serverlog("Couldn't get the lock for 5 mins, timed out, exiting.\n%s" % traceback.format_stack())
@@ -1867,3 +1868,4 @@ def lock_timeout(lock):
         yield held
     finally:
         lock.release()
+        signal.pthread_sigmask(signal.SIG_SETMASK, s)
-- 
2.43.0


