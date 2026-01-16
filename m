Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CC9C982DD
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 15:49:25 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53.1768578561427704381
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jan 2026 07:49:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=laAMomir;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A40B74E42119
	for <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 15:49:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5754360732;
	Fri, 16 Jan 2026 15:49:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2FA5B10B68B17;
	Fri, 16 Jan 2026 16:49:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768578558; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=G/7vlC8JdBpsm5C1Vqx8F3UfGoRpakg75pHjG8iBxJk=;
	b=laAMomirZvKGcYndabRI4Ui0y4hns+pV23od1PDTB4sg6YYmV0dLzUrQCGWPlQhtY/dXyu
	D1+RckaKrfZDkUutqZUEn46lIneR1Xa+FVSs7mkBKdV9Gu7v6TrsZfkuelP/gI4ikVE+qB
	HVdAGf8POvoEAOOR7cXq5Pj4Uk0hq4Sy2zCb8e64RYXEpZ8j2GtcOZBGrnT/naxm8mqHzD
	7U58PLmUytlzP2bng2ujLd+WQJtk2SOlA3oUeGnyBpoC++WpBl0ptMnsC0ua94xeuBGTAq
	j05SRo24KV2ro8xvHB3kddLiz4zIU/KkMh1+k4K28/vbcsWb/v/nkKQq92qTeQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 16 Jan 2026 16:48:56 +0100
Subject: [PATCH 1/2] bin/bitbake-setup: add descriptions for fragment
 choices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-bitbake-setup-choose-builtin-v1-1-8d66666a9efd@bootlin.com>
References: <20260116-bitbake-setup-choose-builtin-v1-0-8d66666a9efd@bootlin.com>
In-Reply-To: <20260116-bitbake-setup-choose-builtin-v1-0-8d66666a9efd@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7126;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=tlp6hip2p/9/3ZXhelbdnlyveJ0kI/VghE+L7eJgaWo=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpal36Ph+x09G1rgamXz3W+TKwum2xZkMcO9q9z
 YLs3vNFmRyJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaWpd+gAKCRDRgEFAKaOo
 Ns0SEADCHEZIFK/1449rxrw+iOKyczY16BDWdJzd3fLTmHfW/d284h8AfyNd3wNcBSpNQS+xrrm
 b55qoeqQmZGdBmNbEET/0mSvxkJX7ZdqZL5HfwLRMCWyEIt7HW/za4fDiJMVxCfUsAXvAYxgRek
 Yyt73i6WL3BW0wzGqK/sz/dZ8TUoDaZ4ecQYZtP4R26vSve/zKH7LPZcoT13ioBVeDiz0oBNcWf
 CZlObSEVxYNiZB3LnVzsuMVDhXvTxfW6aAApOnILqgfWoFUyhpIwJ10odlF6QHBQzhswcKa5z34
 5JCzskqUjZN+xrn8oXio96dXahSmAX6Os41vWuAyI5vUGeapoD5rWtlO/YM4CHRvdHdTXXyyYLd
 cnrcIfrEQXUYzfgdMgGw2O5ARSUhDooyUZxGgZVCFqT9sOinzGdG61uK0DMwEwJ3OWYMmHpe6Ex
 grV6rFP4RpzBuCqabx7+DWuPqzoO2K5u/Knly2ANIV1C9a5w3WrdNqGYYlsd/vGVzwRTwNRM6xG
 M0xcUOEbV3t0Pb5sdsEnwR+TpjR1ZoUQ7jHMEvJ/NT+JFTouPxLa6s176eWkhrTCpbv+xA5VN4n
 EeStyMmthlMuXkK4VROF0r0worEdo3i5UteuoAtWVfELLWyIVEyKj7QyC1Pin8xg7cC6uMH47Ys
 6RuVtdNC0jjU9Tg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 15:49:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18800

Make it possible to give fragments descriptions as it can help users
determine which fragments to pick during bitbake-setup init.

It is still possible to provide a list (with no descriptions) for
backwards-compatibility.

