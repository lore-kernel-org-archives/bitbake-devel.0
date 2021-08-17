Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web09.41432.1629216899128596924
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Aug 2021 09:14:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L59ykKhB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id q6so17959421wrv.6
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Aug 2021 09:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyHYQXGyI4yUaNI5JMvGFHOWOreVb03PkQiKl5tOdLI=;
        b=L59ykKhB48lbFdm/QLc2dfx15+csFqGLMjGIzvy4Dk0ZRNnb/mj3Zi8RY1LmcIPE/W
         enquhLXrDdAWoOLENSpIECb9U50oSshjQRtE9FpIVC/12NWV6xFvSBF+Eqo/LhcwqO0Z
         m6/GyocGMqMlEiuy0zFi27VyW19SsGv0x3bJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyHYQXGyI4yUaNI5JMvGFHOWOreVb03PkQiKl5tOdLI=;
        b=g8dkLet0vfU+NznScwYsQfrEEn3Dm7YCidpgyYbLS0NCLl64//jg404pow6MWBl8uz
         YNHu7i7QcZRRkbjMinMZKIBWTIF96DI/mkLku+oVcK0BToMCb0aGENcX8ZbYXRXLVXKN
         lf2/+AKhPaihoFU7h2CPfatbP4yKOuv45v1ZHZMJsXpDXKPzEV7HrlTEQV8VRhQ3Pdrf
         vA8fDH75Y+0QzkJJB/9G8+Ovp2odIEf9eV3GEROCpy+2XbaTtFB2F+S/NdxJ/dPakbwU
         v0mvwwsc9aUW9wC2FDqyNwnRhBeuex0oLuKX+Te0rFA41s5j2cFxTH3yII2UTi8KO0No
         v1Bg==
X-Gm-Message-State: AOAM531SAzbc5PXF9h4jGS97V0/sqqvqS4qFqsxxIuaDwF2Egki69Rrt
	hnB9ITG2n3AnprCA499XUfwFix1QqBEkKA==
X-Google-Smtp-Source: ABdhPJytL4tmU4XhlDHUDHMC9rBKgLRH7+f3GxXwnK/uTg0ZxfoQiRpR2jQV/6VABV+uTW2fZj4TYg==
X-Received: by 2002:a05:6000:234:: with SMTP id l20mr5285412wrz.291.1629216897404;
        Tue, 17 Aug 2021 09:14:57 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:b306:790:99a8:ebe4])
        by smtp.gmail.com with ESMTPSA id b15sm2877060wrq.5.2021.08.17.09.14.57
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 09:14:57 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake: Make 3.6.0 the minimum python version
Date: Tue, 17 Aug 2021 17:14:56 +0100
Message-Id: <20210817161456.3887984-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OE-Core did this a while ago, it is simpler if bitbake matches.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index c1e30697b3..5c248d3655 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -12,8 +12,8 @@
 __version__ = "1.51.1"
 
 import sys
-if sys.version_info < (3, 5, 0):
-    raise RuntimeError("Sorry, python 3.5.0 or later is required for this version of bitbake")
+if sys.version_info < (3, 6, 0):
+    raise RuntimeError("Sorry, python 3.6.0 or later is required for this version of bitbake")
 
 
 class BBHandledException(Exception):
-- 
2.30.2

