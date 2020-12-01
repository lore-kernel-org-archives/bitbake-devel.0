Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web11.12675.1606840023225935847
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Dec 2020 08:27:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=u5WCwJUd;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: ernstp@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id q13so5327746lfr.10
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Dec 2020 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n4D1GI8CR3uJiLiE7DEYFeFUNuY9Bu4Py7h9U/D7lpc=;
        b=u5WCwJUdO/Z4P4Ih9m+MhFHEdGWCAjedF1we4wJDh1Q15DGN0TMP2qrR8BqpYArXZ1
         Da3dzPwFx1vj53nIyGzASuJzjzqQ1VPgIFCmzLPibicuisEHAV7+l2rdSpSTspTXAJnM
         3bqKbWquBtrb1olNNrD9iH82WlDrFZ5Yx6lES3vJDAR57rmgwGWKYOLlug+XgV9TEthM
         6edX6uP5y285MVBu7aa0QlCaSfXVhxGhQE8jy2avyPfE9DM75WvPsQZH+r3W4IUy3eiX
         fk1WGtKnpXPdJzIHFBB9V5rnP0Xx8t0YEk5TDt2S4MDGgllNuQIikYyDannvkMAP1joS
         VQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n4D1GI8CR3uJiLiE7DEYFeFUNuY9Bu4Py7h9U/D7lpc=;
        b=fG0eOHEqz+0j80bMHe/a2bfYzHLlK6EIKajsThyrYA2+yLw4NHi1T5essSQIlIWgB8
         i8IJOsm53JNBZroUEz7Knxq7h3zoRY47sYJ8fLeejiSt6IOcbL3R1AG9yXrveeiwk2Z3
         fkrYE8ZSRZqglO11JSQOm6/dzFH7EEvcv7l++/DOs8+2qAwrXAVWECz+dqki19ZavG59
         zIwf415ryXPl12Go7tme/afpcdQZEwmUddbus0zuzLj6ltm8MZdxlGi5zWEeAN2UqjKH
         snPkDIMirgJ9MhbubB56ya+SnL7XhliZX1463rv3+n9fgZmJxh+e1xDGtEcyttCz3s5+
         2g4w==
X-Gm-Message-State: AOAM533nzcjLf1FAM2aD9DczBB0Yzx3DGBDmKcxLPl5U8ouKuHUjBzsE
	z/JT9fH27uVMD+1hWCRLUYouf7RfcQA=
X-Google-Smtp-Source: ABdhPJw1Fi6mDdKjCRrAmbGr8SEkAMrK4Dx9xB0pgCWr39ZVClh+YIqeWUmg3VcHzHgogLL6QqywJg==
X-Received: by 2002:a19:483:: with SMTP id 125mr1523190lfe.19.1606840021333;
        Tue, 01 Dec 2020 08:27:01 -0800 (PST)
Return-Path: <ernstp@gmail.com>
Received: from localhost.localdomain (c83-254-138-119.bredband.comhem.se. [83.254.138.119])
        by smtp.gmail.com with ESMTPSA id j131sm248746lfd.209.2020.12.01.08.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 08:27:00 -0800 (PST)
From: =?UTF-8?B?RXJuc3QgU2rDtnN0cmFuZA==?= <ernstp@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [dunfell 2/5] python3-pycairo: use python3targetconfig
Date: Tue,  1 Dec 2020 17:26:24 +0100
Message-Id: <20201201162627.47760-2-ernstp@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201162627.47760-1-ernstp@gmail.com>
References: <20201201162627.47760-1-ernstp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Kanavin <alex.kanavin@gmail.com>

(From OE-Core rev: dadf001c85938b831def8da5851a40dc0977e3d0)

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 5077e7abbacf639f63bd444517d1d59a27d502a1)
---
 meta/recipes-devtools/python/python3-pycairo_1.19.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta/recipes-devtools/python/python3-pycairo_1.19.0.bb b/meta/recipes-devtools/python/python3-pycairo_1.19.0.bb
index 8f60834c17..8452d7fa9f 100644
--- a/meta/recipes-devtools/python/python3-pycairo_1.19.0.bb
+++ b/meta/recipes-devtools/python/python3-pycairo_1.19.0.bb
@@ -18,7 +18,7 @@ SRC_URI[sha256sum] = "4f5ba9374a46c98729dd3727d993f5e17ed0286fd6738ed464fe4efa06
 
 S = "${WORKDIR}/pycairo-${PV}"
 
-inherit meson pkgconfig
+inherit meson pkgconfig python3targetconfig
 
 CFLAGS += "-fPIC"
 
-- 
2.29.2

