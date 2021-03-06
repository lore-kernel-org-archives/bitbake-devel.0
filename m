Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web09.5041.1615018994438064492
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Mar 2021 00:23:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=L6jUUiv4;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id e7so9645169lft.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Mar 2021 00:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ns15Xo9s8NZbvgt0HC8FQMzwJm7dYHdYKHv9/mXm4Zk=;
        b=L6jUUiv4pRBarAt+1M5Eml4wrVP+6sQLqB/auXtyFumrEjt5YOTCPi1zbkzxF7fiBr
         xuseS2wn1TvebqF1iRtGyjNyniYxUKoFdKy8YT/1Ln+fcK4QRH9B48SO2KFlNgQqCecw
         9jm15RtyaaaZg+V9LsAPZnLUF6/KWGjorr5lSj5ZKatSpGJbuOAhJx0+jdcBbH4BA5Yv
         sBuGsHO2Wj4yuxosqhl8bsRvFxAcavrvn1eYvkdGzckCNP6g6JtCZjGr/uwsTkPDxdYS
         LpLxTNODpZ2OXR6zs3veoaX8GhcF/cDN/xGezJ9Yvh/49jdMqOkz/wJiwRfK3/vPZePc
         0TDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ns15Xo9s8NZbvgt0HC8FQMzwJm7dYHdYKHv9/mXm4Zk=;
        b=rP/HjBc/7DuuleHwDBqbSbMtItcOoWaqVKEnB49/aSoAYI7l22Td2w07r+cG5LaUoW
         SSHQ9HMRol5PwzR3Iw2+k+mO5OBf+iwux4Yh0Ge+z6OR6J46ufevGz7H+d/o0YdUGh44
         j+88GxtWZMzjiu4yEDbSSY5jI8ett7PM7rTHNAdinh0LYSv9n7d3VqyNJxaA0wVer/bs
         54h9bne2v9nU8smiwFPH9fV5F4aV3nenSOnfk0PtWp+3Q+j66wTxAz5uNYIV5yXEzmEK
         Dr7MITUX1Cf7/6oQr3XuVWyFIooZpojz/sCRiQDdiu3/JJS/YOcZqA4WJyR9vO/U3H2P
         9zXA==
X-Gm-Message-State: AOAM5330qBgRkbIN3YIgIIfXNvXf8Wmaqh2Ws0OUGfRo2QKPOaMyoJWc
	RWtAKnzPMbRkpYJGU2LfSwnmhyJ4nBsEvC5b
X-Google-Smtp-Source: ABdhPJwn81WUhHvRxXCXkUIxKMxXMsu+yXpbLGQpPqe63h/oTqScM2nOKWXlP42+MrMxBmEsCnD+EA==
X-Received: by 2002:a05:6512:3185:: with SMTP id i5mr7825524lfe.653.1615018991925;
        Sat, 06 Mar 2021 00:23:11 -0800 (PST)
Return-Path: <tomasz.dziendzielski@gmail.com>
Received: from localhost.localdomain (h124200.man.tk-internet.pl. [93.175.124.200])
        by smtp.gmail.com with ESMTPSA id m3sm612963lfo.190.2021.03.06.00.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 00:23:11 -0800 (PST)
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Subject: [PATCH] event: Speed up parsing time on __BBHANDLERS_MC check
Date: Sat,  6 Mar 2021 09:26:00 +0100
Message-Id: <20210306082600.2685-1-tomasz.dziendzielski@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looping over this variable multiple times might increase parsing time,
while in fact we just check if the structure contains event. Replace
list with set that is faster for this job.

Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
---
 lib/bb/event.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 23e1f318..f76f2825 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -118,7 +118,7 @@ def fire_class_handlers(event, d):
             if _eventfilter:
                 if not _eventfilter(name, handler, event, d):
                     continue
-            if d and not name in (d.getVar("__BBHANDLERS_MC") or []):
+            if d and not name in (d.getVar("__BBHANDLERS_MC") or set()):
                 continue
             execute_handler(name, handler, event, d)
 
@@ -275,8 +275,8 @@ def register(name, handler, mask=None, filename=None, lineno=None, data=None):
                 _event_handler_map[m][name] = True
 
         if data:
-            bbhands_mc = (data.getVar("__BBHANDLERS_MC") or [])
-            bbhands_mc.append(name)
+            bbhands_mc = (data.getVar("__BBHANDLERS_MC") or set())
+            bbhands_mc.add(name)
             data.setVar("__BBHANDLERS_MC", bbhands_mc)
 
         return Registered
@@ -296,7 +296,7 @@ def remove(name, handler, data=None):
             _event_handler_map[event].pop(name)
 
     if data:
-        bbhands_mc = (data.getVar("__BBHANDLERS_MC") or [])
+        bbhands_mc = (data.getVar("__BBHANDLERS_MC") or set())
         if name in bbhands_mc:
             bbhands_mc.remove(name)
             data.setVar("__BBHANDLERS_MC", bbhands_mc)
-- 
2.30.1

