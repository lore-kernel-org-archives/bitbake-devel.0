Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1F7C54798
	for <webhook@archiver.kernel.org>; Thu, 29 Feb 2024 21:57:30 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web10.7931.1709243841682281637
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Feb 2024 13:57:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20230601.gappssmtp.com header.s=20230601 header.b=12s3Ev03;
 spf=pass (domain: smile.fr, ip: 209.85.208.173, mailfrom: yoann.congal@smile.fr)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d28387db09so16189801fa.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Feb 2024 13:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1709243839; x=1709848639; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gdKUmz4HeFHfziiMVS36QCn9KKKnthduqvZwo/oHQKw=;
        b=12s3Ev03zIivvuvo/AbHxzeLPCn70wA4VtTlWkWyhXDgj9hgTte9SMIpuGyWjT7k6e
         HQ2yCLaSwhoF2+Ab8GHXKBA3gWcxyyVzp9Tsx24Mdp5N2upGKXEJpvNRImeEbnc2gVQP
         i0dxD++y3fPCjrq8HOEaU8P2TLT2pYmDGLI+bXkXQ9ePJ5/44NJtSr4/+WTcRwzAb/3w
         og6wutJm5nuCMsH/hnpzzER5bITa+zkJ1Rn3C/vDwbpQLlre9rOgyWljoVkb1SgzoxGZ
         ViTXfOcp2K/WoREozebiPvUQRU2J1B22zRcIAYVdjZeAQT0Sno9aJiJAIy5orhsdr9RQ
         IwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709243839; x=1709848639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdKUmz4HeFHfziiMVS36QCn9KKKnthduqvZwo/oHQKw=;
        b=IHPcZOhBcGuNHQAFgORXQfGhagh30xu2uXq3jq4J3Uhp3rd9Cn1yNr37Prgx7pj6hc
         izo7VXrViwT9iTEPOoOq0BcwUy7IN6enzsOJKqlCVOFE5V+NRKYrVM4VclRFiDO1yFEr
         9d5DlCZ+n+evabslUmSMR3mEd3PvzU2rxtNCq/g54RnlB6zpuhL3ALZ0IMmTreJ0oJjA
         ZtRx0Z1B4p+DQZYNflLhcD31Iy8Fiy+zxfsM8XWmruou+Jy2cpK2oTW3PmSMPQhhZ51A
         u4W7qfjUmITUhOkPDVBS7BQOR2yMGysQJ2h0RIn7LSYQXoGbJFW/jKMCce7Nu81xbDrh
         AqPA==
X-Gm-Message-State: AOJu0Yx0udyvEgZ275JrUW+XK/Og7o7NYXXIWZqPY+lICWJIRGn6iYHp
	ERcSsOf2dtZk2hxhMS/RKaIkSHCMzq978DaXqt3uMBnAw9CGHQM8m+WnqHaFqfKo+x9NZifzrmE
	zuX4=
X-Google-Smtp-Source: AGHT+IEi+44Li83aHvvpyvNt7c2DyNXPGKULZN/A2zPgree512J25ilAbVp4t+bBkuLkLr3Ye7KF+Q==
X-Received: by 2002:a2e:7309:0:b0:2d1:1ef3:3c84 with SMTP id o9-20020a2e7309000000b002d11ef33c84mr2249500ljc.28.1709243839125;
        Thu, 29 Feb 2024 13:57:19 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.local ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id fa24-20020a05600c519800b00412c3a5d4f3sm896128wmb.30.2024.02.29.13.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 13:57:18 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] prserv/serv: Fix a PID file removal race on prserv stop
Date: Thu, 29 Feb 2024 22:56:39 +0100
Message-Id: <20240229215638.516053-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Feb 2024 21:57:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15981

A race condition has happened where the exiting server removed the PID
file between the existence check and the removal, resulting in a
FileNotFoundError exception.

The fix is to ignore the FileNotFoundError exception, the existence
check is now redundant so remove it to simplify.

Fixes [YOCTO #14341]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/prserv/serv.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 62d3b5a0..5fc8863f 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -262,8 +262,11 @@ def stop_daemon(host, port):
             os.kill(pid, signal.SIGTERM)
             time.sleep(0.1)
 
-        if os.path.exists(pidfile):
+        try:
             os.remove(pidfile)
+        except FileNotFoundError:
+            # The PID file might have been removed by the exiting process
+            pass
 
     except OSError as e:
         err = str(e)
-- 
2.39.2


