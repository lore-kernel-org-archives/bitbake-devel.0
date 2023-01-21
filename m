Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBE6C61D9D
	for <webhook@archiver.kernel.org>; Sat, 21 Jan 2023 21:23:18 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.6462.1674336188796228281
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Jan 2023 13:23:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PY9ez9L3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso6617617wmn.5
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 13:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cr4uY+9vkyNULM9C7oC2K3i6+NlZ98/GnSpURGemce4=;
        b=PY9ez9L34k45zuBY2E/dH3DlWqAcLkbmppzsXb1E7kNV9KaCBwSf/piVWQjP+npjnx
         6uQrl8vsPXgK0ifXBYpJ88lYPp28lV1x7CaKJKUmKwn32DtXMc88i1qPdQ6yRRP1igss
         /lvtc0VcZB2x+EsL2bnhuh/QXI9RRp2AnZ1Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cr4uY+9vkyNULM9C7oC2K3i6+NlZ98/GnSpURGemce4=;
        b=fvUq23mII5vgdME5xTvKkuY1XJcvX4CqIP9gDvU5nBIptaBmnAEUQWuARkk93ozxjd
         Ucdiok+6ETO2lSgUjCSRv2HBDixfXeI79vxBUvhM1mebM40+gFW7L/NWRag94qUZ0aKO
         kU26pimF9KcI/UaRZk7fkXknEg9htpDrGQ+j/WCBqbwFT7ydWQBOS0P0gXaHXf8SV+FH
         Lwyw2g/Gjm5f+8c6XPjv1AKPFPpVgY0L0//69OkV7JMOjrwj1WgNEoaGgVPw+l7CiWwZ
         +gGGqvXhII3wxNyAM6ITS3WryzbsODto+FaL1+snT8Hei2IofT7nwLzbBFOMO2nqJe45
         rXgQ==
X-Gm-Message-State: AFqh2kqgRMQXAk4vypXBN3jkYTmrV6Bl7avQUmBcJonnIJl/Ij1vFoP1
	+3FC7VmHNNgAjS8L9mrjJVBm/TnNRlR1B4xu
X-Google-Smtp-Source: AMrXdXsAv9cxyVDEipUVGL/fG1xh2GX/iAS+K5G/hjKj5Raqn5vjGcFPC2whGzoH/iXiLVVcAC8Q5A==
X-Received: by 2002:a1c:f617:0:b0:3d2:191d:2420 with SMTP id w23-20020a1cf617000000b003d2191d2420mr17918918wmc.7.1674336186562;
        Sat, 21 Jan 2023 13:23:06 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3f1f:fd3b:ca38:d2c5])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003da105437besm6713089wmq.29.2023.01.21.13.23.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 13:23:06 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/6] server/process: Fix lockfile contents check bug
Date: Sat, 21 Jan 2023 21:23:00 +0000
Message-Id: <20230121212305.2171310-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 21:23:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14330

We need to check against the first line of the file, fix the typo.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 4bd68b1e7f..01ce916a3d 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -376,7 +376,7 @@ class ProcessServer():
                 lock = bb.utils.lockfile(lockfile, shared=False, retry=False, block=False)
                 if not lock:
                     newlockcontents = get_lock_contents(lockfile)
-                    if not newlockcontents.startswith([os.getpid() + "\n", os.getpid() + " "]):
+                    if not newlockcontents[0].startswith([os.getpid() + "\n", os.getpid() + " "]):
                         # A new server was started, the lockfile contents changed, we can exit
                         serverlog("Lockfile now contains different contents, exiting: " + str(newlockcontents))
                         return
-- 
2.37.2


