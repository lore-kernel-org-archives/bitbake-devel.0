Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F506C678D4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 12:48:56 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web11.21954.1677847735438291696
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Mar 2023 04:48:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=oMrBDh0S;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id x3so9699860edb.10
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Mar 2023 04:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677847734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XahEIEeG4pRASHD3hcUExzditsZuZ2w98xVx3sHCN+c=;
        b=oMrBDh0S5m511jF/DliRJPJ4t8/smZpt4HNCu5SYa71QFDVo5dK+9+ROq0AFd4yHAP
         OguelUuF2kwPSWkVRwfH4F3HUNP4DI1XUDcAnXL+h5eTbucUNLg6BZi6m+/JEZSWEQ4y
         xkO578enyW8OdNClYhqe/j7a5jp1W9JStN1oseCIXU6lEb37Phe2u6sdNhFqv4+EIWHl
         CDKtoDg42jySCndVxXm8EheOGtxOwmWbEw6odJD88jcse8yt+giAi19WuivOkEiuKhav
         RcJDvpjcQEEMWkVgmilTeG6mf9FQLGu1hzm1mE5JjlOrb98J7OLUHV6nfqqpNVI/rcjP
         lmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677847734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XahEIEeG4pRASHD3hcUExzditsZuZ2w98xVx3sHCN+c=;
        b=idORA5pwBR7LKWAne7184lTLL9lZdUdOM52ZwJzz2w6bBer9uaQi6L1wO0SxjYZY0y
         oRgBs6MnLsqmdY8taSVHv4YlDZKW9H7xZNgfMGEf09j1LQvEXdMdc6izMpqX88KvjUba
         UEYdaFkgfApFuBglFAXiaS6NgGpipysD2ccPEco8bjKiSbeaZWhh2KdHsGhYl9tdjsJ3
         irOtDFIX+HGL1xzfOOEOv9XNNp36ujftZXZye6lDIXdS9tnExzCS0VRjMwd7FPwLznDt
         Ni+QyfntUPJZQZbmVtZwfLT9lEIrMvqL0WOkyD23xSG/3EC7PKuqGhAMoJdBRyy6Y/8c
         kYxA==
X-Gm-Message-State: AO0yUKWA7fNL+4YsGXhM/V2hq51vqnqjnuVBxnf5/0nlA5ujpJG50Zh9
	orx5u5iqRfyyvkZRzN9x/GDIjBBi2Is=
X-Google-Smtp-Source: AK7set/iYK5V1bIUJvxuLxUjPHb8F0BSEKtxO7dk4o40qWbPs9y95sQG9+R+kcxK/ZfFimxSYh72SA==
X-Received: by 2002:aa7:d513:0:b0:4af:7f6e:297b with SMTP id y19-20020aa7d513000000b004af7f6e297bmr1859884edq.35.1677847733752;
        Fri, 03 Mar 2023 04:48:53 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090685c200b008dcaf24bf77sm915241ejy.36.2023.03.03.04.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 04:48:53 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: khem.raj@gmail.com,
	Martin Jansa <Martin.Jansa@gmail.com>
Subject: [RFC][PATCH] providers.sh: versionVariableMatch: use the name of provided item instead of pn
Date: Fri,  3 Mar 2023 13:48:42 +0100
Message-Id: <20230303124842.2743563-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Mar 2023 12:48:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14521

* when checking for PREFERRED_VERSION and REQUIRED_VERSION use
  the name of the preferred item, not the pn of the provider

* sending as RFC, because there might be some other uses of
  this function where the old behavior was better

