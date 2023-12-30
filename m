Return-Path: <alex.kiernan@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243DBC46CD2
	for <webhook@archiver.kernel.org>; Sat, 30 Dec 2023 15:48:56 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web11.186663.1703951329511139014
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 30 Dec 2023 07:48:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VL1Z6LWV;
 spf=pass (domain: gmail.com, ip: 209.85.167.49, mailfrom: alex.kiernan@gmail.com)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e7e1ddaddso5317039e87.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 30 Dec 2023 07:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703951327; x=1704556127; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMja2nan5IeD4gmQmRBPzqwbnryogSK7Vm5xpOHgYfo=;
        b=VL1Z6LWVxiSdIqMm5rM66tRamwPbW7BZjMalla8sk69uyVsani1NdXN1Zh0qbDI2cs
         +aimqfZnfV673ScnVT+t12qVryeIxla0jKNoknRHhRoZRMoeXcJPFPvUYU3eSpH5vAW0
         R9SN7UBQ9gjyg7SO2dyXtE4j+6wTo3iLfykOdM0c6k+9YYdnywMNgMMBz/MG2E/ivHsd
         oTIWUU85H/E/xubBwRNphyWau/zPWO4ChL6QtQX99gPqMhdA6PdRacR1tMc9PiEEpYkO
         1/AoCmGaxZu9v2ozZKY+R9m+iTtc6R6NdL5DRVdliPQ0hweFBQeY/Zt4/x+MsytcH/7x
         qiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703951327; x=1704556127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMja2nan5IeD4gmQmRBPzqwbnryogSK7Vm5xpOHgYfo=;
        b=jVfk2VpGYREUZw5EnY/2cnXZFo2vXK6oLBXvLB/C4PNT690WtP3IgY9fDn817rgQGT
         1G8RO76/0eIvqagTocTNllbYI4laULObDG80l9BItVZHoyEcjFigGCzaw46Q4Ia4beDY
         PJzPdFIQTiL8CuarolasLbuaIHYmFSsc58yL//RRMgjEwqf1MVdDIlm8PBLlx06jNVcm
         BsfwhZFM57kyJSPxv4JqhG3wtil7Th+SSoOmkCTvkD20u3AEG+lN9dfGXRacx9bHDV+W
         DIwlb7AdqvCA6J4naaWZxFp5RmFoETs/2ah/ghHKI7TlTYILMDkHIgezRTyxHnfEMaHE
         72fA==
X-Gm-Message-State: AOJu0YxGGGOHSvuyvigIIariACGCz8jroXiFqGc6ZQS7h0ZsGBt45MHT
	KR8aIx6KA2XAncDBCiCFt5AtTNiZwhM=
X-Google-Smtp-Source: AGHT+IGAcdwyaOi7oVRLWvg4fXcoApGuoXAZ0oCIva7g9dKN3Di8mhqoCzcgoBmb8fmLXkDAqD/3Jg==
X-Received: by 2002:ac2:4303:0:b0:50e:7d72:1f2f with SMTP id l3-20020ac24303000000b0050e7d721f2fmr3658831lfh.102.1703951326721;
        Sat, 30 Dec 2023 07:48:46 -0800 (PST)
Received: from Zuma-000004PC.lan (cust18-dsl93-89-130.idnet.net. [93.89.130.18])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05600c1e0e00b0040c6ab53cd2sm35343722wmb.10.2023.12.30.07.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 07:48:46 -0800 (PST)
From: Alex Kiernan <alex.kiernan@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alex Kiernan <alex.kiernan@gmail.com>
Subject: [bitbake-devel][PATCH] fetch2/crate: Unpack into CARGO_VENDORING_DIRECTORY
Date: Sat, 30 Dec 2023 15:48:43 +0000
Message-Id: <20231230154843.8086-1-alex.kiernan@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 30 Dec 2023 15:48:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15727

The vendor directory is set in cargo_common, to work with rust 1.75.0 we
need to change the location, so use CARGO_VENDORING_DIRECTORY here.
Signed-off-by: Alex Kiernan <alex.kiernan@gmail.com>
---
Is this change allowed, or am I coupling repos in a bad way and should
hardcode `registry/src` (which is what I need it to be) here instead?

 bitbake/lib/bb/fetch2/crate.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/crate.py b/bitbake/lib/bb/fetch2/crate.py
index 01d49435c3e8..06963294ef35 100644
--- a/bitbake/lib/bb/fetch2/crate.py
+++ b/bitbake/lib/bb/fetch2/crate.py
@@ -23,8 +23,8 @@ class Crate(Wget):
 
     """Class to fetch crates via wget"""
 
-    def _cargo_bitbake_path(self, rootdir):
-        return os.path.join(rootdir, "cargo_home", "bitbake")
+    def _cargo_bitbake_path(self, d):
+        return d.getVar('CARGO_VENDORING_DIRECTORY')
 
     def supports(self, ud, d):
         """
@@ -103,7 +103,7 @@ class Crate(Wget):
             cmd = "tar -xz --no-same-owner -f %s" % thefile
             ud.unpack_tracer.unpack("crate-extract", rootdir)
         else:
-            cargo_bitbake = self._cargo_bitbake_path(rootdir)
+            cargo_bitbake = self._cargo_bitbake_path(d)
             ud.unpack_tracer.unpack("cargo-extract", cargo_bitbake)
 
             cmd = "tar -xz --no-same-owner -f %s -C %s" % (thefile, cargo_bitbake)
@@ -134,7 +134,7 @@ class Crate(Wget):
         # if we have metadata to write out..
         if len(metadata) > 0:
             cratepath = os.path.splitext(os.path.basename(thefile))[0]
-            bbpath = self._cargo_bitbake_path(rootdir)
+            bbpath = self._cargo_bitbake_path(d)
             mdfile = '.cargo-checksum.json'
             mdpath = os.path.join(bbpath, cratepath, mdfile)
             with open(mdpath, "w") as f:
-- 
2.39.0


