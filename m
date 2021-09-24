Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.8867.1632493344133591977
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Sep 2021 07:22:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=St4+oc8T;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.176, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f176.google.com with SMTP id 5so6588062plo.5
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Sep 2021 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/pYDIoBsYNZJ1S8SFYi46geAacnuDzE+ToULHNFpjLs=;
        b=St4+oc8TZDn/pIPvawEdV/shNSBaSaNwjY/q3IdR7AFzNbR1AVth33EVh3T+ktZLHR
         jQINJahxt2YuoezJZ+eO95mcGN3IBq2l1Q2PCfcc261oEI5cpcoIi9KaNQg23f9hNetY
         RueJRMGXLW/0eP9hloKNeW2qhRebAitVRfr3EfbJmBF0xw2zPXJoJERikXrEJkCBwGdC
         4Zg11pjs6sBAlUiQrIhXKGANrsE87q+a7cjeHZ0qacbCQI98+eijrbPCLtBqxJ+HZolW
         nw5ZbKWRTSz+yM9A11t7ybMQre9ktnt6iccT2dqokWvoB2DgKdlYwmJ2IBfcRQDRApiz
         Ze8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/pYDIoBsYNZJ1S8SFYi46geAacnuDzE+ToULHNFpjLs=;
        b=ikwC/UQ28KbGmOGTHLtTRhOZ6J0zhlkS/0GtHrfVNOy/XYWKNQkVf8RJlzGEEcNt7P
         vK9QkJ3/OShrdzQX1X8RuIp5XGZACz09Je8d/QN9cTP7HjQbDxC9DnLFee5jp9dy4gjT
         0p93j0qAmkTNpq3Fp5nH11IyMNKvQqratCZl2uNWg7SjhCYlIWGhSKElJDdAueZHN//0
         Flm0y5c+FTd+gbt+UVgePSXhaPbIZUrZk2AhYMOLK1+jXLWFSZ7euP2xOt8geQWyRsxX
         n0DglT17+qv/43j4abmi5KM19nFdthu/xPE7N8LVXuJhH7+F/MjcAmZoTl6K0GBbFeaB
         18Lg==
X-Gm-Message-State: AOAM533FiSiG47Wsrrm2K0cDlH38C5lMdflTu6/mZUjjAb5jDUoP0hLA
	22+rqcZibElnmlRAoAd+aip1G6z/Ooy8NV/Tw+8=
X-Google-Smtp-Source: ABdhPJxYIS+pUj7cbTejGR7/dPG899rhUg0kn3ZPP8qkA7JTqjM49jIq4JeYC96Fr85jmt9mJDIW3Q==
X-Received: by 2002:a17:903:32cd:b0:13d:9b0e:7897 with SMTP id i13-20020a17090332cd00b0013d9b0e7897mr9129893plr.30.1632493343224;
        Fri, 24 Sep 2021 07:22:23 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id j20sm9907347pgb.2.2021.09.24.07.22.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:22:22 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 04/14] bitbake: bitbake-layers: add skip reason to output
Date: Fri, 24 Sep 2021 04:20:57 -1000
Message-Id: <b92bfd91a9202d05db623b99bbc2820c04f82685.1632493110.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1632493110.git.steve@sakoman.com>
References: <cover.1632493110.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Felsch <m.felsch@pengutronix.de>

Currently we inform the user that some package/layer is skipped but we
don't print the reason albeit bitbake knows the reason. So currently it
looks like:

gtk+:
  meta-oe              2.24.32 (skipped)

With this change the output prints the skip reason which is very helpful
for debugging:

gtk+:
  meta-oe              2.24.32 (skipped: one of 'x11 directfb' needs to be in DISTRO_FEATURES)

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit d43e72db4f7c8b47d91d99ed54ce30e9ee898de1)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bblayers/query.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index e2cc3105..fb6f550e 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -150,7 +150,7 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
         def print_item(f, pn, ver, layer, ispref):
             if not selected_layer or layer == selected_layer:
                 if not bare and f in skiplist:
-                    skipped = ' (skipped)'
+                    skipped = ' (skipped: %s)' % self.tinfoil.cooker.skiplist[f].skipreason
                 else:
                     skipped = ''
                 if show_filenames:
-- 
2.25.1

