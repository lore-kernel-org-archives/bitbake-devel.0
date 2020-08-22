Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.151258.1598082372714404684
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 22 Aug 2020 00:46:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hgArUrzz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f67.google.com with SMTP id a15so3869361wrh.10
        for <bitbake-devel@lists.openembedded.org>; Sat, 22 Aug 2020 00:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IZ8AGmMLJGjYjQCxh9sDrVw0HrbeyizEmBR5ayyYHjo=;
        b=hgArUrzzZ+fXEKvJgOdsR+IiOj4Z2HzIa9NkJ06eKhj3LyGYtBR4SjN5PiF4z3mwGi
         2BN66P3etItTFBbWaAhr1Di3VCPL7MdBOHA2go9juuwVBWu5TFDpROuIssVHhGMPi51q
         gKkqXQEzLxqj1pTnxiJdjGxv8zUi3oBKnYT/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IZ8AGmMLJGjYjQCxh9sDrVw0HrbeyizEmBR5ayyYHjo=;
        b=O3s82VKw9p02pqvwzE6hp7NVT0PSNxOQZmiBNEr38fLnCjRHUMvtJKoLgQoYah6/uN
         P0rCfeCH40Fbl5nd8O7AnVGAEhuyHGf3SB1vQdnLNKFLP/cXDOBi//TGkcebd3CiFTWc
         eYU6jGTOtQLKBmoRFu/ut9U+G0L4Uv4lT6/uxMx8zrHJuTNV3HOwHlR2/2sRhRQD6hjS
         rUHT/1TzzD5RPjGyjWiYn6ZM3M+pz5miTy3IJ+xloYYKnGsVL4z4QwM/P8oqwfFoozVE
         H+kJZ6nJCnRNACIUq3QqYOI+ZJiAlGP4r0v49m4MpwI4NNq9+wtal/se9kuhaqGovICo
         JIlg==
X-Gm-Message-State: AOAM5320WPmBqb58bANYr8k3w41Trd6V9kQVIZjay+hqzBszLLnFP6TY
	ph4c+f0Apm+OhUcU11VOc1Fu5u0yPfSAXIE1
X-Google-Smtp-Source: ABdhPJzzgxTUL0R88exriC9Aqe6fYe05QXBT/hXE0B9Hmu6IMHoQFCwKDWZ+7AaEpCVCp5/CdIn6hg==
X-Received: by 2002:adf:e8cc:: with SMTP id k12mr6238928wrn.2.1598082370774;
        Sat, 22 Aug 2020 00:46:10 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id d7sm9751913wra.29.2020.08.22.00.46.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 00:46:10 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/wget: Remove buffering parameter
Date: Sat, 22 Aug 2020 08:46:09 +0100
Message-Id: <20200822074609.1301404-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The buffering parameter was removed in python 3.1 and made default
so we can clean up the code. This removes weird looking double
exceptions when connections fail.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/wget.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index f7d1de26b7..e6d9f528d0 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -208,10 +208,7 @@ class Wget(FetchMethod):
                         fetch.connection_cache.remove_connection(h.host, h.port)
                     raise urllib.error.URLError(err)
                 else:
-                    try:
-                        r = h.getresponse(buffering=True)
-                    except TypeError: # buffering kw not supported
-                        r = h.getresponse()
+                    r = h.getresponse()
 
                 # Pick apart the HTTPResponse object to get the addinfourl
                 # object initialized properly.
-- 
2.25.1

