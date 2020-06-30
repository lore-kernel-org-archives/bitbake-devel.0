Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
 by mx.groups.io with SMTP id smtpd.web11.7698.1593486548900220275
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2020 20:09:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=CNeDDtkk;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.194, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f194.google.com with SMTP id e9so9245047pgo.9
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2020 20:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=D9a00/byotyLYqjb0D+SLgw19ZAfPIpit5Oln8/IZGE=;
        b=CNeDDtkkp/PvruqFgU1XYsUgnUAHKv0TrxX06qCdDXQ3r68pKrNhNPPn1P3QE2pQ/X
         g3aFH0hL2ROKj/zqB8z4HudRD8IovibJS1f79N/YDfLTZsTNv1Mo6zjXZf26TOYX8G0i
         DWNWQsa3yiNwn2Za3LccI4aW84dxeqM3MGezBe9wHVPPT2X+O5xdVq9l/5cXGMj4T3g+
         P/uf+peD79my28EYUu9LcfNKk3SsLdyRoYjJQR2RMVz+uG7NGBvrDN7LL+mqDQHBewxQ
         4Pt0YZQ9o4ESA1Efj5cBZTjQTITdqTs7GBZyE6SoHs/8rIWwWYQa0SpUhMsBoxlUGNTk
         0dmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=D9a00/byotyLYqjb0D+SLgw19ZAfPIpit5Oln8/IZGE=;
        b=EBUybadMpuudaVaAOGShZGb+HzazByEmBmilLEP3M6kDxx6WeArGCU37LpeO+d+Gwl
         PxKNEF5+xYV3tTQuS+y/ID6KmRyjzfWl3uG+NnnAIuFVCemS/CLguzXEGNXpJykcW+8I
         yWTzsJe4YSGOf3mpapC+73VQIQR7Ap9CUXpzLNqKcLa1KSp+qp0AARb0nyJrmQ2Zs6kH
         nn+hdhfFW16e5/hhw4K4XQ+I3M/K37NiJf74NCd7P7CL+3yUBjo6vxc8OIvSgQRBEnXk
         VZ2Rbp3wnLJDygY39QJt+juYwRpeWAQuR+yf8SIOSrR41zMrFctKlk+qfR69u3d5GpBf
         LIrg==
X-Gm-Message-State: AOAM533tyAC6NkC9q1gNu2ZIgKa3B5z6R+V0tU2/itvt2FQJE//wq7d8
	vAhT2Nu2WTRqbnVCogNl+U7axCNs5knzAg==
X-Google-Smtp-Source: ABdhPJzJlZCaxyGU8LeRWWr/5xGZdU4CbGqkdVoFn+XV3FtPiFh+VsneLZWh35EpWTevz12CLXWU/g==
X-Received: by 2002:a63:7f5d:: with SMTP id p29mr12953850pgn.259.1593486548014;
        Mon, 29 Jun 2020 20:09:08 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com ([99.197.43.113])
        by smtp.gmail.com with ESMTPSA id n14sm970933pgd.78.2020.06.29.20.09.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 20:09:07 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 4/6] siggen: Fix error when hash equivalence has an exception
Date: Mon, 29 Jun 2020 17:08:24 -1000
Message-Id: <54e601ee9ebb5568a17e83fc5ddd2e89d323f805.1593486375.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593486375.git.steve@sakoman.com>
References: <cover.1593486375.git.steve@sakoman.com>

From: Joshua Watt <JPEWhacker@gmail.com>

The code that handled exceptions from the hash equivalence client was
raising an exception itself because hashserv.client wasn't imported

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a76290dfc6f34ff9f6efdb13a6db74b6b4759daf)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/siggen.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 4c8d81c5..94d1762d 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -14,6 +14,7 @@ import simplediff
 from bb.checksum import FileChecksumCache
 from bb import runqueue
 import hashserv
+import hashserv.client
 
 logger = logging.getLogger('BitBake.SigGen')
 hashequiv_logger = logging.getLogger('BitBake.SigGen.HashEquiv')
-- 
2.17.1

