Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
 by mx.groups.io with SMTP id smtpd.web11.7699.1593486558798898978
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2020 20:09:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=OmbUI1KP;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.66, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f66.google.com with SMTP id d6so8866709pjs.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2020 20:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=49Adq/9clo2UfVK05vkFbGzQlM40UaPjabcvRjNr8c4=;
        b=OmbUI1KPsxkH2kkHJlpq12AoWbAS8fEtEchXD/yfBiZLfF+4UZwQ1QbVE4l7rqO8Kx
         2qrE4wxxvB55cL26dhgtpBXrjyGC3tshkDa8wwFq8Y6rPvMv+A5Dzig6fMcJCiN82fg2
         zqkOLpKr7mrRNzIDFa8rHc3iM0Jn1MQJr6aKPoogeI2PXWP2Icx9vzgFAW7klUOI/2Vc
         i1nFy5xB7iWnreC55hunBR3wS7VYDy+2pNmgLEjRDiZ7BW91JWJxgZNWV/3pSWgslvIX
         BBnj4T6kFJWQZHa4IqFAd7RXKP9hMLQUDcrDvgP5RD57aKlrH9xeRHaxg5sVo69dNKiZ
         casQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=49Adq/9clo2UfVK05vkFbGzQlM40UaPjabcvRjNr8c4=;
        b=YrYERz9/brKzpLRvR3xgDlIWsy+bhZlczZa8gVrpABOr8eSXdQXnvCfp3LY75JWqtE
         TiL8g7S5uDWeOYIeZsUxO+ZPziVC3H0+a9X/gqgumozkrmwlsdP00lCDkwezbXg7pHN1
         LOy+Ot6VDDxYfaJAg2+01OJEksCxrhlvZhy2fI+bKh5paYpcY1GRo1SEb+MrsvrmmndS
         lebHzaNInpQ+7eRC4MwkmcUMvOK/7H5llWHCMv4HZVLGEfeeltmRuQZVh+9oMDyktEns
         vJO/lWcI0XYPwg0Wjt1D9M4qC4ciq2XQevGzmSzsyxi52dgTEjdP28UJP+EbJmMR9aHN
         diGw==
X-Gm-Message-State: AOAM5307PX8uOVZfae/8MFdoZS1VEuxkEcimjN8Ta5rnlMtupHVe+wfm
	xgEsxTot6Za2a80jl+9qTA0cD7Km7FuQoQ==
X-Google-Smtp-Source: ABdhPJwcQmgYiVJr9RIAZDdybcWXCcZJlrKC3UMQjyrO2bob0Z0zzvYkPjzS6jyk0LnPKyQxdks8zw==
X-Received: by 2002:a17:902:7208:: with SMTP id ba8mr16338576plb.217.1593486557942;
        Mon, 29 Jun 2020 20:09:17 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com ([99.197.43.113])
        by smtp.gmail.com with ESMTPSA id n14sm970933pgd.78.2020.06.29.20.09.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 20:09:17 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 6/6] msg: Avoid issues where paths have relative components
Date: Mon, 29 Jun 2020 17:08:26 -1000
Message-Id: <436d6fe412397c2eaf7c1e1d3536eb45e4a31edb.1593486375.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593486375.git.steve@sakoman.com>
References: <cover.1593486375.git.steve@sakoman.com>

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The autobuilder can end up using build/../ syntax which is an issue
if the build directory is cleaned. Avoid this by using normpath()
on the file path passed in.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 41988fec47eb196ab7195a75330a6d98de19101b)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/msg.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index c0b344e3..2d88c4e7 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -280,7 +280,7 @@ def setLoggingConfig(defaultconfig, userconfigfile=None):
     logconfig = copy.deepcopy(defaultconfig)
 
     if userconfigfile:
-        with open(userconfigfile, 'r') as f:
+        with open(os.path.normpath(userconfigfile), 'r') as f:
             if userconfigfile.endswith('.yml') or userconfigfile.endswith('.yaml'):
                 import yaml
                 userconfig = yaml.load(f)
-- 
2.17.1

