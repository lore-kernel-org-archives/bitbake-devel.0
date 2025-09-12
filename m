Return-Path: <reatmon@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9460ECAC592
	for <webhook@archiver.kernel.org>; Fri, 12 Sep 2025 20:46:06 +0000 (UTC)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 by mx.groups.io with SMTP id smtpd.web11.1169.1757709961323042971
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Sep 2025 13:46:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=G2ORGB61;
 spf=pass (domain: ti.com, ip: 198.47.19.246, mailfrom: reatmon@ti.com)
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CKk0871045520
	for <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 15:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757709960;
	bh=tGCxaWp3GSWqAis9wxdN8ooi2JJWRT51fWhzIUhuCdo=;
	h=From:To:Subject:Date;
	b=G2ORGB619BwW0qL7MU+8bXOj0wOOTudw7LUns4K1CsP687Jr6NEB6eOTglOxbbVY0
	 qeOPPs72rKm9v/QOCc1q31Ymg5Z59IjRGT9HXTZMiOkRvIrOMnZAtwmokUZiOME+F6
	 IBM789RVsClBuMn8PWMvm2xAGTMZpXv4wM4sYajU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CKk06u3032728
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 15:46:00 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 15:46:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 15:46:00 -0500
Received: from uda0214219 (uda0214219.dhcp.ti.com [128.247.81.222])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CKk0Il273149
	for <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 15:46:00 -0500
Received: from reatmon by uda0214219 with local (Exim 4.90_1)
	(envelope-from <reatmon@ti.com>)
	id 1uxAed-0002hp-UU
	for bitbake-devel@lists.openembedded.org; Fri, 12 Sep 2025 15:46:00 -0500
From: Ryan Eatmon <reatmon@ti.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [bitbake][PATCH 1/3] bitbake-setup: Tweak user inputs
Date: Fri, 12 Sep 2025 15:45:57 -0500
Message-ID: <20250912204559.10360-1-reatmon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 20:46:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18014

Create a common function to get the user input when choosing an item
from a list.  Add support for not returning from the function until the
user has selected a number.

When choosing items from the option list, if there is only one item,
then auto select it.  This is similar to code when picking the
configuration.

Signed-off-by: Ryan Eatmon <reatmon@ti.com>
---
 bin/bitbake-setup | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index dc2de30a8..36103f1e8 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -252,6 +252,14 @@ def flatten_bitbake_configs(configs):
                 flattened_configs.append(merge_configs(c, sub_c))
     return flattened_configs
 
+def get_user_input(prompt):
+    choice_s = ''
+    while choice_s.isdigit() == False:
+        print("\n{}:".format(prompt))
+        choice_s = input()
+    choice_n = int(choice_s)
+    return choice_n
+
 def choose_bitbake_config(configs, parameters, non_interactive):
     flattened_configs = flatten_bitbake_configs(configs)
     configs_dict = {i["name"]:i for i in flattened_configs}
@@ -274,8 +282,7 @@ def choose_bitbake_config(configs, parameters, non_interactive):
     print("\nAvailable bitbake configurations:")
     for n, config_data in enumerated_configs:
         print("{}. {}\t{}".format(n, config_data["name"], config_data["description"]))
-    print("\nPlease select one of the above bitbake configurations by its number:")
-    config_n = int(input())
+    config_n = get_user_input('Please select one of the above bitbake configurations by its number')
     return flattened_configs[config_n]
 
 def choose_config(configs, non_interactive):
@@ -298,8 +305,7 @@ def choose_config(configs, non_interactive):
            print("{}. {}\t{} (supported until {})".format(n, config_name, config_desc, expiry_date))
         else:
            print("{}. {}\t{}".format(n, config_name, config_desc))
-    print("\nPlease select one of the above configurations by its number:")
-    config_n = int(input())
+    config_n = get_user_input('Please select one of the above configurations by its number')
     return config_list[config_n][1]
 
 def choose_fragments(possibilities, parameters, non_interactive):
@@ -317,10 +323,16 @@ def choose_fragments(possibilities, parameters, non_interactive):
 
         print("\n" + v["description"] + ":")
         options_enumerated = list(enumerate(v["options"]))
+
+        if len(options_enumerated) == 1:
+            only_config = options_enumerated[0]
+            print("\nSelecting the only available option {}".format(only_config))
+            choices[k] = options_enumerated[only_config[0]][1]
+            continue
+
         for n,o in options_enumerated:
             print("{}. {}".format(n, o))
-        print("\nPlease select one of the above options by its number:")
-        option_n = int(input())
+        option_n = get_user_input('Please select one of the above options by its number')
         choices[k] = options_enumerated[option_n][1]
     return choices
 
-- 
2.17.1


