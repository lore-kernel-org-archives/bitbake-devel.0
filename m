Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF888CFD2F6
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 10:29:45 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15742.1764239377648588230
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Nov 2025 02:29:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dYJDE1Go;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b735487129fso104346366b.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Nov 2025 02:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764239376; x=1764844176; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfmM8KEqgIH1E471HptGzWXy+sjQJ0mJST4EEq/UL9Q=;
        b=dYJDE1GoifevUqCdMj+vUPpvgWoU27FCR8AhI0NcvxeHRzwt4E3JN9is+PdY79Yavp
         0o9vLkRYE1HBAp/yl8SR4iMpBk4oUELfZ/QoOm7Ljf1rtNUKL99kA+Gg0XZknGqUhIYe
         +HLEy7pC4pVb3okyJ7HwsyyOFu0RpLBvZZ1s/imGJe/dF2eR/vZf2OBHqx4O4dd01bSC
         uyw+2oqOFRfWKESU889nRVGx1qs+54frN3UHvcgldj3/L1pXvRcBfMp9zr5zOXexUDH0
         OFPv1dYKONTYoLrBywElYtmpUIl9Qh0NlZck5xrptdsUa2M1rxz6/CzWOjXnqM3NwmsM
         u+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764239376; x=1764844176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZfmM8KEqgIH1E471HptGzWXy+sjQJ0mJST4EEq/UL9Q=;
        b=PsPiRi2QmPUHikvZl5ioXEiQ/ANvCQmUq+XfVVOwTFVGLaF1QriUML6b70ZRnLtsN7
         foMk73pa/MWBkqJqVHWz132J2TJmpTJ1KZErAPUyY8oDMVWBaaB3nqdWpgJAS2DjYcj5
         vZvHqpggXWiCbouU3V2YIb56JjbU02+g9yA4nlfRYTvQbw9IWwH3/wd6l1gLyk8Y9s/T
         QKUZFLQJsZgtqfzUqleKeImizxokE/AIOwXvgEbWtOTj8Ausvg6PgHr5ArPWu+ttTPJW
         JJmt9hLIHC4bQCE1bfiroLUxsJNk947UJNCqTORkqruZYaaOaIVZdHiM/v4Le2dv0GGQ
         H6Dg==
X-Gm-Message-State: AOJu0YwSMq4Gqy01ir163yDZILkqjqX7V1kbS3vLQrPSxKx0Sya0TLmq
	kTY9dado2iqEfDTnBh3B+LIfjgwNxaGiI2CRwl6QICakeLxX3qXYonaTvYJkgg==
X-Gm-Gg: ASbGncuYI2/FZ+Vw15rU+Bo4RTVLNAbmFRY4S7kBN44S4MGw44+hGmp9GcCfgeJCwGn
	cScUZCYGWnvGrP+iGZUNlTt5g51t6uvftmztbPRstYk9IQNjGj3pEqA4LGCij1ounqJWMAlKIsA
	15UmhzCkuq2s/8u9iDTNsJDpQ/Utl1Jmsd5ijjXrY85YdYduPt188wlwmCrTyNZ8YQFBpT8687L
	OSG9hlHOv4PC+7drU45BpvIziLflHrds+3p1fHfzcBLctuF2MvEJY0EgOJWxlckZC4le5GQVSZO
	pPhUKlYKqPTT+IXdtu6ILZ/v48rw3KGkpylv7Dp1sqoX2tboGNJU9zpvoVEMnd99NjpX/Z/oVC6
	ZYVQ02vENrUMnnNki55GmYsSC8PL+EYnjIENfatc7plsAglrm8ZzXvJcPEj4CqlHgQBS351JuNy
	E4RlkdvfjBZ9jWrV7gyY54SsrH0jcXhmEZacoaGIERRpJS+cw9cAY=
X-Google-Smtp-Source: AGHT+IEiwGin/RJC011fQ9nCezRw+HqvxGwFWHvwEmBE/GRtlTwsAvPMMCGWExp3+laLVR92QJHuMA==
X-Received: by 2002:a17:907:3f2a:b0:b76:45bf:ce38 with SMTP id a640c23a62f3a-b76715abc23mr2431412366b.19.1764239375652;
        Thu, 27 Nov 2025 02:29:35 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59a6a74sm122661566b.45.2025.11.27.02.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 02:29:35 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 3/3] bitbake-setup: add whinlatter configs for poky and oe-nodistro
Date: Thu, 27 Nov 2025 11:29:28 +0100
Message-Id: <20251127102928.3647918-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251127102928.3647918-1-alex.kanavin@gmail.com>
References: <20251127102928.3647918-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Nov 2025 10:29:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18502

From: Alexander Kanavin <alex@linutronix.de>

