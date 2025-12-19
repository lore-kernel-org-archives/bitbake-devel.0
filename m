Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE3CD767EE
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 11:43:18 +0000 (UTC)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15036.1766144594784208925
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Dec 2025 03:43:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=s64ZQb61;
 spf=pass (domain: smile.fr, ip: 209.85.128.66, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so11721575e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 03:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1766144593; x=1766749393; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT/HXEsH6E7fnj+CJvNCqFjB5m7T1MO1xAZ7rdm4iI4=;
        b=s64ZQb61QMO8zg4/OMrwL2BrZOeai4YDgW3i7KAYqx1LZgz6/Ozy/e66+Eje94wf4L
         UJd/zsxub4vSOsZRy6v/kVO+Lv3TU+FkgesoHMwS7wro093jrjSXyu3VSf8B9uSogh6H
         jzsV9H6V/aE+J3DqNgQvk1ak/mXr53bAks564=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766144593; x=1766749393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eT/HXEsH6E7fnj+CJvNCqFjB5m7T1MO1xAZ7rdm4iI4=;
        b=RKb8NTFoALyq9SmZI+vWx5gUmIgsTShOKAkEPB42ZE73Nxx1qSWF10zoCU5Wf5Yfy/
         +bJpAH46VbZeo4YTsT5LBFwXaJtpkaQAS5Vo5KwQNH+JD1/bmb+Wbnpt3v7nVRjMsAq7
         4ALCUjSX7gyCplGIWy/lZLpTB/E+vl4ZolLPl8hpVfUSgMqLAArLCQoj7HCrjzcQjXZ9
         0iUdalcsXU3NWY49rJPVkhvNx1FLYaxx3EOD92Jy1gv74ETXlyyjPkr1QyGJ8OSt2YF5
         staLOUACK00ljGr5/zND4wpsQWfWN/I5DnBVaiQhbVPgiMw62d8y3NbeGYjPsSK8Ge0O
         khfw==
X-Gm-Message-State: AOJu0Yw4xeo0Cl+bh2RRHfm8T6CXq3Y6Ph5FH3hmUKmgJ/7w19Gzuvbl
	c+mvRIvMh7dCaXFYCg+l37gijLiEQ5cnq+wcnJOQVV0kbc3UM/ohcYXKYWFQ5FGEC8sump3OqQL
	GI1xjZma/uQ==
X-Gm-Gg: AY/fxX4bFFpAgkykZx++5tddH77rmf6KyXzxm/2Cux/TuivtNI9zZMj//4yp2OOWsgv
	6wpfdshWZOgBfpJvOqKVdzR9baeAIfR/2h3V3K+t88MLAq2V0bQNdEPb3j6bz3EwF7//8vwvSRM
	NpuQvNHJUxfM1O+OaQfQaKm3KdYzzKxqPlrY+jhp/jt6Jd/XAIAa12xxCoRtSMP4pGkDFrwCkX7
	0XbvtPSczLilNBB2dJaOBZHVOO73IotUxO2ofWV466WWGPUBjyCqw9+CRUzXsYJhPbP8BKURbgr
	NY7A4NM1pxtGuAAg5xK8l+b520yYbP7911pxtJSfiqhEAu/kVdjRO4ROzrqmsT+vO+4T6Eb5g69
	UnUWvO0ZXuHGH46lDCwEPA36bVDkzAUnx8pBjfKsUE3XIVeTj0hg11NrZwr2294o1Xp613gRiI5
	iCwjoOg16UhP8TT1eL97TQoBbpbDT/eKgxuk9v4xV7d0pLP6HRR1k0xxXCwmv6q0mlN3zkpw7lT
	silrEy+PdCq7Nw29EU=
X-Google-Smtp-Source: AGHT+IEM5tVVGUrWfLG98MHmNhIow5a0r++vycK4BW8fetjgIojLqN/U5bUKRENay1+Hgy9LCNU5cw==
X-Received: by 2002:a05:600c:4f42:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-47d19556d02mr26397105e9.14.1766144593127;
        Fri, 19 Dec 2025 03:43:13 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a9687dsm35724665e9.3.2025.12.19.03.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 03:43:12 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v3 4/4] doc/bitbake-setup: document "uri" property
Date: Fri, 19 Dec 2025 12:42:58 +0100
Message-ID: <20251219114258.1574787-4-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219114258.1574787-1-corentin.guillevic@smile.fr>
References: <20251219114258.1574787-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 11:43:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18619

The property 'uri' is a simplification of the property 'remotes'. It is
used to provide only one URI.

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 .../bitbake-user-manual-environment-setup.rst        | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index ec1bdeecd..cfa61e460 100644
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
 
+   -  ``uri`` (*optional*): a URI that follows the git URI syntax. Can replace the
+      ``remotes`` structure if only one URI is provided. Despite this, ``uri`` and
+      ``remotes`` can still be used together.
+
+      See https://git-scm.com/docs/git-clone#_git_urls for more information.
+
    -  ``local`` (*optional*): specifies a path on local disk that should be symlinked
       to under ``layers/``. This is useful for local development, where some layer
       or other component used in a build is managed separately, but should still be
-- 
2.51.0


