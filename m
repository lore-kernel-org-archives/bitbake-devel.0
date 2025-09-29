Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D9ACCA470
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 12:56:45 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web10.53024.1759150597669412611
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Sep 2025 05:56:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=g4dekBcW;
 spf=pass (domain: gmail.com, ip: 209.85.208.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62fa0653cd1so6686652a12.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 05:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759150596; x=1759755396; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqX9Jd4yw5qApHVpTfwlMm+7dpLTzqZIG/l2k9o0cgA=;
        b=g4dekBcW3Ibh5Oi1TojeIEME1npiz+To8USQWCm/4C+ByqCZed/npD8mH6YZI3z7fA
         2CF9eyBEZWSnpOP8iMJM0yioamLKrr/1BYgnywL9JqY3eNTwHL7DKimST084kbaf6lPP
         y/v1M5FDVTEixDIbsUd475ifMtkbaof1L0Ht10bSuaUPGuK3+n8UWKyloybSkpGySMnh
         v4pjYTe1FbB2a5jCzzfHcSbtxHWchY55oZ+oFxa2SgGv8OKgTSE4DdhsluQzskoCHld3
         ZV5ozyuOCr3t9Kmx//mim+u8T8C2ZQulSS7QxpUI0U08Md4iRMG+rnjupHSrgxRgN3pc
         r/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759150596; x=1759755396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqX9Jd4yw5qApHVpTfwlMm+7dpLTzqZIG/l2k9o0cgA=;
        b=qSjUx6OLEP3LgwCwkDKvpjmfaTx0iUJ20dxg7HSPyo8KuChdMs45XQZKPR/tc1ZGII
         Klusvd85DU2u2hnLsXpzphsagj24VXreaaFiMZLjBsQ3FtRVQt45VffnuI4DIgZLFO0k
         FL9I3sME93n+ZMUqv+vAqar59D9q66BsVa+yhNRnWFAkWDb7wqDu54zp7Rk5oiKyhs3b
         QZGbji4QCSsqQ21wA4kqFTM9qHnBa/silIPi6tgEzzwNga8VTP2w4S4LHtot3rgDDCKc
         BXCiF4FLejoR0kUyXlcG/Je6GspuuzmDUNQgOcWrn3SiCgeciMwUeOY8C2OPhNZVcc18
         LqpQ==
X-Gm-Message-State: AOJu0Yzmusy6+VgstPmWzP9MfD5Cs7dcn99UjTM5SV+J6liZqf3/ozGI
	ftldyLg7fAI7+Oo/b6/L4klJEAPL5C+BRVLa0YHbMuJ057AbdFtwnn8xeNB+0A==
X-Gm-Gg: ASbGncs5DApsC5mzHau7la/3KQt3SajTnmOQiAtlBQ4SuqMndxmsN5Nkh359bOgNTe/
	JOZN+5k5o7dEWn46BwhA/xo3EiiJLrWzmuXvl1T+03yKvgEcNmWf1TebaGNz9XAbVDhKckpunIc
	TmVUTAoXVqDDWaugobV0+JnyVfMfucGW8Zb11jUZ1pJWGDJxLQUO++YtEBed4YCg0PDdBXVFPMq
	rpa0fhdwCKnT5TAKgs+hGOEltlFNNhJIxuaVn1OVLMsYb6pqBy/zKuqvDSxXjAARfiOGyutZm19
	rell8xSdU9uSEvigI1MeibU7VlXAhLlDcbW7uMTmGGXoZS7do1ogat7eQdAIulu5yM2rTzqm1Bn
	OUxuYthaPX6Y1jfPDarjsG0L4nNJKKA/R7vTb5WjC83hFIzapMr7vzQ9MV3LqOB0eZcNXDgzMai
	1ADB6OJdSS9bL5J/jfTBhJ7yZtI4e9oYxO/hSm7KT47Gkldl0CR2KcuugHkbsiHMtWbhUl
X-Google-Smtp-Source: AGHT+IFfY+yod0d7DYkEL1U41llCjg+DWpdxM/LUK4FPn4Fmsl6Sv1xun/UzLWIkwZgTA91B2x27Jw==
X-Received: by 2002:aa7:c708:0:b0:633:d65a:af16 with SMTP id 4fb4d7f45d1cf-6349f9ee8e7mr10927898a12.9.1759150595952;
        Mon, 29 Sep 2025 05:56:35 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634b46dca59sm6575915a12.8.2025.09.29.05.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:56:35 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH 06/10] Add default registry config for OpenEmbedded's nodistro and Yocto Project's poky
