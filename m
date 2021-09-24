Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web10.8869.1632493350493583493
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Sep 2021 07:22:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=oGRx33Pn;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.178, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f178.google.com with SMTP id x191so3067356pgd.9
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Sep 2021 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aMXGIoCL1a7Etpc4iSI7MRV74JQnzZ0gnsfNQqMRhiA=;
        b=oGRx33PnRIG/+YPtFfliPPl15odEQqfuVGUa92hzqG01jvLeYlBWzW8Hnqa37Z5ahY
         OiPYX+KrSyGaByeLKknP2JyacJIEsMXhHKt6W48MnUf9SwECbMcksXBOTlHV1rMvZsiq
         64eLay38C5WsC9R7En3mB3j7WyAzxIG+BSWBtHeSERNtFUTdTcZICN1wLoxDVMajOHoS
         T9B3MNV6hHHscEyzwsEdg1OrbG79dVUf0TM+EoDysGEuI9rbm5OJVP5N9Mo+8iS+uk04
         LAi8TCzbfR1pKo/mtXFoTS+px3yOkQJa62P+uMfT8xY6Bh1qWn4eWIQ9Isrq9pTBpFCf
         /ZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMXGIoCL1a7Etpc4iSI7MRV74JQnzZ0gnsfNQqMRhiA=;
        b=iWgp3xLT20+SRnIN74WlG5YCRuXEoAzWoom4hW5bkBw4ypT029mMlnkZ8Jtc3Av6CU
         C9zlBDy6TuPuvuIBtuCNwvt2JokGM47IW2PsIzvdSMgqY4fYPEpD7lQojsr+BELjDpi6
         9FEadnyq/Bt+PuAU4rle3CzakFoyU7c9FNcTMtMwwlvZv6l9KlpXSrpwX9amBRhD9WRz
         W6JcLBsChVEtk8684SpvdR8cXlXz3bFUlCqxNabXNijeyxLe9u2z6zK+pquxeCYw0mfu
         DvLEDw+IG9y63D8H1lVcNlIR/o0k0E/X43RCWqJDyeElzNRJT35dur5q4tbiBkmKOjGJ
         5T6g==
X-Gm-Message-State: AOAM533bpMGYyX6uXvYKmphNtn/wdlQQ7Cxy7NKac0IJvG61/hInkLpP
	WG1chqn4t2N9ETepyI2lQH78py9xYgVpgfLwwhw=
X-Google-Smtp-Source: ABdhPJxMLhbMKFLHJkyl/JOITuGgEW2OoJBZS+c6OAQ/22UeVJmwJAgYfAjZrdwIZK758eMZZQWmJQ==
X-Received: by 2002:a65:508a:: with SMTP id r10mr4002950pgp.96.1632493349524;
        Fri, 24 Sep 2021 07:22:29 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id j20sm9907347pgb.2.2021.09.24.07.22.28
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:22:29 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 07/14] process: Don't include logs in error message if piping them
Date: Fri, 24 Sep 2021 04:21:00 -1000
Message-Id: <62f4d74479d410fe510eeee33f9d202f7e63066b.1632493110.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1632493110.git.steve@sakoman.com>
References: <cover.1632493110.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If the caller is piping the logs, they likely don't want them in the error exception
as well. This removes duplicate output from the build output allowing the UI level
controls on whether to show logs to work correctly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit fc58ad84a9deb2620ad90611684dad65dafedb11)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/process.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/process.py b/lib/bb/process.py
index 2dc472a8..24c588e5 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -179,5 +179,8 @@ def run(cmd, input=None, log=None, extrafiles=None, **options):
             stderr = stderr.decode("utf-8")
 
     if pipe.returncode != 0:
+        if log:
+            # Don't duplicate the output in the exception if logging it
+            raise ExecutionError(cmd, pipe.returncode, None, None)
         raise ExecutionError(cmd, pipe.returncode, stdout, stderr)
     return stdout, stderr
-- 
2.25.1

