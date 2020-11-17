Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
 by mx.groups.io with SMTP id smtpd.web11.15114.1605648203871197853
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Nov 2020 13:23:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=u97KvKrq;
 spf=pass (domain: gmail.com, ip: 209.85.218.65, mailfrom: smertk@gmail.com)
Received: by mail-ej1-f65.google.com with SMTP id f20so31490569ejz.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2020 13:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0qDUsAUZPNVGS/znJ5idOC98GulobdgYruFewn8MnEI=;
        b=u97KvKrqxODAz7Vy2rBpL0mqYfw4yV1xDK3JFYIQ4fBFre3qx7gMKGB18pcAZZFJ7G
         lfKrKPLY+pO/RNIG1rSIJzh7A7LOyWI1K2D/zxfwGlmI5aZkQVqIdzDH0ZOAWYCyDYD1
         7XlRiE3GrB/LA40k2E2ypxAx61dr+DIoVVB/Fpaj4I3NSkClVxfqFYZr1wjn/al9RpNV
         swR6UoEmYuRst2eH5LdeoKVLksSCf90PSjt+KafuuzaP6X8vZO0SgfQJSNl9PzUkwFDa
         vPENwlWexHTXVPsZGMaVfFHq7rKMFTZIEulwk4Rxw9CM2Cdoq8YXVyUVENlk2ok4k2i2
         Fe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0qDUsAUZPNVGS/znJ5idOC98GulobdgYruFewn8MnEI=;
        b=DF/SKy/vd97NP3Ya5FZRshYfmkEeueDIhoyW7bgW7cLX/Nk5mDwraILUWYMMn29Xw/
         LH2OOPop9c/cRC/d1SwJqYIJ3e8UZWmvXfoyZTeNJab0eyT7sRAg3fBBPq57g3ZwzsXe
         Cah24lTbAapQ7SjI0lgNMmzuvoocv6Zo+foH1plQHY9xbuXYFwQtYxIO6r9Dp3oJzO7K
         A7oL7AfrsDoPu//GVRjMdbTekGIzdkl9ohfYhocsZjd2WC+I7qd+n/uQOe9SugfqnAsw
         FYjuF+cUWLfoxZUwgyKVUohtzWW8j9IOumpbjBb6GqkvCJD2nezrfhDgo0PHTBqSVx4z
         kDbQ==
X-Gm-Message-State: AOAM532tXQim6UCCdMKmo1YXlv9DXQK4qnzWB9APN2yKe977IW82w71y
	uE4zLrHMS6rqzTyYk9yVOCXWK8cJaIFCRw==
X-Google-Smtp-Source: ABdhPJweTFLiv7MJsI/XK4WQImGYrwPpbMxKmkWpDPg8plTwlmc4Zc0L4ThywkTr9y6gvJtwDK0i6g==
X-Received: by 2002:a17:906:a444:: with SMTP id cb4mr22065571ejb.416.1605648202185;
        Tue, 17 Nov 2020 13:23:22 -0800 (PST)
Return-Path: <smertk@gmail.com>
Received: from t440.localdomain ([46.196.72.188])
        by smtp.gmail.com with ESMTPSA id h28sm2721242edj.86.2020.11.17.13.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:23:21 -0800 (PST)
From: "Mert Kirpici" <smertk@gmail.com>
X-Google-Original-From: mert.kirpici@siemens.com
To: bitbake-devel@lists.openembedded.org
Cc: Mert Kirpici <mert.kirpici@siemens.com>
Subject: [PATCH] doc/conf.py: add missing import sys
Date: Wed, 18 Nov 2020 00:22:51 +0300
Message-Id: <20201117212251.33622-1-mert.kirpici@siemens.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mert Kirpici <mert.kirpici@siemens.com>

Due to the calls to sys.stderr.write() and sys.exit() in exception
handling in case of sphinx_rtd_theme not being installed, the
following exception is raised by Python due to the fact that sys
module not being imported.

---

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/lib/python3/dist-packages/sphinx/config.py", line 368, in eval_config_file
    execfile_(filename, namespace)
  File "/usr/lib/python3/dist-packages/sphinx/util/pycompat.py", line 150, in execfile_
    exec_(code, _globals)
  File "/work/doc/conf.py", line 80, in <module>
    sys.stderr.write("The Sphinx sphinx_rtd_theme HTML theme was not found.\
NameError: name 'sys' is not defined

---

Signed-off-by: Mert Kirpici <mert.kirpici@siemens.com>
---
 doc/conf.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/conf.py b/doc/conf.py
index 354dff36..fc2ee081 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -14,6 +14,7 @@
 # import sys
 # sys.path.insert(0, os.path.abspath('.'))
 
+import sys
 import datetime
 
 current_version = "dev"
-- 
2.29.2

