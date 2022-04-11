Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2BDC63702
	for <webhook@archiver.kernel.org>; Mon, 11 Apr 2022 17:18:01 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.30413.1649690949992998730
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Apr 2022 08:29:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Elq5++sQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id k22so5029492wrd.2
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Apr 2022 08:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NsE/Iw1g6XAWjgiCrTuOPPMl1X6Q0/5cVCudsYstCRQ=;
        b=Elq5++sQ7tLsv4Lf3K9KBDC2Fl60tZQUnHKiE0TlNL398DPAQzUmVCY12P3uHstn8S
         6ApIdw8hiPv71nlgbqoibqKEVsK8SSSakrkp9pP0P0wA/YSfcp+QN/TQvfk2vaZB+Uk9
         R9QjWLxoy+XqcPf/tTqSiT+GtmEWyq+kjFQnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NsE/Iw1g6XAWjgiCrTuOPPMl1X6Q0/5cVCudsYstCRQ=;
        b=5PPss3obO8nNXhI7dCpKMHGJT08KGRPxrR7T4ruVwWcJzt5cADZGO8qPywzav8pXd8
         3Z3sR4Vm1EA8DMRkWpGaMW+kIoE2qA4AnpynGM3bWpUHRbL8pmX0HMkL8nsTl2K+56Ge
         HvSylIZH3eAXuRW/nAsUm18xTekyTOM8ajDsBvA0oCZLFSL0/wLi2QR63N/znQAmp8+Q
         MnY9da476DutV4CPdBt3XRHhKmsfsmCLGUPllNioUmn3FYT3QH3ap4v+nOR/2LC6vAKL
         /Wl7iqc2fuLLIAje2TffTZa5T8Cszbj+p32UiyT8VVzU8ttOkLorHpPPZjDh8Cvy+Nco
         P2EA==
X-Gm-Message-State: AOAM530aBBuVsz7wPCf48U7iZpfrs9OsfdvY3vkIveHxctU2Vkz+azom
	76LWlQ3pJ8PfRjn9E4RR0azVxsLmw+0=
X-Google-Smtp-Source: 
 ABdhPJx/5ZfMNWpgKnjwe4vr/ubprjNmCGA96qEeZaKd6vHdJ3TB4TxESZmNUsPTJi3AfUvicEHOtg==
X-Received: by 2002:adf:f1d1:0:b0:206:1303:ee49 with SMTP id
 z17-20020adff1d1000000b002061303ee49mr25024241wro.533.1649690947770;
        Mon, 11 Apr 2022 08:29:07 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:f8d9:779e:103c:69c3])
        by smtp.gmail.com with ESMTPSA id
 m3-20020a5d6243000000b001e33760776fsm26399441wrv.10.2022.04.11.08.29.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:29:07 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] checksum: Allow spaces in URI filenames
Date: Mon, 11 Apr 2022 16:29:06 +0100
Message-Id: <20220411152906.2086605-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Apr 2022 17:18:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13601

If there are spaces in the URI filenames it can break the code.
We already solved this issue once somewhere else in the code so
use the same regex trick here as well.

We should ultimately refactor this code but at least fix the issue
for now.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/checksum.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
index fb8a77f6ab..557793d366 100644
--- a/lib/bb/checksum.py
+++ b/lib/bb/checksum.py
@@ -11,10 +11,13 @@ import os
 import stat
 import bb.utils
 import logging
+import re
 from bb.cache import MultiProcessCache
 
 logger = logging.getLogger("BitBake.Cache")
 
+filelist_regex = re.compile(r'(?:(?<=:True)|(?<=:False))\s+')
+
 # mtime cache (non-persistent)
 # based upon the assumption that files do not change during bitbake run
 class FileMtimeCache(object):
@@ -109,7 +112,12 @@ class FileChecksumCache(MultiProcessCache):
             return dirchecksums
 
         checksums = []
-        for pth in filelist.split():
+        for pth in filelist_regex.split(filelist):
+            if not pth:
+                continue
+            pth = pth.strip()
+            if not pth:
+                continue
             exist = pth.split(":")[1]
             if exist == "False":
                 continue
-- 
2.32.0


