Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282A5E6F07C
	for <webhook@archiver.kernel.org>; Tue, 23 Dec 2025 10:18:13 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.98377.1766485087103952532
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Dec 2025 02:18:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=WuUGCfzu;
 spf=pass (domain: smile.fr, ip: 209.85.128.53, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47a8195e515so33390535e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Dec 2025 02:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1766485085; x=1767089885; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ma4NVhkjtSUmoFMFBl/xlOWpNKtRTxHX3lfQZzkESI=;
        b=WuUGCfzuWvUqa/aTnOoQ6OOqfBJyZrmxkXGc5BO3Gh0EDEFu6rS9307rdX4zb3R3f2
         FZrpkvTS6avaqYq8yyE2j0ITEfx8fzI0boa8f4YJZrfPcLMKWjCA1PqhS2duU8x3UDpi
         uMwLj3JRzzcZjJ1vNakDGJl88EAZscHeK6zOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766485085; x=1767089885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ma4NVhkjtSUmoFMFBl/xlOWpNKtRTxHX3lfQZzkESI=;
        b=bE1n/9XTWKGjAdWmDR+U/r3VKzXgGXLtqAOrL0Bk0KEVynBdBEteUnV7fxGIaR9dCn
         4ZD4aJynge1WVq8N8VMJN4lpvdRSavl3Xk5O2bTN520UDWLShOouepFaa1xyyuTvMi42
         7Ov6CPmxzbwoTSC8MtGUJVXEgNKiw0c0M0wudLXoEeTREE9Jr10kdcVIBP+IJhOsx3pR
         3e9zMt5RENR2okL3dvsl7V8kXz6+DEAhTftADVwMowNgIUV/LVw0Rx0kS9rxDzC3QN9n
         ZraD01eZaJOIOtTPbdtgNhgB8IFh77wJePpTWYiN5V36QkfttWVLiGLvbjsJiCe08Rdl
         xgmQ==
X-Gm-Message-State: AOJu0YwCjq7hGZI8GhuDOIA/w6VOKifitBrK2j5ZYy5ER4pOejT1qxmU
	0cbXpFOQddZQmPSe9N76EghM8eIYT4XiJ0zm/Z6siocikz7o3cIAMVl93NNQQIDHc5eRt5hvMy0
	LvUIMPrg=
X-Gm-Gg: AY/fxX6OxwsGnYxY0SCqS8J79iGmp5NmUF8FPFB70QExYts3yPBQATvSoNKrbFQm1px
	y0IJO8O3U7oaIMlb3f9l2PA9KTdb6857U748ycYQ20S4irji85ZielDQa8Tqk0kT7pljdM7oqkf
	xwLkKoA06pAEoYZYNXXOAzMc5mecYEVWvh8Px86HBYKoWTyUNpQ2fDehjBH7z9244KQXLoKzSny
	a0DrTwSYbjo5K9sGDNisxX4EYn2PrbwjU1YSxSz2hpfUc3X1W8o9eU3b6O1/ZwfpLIBDBhULLlt
	Mf0FLsUmd8d4RmJmWNC1dgCVrwoWdvID7vdLepF4PdkeX+EtLHsMKiTas/qKSwRn/SX6POeKTYl
	c0wKeyOJhFLs84wryrVStkcAHNoweLvLAH67JoYAM/OQyNj3lblrt4FLUw2QsCRvBwdoWSNZaZ5
	P/eLfnc8+qX5c3Gz4=
X-Google-Smtp-Source: AGHT+IGs2AXutsPXg98DCZA5DifK0r3ZK3ML8RzqlQ6WaQDRoMlmgcmgci64bVjpLaGly3FH81WhjQ==
X-Received: by 2002:a05:600d:108:20b0:477:214f:bd95 with SMTP id 5b1f17b1804b1-47d1c036d6cmr106964915e9.23.1766485085438;
        Tue, 23 Dec 2025 02:18:05 -0800 (PST)
Received: from heaven ([2a01:e0a:25d:d2b0:4eb0:a6f9:d3f9:1686])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab257asm27428376f8f.38.2025.12.23.02.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 02:18:05 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v5 3/4] bitbake-setup: use URI shortcut for all configurations
Date: Tue, 23 Dec 2025 11:17:55 +0100
Message-ID: <20251223101757.1057188-3-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223101757.1057188-1-corentin.guillevic@smile.fr>
References: <20251223101757.1057188-1-corentin.guillevic@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Dec 2025 10:18:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18645

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


