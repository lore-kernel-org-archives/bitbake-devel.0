Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F893C61DE2
	for <webhook@archiver.kernel.org>; Mon, 31 Aug 2026 02:12:39 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21069.1788142355184997077
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 30 Aug 2026 19:12:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TLCZneJi;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90cd7ad71a9so39260526d6.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 30 Aug 2026 19:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788142354; x=1788747154; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EvkX6pAN78HXVqLNw5QsVVCER8Wim0MykhfoUK/Xgaw=;
        b=TLCZneJiAf4vzoHeTgqfJ8Q0XOUmUmMm1O3lT41r6Wb6qm5guSusqQCJazcBWchgRF
         3iZ0hYy6oCk8oLCIc+vOTPDjWMa+l8olbvgAAGuHYEosWMnXnathJzRBdlUoKoA933+2
         oGXCBH+jvMVF1fkwwqPmfMiovgPirTOmFiD8rOlFTZGCPNVGIxFvaE3tlxwWTST+VWP6
         IeYhHxAjEp12vVcArJA3C/TaHk1D9yd+g2nB+/xhDntmEwEzKQozrazLGo64bMyPDpRY
         tiuv+u2X69gZOUzqqz/FlN6mBJ5+tjf6p6Dwyw4UsMdut4E2jxb0e9Ujs/ZEbfXbgB+d
         hQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788142354; x=1788747154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EvkX6pAN78HXVqLNw5QsVVCER8Wim0MykhfoUK/Xgaw=;
        b=aY8kvFq6q+ObQS5iumNWq44rd+JasgaCCppWSbbsJK9ifxL5nnwmVHcugJD5uZMcLD
         +mYE3seA+Dvmg4rXlg/GO6Hvi2snUyHqub79E18MMGISRV7cwOW2/GCRvBaVEImPLfSm
         DfVMD2F46lGqv+AMPwB+qugUAtj6B1fvurRRbio+aSpwZ1T7SFlKsthZ9eDfAoQNLaDE
         gXsXAK0EiZpTeIPKKz9zXNPInuBMXtl/N1/DmPYGzpuWrD4XiPs9TYoSmjJZ1mXXeIv4
         S11TjqIY76jMRAvi5zZhGWTcYfJaDpgebh9PBiUdw0T/XWVqcx+ZapSYhzRXkCwCtY8e
         g7TQ==
X-Gm-Message-State: AFuF++lhkRC5hNkTRClkh9HYKBsFRQle8Zs6Vgs3tlJpo6uE5xbcM1lw
	km8BPNcenyiN/oKWkclilj+TFXpi4FAFYc2Tdyck9A8ftGw93ebTrX4H
X-Gm-Gg: AYBFou2ik7ncGw/40dPA5IIJuqSmCWXWPRDmmrWKSzh8E76nBXw+FqZz4R81RLoPkmB
	sYCixdwMoZDYd5rgNCZS6NMzoC9Ycnd1IfclOakN/GadTqO9juhfhpFz2g5hcSbuqrAgRwUf4eF
	Nnp8Irw2QwMoNALThgGcPEy/QnG4WCf3Ev4McGSzHqvmTF4oXsjZ8qsE89vrQC8pUwmX2dO+fZj
	7s7HwywgCNR+fVLEqmWaakr10wUiHnYxcYzTi51k+o4Pe+nI6tLnJHi6PIlQqSnBCSLTvrzq/kz
	zKswAZDn6VCrat0Too/VWT2GhHK9qbZqObw1UQYxTuN1B3+Szrz2qLkONsv2qsOCtjnQPzSOZS9
	1QekzzPvn3/cyiKSKxzqaisvF3FAyOrOYIpUTiJ8KdL9oGnCNyylMOCMwMPKtlHwtQnJlXcwRzi
	7JjXXyVPIrT7UJVmSIjwZ/XAEoBWJ7DXHT9kdyWw/dbd3tQrnu9OLqAvto9kQODQY+/cd8wuYc7
	rr60aeRk5jGzW/5NvxSlqkFxpZzzg==
X-Received: by 2002:a05:6214:588b:b0:90e:7e02:cc42 with SMTP id 6a1803df08f44-90e7e02cef4mr157530996d6.23.1788142353919;
        Sun, 30 Aug 2026 19:12:33 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce444db01sm73848066d6.7.2026.08.30.19.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 19:12:33 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: docs@lists.yoctoproject.org
Cc: bitbake-devel@lists.openembedded.org
Subject: [PATCH] doc: quote the value in the named-checksum example
Date: Sun, 30 Aug 2026 22:12:29 -0400
Message-ID: <20260831021229.4063996-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 31 Aug 2026 02:12:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20130

BitBake requires a quoted value.

AI-Generated: codex/claude opus 5 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index b96018a4edcf..476672bbb95b 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -123,7 +123,7 @@ in the previous example, or you can name the URLs. The following syntax
 shows how you name the URIs::
 
    SRC_URI = "http://example.com/foobar.tar.bz2;name=foo"
-   SRC_URI[foo.md5sum] = 4a8e0f237e961fd7785d19d07fdb994d
+   SRC_URI[foo.md5sum] = "4a8e0f237e961fd7785d19d07fdb994d"
 
 After a file has been downloaded and
 has had its checksum checked, a ".done" stamp is placed in :term:`DL_DIR`.
-- 
2.50.0.173.g8b6f19ccfc3a


