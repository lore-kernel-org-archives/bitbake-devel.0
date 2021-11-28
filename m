Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA00C433F5
	for <webhook@archiver.kernel.org>; Sun, 28 Nov 2021 22:03:07 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web11.52933.1638136986771488819
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 28 Nov 2021 14:03:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=hk9Greif;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.44,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f44.google.com with SMTP id iq11so11014767pjb.3
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 28 Nov 2021 14:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wEsBcQJSpPY36KdFWL3/WMM84JeXzts7LXdsXDFer6U=;
        b=hk9Greif9vGKauNyv79Q5NTTCaNW1Lj1CUPXRFcFrX44tbJTC0m2U+W9wrC1/PvM0V
         yotTv/paNRaAEGVMG6heWK3jCRmtrBthQ7EIj9JCzmyGQLDXDhJxYjiHVO9GbXELoy+v
         jw6KYRy/JCuDxMyH+Y+3EQmgKmbfrXx8zTmgdirqMlhZua9wODGFUNjGZvSMGzxeqHVU
         B7EWqiOB6MGu7dd0wbL3UYP3TlkbAyAnSWPPIxxTBlxWkhJSNgFwFCNJ5mCkgeCzPYv3
         O2NtZ9jBO15ikMm7rH1aimvxVvJGBfUvuCacLcgOVUrr/+pNh3+kgYmh86EKtch4uktC
         /sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wEsBcQJSpPY36KdFWL3/WMM84JeXzts7LXdsXDFer6U=;
        b=AnvoZVBm0xJeQQMX2/VINj5NGaNKyg+pDpaJhHqNTyrxc04io44aFlIo6X6qrQT8TN
         hqYQOVx6emGTX5E5TjUUHqAOciZMPNHt+ojShP/I12Jk9svZPSX3PPExOCVIT2ljKacB
         SK0ymhjbHMnwlO1hNNe/tKYbVUorBm1w9mTDAECJh35ICx6nGwnfAvG0FHWPMZyaiy3P
         MH41zFEOM5hiZpk0iYBLOeA7EwpEtf+c545IyqzlKEZZKgchcvXKJw6zl7XtRHxK/2Eb
         peSHcvfBv75z9jf8MgFI52vkwvOkrGW6DKoxecAFxTYiRHzXyzHfMXl3QxkmflI0sFxu
         A/yQ==
X-Gm-Message-State: AOAM532HN5no/+bq34YLLFqcyqARtOIjTuHIDj3JdYvhtkxdT6pVPZEn
	W0C0oYCkyQj/0+Qv++et6ugd9n4IW2V+c0pNoOI=
X-Google-Smtp-Source: 
 ABdhPJwgI1Cak4PaZ7xcw8QEXI/kFRJkJ+pMiiAvqyKPy/+ryjFzQF3yOVUHMIGKOeH1j1JYhePVvQ==
X-Received: by 2002:a17:902:d490:b0:141:fd0f:5316 with SMTP id
 c16-20020a170902d49000b00141fd0f5316mr54180858plg.14.1638136985664;
        Sun, 28 Nov 2021 14:03:05 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 d9sm19749139pjs.2.2021.11.28.14.03.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 14:03:04 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/3] tinfoil: When sending commands we
 need to process events
Date: Sun, 28 Nov 2021 12:02:47 -1000
Message-Id: 
 <f20da5247dea524e837c5b6fdeccc79cbafedf90.1638136822.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638136822.git.steve@sakoman.com>
References: <cover.1638136822.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 28 Nov 2021 22:03:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13120

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The server may be displaying useful information for the user through log
messages so we should display anything that has been sent. Its either this
or expecting every UI to implement this code around every command call
which isn't good API.

[YOCTO #14054]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 64ae9d7e2fad804dd9e12706c6d76b4b22f9586b)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tinfoil.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 8c9b6b8c..ae690389 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -465,7 +465,16 @@ class Tinfoil:
         commandline = [command]
         if params:
             commandline.extend(params)
-        result = self.server_connection.connection.runCommand(commandline)
+        try:
+            result = self.server_connection.connection.runCommand(commandline)
+        finally:
+            while True:
+                event = self.wait_event()
+                if not event:
+                    break
+                if isinstance(event, logging.LogRecord):
+                    if event.taskpid == 0 or event.levelno > logging.INFO:
+                        self.logger.handle(event)
         if result[1]:
             raise TinfoilCommandFailed(result[1])
         return result[0]
-- 
2.25.1