Compared to master, these:
- adjust the branch names (particularly bitbake is at 2.16, making a reference
for matching it with whinlatter branches in layers and docs)
- adjust the description to add "release 5.3 'whinlatter'
- add an 'expires' field so that bitbake-setup can print the date until
the release is supported (and exclude it from 'list' and interactive 'init'
thereafter, unless whinaltter is explicitly asked for).

Bitbake-setup output:

Available configurations:
1. poky-master	Poky - The Yocto Project testing distribution configurations and hardware test platforms
2. oe-nodistro-master	OpenEmbedded - 'nodistro' basic configuration
3. poky-whinlatter	Poky - The Yocto Project testing distribution configurations and hardware test platforms, release 5.3 'whinlatter' (supported until 2026-05-31)
4. oe-nodistro-whinlatter	OpenEmbedded - 'nodistro' basic configuration, release 5.3 'whinlatter' (supported until 2026-05-31)

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 .../oe-nodistro-whinlatter.conf.json          | 56 +++++++++++++
 .../configurations/poky-whinlatter.conf.json  | 80 +++++++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100644 default-registry/configurations/oe-nodistro-whinlatter.conf.json
 create mode 100644 default-registry/configurations/poky-whinlatter.conf.json

diff --git a/default-registry/configurations/oe-nodistro-whinlatter.conf.json b/default-registry/configurations/oe-nodistro-whinlatter.conf.json
new file mode 100644
index 000000000..7b183ae1c
--- /dev/null
+++ b/default-registry/configurations/oe-nodistro-whinlatter.conf.json
@@ -0,0 +1,56 @@
+{
+    "description": "OpenEmbedded - 'nodistro' basic configuration, release 5.3 'whinlatter'",
+    "expires": "2026-05-31",
+    "sources": {
+        "bitbake": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "https://git.openembedded.org/bitbake"
+                    }
+                },
+                "branch": "2.16",
+                "rev": "2.16"
+            }
+        },
+        "openembedded-core": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "https://git.openembedded.org/openembedded-core"
+                    }
+                },
+                "branch": "whinlatter",
+                "rev": "whinlatter"
+            }
+        },
+        "yocto-docs": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "https://git.yoctoproject.org/yocto-docs"
+                    }
+                },
+                "branch": "whinlatter",
+                "rev": "whinlatter"
+            }
+        }
+    },
+    "bitbake-setup": {
+        "configurations": [
+        {
+            "name": "nodistro",
+            "description": "OpenEmbedded 'nodistro'",
+            "setup-dir-name": "oe-nodistro-whinlatter",
+            "bb-layers": ["openembedded-core/meta"],
+            "oe-fragments-one-of": {
+                "machine": {
+                    "description": "Target machines",
+                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64"]
+                }
+            }
+        }
+        ]
+    },
+    "version": "1.0"
+}
diff --git a/default-registry/configurations/poky-whinlatter.conf.json b/default-registry/configurations/poky-whinlatter.conf.json
new file mode 100644
index 000000000..bfa67426d
--- /dev/null
+++ b/default-registry/configurations/poky-whinlatter.conf.json
@@ -0,0 +1,80 @@
+{
+    "description": "Poky - The Yocto Project testing distribution configurations and hardware test platforms, release 5.3 'whinlatter'",
+    "expires": "2026-05-31",
+    "sources": {
+        "bitbake": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "https://git.openembedded.org/bitbake"
+                    }
+                },
+                "branch": "2.16",
+                "rev": "2.16"
+            }
+        },
+        "openembedded-core": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "https://git.openembedded.org/openembedded-core"
+                    }
+                },
+                "branch": "whinlatter",
+                "rev": "whinlatter"
+            }
+        },
+        "meta-yocto": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "https://git.yoctoproject.org/meta-yocto"
+                    }
+                },
+                "branch": "whinlatter",
+                "rev": "whinlatter"
+            }
+        },
+        "yocto-docs": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "https://git.yoctoproject.org/yocto-docs"
+                    }
+                },
+                "branch": "whinlatter",
+                "rev": "whinlatter"
+            }
+        }
+    },
+    "bitbake-setup": {
+        "configurations": [
+        {
+            "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
+            "setup-dir-name": "$distro-whinlatter",
+            "oe-fragments-one-of": {
+                "machine": {
+                    "description": "Target machines",
+                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
+                },
+                "distro": {
+                    "description": "Distribution configuration variants",
+                    "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
+                }
+            },
+            "configurations": [
+            {
+                "name": "poky",
+                "description": "Poky - The Yocto Project testing distribution"
+            },
+            {
+                "name": "poky-with-sstate",
+                "description": "Poky - The Yocto Project testing distribution with internet sstate acceleration. Use with caution as it requires a completely robust local network with sufficient bandwidth.",
+                "oe-fragments": ["core/yocto/sstate-mirror-cdn"]
+            }
+            ]
+        }
+        ]
+    },
+    "version": "1.0"
+}
-- 
2.39.5


