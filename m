Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CD7C98318
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 15:31:25 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1210.1790263879045666227
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Sep 2026 08:31:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KMEgGcD2;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.140, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e620fa473so13696815e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Sep 2026 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790263877; x=1790868677; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qYsKvP/x4uH6MkVRZVZ6uuPsSpPj+sE+cjMY3tI+Ib0=;
        b=KMEgGcD2KxbDyafVK5wsxo61P5sBi/Uiuvm1WOXYfP/TnId1Kb0fkSE1dN/eQE4dxg
         qa59rbIpGuV/4krltv81h2jVeTTMm+MY94ICH3SYjJT0J3bdLZPwzG3gyijpzoajItSY
         vAtSFNt4VExSgpodCLqZp09H1Hsr/Q436O900=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263877; x=1790868677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qYsKvP/x4uH6MkVRZVZ6uuPsSpPj+sE+cjMY3tI+Ib0=;
        b=VIfYVP7KGJewS6d2HsSGEdkSBkFGqWdlpD4PB47rZU7kj+m7qjYsIo+DoQfPp3BfEf
         4cH1CquQTtLpj8yqZgcMncwiKmd2wHDUimurfiP7GGNmhE+RAj4CyMPOEJK7ZrlAIgKV
         DSKCkSpuPfAcZhtLps8E8w36fbyWud4dzhhnACH7EXvSGxa+41N6x3hHmGqCpc+O/IWe
         aB+c9vUOl3qiQErbb6QxPQCBFD4KMLb3K6YxJ+1guVqALM83XERNyPDeFhMsldvGPbMY
         NJ/IpYMTDWd8FIq4aluF+wXotBTqQ1w7C6hNRhE7+moTxh6X6rCL2jC7ugfIHC/l48CH
         IVGQ==
X-Gm-Message-State: AFuF++lvCtE6Ua2iXfnWFCUO3qVCu6iGj39uOc87Hu4oWhbkubbogwR7
	yt6pv/xVP+w0o9SQkXlcSWQn5rBSmPivbAauPXji1yEMaTG47Fm+1c9lFdE0UeuGCz5TmKpErYL
	KBeGNfqU=
X-Gm-Gg: AYBFou2U3lBpLh+oM3ni2Wrhrs6K555ENkT0qRtdtkTX/xpSgKdKqj1eYyyYUJ7E9gC
	k9EzKoG34myHiPtnz5ZqCFmzxajfYNqpHKPezH075Jpjo+2uOinnvOGIRiYor79rVbhLoml2uX/
	VU53wvtZbFmK6kaiMcNPT6w36OU0QQSGijLhgDg66VXlDDuvb+E87wwx/u3BkBWCjhyxdIYlK0u
	yTJ/cJpReAOj6GmI1zMEVaqkBjf4mCZzGFm4dQ2VYnV69/4CVbwcO3QxIKtJEyGtUbeTp2ZHSOn
	UCPiLxS76PiUULBmlh90dudnVMp+9Ex/mku50Iqw0kgFZtAp66asV2WWtBIh2TrSUN34sJkLaF3
	7SWn/HqGKVbpWpoIiQ2i1jEhbZ2EHQhhTlRzwXFTZNNrr18xmSMFl36cZQFLfmpxPjDvZkBNcwe
	IlMCUiFEHHs1ScxC/IXMk3ivWl6E8iuXg7pP3/Y/9FVkaTfLq+4pJcJA39lzHKjAFQedrkFcgHv
	rkZXmOVAPO1xDUyxJDCdTff5w==
X-Received: by 2002:a05:600c:34c7:b0:49c:dca2:ac47 with SMTP id 5b1f17b1804b1-49fe66c8e71mr47744715e9.2.1790263869835;
        Thu, 24 Sep 2026 08:31:09 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d896:f63e:1133:71e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c50da7sm96446975e9.3.2026.09.24.08.31.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:31:09 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] default-registry: Add blacksail configs
Date: Thu, 24 Sep 2026 16:31:08 +0100
Message-ID: <20260924153108.1090791-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Sep 2026 15:31:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20251

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../oe-nodistro-blacksail.conf.json           | 48 ++++++++++++
 .../configurations/poky-blacksail.conf.json   | 74 +++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 default-registry/configurations/oe-nodistro-blacksail.conf.json
 create mode 100644 default-registry/configurations/poky-blacksail.conf.json

diff --git a/default-registry/configurations/oe-nodistro-blacksail.conf.json b/default-registry/configurations/oe-nodistro-blacksail.conf.json
new file mode 100644
index 00000000000..c970a96e27f
--- /dev/null
+++ b/default-registry/configurations/oe-nodistro-blacksail.conf.json
@@ -0,0 +1,48 @@
+{
+    "description": "OpenEmbedded - 'nodistro' basic configuration, release 6.0 'blacksail'",
+    "expires": "2027-05-31",
+    "sources": {
+        "bitbake": {
+            "git-remote": {
+                "uri": "https://git.openembedded.org/bitbake",
+                "branch": "2.20",
+                "rev": "2.20"
+            }
+        },
+        "openembedded-core": {
+            "git-remote": {
+                "uri": "https://git.openembedded.org/openembedded-core",
+                "branch": "blacksail",
+                "rev": "blacksail"
+            }
+        },
+        "yocto-docs": {
+            "git-remote": {
+                "uri": "https://git.yoctoproject.org/yocto-docs",
+                "branch": "blacksail",
+                "rev": "blacksail"
+            }
+        }
+    },
+    "bitbake-setup": {
+        "configurations": [
+        {
+            "name": "nodistro",
+            "description": "OpenEmbedded 'nodistro'",
+            "setup-dir-name": "oe-nodistro-blacksail",
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
diff --git a/default-registry/configurations/poky-blacksail.conf.json b/default-registry/configurations/poky-blacksail.conf.json
new file mode 100644
index 00000000000..ff09df99412
--- /dev/null
+++ b/default-registry/configurations/poky-blacksail.conf.json
@@ -0,0 +1,74 @@
+{
+    "description": "Poky - The Yocto Project testing distribution configurations and hardware test platforms, release 6.1 'blacksail'",
+    "expires": "2027-05-31",
+    "sources": {
+        "bitbake": {
+            "git-remote": {
+                "uri": "https://git.openembedded.org/bitbake",
+                "branch": "2.20",
+                "rev": "2.20"
+            }
+        },
+        "openembedded-core": {
+            "git-remote": {
+                "uri": "https://git.openembedded.org/openembedded-core",
+                "branch": "blacksail",
+                "rev": "blacksail"
+            }
+        },
+        "meta-yocto": {
+            "git-remote": {
+                "uri": "https://git.yoctoproject.org/meta-yocto",
+                "branch": "blacksail",
+                "rev": "blacksail"
+            }
+        },
+        "yocto-docs": {
+            "git-remote": {
+                "uri": "https://git.yoctoproject.org/yocto-docs",
+                "branch": "blacksail",
+                "rev": "blacksail"
+            }
+        }
+    },
+    "bitbake-setup": {
+        "configurations": [
+        {
+            "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
+            "setup-dir-name": "$distro-blacksail",
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

