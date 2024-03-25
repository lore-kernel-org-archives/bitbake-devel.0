Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DB5C6FD1F
	for <webhook@archiver.kernel.org>; Mon, 25 Mar 2024 15:56:53 +0000 (UTC)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
 by mx.groups.io with SMTP id smtpd.web10.56159.1711382212119039096
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Mar 2024 08:56:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fylmCd+V;
 spf=pass (domain: gmail.com, ip: 209.85.166.50, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d05484dd40so23484839f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 25 Mar 2024 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711382211; x=1711987011; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lYAFv6Z2WE6T2z9zhHB1zqeB+YtvozkHsR2EkTr3k64=;
        b=fylmCd+V3fKpPnt/8E4lkfInDxYnddXDNCCppmwsAG7HCbSOGyVM+yj/GlQOULrz6F
         ABiDRRFirn521SY8mDCnKXjnbwd6Wgzv8cRZXL8NHcs8dZHAp0XU2WNyh2QC4a7L8x13
         PTVpM+L70UuG63coWpi4AbzgbbA1/ziOS97hzzpmeHY2If8Snuuz0L7p5vY4/B/yPoCh
         TBlyj2OwhSHRq8szIfns0JDL7ARrFTJA2ZNqd7IH249lt9IwmK79en3NFMKlZ6r/cZGD
         Rxw1HOWtEY8rDMy3QD1JqIyZKR0K7K/D40ByMAqx98fHln84Y0wRE8QL2I/JTpA0ANYO
         bHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711382211; x=1711987011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lYAFv6Z2WE6T2z9zhHB1zqeB+YtvozkHsR2EkTr3k64=;
        b=ESWMMiIxMOEzr5c6N26CB5oi7ld7Drkl714Efhe0AY9aLHzkf5VVnwbux+MtDXCaYr
         Ur2iVTvEO5G7wfwX8D9XZjWEI8yf2nyZMzd1gxL37DuFJl7j3M8+qF3c4BZv6jEu9rMH
         KL5ZxUzejIZGkw3Fd5hORde19fBREoUj70jmrniLkR433DjD2ANwShmL99Oj1kAeyxjQ
         /DOXiwqItDpm12MEayVvhSr0QF15ulW/u9u8FTg/AJBU2afL4AAYTvei0TVA+Atm9W5G
         u52U/J1QjfeMrJ7gTgS38fBEFjM02FFX/E2tZ1JONYzni5Au1GkSAEmAI4mHCmfL5kHP
         fdsg==
X-Gm-Message-State: AOJu0YyhqMwR7d7K7/HRsX0lwO8WwVPWaNvFDoQWTCjOd76GWiL9mYK+
	QJ47D71qSUINi9K2AIWlr+1wmy5uVLuqmISjicnuHtE00wr/MzsdeJl3hKVm
X-Google-Smtp-Source: AGHT+IHIhgVtpBvtA6SNoCo9ufnHCgfU22CWtIpT2DA+zNu9bttHLkZPTIqAlV1p2GcDTY4NASN5TA==
X-Received: by 2002:a05:6602:1b46:b0:7cf:3d3:7549 with SMTP id dl6-20020a0566021b4600b007cf03d37549mr133675iob.15.1711382210706;
        Mon, 25 Mar 2024 08:56:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::78ab])
        by smtp.gmail.com with ESMTPSA id t23-20020a02ccb7000000b00476c56069e7sm2286260jap.105.2024.03.25.08.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:56:42 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake-hashclient: Warn on bad .netrc
Date: Mon, 25 Mar 2024 09:56:32 -0600
Message-Id: <20240325155632.2002975-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Mar 2024 15:56:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16013

If there is an error parsing .netrc, warn the user on stderr

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-hashclient | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/bin/bitbake-hashclient b/bitbake/bin/bitbake-hashclient
index 47dd27cd3c2..610787ed2b0 100755
--- a/bitbake/bin/bitbake-hashclient
+++ b/bitbake/bin/bitbake-hashclient
@@ -346,6 +346,8 @@ def main():
                 login, _, password = auth
         except FileNotFoundError:
             pass
+        except netrc.NetrcParseError as e:
+            sys.stderr.write(f"Error parsing {e.filename}:{e.lineno}: {e.msg}\n")
 
     func = getattr(args, 'func', None)
     if func:
-- 
2.34.1


