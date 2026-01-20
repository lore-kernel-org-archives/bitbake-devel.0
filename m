Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260BED2ECF7
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 08:57:53 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2501.1768899464050361664
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 00:57:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=06bqOl0q;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7A93C4E421A9
	for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 08:57:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4A797606AB;
	Tue, 20 Jan 2026 08:57:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 790D110B6B319;
	Tue, 20 Jan 2026 09:57:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768899461; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MUFNe2vjOWECCrA7YVpUksXTNdlGTlSwMP8YhE4miZ8=;
	b=06bqOl0qD/nmkwVia4HMZKzrcr4Wcb1D8eJFerI17TrmjF3ahmlZpN2n689qF4kzz7yhlB
	11cKYYO0BtP2XhbO2opHF3pisf8qPCBSeS0SwN01TwvkcxUM83onWd+6Vj573i3in61j+F
	awkTFoUQX+ZCxfyzIk6ULuqp/lyed4mOG7K6khdMeF64AHpxRmGQMp60dmSnYjH2kIFZVQ
	VSyroPgRPRIDwI9E/C8MPEO4YXU5lTqes8IXwlgys8/GTYACafclU68wbzmRysF966h7y5
	b/Exs8GABBKn2+6lbFmuFYT2gkfSJxpqLyYojWyFcnu4XeekA9HGuVInOc0X5g==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 20 Jan 2026 09:57:33 +0100
Subject: [PATCH v2 1/2] bin/bitbake-setup: add descriptions for fragment
 choices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-bitbake-setup-choose-builtin-v2-1-ade604ff2351@bootlin.com>
References: <20260120-bitbake-setup-choose-builtin-v2-0-ade604ff2351@bootlin.com>
In-Reply-To: <20260120-bitbake-setup-choose-builtin-v2-0-ade604ff2351@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7955;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=JCmdP9dMv3w4onXKsdqpyra2lerrL/3sAf1rPeDQHjw=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpb0OE+M4vC52WReCPnnm0xplMp1L7QRWdr836B
 SMbPMebrCmJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaW9DhAAKCRDRgEFAKaOo
 NrmsD/9A2b9BjyLPFk9dfbfuFLK/oph0soCdKU1HUTh5Zm2GR5m3OQ8zpI0TiEwDnC2OBH6w4qH
 iQcDq1KnL6xHUDI/60IkBXblxR2D9UbY1eE8dlt2FBI09tl1JAlr1PtB/V1ZQyc0+nNBxXfyXBS
 WZSP2e1Q6s9A6zdF4F2iduIYmF/a2Yql4Xw0QC2gZoK9W15rPcM7h73nHp01ziA+SyqaTlE2sr7
 Ej/lahMXgZ1l/Escyly8Ycc7HwKBU1Qfc7uriqRtLcCu3pVltoDxSP5SKw/U0zFNXdwC1hmXnpR
 2pZEU6PkfqSqQYHnLYavHs8bK0vdlEzMSPlz09CH+q15BUXf2XDSf6oWhSlY/FQsTZtN7glFT9C
 Sssi/Iq+f81xTL/EhBkVZto8HZ3TW154CKKP4oGQZEKLIYdl3lzoYOXSBS+B4wLKD+tqrJfo/+x
 TpwNRHN0ss8K5g4Dgowv9dTH6oD1vES7lGfZQ6nNnRqiiTux5XmoMFPSLm0zPSmeQJtyRHB9Bki
 MufvpOCm1+ZHN+XYy/97EsgAnsJzS076NGwybAE2Q7LX+r43AII76l1TtcsnjSlEsK81IvbxPDL
 v8bPOLjamaTlserTWq/R5Gu5KHbth/DYAKxuc078mh/TdDdiB/awYfFZvj7sPDTgmCr9n4WC7GO
 X7yhibb2nyme8SA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 08:57:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18812

Make it possible to give fragments descriptions as it can help users
determine which fragments to pick during bitbake-setup init.

It is still possible to provide a list (with no descriptions) for
backwards-compatibility.

