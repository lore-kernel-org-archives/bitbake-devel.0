Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30F5C433EF
	for <webhook@archiver.kernel.org>; Mon, 17 Jan 2022 21:56:44 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.4235.1642456604012289042
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Jan 2022 13:56:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Uy0TgHMZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id
 p1-20020a1c7401000000b00345c2d068bdso1061502wmc.3
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Jan 2022 13:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2iONxq/tPxLN5FVoY2PUz1J2alBetEceht9xAq/0jA=;
        b=Uy0TgHMZ3VDprhDylAAQSZGrv0SsDGO75P9rsmD0bd0+wSnGJGFyEdW18+v1Ewl6d3
         Qcft6tQDEz4gPQUoLh9Yrdc7E2FzZJw3GronFzu3SUWvI2pnKYudj4Asnyh2Wzx4VhIv
         Gj1jHOrcdk64pOgLM81C2OnTRk9snlucp8lqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K2iONxq/tPxLN5FVoY2PUz1J2alBetEceht9xAq/0jA=;
        b=JIfkNFXZRPp0EWX6r3YssnglTljsqVC8KWZyEWkLTLmerIxNKl3LnT/x9Z/i2mi7ka
         7YUPd8ocq4PtxB0i4WH9g1Pm2QBu85O5IcWI+dB4OU4M2uA2avMjypDUwbestENWa+wl
         4syZAYl0hVqbr6jWUGJwCd/PhsGhC8s7cZQ/ATHxzkF1Z4t4Kbud5EPSIAFk+bC/hnZ/
         yVFwP0MhIvH1lQfpZbnukxZ7qAxhhypTF+Tey8ZgjUNPt93pcZainu+jcNXu0dKhA+FQ
         AzMlSiR8dgS2iBxYe25P2Ht8AVsWNQFM7OE5MnWRrWLbvgZCscOZ8DLFWe8zEJqTeNIK
         87sA==
X-Gm-Message-State: AOAM530HMfUYoB+WZ3LMB/Swovyc4hln55K/Komy2W0/pLxgXllkQdOQ
	m1h4QrgjobbnZeHN3vK8vONtpmv2DKOPyQ==
X-Google-Smtp-Source: 
 ABdhPJwC3U/cj53oxWg+FDsxSo5+S2akUgP98dwOxRgezOE+mMRqcwQNEvBjPw4iLg/g+jOWu0NdMg==
X-Received: by 2002:a5d:55c7:: with SMTP id i7mr21576304wrw.618.1642456602444;
        Mon, 17 Jan 2022 13:56:42 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:cdb:ba2:df58:76a3])
        by smtp.gmail.com with ESMTPSA id o4sm698455wmq.41.2022.01.17.13.56.42
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 13:56:42 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] doc: Drop BB_STAMP_POLICY/BB_STAMP_WHITELIST
Date: Mon, 17 Jan 2022 21:56:41 +0000
Message-Id: <20220117215641.1870078-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Jan 2022 21:56:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13240

These variables were removed from the codebase, update the docs to match.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../bitbake-user-manual-metadata.rst          |  6 -----
 .../bitbake-user-manual-ref-variables.rst     | 23 -------------------
 2 files changed, 29 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index d802a8d353..8496e1da53 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1921,12 +1921,6 @@ The following list describes related variables:
    Specifies a function BitBake calls that determines whether BitBake
    requires a setscene dependency to be met.
 
--  :term:`BB_STAMP_POLICY`: Defines the mode
-   for comparing timestamps of stamp files.
-
--  :term:`BB_STAMP_WHITELIST`: Lists stamp
-   files that are looked at when the stamp policy is "whitelist".
-
 -  :term:`BB_TASKHASH`: Within an executing task,
    this variable holds the hash of the task as returned by the currently
    enabled signature generator.
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 3160a41ae9..07495f4fb3 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -546,29 +546,6 @@ overview of their function and contents.
       -  *clear* - Queries the source controls system every time. With this
          policy, there is no cache. The "clear" policy is the default.
 
-   :term:`BB_STAMP_POLICY`
-      Defines the mode used for how timestamps of stamp files are compared.
-      You can set the variable to one of the following modes:
-
-      -  *perfile* - Timestamp comparisons are only made between timestamps
-         of a specific recipe. This is the default mode.
-
-      -  *full* - Timestamp comparisons are made for all dependencies.
-
-      -  *whitelist* - Identical to "full" mode except timestamp
-         comparisons are made for recipes listed in the
-         :term:`BB_STAMP_WHITELIST` variable.
-
-      .. note::
-
-         Stamp policies are largely obsolete with the introduction of
-         setscene tasks.
-
-   :term:`BB_STAMP_WHITELIST`
-      Lists files whose stamp file timestamps are compared when the stamp
-      policy mode is set to "whitelist". For information on stamp policies,
-      see the :term:`BB_STAMP_POLICY` variable.
-
    :term:`BB_STRICT_CHECKSUM`
       Sets a more strict checksum mechanism for non-local URLs. Setting
       this variable to a value causes BitBake to report an error if it
-- 
2.32.0


