Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2611E9A047
	for <webhook@archiver.kernel.org>; Wed, 18 Feb 2026 13:15:41 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11680.1771420537363245699
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Feb 2026 05:15:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=NjJSmWqh;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BF532C237EE
	for <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 13:15:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D614A6074B
	for <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 13:15:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E11E10368B8C;
	Wed, 18 Feb 2026 14:15:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771420535; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZOqZfS29BsvQ+cebMw84hV/TWudO6JWMqr8Jx+Gyt/8=;
	b=NjJSmWqh9OM2VVdcqZvDm0x0i+BwHhd+vCDk+uo8Pdq3fOE8cIOdoZ8IiUEcYa6ecKKsat
	PJ8v5orz6pUKP2hchSZHx5d17/Mvw3LIv4zsn8BCLp+HB6tuwFz8IOt9V3l0cMOlTGcCkX
	8e/794XVZ+h6zTsrF6Bm8M/UmaabwYVg9E8vSWhwoCN6++6vZHET5yf4IoG9ydjTaXvZo8
	tAx1P7ODwn64yl5pmdT0+gk5xzMYPRUlXEOiSEchFRRRdA9x4Z5I2S/HPqkenFijhWA/Uq
	yD3coQ3zf29dYsabb0OgwlqLFWtAb58hOMLx2bV7JU7OB0f8eGjpg3sCSipf+Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 18 Feb 2026 14:15:27 +0100
Subject: [PATCH v2 2/4] bitbake-setup: improve readability of choices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-improve-bbsetup-readability-v2-2-351584e5df9c@bootlin.com>
References: <20260218-improve-bbsetup-readability-v2-0-351584e5df9c@bootlin.com>
In-Reply-To: <20260218-improve-bbsetup-readability-v2-0-351584e5df9c@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5682;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=1quA5f/DLTqmFNZ1fqFLGQfZviq0mSW19f1EWd1fmvg=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBplbt08qyyU6wjPoFTghO5QI0KlVtFoUIFHZvlw
 3CB9xCWDT2JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaZW7dAAKCRDRgEFAKaOo
 NndUEACwuwzwr6eFhQ0xQggsu7HadawJpnFyy4pO4Y18TuT16qjtZFFK9WxeDGIjP+UdV/MIGMi
 GNY/A9bsNTH/GrIPIZjAQAOniG213xMTV3kv0aZXEGmeDgSSHmeYluqnvMyXX3hcp2psYB+juE2
 9htFq9Br/Lkz7INN07kHQO/OEMqQSoFBb5fUJXyfpgs/ZJ9ucbHvM5YMvP5fVkcJnnfGsjhq+4l
 0F6asWXibKY0BqLy4S56u8Fjub805n60N5etSY2ILESErOTPYGCcpHvNiJ8XEeYIoPUtOZ5CIVJ
 9yrItMVp37sGI1BbcKOIdjKiwM70KXKrR8D8Va/s6uE/bNU84+r7HAmXm2PhsA4d64pnuTLyi1L
 6R/L3r4JfweYe4UrIU/yWnAnSlNN2e3sBNsCBvMLOUOaUB/okEuo/xvKnp7GpLQETHb/VvRdW/d
 W1IQI7nY71qDjJK6lkkLHugjcThTb5wR2rW0dVzqn0ewElpTHPvw2WN3peWPgPuDhZLjOWvDCx6
 1QPVJ9ggJ7uqkTt2BVxgSo2Dn4nI4nQ0mFrT3nNUkDSAXmeDsynKwhNpnELkilzudRz7upv5SzV
 BZKr5Pyb4jjvAxpItubiYnuU1JBN70oadUf3dL1zFcHa3CPKp119zHpKzUBcTjlnm9RPrcdaJum
 wxx56WbgKIgn4MA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 13:15:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19059

Bold the configuration names and align the descriptions for improved
readability. For this, define a print_configs() function which should
also help factorizing the code as this is done in multiple places.

If color_enabled() is false, keep the text plain.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup | 74 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 23 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 3e17e631bfb..9b0ecc8d0e4 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -42,6 +42,33 @@ def color_enabled() -> bool:
     """
     return logger.handlers[0].formatter.color_enabled
 
+def print_configs(prompt: str, choices: list[str], descriptions: list[str] = []):
+    """
+    Helper function to print a list of choices and align the output.
+    Each option name is made bold to stand out, unless color is not enabled in
+    our logger.
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
+        if color_enabled():
+            # make it bold
+            msg += "\033[1m"
+        msg += f"{c:<{cmax}}"
+        if color_enabled():
+            msg += "\033[0m"
+        msg += f" {descriptions[n]}"
+        logger.plain(msg)
+
 # If bitbake is from a release tarball or somewhere like pypi where
 # updates may not be straightforward, prefer to use the git repo as the
 # default registry
@@ -497,36 +524,39 @@ def choose_bitbake_config(configs, parameters, non_interactive):
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
@@ -552,13 +582,11 @@ def choose_fragments(possibilities, parameters, non_interactive, skip_selection)
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


