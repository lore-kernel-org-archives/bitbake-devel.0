Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66230EEAA56
	for <webhook@archiver.kernel.org>; Thu, 14 Sep 2023 16:28:21 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.297.1694708890843244024
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Sep 2023 09:28:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YoyxAjSn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so1068876f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 Sep 2023 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694708889; x=1695313689; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6eI7ZOChYwrw0kKMO/jl29CZ11OnDvDijPjuAeueK9w=;
        b=YoyxAjSnCRUr7oMhEV/oo1G6gN3dhadRwrD1CQIw0JML8Z09ptqvM55Tuep6+N6ABF
         maIPUoRnAXsgbnrplsVi3LgA3mf6Dwq7G1xu1zkWG7oZBUK+GnMR1DWCSIo5j4MQk25N
         bDr0z4DNh9m0d6B5lgwjAk8tr5SrtEdi3CHZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694708889; x=1695313689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eI7ZOChYwrw0kKMO/jl29CZ11OnDvDijPjuAeueK9w=;
        b=ZGmIVMbgQVUEBPImNxpEsZIDS4pI+gJ8lTWFHETXN8I9EMunPb+X5gQRB17jsxjTN0
         sBIoe7s5UCvjLT879NEpz2gkG7t1K2kLqiVDDC3l/VaV0oIGXbEaujvwteZy5r+V1TMq
         1KNPYfK/KvUilLSocWeVdzWCaBKgKwtAFR67oILOWLh3hqFa9Cwp+ysvPp1004kjWW18
         G+OSOOoHkcoNndDF/iQc6enY1MG/1m0ICPnehiOfRaUYEct0nrZ7cUxtKQY05bN9m+/I
         jhTfCl43a5WgYrPWAXRWWvFmDnIZ85FCttUoOQMNMaQqQq1rHMaJYZ7Z/Y1lP5mv8mQ7
         fy0A==
X-Gm-Message-State: AOJu0YwPMwBoyL1jlYAXrWj03Z3kMitF6rggIwsElp2+fDrh0njXdxLP
	jlFAnFknAftyrAt+AAxu77WNSeNHD4ayKl1Km6s=
X-Google-Smtp-Source: AGHT+IFLPnv/f4yHlngxrR3Us2KCDrP7JBf29+jawrOSN2NzvA4cb/LoFbmD36J5DWfR8PbMHGmx5Q==
X-Received: by 2002:adf:e611:0:b0:317:e68d:f862 with SMTP id p17-20020adfe611000000b00317e68df862mr4917569wrm.37.1694708888824;
        Thu, 14 Sep 2023 09:28:08 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a6e7:41e3:896b:6b97])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d4d91000000b0031c855d52efsm2153427wru.87.2023.09.14.09.28.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 09:28:08 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/process: Disable the flush() call in server logging
Date: Thu, 14 Sep 2023 17:28:07 +0100
Message-Id: <20230914162807.198231-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Sep 2023 16:28:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15063

We've been chasing bitbake timeouts for a while and it was unclear where things
were blocking on IO. It appears the flush() call in server logging can cause
pauses up to minutes long on systems with slow (spinning) disks that are heavily
loaded with IO.

Since the flush() was added to aid debugging of other timing issues, we shouldn't
need it now and it can be disabled. Leave a comment as a reminder of the pain this
can cause.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 40cb99bc97..94e93bc3a6 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -43,7 +43,8 @@ def currenttime():
 
 def serverlog(msg):
     print(str(os.getpid()) + " " +  currenttime() + " " + msg)
-    sys.stdout.flush()
+    #Seems a flush here triggers filesytem sync like behaviour and long hangs in the server
+    #sys.stdout.flush()
 
 #
 # When we have lockfile issues, try and find infomation about which process is
-- 
2.39.2


