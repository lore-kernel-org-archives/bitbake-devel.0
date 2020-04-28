Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.239.1588040246830690306
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Apr 2020 19:17:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=KP5C73UB;
 spf=pass (domain: gmail.com, ip: 209.85.216.54, mailfrom: akuster808@gmail.com)
Received: by mail-pj1-f54.google.com with SMTP id h12so542227pjz.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Apr 2020 19:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9LsX4nuETbXHz4xzAQAH5kQOsWDNDlSzOhepr3oRiLk=;
        b=KP5C73UB906DFoOOF0AJ35E7zQ+95CAGNuXfJ3v1m6rp+SUiHdN5TVvcVBFo9zWdlU
         7KJ0z+GFysqwpMboT4DWRxrmQEsVkKsFdmbmu7wz8vsrXt3lA0gqhCUVhuvW2f2gWSB9
         705qoSPEOuNfOp88qE02V0jF1zEmqvRszPrnV4RTb8XghX1wF+m2/KQ7867gzNLR3blY
         Gh3VhEWyL26O9Pa4QJZODIlzCTgsTNdTpxwPbsoO0riWHSsVWzFYKbsXVH+fF9iw3v+5
         OkMUp0oAF/mS5AlhCwbCbe8d8SHFSLDHuYb1iTCCcWpVtAXDdf/q3xk17eqHX6IDbn32
         wwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=9LsX4nuETbXHz4xzAQAH5kQOsWDNDlSzOhepr3oRiLk=;
        b=ER86k/HpwVzTpuE7Wv+DUVdSEVZkJasda3Jx0+jShauWd9iiGrzsZ5XyY+IIuvZJI1
         vNaZQ5riyygftpVf3uknL8yJWmCPndNk+tQsbcUUDSntHdFuAzvvRI40dwtkmO59CNsP
         ED0cprgWaJOaFg+WqAmmQtvGP+lhR2FVcb82AlojtYGotJuoN8Wgx5+D38BYTA2R1lPg
         18xFSt65pGOUmHG0k1IiWS2+6m+bkcg3zUnYqCJYAYwEHGa4UmGbt71QFEFVT49qUic0
         3X0YfKBX9uSYmqOLx7c+iEWJD17nhJRXafSKLTmq45HcSVtsdECcoSZW42q7uZZPK1dA
         ClWQ==
X-Gm-Message-State: AGi0PubGGeSQ/pPTwfuZjwfCAxxJbULcAfKmtDbfq3ojQPeeyPtG4LV3
	c14MGebEhEKcJkelyqBeq6pJIoE1
X-Google-Smtp-Source: APiQypIdg97h/GWvzWm4aHxBuJmqIpubQDgOw2AvUZOVc1na7b88IFqs4JcaupbwUaumjk+LBL2sUg==
X-Received: by 2002:a17:90a:3726:: with SMTP id u35mr2134935pjb.162.1588040246159;
        Mon, 27 Apr 2020 19:17:26 -0700 (PDT)
Return-Path: <akuster808@gmail.com>
Received: from akuster-ThinkPad-T460s.mvista.com ([2601:202:4180:a5c0:f1bf:759e:e8cd:49cd])
        by smtp.gmail.com with ESMTPSA id c63sm9820866pfc.2.2020.04.27.19.17.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 19:17:25 -0700 (PDT)
From: "akuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.44 1/3] knotty: Make the bb.command.CommandExit event terminate bitbake
Date: Mon, 27 Apr 2020 19:17:20 -0700
Message-Id: <2283e0d1fa9a50f50ed5b36aee4543e342d5c78b.1587931627.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587931627.git.akuster808@gmail.com>
References: <cover.1587931627.git.akuster808@gmail.com>

From: Peter Kjellerstedt <pkj@axis.com>

This matches the other bb.command.Command* events and without it,
running `bitbake --revisions-changed` will hang indefinitely if there
are changed revisions.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 40520d229c8ea51ee9784184ab5d13a82dd1eb61)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/ui/knotty.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index c6abb2a1..5402f7c9 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -591,6 +591,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if isinstance(event, bb.command.CommandExit):
                 if not return_value:
                     return_value = event.exitcode
+                main.shutdown = 2
                 continue
             if isinstance(event, (bb.command.CommandCompleted, bb.cooker.CookerExit)):
                 main.shutdown = 2
-- 
2.17.1

