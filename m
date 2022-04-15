Return-Path: <matt@madison.systems>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AFEC71141
	for <webhook@archiver.kernel.org>; Mon, 18 Apr 2022 14:26:03 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web09.7261.1650029768814189713
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Apr 2022 06:36:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@madison.systems header.s=google header.b=bk9tnmw0;
 spf=pass (domain: madison.systems, ip: 209.85.210.182,
 mailfrom: matt@madison.systems)
Received: by mail-pf1-f182.google.com with SMTP id bo5so7324507pfb.4
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Apr 2022 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=madison.systems; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z/xDLsGqtD/9JF5O80aHbBwgEqxUA0I9kcNcTrMd+WE=;
        b=bk9tnmw0Bp/NpMYxGQhPNHMGEXM7UHT4HrZx7kx8bruI61arxN2P8TNodpdwKYCcQO
         XgQsqMeC9knNefo024MDBU5URQwjx5GaGdu1qtY9QpRrZ4BO5WF0Rn8qtEkuITcamzNi
         86gBSCD2B4a477GaJ0nfKlB5YWn/NFvxc7DSgn5U21TG/O89dgSimst3be4/JlVjURTJ
         1T8Av8LE/hXWyQcN3ZfKSYQgT2eU8ZJaTh8O/jntUP1Z2EjtV8qG5NG/dBDXHPhgNjWd
         5NtjjIS2hRUNIg/EXshnW/99s5fySYAVRdORoDhSHHmNrUIOyJ/eW2pmLf4MMJat2mP4
         nvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z/xDLsGqtD/9JF5O80aHbBwgEqxUA0I9kcNcTrMd+WE=;
        b=IJbVhVRb/4m2CI4FXAarcmvwQX0IJ4YuturJ02Ne9LlNMjj5VztHYAJHFj6430r2F8
         bBPnu1azGmp2C+rOxNus6B+sMQHC1508lSIqQJ7Cn2VAyL9si5u5bGdc2je8q5gaaO+A
         IxcSuZFVnemYJjokdLr1TwRko/PonShLHjr+YqIoa0GD2i7UnxhNCOw/p8IVK51z4er5
         nERB/2mm7PJ9wO43MA9gYFQrVAl1gphEveeM14u/zCN+GthsYNy6sC4b7GzsJGOQ0dXw
         QM4KMBQR7p+8SRmI6AYh76dW3vB8s/Oz00uNJ8n4vW1S+3QP7RyxjjiAU8IMLsynRML8
         Jg2g==
X-Gm-Message-State: AOAM532lU0zfGltPg5X73J/Zy0g2eW5KZuDQixWy5iIrr982b60Pshoq
	kCwE223OnV8VKpg/TTIw4XSab0eBFQnWJtf2
X-Google-Smtp-Source: 
 ABdhPJzODHxxYdL3oD1q5e9dNdAw/PNX3tAdI65g1l24iuHJIOSb2C0IBilC1syykvfPp88ooR8KPQ==
X-Received: by 2002:a65:6e4d:0:b0:39d:a6ce:14dc with SMTP id
 be13-20020a656e4d000000b0039da6ce14dcmr6467507pgb.476.1650029767858;
        Fri, 15 Apr 2022 06:36:07 -0700 (PDT)
Received: from visar.local ([2600:1700:87f0:9cff:abce:437e:de4b:c518])
        by smtp.gmail.com with ESMTPSA id
 k13-20020aa7820d000000b004fa72a52040sm2949165pfi.172.2022.04.15.06.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:36:07 -0700 (PDT)
From: Matt Madison <matt@madison.systems>
To: bitbake-devel@lists.openembedded.org
Cc: Matt Madison <matt@madison.systems>
Subject: [PATCH] providers: use local variable for packages_dynamic pattern
Date: Fri, 15 Apr 2022 06:34:56 -0700
Message-Id: <20220415133456.44233-1-matt@madison.systems>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Apr 2022 14:26:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13633

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
2.32.0


