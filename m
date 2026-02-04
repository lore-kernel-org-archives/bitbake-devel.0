Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BDBE95384
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 11:11:16 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18130.1770203469355122440
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Feb 2026 03:11:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=npm/7GsA;
 spf=pass (domain: smile.fr, ip: 209.85.128.45, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4807068eacbso56170115e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 03:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1770203468; x=1770808268; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKVwEOp0ntMtfEc4cPHk+6OovLRUzOrw6T/U+JRfZI8=;
        b=npm/7GsAktJvg1tdLlYCXegqubRmyR69Yt8THLNOK05QNt66cQBxjpFH2Rm0SEt5je
         El4lYhuPQ4EHKSBLPXd6LLRRaJFNREoo1mQCYWBSafdXmkERmZYkOfFpRlBlXb/KRNSe
         1Jh+GaV3DIH8nl/qf1Et9SBqDl0Jakdj5Xyzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203468; x=1770808268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cKVwEOp0ntMtfEc4cPHk+6OovLRUzOrw6T/U+JRfZI8=;
        b=pgm9iPTrWGsFYfVE06TWdPYHoISw6IXDWhGhsWTxTGi4Gp5QIbQa5h3qvVaGnvPWv1
         5X1nxVdBPOaKDeTx/sngYZoO2Gs54WTAOwn1BRpO9no55SIJxdlHigPmCSeWgBcA1AG2
         KeuldT1RVGEdkO4pW4pj/x1tzlOxdnjZXf/bRRxAyWh0arcJTKU5q4W5MFUal1K5yR6U
         QOfrywvKiSL1QxBXSQN5lhFVk8rT00vyypPKWsIcYRH6Y65FR5T/COGPHtMBk3n1nfBe
         KD9lhDTxUIxHOO6//7QltA1JOicN9ZA/0GhvF0H2WWDy/Itln6Ailr4vqXsicpr45PkR
         HYLg==
X-Gm-Message-State: AOJu0Yyl/ot/x1y19VgNrybrB0Noz50sgZ14zxnPOs+Qui0bZe2SU1sp
	LtakQCeDcux9UZANwcNvBpdQQqC4wOlq4HyeNrz1sVm1xwSDYky2RSiSvmQ8yUa8ANzZvg1agZu
	PTKWi
X-Gm-Gg: AZuq6aIIgAKnvag290z/PREd4U56z56XQpm9AprjTbKpzot8uk2HC+42hO6vkSEbT+8
	Sw4JeZ680x2AYCPwWH9f00ShP0auN3uxxqPYUR82IlSNvzJUKiNeh5oxZmOkIWMc8HQiauqHJB6
	9jY5Bzm1BspQcfqr9bxdmeu1oQGnQiTlEyNkNH1R51GuVjdFbDLodvMSjmcM8IjsqPd+livmlZ8
	hwdlcYrEKrYcrUcFlRcGWncTwRArOCVxFN4NeHoRHRPg/5wpYBk0yKxgdmmmMz1jJEvxhEDact5
	6TLM3YZWjdHWXlcEf0aH6/SrM+erl6y57mewHg0QfmQQL9LmBGeseyHQYwqPntxz6SC11ycNJ5z
	3SJpawGY1AyFCewBjCbc0sYaJ7TRbiudzoxyr+wOafx45nuXY/0UzeKSQoXXwi9uDRJ6rrI0K0O
	gL/XDp0gcgbNsLOYjrjCEfJQFduBrfRKU=
X-Received: by 2002:a05:600c:1c28:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-4830e93203cmr39237255e9.10.1770203467581;
        Wed, 04 Feb 2026 03:11:07 -0800 (PST)
Received: from heaven.lan ([2001:861:3080:b0f0:481f:fde1:912:228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830fc0a3bbsm28824395e9.1.2026.02.04.03.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:11:07 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v7 3/4] bitbake-setup: use URI shortcut for 'master' configuration
Date: Wed,  4 Feb 2026 12:10:50 +0100
Message-ID: <20260204111051.1444641-3-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204111051.1444641-1-corentin.guillevic@smile.fr>
References: <20260204111051.1444641-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 11:11:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18952

Currently, no source has several remotes. So we can replace their entire
structure 'remote' -> 'origin' -> 'uri' with a shorter one (property 'uri'
only).

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 .../oe-nodistro-master.conf.json              | 18 +++-----------
 .../configurations/poky-master.conf.json      | 24 ++++---------------
 2 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/default-registry/configurations/oe-nodistro-master.conf.json b/default-registry/configurations/oe-nodistro-master.conf.json
index 180d2008a..e4e842177 100644
--- a/default-registry/configurations/oe-nodistro-master.conf.json
+++ b/default-registry/configurations/oe-nodistro-master.conf.json
@@ -3,33 +3,21 @@
     "sources": {
         "bitbake": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/bitbake"
-                    }
-                },
+                "uri": "https://git.openembedded.org/bitbake",
                 "branch": "master",
                 "rev": "master"
             }
         },
         "openembedded-core": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/openembedded-core"
-                    }
-                },
+                "uri": "https://git.openembedded.org/openembedded-core",
                 "branch": "master",
                 "rev": "master"
             }
         },
         "yocto-docs": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.yoctoproject.org/yocto-docs"
-                    }
-                },
+                "uri": "https://git.yoctoproject.org/yocto-docs",
                 "branch": "master",
                 "rev": "master"
             }
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
index 1de038bab..82464e8ab 100644
--- a/default-registry/configurations/poky-master.conf.json
+++ b/default-registry/configurations/poky-master.conf.json
@@ -3,44 +3,28 @@
     "sources": {
         "bitbake": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/bitbake"
-                    }
-                },
+                "uri": "https://git.openembedded.org/bitbake",
                 "branch": "master",
                 "rev": "master"
             }
         },
         "openembedded-core": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/openembedded-core"
-                    }
-                },
+                "uri": "https://git.openembedded.org/openembedded-core",
                 "branch": "master",
                 "rev": "master"
             }
         },
         "meta-yocto": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.yoctoproject.org/meta-yocto"
-                    }
-                },
+                "uri": "https://git.yoctoproject.org/meta-yocto",
                 "branch": "master",
                 "rev": "master"
             }
         },
         "yocto-docs": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.yoctoproject.org/yocto-docs"
-                    }
-                },
+                "uri": "https://git.yoctoproject.org/yocto-docs",
                 "branch": "master",
                 "rev": "master"
             }
-- 
2.51.0


