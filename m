Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web08.9019.1632493352827191731
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Sep 2021 07:22:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=zGMJh9MU;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.181, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f181.google.com with SMTP id c1so8970403pfp.10
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Sep 2021 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Tqs8y0YW+6zwKTnzao0ueriKFrqCuBmO1o2zN2luV3g=;
        b=zGMJh9MU9+w6619Du5o7Ro40Z1pbVCyR3+xc7YUkiplA2UiMlfbWqbvGMXzbPc38/f
         kdOL9I3UdJcRsMsF3+XJkAwR5ovMH6iBeKy5P8+QM6aa/buT64COrT6jKJxiOnFx3r52
         i3hHO47Z6+Dak1sVkqliB/r9UWZ+I4S2dP1+tpotrf0OqCzpBIB1ToZyESbTJ3BpPDhd
         EryR+EA9fBTTtg21hbTiSN1Y+X2Rce34sWw12r09Zc43ExuXdQzTzVreQZo4XLajC3OL
         zvLw8sYxYftbuNw/XsZewZvyBAXVq6mkpQAanjSxfmpmXXdfYIQe2zFosFs1tMnShPhx
         s89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tqs8y0YW+6zwKTnzao0ueriKFrqCuBmO1o2zN2luV3g=;
        b=ptg0S6tSyrr0OAGfVaPEYgIJ+6692cfTkpFMOjx0bB/pBBIRDHXLBsAfVJ5P+SVsLX
         n5BwZBx/29Z2EZYVbVIS+YHb8g2z7g/iXWm7J0T6/xsXrqTXwkWmE4p8IgTxnLTfGbVv
         HwIZBswVWZHjHPgO20+Vj1/0+yCW3rGewjKSKyWwRUI1lSsYcLal+kpePh1SUp72wfyZ
         RMtSl1kB0aef4/haPNOFpnC7CAOVPr77yOGyeRYcWJsM+xqqJQLoK5nBHa0ejjfPDak6
         bF6LHFAadLEPcZHmmrt0aGYG1ke6k3RGB2fojvi03Ia51THQxagFkRjt/i+CdDEx65XY
         OLSA==
X-Gm-Message-State: AOAM5323BFelt5G37tDhzJ2eeOWtvmYK4qZiPfR9QBiJkv0oB/2redMU
	VJlOIGbW2RIvxN4QVgxKa6kXf+s7dnKx9v4jEdk=
X-Google-Smtp-Source: ABdhPJzvZ5EvpbBdu3xhYrkKeU4/JGOH5xjTbdSSp/ytEZssAK22NNKLfIN4fvTsVcwWoPeIaz+7IQ==
X-Received: by 2002:a65:5845:: with SMTP id s5mr3916788pgr.227.1632493351738;
        Fri, 24 Sep 2021 07:22:31 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id j20sm9907347pgb.2.2021.09.24.07.22.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:22:31 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 08/14] build: Avoid duplicating logs in verbose mode
Date: Fri, 24 Sep 2021 04:21:01 -1000
Message-Id: <e75169f7ef89cca94cefe9f0099a5b427b380a6d.1632493110.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1632493110.git.steve@sakoman.com>
References: <cover.1632493110.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

With "bitbake -v", for task failures you'd see the log output twice. Avoid
this by using the existing "did we print info" switch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit e2c1afda4cb8023ed4ffeb5dc5bee4f0055659a8)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/build.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 04971636..6e9c064e 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -592,6 +592,10 @@ def _exec_task(fn, task, d, quieterr):
                 event.fire(TaskFailedSilent(task, fn, logfn, localdata), localdata)
             else:
                 errprinted = errchk.triggered
+                # If the output is already on stdout, we've printed the information in the
+                # logs once already so don't duplicate
+                if verboseStdoutLogging:
+                    errprinted = True
                 logger.error(str(exc))
                 event.fire(TaskFailed(task, fn, logfn, localdata, errprinted), localdata)
             return 1
-- 
2.25.1

