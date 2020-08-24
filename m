Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web11.1059.1598288024840415131
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2020 09:53:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hgssbSat;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f68.google.com with SMTP id s20so4059317wmj.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2020 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OVwNMBVVzfKQWPJTCCbCnj31qZsS1lI1orfpdNo9C3I=;
        b=hgssbSatROfGP5Untl7TiCIpfKy6Zn2L5S/fXFpRJ2iertFee+Qg4ukKTiezhqfLje
         l2ygaPDtRMT++NV/geZqQeqpad5I1IKT+FNFvPJqTVYPMej5KDgoMG9q92yGm2VLLd2o
         mhfG0ul9KGjhLVhLW4OeIMNNmmtSjkqo2g7Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OVwNMBVVzfKQWPJTCCbCnj31qZsS1lI1orfpdNo9C3I=;
        b=flR4nm+dngsdoQx5l8VFxr76kp5Quvl6hSWapuwH5XlzHxIN7OzzUO91RTmlYOyFX0
         GxLuc8RISVu5IaPwurFGeBwRPDoYSiMBgpH/DoKUWKdHjX+x7DqOicYJkCM4FKdp/WlT
         +YjFg92+f83ZCzrbrfaZK1+TF53hS++le2Blej2WkodBnUPaEMQp8uNccm2rGSdlY0Vc
         ZfLsCdBZJGd4EHnuXmy0Oc3pREbfRQ66dk76DtUrIc0OvoLd3a0mxHt2i6YlQ+NHGBM3
         6bHsb9XdMUwDtdWUogehH5i9mxiKilKKfpDtjqvpXQVirOcOAlpnOrCUgev7aVFYWhXx
         2+Lg==
X-Gm-Message-State: AOAM5319M5QR5Ip3po/HPwk1VRUqqZF0dpGSjHJZxRN51r7cj3IvLatg
	C4EOHT2FomRpZYhn1t/zZ1T1cr6JeAXAAzxC
X-Google-Smtp-Source: ABdhPJy1549Xg7cWeqa+be3sXMqE+64m/n1AeR7jhelOAXYFvnSOUEvlTGWukLK9tfqH/4rRbVnRCQ==
X-Received: by 2002:a1c:3985:: with SMTP id g127mr202860wma.64.1598288019123;
        Mon, 24 Aug 2020 09:53:39 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id f19sm182127wmh.44.2020.08.24.09.53.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 09:53:38 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 09/10] server/process: Log extra threads at exit
Date: Mon, 24 Aug 2020 17:53:30 +0100
Message-Id: <20200824165331.1373725-9-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
References: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dump info into the logs if there are extra threads left at process exit
time.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 03cdde04ee..915651084e 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -233,6 +233,9 @@ class ProcessServer():
 
             ready = self.idle_commands(.1, fds)
 
+        if len(threading.enumerate()) != 1:
+            print("More than one thread left?: " + str(threading.enumerate()))
+
         print("Exiting")
         # Remove the socket file so we don't get any more connections to avoid races
         try:
-- 
2.25.1