Update the documentation accordingly.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup                                  | 14 ++++++++-----
 .../bitbake-user-manual-environment-setup.rst      | 21 ++++++++++++++++++--
 setup-schema/bitbake-setup.schema.json             | 23 +++++++++++++++++-----
 3 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index abe7614c832..bb0a579bbed 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -494,20 +494,24 @@ def choose_fragments(possibilities, parameters, non_interactive, skip_selection)
         if skip_selection and k in skip_selection:
             logger.info("Skipping a selection of {}, as requested on command line. The resulting bitbake configuration may require further manual adjustments.".format(k))
             continue
-        choice = [o for o in v["options"] if o in parameters]
+        options = v["options"]
+        choice = [o for o in options if o in parameters]
         if len(choice) > 1:
-            raise Exception("Options specified on command line do not allow a single selection from possibilities {}, please remove one or more from {}".format(v["options"], parameters))
+            raise Exception("Options specified on command line do not allow a single selection from possibilities {}, please remove one or more from {}".format(options, parameters))
         if len(choice) == 1:
             choices[k] = choice[0]
             continue
 
         if non_interactive:
-            raise Exception("Unable to choose from options in non-interactive mode: {}".format(v["options"]))
+            raise Exception("Unable to choose from options in non-interactive mode: {}".format(options))
 
         logger.plain("\n" + v["description"] + ":")
-        options_enumerated = list(enumerate(v["options"], 1))
+        options_enumerated = list(enumerate(options, 1))
         for n,o in options_enumerated:
-            logger.plain("{}. {}".format(n, o))
+            opt_str = f"{n}. {o}"
+            if isinstance(options, dict):
+                opt_str += f"\t{options[o]}"
+            logger.plain(opt_str)
         option_n = int_input([i[0] for i in options_enumerated],
                              "\nPlease select one of the above options by its number: ") - 1
         choices[k] = options_enumerated[option_n][1]
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index fcffab8123b..14d0f87aeb4 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -747,11 +747,21 @@ They contain the following sections:
                 "oe-fragments-one-of": {
                     "machine": {
                         "description": "Target machines",
-                        "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
+                        "options" : {
+                            "machine/qemux86-64": "Machine configuration for running an x86-64 system on QEMU",
+                            "machine/qemuarm64": "Machine configuration for running an ARMv8 system on QEMU",
+                            "machine/qemuriscv64": "Machine configuration for running an RISC-V system on QEMU",
+                            "machine/genericarm64": "Machine configuration for Arm64 SystemReady IR/ES platforms",
+                            "machine/genericx86-64": "Machine configuration for generic x86_64 (64-bit) PCs and servers"
+                        }
                     },
                     "distro": {
                         "description": "Distribution configuration variants",
-                        "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
+                        "options" : {
+                            "distro/poky": "Distro configuration for Poky (Yocto Project Reference Distro)",
+                            "distro/poky-altcfg": "Distro configuration for Poky (systemd init manager)",
+                            "distro/poky-tiny": "Distro configuration for Poky (optimized for size)"
+                        }
                     }
                 },
                 "configurations": [
@@ -840,6 +850,13 @@ They contain the following sections:
    -  ``oe-fragments-one-of`` (*optional*, OpenEmbedded specific): the OpenEmbedded
       fragments to select as part of the build.
 
+      This can one of two formats:
+
+      -  A dictionary where keys are fragments names and values are descriptions
+         for these fragments (like in the example above).
+
+      -  A list of fragment names.
+
       This will trigger choices to make during the
       :ref:`ref-bbsetup-command-init` command execution.
 
diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index e51fef3b97c..51035fbaa53 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -61,11 +61,24 @@
                             },
                             "oe-fragments": {
                                 "$anchor": "oe-fragments",
-                                "type": "array",
-                                "description": "List of BitBake configuration fragments to enable",
-                                "items": {
-                                    "type": "string"
-                                }
+                                "oneOf": [
+                                    {
+                                        "type": "array",
+                                        "description": "List of BitBake configuration fragments to enable",
+                                        "items": {
+                                            "type": "string"
+                                        }
+                                    },
+                                    {
+                                        "type": "object",
+                                        "description": "Dictionary of BitBake configuration fragments to enable (with description)",
+                                        "patternProperties": {
+                                            ".*": {
+                                                "type": "string"
+                                            }
+                                        }
+                                    }
+                                ]
                             },
                             "oe-fragments-one-of": {
                                 "type": "object",

-- 
2.52.0


