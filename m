Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web12.5515.1619744661040041814
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Apr 2021 18:04:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=IC7MEzA8;
 spf=pass (domain: gmail.com, ip: 209.85.210.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f46.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso61193317otb.13
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Apr 2021 18:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QNE0E9lFlwD6UUVenMyUZOoH2IW7oJqtcXfTATdh7JI=;
        b=IC7MEzA8G6JsH51dIMnRSc4Et6O3CBRHoOTdpnPs3deoiSZbWnPHWGqcC8sliA6wKX
         daMRla5Tz+0JlubeZtnlp9GaZCQ7oRHYo3dPiBd3aGAwfWoxQQbF6bN3Gi129IGGkW12
         zdRhJXsV9F/drfmhYNOUDVq/1JWCyMqqEQzz+/kLRSQFfQ6uVhpscXtM4KJhH0xqiX1y
         u6Cyc3c5EdlfkfjmxysEc0zRuYrihokI9K5agT4Bx6PirK5eq45XqzoKsfj/fBJdEn1S
         Iri+QOXp1KKgn+heCJLICQMngFP3GgGH48x07Oh6KaLGXzfpIG3nurH6X87MgEY/0zD/
         4JnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QNE0E9lFlwD6UUVenMyUZOoH2IW7oJqtcXfTATdh7JI=;
        b=qOkpkXJRL3uvfoLRa1NJx161YGWcXzejhvJOvIv946I8qTb/wGWy4OgWkZUi5w77h8
         YQUVr7UaUbi+dmsycufU2UeMTmV+KguufRR4NjSErIdrHrx61isJbkzjPyMEN9Ze7dhU
         z2ayuFqptd0odi926a2BxT/knq6evQvrO4611R/QK9jkCpS2eFU90W+QgvL0duy9Q3Q6
         Rm1cXcV+Sq2AfslnQ6w0GhETo0gQ5VGZsyRXnugw5nVhi7debPbD+4xJxhvZUa81bcEO
         64N7DXO2NF/f8FoQlbm7Mz7M4v0xYVBD2dJT3EN0+GYd5Toqo2n2GLesDWY6kc8Gz4i7
         P9ng==
X-Gm-Message-State: AOAM530yXqkxjUFZXGlah0KRTePtVYSEq1wxB2fyaM0Mzxpwr6CNeqx8
	LiKgHPd78+rqqSw6rkVHccE1q+WQtLA=
X-Google-Smtp-Source: ABdhPJyHIAvXEVCFclMU5dFVc0rROJHnUx1hniICKPxwKIjCHwSos/YYnnvMol69NISIg+EJ/qmEeg==
X-Received: by 2002:a9d:a4e:: with SMTP id 72mr1590030otg.229.1619744660177;
        Thu, 29 Apr 2021 18:04:20 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id x24sm361882otk.16.2021.04.29.18.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 18:04:19 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake: knotty: Re-enable command line logging levels
Date: Thu, 29 Apr 2021 20:04:13 -0500
Message-Id: <20210430010413.935-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "-l" command line options to enable specific logging domains wasn't
working with the switch to structured logging because they were only
being used to set the legacy logging domains. Fix this by implementing
the logic to parse the user options into the logging configuration.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/ui/knotty.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 0efa614dfc..65ff2727dc 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -21,6 +21,7 @@ import fcntl
 import struct
 import copy
 import atexit
+from itertools import groupby
 
 from bb.ui import uihelper
 
@@ -539,6 +540,13 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         except OSError:
            pass
 
+    # Add the logging domains specified by the user on the command line
+    for (domainarg, iterator) in groupby(params.debug_domains):
+        dlevel = len(tuple(iterator))
+        l = logconfig["loggers"].setdefault("BitBake.%s" % domainarg, {})
+        l["level"] = logging.DEBUG - dlevel + 1
+        l.setdefault("handlers", []).extend(["BitBake.verbconsole"])
+
     conf = bb.msg.setLoggingConfig(logconfig, logconfigfile)
 
     if sys.stdin.isatty() and sys.stdout.isatty():
-- 
2.31.1

