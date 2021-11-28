Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9CCC433F5
	for <webhook@archiver.kernel.org>; Sun, 28 Nov 2021 22:03:04 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web11.52930.1638136984432556491
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 28 Nov 2021 14:03:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=ClZmq3qG;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.44,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f44.google.com with SMTP id
 y14-20020a17090a2b4e00b001a5824f4918so13808523pjc.4
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 28 Nov 2021 14:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tkvt/zmPhLXLF7jS4CFAN/rK39Vvl2tQAwBt0fAhdgA=;
        b=ClZmq3qGMB+2nEnLdxnj/2SA9CK5aLMLIF6i6foTOPHRsEFTZKmgPTb5yIW01IvUg+
         GV/drJK2baprFGUpNQ9flLFWNIbwzNFSYNoZsc73TTYEIQ64OKYem7/JRWuttnANmN/1
         YUkjo4E69kfJVreIzR18ijh9bEc5yUVN9FV29AymeKLJJkUKmM5tWzB4Yb6eFCWRey12
         h2zbgQSojVTcpTkr318cPhUV7++1lX8b6JGl0PgKG/nn1kkxQnE9UJTTLgvCKR99lqU+
         7moG7qTQ3kCb/ZYXjFhmWJRP5V2z3eiy17gXJOd79VOsltm7KuykEXJJpUCGqIBpionO
         DgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tkvt/zmPhLXLF7jS4CFAN/rK39Vvl2tQAwBt0fAhdgA=;
        b=6oXSN7TrH38nNjMdGnyZASXu/dk5Bnc3XSVkUW2c4S0tMcEV+hpWNBqrTL+sD5bFMM
         TyL2AtR0WtlZByYkK0yWd8Jk6Mw4WyqB6D0NMHADE5JFDSgUtxoM4kwVD52sWsli8EV3
         e3nmEnG1p9bl/nDKMzflaSxOS5XrDDO6ECXwoOu9W2fAHD/pT0pWJdsY1iw1/tJ7jyne
         d+hAS5GfsboMLj13D8VQCRwTTz77U9bIUyqouvWtife7mdyrTYzWn+ic7ijBkkie9+TL
         HSl8jlucrFt3ghRyRnD3XPknKtNhwI1MVfvpkCwktNRIyIMizIMG44NV6GhdCSQEks05
         RFyw==
X-Gm-Message-State: AOAM5332pNYY+SjcwBeu7jkClllwpSzFbSSSLF+/qCsEwTAxIRcdE/el
	6TTL4TkdMm7uyKdmQ96ndwkdAT4swmPUBHZj9w4=
X-Google-Smtp-Source: 
 ABdhPJwBOC20I631el+Pu7kLtKXlkBr0LBwdYQoWQbh6zRtpyO4TgcJTQmkuvVyrbuJny0SlyFV8Sw==
X-Received: by 2002:a17:90b:1c81:: with SMTP id
 oo1mr33359301pjb.5.1638136983374;
        Sun, 28 Nov 2021 14:03:03 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 d9sm19749139pjs.2.2021.11.28.14.03.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 14:03:02 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/3] command: Ensure exceptions
 inheriting from BBHandledException are visible
Date: Sun, 28 Nov 2021 12:02:46 -1000
Message-Id: 
 <80348b68a34b7ec45a0496a4af7f2ae0c26488f0.1638136822.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638136822.git.steve@sakoman.com>
References: <cover.1638136822.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 28 Nov 2021 22:03:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13119

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Previous changes allowed BBHandledException to be detected but not exceptions
which inherit from it. Fix this. The code really needs totally reworking
to preserve the exceptions.

[YOCTO #14054]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ef762d92df6c2554c6248e80212f984d9ec4c651)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/command.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 6abf3866..07128027 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -74,8 +74,12 @@ class Command:
                 result = command_method(self, commandline)
             except CommandError as exc:
                 return None, exc.args[0]
-            except (Exception, SystemExit):
+            except (Exception, SystemExit) as exc:
                 import traceback
+                if isinstance(exc, bb.BBHandledException):
+                    # We need to start returning real exceptions here. Until we do, we can't
+                    # tell if an exception is an instance of bb.BBHandledException
+                    return None, "bb.BBHandledException()\n" + traceback.format_exc()
                 return None, traceback.format_exc()
             else:
                 return result, None
-- 
2.25.1


