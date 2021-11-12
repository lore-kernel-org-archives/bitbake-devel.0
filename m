Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1459C433F5
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 10:44:41 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.14199.1636713880459330905
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Nov 2021 02:44:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Y+4olxz3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id
 77-20020a1c0450000000b0033123de3425so9508581wme.0
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Nov 2021 02:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rLpt/3me/eNYXqjUMSB34q3p6YSPqI1b5sk8hg28HkI=;
        b=Y+4olxz3uDVq8PtY64JgrKkcG2BygmVW1MNaqwjeejfH+LaLCVM+h+4915RIdVLC1d
         pSQlRiiaggBfeEpiMfoazwGDwXkt2Y1aLIT46mca1m59/HAuwXkRoNf6muid6RH0X3qp
         WaXsFEe1luDU5C8BWj1oLoNk6L1Zi7XqSANG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rLpt/3me/eNYXqjUMSB34q3p6YSPqI1b5sk8hg28HkI=;
        b=oTaRVPXSKnOcvmXZV0svw2OHj4dJBkY6kbjEXQzE+cExGBz68EfkEOEGZ9N/K6P8SM
         f1NSg9cxiazypB2d32sujvSZ5MD4AWKk6rdbwAz4fPcTmeBdBMiqnPGr0/hT5SgIPNSI
         onreIWIeFvqO3nk5rf0bYECzNmX2wMpDlEsNW9pEojmFlmQYrx8ZwNEZp0FlJgxlxo3e
         +3XiMoQhGkVqyMqI9zAHEVQnY6/HJ7jRoqetMcNRn26OJjIQfuHJOR+ZVTjPl9M/xjUU
         mUdLxpX+Pj8TPE4bxVy3Z1Qlet2eDwyBdINg9q9wPIsf8+FuKt6RK7iUrDvaBYDV7vaE
         Lkig==
X-Gm-Message-State: AOAM531s+76z98xNj9F0dIUURz9flDahnrarUi4UR2fTjac36etmT1iu
	fMK3HK3GCwa0xUmHURS10biaql21rtTP5w==
X-Google-Smtp-Source: 
 ABdhPJwpv//7iaWIJOq98NPIrSXpZWIUkb16G84xuq2UHoYQTJFqm7EM1WnLC+K3rMpvXPzfwRa4GQ==
X-Received: by 2002:a1c:2b81:: with SMTP id
 r123mr17086380wmr.136.1636713878720;
        Fri, 12 Nov 2021 02:44:38 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:c0bd:72b4:105a:2914])
        by smtp.gmail.com with ESMTPSA id
 x21sm11091346wmc.14.2021.11.12.02.44.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 02:44:38 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Fix task-depends.dot for multiconfig targets
Date: Fri, 12 Nov 2021 10:44:37 +0000
Message-Id: <20211112104437.3890014-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Nov 2021 10:44:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13033

The right hand side of dependencies in the task dependency file generated
by bitbake -g was missing multiconfig prefixes, corrupting the data. Fix
this.

[YOCTO #14621]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index b2d8bbdbac..08e45e79d0 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -814,7 +814,9 @@ class BBCooker:
             for dep in rq.rqdata.runtaskentries[tid].depends:
                 (depmc, depfn, _, deptaskfn) = bb.runqueue.split_tid_mcfn(dep)
                 deppn = self.recipecaches[depmc].pkg_fn[deptaskfn]
-                depend_tree["tdepends"][dotname].append("%s.%s" % (deppn, bb.runqueue.taskname_from_tid(dep)))
+                if depmc:
+                    depmc = "mc:" + depmc + ":"
+                depend_tree["tdepends"][dotname].append("%s%s.%s" % (depmc, deppn, bb.runqueue.taskname_from_tid(dep)))
             if taskfn not in seen_fns:
                 seen_fns.append(taskfn)
                 packages = []
-- 
2.32.0


