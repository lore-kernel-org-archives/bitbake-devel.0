Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.13665.1612652942022812479
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Feb 2021 15:09:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=lfbED8jz;
 spf=pass (domain: gmail.com, ip: 209.85.214.181, mailfrom: akuster808@gmail.com)
Received: by mail-pl1-f181.google.com with SMTP id b8so5475276plh.12
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Feb 2021 15:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Zbz5lqDrLY7Nkfz/rbDcbcZ8YzpAw3bx+T/785DIfj0=;
        b=lfbED8jz1WB2OYSxO4Pn7H9ZNtyNG2TW9TwUY9Ll5CdcCBN7KM3thUXnq/HuH0ns9i
         0lfwlK+SbfCniqrmlqm9lkyKnoUClhHy++61Uj3kw8T5KicBVNmBlw5RCn0jrEoWtsBV
         9r8SvjaHhCtGEq3jMv50FTs7GkkDcbL32lJpwn3rtlwki5pfU/gBp8mdb/hlxuWm3hoL
         KAao6aozvQYTUf+mYy2p/r5KDZuYcNTvgHdMiiGR388Q9N28FgjA+3TGos8+RAVvQX5q
         YVB70tXxOJxxi5OkFKsq6mCM+tNA5IrS56X5L0FAOyz0L//LAkPIysY8H8kQGqSHr1nu
         Q2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Zbz5lqDrLY7Nkfz/rbDcbcZ8YzpAw3bx+T/785DIfj0=;
        b=BP3sbxiIJ7BXiBflgz9N2J7tfI9YBkSQMpkbx6amKbp7IjOtK5PinIdM0b5ANIOmx5
         hjddgwmxXnFhjiL9n+mtm+FLtxf76cWo0G9snCNnb63MV+gb8ljOF0OdUwQMCqDECoNw
         X6dU6UdNxL7WVHxZHOoAlHpgS7WDRfyMdGIb7Y1GWKyqnS3G56Gaypxc2T0+zuwwcQ5n
         9n4yZIWa+GX0/DPNOvDxSnsMyWFR7JAdx9oA1PvUGcuWPttX08vLiXl77d28+PE6OXeP
         O8vc8Ktfd/rAzEJCb5MtH35/6YV+aqMCgtaKA1IDCOB+HJkjRAVqQDsIgBRlVczMg4nD
         6eMg==
X-Gm-Message-State: AOAM532z7Jv2rFBVnxj/W85nrxWhs9qWGod/o6dqTDh8fxdPGAV6lRkT
	QLZ76XqXQ3H7t30VWGNhn2bYyeupTdtTmQ==
X-Google-Smtp-Source: ABdhPJyNKcvaf+9IL+3dUttj0VrJit3X3/lZbXONqaXOAqCLgWEqhVWHYD55N28Z7cBrnBAz0B9YdA==
X-Received: by 2002:a17:902:cecc:b029:e1:268e:2286 with SMTP id d12-20020a170902ceccb02900e1268e2286mr10407499plg.62.1612652941440;
        Sat, 06 Feb 2021 15:09:01 -0800 (PST)
Return-Path: <akuster808@gmail.com>
Received: from akuster-ThinkPad-T460s.mvista.com ([2601:202:4180:a5c0:c5c4:f80e:4f44:b02e])
        by smtp.gmail.com with ESMTPSA id k10sm14492489pfk.0.2021.02.06.15.09.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 15:09:01 -0800 (PST)
From: "akuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [gatesgargh 09/10] openldap: upgrade 2.4.51 -> 2.4.56
Date: Sat,  6 Feb 2021 15:08:46 -0800
Message-Id: <e615c6fceff7275d93e462f4cd4a14cc55b2d656.1612652802.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1612652802.git.akuster808@gmail.com>
References: <cover.1612652802.git.akuster808@gmail.com>

From: zangrc <zangrc.fnst@cn.fujitsu.com>

Signed-off-by: Zang Ruochen <zangrc.fnst@cn.fujitsu.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
(cherry picked from commit 768345053e83623e286ce3140756036e75c023bc)
[Maintenance update only]
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 .../openldap/{openldap_2.4.51.bb => openldap_2.4.56.bb}       | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename meta-oe/recipes-support/openldap/{openldap_2.4.51.bb => openldap_2.4.56.bb} (98%)

diff --git a/meta-oe/recipes-support/openldap/openldap_2.4.51.bb b/meta-oe/recipes-support/openldap/openldap_2.4.56.bb
similarity index 98%
rename from meta-oe/recipes-support/openldap/openldap_2.4.51.bb
rename to meta-oe/recipes-support/openldap/openldap_2.4.56.bb
index d2c5746080..4c0f179cb0 100644
--- a/meta-oe/recipes-support/openldap/openldap_2.4.51.bb
+++ b/meta-oe/recipes-support/openldap/openldap_2.4.56.bb
@@ -25,8 +25,8 @@ SRC_URI = "http://www.openldap.org/software/download/OpenLDAP/openldap-release/$
     file://remove-user-host-pwd-from-version.patch \
 "
 
-SRC_URI[md5sum] = "0d2025896cf1c17af7304ecc57ec9531"
-SRC_URI[sha256sum] = "f490775ea4c6506b7210ee55a102c8f4aacfe9d1c8eaa633c7316d33a714be62"
+SRC_URI[md5sum] = "82a7dcf7aeaf95fdad16017c0ed9983a"
+SRC_URI[sha256sum] = "25520e0363c93f3bcb89802a4aa3db33046206039436e0c7c9262db5a61115e0"
 
 DEPENDS = "util-linux groff-native"
 
-- 
2.17.1

