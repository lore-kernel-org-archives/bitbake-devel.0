Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8BFC54F3F
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:45 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web12.33108.1649066394503930035
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Apr 2022 02:59:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QGCvc4OC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id r13so13599284wrr.9
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Apr 2022 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBAE4CtS7IQDvEKtFDUbelu7KpZAjtsW/vHa9pfM2jo=;
        b=QGCvc4OCMyPPRaRGg+x7MRlP5p1NVr2W6JnKvjbcYnnPMmolE+JE+5Rp8k+41Dt9ua
         S4jyMarJlLrpzKs7oXI6gRbt6YBDhbRKyZqVCqqy2372t1ThCeeIt4pA3uDxxjMFsZFy
         cQs8iUZu08GXz7hE4vlCpmLRtWI7MGKWOBVkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBAE4CtS7IQDvEKtFDUbelu7KpZAjtsW/vHa9pfM2jo=;
        b=RbxGHgigBuILpuymDq/KM8/ort+Wh/IUH38XBxfEE4QnUc8kcQfGqypwqqMH2gw8kL
         JLrX+RIzrwyqngsJ0QuhRlJEBoJAYlRCdeLwSFDpkEx4oTxudznel+z1ausIXxETRoED
         tOdWdL/sIvjti7FGcSN8U6xRXP0whpabgaXIn3rpxLWFRXeSoE+HgyP7b25anWvIKQyn
         aGQtsT8wOaefgqKu8ROj5J7U8AUkxsc1F+KRusJUU47grwcYENwP2jL06JlrC5R5JhvT
         sgz6nSJ5/OHJqaNica/ru08x3OTeQkuOYOeaBTJFTbEe9hoAXpWV0vSqTsIURqj3nUps
         KFlQ==
X-Gm-Message-State: AOAM530VrfQ6aTcms/oNh9oWhFdX7di3usNkrGJs7b0uIfGNuwrnulpT
	a2mYMDGZW+t0tT08Y2apm+uj0QxzP3ELo6HG
X-Google-Smtp-Source: 
 ABdhPJxk3TStdhK81wNGk7RBI/GsrwiKxT2NpgV1QoglDunu+FyT43LnC0bP7iTmmWKRSd/vV5mOjA==
X-Received: by 2002:a5d:6152:0:b0:205:bcf3:2cc with SMTP id
 y18-20020a5d6152000000b00205bcf302ccmr16994876wrt.158.1649066392579;
        Mon, 04 Apr 2022 02:59:52 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:4552:8cb0:e722:b501])
        by smtp.gmail.com with ESMTPSA id
 f1-20020a1c6a01000000b0038c9f6a3634sm16502617wmc.7.2022.04.04.02.59.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 02:59:51 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data: Fix accidentally added parameter
Date: Mon,  4 Apr 2022 10:59:50 +0100
Message-Id: <20220404095950.1723753-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Apr 2022 18:46:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13576

This was only meant to be added for the handle_contains function in
a previous commit, fix it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 363901b5d3..62ec214762 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -329,7 +329,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars, d):
                 deps = deps | (keys & parser.execs) | (keys & parsedvar.execs)
                 value = handle_contains(value, parsedvar.contains, exclusions, d)
                 if hasattr(parsedvar, "removes"):
-                    value = handle_remove(value, deps, parsedvar.removes, varflags, d)
+                    value = handle_remove(value, deps, parsedvar.removes, d)
             if vardeps is None:
                 parser.log.flush()
             if "prefuncs" in varflags:
-- 
2.32.0


