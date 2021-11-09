Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B950C433EF
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 14:54:51 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.13045.1636469690946589241
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 06:54:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fqCBkK1t;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id
 y84-20020a1c7d57000000b00330cb84834fso2134486wmc.2
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 06:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b3ClYnKZI2g7BU4mVb29+Y2gbeOyqee37rdD0473YSo=;
        b=fqCBkK1tabqpZkFbOtqhNSn2zaZ/kuCfEXwEadrbMGXuR/H785tAETQtphumipq8Qg
         /Y9OgZbwc2wGspYwVOhwov7UWGRX1afYNs8u1pSI1F93S0DZVpAHKbhkRTVdzJWa9eKa
         rjXKu7rJxZAJ5/coO3I0O8bW9xBh8lKL1XAIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b3ClYnKZI2g7BU4mVb29+Y2gbeOyqee37rdD0473YSo=;
        b=A1TYwBD8z0FRwh9ovpOKrBChbztZFUdJ5JNb3a1tSU7eTqUKH4QqbBsw0rLn923cRH
         CtWJTW1B0ND0FeCYzA8rCD6j4ftVIXcCrZhEXQ8i9ukfv53wAr0nSg23COER374Ndo0l
         mDnQUGC1yAxrnMDN/qUms6yTCzZw9B+hu5Te/niYbWx3AxKAgJlhB3DCvQ3tEA048sVW
         s6k0FyAu+Lg/r1Jh5ULx3PSfIp69PsXN+RYq4vyR3+yELIE4+RL0luaHZjRTbqJXG7No
         wdwCKUcwlW5/wf2obsM0G4CicltXUUxfsIRWEUchOrq1n/rM2G3sDH0wEPE4AevhLSb5
         z5OQ==
X-Gm-Message-State: AOAM5320oE0eKMWRBw5PZwUloySGaeObWyXhFsMQbnBQf0DViWf+jdaY
	+jxgrQm342Myp1hzMnsyonMvr3bUAtQEjQ==
X-Google-Smtp-Source: 
 ABdhPJxf4ut6XjKAEXEz7ipuahy4Lkn/xL/gKqjQR59lkYCWAw6Lrumk+rdiOSnFwBqSXNNTzsvuiw==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr7899185wmc.126.1636469688941;
        Tue, 09 Nov 2021 06:54:48 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:10b7:e9c6:d1a:6f7c])
        by smtp.gmail.com with ESMTPSA id
 n32sm2653705wms.42.2021.11.09.06.54.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 06:54:48 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch/wget: Add timeout for checkstatus calls (15s)
Date: Tue,  9 Nov 2021 14:54:48 +0000
Message-Id: <20211109145448.3794752-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 14:54:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12981

We had an issue where a webserver serving sstate had filesystem issues so
would accept connections but effectively not do anything with them. This
causes bitbake to hang whilst processing things like sstate objects inside
the checkstatus() calls. It can be replicated by setting up a server like:

socat -u TCP4-LISTEN:NNN,fork OPEN:/dev/null

and pointing SSTATE_MIRRORS in OE at that address.

Adding a timeout to the checkstatus calls of 15s means that whilst the
system will pause, it will then continue and not hang entirely. Since there
isn't a large transfer here, 15s seems a reasonable response time after which
we should fall back to building things ourselves.

[YOCTO #13716]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 349891e852..743f73cfd4 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -356,7 +356,7 @@ class Wget(FetchMethod):
                 except (TypeError, ImportError, IOError, netrc.NetrcParseError):
                     pass
 
-                with opener.open(r) as response:
+                with opener.open(r, timeout=15) as response:
                     pass
             except urllib.error.URLError as e:
                 if try_again:
-- 
2.32.0


