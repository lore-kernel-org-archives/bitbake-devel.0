Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FF0CD98F2
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 18:04:30 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25621.1781805864510996231
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2026 11:04:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=sRmQ99KH;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490cdae130cso6887025e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781805863; x=1782410663; darn=lists.openembedded.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YL30OI4WmxSOO0M0zsOxxSU0PfLi+oRqbji9Yx0txQ0=;
        b=sRmQ99KHkW9Vw8HJozrwJp65l5KzMxnHdZV5f+nkS8BXyOIcRh5NL6uf95O4t9nsuA
         urka2eZDo6OT+AdUdRz6IaRF3Ef7Y1Zud/QqnopcbyR11b8TxC0IboIGnj8+wJE9wktC
         RzJpOkGqmjo9f8jtvRsM5skjXQhloWZqWqFuXilBCrh+1trDl1GZ9tErDTjtUBJE6Rf2
         M6dimG8NgceskQzdQbfgTRKHZ0ndnNPIpIWhQ16pCjhLikgac7ous12lTNaezXCVc+bZ
         dN53stc928ztXSyRclFCHFiMZLchMywkYjc6dMmPsm/TvZwscDA6PeYz1kijBybxbXHW
         YsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781805863; x=1782410663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YL30OI4WmxSOO0M0zsOxxSU0PfLi+oRqbji9Yx0txQ0=;
        b=HbR3XDLj6SSpKMlKu9DEO5z848OIBI6hAWZQVBUtFxkITO9bUSLGN34UWQuj6kRGse
         si7mNASwdKcX2jO2n1+Ng555YNY68/87rDfs0KwdXAB13H/rMJ8wq+kzDAZ38p535j25
         J4aZyyWUuaImH0o0dt/1GR1HIUS64DNGHBcZarvlGcZffha8Jm+hfpAM/zlGcnBBhbdc
         +RfPkrJUOWziC8Fbxf3qH2bk6ZtMuOB5zjkCtfTs+HNp7D14AsJeiJHHqwaF9vXVtkYD
         XggFXv3eDrqjWOe+lsWSedmOmzbppmucxaD7HpgChV63vdkfhtJwbfVsi/3LIaKFuVoG
         sEBg==
X-Gm-Message-State: AOJu0Yxj8aiawPkAEKBp4qaztWrUMM6RgniIg4wqrGG8zE0klJddZjEG
	oGOLf6HAK16swKLCeW2E0Qi5dAmkFlMii8UDagR6RiwBAwYESmOMpdegzA5O9llQ
X-Gm-Gg: AfdE7clDs4iriFkFgR/U1NWqLkEA2FW5AeGrI5fVsCoPbRe1wYyB/NJI2xpOmLdpEjU
	hGVOvM1DitK1MBAy/GsZKxdbjuTIjlV1Db18AGt8AAEOma/4CuKzWS9gUD5om8lCewzeos7zRAA
	84KaIGVkcnNBt3PTFD1WWEmafvXSeGfcZZbojkNAHzmVOopbqqi+sNREfqwi5AgWnKvRRGpIuxZ
	E6/yhWQ/3CHI3zeBuWn+As3ljJhHPxJh58+SntyqksXp6G4uZ4iEnkGEYEwvOy3TVTKezuSX9cD
	EiSwyDU6xR1S/PMK+zvUeMF6bM+KIr3VNvE9iNh2C5XXpnSXBwyFgcfppHIM7vFpldBxRyWfFVk
	FvS9xabq2bjQ8G8HCoBlBJytzn3D2Hn15tiEYObboVqDYEWxvpMs6ja/6WolFGokMWD9pYHxAcC
	IMIMGqIfXYbTixZfmAWVY869IyYtlAB7/AGzyil/EUKqYdRmHFxUYUF3LHZ+cz12G0PuxC6Yib+
	ZGBCWjKWg/naB4G
X-Received: by 2002:a05:600c:c4a4:b0:48f:e26a:1744 with SMTP id 5b1f17b1804b1-4923f1503bfmr14453275e9.9.1781805862395;
        Thu, 18 Jun 2026 11:04:22 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47b48sm7813665e9.0.2026.06.18.11.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:04:21 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Thu, 18 Jun 2026 20:04:05 +0200
Subject: [PATCH RFC v2 2/2] default-registry: consolidate OE and Poky
 release configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-bb-setup-source-choices-integrated-tests-v2-2-66b3b438f073@toradex.com>
