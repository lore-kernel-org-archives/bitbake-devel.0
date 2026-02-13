Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A24EDF165
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 13:50:53 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.71770.1770990651262435949
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Feb 2026 05:50:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=uDLplLYr;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A683EC1E4A2
	for <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 13:50:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 00525606BE
	for <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 13:50:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 37987102F2783;
	Fri, 13 Feb 2026 14:50:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770990648; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WbJcg1TyKeDEAoor4Nce5DWlCgOnp8zB1h+svCwW25o=;
	b=uDLplLYrlZ8EFMXliHWQVKPwuTzOqkdycU37ss/XrVUN9d/4uaX5g8yRD6dC//zW7uw0hM
	3WiLRdlBqoYVOsdc7bm2fU6comhCABAqQKJh+2HNrEQ4ev+ilV+U6YkyZfX55LABguEBC7
	MpECavGKKwA2+h9IMnKOx1R+l3NZNQop0zda3udHOEa/kjAkTeaPhCn5sDwcir3gm/Xvx1
	y1e8fykbOrRrVdAH5bQp9jrN/uS8NuG/Mk5NAemAtR9DgNfqnbTiRop28D0/c+3e2Itjg8
	L3yZscm4AekHUJ/LZDiUrcbyKfEW57Jhe9xsuu+0W7WrRWnEJZPYLC/hPT9kDQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 13 Feb 2026 14:50:40 +0100
Subject: [PATCH 2/4] bitbake-setup: improve readability of choices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-improve-bbsetup-readability-v1-2-41cec3b06992@bootlin.com>
References: <20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com>
In-Reply-To: <20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5531;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=iumSXHGUWMiOUn5GaWksGP8ViqhmowNFVqoZ5lXvfU0=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpjyw25o+6MhALg6G/OFdIeEb9jP8feGcY93uIK
 Y3vEvDuszOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaY8sNgAKCRDRgEFAKaOo
 Nrl0EACgcYq2ekFXN3/RHAvH4uqa1bveZ2aUhXAdeSwTZvV88pEzVQJrbjjPp0Hqu3S99tLxx2y
 0pN31bVvJCi8C3VM4wjcpfV9URHRp2b+/WSe38uTeJ/AC2KZdS3hsNYpfJnBEGNL9e+Xo/ORrQp
 ieQkPOShuGEeoUH3f0aS1YEz8J6K16n3YKQONRRRpP3cjukLzNLgZ4Ik6dkO11lBCyUYed7PhCA
 1NHZpCjlTWVQ36yoxYh0WOLiUmeRzOLKIrdV5pJLOl3CcnTuFmEKytLyLPZIFRpm6YDWmyuAh2L
 V4ji1PJOHOAsCeS7mL14etSo0iH9uco88LMMrEfvxis3mPnKesR/Di17phqFV+d4L5UO4X9Tj52
 eu7+e9nMybi0yddazo+TW5vRNrgq1CDlE1E379ufcW8Pwq2Qamwycv1XewTuXetxd+Lr1VQ6gOe
 0I92EpW0VMy9BETPVs57tbC63BxikDlq1kF7nxoZpp1v/YJIRCrfoqQ5UeyTIK7awFfEREpulsB
 CTXTEXXLzHTNo6ReNJE1aYZzvDLqE6pdlX3mcmDFF5lnwLvYSKOQwZ8HtGM6jzZKrLk5+V3sK5L
 1uV4pJ+u6nVVVr0DWHh4EaVcbbdkKqKHM32QE6mRcXETY7An3yr1CpRucO9r/rtfIzOEcfRMc6G
 t3xPXQQM25Ps55A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 13:50:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19026

Bold the configuration names and align the descriptions for improved
readability. For this, define a print_configs() function which should
also help factorizing the code as this is done in multiple places.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup | 73 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 23 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 547d3f36bff..6529e9f30b5 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -37,6 +37,32 @@ GLOBAL_ONLY_SETTINGS = (
     "top-dir-name",
 )
 
