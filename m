Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36201C433F5
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 11:21:30 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.9110.1636629686094419707
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 03:21:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TXz0wk8h;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id t30so9175812wra.10
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 03:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UShn/SRqyOQyH9EmafrVmaeKidlCpSlAzk8DN+e3Ly8=;
        b=TXz0wk8hRWKIz5KMT2zdVKHr+JKGYJL86J2oO2WuZ/frUIez+75B9kmaH9Rnr7CBH4
         YoWkp1h7g4BuzapZ4ndaD4+WytURzHUOTz3iLkoQEdAJPjRu+GCM8aFQUyOmJGefz3QV
         DihZihkeYm3Buk/dx/y9rhcjpmbDTaE2Nevc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UShn/SRqyOQyH9EmafrVmaeKidlCpSlAzk8DN+e3Ly8=;
        b=z641q5zfmKndLOvwsoKm2ocOV9ChNXkEiPdCrDVDh/zywpTg/KKnqKL15AgRlE6/3l
         NPiDUKeC4aX50lbD5U1p5QXg+ZaY5m0XRcEE+jPpBoH1r+po37TXDAOl2+95jUKC5baP
         nVmL+wtTBBcHCaSpXFzo9fJE0Pyq1tr4+Vcoyv0nGEsD6ScdlIhxYwSSJYu7GMvdszbN
         ngX/ZX7xDKa3RazC19QI+fVUyMlSdxpejlaGCCOdiCsvjVOVAuMF1gK/ZQ8qDmfmBL3w
         5XXkVijM9XXvgpYXWGyReASW7ib9zAcZJV89dvOSRXfmK4BtAtKWUxBJrEB6hzqy+OIN
         5bKg==
X-Gm-Message-State: AOAM530hLOpG82gDUKX/mkXNzvqMfnzIRdr9AV6YwxWDQjGdPrNfMrpD
	hvG9sg2JfM7kOCulaXxPXiccKiMOJRCe0g==
X-Google-Smtp-Source: 
 ABdhPJxxfhAxqxa+fZLQXQuIEfN2ccHRlP3noGc2J4PiTcOM+hO24ECRTLxv7y+IEaeXX06NPMzU4w==
X-Received: by 2002:adf:e747:: with SMTP id c7mr7964185wrn.38.1636629684382;
        Thu, 11 Nov 2021 03:21:24 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:b19:11f4:a3d9:cabc])
        by smtp.gmail.com with ESMTPSA id
 a12sm2573715wrm.62.2021.11.11.03.21.23
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 03:21:24 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch: Add README on fetcher design constraints
Date: Thu, 11 Nov 2021 11:21:23 +0000
Message-Id: <20211111112123.3853646-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 11:21:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13011

There have been requests to better document the contraints of fetcher
design and operation. This README attempts to start that.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/README | 58 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 lib/bb/fetch2/README

diff --git a/lib/bb/fetch2/README b/lib/bb/fetch2/README
new file mode 100644
index 0000000000..eb214709e5
--- /dev/null
+++ b/lib/bb/fetch2/README
@@ -0,0 +1,58 @@
+There are expectations of users of the fetcher code. This file attempts to document
+some of the constraints that are present. Some are obvious, some are less so. It is
+documented in the context of how OE uses it but the API calls are generic.
+
+a) network access for sources is only expected to happen in the do_fetch step.
+   This is not enforced or tested but is required so that we can:
+
+   i) audit the sources used (i.e. for license/manifest reasons) 
+   ii) support offline builds with a suitable cache
+   iii) allow work to continue even with downtime upstream
+   iv) allow for changes upstream in incompatible ways
+   v) allow rebuilding of the software in X years time
+
+b) network access is not expected in do_unpack
+
+c) you can take DL_DIR and use it as a mirror for offline builds
+
+d) access to the network is only made when explicitly configured in recipes
+   (e.g. use of AUTOREV, or use of git tags which change revision)
+
+e) fetcher output is deterministic
+   (i.e. if you fetch configuration XXX now it will match in future exactly in 
+    a clean build with a new DL_DIR)
+   One specific pain point example are git tags. They can be replaced and change
+   so the git fetcher has to resolve them with the network. We use git revisions
+   where possible to avoid this and ensure determinism.
+
+f) network access is expected to work with the standard linux proxy variables
+   so that access behind firewalls works (the fetcher sets these in the 
+   environment but only in the do_fetch tasks)
+
+g) access during parsing has to be minimal, a "git ls-remote" for an AUTOREV 
+   git recipe might be ok but you can't expect to checkout a git tree
+
+h) we need to provide revision information during parsing such that a version
+   for the recipe can be constructed.
+
+i) versions are expected to be able to increase in a way which sorts allowing 
+   package feeds to operate (see PR server required for git revisions to sort)
+
+j) API to query for possible version upgrades of a url is highly desireable to 
+   allow out automated upgrage code to function (it is implied this does always 
+   have network access)
+
+k) Where fixes or changes to behaviour in the fetcher are made, we ask that 
+   test cases are added (run with "bitbake-selftest bb.tests.fetch"). We do 
+   have fairly extensive test coverage of the fetcher as it is the only way
+   to track all of it's corner cases, it still doesn't give entire coverage 
+   though sadly.
+   
+l) If using tools during parse time, they will have to be in ASSUME_PROVIDED
+   in OE's context as we can't build git-native, then parse a recipe and use
+   git to ls-remote.
+
+Not all fetchers support all features, autorev is optional and doesn't make
+sense for some. Upgrade detection means different things in different contexts
+too.
+
-- 
2.32.0


