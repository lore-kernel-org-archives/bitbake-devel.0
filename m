Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web08.13831.1612652942929338693
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Feb 2021 15:09:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Tc9mjdJB;
 spf=pass (domain: gmail.com, ip: 209.85.214.181, mailfrom: akuster808@gmail.com)
Received: by mail-pl1-f181.google.com with SMTP id k22so1120743pll.6
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Feb 2021 15:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=H2WMZBIiCsIhSwxroWBCwuhgh2Vbc+Rzy8gCiQVXnFs=;
        b=Tc9mjdJBpYWeMTse+V4IqOemWlXV1BfiJ4GUzUz+dtgqrcSu9xMPs4o2Y4ZHxgH1u0
         OcPWIpJ5iUhqH4LzfNoG90W2mqdLd2g7S/jkQIZu7S26mKzaVlS+LnePJGXiK1XiHVzv
         8wIkC3qn1IVBf9gAJQ6JiUD/vgcrQ57eTz6dzkI+iKhGaGqGgcvH+3y0EPbJ864iPd2W
         E1vqsuUz4MqyLKs/y/KJL7k8WmUKm9K/0APBGADmMFVVtCxPJ+viAxEOMyDs7/PR1WAt
         pw6AsFm9NrHxe/PW8XbsT9E6yip2YdZcqSRiiuSPRPfXOYXLAQbiDkUvgJqhG1JtAU0T
         ZdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=H2WMZBIiCsIhSwxroWBCwuhgh2Vbc+Rzy8gCiQVXnFs=;
        b=Iu6pp9l7ZzBZlfmjwAYXO66CRqYpYeLzkFa/re1cot0XYUJNKr/Qi98gx95fijWHsp
         202BeWtzCg5hQmU5f4Hig/bUK8tdYzOBHoiRvH54OUbG0RYgDRWC7dx2uN4z3QJNYENR
         pl1lNJaU6i5sxltlfaVOfbz/YRak9tN0jHuSkyiKMCttXzNs/v2nBIlDnOdXlGheFTKn
         Fs6fm2VmNi8Eawk0h4XcjFPjM6zNxg8GCdIT+nXwHIG3Q/EdQcTIHedqGYnHih9l1WZD
         dhFBu0q4jV7di1LLRI8KYZsx0lOrk8Jz+DLF/5l8rrARL06AValXDhJM8sdL0uboU+/Y
         QWHQ==
X-Gm-Message-State: AOAM532Tp+VcIUNEVe5DotCmxWnLOwbR/64xARYL6w/C1Ct8gwz7U5Ya
	MY95jxw7djCwgOTlxYqImSLN2O4YpqXEFg==
X-Google-Smtp-Source: ABdhPJyQmgE12G6rtYsPK3zlJwjGQFpP6a8W//+tyvLwsql82UC6dDUyqKmZVT3r4Nf+3Fy4LsUtyw==
X-Received: by 2002:a17:902:8643:b029:da:d5f9:28f6 with SMTP id y3-20020a1709028643b02900dad5f928f6mr9834377plt.8.1612652942327;
        Sat, 06 Feb 2021 15:09:02 -0800 (PST)
Return-Path: <akuster808@gmail.com>
Received: from akuster-ThinkPad-T460s.mvista.com ([2601:202:4180:a5c0:c5c4:f80e:4f44:b02e])
        by smtp.gmail.com with ESMTPSA id k10sm14492489pfk.0.2021.02.06.15.09.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 15:09:02 -0800 (PST)
From: "akuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [gatesgargh 10/10] openldap: upgrade 2.4.56 -> 2.4.57
Date: Sat,  6 Feb 2021 15:08:47 -0800
Message-Id: <cef93b7b00e620d90a610112ee574fa60b691cf8.1612652802.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1612652802.git.akuster808@gmail.com>
References: <cover.1612652802.git.akuster808@gmail.com>

From: zhengruoqin <zhengrq.fnst@cn.fujitsu.com>

-License-Update: Copyright year updated to 2021.

Signed-off-by: Zheng Ruoqin <zhengrq.fnst@cn.fujitsu.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
(cherry picked from commit 0282b8ce6a5a5f082a37cb0863b3e62ad8e56a5a)
[Maintance update only]
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 .../openldap/{openldap_2.4.56.bb => openldap_2.4.57.bb}     | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 rename meta-oe/recipes-support/openldap/{openldap_2.4.56.bb => openldap_2.4.57.bb} (97%)

diff --git a/meta-oe/recipes-support/openldap/openldap_2.4.56.bb b/meta-oe/recipes-support/openldap/openldap_2.4.57.bb
similarity index 97%
rename from meta-oe/recipes-support/openldap/openldap_2.4.56.bb
rename to meta-oe/recipes-support/openldap/openldap_2.4.57.bb
index 4c0f179cb0..a282523a3c 100644
--- a/meta-oe/recipes-support/openldap/openldap_2.4.56.bb
+++ b/meta-oe/recipes-support/openldap/openldap_2.4.57.bb
@@ -7,7 +7,7 @@ HOMEPAGE = "http://www.OpenLDAP.org/license.html"
 # basically BSD.  opensource.org does not record this license
 # at present (so it is apparently not OSI certified).
 LICENSE = "OpenLDAP"
-LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=5391b559d23a2237bdb21e7a62dae7c3 \
+LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=b6dea6c170362fc46381fe3690c722cb \
                     file://LICENSE;md5=153d07ef052c4a37a8fac23bc6031972 \
                     "
 SECTION = "libs"
@@ -25,8 +25,8 @@ SRC_URI = "http://www.openldap.org/software/download/OpenLDAP/openldap-release/$
     file://remove-user-host-pwd-from-version.patch \
 "
 
-SRC_URI[md5sum] = "82a7dcf7aeaf95fdad16017c0ed9983a"
-SRC_URI[sha256sum] = "25520e0363c93f3bcb89802a4aa3db33046206039436e0c7c9262db5a61115e0"
+SRC_URI[md5sum] = "e3349456c3a66e5e6155be7ddc3f042c"
+SRC_URI[sha256sum] = "c7ba47e1e6ecb5b436f3d43281df57abeffa99262141aec822628bc220f6b45a"
 
 DEPENDS = "util-linux groff-native"
 
-- 
2.17.1

