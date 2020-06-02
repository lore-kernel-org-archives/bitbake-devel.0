Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
 by mx.groups.io with SMTP id smtpd.web11.398.1591058408524332260
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 17:40:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=EW17Aos0;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.194, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f194.google.com with SMTP id bg4so623984plb.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 17:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=UTk4LVKh9RvpZ2JY6FT7IIidMHQinQNh6xWKVz8I+ds=;
        b=EW17Aos0DiQEDS29meezdsaYFKjcMilyaP5Rmp2W+rM43r92QEUlf6OVh3Dvjk4nIz
         iywQ8ANucFwC3pbaCrJK+RbqS0syI39godNLIuJ89s2DwPQhqqSnWSFwbI66BMtoVG2F
         tT4rMHu580SInyarYBeiEZk6ekJ8IFsxFa+PONltkpsuMlN2+c0SXNy5oaIPM/zFIUgX
         6ij3QN71SnQTGMLei9+vrfBF3/jg4YlCI/FhRL7VFYdIj/fuQ6Y2Cy+HKvzgoZ7GdwnC
         mbLRNR2xs6NkA2x8C+t6nD7RQPU3ow2d2iDB/MZqGq16sQRudfdG45YW4V3gwgJvzwRv
         4R8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=UTk4LVKh9RvpZ2JY6FT7IIidMHQinQNh6xWKVz8I+ds=;
        b=KZWHCrh1Hyq9R2gfPvTQ6N+tS5x1GOqkXKgXg/EKnLffaxMqHY9Ms1Hvu+yUkvo8fF
         jRjM7z8rHnw3PzuGFRKfuGW79LvxdfVdfhBy4mNNz64VNX/UM8w7nu/v48bzU46ssrwB
         0dKGWOswmM9jv5e9QnwDEERQ50Idb/5Xx6Qwu791v1CciRzTyo5iDXfxA1uqBASdIv3C
         pAVRrpJ8AukZ3yxmcXXd5eHiDsJnZygumq+J9u1oZVBa5B40u1aFPSRh2GkFmChoq8ke
         MlXrCNa6B0KSqleAiARIyGk7C488r7R+t+hXubmKpKr+GeQFLcp9g6heaBaQTBCJzM2U
         X0/Q==
X-Gm-Message-State: AOAM5325oekcb7Y37AWjqZaS1oXSUXnX8129Intm27XU6kswVNj66OcB
	6Q29c0QxSsc0FhPPvuIHc6P1TwH3mnY=
X-Google-Smtp-Source: ABdhPJxISu56cUjYORnAJg8BE1mJQqcFiftPX6zZMkgOBUULlNeFhS16fp+sAB8hxeDGtpTtK0lT+Q==
X-Received: by 2002:a17:90a:17ed:: with SMTP id q100mr2125130pja.80.1591058407651;
        Mon, 01 Jun 2020 17:40:07 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id l187sm465729pfl.218.2020.06.01.17.40.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 17:40:07 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 6/6] toaster-requirements.txt: require Django 2.2
Date: Mon,  1 Jun 2020 14:39:36 -1000
Message-Id: <6cc09fa33131f71a3fd0e336ff07a4186b41bf8f.1591058197.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1591058197.git.steve@sakoman.com>
References: <cover.1591058197.git.steve@sakoman.com>

From: Tim Orling <timothy.t.orling@linux.intel.com>

In commit 9730f95686b2ac72cf1fa513c555f7c7787e2667
Django 2.2 was enabled.

Django 1.11 was EOL on April 1, 2020

Signed-off-by: Tim Orling <timothy.t.orling@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ee15e78c6f9b59c221b1e43973ee4db20c5b443b)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 toaster-requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index a682b085..735b6145 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -1,3 +1,3 @@
-Django>1.8,<1.12
+Django>2.2,<2.3
 beautifulsoup4>=4.4.0
 pytz
-- 
2.17.1

