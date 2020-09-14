Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.62399.1600093162123068042
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2020 07:19:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=Y8ebBZ/Z;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.47, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f47.google.com with SMTP id o16so5651755pjr.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2020 07:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=6Q5/8zLUzu8xxzVb06uIH32SnA9B3wp4Xl2Yxz+XC00=;
        b=Y8ebBZ/Z0BuC0esefXiAGg8L4NgeCYy7QLtw8u3fctvaaxfTJVZ6z2pGF9fzOcKqid
         6OQXUcOIEXw4xYBj1Xn9+UtyAH7HOAiFBPuu8EyAhVO7zYP3xvOgdG+LRUz7WRqHFTdS
         iLDjcCgXQaxcZvOwoSNH+mTo0mPEB6Yxny7K6XUwtygGcSRMQFlW0jZDJ8vBaXoofHxa
         Fuzlbqa+dSXu7mG/MiPljG49AXExv7oBb3TIwKfUqTElMVFDDgGwKzB0VQfqagsiHTdT
         YHLOotBYgtDJnaxnHT1akHCclSZOp8bx0maHspJ+cVXsPSZ78HPaH0PC5/ztSpnVzDE/
         b3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=6Q5/8zLUzu8xxzVb06uIH32SnA9B3wp4Xl2Yxz+XC00=;
        b=unu6Z1Kw63NdhaA/OcgJRjBH22dFAPbSFwi2rVbj/FjneOP4PokBbvukp9M0mEVc7e
         7LWIsm2otmkx6fhMR7nr6oxr7E0YMEtqf6ci5LwQHiZd1CeviveetEKuj5oMW88oHHgX
         vQol5R2Uj4ELurNh2XgYT4J+D7XebN4w3tNWMir1X9zwJLHSasjI7b/0agxSmh0pJVzf
         bjAI7iXdGvhdSs7dNegqz8QlOwGzJ9FllInqd/bzo+DXDTp5mks4395k3a89cSJ7fdH+
         aLYWurp8jVT2Zq1d56g5Opd34FPGCnWIjAoWXPqnqlKuXCzTN1sSNNjg8zWS7BZM7DsS
         xr/Q==
X-Gm-Message-State: AOAM531jAFTOqJCGaW173XwhxA90LVn0H+YsZCNdchrVcItdZqORkita
	Z42cLuCDzcZ1EZrKFY/6yBw1N2grkPbf75y/Qg0=
X-Google-Smtp-Source: ABdhPJyiT9eWZmiOM9xjx32oyESYdOtVyCxgtkoSqsQZRJ5EhpFjNNePYkctuT+Kc6QxKpEerDbOAA==
X-Received: by 2002:a17:90b:317:: with SMTP id ay23mr13950404pjb.68.1600093161217;
        Mon, 14 Sep 2020 07:19:21 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id gn24sm9738003pjb.8.2020.09.14.07.19.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 07:19:20 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/2] fetch2: Drop cups.org from wget status checks
Date: Mon, 14 Sep 2020 04:19:04 -1000
Message-Id: <16774d4d41f2011e8db7d2986a1a701df123dfc1.1600092861.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1600092861.git.steve@sakoman.com>
References: <cover.1600092861.git.steve@sakoman.com>

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Its becomming clear the upstream server doesn't like this, drop these
two urls from the test, not sure we need them here anyway.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ab2ef942dc21f9639793c972f2e546edf9444783)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 29c96b2b..61b80bed 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1262,9 +1262,7 @@ class FetchLatestVersionTest(FetcherTest):
 
 
 class FetchCheckStatusTest(FetcherTest):
-    test_wget_uris = ["http://www.cups.org/software/1.7.2/cups-1.7.2-source.tar.bz2",
-                      "http://www.cups.org/",
-                      "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.1.tar.gz",
+    test_wget_uris = ["http://downloads.yoctoproject.org/releases/sato/sato-engine-0.1.tar.gz",
                       "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.2.tar.gz",
                       "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.3.tar.gz",
                       "https://yoctoproject.org/",
-- 
2.17.1

