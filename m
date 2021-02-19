Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.web08.12877.1613759303523179235
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Feb 2021 10:28:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=YOoUXwMy;
 spf=pass (domain: gmail.com, ip: 209.85.167.177, mailfrom: aehs29@gmail.com)
Received: by mail-oi1-f177.google.com with SMTP id q186so6737852oig.12
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Feb 2021 10:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BSWayIWB1d5XtPA3oV4Kw539AMV4r8SdUjH/s053XtI=;
        b=YOoUXwMyOu3g+ejdDdbkDB5mhgRXQXcM4tIDH2MSBHiz5MAZ2e64jRy2R/PFT2PLaf
         iB0epdRvz5Y9+Z7XHZpKgVW/2yvYPNaNnWzOqwNDNZax2l+FWmr/zf62vY2vU6s1I6cZ
         kDNegtJsG7pRbb8i3/i6YKFXHAeYwqc+2jdhjgXh2TBRtUg8S97FZd+tAemKZ+njTsdz
         cXwqXmkvhPge/v6vEtUTin3Be85mBHY6vojNVMtgXyxZxAQBDdt+2qHO0WPy4RgHggGm
         7POoKfhDgJ05SB190sQ02CdCyNQxNN/AUuSrKiG3kxX98D+LqEwtX+L2jmfqG8rTEf5q
         Fa6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BSWayIWB1d5XtPA3oV4Kw539AMV4r8SdUjH/s053XtI=;
        b=SQCXKemfx7P+kufBlrf7qbXdJAUqzHRWFmDIPdsix8mHsGHKCNZJfM8X3b4CxmZCy3
         6f1AxoYv8vvLw0T762XOahoaEjLLowz8HuXdHlRPxKyONm+e6/QyInYEel8SiicF4pav
         cwmZ2KRJ1qsXbKFzLOe0uSbhxSkp91iDD2EvQFk0Ep4idwKEGfMkx6bH3qYXufPWgxnI
         r/xbXHpakRByeyK3T8pUwmAIuo3PYYyuKl2lAN3k1OpBXvm+tS7kwPQ0wnmIvaRTEddh
         Ey/xQ8iwXvdZhtkwjfhA6JyIQ05/SjpoIQhyKA5MeFnBDgZ+qFP7e7I0viUXLDeV93UM
         5BNA==
X-Gm-Message-State: AOAM532qrGQuJwPCw0I3wJJB1h8QLNJOcu+p6+NVkbDdmFryYepcGZ0g
	1oFh8PDj0vaZZbBVZ9cvp9t9XTQF8oayTA==
X-Google-Smtp-Source: ABdhPJwaDNJ+aEs620aE/bhZ/iMhcLSz/CenUgP7+9+i9gbvDqNmKelQd5ac1Z0rKVNLD+bZI4L51A==
X-Received: by 2002:aca:edc8:: with SMTP id l191mr3964461oih.157.1613759302430;
        Fri, 19 Feb 2021 10:28:22 -0800 (PST)
Return-Path: <aehs29@gmail.com>
Received: from alsamon-xub.lan (cpe-68-201-52-49.elp.res.rr.com. [68.201.52.49])
        by smtp.gmail.com with ESMTPSA id k41sm1765698ool.15.2021.02.19.10.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 10:28:21 -0800 (PST)
From: "Alejandro Hernandez Samaniego" <alejandro@enedino.org>
X-Google-Original-From: Alejandro Enedino Hernandez Samaniego <alhe@linux.microsoft.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alejandro Enedino Hernandez Samaniego <alhe@linux.microsoft.com>
Subject: [PATCH] fetch2/wget: Avoid crashing when connection drops mid checkstatus
Date: Fri, 19 Feb 2021 11:28:17 -0700
Message-Id: <20210219182817.4006374-1-alhe@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    If an exception is raised when running host python code, the fetcher
    immediately crashes, this might be temporary depending on the servers
    reliability.

    Catch the exception when the connection was reset and try once again
    to fetch the data.

    File: '/usr/lib/python3.8/socket.py', lineno: 669, function: readinto
         0665:        if self._timeout_occurred:
         0666:            raise OSError("cannot read from timed out object")
         0667:        while True:
         0668:            try:
     *** 0669:                return self._sock.recv_into(b)
         0670:            except timeout:
         0671:                self._timeout_occurred = True
         0672:                raise
         0673:            except error as e:
    Exception: ConnectionResetError: [Errno 104] Connection reset by peer

Signed-off-by: Alejandro Enedino Hernandez Samaniego <alhe@linux.microsoft.com>
---
 lib/bb/fetch2/wget.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 78a49676..6d82f3af 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -332,6 +332,14 @@ class Wget(FetchMethod):
                 # debug for now to avoid spamming the logs in e.g. remote sstate searches
                 logger.debug2("checkstatus() urlopen failed: %s" % e)
                 return False
+        except ConnectionResetError as e:
+            if try_again:
+                logger.debug2("checkstatus: trying again")
+                return self.checkstatus(fetch, ud, d, False)
+            else:
+                # debug for now to avoid spamming the logs in e.g. remote sstate searches
+                logger.debug2("checkstatus() urlopen failed: %s" % e)
+                return False
         return True
 
     def _parse_path(self, regex, s):
-- 
2.25.1