+def print_configs(prompt: str,choices: list[str], descriptions: list[str] = []):
+    """
+    Helper function to print a list of choices and align the output.
+    Each option name is made bold to stand out.
+    """
+    if not prompt.endswith(':'):
+        prompt += ":"
+    logger.plain(prompt)
+
+    if not descriptions:
+        descriptions = ["" for _ in choices]
+
+    # maximum size of all choices, for alignment
+    cmax = max([len(c) for c in choices]) + 1
+
+    for n, c in enumerate(choices):
+        msg = f"{n + 1}. "
+        if BBSETUP_COLOR:
+            # make it bold
+            msg += "\033[1m"
+        msg += f"{c:<{cmax}}"
+        if BBSETUP_COLOR:
+            msg += "\033[0m"
+        msg += f" {descriptions[n]}"
+        logger.plain(msg)
+
 # If bitbake is from a release tarball or somewhere like pypi where
 # updates may not be straightforward, prefer to use the git repo as the
 # default registry
@@ -492,36 +518,39 @@ def choose_bitbake_config(configs, parameters, non_interactive):
     if non_interactive:
         raise Exception("Unable to choose from bitbake configurations in non-interactive mode: {}".format(configs_dict))
 
-    logger.plain("\nAvailable bitbake configurations:")
-    for n, config_data in enumerated_configs:
-        logger.plain("{}. {}\t{}".format(n, config_data["name"], config_data["description"]))
+    logger.plain("")
+    print_configs("Available bitbake configurations",
+                  [c["name"] for c in flattened_configs],
+                  [c["description"] for c in flattened_configs])
     config_n = int_input([i[0] for i in enumerated_configs],
                          "\nPlease select one of the above bitbake configurations by its number: ") - 1
     return flattened_configs[config_n]
 
 def choose_config(configs, non_interactive):
     not_expired_configs = [k for k in sorted(configs.keys()) if not has_expired(configs[k].get("expires", None))]
-    config_list = list(enumerate(not_expired_configs, 1))
-    if len(config_list) == 1:
-        only_config = config_list[0][1]
+    if len(not_expired_configs) == 1:
+        only_config = not_expired_configs[0]
         logger.plain("\nSelecting the only available configuration {}\n".format(only_config))
         return only_config
 
     if non_interactive:
         raise Exception("Unable to choose from configurations in non-interactive mode: {}".format(not_expired_configs))
 
-    logger.plain("\nAvailable Configuration Templates:")
-    for n, config_name in config_list:
-        config_data = configs[config_name]
-        expiry_date = config_data.get("expires", None)
-        config_desc = config_data["description"]
+    descs = []
+    for c in not_expired_configs:
+        d = configs[c]["description"]
+        expiry_date = configs[c].get("expires", None)
         if expiry_date:
-           logger.plain("{}. {}\t{} (supported until {})".format(n, config_name, config_desc, expiry_date))
-        else:
-           logger.plain("{}. {}\t{}".format(n, config_name, config_desc))
-    config_n = int_input([i[0] for i in config_list],
-                         "\nPlease select one of the above Configuration Templates by its number: ") - 1
-    return config_list[config_n][1]
+            d += f" (supported until {expiry_date})"
+        descs.append(d)
+
+    logger.plain("")
+    print_configs("Available Configuration Templates",
+                  [c for c in not_expired_configs],
+                  descs)
+    config_n = int_input([i[0] for i in list(enumerate(not_expired_configs, 1))],
+                         "\nPlease select one of the above configurations by its number: ") - 1
+    return not_expired_configs[config_n]
 
 def choose_fragments(possibilities, parameters, non_interactive, skip_selection):
     choices = {}
@@ -547,13 +576,11 @@ def choose_fragments(possibilities, parameters, non_interactive, skip_selection)
         if non_interactive:
             raise Exception(f"Unable to choose from options in non-interactive mode: {[o['name'] for o in options]}")
 
-        logger.plain("\n" + v["description"] + ":")
+        logger.plain("")
+        print_configs(v["description"],
+                     [o['name'] for o in options],
+                     [o['description'] for o in options])
         options_enumerated = list(enumerate(options, 1))
-        for n,o in options_enumerated:
-            opt_str = f"{n}. {o['name']}"
-            if o["description"]:
-                opt_str += f"\t{o['description']}"
-            logger.plain(opt_str)
         option_n = int_input([i[0] for i in options_enumerated],
                              "\nPlease select one of the above options by its number: ") - 1
         choices[k] = options_enumerated[option_n][1]["name"]

-- 
2.52.0


