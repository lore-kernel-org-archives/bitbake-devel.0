Return-Path: <me@anthonysquires.ca>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915B0CCFA13
	for <webhook@archiver.kernel.org>; Sat,  2 May 2026 02:51:28 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.72.1777690278143562348
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 May 2026 19:51:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@anthonysquires-ca.20251104.gappssmtp.com header.s=20251104 header.b=XhdMe9O5;
 spf=softfail (domain: anthonysquires.ca, ip: 209.85.216.52, mailfrom: me@anthonysquires.ca)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35f9ab079bdso1856240a91.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 01 May 2026 19:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anthonysquires-ca.20251104.gappssmtp.com; s=20251104; t=1777690277; x=1778295077; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yfo6A/O1u9K9GbFTN66t2DnC4oZKSrAk87G2t3w0CR0=;
        b=XhdMe9O5eYHJjFTuomywmI6eFIE9HPie0xBh/nOrv3R+waqEKViGesoDuIents/aAJ
         u5jRrx85nrqHcXHVopnU4ToIatwYspUOLhwBdIFq/zRIg5EwckKQnKXCEx3AjAhqAX6v
         QOABI1N7I98pRsBCD49TUzsi9UoSLYM1Kk1dDlb3ILlYXmR3+ln83eVgSoEdFRj/PmMz
         uWDI6C0Fi+Zw+bWPoib/LpTjPb2Vz7GR9oJ8Zl2fH79r91ii4x28CzJgzFiGgPiubYq/
         4jlBUbJIpmZgSFw644mWbViSjRWtzE4RZXiHwLPGHZ8htoDjOUAiV0wPgGfmOJPFa9SK
         5Siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777690277; x=1778295077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yfo6A/O1u9K9GbFTN66t2DnC4oZKSrAk87G2t3w0CR0=;
        b=PTjoHVrureWrN40JkqflWageldEtJ3v3B5X9WWNBfWGHTvRgO0alchxhk2Xb7Rn8IR
         dLGQwIP0elXiXtuI0UjOONezimW3zladvSsM2RyWp5w/QWLhmHW26Hq3P64DeMXvwsPu
         Uz8VCaRdcyyaMD/3V/Jx8sQueRLh2S5xv6puG45ECe8LOoiGAck2eTt3Sxr38V4ftW8m
         P7Td1Red9mFJQgM4QYtSHBoemQk4J4VbhCVn85+NsD9vu44gXy50ofX1zJo6YL/0TYkm
         W/tGy6MhTcc7o5i0s+PXm2iB/zryWiPVHTxxfLXOVr86viRMTtGLdABHKfRJxFGGunxZ
         yxvg==
X-Gm-Message-State: AOJu0YyDHqoWvwHfVaMSjkHnqq2YTd0i9wmv++GxuJEmv53y+Y8sxEN+
	OcDGa1u9l730q+I6jJ4kQWq2pT8fD/omHcMzh07yqqxsY4Nxx12iF/2KU346ewfvFDD0qn7Z97n
	m/aAPLQ==
X-Gm-Gg: AeBDieu95RIAHswbuP0Tme4VbpTceB5zkfwRpGx/LfwiPvgtbbPgu5jkeS+CdSdLNMU
	r1hVP/9I0eq3OoFi0e7O1X+Qx8Crs03gi/jadEN5liqKNdiAP4CGN/bu8qr4p1Ujvc/6mElPqKm
	On8Tpe+4EGTJJVnPXt4iOpMgp/gRg/ia38M0c25n0vDERWQzcLDUKiXSBAV3NKDRMr43YL3jfAS
	MzTd45Jjprwgqn1Cvrf9arl4JxTVIwPW7FESDEQhLLwYLe6EWAdGpgjI3q59Ur08QuGTSX6z9OL
	ILDOON9ntGxWAGXzvYe/17hN68wi+OGfcyBlTpCfQ8S6jOiBWa56JD6cXLWvPFSpswRrvtlHTiO
	efs5elwx/761XkZdFVoOrYBGVctzH3eaFEkjc+J6dUZbdChJiUw4CrsJ5aG8yHkJNjbH87mQSmv
	7G4iAMayK1g0Bv6NQpDYPN1U4GNwE+IQZ920d/1qCihjsY4p8SjQ==
X-Received: by 2002:a17:903:4b50:b0:2b7:beb5:3002 with SMTP id d9443c01a7336-2b9f25957cdmr14512505ad.12.1777690276887;
        Fri, 01 May 2026 19:51:16 -0700 (PDT)
Received: from localhost.localdomain ([2604:3d08:7f7c:ca00:e2f4:7d6f:21ab:4d32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae0e5fasm34400185ad.54.2026.05.01.19.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 19:51:16 -0700 (PDT)
From: Anthony Squires <me@anthonysquires.ca>
To: bitbake-devel@lists.openembedded.org
Cc: Anthony Squires <me@anthonysquires.ca>
Subject: [PATCH] fetch2: reraise IOError during download
Date: Fri,  1 May 2026 19:51:09 -0700
Message-ID: <20260502025109.3466845-1-me@anthonysquires.ca>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 02 May 2026 02:51:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19431

Fixes [YOCTO #16268]

Adds a missing "raise" statement to download that ensures when there is an IOError/OSError that is is correctly reported and not silently discarded.
When an IOError is thrown in this case do_fetch silently passes which then leads to downstream failures in do_unpack when the file doesn't exist.

Signed-off-by: Anthony Squires <me@anthonysquires.ca>
---
 lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 52d5556d3..f7d5dfe9a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1962,6 +1962,7 @@ class Fetch(object):
                 if e.errno in [errno.ESTALE]:
                     logger.error("Stale Error Observed %s." % u)
                     raise ChecksumError("Stale Error Detected")
+                raise
 
             except BBFetchException as e:
                 if isinstance(e, NoChecksumError):

