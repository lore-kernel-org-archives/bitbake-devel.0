Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3711.1795466174207436329
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Nov 2026 12:36:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=hDHNg4iX;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: stondo@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a42b34e930so3326485f8f.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Nov 2026 12:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795466172; x=1796070972; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L86a/IVDXLrVGCAseUQRrPP+Q8Wu9Bg4uoezVfMWtgY=;
        b=hDHNg4iXX+3doXbDL2+LQ06lXnl65DsuUKDY8sl0oXC/O8UpmRH1zRtpRk9GXvuMHt
         nrVQ/iU+CP8VGlicQtHBrBWhz4VpxtiOgWvJ00Tu9CXU+IONo0tem2s5VvKs1nSWs7Z5
         a05DT/ZZW4So3J4xDV56IkoSqYxWz78xW3c7ijkYPu4EgTZDt/3bgjd2FywExfQvSOW+
         N8eiUTz260qK5s5gT9HJEFsjOKBbLtRGasYdeEnDdpSG7/G0SDVTVVYVXDlMg1Vh1t7p
         FWR3I8EcPjGXShUClWJOvC5NwzyKzIPK7s3wz49/ql+S5Z1Z4AVAAa1nCzmlr96nShHV
         gePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466172; x=1796070972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L86a/IVDXLrVGCAseUQRrPP+Q8Wu9Bg4uoezVfMWtgY=;
        b=2yc4O3SAdbLFprRvyoErw62NAyFe6sOwLi70P1ZXQo2g1pfC6WKv9cDMNMiFoH7CH5
         beDBhhx3pFcoAOZMdBJUQuOna25ststv87tFmF5I0qyEQ8W4264E596LcU76p3wmESy3
         3UBvHHjAmjrJqaqHa9MtW2b0poi4NnkQjLyk0nhTxOwH32KvWzzSdJzMNjpZpo1fWZfi
         +xt+HRUql0ybWUAZkahepGrlGKGE0qwWHuUIAZTp1Y7nyLDX4uzkehKDMMJi7Egrel/O
         qftK/NM5pH7e8Rv+PAshIYmf06EqiP0kbKk0Pa169fDBL+XgKO9EN8hM1rVaO8yjUFL+
         kETA==
X-Gm-Message-State: APuU4Z8mGqtuCdddGLai9Ohq1LuY8Dz1gRwlqd/SYN2IvfWDHXfjQ4ti
	A/f4qUAKQxU6Hv2IpoVb5wlJcDkhMUjOj/RFYYuPNHiyQdj/R72eDCSzj2E3xw==
X-Gm-Gg: AZFdTZco6RtGcVd/HlfKfEegm5YPYU5D/YGz2T+jhW0i3is1IIXg8IrnPMt+jduELbm
	j1TqkyAZeelvYvgwu4O2yBknOnATg5TZH3K1lkO5C1jexcChaV0/u4LucicaG1QN8XYpsFXJEsl
	FCFjYgwh6xSlFZbQJXPLoD3TVOGiPilAyBZQuxql/KpeHqgFTP+HDIdnX2eUI8lV8BZf8ozYjIj
	n6hHFUR1AUEh7n/MIibADqlb7aUr8xRrTborp4p/+yh4GAMfo61u2pkEkxweEWFD6iWf/7DiXGv
	Pd/wVqFnbwHPCoKV+uUWFCVzw3Ctsazi12ZzFBt15OvkLQ96ndMbg2a1o1OcN/EIXLEdbfVJkvk
	JBEeYgUGH003uLAikpAsaAm3qHyZ3GXERWRNUT7eiHC57wb57ewpJiBoiaXSVri+lrbSW3IK4XO
	5y4r6tJUbwGd0vFXW7qdOfxFpjQ/cvejfB2LcaK5xs1PjKmXZCKLolklxV2eN+XXTaIBdjNOeY0
	NgjDVEKKbIsSJHsrG5M6EuMtDtQ2hhKywNNbOr8fYXWCQ0hXHwL4+lZ7Hp8Vm7hu12NIo71ZNm8
	bGCUeypOLdw=
X-Received: by 2002:a05:6000:29d6:b0:48e:20f9:8d75 with SMTP id ffacd0b85a97d-4abb58ec00dmr14454426f8f.48.1795466172263;
        Mon, 23 Nov 2026 12:36:12 -0800 (PST)
Return-Path: <stondo@gmail.com>
Received: from fedora ([165.225.94.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dd55sm23620424f8f.30.2026.11.23.12.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:36:10 -0800 (PST)
From: Stefano Tondo <stondo@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Peter Marko <peter.marko@siemens.com>,
	Stefano Tondo <stefano.tondo.ext@siemens.com>
Subject: [PATCH] tinfoil: Disable data tracking also when the operation fails
Date: Mon, 23 Nov 2026 21:36:08 +0100
Message-ID: <20261123203608.867455-1-stondo@gmail.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Mon, 23 Nov 2026 20:36:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20472
Content-Type: text/plain; charset="utf-8"

From: Stefano Tondo <stefano.tondo.ext@siemens.com>

_data_tracked_if_enabled() enables data tracking before the operation
and disables it after the operation. If the operation raises an
exception, the second step does not run and tracking stays enabled in
the server for the rest of the tinfoil session.

Disable tracking in a finally block.

Signed-off-by: Stefano Tondo <stefano.tondo.ext@siemens.com>
---
 lib/bb/tinfoil.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 9b9925e51..4fd2a9af8 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -789,10 +789,11 @@ class Tinfoil:
             self.run_command('enableDataTracking')
 
         # Here goes the operation with the optional data tracking
-        yield
-
-        if self.tracking:
-            self.run_command('disableDataTracking')
+        try:
+            yield
+        finally:
+            if self.tracking:
+                self.run_command('disableDataTracking')
 
     def finalizeData(self):
         """
-- 
2.56.1

