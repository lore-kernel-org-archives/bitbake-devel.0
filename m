Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C420F9B604
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 09:56:38 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78787.1776851787900701081
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Apr 2026 02:56:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aLhWloc9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso26439235e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Apr 2026 02:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776851786; x=1777456586; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E3c1HYua42TazSARcJIFdWB0g1WFLyRwtCO57Goe1xw=;
        b=aLhWloc9irMATNKnuFfsgQ/eG1OHJzB0WAbOQNDWlWM78Xm6LQLJp/gsy7wgoTMz6y
         E/TfRse1UuUVqJmSb7pMP50VwxxNQZzJJjlo+nifbO5puSTPFSApu3apbzzBo6WQj7LY
         9QONOSWkFwXFJZffYKRuUm4n1PC+RqeQTsRUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776851786; x=1777456586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3c1HYua42TazSARcJIFdWB0g1WFLyRwtCO57Goe1xw=;
        b=sjE8oGo22rydO0MV2F0R0v7CK1QvYzDDHxc0A/p1rnB7IOHUzIbc18o5fNmh0ethM8
         4CVpAE70gjjyeNl3xTai9Gsj2ZA17uqdnfpMBRCRu3lIj/5bVGjDaiDPH9fmZwjua3dg
         0D4r56ZjhMM1/K1vLnTFHGVUPWZTQ+wIq6vXHTCHvrlbVZCQkYQbUJpZgK2s94/Yzj+5
         jAQTgcsdwdg+kr0/7DQkIGOT3rMESLAtwQuwxi8vZzczOPtGZawi2lrXAXN4hhkxN379
         ydwdF7+ki74N+mObnDhEEozIz2RlpR51rvlL8qiPMV3s2/IXVzmuAX3SM1FKbZYL4+cH
         1O3g==
X-Gm-Message-State: AOJu0Yywg3nVnRBokv3B9a5+iSbA1cUaK5s490ufe1ttI6D7pVM+HmiV
	BdmZ4QxslaZuixij3FtT7gVyX+vpJdGMwb4GObq7viy1gOYXmHUJgq1J5DhsNZv2whhTLtwMZtT
	o78fJH7Q=
X-Gm-Gg: AeBDiesC94qEKtiBVk2g8krIE1WVV3iRvZ+OBZoGQV/xkPen/jCllWGIeowQgRrQrvw
	TO5EUgpXXx2OZalgK8eLeEWR+NUdRGMDzJ72gZDdVogXMOtm9TgyJOHiMA1n5m/OCSiYtmgywZd
	1SQpP3t1N3nA5OXvs9Oo4TWpbWugtunoAII1C/Hu/hPgegEMF2BmBPfGQ6+HpBOueeWSs40v56U
	+TKg0O1D6dnWzbPG1d91QT1xYieshebM5FuGqumaiO/7NoCDHAayvARpZJZS3LDb6iuU4CBdTPB
	Xz4manJ+a5eU1LSX2zstEdjaWQfykfr1y8yKzOwJlvJ2gzAPrrW0nJmgWgG906Y3dlN6OFbI5fe
	D3hif0lRswNPtKMzJ0GE3KhTncZHBvId1US/1HTm6iA52FIi75ZGDlLK83q7i2oc+Yw/WVUNayO
	yS0l9Me4KbQUWRCMLwt49LHG0sXYc3vZERdwjSEiAZez+L5oHGP4ecfhLHVCfG4+VMa2sfH9wsL
	g==
X-Received: by 2002:a05:600c:1f94:b0:489:1c2d:211e with SMTP id 5b1f17b1804b1-4891c2d2213mr170900285e9.5.1776851785507;
        Wed, 22 Apr 2026 02:56:25 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a9c6:3deb:bd01:ef01])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c01cfsm453993925e9.10.2026.04.22.02.56.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 02:56:25 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] default-registry: Add wrynose
Date: Wed, 22 Apr 2026 10:56:24 +0100
Message-ID: <20260422095624.241708-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Apr 2026 09:56:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19374

Add the new release

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../oe-nodistro-wrynose.conf.json             | 48 ++++++++++++
 .../configurations/poky-wrynose.conf.json     | 74 +++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 default-registry/configurations/oe-nodistro-wrynose.conf.json
 create mode 100644 default-registry/configurations/poky-wrynose.conf.json

diff --git a/default-registry/configurations/oe-nodistro-wrynose.conf.json b/default-registry/configurations/oe-nodistro-wrynose.conf.json
new file mode 100644
index 00000000000..278ce4dd029
--- /dev/null
+++ b/default-registry/configurations/oe-nodistro-wrynose.conf.json
@@ -0,0 +1,48 @@
+{
+    "description": "OpenEmbedded - 'nodistro' basic configuration, release 6.0 'wrynose'",
+    "expires": "2030-05-31",
+    "sources": {
+        "bitbake": {
+            "git-remote": {
+                "uri": "https://git.openembedded.org/bitbake",
+                "branch": "2.18",
+                "rev": "2.18"
+            }
+        },
+        "openembedded-core": {
+            "git-remote": {
+                "uri": "https://git.openembedded.org/openembedded-core",
+                "branch": "wrynose",
+                "rev": "wrynose"
+            }
+        },
+        "yocto-docs": {
+            "git-remote": {
+                "uri": "https://git.yoctoproject.org/yocto-docs",
+                "branch": "wrynose",
+                "rev": "wrynose"
+            }
+        }
+    },
+    "bitbake-setup": {
+        "configurations": [
+        {
+            "name": "nodistro",
+            "description": "OpenEmbedded 'nodistro'",
+            "setup-dir-name": "oe-nodistro-wrynose",
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
diff --git a/default-registry/configurations/poky-wrynose.conf.json b/default-registry/configurations/poky-wrynose.conf.json
new file mode 100644
index 00000000000..d2792843773
--- /dev/null
+++ b/default-registry/configurations/poky-wrynose.conf.json
@@ -0,0 +1,74 @@
+{
+    "description": "Poky - The Yocto Project testing distribution configurations and hardware test platforms, release 6.0 'wrynose'",
+    "expires": "2030-05-31",
+    "sources": {
+        "bitbake": {
+            "git-remote": {
+                "uri": "https://git.openembedded.org/bitbake",
+                "branch": "2.18",
+                "rev": "2.18"
+            }
+        },
+        "openembedded-core": {
+            "git-remote": {
+                "uri": "https://git.openembedded.org/openembedded-core",
+                "branch": "wrynose",
+                "rev": "wrynose"
+            }
+        },
+        "meta-yocto": {
+            "git-remote": {
+                "uri": "https://git.yoctoproject.org/meta-yocto",
+                "branch": "wrynose",
+                "rev": "wrynose"
+            }
+        },
+        "yocto-docs": {
+            "git-remote": {
+                "uri": "https://git.yoctoproject.org/yocto-docs",
+                "branch": "wrynose",
+                "rev": "wrynose"
+            }
+        }
+    },
+    "bitbake-setup": {
+        "configurations": [
+        {
+            "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
+            "setup-dir-name": "$distro-wrynose",
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