Date: Mon, 29 Sep 2025 14:56:12 +0200
Message-Id: <20250929125616.1751116-6-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929125616.1751116-1-alex.kanavin@gmail.com>
References: <20250929125616.1751116-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 12:56:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18105

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Rather than forcing every user to have to access a separate repository
for data for some key defaults, add those for nodistro and poky. This
gives us some commonly used setups and also something to test against too.

We will need to come up with a criteria for adding these, most likely based
on community usage/demand with the OE TSC governing that policy.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../configurations/oe-nodistro.conf.json      | 54 ++++++++++++++
 .../configurations/poky-master.conf.json      | 70 +++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 default-registry/configurations/oe-nodistro.conf.json
 create mode 100644 default-registry/configurations/poky-master.conf.json

diff --git a/default-registry/configurations/oe-nodistro.conf.json b/default-registry/configurations/oe-nodistro.conf.json
new file mode 100644
index 000000000..f4a7492f3
--- /dev/null
+++ b/default-registry/configurations/oe-nodistro.conf.json
@@ -0,0 +1,54 @@
+{
+    "description": "OpenEmbedded - 'nodistro' basic configuration",
+    "sources": {
+        "bitbake": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.openembedded.org/bitbake;protocol=https"
+                    }
+                },
+                "rev": "master"
+            },
+            "path": "bitbake"
+        },
+        "openembedded-core": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.openembedded.org/openembedded-core;protocol=https"
+                    }
+                },
+                "rev": "master"
+            },
+            "path": "openembedded-core"
+        },
+        "yocto-docs": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.yoctoproject.org/yocto-docs;protocol=https"
+                    }
+                },
+                "rev": "master"
+            },
+            "path": "yocto-docs"
+        }
+    },
+    "bitbake-setup": {
+        "configurations": [
+        {
+            "name": "nodistro",
+            "description": "OpenEmbedded 'nodistro'",
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
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
new file mode 100644
index 000000000..227816983
--- /dev/null
+++ b/default-registry/configurations/poky-master.conf.json
@@ -0,0 +1,70 @@
+{
+    "description": "Poky - The Yocto Project testing distribution configurations and hardware test platforms",
+    "sources": {
+        "bitbake": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.openembedded.org/bitbake;protocol=https"
+                    }
+                },
+                "rev": "master"
+            },
+            "path": "bitbake"
+        },
+        "openembedded-core": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.openembedded.org/openembedded-core;protocol=https"
+                    }
+                },
+                "rev": "master"
+            },
+            "path": "openembedded-core"
+        },
+        "meta-yocto": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.yoctoproject.org/meta-yocto;protocol=https"
+                    }
+                },
+                "rev": "master"
+            },
+            "path": "meta-yocto"
+        },
+        "yocto-docs": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "git://git.yoctoproject.org/yocto-docs;protocol=https"
+                    }
+                },
+                "rev": "master"
+            },
+            "path": "yocto-docs"
+        }
+    },
+    "bitbake-setup": {
+        "configurations": [
+        {
+            "name": "poky",
+            "description": "Poky - The Yocto Project testing distribution",
+            "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
+            "oe-fragments": ["core/yocto/sstate-mirror-cdn"],
+            "oe-fragments-one-of": {
+                "machine": {
+                    "description": "Target machines",
+                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
+                },
+                "distro": {
+                    "description": "Distribution configuration variants",
+                    "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
+                }
+            }
+        }
+        ]
+    },
+    "version": "1.0"
+}
-- 
2.39.5


