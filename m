Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web12.8914.1632493360757554092
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Sep 2021 07:22:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=kWCSS0wQ;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.175, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f175.google.com with SMTP id n2so6550841plk.12
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Sep 2021 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=V6eR5LbHKMJztaSC30MacONbR/txm+Y2njjHIQfHLFw=;
        b=kWCSS0wQ85wWMz7pnMd6f9XUj5tuiPL1Zb0e342Jikdvq3v1TrK6hvB+oxtNSkakeN
         g8oRxKNLCmPN2iEiFzg5eZTz8Y0ZjUgEr5kWzD3gKbrpSWkFBNdPDt7p/afs3WSYBZ0c
         mdtJN4nk7ZHkQpcgz5vwOJKCrksoSUwbQWiZjePlOehvZYyEXRop8HD4xpMXErIUPQ96
         tgrZsnW/UnMMEacCBzrUUPgCsbWJ8iYSwcuVPhbM028bdeXNZA84h6JtDD5MIJ9/CQRh
         wraEvNT+V8nCBUyCM9+zERO2nmzDbHUHv3XoLk3wbnxhum/CVnK+ZNl52IjMlcfjJngs
         vT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6eR5LbHKMJztaSC30MacONbR/txm+Y2njjHIQfHLFw=;
        b=igK0JEsjLqsS98rbXEByyJPQ4iwuc82WUpIA8hGfg9TJnM9tJND/jq4uqxVc1Tn9aR
         Q5ovR65UQQH4FKNttkgvspWxkwgLbaREbvxEsSJxKXfkdW36w0YxVbHO0ChUMLY5X7fj
         bkvtkGQOQJo+S5bP7wBaqIPzKl5ZC+LejqZUMQEX4ohNv6mu9ekA2x7uOye0vjvJ1xIx
         TIw/R7x2wLkvDxPT/X3wDV1UEIGy9FVpK0hJZwDRUloaiDk+SKXot7JFObzcbpD0h0MR
         4L3Oo7jkUyimv3cIvsN6EJRccqZ1lmu6IZmrgl38ybN+DWZaVm0xn+fKSKMkyzTn7Cpp
         ge8A==
X-Gm-Message-State: AOAM533l1bt9QZxeVCGPurBMggoctjPhgxFEeU20pqStryBINw6Tvkxh
	la+/rU5afeBldLn0xm4djkZN2dL2bmX7i9Zc7x0=
X-Google-Smtp-Source: ABdhPJwV8ZaKM+s/xUS1NUHCO/ZMWF/103jLfrlytPltglj99hXjSzFqfFR/7UEPIUob8mfjNkhFtw==
X-Received: by 2002:a17:90b:4a09:: with SMTP id kk9mr2524902pjb.103.1632493359782;
        Fri, 24 Sep 2021 07:22:39 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id j20sm9907347pgb.2.2021.09.24.07.22.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:22:39 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 12/14] cookerdata: Show error for no BBLAYERS in bblayers.conf
Date: Fri, 24 Sep 2021 04:21:05 -1000
Message-Id: <983dc7f5bbeaf13f367da32ec17bbf7881e8f6a3.1632493110.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1632493110.git.steve@sakoman.com>
References: <cover.1632493110.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If there is no BBLAYERS set in bblayers.conf show a more helpful
error and exit.

[YOCTO #14340]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 97183e10faf9862b5d9489d6e2c27ac77c3b697d)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/cookerdata.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 44af7b2a..26b9b0b4 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -348,6 +348,9 @@ class CookerDataBuilder(object):
             layers = (data.getVar('BBLAYERS') or "").split()
             broken_layers = []
 
+            if not layers:
+                bb.fatal("The bblayers.conf file doesn't contain any BBLAYERS definition")
+
             data = bb.data.createCopy(data)
             approved = bb.utils.approved_variables()
 
-- 
2.25.1

