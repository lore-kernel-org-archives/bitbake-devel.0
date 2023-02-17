Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD715C6379F
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 15:18:54 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.8857.1676647127768281816
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 07:18:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FpFjEV8U;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id e4-20020a05600c4e4400b003dc4050c94aso1197144wmq.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 07:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ursWNhpCNBUzxgzTQDO7WUWy82Z0cVG/stOM9KP2Oo=;
        b=FpFjEV8UbCNtCqJn/3+R17iwUoEtfYYTCPqTvvMlzqQWGFoMzm88ANDIGrBLoL5Gqc
         KyXW/ZG/KBhXcrS2wAKJ7KGR1QpRFQfGHWzzQ3ZevNuXGzOCmdzD20d1p+nLf9Js+UFb
         QqRacrYE2DRI1kFX0Fy4sriH9v63oDSs4I+5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ursWNhpCNBUzxgzTQDO7WUWy82Z0cVG/stOM9KP2Oo=;
        b=ptnVKXfs76CmEwux8PtNcayZ14CL+ZObYDI7nDVUPWYUZeldZtXFqWISVC0Erlvfko
         Q+09ZXFWD9OwfTUvRJnqLUUtzICNYz81o2QHTB8eJOXn8lwRqL/89i4GabUbG/+aNykm
         BW5FU+H+A2fbFs7f4P6JeEfdZckqz//HlHMRvTh9T/GZUGSXwbo1QMm3FHLs2uA9OI7F
         wYsfw4hjfmv1ABB0SNh+h8tgBv1nZniB1AcYH1vftwfpdxI3ky/wd9Fq2BAQhQcVzmJ2
         l0/gujbVTFT+GIyGRyPdHHA0tamoww+2o6TYkS8qgwZhA15WhDgFCfhuTFpWL2FYK1Co
         7Dag==
X-Gm-Message-State: AO0yUKXwDNffMlrBgUIQt0VeurmiQfNQIaFFvS0itt0CgU1mDiKMcDkT
	GIHf4mNdPJ1DRwlb4QdF5VocaH++9IjghSf9
X-Google-Smtp-Source: AK7set8X3gcAVkVSAGZfd9NPRgWMt7uhY9yH7i3Vdd/RU58Mhwu6yIx1mAPUL8+SRcnYKN94epxZIQ==
X-Received: by 2002:a05:600c:2ad6:b0:3df:eedf:f378 with SMTP id t22-20020a05600c2ad600b003dfeedff378mr976414wme.24.1676647125762;
        Fri, 17 Feb 2023 07:18:45 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:33b5:dd6c:d0ba:e1ab])
        by smtp.gmail.com with ESMTPSA id n21-20020a1c7215000000b003df7b40f99fsm239818wmc.11.2023.02.17.07.18.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 07:18:45 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Drop SystemExit usage
Date: Fri, 17 Feb 2023 15:18:44 +0000
Message-Id: <20230217151844.351586-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 15:18:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14458

Using bb.fatal for a fatal error message is the best practise, switch
the code to match other call sites.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ce711b6252..e5bd9311f2 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1941,8 +1941,7 @@ class RunQueueExecute:
                 try:
                     module = __import__(modname, fromlist=(name,))
                 except ImportError as exc:
-                    logger.critical("Unable to import scheduler '%s' from '%s': %s" % (name, modname, exc))
-                    raise SystemExit(1)
+                    bb.fatal("Unable to import scheduler '%s' from '%s': %s" % (name, modname, exc))
                 else:
                     schedulers.add(getattr(module, name))
         return schedulers
-- 
2.37.2


