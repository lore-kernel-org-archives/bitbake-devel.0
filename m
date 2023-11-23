Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54EDC61DF7
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 21:49:20 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.108516.1700776158769631762
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Nov 2023 13:49:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fwaNBV8r;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40b2a8c7ca9so10090975e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Nov 2023 13:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1700776157; x=1701380957; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3m7fEghTDnnHJu/kmfBhwMGDkN/cUb+blRRSvtb8okc=;
        b=fwaNBV8rIrr9WxhoWjBe2IfZgQHLpcZlsARtuwaLnBJ9tTClajtLX5s4sair5i/5Cs
         voM76335gXtKdie8Q5DhZ836IEP+xWtukMv2zQsUW7VS525zRCbRiNLcivz6RAmFUn+d
         EBFln0oQ+qxakV3AbkkdRNYhsatSIt53e7KzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700776157; x=1701380957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3m7fEghTDnnHJu/kmfBhwMGDkN/cUb+blRRSvtb8okc=;
        b=wG7kMV8en1fWaxk3NvURFzmanr+2/c8R4/RzOghh7rBxgocf3LD0/y9lYqB6m3DWZj
         ZTHfuWSuNQjwbhf3LYCEVujm41X8TFGC0WlXF+lS0fJSgDQN5vay3FZzdYyWLS7ZCsWW
         N4xwtwBcjARhX7FxX18fTWfExoBDVrsSLfA+BiaVs4o7ssLzsueyvSmKNCQMWSxncv3n
         RA3ojIn0J/SFEbuCNsc4I8Y+mAkKFf9SmFVX3UK7SqEVWTn8OjfwrFbPceRFtS42bxry
         3aTVDCtNdEzW0O2lCUeUYFu9g6xPeEHnz6xSzRZ8SXLFKe9ndCp0DQd9B4jdPR9czbIK
         80/Q==
X-Gm-Message-State: AOJu0YwnPhv3SbfS8Oj+HA31HarSYM/LdsuxHC/WX0u0d+Uoo4GZK7Ra
	0Otzl7IP5Hx8gQURlyMWM+bZzLht8GpcvFYfAb4=
X-Google-Smtp-Source: AGHT+IG6P1/oPMQBpPafwgrssgvulWuhfumhntWzYqRrDtRpILHtAWf4a0zQx8ErmOTUd/i0T6mnbg==
X-Received: by 2002:a05:600c:428b:b0:408:3b8d:f7e8 with SMTP id v11-20020a05600c428b00b004083b8df7e8mr584060wmc.33.1700776155980;
        Thu, 23 Nov 2023 13:49:15 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:2b4d:5aea:2d30:c0d3])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0a4400b003fefaf299b6sm3175691wmq.38.2023.11.23.13.49.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 13:49:15 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] ui/ncurses: Add missing function call to avoid traceback
Date: Thu, 23 Nov 2023 21:49:14 +0000
Message-Id: <20231123214914.3723422-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Nov 2023 21:49:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15567

The ncurses UI wasn't working due to a missing function call. Add it
to avoid a traceback when starting builds.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/ncurses.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/ui/ncurses.py b/lib/bb/ui/ncurses.py
index cf1c876a51..18a706547a 100644
--- a/lib/bb/ui/ncurses.py
+++ b/lib/bb/ui/ncurses.py
@@ -227,6 +227,9 @@ class NCursesUI:
         shutdown = 0
 
         try:
+            if not params.observe_only:
+                params.updateToServer(server, os.environ.copy())
+
             params.updateFromServer(server)
             cmdline = params.parseActions()
             if not cmdline:
-- 
2.39.2