* the case where this seems to work incorrectly is meta-clang clang recipe
  which correctly says:

  conf/layer.conf:LLVMVERSION = "15.0.7"
  conf/layer.conf:PREFERRED_PROVIDER_llvm-native = "clang-native"
  recipes-devtools/clang/clang_git.bb:PROVIDES:append:class-native = " llvm-native"

  LLVMVERSION is used by oe-core as:
  meta/conf/distro/include/tcmode-default.inc:LLVMVERSION ?= "15.%"
  meta/conf/distro/include/tcmode-default.inc:PREFERRED_VERSION_llvm = "${LLVMVERSION}"
  meta/conf/distro/include/tcmode-default.inc:PREFERRED_VERSION_llvm-native = "${LLVMVERSION}"
  meta/conf/distro/include/tcmode-default.inc:PREFERRED_VERSION_nativesdk-llvm = "${LLVMVERSION}"

  and now this code will cause a warning about 15.0.7 version not being available
  even when in the end it will use clang-native as a provider with this version:

  $ bitbake-getvar -r llvm-native PV 2>&1 | tee log.bitbake-getvar.llvm-native-4
  WARNING: preferred version 15.0.7 of llvm-native not available (for item llvm-native)
  WARNING: versions of llvm-native available: 15.0.6
  #
  # $PV [4 operations]
  #   set oe-core/meta/conf/bitbake.conf:239
  #     "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[1] or '1.0'}"
  #   set oe-core/meta/conf/documentation.conf:340
  #     [doc] "The version of the recipe. The version is normally extracted from the recipe filename."
  #   set oe-core/meta/classes-global/sstate.bbclass:51
  #     [vardepvalue] "${PV}"
  #   set meta-clang/recipes-devtools/clang/clang.inc:13
  #     "${MAJOR_VER}.${MINOR_VER}.${PATCH_VER}"
  # pre-expansion value:
  #   "${MAJOR_VER}.${MINOR_VER}.${PATCH_VER}"
  PV="15.0.7"

  the problem is that both llvm-native from oe-core and clang-native are
  found as possible providers for item llvm-native, but then we call
  findPreferredProvider for pkg_pn clang-native, we'll check for
  PREFERRED_VERSION_clang_native not PREFERRED_VERSION_llvm-native

  then when running findPreferredProvider for pkg_pn llvm-native
  we find the PREFERRED_VERSION_llvm-native and if it doesn't
  match with PV we issue the warning, be aware that this issue
  is reproducible only when they don't happen to match, e.g. with
  master before:
  https://git.openembedded.org/openembedded-core/commit/?id=7438f9a9efaf0826f1be13acbc51f0a1134cf175
  in dunfell it's triggered as well, with different versions:

  WARNING: preferred version 14.0.3 of llvm-native not available (for item llvm-native)
  WARNING: versions of llvm-native available: 13.0.1

* if we agree that this is something worth changing, then the
  search for available versions should be similarly changed
  as well, because now in dunfell it shows only 13.0.1
  while clang-native-14.0.3 is also available provider for
  it (and actually gets used in the end).

* this might make some sense for llvm-native and clang-native
  but I can imagine counter example when you have 2 very different
  providers for something and you want to control their versions
  independently from which provider is preferred e.g. by MACHINE.conf

* this change didn't cause any new warnings in my builds, but other
  layers might be more creative with P_V/P_P

* alternative solution might be to use different variable name
  in meta-clang/conf/layer.conf to avoid changing llvm-native P_V
  and depend on P_P to always select clang recipes to provide llvm
  which might be less controversial than this P_V behavoir change

  I have a local commit which changes LLVMVERSION to CLANGLLVMVERSION
  in these 3 meta-clang places:
  conf/layer.conf:LLVMVERSION = "14.0.3"
  dynamic-layers/openembedded-layer/recipes-devtools/bcc/bcc_0.24.0.bb:    -DLLVM_PACKAGE_VERSION=${LLVMVERSION} \
  dynamic-layers/openembedded-layer/recipes-devtools/bpftrace/bpftrace_0.14.1.bb:    pvsplit = d.getVar('LLVMVERSION').split('.')

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/providers.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index e11a4637d..1aa0d1282 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -124,8 +124,8 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
     preferred_ver = None
     required = False
 
-    required_v = versionVariableMatch(cfgData, "REQUIRED", pn)
-    preferred_v = versionVariableMatch(cfgData, "PREFERRED", pn)
+    required_v = versionVariableMatch(cfgData, "REQUIRED", item)
+    preferred_v = versionVariableMatch(cfgData, "PREFERRED", item)
 
     itemstr = ""
     if item:
-- 
2.39.2


