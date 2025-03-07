Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F669C19F32
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 13:55:09 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.11368.1741355703627924033
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Mar 2025 05:55:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=H3QcmhlB;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.43, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso3280089a91.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 05:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1741355703; x=1741960503; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QxXInYW13FxRcsNmm9q3w0pWz20qT7Xe+llWUdFlV4=;
        b=H3QcmhlBC9IFijF6/0eL4VgDqMsB0Nny6B3D5cUV3gR6Irfy369LsScsvtM9VGAqby
         2Ku0HtuwUOchWNpMi4LX/iXnu9/RYg3UwXDJgX0S12ERFO0girklHu7FhDKRnyJrB8hh
         W0A8/49Xls4MqwGALKfUemNpGmbH83U+Ml32OlN5VbKqYfOESPpPjtPiztHXsm/ppFgB
         +SLzXqqSCFKU7gNgxlywf+HCDwCUxyPaxnNwRfyy6Vn9fsje31kt6y2Te9w2JxMU0VWD
         kP7PdKoPaCcJB/Liy7o9dhBbmRyteaiwccYhuM6RXoHAQdaUXho/3+CZwc+bihqXD/WR
         LA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741355703; x=1741960503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QxXInYW13FxRcsNmm9q3w0pWz20qT7Xe+llWUdFlV4=;
        b=oTq8ArWAXDSzr+aYeXPqOeuDEagNXhVtOO2eok2I1GO0qWmxGl8oaSVD4YoxEQlhn5
         x+JSDSOWfg43vwe9C6p2rDftvz4DNJpYowRs4Mi/NGgCv5ecte2KKBhVu3EAew3fKIXZ
         nGRQeLUyJ5qllhbWPGzm85WJAAJQ66L6+xdydrtLlmZAMPebl8OExy6JNc24llp4CRT7
         pVx1n98UBvSqESq/PoMlr40U5MYfcCMJqh9Ewkds6QQFU7xaM2los/Q2Ar6caUH8rI2y
         r3vgJAf1hvO6Er5pvwvbpVMXBkOoCTyZXnE+xwGJ/JbYTbRlmVJ16l3x9pS5Yxe7lezj
         +XhA==
X-Gm-Message-State: AOJu0Yw8p7tvQVChuuFU1uJjdfFszHs+z3sXVGKewIc/hDx41i4DncDA
	p+v/498oNf5IC4GzEyS9PwtX2lu0XqcSTUEzoNa/p6MxEgzvAW1gymZPhqOx/ueJszQlQ/UCULL
	m
X-Gm-Gg: ASbGncu93W6oe+KZPTQUW0N1wsOYQQ62YbjYWbyjQUsRlGBkqxrcwVFf/0zunNP8Jf6
	ImyrZ/SH/d2uhWHdV6IHV0w8J347cpcx1PT7KmQI4Qp+3pymBWO4WWDwHPFhY6WLxkiWSifPxeO
	hpNNfoOa6lHOH5dW4DrIKirjxKcDW2JuWriGNWFm68ZAUq45mzAAmoZfkmJZfb0IOOg91WnNZrJ
	gYYs9Ftf+K0zM9HyNa8a9oHYKgstgAs6QZ2YV7SF3e7xnrqcGVg6CbZbdpiMY0gJ5vWRaGWZU5K
	JSTssljYf5uJjuqhmoTlGJLZO8A7kNhnXvzB
X-Google-Smtp-Source: AGHT+IH6GCFGuS1guYUlkwH/me5Fji1psAhyqpRfdCfKLc+omAPodgdeYEPwXnURsPkvPzgxu/QjYQ==
X-Received: by 2002:a17:90a:d44c:b0:2fa:2133:bc87 with SMTP id 98e67ed59e1d1-2ff6175a466mr11905433a91.6.1741355702810;
        Fri, 07 Mar 2025 05:55:02 -0800 (PST)
Received: from hexa.. ([2602:feb4:3b:2100:cfcd:40b4:f918:b895])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e75edc9sm5488032a91.10.2025.03.07.05.55.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:55:02 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][styhead][2.10][PATCH 2/4] utils: Tweak lock_timeout logic
Date: Fri,  7 Mar 2025 05:54:52 -0800
Message-ID: <f0f7bed1291afd63a27f1863901445e6d40c4a09.1741355508.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741355508.git.steve@sakoman.com>
References: <cover.1741355508.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 13:55:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17409

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We should really try and take the lock in the try/finally block so that
in some rare cases such as badly timed interrupt/signal, we always release
the lock.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a9eb8bf7174b6962b5ba07192fe95b8c7112d9d2)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 0dfe47dc5..83e832c33 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1859,8 +1859,8 @@ def path_is_descendant(descendant, ancestor):
 # we exit at some point than hang. 5 minutes with no progress means we're probably deadlocked.
 @contextmanager
 def lock_timeout(lock):
-    held = lock.acquire(timeout=5*60)
     try:
+        held = lock.acquire(timeout=5*60)
         if not held:
             bb.server.process.serverlog("Couldn't get the lock for 5 mins, timed out, exiting.\n%s" % traceback.format_stack())
             os._exit(1)
-- 
2.43.0


