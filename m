Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
 by mx.groups.io with SMTP id smtpd.web10.61551.1600093159256039010
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2020 07:19:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=Q1tWwt5u;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.195, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f195.google.com with SMTP id o20so12737328pfp.11
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2020 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cb0Y3G+TOcDGOlPRvxTvcFngIbEjSuE25TnzhXlTXWA=;
        b=Q1tWwt5uh5nG9FrnDptntTib1EmjBFslt/MP9fuJqo71BarqgK9ZFBzNpMygYOzDxC
         yLHRufS9Ah4ipVdWqIXBOAdhuqHcVQCrT/9YNCVISUSxlJ+36J7mSfBoD/lHrTisssSw
         Eu14a8TWnn8r49AZWXVI0nS932WDXGFT6lASMuQyUqhYFa1InLLQ94pur1XZpLFvjplh
         dnOw0jzZG+JHyMFPJafDn1WGyiwKjmpR1I3I6hEFIPCQVxkLGyUD1dbRvm6PWjR7bIJn
         rmvMs4Yw45K2b2njh/DOaCHFjpaxXil71tdhfFoUQOJrhQfm9EHT92QmxywtVxGDdX6B
         9O+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cb0Y3G+TOcDGOlPRvxTvcFngIbEjSuE25TnzhXlTXWA=;
        b=C7eDwDrzVKVNfAKWiII9wEfozrssDj762LNPjTu60vUvdGkmhNcgrOZqs9PZWwB9Ei
         SUb9BTF1QPnmwKX8QnEH9ouBRi5SD1tVApQRWjQ654EFCwhmwO00SNCKTn6zbGLfi9yi
         uieRSZmX1buSeXf1rkjx6RtWOUWOWyNXNZkutVM6tZbXvkNYRmG5da9bm60zhk+DR/8C
         HGKdAKcQHWm2IOxeZP2zKXuFHPjRgvgwj6WGj7MGayIzckXSolLEwAErcgEDsTBWEvdh
         E1JrhPgTZRqRuPq8R/9+qQ/jeUWrGwCZnel8+/scK84DmAO+fChCE4d56J6xSp8XGjJV
         5ezQ==
X-Gm-Message-State: AOAM531dyZC0mtiUrcfc640li4msQSwylKFI8ynDKTMWlykXffnNOJOy
	r7d68iYt/b0XCVGhsCSdeIJm1reweBAK3Ri7dI0=
X-Google-Smtp-Source: ABdhPJyzKL5HWehn1Pnz156R53BFH0oAYNaNQMQTcFt6L9vEanwkQKaABaQp9LziQyyrEjOCRPCE1g==
X-Received: by 2002:aa7:8b0c:: with SMTP id f12mr13507205pfd.58.1600093158206;
        Mon, 14 Sep 2020 07:19:18 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id gn24sm9738003pjb.8.2020.09.14.07.19.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 07:19:17 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/2] siggen: clean_basepath: remove recipe full path when virtual:xyz present
Date: Mon, 14 Sep 2020 04:19:03 -1000
Message-Id: <befc11acd25a9d9a2d44c20a0e33ada740407af7.1600092861.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1600092861.git.steve@sakoman.com>
References: <cover.1600092861.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>

Before this fix, this example basepath (a):
virtual:native:/full/path/to/recipes-example/helloworld/helloworld_1.2.3.bb:do_compile
would get incorrectly "cleaned" into:
helloworld/helloworld_1.2.3.bb:do_compile:virtual:native:/full/path/to/recipes-example/helloworld/helloworld_1.2.3.bb

When searching backwards in `a` trying to isolate the 'virtual:xyz' to add
it to the end of the string, we need to consider `a` still has the recipe
path and taskname. So stoping the rsplit after only 1 split is not enough.
We want to reach the second ':' from the end.

This way, we obtain:
helloworld/helloworld_1.2.3.bb:do_compile:virtual:native

reviewed-by: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit d193d93422a0ad62aa35b5d4ca5da8d422f72180)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/siggen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 94d1762d..26fa7f05 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -706,7 +706,7 @@ def clean_basepath(a):
         _, mc, a = a.split(":", 2)
     b = a.rsplit("/", 2)[1] + '/' + a.rsplit("/", 2)[2]
     if a.startswith("virtual:"):
-        b = b + ":" + a.rsplit(":", 1)[0]
+        b = b + ":" + a.rsplit(":", 2)[0]
     if mc:
         b = b + ":mc:" + mc
     return b
-- 
2.17.1

