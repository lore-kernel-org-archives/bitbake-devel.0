Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
 by mx.groups.io with SMTP id smtpd.web12.43080.1593976889762393401
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 05 Jul 2020 12:21:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=tNLWsiUg;
 spf=pass (domain: gmail.com, ip: 209.85.160.194, mailfrom: mostthingsweb@gmail.com)
Received: by mail-qt1-f194.google.com with SMTP id 6so2196606qtt.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 05 Jul 2020 12:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9VoYIgNJOvThNVnIs2u4G0kNbBfATxaydYzzGf7XFB4=;
        b=tNLWsiUgfTJ5UvvXfpLFvtRRb4R2C4DX6JwsF01r6LsrNDoQ0pckM3gkI2rJFBvLvK
         gjroScPCy7n2V+bK8zlOFq7V6NUWndLjOEfFIi3zy2s3F1dEC7Xkj+dhbLgn4/X8utzM
         Le6hpZHX21NZcHfi5h8rFWRL5YRQgTllEedmJWvHkWBvLXxJUiMmWqCR1fX1rnolXf17
         +/mEjOIq6eXBb9GcpfJNegiKY0zKwxc9BpAvF4O5IYKa46oJy1MeADbbW5Bu42850qqQ
         TXFGxRr0GyKQELjxFO7M7rB22Uii66tr7ahn7c0nRKZaYU7g3zITgBByeWs2deUpj9Ff
         Mmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9VoYIgNJOvThNVnIs2u4G0kNbBfATxaydYzzGf7XFB4=;
        b=d9QVe1Mfp1XL03X86hLE7iqU/BtfPnHzyFxGiIoApBOveJrB2eUotp7687X/EmJHep
         o4b+AiD0PeCL4MdRWhyTdH9fiBNhowwZ1aFJi2VmV/tDIs8BsuU8gBS/+NWQIH3TEgPS
         k1TafXo82I6cVYBdM+QEm0fRuXSxQKbjIPULiOAZlhK+n3P0XImutYBaMIXzmAk2f3fM
         tnWzhyxgM7u73pC0ICuuMtN8JQAX3cQOadi9RIlQDzpn9bsEsdclUXw3ik6m0NlqQuQX
         iwVGMugMA0OrhBDIdBK0k78unNUGdnB8+f5DktYYgg5o+hm3KbH1YL8aMR0gEHbEK89E
         g1yw==
X-Gm-Message-State: AOAM533A6gLwkniqIFsOm7b0Nv4hvI10D3nPxj71DWmQt7hH0zcrg65L
	/wHg/fKdE8EQjAXlWtK6utwzcMve7GN4dg==
X-Google-Smtp-Source: ABdhPJwJPPrm6qyql0/kRLmot1YNRB5g/xzzgI/sDYJz7HFAk84osNsMh1hC88rz97HGip47W4O9eQ==
X-Received: by 2002:ac8:d86:: with SMTP id s6mr17249906qti.343.1593976888470;
        Sun, 05 Jul 2020 12:21:28 -0700 (PDT)
Return-Path: <mostthingsweb@gmail.com>
Received: from localhost.localdomain (84.185.2.69.cable.dhcp.goeaston.net. [69.2.185.84])
        by smtp.gmail.com with ESMTPSA id 185sm15568877qkm.111.2020.07.05.12.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 12:21:27 -0700 (PDT)
From: "Chris Laplante" <mostthingsweb@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Chris Laplante <mostthingsweb@gmail.com>
Subject: [PATCH] ui/teamcity: don't use removed logging classes
Date: Sun,  5 Jul 2020 15:21:18 -0400
Message-Id: <20200705192118.7372-1-mostthingsweb@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows the TeamCity frontend to be used again.

Signed-off-by: Chris Laplante <mostthingsweb@gmail.com>
---
This is an immediate term fix to at least let the frontend work again. I
will be adding a test suite and doing other improvements in the near
future.

 lib/bb/ui/teamcity.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bb/ui/teamcity.py b/lib/bb/ui/teamcity.py
index 1854292f..fca46c28 100644
--- a/lib/bb/ui/teamcity.py
+++ b/lib/bb/ui/teamcity.py
@@ -167,8 +167,6 @@ def main(server, eventHandler, params):
         forcelevel = bb.msg.BBLogFormatter.ERROR
     else:
         forcelevel = bb.msg.BBLogFormatter.WARNING
-    bb.msg.addDefaultlogFilter(console, bb.msg.BBLogFilterStdOut, forcelevel)
-    bb.msg.addDefaultlogFilter(errconsole, bb.msg.BBLogFilterStdErr)
     console.setFormatter(format)
     errconsole.setFormatter(format)
     if not bb.msg.has_console_handler(logger):
--
2.27.0

