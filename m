Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web10.13660.1612652934098084909
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Feb 2021 15:08:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=IDIXoJSI;
 spf=pass (domain: gmail.com, ip: 209.85.215.173, mailfrom: akuster808@gmail.com)
Received: by mail-pg1-f173.google.com with SMTP id m2so591344pgq.5
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Feb 2021 15:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=lcIRF4DCAqqo9aM3jIJHEmSyVt3mXL3V3kj3RMmG7FI=;
        b=IDIXoJSIgW8VkMi9hS3cIx/xaNLpZeRZiNDiL1h0kWhWr3tIz7oveRxPAOFIBRits2
         l/h2EJuZwP99NJoTCFSYUrIHirRbLAAJOkOpB7N2Fb8HfhU+y8HpjIRgn2PDVnj5pdjc
         OEFfGDjdKDDIshLUmu4456cmAxOzQ5tSFieVwacT7wVuvygMVjK324iQiOwTK3OPSZ/G
         +TeDPCyGcJNc0wnPCh7mPxoXzszUXl80X8VzTsjarkxYO7fHvx5DQlHnQtbqyM9mhN/X
         6uvYr/TcdS+BTDBNAtZeyyOoMnlDN88xdzEchNWMvxh1E4zZHKbuOUVQFT3EATWOvIk1
         kGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=lcIRF4DCAqqo9aM3jIJHEmSyVt3mXL3V3kj3RMmG7FI=;
        b=hisgX8flS2SCVgD3JZfJclSCZITB6yIk+k/y0mHT/TBwbJHomAptPSkannm29Htzay
         yiGGUC250KQUTq8ZvhIQBJBLeb1aEmAGj5qvIzOUH13FK3+7el/F6Qv5uC+sDdjzLJTo
         6wMusdgoJYI9BIFUfLW3/Oh7zIRRDaBACvUqgG9MHP51zd5k2/m+A+BOsz7X8QrnogNA
         JS5gRhRE8/LjmoLv+DuFKaVpq9Hv21mI5Lc6b+4zuoXzajpAogOaJRUZuU6c2uOzRKOv
         0iD/28TZZpgmQKg6NDLEmlT26UOL/M3G4DbPSBmOSx/avxsxYIJT91xOK0CC1jfxg2as
         HhZQ==
X-Gm-Message-State: AOAM532Xk7S1l5F6Gj9pG9xG0KHdc1yPo0hUop6/6n8Eg95cicpn12jC
	033IqEog4eEP9iyIRuyotYTLJU85vXiQfw==
X-Google-Smtp-Source: ABdhPJz9R/BD1P22sJpAWhZlTC/86A5KN39blMjpSxclUnlOBDPh5Fu7jDRxTnCbbovtspx3xtxewA==
X-Received: by 2002:a63:7f09:: with SMTP id a9mr10832075pgd.63.1612652933504;
        Sat, 06 Feb 2021 15:08:53 -0800 (PST)
Return-Path: <akuster808@gmail.com>
Received: from akuster-ThinkPad-T460s.mvista.com ([2601:202:4180:a5c0:c5c4:f80e:4f44:b02e])
        by smtp.gmail.com with ESMTPSA id k10sm14492489pfk.0.2021.02.06.15.08.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 15:08:52 -0800 (PST)
From: "akuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [gatesgargh 02/10] xterm: provide virtual/x-terminal-emulator
Date: Sat,  6 Feb 2021 15:08:39 -0800
Message-Id: <2ed77abf132696b7f3a8b9f8f422eb33ff711038.1612652802.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1612652802.git.akuster808@gmail.com>
References: <cover.1612652802.git.akuster808@gmail.com>

From: Dmitry Baryshkov <dbaryshkov@gmail.com>

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
(cherry picked from commit 8826791d795e65851ad20bbc0f34e74b2bf72e07)
---
 meta-oe/recipes-graphics/xorg-app/xterm_353.bb | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/meta-oe/recipes-graphics/xorg-app/xterm_353.bb b/meta-oe/recipes-graphics/xorg-app/xterm_353.bb
index 6376388c27..06c285924d 100644
--- a/meta-oe/recipes-graphics/xorg-app/xterm_353.bb
+++ b/meta-oe/recipes-graphics/xorg-app/xterm_353.bb
@@ -37,7 +37,12 @@ do_install_append() {
     oe_runmake install-desktop DESTDIR="${D}" DESKTOP_FLAGS="--dir=${D}${DESKTOPDIR}"
 }
 
+RPROVIDES_${PN} = "virtual/x-terminal-emulator"
+
 # busybox can supply resize too
 inherit update-alternatives
 
-ALTERNATIVE_${PN} = "resize"
+ALTERNATIVE_${PN} = "resize x-terminal-emulator"
+ALTERNATIVE_TARGET[x-terminal-emulator] = "${bindir}/xterm"
+# rxvt-unicode defaults to priority 10. Let's be one point lower to let it override xterm.
+ALTERNATIVE_PRIORITY[x-terminal-emulator] = "9"
-- 
2.17.1

