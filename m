Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1FEC433EF
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 12:40:09 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.26574.1654864801553385937
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Jun 2022 05:40:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=exSc1rrs;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id m24so1522660wrb.10
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Jun 2022 05:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X932iQGFgRgkAbzYim7Gl15bTcQpp9F4FVp2FissLA0=;
        b=exSc1rrsK77SjGATM3Wtipt/gcQnPpFHoCwMNjEEeuLhtCynLKoX3aD+G46u16tfY6
         Rxi/dggOPOGBeqyO9dNXrGrg1xRFQ5A4y00j8jcOlreik3dKEjOCHbTUxfuWs/TqqquF
         f0vCBZ2NAV9QT+iXPuSYpLEQg/3GgfXRKCnRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X932iQGFgRgkAbzYim7Gl15bTcQpp9F4FVp2FissLA0=;
        b=NoSQnLeiePHVJvKBlN6HKgBEiDYyVQJX1MHNT+qdw57NyoZ2loZx78ZhT9+R/i+iS3
         OupLKELryKisTH3E8FT4X+WSEJGFxciM2fnRS2zcDqV1ICODk+fCSXqNXCCSY7RRWDIV
         DQE3dK9VGFs4Kd95nOHutzDDlnHqv/k7mW854TQBbBar0Ywlh39vlh5r3rp6+JzfcCBu
         kMUbeXt7oBxJGaIVzYOk4puXqpkl2w7EJNuoWWjN75Juon08eKB2xsFu2P5g2zYKm1+Y
         Nm6zEb1f5OL+HduwdAB4BeqRPEx3ZsDY5YakKygq5IQGfm6oDLPiW5oEsJBZZI85yxzA
         T+bw==
X-Gm-Message-State: AOAM532hcre/HADaab83P//LiEW5i6NSEcEEFf8ka6Zfxh4kjXe+OBUy
	XFmoDoRs6TRktEjmqrhw9zpOs87fE+mu+w==
X-Google-Smtp-Source: 
 ABdhPJxdO4Prkh/5WDBZAPHSU6IpOBpSj7leejEWd1OCsdJs74B//Azh/TMSE4PPyLaxmlXMPsDbcw==
X-Received: by 2002:a5d:5047:0:b0:216:d756:83c6 with SMTP id
 h7-20020a5d5047000000b00216d75683c6mr31937023wrt.286.1654864799487;
        Fri, 10 Jun 2022 05:39:59 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a80c:d45b:2638:f3f9])
        by smtp.gmail.com with ESMTPSA id
 h18-20020a05600c351200b0039c50d2d28csm2905943wmq.44.2022.06.10.05.39.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 05:39:59 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/process: Avoid tracebacks at exit
Date: Fri, 10 Jun 2022 13:39:58 +0100
Message-Id: <20220610123958.78210-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jun 2022 12:40:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13751

In theory this should have been worked around but is still occurring. Add
it to the list of things to ignore when bitbake is shutting down.

Traceback (most recent call last):
  File "/usr/lib64/python3.9/threading.py", line 973, in _bootstrap_inner
    self.run()
  File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb/server/process.py", line 698, in startCallbackHandler
    event = self.reader.get()
  File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb/server/process.py", line 722, in get
    res = self.reader.recv_bytes()
  File "/usr/lib64/python3.9/multiprocessing/connection.py", line 221, in recv_bytes
    buf = self._recv_bytes(maxlength)
  File "/usr/lib64/python3.9/multiprocessing/connection.py", line 426, in _recv_bytes
    return self._recv(size)
  File "/usr/lib64/python3.9/multiprocessing/connection.py", line 384, in _recv
    chunk = read(handle, remaining)
TypeError: an integer is required (got type NoneType)'

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 02bef3506f..43790b6631 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -697,7 +697,7 @@ class BBUIEventQueue:
                 if ready:
                     event = self.reader.get()
                     self.queue_event(event)
-            except (EOFError, OSError):
+            except (EOFError, OSError, TypeError):
                 # Easiest way to exit is to close the file descriptor to cause an exit
                 break
 
-- 
2.34.1


