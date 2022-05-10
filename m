Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926F4C4332F
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:13 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web12.672.1652205964184979817
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=e0zeZbOG;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.48,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f48.google.com with SMTP id n10so5456836pjh.5
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BxMol2vX9GjIBuSNrp5XFKlVRAgFrMFTQ/D0MD7iftQ=;
        b=e0zeZbOGACT/7DTu0CWd931leMUg9WDe0uGbseb4B71PObDbBZhu++3GOO+x6UYMK8
         oCgch5TvcA7gsfEhDVU39hxeP4vNMm0gf54cpwyF0DVnanjO1cR2qOM890w1sa/LY3Gv
         eISJfPkmJVeUogjV3Kej83uoBiR3UUM35qwuaVAUzzYQYgKQx0fD00NX7B52lk0GX/lb
         JKa9RFxHDTraJVQshAq2FjMUKDbhDn+Brsxb9qqntEuIu9ymbfqu7Ax84CUTrmzpVI0t
         zVZGDZunruQOknIS7F3gFXqAY6cXaREkQlFn9CUBVaTYC0crBpddvFCiM1nm1Xyb7ZzG
         EGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BxMol2vX9GjIBuSNrp5XFKlVRAgFrMFTQ/D0MD7iftQ=;
        b=Z/X2x4ehAQGt9mv+PlOyBaA+iHW3xaf/mpffjJgxqNgE8uVAb9qIMjIW6KsP+bg5hi
         EVLVRycv9rmtRJ0OUuV7nZ+MOGjuN39wVMvRThr4/uisZ6su0RL6KktGcHp38H6a8N1d
         ZKrPJmFuJUD6zNNKEKslRtNxpRUvLtXwgN9eKlvZdSighy004bbIJYNlyrNWcBk8ekZ+
         FzpWDi7bDjZ2k3Ht6ud/9zgGcuZB14hiYxClNrcB8TqQXK0fAE4PeceWpO8IfpVy4Hxb
         4/X5B7nKuwwihToCfM2JjH8sRLV5aZPrze+cvXGCc8xI3XjfYnWOTb2kvThutlqF8Aoe
         mJeQ==
X-Gm-Message-State: AOAM531bc+75UeDdfnAOUJJ37u6E5FqHwp7nFxkV+JumA7gIFEfdNuiZ
	VEZanqLVi5k2BscqzQsHPFx221GF8McPGEyN
X-Google-Smtp-Source: 
 ABdhPJy2ibtw5rlWBU1usocjo2wozmNrd+nPv1O5Pmz1gqiBlOOoKoAs8Wy5FYce30077UAsjH4C/g==
X-Received: by 2002:a17:902:b094:b0:15c:dee8:74c8 with SMTP id
 p20-20020a170902b09400b0015cdee874c8mr21368339plr.6.1652205962872;
        Tue, 10 May 2022 11:06:02 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:02 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 01/18] providers: use local variable
 for packages_dynamic pattern
Date: Tue, 10 May 2022 08:05:26 -1000
Message-Id: 
 <4fddb0c9ef344d73b10fd9491a39f4c36e3094b1.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13681

From: Matt Madison <matt@madison.systems>

During parsing, Python raises

   RuntimeError: dictionary changed size during iteration

in getRuntimeProviders, if you happen to have a recipe
with an explicit RDEPENDS on a dynamic package containing a '+'
character, such as 'gtk+3-locale-en'.

This is because we're using the modified pattern as the
key into the packages_dynamic dict to append to rproviders,
and since that key doesn't exist, the dict is getting modified
to add a new, empty, entry for it. So even without the runtime
error, we'd be generating an incorrect result.

Fix this by using a local variable for modifying the pattern
and using the original key to retrieve the value on a match.

Signed-off-by: Matt Madison <matt@madison.systems>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 07de375c3e57f17ab7b47569186f24ecd9896825)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/providers.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index 8c1c31a5..e11a4637 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -396,8 +396,8 @@ def getRuntimeProviders(dataCache, rdepend):
         return rproviders
 
     # Only search dynamic packages if we can't find anything in other variables
-    for pattern in dataCache.packages_dynamic:
-        pattern = pattern.replace(r'+', r"\+")
+    for pat_key in dataCache.packages_dynamic:
+        pattern = pat_key.replace(r'+', r"\+")
         if pattern in regexp_cache:
             regexp = regexp_cache[pattern]
         else:
@@ -408,7 +408,7 @@ def getRuntimeProviders(dataCache, rdepend):
                 raise
             regexp_cache[pattern] = regexp
         if regexp.match(rdepend):
-            rproviders += dataCache.packages_dynamic[pattern]
+            rproviders += dataCache.packages_dynamic[pat_key]
             logger.debug("Assuming %s is a dynamic package, but it may not exist" % rdepend)
 
     return rproviders
-- 
2.25.1


