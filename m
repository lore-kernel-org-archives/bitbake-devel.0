Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AABC6FD1F
	for <webhook@archiver.kernel.org>; Sat, 30 Mar 2024 16:21:59 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.605.1711815711699456777
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 30 Mar 2024 09:21:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gMcXkxhD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4155bc0cf9cso2447475e9.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 30 Mar 2024 09:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711815710; x=1712420510; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KpwFeaRnOFNYUnjlEeirlDic11q/U9QUQhvnvThIJQ4=;
        b=gMcXkxhDCmAcfEpuMtSv+U4o9V+xjGgavr6BjCP6bpKZ7F5xbWncamkAo3Unt8j2aa
         1hZejq2e54VayVMhKD2SvijpJ1rwXohXb2nCfJWNAEja/J30TLaY7+T/fBN9zr+n2Te5
         KAB114pF24YrZ+JsHJJ5NGBcleCvtmTPCGGB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711815710; x=1712420510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpwFeaRnOFNYUnjlEeirlDic11q/U9QUQhvnvThIJQ4=;
        b=fYzN0FfeTTQKhJxhUtm5vaBaoSUTAWk9r5Eh+qAYkaq67hTk+kgmGrT6oK+WQgTJ+r
         NmlzVy5nA8BpmH9pJ1gOklGelaxrKuKhrPqi28nHw0LlgrJTnh/N3x0P6Br/eIgd4ZvM
         SAbFoiZs9cHxEvhuBB4IUvM9q22zv5BDShm0dGmbbMbW000EOsI4venPhK4OrXMIjtwJ
         C6dFlBlKiP/Wut8vdnFCim6iElGPqhopqR6J/NmCL4ROEXkSoi6iitzNnStxmTLderMC
         X1+LNq+0U5wKaYSjFI0Jsn9yabZBHdYfKmPt9z8NzgGomCvZ/UwZrHMAQJAnrLL3Pl6C
         eVzA==
X-Gm-Message-State: AOJu0Yzxm1thff6vX0dHDsKgsY/lpABFX3VW7rWI1bN31ryhywhkpzvz
	14tGvcNX/2NApwOcfm0Tt5DUImWBMGNriIFxbOzaOX7t/QfmaOdLuxRdDASXg39xVQT4YBhz503
	9
X-Google-Smtp-Source: AGHT+IFoU5rJQ4fOlUBxclcpSSLFGIGaaPYtZ5TnxtwT3pYukZfEOwfZEujRJOGeecXcp2sHPFfDYA==
X-Received: by 2002:a05:600c:1989:b0:414:835:6ed2 with SMTP id t9-20020a05600c198900b0041408356ed2mr4021379wmq.35.1711815709964;
        Sat, 30 Mar 2024 09:21:49 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:71ca:5c3d:96bc:4b3d])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c311000b004148670f9ecsm9038245wmo.23.2024.03.30.09.21.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 09:21:49 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] process: Ensure writes to connect pipes are flushed
Date: Sat, 30 Mar 2024 16:21:48 +0000
Message-Id: <20240330162148.1101054-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 30 Mar 2024 16:21:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16036

In looking into a bitbake 'hang' on the autobuilders, it looked
very much like the server had finished a computation and was looping
at idle but the UI didn't see it. Adding in some os.fsync() calls should
help avoid this potential problem (but may cause other timeout/IO load
issues unfortunately).

The exception handling is needed since some writes cause the pipe to
close immediately so the flush would error.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 76b189291d..d0825582b5 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -867,6 +867,10 @@ class ConnectionWriter(object):
         gc.disable()
         with bb.utils.lock_timeout(self.wlock):
             self.writer.send_bytes(obj)
+            try:
+                os.fsync(self.fileno())
+            except OSError:
+                pass
         gc.enable()
 
     def send(self, obj):
-- 
2.40.1