References: <20260618-bb-setup-source-choices-integrated-tests-v2-0-66b3b438f073@toradex.com>
In-Reply-To: <20260618-bb-setup-source-choices-integrated-tests-v2-0-66b3b438f073@toradex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 18:04:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19744

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Replace the release-specific OE nodistro and Poky registry files with
one configuration file for each project. The new files use
source-choices to select the master, whinlatter or wrynose source set.

This keeps the shared setup configuration in one place while preserving
the different source revisions and expiry metadata for each release.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 .../configurations/oe-nodistro-master.conf.json    |  47 ------
 .../oe-nodistro-whinlatter.conf.json               |  56 -------
 .../configurations/oe-nodistro-wrynose.conf.json   |  48 ------
 .../configurations/oe-nodistro.conf.json           | 117 +++++++++++++++
 .../configurations/poky-master.conf.json           |  73 ----------
 .../configurations/poky-whinlatter.conf.json       |  80 ----------
 .../configurations/poky-wrynose.conf.json          |  74 ----------
 default-registry/configurations/poky.conf.json     | 161 +++++++++++++++++++++
 8 files changed, 278 insertions(+), 378 deletions(-)

diff --git a/default-registry/configurations/oe-nodistro-master.conf.json b/default-registry/configurations/oe-nodistro-master.conf.json
deleted file mode 100644
index 5aa148d4217e..000000000000
--- a/default-registry/configurations/oe-nodistro-master.conf.json
+++ /dev/null
@@ -1,47 +0,0 @@
-{
-    "description": "OpenEmbedded - 'nodistro' basic configuration",
-    "sources": {
-        "bitbake": {
-            "git-remote": {
-                "uri": "https://git.openembedded.org/bitbake",
-                "branch": "master",
-                "rev": "master"
-            }
-        },
-        "openembedded-core": {
-            "git-remote": {
-                "uri": "https://git.openembedded.org/openembedded-core",
-                "branch": "master",
-                "rev": "master"
-            }
-        },
-        "yocto-docs": {
-            "git-remote": {
-                "uri": "https://git.yoctoproject.org/yocto-docs",
-                "branch": "master",
-                "rev": "master"
-            }
-        }
-    },
-    "bitbake-setup": {
-        "configurations": [
-        {
-            "name": "nodistro",
-            "description": "OpenEmbedded 'nodistro'",
-            "setup-dir-name": "oe-nodistro-master",
-            "bb-layers": ["openembedded-core/meta"],
-            "oe-fragments-one-of": {
-                "machine": {
-                    "description": "Target machines",
-                    "options" : [
-                        { "name": "machine/qemux86-64", "description": "x86-64 system on QEMU" },
-                        { "name": "machine/qemuarm64", "description": "ARMv8 system on QEMU" },
-                        { "name": "machine/qemuriscv64", "description": "RISC-V system on QEMU" }
-                    ]
-                }
-            }
-        }
-        ]
-    },
-    "version": "1.0"
-}
diff --git a/default-registry/configurations/oe-nodistro-whinlatter.conf.json b/default-registry/configurations/oe-nodistro-whinlatter.conf.json
deleted file mode 100644
index 7b183ae1c438..000000000000
--- a/default-registry/configurations/oe-nodistro-whinlatter.conf.json
+++ /dev/null
@@ -1,56 +0,0 @@
-{
-    "description": "OpenEmbedded - 'nodistro' basic configuration, release 5.3 'whinlatter'",
-    "expires": "2026-05-31",
-    "sources": {
-        "bitbake": {
-            "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/bitbake"
-                    }
-                },
-                "branch": "2.16",
-                "rev": "2.16"
-            }
-        },
-        "openembedded-core": {
-            "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/openembedded-core"
-                    }
-                },
-                "branch": "whinlatter",
-                "rev": "whinlatter"
-            }
-        },
-        "yocto-docs": {
-            "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.yoctoproject.org/yocto-docs"
-                    }
-                },
-                "branch": "whinlatter",
-                "rev": "whinlatter"
-            }
-        }
-    },
-    "bitbake-setup": {
-        "configurations": [
-        {
-            "name": "nodistro",
-            "description": "OpenEmbedded 'nodistro'",
-            "setup-dir-name": "oe-nodistro-whinlatter",
-            "bb-layers": ["openembedded-core/meta"],
-            "oe-fragments-one-of": {
-                "machine": {
-                    "description": "Target machines",
-                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64"]
-                }
-            }
-        }
-        ]
-    },
-    "version": "1.0"
-}
diff --git a/default-registry/configurations/oe-nodistro-wrynose.conf.json b/default-registry/configurations/oe-nodistro-wrynose.conf.json
deleted file mode 100644
index 278ce4dd0296..000000000000
--- a/default-registry/configurations/oe-nodistro-wrynose.conf.json
+++ /dev/null
@@ -1,48 +0,0 @@
-{
-    "description": "OpenEmbedded - 'nodistro' basic configuration, release 6.0 'wrynose'",
-    "expires": "2030-05-31",
-    "sources": {
-        "bitbake": {
-            "git-remote": {
-                "uri": "https://git.openembedded.org/bitbake",
-                "branch": "2.18",
-                "rev": "2.18"
-            }
-        },
-        "openembedded-core": {
-            "git-remote": {
-                "uri": "https://git.openembedded.org/openembedded-core",
-                "branch": "wrynose",
-                "rev": "wrynose"
-            }
-        },
-        "yocto-docs": {
-            "git-remote": {
-                "uri": "https://git.yoctoproject.org/yocto-docs",
-                "branch": "wrynose",
-                "rev": "wrynose"
-            }
-        }
-    },
-    "bitbake-setup": {
-        "configurations": [
-        {
-            "name": "nodistro",
-            "description": "OpenEmbedded 'nodistro'",
-            "setup-dir-name": "oe-nodistro-wrynose",
-            "bb-layers": ["openembedded-core/meta"],
-            "oe-fragments-one-of": {
-                "machine": {
-                    "description": "Target machines",
-                    "options" : [
-                        { "name": "machine/qemux86-64", "description": "x86-64 system on QEMU" },
-                        { "name": "machine/qemuarm64", "description": "ARMv8 system on QEMU" },
-                        { "name": "machine/qemuriscv64", "description": "RISC-V system on QEMU" }
-                    ]
-                }
-            }
-        }
-        ]
-    },
-    "version": "1.0"
-}
diff --git a/default-registry/configurations/oe-nodistro.conf.json b/default-registry/configurations/oe-nodistro.conf.json
new file mode 100644
index 000000000000..02554cbf10aa
--- /dev/null
+++ b/default-registry/configurations/oe-nodistro.conf.json
@@ -0,0 +1,117 @@
+{
+    "description": "OpenEmbedded - 'nodistro' basic configuration",
+    "source-choices": {
+        "master": {
+            "description": "OpenEmbedded 'nodistro' development branch",
+            "sources": {
+                "bitbake": {
+                    "git-remote": {
+                        "uri": "https://git.openembedded.org/bitbake",
+                        "branch": "master",
+                        "rev": "master"
+                    }
+                },
+                "openembedded-core": {
+                    "git-remote": {
+                        "uri": "https://git.openembedded.org/openembedded-core",
+                        "branch": "master",
+                        "rev": "master"
+                    }
+                },
+                "yocto-docs": {
+                    "git-remote": {
+                        "uri": "https://git.yoctoproject.org/yocto-docs",
+                        "branch": "master",
+                        "rev": "master"
+                    }
+                }
+            }
+        },
+        "whinlatter": {
+            "description": "OpenEmbedded 'nodistro', release 5.3 'whinlatter'",
+            "expires": "2026-05-31",
+            "sources": {
+                "bitbake": {
+                    "git-remote": {
+                        "remotes": {
+                            "origin": {
+                                "uri": "https://git.openembedded.org/bitbake"
+                            }
+                        },
+                        "branch": "2.16",
+                        "rev": "2.16"
+                    }
+                },
+                "openembedded-core": {
+                    "git-remote": {
+                        "remotes": {
+                            "origin": {
+                                "uri": "https://git.openembedded.org/openembedded-core"
+                            }
+                        },
+                        "branch": "whinlatter",
+                        "rev": "whinlatter"
+                    }
+                },
+                "yocto-docs": {
+                    "git-remote": {
+                        "remotes": {
+                            "origin": {
+                                "uri": "https://git.yoctoproject.org/yocto-docs"
+                            }
+                        },
+                        "branch": "whinlatter",
+                        "rev": "whinlatter"
+                    }
+                }
+            }
+        },
+        "wrynose": {
+            "description": "OpenEmbedded 'nodistro', release 6.0 'wrynose'",
+            "expires": "2030-05-31",
+            "sources": {
+                "bitbake": {
+                    "git-remote": {
+                        "uri": "https://git.openembedded.org/bitbake",
+                        "branch": "2.18",
+                        "rev": "2.18"
+                    }
+                },
+                "openembedded-core": {
+                    "git-remote": {
+                        "uri": "https://git.openembedded.org/openembedded-core",
+                        "branch": "wrynose",
+                        "rev": "wrynose"
+                    }
+                },
+                "yocto-docs": {
+                    "git-remote": {
+                        "uri": "https://git.yoctoproject.org/yocto-docs",
+                        "branch": "wrynose",
+                        "rev": "wrynose"
+                    }
+                }
+            }
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
+                    "options" : [
+                        { "name": "machine/qemux86-64", "description": "x86-64 system on QEMU" },
+                        { "name": "machine/qemuarm64", "description": "ARMv8 system on QEMU" },
+                        { "name": "machine/qemuriscv64", "description": "RISC-V system on QEMU" }
+                    ]
+                }
+            }
+        }
+        ]
+    },
+    "version": "1.0"
+}
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
deleted file mode 100644
index 58d379648a31..000000000000
--- a/default-registry/configurations/poky-master.conf.json
+++ /dev/null
@@ -1,73 +0,0 @@
-{
-    "description": "Poky - The Yocto Project testing distribution configurations and hardware test platforms",
-    "sources": {
-        "bitbake": {
-            "git-remote": {
-                "uri": "https://git.openembedded.org/bitbake",
-                "branch": "master",
-                "rev": "master"
-            }
-        },
-        "openembedded-core": {
-            "git-remote": {
-                "uri": "https://git.openembedded.org/openembedded-core",
-                "branch": "master",
-                "rev": "master"
-            }
-        },
-        "meta-yocto": {
-            "git-remote": {
-                "uri": "https://git.yoctoproject.org/meta-yocto",
-                "branch": "master",
-                "rev": "master"
-            }
-        },
-        "yocto-docs": {
-            "git-remote": {
-                "uri": "https://git.yoctoproject.org/yocto-docs",
-                "branch": "master",
-                "rev": "master"
-            }
-        }
-    },
-    "bitbake-setup": {
-        "configurations": [
-        {
-            "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
-            "setup-dir-name": "$distro-master",
-            "oe-fragments-one-of": {
-                "machine": {
-                    "description": "Target machines",
-                    "options" : [
-                        { "name": "machine/qemux86-64", "description": "x86-64 system on QEMU" },
-                        { "name": "machine/qemuarm64", "description": "ARMv8 system on QEMU" },
-                        { "name": "machine/qemuriscv64", "description": "RISC-V system on QEMU" },
-                        { "name": "machine/genericarm64", "description": "Arm64 SystemReady IR/ES platforms" },
-                        { "name": "machine/genericx86-64", "description": "x86_64 (64-bit) PCs and servers" }
-                    ]
-                },
-                "distro": {
-                    "description": "Target distributions",
-                    "options" : [
-                        { "name": "distro/poky", "description": "Yocto Project Reference Distro" },
-                        { "name": "distro/poky-altcfg", "description": "Poky alternative with systemd as init manager" },
-                        { "name": "distro/poky-tiny", "description": "Poky alternative optimized for size" }
-                    ]
-                }
-            },
-            "configurations": [
-            {
-                "name": "poky",
-                "description": "Poky - The Yocto Project testing distribution"
-            },
-            {
-                "name": "poky-with-sstate",
-                "description": "Poky - The Yocto Project testing distribution with internet sstate acceleration. Use with caution as it requires a completely robust local network with sufficient bandwidth.",
-                "oe-fragments": ["core/yocto/sstate-mirror-cdn"]
-            }
-            ]
-        }
-        ]
-    },
-    "version": "1.0"
-}
diff --git a/default-registry/configurations/poky-whinlatter.conf.json b/default-registry/configurations/poky-whinlatter.conf.json
deleted file mode 100644
index 4827ebe11483..000000000000
--- a/default-registry/configurations/poky-whinlatter.conf.json
+++ /dev/null
@@ -1,80 +0,0 @@
-{
-    "description": "Poky - The Yocto Project testing distribution configurations and hardware test platforms, release 5.3 'whinlatter'",
-    "expires": "2026-05-31",
-    "sources": {
-        "bitbake": {
-            "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/bitbake"
-                    }
-                },
-                "branch": "2.16",
-                "rev": "2.16"
-            }
-        },
-        "openembedded-core": {
-            "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.openembedded.org/openembedded-core"
-                    }
-                },
-                "branch": "whinlatter",
-                "rev": "whinlatter"
-            }
-        },
-        "meta-yocto": {
-            "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.yoctoproject.org/meta-yocto"
-                    }
-                },
-                "branch": "whinlatter",
-                "rev": "whinlatter"
-            }
-        },
-        "yocto-docs": {
-            "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "https://git.yoctoproject.org/yocto-docs"
-                    }
-                },
-                "branch": "whinlatter",
-                "rev": "whinlatter"
-            }
-        }
-    },
-    "bitbake-setup": {
-        "configurations": [
-        {
-            "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
-            "setup-dir-name": "$distro-whinlatter",
-            "oe-fragments-one-of": {
-                "machine": {
-                    "description": "Target machines",
-                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
-                },
-                "distro": {
-                    "description": "Target Distributions",
-                    "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
-                }
-            },
-            "configurations": [
-            {
-                "name": "poky",
-                "description": "Poky - The Yocto Project testing distribution"
-            },
-            {
-                "name": "poky-with-sstate",
-                "description": "Poky - The Yocto Project testing distribution with internet sstate acceleration. Use with caution as it requires a completely robust local network with sufficient bandwidth.",
-                "oe-fragments": ["core/yocto/sstate-mirror-cdn"]
-            }
-            ]
-        }
-        ]
-    },
-    "version": "1.0"
-}
diff --git a/default-registry/configurations/poky-wrynose.conf.json b/default-registry/configurations/poky-wrynose.conf.json
deleted file mode 100644
index d27928437735..000000000000
--- a/default-registry/configurations/poky-wrynose.conf.json
+++ /dev/null
@@ -1,74 +0,0 @@
-{
-    "description": "Poky - The Yocto Project testing distribution configurations and hardware test platforms, release 6.0 'wrynose'",
-    "expires": "2030-05-31",
-    "sources": {
-        "bitbake": {
-            "git-remote": {
-                "uri": "https://git.openembedded.org/bitbake",
-                "branch": "2.18",
-                "rev": "2.18"
-            }
-        },
-        "openembedded-core": {
-            "git-remote": {
-                "uri": "https://git.openembedded.org/openembedded-core",
-                "branch": "wrynose",
-                "rev": "wrynose"
-            }
-        },
-        "meta-yocto": {
-            "git-remote": {
-                "uri": "https://git.yoctoproject.org/meta-yocto",
-                "branch": "wrynose",
-                "rev": "wrynose"
-            }
-        },
-        "yocto-docs": {
-            "git-remote": {
-                "uri": "https://git.yoctoproject.org/yocto-docs",
-                "branch": "wrynose",
-                "rev": "wrynose"
-            }
-        }
-    },
-    "bitbake-setup": {
-        "configurations": [
-        {
-            "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
-            "setup-dir-name": "$distro-wrynose",
-            "oe-fragments-one-of": {
-                "machine": {
-                    "description": "Target machines",
-                    "options" : [
-                        { "name": "machine/qemux86-64", "description": "x86-64 system on QEMU" },
-                        { "name": "machine/qemuarm64", "description": "ARMv8 system on QEMU" },
-                        { "name": "machine/qemuriscv64", "description": "RISC-V system on QEMU" },
-                        { "name": "machine/genericarm64", "description": "Arm64 SystemReady IR/ES platforms" },
-                        { "name": "machine/genericx86-64", "description": "x86_64 (64-bit) PCs and servers" }
-                    ]
-                },
-                "distro": {
-                    "description": "Target distributions",
-                    "options" : [
-                        { "name": "distro/poky", "description": "Yocto Project Reference Distro" },
-                        { "name": "distro/poky-altcfg", "description": "Poky alternative with systemd as init manager" },
-                        { "name": "distro/poky-tiny", "description": "Poky alternative optimized for size" }
-                    ]
-                }
-            },
-            "configurations": [
-            {
-                "name": "poky",
-                "description": "Poky - The Yocto Project testing distribution"
-            },
-            {
-                "name": "poky-with-sstate",
-                "description": "Poky - The Yocto Project testing distribution with internet sstate acceleration. Use with caution as it requires a completely robust local network with sufficient bandwidth.",
-                "oe-fragments": ["core/yocto/sstate-mirror-cdn"]
-            }
-            ]
-        }
-        ]
-    },
-    "version": "1.0"
-}
diff --git a/default-registry/configurations/poky.conf.json b/default-registry/configurations/poky.conf.json
new file mode 100644
index 000000000000..ea4c7a0660e7
--- /dev/null
+++ b/default-registry/configurations/poky.conf.json
@@ -0,0 +1,161 @@
+{
+    "description": "Poky - The Yocto Project testing distribution configurations and hardware test platforms",
+    "source-choices": {
+        "master": {
+            "description": "Poky development branch",
+            "sources": {
+                "bitbake": {
+                    "git-remote": {
+                        "uri": "https://git.openembedded.org/bitbake",
+                        "branch": "master",
+                        "rev": "master"
+                    }
+                },
+                "openembedded-core": {
+                    "git-remote": {
+                        "uri": "https://git.openembedded.org/openembedded-core",
+                        "branch": "master",
+                        "rev": "master"
+                    }
+                },
+                "meta-yocto": {
+                    "git-remote": {
+                        "uri": "https://git.yoctoproject.org/meta-yocto",
+                        "branch": "master",
+                        "rev": "master"
+                    }
+                },
+                "yocto-docs": {
+                    "git-remote": {
+                        "uri": "https://git.yoctoproject.org/yocto-docs",
+                        "branch": "master",
+                        "rev": "master"
+                    }
+                }
+            }
+        },
+        "whinlatter": {
+            "description": "Poky, release 5.3 'whinlatter'",
+            "expires": "2026-05-31",
+            "sources": {
+                "bitbake": {
+                    "git-remote": {
+                        "remotes": {
+                            "origin": {
+                                "uri": "https://git.openembedded.org/bitbake"
+                            }
+                        },
+                        "branch": "2.16",
+                        "rev": "2.16"
+                    }
+                },
+                "openembedded-core": {
+                    "git-remote": {
+                        "remotes": {
+                            "origin": {
+                                "uri": "https://git.openembedded.org/openembedded-core"
+                            }
+                        },
+                        "branch": "whinlatter",
+                        "rev": "whinlatter"
+                    }
+                },
+                "meta-yocto": {
+                    "git-remote": {
+                        "remotes": {
+                            "origin": {
+                                "uri": "https://git.yoctoproject.org/meta-yocto"
+                            }
+                        },
+                        "branch": "whinlatter",
+                        "rev": "whinlatter"
+                    }
+                },
+                "yocto-docs": {
+                    "git-remote": {
+                        "remotes": {
+                            "origin": {
+                                "uri": "https://git.yoctoproject.org/yocto-docs"
+                            }
+                        },
+                        "branch": "whinlatter",
+                        "rev": "whinlatter"
+                    }
+                }
+            }
+        },
+        "wrynose": {
+            "description": "Poky, release 6.0 'wrynose'",
+            "expires": "2030-05-31",
+            "sources": {
+                "bitbake": {
+                    "git-remote": {
+                        "uri": "https://git.openembedded.org/bitbake",
+                        "branch": "2.18",
+                        "rev": "2.18"
+                    }
+                },
+                "openembedded-core": {
+                    "git-remote": {
+                        "uri": "https://git.openembedded.org/openembedded-core",
+                        "branch": "wrynose",
+                        "rev": "wrynose"
+                    }
+                },
+                "meta-yocto": {
+                    "git-remote": {
+                        "uri": "https://git.yoctoproject.org/meta-yocto",
+                        "branch": "wrynose",
+                        "rev": "wrynose"
+                    }
+                },
+                "yocto-docs": {
+                    "git-remote": {
+                        "uri": "https://git.yoctoproject.org/yocto-docs",
+                        "branch": "wrynose",
+                        "rev": "wrynose"
+                    }
+                }
+            }
+        }
+    },
+    "bitbake-setup": {
+        "configurations": [
+        {
+            "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
+            "oe-fragments-one-of": {
+                "machine": {
+                    "description": "Target machines",
+                    "options" : [
+                        { "name": "machine/qemux86-64", "description": "x86-64 system on QEMU" },
+                        { "name": "machine/qemuarm64", "description": "ARMv8 system on QEMU" },
+                        { "name": "machine/qemuriscv64", "description": "RISC-V system on QEMU" },
+                        { "name": "machine/genericarm64", "description": "Arm64 SystemReady IR/ES platforms" },
+                        { "name": "machine/genericx86-64", "description": "x86_64 (64-bit) PCs and servers" }
+                    ]
+                },
+                "distro": {
+                    "description": "Target distributions",
+                    "options" : [
+                        { "name": "distro/poky", "description": "Yocto Project Reference Distro" },
+                        { "name": "distro/poky-altcfg", "description": "Poky alternative with systemd as init manager" },
+                        { "name": "distro/poky-tiny", "description": "Poky alternative optimized for size" }
+                    ]
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
2.43.0


