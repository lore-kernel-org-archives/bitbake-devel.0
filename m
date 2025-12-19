Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BB2D78794
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 16:13:10 +0000 (UTC)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20305.1766160787727561154
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Dec 2025 08:13:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=u6/EBzVa;
 spf=pass (domain: smile.fr, ip: 209.85.128.65, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso8120665e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 08:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1766160786; x=1766765586; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtbCIQ3ZC+dM0PqspT29FgKVTSObuAISrT2YCdXsYgo=;
        b=u6/EBzVaf3TrapycVqHOj6/qicaLch5+Uwy1v1u/CPkQipYA7dces/XOs1COhipQSw
         b9o3vz7NZxv4hQQfvdm47JrtmSquZJ4QWzaYLJKC3ofFXNdBm4PBUf7mL9OLhQn17Vwg
         nxOUDM9/vvQLAotoLJ1ZQx/Wb98cWhpNHMZWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766160786; x=1766765586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CtbCIQ3ZC+dM0PqspT29FgKVTSObuAISrT2YCdXsYgo=;
        b=gX+qmusZteTzWKiUXWK/81Xx8NgxWWagJky/YrAYMSHLaPEfXoT6foXdoyy2F+UDdP
         lGEUtc3+8ySfri7Kci1ISfGVgUMmNXgp3Crib6M6M7Zp6V+8Oiu1f63o63sOyi084pbn
         xbCJlDIIL/UxN8uoEXNSRLZOSY2QUI5B4ICi0N42Qghw+m8BZo/Y63U7fVIzNrYEQUUt
         zPfE9hdq9GXkOeDSUUSo5NdPAk8vhX2xW4OBV4b+sspdV45Nr+NnGgO42JGe+2TBGeAU
         231meWTHXF8fbEjKy0qg+nToNnC/IujJV38mbYV62KfV+9k0KbZZfH3Hfj3IWAUUxQ9O
         7XvQ==
X-Gm-Message-State: AOJu0YwuaYp29atCfWRKkTq+SQl6HXTTVIThz05Xgw1tQ4t4DkEgSKAv
	SXDKe1Rg1i5Cc/wWT+ZdM7LM7gEBUKPk4KnZ54zwHyBxTc+UZVqM4as+QhFzV7u/9FgDBlVl1qD
	fmo05b4Z8oQ==
X-Gm-Gg: AY/fxX7TuY6RFXylEu5KPdaI97XapWYkqdM6nARSqWQLqD9onfIqrugekXwoH7ZgjJd
	wH2mAjW2aRLG6xuPr+d9YeiPaM0j9gYUD10ydMTlFA7zbM/DpvommxHkMls6SHlLIzODDFB+3jd
	CdTErcusvKVE7xOQe/K+zGajClxhY6oePV2delOse1KNrINZcIryrsFHclMp7JYmK6MHZb4KZB6
	FzaJBpkla809cJGYK+7mQ0vLo+T9qNiJoyarmCiPzAZDLC490hoJ53Z8EUF5q8pc+s/B/CiAhZm
	uKmE/xO9PE62Hl5SxeKt9Y5dDnPeKkTY9G3mgPW6DBL78TSVFNfNJ9J7vcA/IoGoay/AsLq0aS5
	Uh9Is4YzSfU7bn5G8cjr/CyPwQLJ76Nix4FMyzdMccbgUlwwMjUgvAeOBGYlf5KDVqTViHMMdga
	2sXExV2bcNF9/kk7exsZqIpn2a1eMTKTsOmYz77C2X0grnZvcJUICJEgyORRv3+FUAlOZyZwlGB
	yEk3UIj9msqGJ2jwKM=
X-Google-Smtp-Source: AGHT+IFd4rlBSJS4FoN7Qik9zg8+qjqTzjLMMF79I/uaXeY3vPKVEy/RgTOyg6X6BpVoaGabqAVo4w==
X-Received: by 2002:a05:600c:c494:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-47d19582aacmr30646415e9.30.1766160786048;
        Fri, 19 Dec 2025 08:13:06 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be273f147sm105391065e9.7.2025.12.19.08.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 08:13:05 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v4 4/4] doc/bitbake-setup: document "uri" property
Date: Fri, 19 Dec 2025 17:12:55 +0100
Message-ID: <20251219161255.2293450-4-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219161255.2293450-1-corentin.guillevic@smile.fr>
References: <20251219161255.2293450-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 16:13:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18627

The property 'uri' is a simplification of the property 'remotes'. It is
used to provide only one URI.

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 .../bitbake-user-manual-environment-setup.rst        | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index ec1bdeecd..b3588f27d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -673,11 +673,7 @@ They contain the following sections:
          "sources": {
              "bitbake": {
                  "git-remote": {
-                     "remotes": {
-                         "origin": {
-                             "uri": "https://git.openembedded.org/bitbake"
-                         }
-                     },
+                     "uri": "https://git.openembedded.org/bitbake",
                      "branch": "master",
                      "rev": "master"
                  },
@@ -716,6 +712,12 @@ They contain the following sections:
       -  ``branch`` (**required**): the Git branch, used to check that the
          specified ``rev`` is indeed on that branch.
 
+      -  ``uri`` (*optional*): a URI that follows the git URI syntax. Can replace the
+         ``remotes`` structure if only one URI is provided. Despite this, ``uri`` and
+         ``remotes`` can still be used together.
+
+         See https://git-scm.com/docs/git-clone#_git_urls for more information.
+
    -  ``local`` (*optional*): specifies a path on local disk that should be symlinked
       to under ``layers/``. This is useful for local development, where some layer
       or other component used in a build is managed separately, but should still be
-- 
2.51.0


