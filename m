Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF92CCFA18
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 17:17:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22927.1762881413270202156
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 09:16:53 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2917E497
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 09:16:45 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A4373F5A1
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 09:16:52 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] bitbake-setup: 1-index the questions to the user
Date: Tue, 11 Nov 2025 17:16:43 +0000
Message-ID: <20251111171643.3329047-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111171643.3329047-1-ross.burton@arm.com>
References: <20251111171643.3329047-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 17:17:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18329

When the user is asked to select a configuration, the list is
zero-indexed:

  Distribution configuration variants:
  0. distro/poky
  1. distro/poky-altcfg
  2. distro/poky-tiny

It is more user friendly to start the lists from "1".

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bin/bitbake-setup | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 96c0400152..f9a1c75bc8 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -343,7 +343,7 @@ def choose_bitbake_config(configs, parameters, non_in=
teractive):
             raise Exception("Bitbake configuration {} not found; replace=
 with one of {}".format(config_id, configs_dict))
         return configs_dict[config_id]
=20
-    enumerated_configs =3D list(enumerate(flattened_configs))
+    enumerated_configs =3D list(enumerate(flattened_configs, 1))
     if len(enumerated_configs) =3D=3D 1:
         only_config =3D flattened_configs[0]
         print("\nSelecting the only available bitbake configuration {}".=
format(only_config["name"]))
@@ -356,12 +356,12 @@ def choose_bitbake_config(configs, parameters, non_=
interactive):
     for n, config_data in enumerated_configs:
         print("{}. {}\t{}".format(n, config_data["name"], config_data["d=
escription"]))
     print("\nPlease select one of the above bitbake configurations by it=
s number:")
-    config_n =3D int_input([i[0] for i in enumerated_configs])
+    config_n =3D int_input([i[0] for i in enumerated_configs]) - 1
     return flattened_configs[config_n]
=20
 def choose_config(configs, non_interactive):
     not_expired_configs =3D [k for k in configs.keys() if not has_expire=
d(configs[k].get("expires", None))]
-    config_list =3D list(enumerate(not_expired_configs))
+    config_list =3D list(enumerate(not_expired_configs, 1))
     if len(config_list) =3D=3D 1:
         only_config =3D config_list[0][1]
         print("\nSelecting the only available configuration {}\n".format=
(only_config))
@@ -380,7 +380,7 @@ def choose_config(configs, non_interactive):
         else:
            print("{}. {}\t{}".format(n, config_name, config_desc))
     print("\nPlease select one of the above configurations by its number=
:")
-    config_n =3D int_input([i[0] for i in config_list])
+    config_n =3D int_input([i[0] for i in config_list]) - 1
     return config_list[config_n][1]
=20
 def choose_fragments(possibilities, parameters, non_interactive, skip_se=
lection):
@@ -400,11 +400,11 @@ def choose_fragments(possibilities, parameters, non=
_interactive, skip_selection)
             raise Exception("Unable to choose from options in non-intera=
ctive mode: {}".format(v["options"]))
=20
         print("\n" + v["description"] + ":")
-        options_enumerated =3D list(enumerate(v["options"]))
+        options_enumerated =3D list(enumerate(v["options"], 1))
         for n,o in options_enumerated:
             print("{}. {}".format(n, o))
         print("\nPlease select one of the above options by its number:")
-        option_n =3D int_input([i[0] for i in options_enumerated])
+        option_n =3D int_input([i[0] for i in options_enumerated]) - 1
         choices[k] =3D options_enumerated[option_n][1]
     return choices
=20
--=20
2.43.0


