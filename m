Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web10.7721.1593486534428322295
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2020 20:08:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=Gp1OEs4i;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.179, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f179.google.com with SMTP id l63so9236395pge.12
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2020 20:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9kUqA0oI3SCJt7hlAWo/zTMPNkVMClfdroBBi3sKMJY=;
        b=Gp1OEs4iHeKIksiwVLL0i6MZc5eAbK8dEWh9lYalqSkgx6HRkYniwMC08TpsE91RXH
         wB14mMFzpZ2f8tbVYoV31udfn6/v7AyJbgc/NiP3q9XMcie2ceFSuvGNdvddJi8HOyAX
         85zvNrF4tyM8KcBpdJZkiDTjQSsqqEmZtTcatB+lm52IlnbgGfq9m36+fgq/u+E8RKXD
         eFQzeoEPJQlBnsE87zU4HTI44iN+txhUNc1KtKDhsMD2RSZ4pXnaL80iNfHr9+tO9egg
         ZXe+O3uPgN9zCjEEAwaDmHlQvLuFB8K2eLUEHaJBiztOJrT5jpfwsVNkTrV8Q9TWZDSn
         eKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=9kUqA0oI3SCJt7hlAWo/zTMPNkVMClfdroBBi3sKMJY=;
        b=ftjcSmGajMUWA+rj+70hDeFBwr4bkU6YrE4CPdOZWXyvuRrkjK/isPOhaEzwtLgIGP
         XXSy2SCE3w+GaFMnmvbKiAzciEEcmh7mpz7tLyfFvOmA3lrABzPpSnPJ+8MExb3AVjmP
         mfspUBB7igilka/fvkLxkdfujpoAxKIvgwIZN6sXgw8oNttiRLBnujFvyLBb8yU+ElSf
         5CwP2Etoi/Qc7YjrZn5JKL6lZYTL/lAfTnpmoQPSpS3EvSut9FHfCiVZn608qobBoVNx
         nqTN5ymgkOsqwWoYuJmPHdZEq45NgV/cHZRMdeiDGGz067Z8uDVrKFNl4qMS8BT8o8jV
         GdsA==
X-Gm-Message-State: AOAM533MUeGlE6AjEswLELjYpnnlYxnqW+Bx+eXtHs1+Ib7pS5k+Hzw2
	d4CpRjWIdReKn+9BmjtbRRmAzr25Z55zsA==
X-Google-Smtp-Source: ABdhPJwGYApqSNAyamTsFHzNTidMcB/Rky0OgPY9YSooZa38HiUkYrfncBRaQlnqrB3uCZB3HtVzPQ==
X-Received: by 2002:a63:2b93:: with SMTP id r141mr13018574pgr.171.1593486533399;
        Mon, 29 Jun 2020 20:08:53 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com ([99.197.43.113])
        by smtp.gmail.com with ESMTPSA id n14sm970933pgd.78.2020.06.29.20.08.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 20:08:52 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/6] taskdata: Improve handling of regex in ASSUME_PROVIDED
Date: Mon, 29 Jun 2020 17:08:21 -1000
Message-Id: <7ee38d7f6eae1c938842ddcc3aae49e462569df3.1593486375.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593486375.git.steve@sakoman.com>
References: <cover.1593486375.git.steve@sakoman.com>

From: Richard Purdie <richard.purdie@linuxfoundation.org>

ASSUME_PROVIDED can take regexs however the current way of handling
this in code is suboptimal. It means that you can add something like:

DEPENDS += "texinfo-nativejunk-that-does-not-exist"

and if texinfo-native is in ASSUME_PROVIDED, no error will occur.

Update the code to only treat something as a regex if a start or end
anchor character is present (which wouldn't be valid in a recipe name).

[YOCTO #13893]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 3d72e23109990970fbb1086923277af752168b4a)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/taskdata.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index d13a1249..ffbaf362 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -21,8 +21,13 @@ def re_match_strings(target, strings):
     Whether or not the string 'target' matches
     any one string of the strings which can be regular expression string
     """
-    return any(name == target or re.match(name, target)
-               for name in strings)
+    for name in strings:
+        if name.startswith("^") or name.endswith("$"):
+            if re.match(name, target):
+                return True
+        elif name == target:
+            return True
+    return False
 
 class TaskEntry:
     def __init__(self):
-- 
2.17.1

