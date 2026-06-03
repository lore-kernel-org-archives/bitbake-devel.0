Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C846CD6E6B
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 10:48:59 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17040.1780483734669224855
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Jun 2026 03:48:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=avkac4hs;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so4059571f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 03:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780483733; x=1781088533; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwAFRt8rERQbGM4z9pgSdcSj91XPJyaxKeZxawLFYW0=;
        b=avkac4hsFeK6uaEu+ZidFljxdhti6xD54qNzndYRZs6OLEGH9rzY3lB/slklhWQ9MV
         My5EXQVTodAiW72Ew+zGNRS6zevuAxPWWtoyW1OflDem9jkOTppvF7jNt1dUhNUqG4YH
         L9CT39xK7d0Qu/RMhPDe/XDqiCb2XNFxQ0894=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780483733; x=1781088533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LwAFRt8rERQbGM4z9pgSdcSj91XPJyaxKeZxawLFYW0=;
        b=MHliHAHYcnAI6ISyl/GMjb2HaTopv1QeRPfeCn33zz1E9nokhaGoSkxYfhR8qnwcmj
         XkrkFKyx3xh65UJpHC4M2sD/kxzMhTRipmeCv2nK8C0hhsh7mF5KUTRLnRgypEiP/Teo
         NKr1184ysVcq4sD0KI1kKEXqLtrdnvtampL9Ht83J2cRvyQlDgRypV8AV/i8S0BhNf6L
         R252L7+trOgfuydr1P1NITj6pKn4ELMf5C1cW0zeEQ77ySdq6MQ0CEiM0Y0kjYCwiYDU
         KCxkcC8YJ9JvvnmoaeVl2/O2hPYvRKGDgHVcL+Wd4Zqgln0d96GYHEclqVk25FqgOHkC
         cxfg==
X-Gm-Message-State: AOJu0YxAbJGmvoEH+nDirIaRCC1sC6T3egwotAHssXWCFo1Jjb7MAz4F
	SQ//kp+JTz23qz5aYdpH5a61M8ERZKANsEq2198gh3f//boZdlEy/Hi2alV9SIvGSCPWXtQH/Po
	uFIGk
X-Gm-Gg: Acq92OGAOjNCzsHC4BA3A33TPXqTrSjLUw/PLqxV9kLSSiCtrJFklN/GQgbIPefwE7D
	0KrWXwkiS9v4e51X5sWmLf54olErezqPLHPhFUfFwTB37cyLmXehAJhUYBfoHlqKQ0AxXu0L3p7
	g3kuDCDgat4HYkAP0b4a6GFrlSZ/W4rl1Du+krfsz0R4AyzZ3q2GYCqUF0vmxLaB2nxxSAxR1zm
	fxVMEthq3y56ydTV7zYZHXZKvsyaKaIa5eM2iBtwV0ZINO9MNIFnzywS4MyNKW5rwlv/CgEZL2I
	Z+iPXGb1s3jjjNhaiV4Xnb5bRXFQ3ryVqMmsN+pILK3sRwrPeZuo0rLvvzBettcN3RJeA5mLYqS
	aitS1Ls90v1btXnrpMzYtHW0HzDOwrkt5jpwDUnezXqHLCVNVWEmcys4GscisdP0iCxi7TqtQti
	i5LmZP2JKa1ni74jo2qaPnGzPf9bjvMJbpxxJslX86Cmx3M+wZtzW937OqTK/NioV/z+OYps+k
X-Received: by 2002:a05:600c:c174:b0:490:b2a6:8c2b with SMTP id 5b1f17b1804b1-490b5eb82b2mr47214255e9.10.1780483733135;
        Wed, 03 Jun 2026 03:48:53 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:202c:df88:9261:8b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35ee64sm8090759f8f.30.2026.06.03.03.48.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:48:52 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 8/8] fetch2: Drop shell=True from runfetchcmd
Date: Wed,  3 Jun 2026 11:48:40 +0100
Message-ID: <20260603104840.815399-8-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603104840.815399-1-richard.purdie@linuxfoundation.org>
References: <20260603104840.815399-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 10:48:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19601

All users should be updated to use lists and we can drop the shell=True
fallback code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index e3b8f5787b1..93d8b1820d8 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -979,10 +979,7 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None, extra
     error_message = ""
 
     try:
-        if isinstance(cmd, str):
-            (output, errors) = bb.process.run(cmd, log=log, shell=True, stderr=subprocess.PIPE, cwd=workdir, env=env)
-        else:
-            (output, errors) = bb.process.run(cmd, log=log, stderr=subprocess.PIPE, cwd=workdir, env=env)
+        (output, errors) = bb.process.run(cmd, log=log, stderr=subprocess.PIPE, cwd=workdir, env=env)
         success = True
     except bb.process.NotFoundError as e:
         error_message = "Fetch command %s not found" % (e.command)

