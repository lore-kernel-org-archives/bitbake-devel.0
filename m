Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web12.33874.1601900838194724916
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Oct 2020 05:27:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=p+Uer6B2;
 spf=pass (domain: linaro.org, ip: 209.85.128.68, mailfrom: nicolas.dechesne@linaro.org)
Received: by mail-wm1-f68.google.com with SMTP id p15so3935387wmi.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 Oct 2020 05:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zjEfMZzzIJjnVtYTNC0aGuDPNRDrVZdgRntvyYzQktA=;
        b=p+Uer6B2LJVeLYDsMqE8jUnTLtl9ROC7XxHV+owwkSOpfjKYX79AAUWRjfx21aPFph
         LVy2oVCKUqVhAc6fXBVQJ6RSVzirIG+GPMTRqbk01fwNMhCuWQ1WU2V5sJ5qYzavsZz2
         JU6FdmAuMp8UVK252iVa1YuEeNpItPrcumK0OxNcKga9oYL/5ZOIvV6v6XJCPNYOICXs
         1oefERFvVKcyHgk1kpCjsraxYT7ExDe10RNRmT1BI/rj6MGlAMLHu4qgYlLxAoXugHLe
         vb21+UbQ0fW8zPhI0kn1iDlVXbbLfAEpgRYhrJ6nab158Iq+E2GG1O8D1jOPlPiu+N9r
         QEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjEfMZzzIJjnVtYTNC0aGuDPNRDrVZdgRntvyYzQktA=;
        b=jSG3aOZ4Q2TO74TXrn/RPodsQcVc9EAp/OID158hVjr7v+qBDYycYfuKolqxrmaBIo
         wluoZOzsO49fnb6cnhrnmtWmu28o0jH8QOJkydOcH4BHHDXC02myMOade6Ku+B7vXt8Z
         FoQbvbOlRMBVhj56o2D/tIXdeDsqjBnPYRLI3Ai5s0pIIFi2GXlml8c+iYoLuWtewP6M
         P9Zs2c+o8MehEzdUbhHOwRm7dMJcZ65KqidJ7LQ8HG0C6+F8oxldD1XxMaLAqd1ZgsZY
         QFgwW5E/xiQ/QrYgmf7UOT6r9ZmwTZeLfKVXb4WA0USujanFI/Ut0y86ChJdDzEloXTw
         3dMw==
X-Gm-Message-State: AOAM532S4x40FC/5+9q/5+Gm8/HJ2x53tvDEy5c78jjB51jXSZW7j85j
	OjUOnCSDqflmrz88+B58BccUh9d/vVyKww==
X-Google-Smtp-Source: ABdhPJzoY0CwWAe/c2G+FyZIEx4hAD1EWfWRbERbI2Ox9Tcxy7QTH1I0i4e1hHswiUK3u6TcinbUKg==
X-Received: by 2002:a05:600c:c5:: with SMTP id u5mr16486916wmm.14.1601900836369;
        Mon, 05 Oct 2020 05:27:16 -0700 (PDT)
Return-Path: <nicolas.dechesne@linaro.org>
Received: from localhost.localdomain (82-64-249-211.subs.proxad.net. [82.64.249.211])
        by smtp.gmail.com with ESMTPSA id c130sm1953628wma.17.2020.10.05.05.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:27:15 -0700 (PDT)
From: "Nicolas Dechesne" <nicolas.dechesne@linaro.org>
To: bitbake-devel@lists.openembedded.org
Cc: foss@0leil.net,
	Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: [PATCH 5/5] docs: static: theme_overrides.css: fix responsive design on <640px screens
Date: Mon,  5 Oct 2020 14:26:52 +0200
Message-Id: <20201005122652.392528-6-nicolas.dechesne@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005122652.392528-1-nicolas.dechesne@linaro.org>
References: <20201005122652.392528-1-nicolas.dechesne@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quentin Schulz <foss@0leil.net>

From experience the body takes the whole space anyway and the text stays
within the screen boundaries by default, no need to make the min-width
640px then.

Signed-off-by: Quentin Schulz <foss@0leil.net>
Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 doc/sphinx-static/theme_overrides.css | 2 --
 1 file changed, 2 deletions(-)

diff --git a/doc/sphinx-static/theme_overrides.css b/doc/sphinx-static/theme_overrides.css
index 4fd76a15..e362677a 100644
--- a/doc/sphinx-static/theme_overrides.css
+++ b/doc/sphinx-static/theme_overrides.css
@@ -4,8 +4,6 @@
 
 body {
   font-family: Verdana, Sans, sans-serif;
-
-  min-width: 640px;
   margin:  0em auto;
   color: #333;
 }
-- 
2.28.0

