Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E32D12D58
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 12:15:56 +0000 (UTC)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13674.1764764155355231387
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 04:15:55 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.173, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dLxS96W9Mz235;
	Wed,  3 Dec 2025 13:15:53 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dLxS93HgczbYq;
	Wed,  3 Dec 2025 13:15:53 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 03 Dec 2025 13:15:42 +0100
Subject: [PATCH 2/3] bitbake-setup: make all callers of int_input pass
 their prompt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-bitbake-setup-input-consistent-v1-2-3c7e6edecd57@cherry.de>
References: <20251203-bitbake-setup-input-consistent-v1-0-3c7e6edecd57@cherry.de>
In-Reply-To: <20251203-bitbake-setup-input-consistent-v1-0-3c7e6edecd57@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 12:15:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18525

From: Quentin Schulz <quentin.schulz@cherry.de>

This aligns the behavior of int_input() with input() so that the user
input is printed on the same line as the prompt.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 bin/bitbake-setup | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 54faa7e30..7173fec1f 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -388,8 +388,8 @@ def choose_bitbake_config(configs, parameters, non_interactive):
     print("\nAvailable bitbake configurations:")
     for n, config_data in enumerated_configs:
         print("{}. {}\t{}".format(n, config_data["name"], config_data["description"]))
-    print("\nPlease select one of the above bitbake configurations by its number:")
-    config_n = int_input([i[0] for i in enumerated_configs]) - 1
+    config_n = int_input([i[0] for i in enumerated_configs],
+                         "\nPlease select one of the above bitbake configurations by its number: ") - 1
     return flattened_configs[config_n]
 
 def choose_config(configs, non_interactive):
@@ -412,8 +412,8 @@ def choose_config(configs, non_interactive):
            print("{}. {}\t{} (supported until {})".format(n, config_name, config_desc, expiry_date))
         else:
            print("{}. {}\t{}".format(n, config_name, config_desc))
-    print("\nPlease select one of the above configurations by its number:")
-    config_n = int_input([i[0] for i in config_list]) - 1
+    config_n = int_input([i[0] for i in config_list],
+                         "\nPlease select one of the above configurations by its number: ") - 1
     return config_list[config_n][1]
 
 def choose_fragments(possibilities, parameters, non_interactive, skip_selection):
@@ -436,8 +436,8 @@ def choose_fragments(possibilities, parameters, non_interactive, skip_selection)
         options_enumerated = list(enumerate(v["options"], 1))
         for n,o in options_enumerated:
             print("{}. {}".format(n, o))
-        print("\nPlease select one of the above options by its number:")
-        option_n = int_input([i[0] for i in options_enumerated]) - 1
+        option_n = int_input([i[0] for i in options_enumerated],
+                             "\nPlease select one of the above options by its number: ") - 1
         choices[k] = options_enumerated[option_n][1]
     return choices
 

-- 
2.52.0


