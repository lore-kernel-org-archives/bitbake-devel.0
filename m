Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CDCD10399
	for <webhook@archiver.kernel.org>; Wed, 26 Nov 2025 08:57:34 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9365.1764147450896240166
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Nov 2025 00:57:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dAcFy77K;
 spf=pass (domain: gmail.com, ip: 209.85.218.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b73161849e1so1198278966b.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Nov 2025 00:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764147449; x=1764752249; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfmM8KEqgIH1E471HptGzWXy+sjQJ0mJST4EEq/UL9Q=;
        b=dAcFy77KtBo/hJkv9V5OioqD5NkmD/AWMvY+b05jmC5H/VXsH/jV5SidGiyHvh5dk3
         xe4TS8gFf4iiCG+xtrO/F1TRjz+DW8CrGkQYx18B0M3a38DzrSN/rBDP+nebr0ZXzKnG
         2683MM5f1GRdKhB2xBM7QF0vTux++I/qpektYUYyyq15jpqFqVOOhTlQCNEt46eaRcBQ
         uQNSgZcXkGRhlUUNxDj9riKEAkdwfDpBWxsvzwJb+GixadoCkmoGvCUfbiBVxCcTLcJp
         Wp+nI976mszLY7cH+BE4lxdTFWyVFTeFUGC2G/IIdQaqOWH2z18tjP6MrOXCppkm5PX8
         U2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147449; x=1764752249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfmM8KEqgIH1E471HptGzWXy+sjQJ0mJST4EEq/UL9Q=;
        b=MsY9L64etGnotB+HKUKd0fShH56GIBSS9EX7x8scKyElq79XOq9E7BnQguAWWBPdEs
         bNKBN5bB1WR+vqKxcN/PO+yvRcubPzoZPT/gFMucItGWhA1lmBk62JNhLHTORnx1iefZ
         A/rvM3LiYz2eA0X9pXGyNgSca3hn8+H5q55ispfuWOnwvBQi8oV4bzxB6Sk1eei6Zp3+
         AOCaMT/C7pHRR7KGXXP7E6CaffSpbFsIDBIZaqLKikON5Y2mhbB6gBcPnjxEyZj3sWNO
         /e0mU+otsZpZDaOZDwpdVQRp9YTPmkmrdMf2GncdB5NJOIxsEDCv+HXckEhNGlQQYrI6
         Z7gA==
X-Gm-Message-State: AOJu0Yy50QCqkA3nTTy26eQu6rpoKK/9O2yJQsKTsd17mOR/yF0uPMl8
	2mXG17M0vc98Iv/OV9NY/ol/JFAxTbk7iA/rXilL/+0rB9Evgr+J2S6cXzS+Nw==
X-Gm-Gg: ASbGncuvnGym1zy9f85B42CgH4J13kmj1xWE3Rc0KHPnG/hkjtdIsZy/cjtHzxxlMay
	Vje3BoLdD3reFbWAu/XnTqewCw0bC9CA9cFCyJq7LGpKsaIq4rtjvI94WTc7twXdHfNvSareZHP
	xzwGyyn0JabtEydXuLQA4Uy5aHihT/Y+C2CabA0GlceAcI6A1M9voZDGBOaBP6sHEChAjO6BnIX
	0pm35q6glzg0s/dFIJvXAb4WBjVvAmrKI+YPZ0teN2+iAuiPPqQoCODfKbsCA9cWnJ+vn5+P9Z7
	llKTK9CMtceGv0SpAxQ5JnCmwaoeDKovJSHHj6Kdge+yQu+34kQR559IcYpnupca2r4J+9wQ/1P
	na7fg6d0I0G9KG7pKMJJY8zJQKaAkPaKox3KZ5Dt+qPxWOcEiZtOO401FyOINwgzbSwB39por8K
	CrQBTQWscjP0RJxDwQ4+K2XD3LhYbErk3aOlzSqmKCWVHkW/FY63I=
X-Google-Smtp-Source: AGHT+IGsP1YDPR4bFKxwk7CX6jYdFBJJoQ2lYtzJqdHeJNBU0V3AFrypj8G+t64Ue7l1LcydOpEv2g==
X-Received: by 2002:a17:907:3f93:b0:b72:5a54:1713 with SMTP id a640c23a62f3a-b76718ab1cbmr2292283166b.58.1764147449021;
        Wed, 26 Nov 2025 00:57:29 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cda956sm1956894166b.2.2025.11.26.00.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:57:28 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-setup: add whinlatter configs for poky and oe-nodistro
Date: Wed, 26 Nov 2025 09:57:26 +0100
Message-Id: <20251126085726.2502674-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Nov 2025 08:57:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18495

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


