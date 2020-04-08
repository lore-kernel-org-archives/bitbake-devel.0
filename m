Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.1507.1586387992402975293
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Apr 2020 16:19:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VdzEl5ng;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id i10so3217750wrv.10
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Apr 2020 16:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pQ/8dNxubNdtRjixY9to2d0kus9uyIzC+qZNisAZl6M=;
        b=VdzEl5ngAeSX5GwA1L7EfTbcTHqYBwjwxHx803o5Zgis2xEiP/RkD8PWfcYIZEQ3Pj
         vAPQZtV4Q4wNePrKnJHFHgL2G+ltJBr6kdfKa8uD7JI8j2UJFEkZ1709FyyhyWoxItGc
         O2wly77BI0RQPa8rBxEJp+AWNY2x/J2i3CfsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pQ/8dNxubNdtRjixY9to2d0kus9uyIzC+qZNisAZl6M=;
        b=G2vqxvjshFrJkdrrc8Qz96biSRu1F/n6ImdxlyTS1hp+/GFkmmapJ8e/DZDUdWNd33
         9v9QW9FGIa3IDkJm2iBPZYO5gp2ps7y6i7F9sYatlU5p700oq8G2drYyruT7WsH5+xfc
         1hMgui/t8sHTuq8o8Wo7OXmu0fRTinJ5esbJ/H6W2daTO8OKYt+bQAD8roefTRnsnvGj
         N4pzz99v11f8H7q75yolm888WUKcbKTou+mMlmcPusr0mjS4U2X1lvx8t0QR7DNfOg4W
         jjYPeLTV9i8frSz6QZczlLAKXvnGm3zShvAqvuQoivDP6r/rd+HGcaB40DSFtFpptoWn
         O4fQ==
X-Gm-Message-State: AGi0PuZzfY0GkQ9zINjSn73Jz3KjSPuQ3WUp6C/ehYknmS/XNaIIifMF
	cAYMDw+z8xbfO4dbvIt04EUnoBlnO6I=
X-Google-Smtp-Source: APiQypJJSKG6GTr8xuMum16EVdxAxKlmBO3gsJi2S0uJTcvur96hdt5gsnHosEk9Tc2frCwjKvTD8A==
X-Received: by 2002:adf:f808:: with SMTP id s8mr11847951wrp.219.1586387990710;
        Wed, 08 Apr 2020 16:19:50 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id z16sm3904895wrl.0.2020.04.08.16.19.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 16:19:50 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] data_smart: Handle hashing of datastores within datastores correctly
Date: Thu,  9 Apr 2020 00:19:48 +0100
Message-Id: <20200408231949.393761-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is a datastore within a datastore (e.g. BB_ORIGENV) then
get-hash() doesn;t correclty handle the contents using the memory
address instead of the contents.

This is a patch from dominik.jaeger@nokia.com which addresses
this problem. Its been low priority since we don't include
BB_ORIGENV anywhere this would cause an issue as standard.

[YOCTO #12473]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 70257ab7f8..7f1b6dcb4f 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -1000,7 +1000,10 @@ class DataSmart(MutableMapping):
                 continue
 
             value = d.getVar(key, False) or ""
-            data.update({key:value})
+            if type(value) is type(self):
+                data.update({key:value.get_hash()})
+            else:
+                data.update({key:value})
 
             varflags = d.getVarFlags(key, internalflags = True)
             if not varflags:
-- 
2.25.1

