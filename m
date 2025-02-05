Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431CDC02194
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 13:58:58 +0000 (UTC)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
 by mx.groups.io with SMTP id smtpd.web11.12398.1738763936407226611
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Feb 2025 05:58:56 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.8, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yp1zy3KD0zw75;
	Wed,  5 Feb 2025 14:58:54 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yp1zx5LRGz1KN;
	Wed,  5 Feb 2025 14:58:53 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 05 Feb 2025 14:58:40 +0100
Subject: [PATCH v3] add basic support for b4 contribution workflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-b4-support-v3-1-d7f94eca8a3e@cherry.de>
X-B4-Tracking: v=1; b=H4sIAI9uo2cC/23MQQ7CIBCF4as0rMUwMJTWlfcwLhSmlk3bQCU2D
 XeXNjHRxOV7yfevLFLwFNmpWlmg5KMfhzLUoWK2vw0P4t6VzaSQKLREfkcen9M0hplT22jdWY0
 OBStgCtT51x67XMvufZzHsOztBNv7N5OAAxcWlUKramvN2fYUwnJ0xLZMkh+qBYD5obJQA6bpa
 nDYEn7TnPMbPlbc+N8AAAA=
X-Change-ID: 20240524-b4-support-e9855fc54d40
To: bitbake-devel@lists.openembedded.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 13:58:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17157

From: Quentin Schulz <quentin.schulz@cherry.de>

b4[1] is a very nice tool for mail-based contribution. A config[2] file
exists to set up a few defaults. We can use it to set the To recipients
to always add, in our case the mailing list.

This also adds a wrapper script that is called by b4 to figure out which
addresses to put as Cc recipients. Considering that patches to the doc/
directory also need to be sent to the yocto-docs mailing list, this
wrapper handles that. A limitation of the script (lsdiff actually) is
that it doesn't know how to handle empty files, but those should be
of rather rare occurrences.

Because we currently do not have anything to check for patch validity,
remove requirement for b4 prep --check to be run before sending a patch
series, via disable-needs-checking in prep-pre-flight-checks.

[1] https://pypi.org/project/b4/
[2] https://b4.docs.kernel.org/en/latest/config.html

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
This adds a basic config file for b4 to avoid to have to add the mailing
list by hand.
For documentation patches, the additional mailing list will be added
when running b4 prep --auto-to-cc, as is required for each new series
managed by b4.

Note that b4 supports patchwork, c.f.
https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-settings
though I have no clue what it does with it as I am no maintainer, but
maybe something worth having a look at if some maintainer of this repo
wants to use b4 to merge stuff?
---
Changes in v3:
- bitbake mailing list is added to To recipients, while docs mailing
  list still is part of the Cc recipients, 
- the wrapper script doesn't print the bitbake mailing list anymore as
  it handles only Cc recipients,
- moved the script to contrib/,
- renamed script to b4-wrapper-bitbake.py,
- added license and copyright holder to b4 wrapper script,
- Link to v2: https://lore.kernel.org/r/20250117-b4-support-v2-1-7178f61d49e4@cherry.de

Changes in v2:
- add b4-wrapper for auto-detecting patches that are to be sent to the
  docs mailing list as well,
- disable forced b4 prep --check for each b4-managed series,
- Link to v1: https://lore.kernel.org/r/20240524-b4-support-v1-1-0c4334c36cc7@cherry.de
---
 .b4-config                    |  4 ++++
 contrib/b4-wrapper-bitbake.py | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000000000000000000000000000000000000..047f0b94a4f7844640373b99369fc053d54e5f5b
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,4 @@
+[b4]
+  send-series-to = bitbake-devel@lists.openembedded.org
+  send-auto-cc-cmd = ./contrib/b4-wrapper-bitbake.py send-auto-cc-cmd
+  prep-pre-flight-checks = disable-needs-checking
diff --git a/contrib/b4-wrapper-bitbake.py b/contrib/b4-wrapper-bitbake.py
new file mode 100755
index 0000000000000000000000000000000000000000..87dff2c3a728861f2b4f75aba4924f4875a63e30
--- /dev/null
+++ b/contrib/b4-wrapper-bitbake.py
@@ -0,0 +1,40 @@
+#!/usr/bin/env python3
+#
+# Copyright OpenEmbedded Contributors
+#
+# SPDX-License-Identifier: MIT
+#
+# This script is to be called by b4:
+# - through b4.send-auto-cc-cmd with "send-auto-cc-cmd" as first argument,
+#
+# When send-auto-cc-cmd is passed:
+#
+#  This returns the list of Cc recipients for a patch.
+#
+# This script takes as stdin a patch.
+
+import subprocess
+import sys
+
+cmd = sys.argv[1]
+if cmd != "send-auto-cc-cmd":
+    sys.exit(-1)
+
+patch = sys.stdin.read()
+
+if subprocess.call(["which", "lsdiff"], stdout=subprocess.DEVNULL) != 0:
+    print("lsdiff missing from host, please install patchutils")
+    sys.exit(-1)
+
+files = subprocess.check_output(["lsdiff", "--strip-match=1", "--strip=1", "--include=doc/*"],
+                                input=patch, text=True)
+if len(files):
+    print("docs@lists.yoctoproject.org")
+else:
+# Handle patches made with --no-prefix
+    files = subprocess.check_output(["lsdiff", "--include=doc/*"],
+                                    input=patch, text=True)
+    if len(files):
+        print("docs@lists.yoctoproject.org")
+
+sys.exit(0)

---
base-commit: 29e67acb87ae76879efe9688a69c961a96df10f1
change-id: 20240524-b4-support-e9855fc54d40

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