Update the documentation accordingly.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup                                  | 21 ++++++++++++-----
 .../bitbake-user-manual-environment-setup.rst      | 26 ++++++++++++++++++++--
 setup-schema/bitbake-setup.schema.json             | 21 ++++++++++++++++-
 3 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index abe7614c832..8f28a1ef4d4 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -494,20 +494,31 @@ def choose_fragments(possibilities, parameters, non_interactive, skip_selection)
         if skip_selection and k in skip_selection:
             logger.info("Skipping a selection of {}, as requested on command line. The resulting bitbake configuration may require further manual adjustments.".format(k))
             continue
-        choice = [o for o in v["options"] if o in parameters]
+
+        # options can be a list of strings or a list of dicts
+        options = v["options"]
+        descriptions = []
+        if len(options) > 0 and isinstance(v["options"][0], dict):
+            descriptions = [o["description"] for o in options]
+            options = [o["name"] for o in options]
+
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
+            if descriptions:
+                opt_str += f"\t{descriptions[n - 1]}"
+            logger.plain(opt_str)
         option_n = int_input([i[0] for i in options_enumerated],
                              "\nPlease select one of the above options by its number: ") - 1
         choices[k] = options_enumerated[option_n][1]
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 57e799980c4..0376d77143d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -759,11 +759,21 @@ They contain the following sections:
                 "oe-fragments-one-of": {
                     "machine": {
                         "description": "Target machines",
-                        "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
+                        "options" : [
+                            { "name": "machine/qemux86-64", "description": "Machine configuration for running an x86-64 system on QEMU" },
+                            { "name": "machine/qemuarm64", "description": "Machine configuration for running an ARMv8 system on QEMU" },
+                            { "name": "machine/qemuriscv64", "description": "Machine configuration for running an RISC-V system on QEMU" },
+                            { "name": "machine/genericarm64", "description": "Machine configuration for Arm64 SystemReady IR/ES platforms" },
+                            { "name": "machine/genericx86-64", "description": "Machine configuration for generic x86_64 (64-bit) PCs and servers" }
+                        ]
                     },
                     "distro": {
                         "description": "Distribution configuration variants",
-                        "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
+                        "options" : [
+                            { "name": "distro/poky", "description": "Distro configuration for Poky (Yocto Project Reference Distro)" },
+                            { "name": "distro/poky-altcfg", "description": "Distro configuration for Poky (systemd init manager)" },
+                            { "name": "distro/poky-tiny", "description": "Distro configuration for Poky (optimized for size)" }
+                        ]
                     }
                 },
                 "configurations": [
@@ -852,6 +862,18 @@ They contain the following sections:
    -  ``oe-fragments-one-of`` (*optional*, OpenEmbedded specific): the OpenEmbedded
       fragments to select as part of the build.
 
+      This can one of two formats:
+
+      -  A list of dictionaries with ``name`` and a ``description``,
+         corresponding to respectively the fragments names and fragment
+         descriptions (like in the example above).
+
+      -  A list of fragment names. For example:
+
+         .. code-block:: json
+
+            "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
+
       This will trigger choices to make during the
       :ref:`ref-bbsetup-command-init` command execution.
 
diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index e51fef3b97c..be8772db1b2 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -64,7 +64,26 @@
                                 "type": "array",
                                 "description": "List of BitBake configuration fragments to enable",
                                 "items": {
-                                    "type": "string"
+                                    "oneOf": [
+                                        {
+                                            "type": "string",
+                                            "description": "Configuration fragment name"
+                                        },
+                                        {
+                                            "type": "object",
+                                            "description": "Dictionary of BitBake configuration fragments to enable (with description)",
+                                            "properties": {
+                                                "name": {
+                                                    "type": "string",
+                                                    "description": "Configuration fragment name"
+                                                },
+                                                "description": {
+                                                    "type": "string",
+                                                    "description": "Human-readable description of the fragment"
+                                                }
+                                            }
+                                        }
+                                    ]
                                 }
                             },
                             "oe-fragments-one-of": {

-- 
2.52.0


