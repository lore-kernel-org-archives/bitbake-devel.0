Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
 by mx.groups.io with SMTP id smtpd.web11.393.1591058400205341620
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 17:40:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=g93GoUkU;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.194, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f194.google.com with SMTP id t7so629486plr.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 17:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=CkDFvmX+293dFC2ING/tPoZ0cbd7XEmSdVkGCt6ZPR0=;
        b=g93GoUkUD2h43pKZzkEmEn2lgg72F6SmHegg2bh+eJ/+HiCVHItMbfpJ0nbo8+QkwR
         OROlPAX4GPA4zXSz4L+49DrPqkOgQYHb8Ja4Qnw3uvW7ndxh9zWE+GWtyqnmzyKsLwC+
         4otrpVLTlTGscxE5c/GWI711eacUbKBtDZy2NTeO3n+jg5yPOovwFSZ5IQ65wQR7/KDI
         vKFFI33qMaV9UEM69xjuN7CqtpUWharPQUVCxv0FjQNdK4k4FwSYR+WkKt3tyRfi9/za
         VKWBu6fAQvQ3+K0CK5pHpb26WI8nmmVWahbWAVsOBX/8LMFb0IXMNQxqYV6+scBx8yVg
         dH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=CkDFvmX+293dFC2ING/tPoZ0cbd7XEmSdVkGCt6ZPR0=;
        b=lCCJcL7YomvO34XHLEoMrlgof+6Ei63Qx9tHvRQltghu7z1ztcJAtHLQhM+2dwHUUn
         oJtaJpvFD/Z9rxxbdkXm2pZjiH8InUvfl/ELs44NiuZsoJDid7aFJcyuHGudeF/H8SQv
         CUQUbpPbfD1TWQgZ1bqnUJnT3VOuwmDM/EERgIJRtEyRCzgaxVVjgumMyRAIcZ8v0lb9
         sjXUcV1u3O4w/TsEDBkGB+ulwtpqicv8Wa+ejcdRBBcS5Q7gdOlo3DBZOveRttbRwTlf
         BWbJUoITigwHI6Wo9YDJBWJQ/xz38wEAmbAQ18vG55+FYGGrP9+ysODnBFBni4+rrkPJ
         ls+Q==
X-Gm-Message-State: AOAM530iKHmplYJF9YD4NGeO/NgMnT6aaDN/pCG9w8eH6wXfwU39MCVT
	yYKPM7iFiIgIEUJDeB9SmFXIiAJjnI4=
X-Google-Smtp-Source: ABdhPJyyHmCbPOL07nXYtAQTyEiHJkpEMtg52Vz0VQ8nElPeGXO+umUOtu+fJAnbzYIqxFq8n0jyGg==
X-Received: by 2002:a17:90b:ed5:: with SMTP id gz21mr2248013pjb.214.1591058399310;
        Mon, 01 Jun 2020 17:39:59 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id l187sm465729pfl.218.2020.06.01.17.39.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 17:39:58 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 3/6] doc: Clarify how task dependencies relate to RDEPENDS
Date: Mon,  1 Jun 2020 14:39:33 -1000
Message-Id: <e4695176ffdc5eb959f71a08f77ff6a8e028ffa9.1591058197.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1591058197.git.steve@sakoman.com>
References: <cover.1591058197.git.steve@sakoman.com>

From: Jacob Kroon <jacob.kroon@gmail.com>

Clarify that BitBake knows how to map entries defined in the runtime
dependency namespace back to build-time dependencies (recipes) in
which tasks are defined.

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit caf422435ad64aacbdab8a94da3115599dd0938b)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.xml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index 10b58835..95a8b95b 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -2526,6 +2526,9 @@
                 In the previous example, the <filename>do_packagedata</filename>
                 task of each item in <filename>RDEPENDS</filename> must have
                 completed before <filename>do_package_qa</filename> can execute.
+                Although <filename>RDEPENDS</filename> contains entries from the
+                runtime dependency namespace, BitBake knows how to map them back
+                to the build-time dependency namespace, in which the tasks are defined.
             </para>
         </section>
 
-- 
2.17.1

