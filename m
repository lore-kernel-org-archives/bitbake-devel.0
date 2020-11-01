Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web09.22228.1604269756896067643
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 01 Nov 2020 14:29:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=PHXiTlg9;
 spf=pass (domain: gmail.com, ip: 209.85.128.65, mailfrom: smertk@gmail.com)
Received: by mail-wm1-f65.google.com with SMTP id w23so7649271wmi.4
        for <bitbake-devel@lists.openembedded.org>; Sun, 01 Nov 2020 14:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pYQeum9X0S8z0vcRDHNh7bKOE5Emn3y8rBHC+oe2azw=;
        b=PHXiTlg9aIE/TRKC5yyY9DVb58B8gNedcjoy3ysiore23aNSnkvl5WbSiQVPpkoOac
         YS/rbzoQQP8zEUsOU4DMLomIF9QDA1JAzV3bWc4LQHgyeusC/Pvp1N/Eq0PnjgOwbQhM
         mlKnoxESXdJ06Yf2C9Hh0hwdJkOv84uLBrIbTsozFf5+VxRQO+hWqXCqeCN0M2VCrdEW
         K7axRpHJQ5tKm5LkHCiIlBICqgJhoatdC6CMKK6jK5zNOYEac8ARutp7pGWvcAFRxMtP
         Q7b6NslTdpjodzDm7RLSzZWKDQn+C+vn2BweVZRPuDFvb9xeLHRY2j6aTQ7aG0hVwADS
         Cetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pYQeum9X0S8z0vcRDHNh7bKOE5Emn3y8rBHC+oe2azw=;
        b=pjoAXH9W1oGLiNjp4UM12cR74rMo7VfifGYIYRKnQT7Wdj4EgDKzpffZ8hAfkJiqJf
         vnUt9WPmhrmMqrahyfK6YHVwcr6gEM7b4pFv9N89x9r2BxX9ajCSQp+P3krDH82nhd5c
         6tZc7qXE8H4HQ2NeiovNzJMeOqM1/5xKy41GZLZZy986rPMPI0g33gEcLhvupXWxVFdh
         GIR65KyXD2YetdYmK7wfTiHqMdUcFbXS+w/DpX1Yy+nbxUoiElKBhwvLznFgAHGuFXV+
         sHXkbXuLXoci86TzpoyZF7VuFC5tSPKyJSFsiTBpzzIziHANHpHnM354RTtDG+aSXjCA
         +TBA==
X-Gm-Message-State: AOAM530qaKLuxCx/OqPmuIVZoxbR0MVdYFocWatk0sQPe+rGBU/7ymFg
	FNlHOcFL3/kWTr5pDy3z2xUZ65S5H243LFYd
X-Google-Smtp-Source: ABdhPJxgwk4fqq3lggmuLhbVnGmZHFr2h4lybtq80KHVi+CqRjJSn3TM554piWaRi2dnNRvKna+KQQ==
X-Received: by 2002:a1c:6302:: with SMTP id x2mr15249920wmb.121.1604269755165;
        Sun, 01 Nov 2020 14:29:15 -0800 (PST)
Return-Path: <smertk@gmail.com>
Received: from t440.localdomain ([46.196.72.188])
        by smtp.gmail.com with ESMTPSA id y200sm9388507wmc.23.2020.11.01.14.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 14:29:14 -0800 (PST)
From: "Mert Kirpici" <smertk@gmail.com>
X-Google-Original-From: Mert Kirpici <mert.kirpici@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Mert Kirpici <mert.kirpici@siemens.com>
Subject: [PATCH] fetch2: add zstd support to unpack
Date: Mon,  2 Nov 2020 01:29:08 +0300
Message-Id: <20201101222908.44421-1-mert.kirpici@siemens.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds unpack support to fetched files with extensions:
'.tar.zst', '.tzst' and '.zst'

Signed-off-by: Mert Kirpici <mert.kirpici@siemens.com>
---
 lib/bb/fetch2/__init__.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 551bfb70..ca81bd52 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1461,6 +1461,10 @@ class FetchMethod(object):
                 cmd = '7z x -so %s | tar x --no-same-owner -f -' % file
             elif file.endswith('.7z'):
                 cmd = '7za x -y %s 1>/dev/null' % file
+            elif file.endswith('.tzst') or file.endswith('.tar.zst'):
+                cmd = 'zstd --decompress --stdout %s | tar x --no-same-owner -f -' % file
+            elif file.endswith('.zst'):
+                cmd = 'zstd --decompress --stdout %s > %s' % (file, efile)
             elif file.endswith('.zip') or file.endswith('.jar'):
                 try:
                     dos = bb.utils.to_boolean(urldata.parm.get('dos'), False)
-- 
2.29.1

