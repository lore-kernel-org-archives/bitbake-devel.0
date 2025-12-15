Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60286D5B170
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 10:33:14 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45580.1765794792223648637
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Dec 2025 02:33:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=rMGSv5Nu;
 spf=pass (domain: smile.fr, ip: 209.85.221.49, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42e2e628f8aso1380689f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 02:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1765794791; x=1766399591; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ma4NVhkjtSUmoFMFBl/xlOWpNKtRTxHX3lfQZzkESI=;
        b=rMGSv5Nu6+5Nge/wQS/NFJ52owvtAOzgHE3+9eKtgWD0NVHyhDhSjzc+x9wyeybV1D
         tBn8kQdLdd9elqU3pF+Y90zmVRnb7zFz6+fFEALsOVfj5X59pR0HRzpWLXizvmegfnwl
         Hp8bIVLFFO3kUwCV56Zdmbqm0fcPLZGMEFbjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765794791; x=1766399591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ma4NVhkjtSUmoFMFBl/xlOWpNKtRTxHX3lfQZzkESI=;
        b=v5LuXo6kHqm+oQ0bVwMxLj6hdJo0lLm+ojQaq++I56iOPSDTFHed/KMmIVPeVVzUBo
         paeF8d3qF4/6YVMYyMCPseAFvv6JrKv1S6L6PIGCONdiIzrYkusMDwj8mbJOq2sBo5sL
         IcpFRM5rxVQOHkZgKeujYyZQyvHy4NJIEVoPumsC8PHlP5ewYegFtvPLRt1Hkecfk5MW
         0i08No2Le5K8Sv3LEDZZA9YJmZaBp8V4hTTVVWqFvkUjB9S3YFAKChqojLwPKPeF54QN
         UMI40Weh9fk+iH1xYkV0EDErFfwN9/KRMtdUc+tnSqvloAyphaXzqzgyE6rb5UWiJbz8
         wgGw==
X-Gm-Message-State: AOJu0Yw+bVNnnUTl5eJuo4/KOIA9ovkHIIi4vxdhu4cSdUdcaJkyo0rE
	tvegOB0A8BrCEkqVHyh+jO/eLCU3KDJ9BMF7UfJfQc/7YD4j7NTzjxXKyi83kE1AG8+3IMuIO8r
	uFDm4cMc=
X-Gm-Gg: AY/fxX4ciB/7ibQixRCO0OEk2zKRQNdrgdNExg/0PqfgUL696R3LQg1iBb8RXYPjryV
	O2USQxe9q/N40jvxUqigmtKobLJS940YtuUO0wPg/fikLKAvu6TzmR3Jm6jGgoZoSfjd8Y9FrwP
	Ck6zk6UHzufw3cEydDoZBPG0xLCPsEb4l1GW2VMYQgTKiy1LN6WMpQaGyVDTDNkDKt1jnw4nfqA
	fX4zRPznYtO9xThjGhyIZeIF4jp/YwIITXXXWx25Trw3qVNobxrW9sELEe4DSQsfyE5xuxm+02M
	YYfcvE2qknQhrKwtdbi4puUpH9y5Ybizdp9TfPvMOkZcMNxKrfTb2P+oZI5v/RRimToZAnYmnF2
	mZ4/mvj5np2sQ2h3YrYenro72MvUpY7SdQTt9QW4luD85GNDEDzjvG5DBWLu0pJ9ovsuQFsdgPp
	lCtbPriyLgWEyFY1XjMFLspv/KDjh5TIIdAMWnbZohIjQ81tZbldgWBdklRTEC9g0TO9kwlSR33
	dDEIjLtWsFUU0+wuMzVJdtSjDmnHQ==
X-Google-Smtp-Source: AGHT+IFKwI77LRMqjzxDk4dTfEkFihz7EWQBsqbFi/3WoNkYEkx+ecxUhfmRPosqeN0aXiv+d/r3yA==
X-Received: by 2002:a05:6000:2285:b0:42b:3b8a:308c with SMTP id ffacd0b85a97d-42fb46ec08fmr11311663f8f.42.1765794790578;
        Mon, 15 Dec 2025 02:33:10 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b85d1esm28676257f8f.26.2025.12.15.02.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 02:33:10 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v2 3/3] bitbake-setup: use URI shortcut for all configurations
Date: Mon, 15 Dec 2025 11:32:56 +0100
Message-ID: <20251215103256.902711-3-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215103256.902711-1-corentin.guillevic@smile.fr>
References: <20251215103256.902711-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 10:33:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18586

Currently, no source has several remotes. So we can replace their entire
structure 'remote' -> 'origin' -> 'uri' with a shorter one (property 'uri'
only).

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---
 .../oe-nodistro-master.conf.json              | 18 +++-----------
 .../oe-nodistro-whinlatter.conf.json          | 18 +++-----------
 .../configurations/poky-master.conf.json      | 24 ++++---------------
 .../configurations/poky-whinlatter.conf.json  | 24 ++++---------------
 4 files changed, 14 insertions(+), 70 deletions(-)

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
diff --git a/default-registry/configurations/oe-nodistro-whinlatter.conf.json b/default-registry/configurations/oe-nodistro-whinlatter.conf.json
index 7b183ae1c..8342f2cf5 100644
--- a/default-registry/configurations/oe-nodistro-whinlatter.conf.json
+++ b/default-registry/configurations/oe-nodistro-whinlatter.conf.json
@@ -4,33 +4,21 @@
     "sources": {
         "bitbake": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/bitbake"
-                    }
-                },
+                "uri": "https://git.openembedded.org/bitbake",
                 "branch": "2.16",
                 "rev": "2.16"
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
                 "branch": "whinlatter",
                 "rev": "whinlatter"
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
                 "branch": "whinlatter",
                 "rev": "whinlatter"
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
diff --git a/default-registry/configurations/poky-whinlatter.conf.json b/default-registry/configurations/poky-whinlatter.conf.json
index bfa67426d..80b3c7f8c 100644
--- a/default-registry/configurations/poky-whinlatter.conf.json
+++ b/default-registry/configurations/poky-whinlatter.conf.json
@@ -4,44 +4,28 @@
     "sources": {
         "bitbake": {
             "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/bitbake"
-                    }
-                },
+                "uri": "https://git.openembedded.org/bitbake",
                 "branch": "2.16",
                 "rev": "2.16"
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
                 "branch": "whinlatter",
                 "rev": "whinlatter"
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
                 "branch": "whinlatter",
                 "rev": "whinlatter"
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
                 "branch": "whinlatter",
                 "rev": "whinlatter"
             }
-- 
2.51.0


