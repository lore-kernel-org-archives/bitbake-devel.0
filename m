Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC303D7879C
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 16:13:10 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20304.1766160786476406164
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Dec 2025 08:13:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=fhFeAS5x;
 spf=pass (domain: smile.fr, ip: 209.85.128.49, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so11396845e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 08:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1766160785; x=1766765585; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ma4NVhkjtSUmoFMFBl/xlOWpNKtRTxHX3lfQZzkESI=;
        b=fhFeAS5xs4AAqWOY/5zVcAHqc7XqQ0SIGL/bzumWW/LD8HSNSmR10WcRKWYGxRHjkQ
         fkf6lQ6Bqz5996l7jKYPgURBouuCAqw1fFOhcycqMsrcpAPEXm40BaHITu30xN3cLrwO
         ejznQ9TJvnRtsGGfq48BOjFZY5MJQjMfgaL5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766160785; x=1766765585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ma4NVhkjtSUmoFMFBl/xlOWpNKtRTxHX3lfQZzkESI=;
        b=T4aHMAtPG9gfNcvyLobivGdvXppnTMTFrwR67UseC4yQks0vd682s45zSlpm4yRUDp
         Do4tH4tukTFJkqkWjfLgT3TvCoQP+zGVrnwQzQQ+np3iMH0PfZq/Nes2uyImy7BkASpw
         X2sVcUukDm004H9FI/4axQBEs0WDeczgqTk/E85OdtteXFea+cr1n9hCT2Mrlpjg3lEh
         I8UJxDBR9oT+rOPcaEgHwEMvzVz99D4NtIj2v6m71vofU1orXMAN2uI+hXIeoVFB37sT
         o3knUnHOwX2UTSZ0BViHGmwJIRJ8rsh0DeJElEcqI4aiIXHjsJeCOX2G5ezKe2BkphIb
         zlmQ==
X-Gm-Message-State: AOJu0YzwS5ulAVnM3wyH9FckPKxs7ZPbZCH0aIz7CH0EnU0I6PhBgO4S
	cdHQtPWJ15BpP/WQxoWyxTBCJn0ov2Q5c22Gy0w32tD+1ZmfCQF35uq/LIu6p7wxGaEoPMg8X+J
	kL8YJcWo=
X-Gm-Gg: AY/fxX5NXROuwV5aSp+EXbvVqaOmKJuP6sICADQa195vrPT/SEn4OC6Zxwgtlc8cT1f
	iq17e/O0mS5yjrk6v78MVNme7f5jKms5O15nIntH9C/j9nfBCrR+mlSAbS2pGOI0Q7nimPl+/0Y
	UgyOkpqwqccV2IpjFlZ6g0GDzWc1ChjgiGk91C9khyV6q5g1ENDs10cH3SACQ3u5SxbbCKIkjqN
	flXoIRPjYhi/j4WyuiN6A8V+rmnAWwtdQhF6aX9u/WPhwtjuGXl6zVQ8rcj0Jc+eO/RUoTMSUC+
	KGtlmK7CcdiHqNmulQh5fbWJhWeDfPTUdq2uMTvJzvjl/g1uZ0OZM8pCET/lPGMHJo9VZMIr1CH
	ysoNFd51sdEkS8piDlf07oZ4NQ3GPuyQqhOQIdmTxw4oX9bEkZUzjxtO2rVlWQZ3epKur+GgomG
	x9EDluDYGwpSlweuoP95stGSIeffn0GCYgGqeeLBNWoxcNEshuqNSwfiiIEmCtK8/8cZy8yoOCL
	/4N3Ck+IoYG1/cRaWM=
X-Google-Smtp-Source: AGHT+IHABFwTBarxwt9BfT5Yi/LUAZR8XB11Spc/M+eIJdIChdN0TSrNG/mgLtb3pJXu+DFvuYSQoA==
X-Received: by 2002:a05:600c:34d1:b0:477:55ce:f3c3 with SMTP id 5b1f17b1804b1-47d1953b4bbmr29790775e9.5.1766160784901;
        Fri, 19 Dec 2025 08:13:04 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be273f147sm105391065e9.7.2025.12.19.08.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 08:13:04 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v4 3/4] bitbake-setup: use URI shortcut for all configurations
Date: Fri, 19 Dec 2025 17:12:54 +0100
Message-ID: <20251219161255.2293450-3-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219161255.2293450-1-corentin.guillevic@smile.fr>
References: <20251219161255.2293450-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 16:13:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18626

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


