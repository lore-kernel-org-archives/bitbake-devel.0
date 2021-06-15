Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web10.1736.1623794475013835829
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Jun 2021 15:01:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=FLm9kBWy;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.172, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f172.google.com with SMTP id w31so229100pga.6
        for <bitbake-devel@lists.openembedded.org>; Tue, 15 Jun 2021 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BZq3DpB6KknSq37PE/4rrFaCyFrpNOttbWjz57mr/yI=;
        b=FLm9kBWykw1ixC0UHqsuc0Tbr9heSpRb1Wbie1NYZXytF9v8b/3ONJShwpTTSaXJWJ
         xIl5zdeb2J07mJbQzO/wcF3DiPbc3YMGQCfy+gybShkRzAcx6X0Ivp/05kwmcv3bMx5G
         D0PeZ9Y/cCRwDJPvLY1YdeGxGUpd9xbpSZoSAICmHt4NG/VsEaqmCP/UnnNQ/n9hWdDd
         R4PNRwQbOOxDhvkulGmP2wm+snzhuHcxyyIxnUb9zQ9CzJht85pAGDxlUgVzawdzF/gi
         WaS1aW4YFiGAjgoTHzOXlDtnFuhJRfnAZdGxRWrj+/aHSvzvEeOxmqcGuVDwpB0nuZTi
         1AhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BZq3DpB6KknSq37PE/4rrFaCyFrpNOttbWjz57mr/yI=;
        b=gzF3hyDQCQQ2RjlF/+wojV30cqBlbGYC5voApstoqs+39hsM5bUU14FySjXgWvDyHX
         M9OqQVqwJ5d0DaZ0E+1hC+UVNOkXyx8kGBzjfyjYW9vUXHpuwshBM5LykcHGUzFMp502
         SmstqDavtXh5gDON9qEaJVGgTg3mBt9gQ5x6gxpeKyEnfQ9mnzNneAu7fuP6hcmHkpUZ
         +LeMhUSXs/eHUcST8KhjhBD8ZS/ILov/V+46tzRz1MUi56q4XSqTxMCtgXpZN0UzxXi9
         pIBdmsc2RvsUzV+I+taI17XFEhi5BxxgvCm79h6esQ1B44MCxXoA16B+Q/iKa350hLqL
         SU4Q==
X-Gm-Message-State: AOAM530v9L0XdNKr9tfZEP31x50VcL5NOx9zFbTeWL5OudYGKslSGOdZ
	ISnX29Ao4wNzqzF8wxqjiK7j/Q353QhJXpLPCbs=
X-Google-Smtp-Source: ABdhPJy1Dq2Ig4xIVPT0sbiKRFR//LL1XvxKPRDT99Qqz3qosx8J8lhjwBfl+2DPTeT4XWG7HvBXtw==
X-Received: by 2002:a63:1347:: with SMTP id 7mr1587127pgt.245.1623794473922;
        Tue, 15 Jun 2021 15:01:13 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain ([172.243.4.16])
        by smtp.gmail.com with ESMTPSA id ls13sm115049pjb.23.2021.06.15.15.01.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:01:13 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 3/4] cooker: Ensure parser is cleaned up
Date: Tue, 15 Jun 2021 12:00:32 -1000
Message-Id: <6f2b90304a84714c05cf3a0036902e6f3cebbe29.1623793815.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1623793815.git.steve@sakoman.com>
References: <cover.1623793815.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

During cooker shutdown, its possible the parser isn't cleaned up. Fix
this (which may partially explain why threads were left hanging around
at exit).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/cooker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 87884574..4d2c62cd 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1636,6 +1636,7 @@ class BBCooker:
         return
 
     def post_serve(self):
+        self.shutdown(force=True)
         prserv.serv.auto_shutdown()
         if self.hashserv:
             self.hashserv.process.terminate()
-- 
2.25.1

