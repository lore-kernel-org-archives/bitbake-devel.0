Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.8013.1628167056978318339
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Aug 2021 05:37:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dNFiVjM8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id j2so6311138wrx.9
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Aug 2021 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sCpD6xErnCanxjer7PfqCip4yljOpSIT89H0ePsdnME=;
        b=dNFiVjM8wifcQj+ZRCeg9Wy7y0tNPBYrdiGLeGudofZh65VzABDYOSbrlLQzVt7ECi
         Impo4ObuEalqSN2fCLhcx68AXOh4R1yBp4L1lPCL5ftwJp8fX4jhgLq300LIhgPtqyQe
         l6r5YRbUpfdx6mEUVoJpoEE0lCGn17KdiyhoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sCpD6xErnCanxjer7PfqCip4yljOpSIT89H0ePsdnME=;
        b=a5ZvIYVcGM2KlsBayB5zqesy46hmPnVmcgdRa1QPeW3njTnfnCLPpSOtD3Nsvvb7tr
         WE6BV8gyLQzMyWgczDk9MG6tK6JXx9mRf5mY+ZBRLrbbBeN1qVrSxxoFKkku9U9FfuQI
         OR4ayunjwuFDMTeN539z0XAC13a/2uEiF2qUjfawYM2Lydvnv5mvRA/dIWi5U3eKJTA8
         riWTyo/V7MMWoRNk6Emcn2+o6V8lHESDOe7Uz/QHaTKhDvqsDFhed85oLNFaHFdBRXwx
         VtXo2ZgyfmThPeAPha8MMInKBOq9OtMsd5lwYKS77W8AtL1LyU4p+hst4UMpdfZYObXH
         4zHQ==
X-Gm-Message-State: AOAM533Gz6ybmyU9RlbFjBvNSt7fcp84qOv0IrHVuCIAv2kfJ+KQ4dut
	zPP9nMY9UH0fBjcG83Z6wQaWJMt9kz+wkA==
X-Google-Smtp-Source: ABdhPJzeJUQqUNZQPJPRDa+9zCLmcsPhPKw8Gz0V5Avw1IXlpt60uo9Qlgdvh6aTF9AcGU2hmDUP+A==
X-Received: by 2002:adf:f847:: with SMTP id d7mr5156502wrq.352.1628167055558;
        Thu, 05 Aug 2021 05:37:35 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:ea47:91d3:ba71:9eb4])
        by smtp.gmail.com with ESMTPSA id a24sm2106291wmj.42.2021.08.05.05.37.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 05:37:35 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/4] ui/taskexp: Improve startup exception handling
Date: Thu,  5 Aug 2021 13:37:32 +0100
Message-Id: <20210805123733.3572421-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210805123733.3572421-1-richard.purdie@linuxfoundation.org>
References: <20210805123733.3572421-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an exception occurs at startup, show it to the user.

[YOCTO #14408]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/taskexp.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
index 2b246710ca..81392977a0 100644
--- a/lib/bb/ui/taskexp.py
+++ b/lib/bb/ui/taskexp.py
@@ -8,6 +8,7 @@
 #
 
 import sys
+import traceback
 
 try:
     import gi
@@ -218,6 +219,9 @@ def main(server, eventHandler, params):
     except client.Fault as x:
         print("XMLRPC Fault getting commandline:\n %s" % x)
         return
+    except Exception as e:
+        print("Exception in startup:\n %s" % traceback.format_exc())
+        return
 
     if gtkthread.quit.isSet():
         return
-- 
2.30.2

