Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.338.1597264986999522692
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Aug 2020 13:43:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iaTU+m5y;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f66.google.com with SMTP id r4so3260485wrx.9
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Aug 2020 13:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zur6Z0n5+3I3ix2/i10dUhIWZ9fEdTjD1ni3UZB0igI=;
        b=iaTU+m5yjVtRg/SrPQLLGRGzhi2LWbiJH1Gs9m5xhpS58ZhqhfryzAjnfxeTF5XEdR
         JGhw6qZSZ/RfYFj7sztMbISzNSY4bILlVhac2fX+n+XeVUto1Sf8BDJExo/K2BhgXfJo
         GiyQweyE7Ik7Nxy9AX/q7+iLozBXsJppAxkbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zur6Z0n5+3I3ix2/i10dUhIWZ9fEdTjD1ni3UZB0igI=;
        b=ZyjRxqvEnZoBLtjL1RhtFEtmMBz59nhwd33iD0sM5QFz8bDaLX4g8YZeA/94YX4QMC
         Exi61UBAKaNBscslCAOkyFjD8mCK3xVkSImWlv8TwsNuwORsBVQI7HvcK8TdF+eNPqeW
         4J84BV+r1rAnanb1I7lolhCBgVQ7y/0DtG2UB9iDOmP0V7pSp3terz7i8OIJTh4DRCZ1
         +oWfQ32P29mVvFdWJxMBxLfjoF/KMqKe2CR51MS5yS2hWvrHQx/F5y6r6sVcC+ZBjsJ4
         QF3pmtzkBhtQE1JPyEMc70rNlOvcdAcyVjPcC4STUTbu8/IOmI24Ms+5V+jUiZ8CmYOS
         qCjA==
X-Gm-Message-State: AOAM530V/9Xcad2rxS1jFuvPuZhaU12R9kt3Wdch74/Q+PC5zTVeWM/M
	coqiT2W/x6BL9+yOusZ34KpfAwoDPKkY1w==
X-Google-Smtp-Source: ABdhPJzwHhkmFUMTSLouJp0pOESzmv7R4dAojjxiZKyf4NeGkefOWr41TB0PS8CVpIo9OovM5DwfMg==
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr782550wrx.33.1597264985176;
        Wed, 12 Aug 2020 13:43:05 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (9.a.c.c.d.f.6.e.e.7.9.e.9.0.c.e.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:ec09:e97e:e6fd:cca9])
        by smtp.gmail.com with ESMTPSA id p25sm5408479wma.39.2020.08.12.13.43.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 13:43:04 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] server/process: Remove pointless process forking
Date: Wed, 12 Aug 2020 21:43:02 +0100
Message-Id: <20200812204304.931893-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already call bb.daemonize.createDaemon() in BitBakeServer so the extra
multiprocessing.Process() appears to be totally unneeded and just an extra layer
of forking which confuses things. Remove it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index b66fbe0acd..a152b44824 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -34,12 +34,11 @@ logger = logging.getLogger('BitBake')
 class ProcessTimeout(SystemExit):
     pass
 
-class ProcessServer(multiprocessing.Process):
+class ProcessServer():
     profile_filename = "profile.log"
     profile_processed_filename = "profile.log.processed"
 
     def __init__(self, lock, sock, sockname):
-        multiprocessing.Process.__init__(self)
         self.command_channel = False
         self.command_channel_reply = False
         self.quit = False
@@ -483,7 +482,7 @@ class BitBakeServer(object):
         print("Started bitbake server pid %d" % os.getpid())
         sys.stdout.flush()
 
-        server.start()
+        server.run()
 
 def connectProcessServer(sockname, featureset):
     # Connect to socket
-- 
2.25.1

