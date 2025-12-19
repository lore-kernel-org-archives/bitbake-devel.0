Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6111D767F7
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 11:43:18 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15103.1766144593732406878
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Dec 2025 03:43:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=nutCpvx+;
 spf=pass (domain: smile.fr, ip: 209.85.128.49, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775ae77516so15939965e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 03:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1766144592; x=1766749392; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ma4NVhkjtSUmoFMFBl/xlOWpNKtRTxHX3lfQZzkESI=;
        b=nutCpvx+K8A7kVV21znVjybEtsRt2KLN1O71jy1iTUaNCIgP3iBGdAO8hVCq0y9Xht
         s5WPzR/7zEJn4ccgU/I+2qb0aWrWcgg6UUXHBvhitcC8s7y4byHgldYHshzEoAuU3bTD
         qVtmqAeRYKC/T6c/M/lkN63+LPG/6pK8sq+L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766144592; x=1766749392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ma4NVhkjtSUmoFMFBl/xlOWpNKtRTxHX3lfQZzkESI=;
        b=uxndtpBH9SJHRcbNkVKbHmg6DImyAXgD71oeV0HK85p77iUO+5G7YECUKDsL22hvTi
         ovaE5AhPKyAALxXqrrKv3QdMP4a3f7kPWmzeEwu/8vrH+s7qHBXjzf8hiMDGYpQKOSGK
         A69h34ZkionRS1jqJ5TmI8T1AtjT+U7M4lO3VLkHoMlVAUy/FPM1flG2mD9kZYNDKYdv
         gZJHT7xXJSzIL6H+rzQoZAFGpvp6KcztZw9jemEXTpWywJUcqxhdt8tLiTP1XdX5SVWG
         8OE1I273nk3fa0qx1kyBEgEDfab3WElXBxZq4Do0DPMKzTVcDhG2UaO2GGcVmjs8NPl5
         9IdA==
X-Gm-Message-State: AOJu0YyDiYGVBE90Lq3JssWKQ3pqooKU+Su2xDWzCPuE7gP8wrnQ5JEq
	srxvxyKTuzIlOOeTUPYbkBGR21OlO3TA51dm1jSY+IVNM7KxqVEmpZVsXb1psqUZ5J1zEffTE/A
	6Vy0ROCo=
X-Gm-Gg: AY/fxX7lFgkRbPVqPOL5JTYxp9pKWTcWDoHdbl9LIlAvG98qaor+yTtVE9eIG1fGta7
	Id85f1yVnJBNsFaLJjU55WFwyd+YB0+Jy8PowNmghh+WcfiyuIQN/lnohTEB+ueQ2b3PvBCxWOE
	2i96HMKaB6lYv9vZfYCa+gsTBAqehYz8isXyC62gntc5AC08UkKwliIVKXyYNDeVUpy7E8TAQNO
	wNQQY3a9EFsJYeHPu2X080Dxg1Wvb1+YVc/m0/9PgROHged3n7nekopvTu1S5A7uQr0LrU7Dulh
	2qyTOSWbS7R9YwI1yE3xWrqo7UJxmvK0R03ghmWbiMVLyBwXICcbRq6XQjjqbslojq2I7sya+Yu
	WQX31rdSU2WCsJ6J29eUO+elP+jIPh0PrXLUhH5uDdO5WI73KH4GAzoeHYWqyulg5HlA1VpAC9T
	5UuCQXW7P/53jX/lfKdVUzieY7rpaxw64GGkfMspcAqYHg412Nvy7AsyBPR9x5Lvz6vZhZodxgB
	yHRpmTGHO2sH4/q3uE=
X-Google-Smtp-Source: AGHT+IHr/gAqf/x3ZRK+5UH2Zsjs5E7I2j0U1L21hrOi+SQaAls9P8X1U5GMru1vxvwEZq11Lz1hFg==
X-Received: by 2002:a05:600c:348a:b0:477:95a0:fe95 with SMTP id 5b1f17b1804b1-47d195ab61fmr21528435e9.24.1766144592150;
        Fri, 19 Dec 2025 03:43:12 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a9687dsm35724665e9.3.2025.12.19.03.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 03:43:11 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v3 3/4] bitbake-setup: use URI shortcut for all configurations
Date: Fri, 19 Dec 2025 12:42:57 +0100
Message-ID: <20251219114258.1574787-3-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219114258.1574787-1-corentin.guillevic@smile.fr>
References: <20251219114258.1574787-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 11:43:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18618

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


