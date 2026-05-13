Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB50CD4F24
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 14:46:35 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9357.1778683589066072887
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 May 2026 07:46:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=fOySvTaQ;
 spf=pass (domain: gmail.com, ip: 209.85.210.51, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dd73b7c757so3901269a34.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778683588; x=1779288388; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=blrZwbB4n8B123lrb2w1tKQq+Lxt4y1v30xRqsuBOdA=;
        b=fOySvTaQsxLx2E3l3NjQh7BOfP9l3SA1MxVyVEX7sDc+02eU7XeYv+MHwGWuNYUU16
         rzNSNLVOcawjUQn8NNQWGCDHtjOzfBoEoZJbsb8xy9BUnFvXhj3E2EWh1vea4lpMp/Fa
         4JxwKFDRKuxApSibYjBoSnd3YzQUmcLngaljzRXDqCBcWK1NTlRMdJGRlYU7SW6kUQLl
         AMxuBMzWOPmoeyHMm7MiuMPSvPD8AizS3Mo5jC6VpAQGZ6RF4vuVvOB58f9DTziKZ5YI
         a/pgDcrW+86QFYypwZd3QW183V1ou8T+BLeXWTX9O2Tvmup7KozW4N2P3BDv/ausMCba
         0J1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778683588; x=1779288388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blrZwbB4n8B123lrb2w1tKQq+Lxt4y1v30xRqsuBOdA=;
        b=JDROJyV85KKpCush7CxIVoPyCDGzyViHeE1pa3Wz/ElNvgzQYliVy7hXnSLuJGwXVn
         bxABVqkl8/9SbmVij8TInULxyzZho6S78cNV9gfVCyMq2iv9lLD9DjV0zvjXtVcFOFrr
         1z0J95pcSCm2rEnPqT0i2VQtTEkPxgtvsvXXq6hEs4Fv6Uk3evyqVtZ3pL7LPXJdMOa/
         LH8axpEye528F8jCRG1kUkSSIh2h2f6rrlXeQr843ZKVKbeGxaSeq7Ge1q3SnT2zZEl7
         okcmZ1csrMtw1Y22r8sv0aVRFsllwTM7zJvoK1VOw/B8f93+H1Qhbn0Sj0Tzzq94KIqX
         DcLg==
X-Gm-Message-State: AOJu0YyR2iI0CqgSBrrXPVrwr3DCzpiKUZwMTb1tImhjJFVKbovLC0eR
	CYBbOd7kjJeW4F1vbH/S4yuNowckghHaIwpKOFlzPQ60gNZWshGSmVKv6ptR6Hp8
X-Gm-Gg: Acq92OHS4SfzlQI/oV10AIkN9nX6ys+90B/o2SBtgHSCRbbOPqszmKON755ABCNkt62
	3bFyw5E/342frGf+E0VI4PZFT8vkULn9Exn9HBVf/Bghc2k7DAZNQJsCyJc7my73ROoDycZ+Z3w
	7DiOTbGHo7jfCsrf7U0ENsaV994HnP6pe0eN8s8HKRAd0E0brhFVkpbW9nj1mLgNDV02j7k26CQ
	Ehil2R7+nCqV0z1tfUsspABDZMeoOWMaRy8OruVfCtFhuEf2lV6HQqNCKDikBdbFXrmuP9kA82b
	EKbpYq0xGVOdWrataScKA+J/yqRZODdF+m5EkhRV7XS1hU020LRcqmrzGAhgZamVpuaaKPUMefV
	APY2MvoKLuxP5KtU9rOlDobVUyLOTMVkfg7GOAbQIkV3cny5tHKCA6CjR++ZrIqHrL+/ZTyDRWN
	nrMZ8Mel8SiwuBoRWJRAja
X-Received: by 2002:a05:6830:d01:b0:7e1:cbe3:bb1b with SMTP id 46e09a7af769-7e3d9d1280cmr2128913a34.0.1778683588050;
        Wed, 13 May 2026 07:46:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::c552])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367c055dcsm10645661a34.11.2026.05.13.07.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 07:46:27 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] fetch: Upgrade shown checksum to SHA-512
Date: Wed, 13 May 2026 08:46:21 -0600
Message-ID: <20260513144621.440431-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 14:46:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19513

Regulatory standards for Software Bill of Materials like BSI TR-03183
[1] are requiring SHA 512 as the minimum checksum for validation.
Upgrade the checksum suggested by the bitbake fetcher to align with this
requirement.

Note that the checker has allowed SHA 512 as the checksum for some time
now, this only changes the checksum that is suggested by tooling.

[1]: https://www.bsi.bund.de/EN/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/Technische-Richtlinien/TR-nach-Thema-sortiert/tr03183/TR-03183_node.html

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f7d5dfe9a..1e78c4fda 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -35,7 +35,7 @@ _revisions_cache = bb.checksum.RevisionsCache()
 logger = logging.getLogger("BitBake.Fetcher")
 
 CHECKSUM_LIST = [ "goh1", "md5", "sha256", "sha1", "sha384", "sha512" ]
-SHOWN_CHECKSUM_LIST = ["sha256"]
+SHOWN_CHECKSUM_LIST = ["sha256", "sha512"]
 
 class BBFetchException(Exception):
     """Class all fetch exceptions inherit from"""
-- 
2.54.0


