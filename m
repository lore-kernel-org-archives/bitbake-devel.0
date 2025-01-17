Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30738C0218A
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 10:44:38 +0000 (UTC)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
 by mx.groups.io with SMTP id smtpd.web11.7956.1737110674005913583
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jan 2025 02:44:34 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.13, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YZGZS2yQlz9JR;
	Fri, 17 Jan 2025 11:44:32 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YZGZR3NNtzbBy;
	Fri, 17 Jan 2025 11:44:31 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 17 Jan 2025 11:44:09 +0100
Subject: [PATCH v2] add basic support for b4 contribution workflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-b4-support-v2-1-7178f61d49e4@cherry.de>
X-B4-Tracking: v=1; b=H4sIAHg0imcC/23Myw6CMBCF4Vchs3ZMaadeWPkehoVOB+kGyBSJh
 PTdraxd/ic53wZJNEqCptpAZYkpjkMJe6iA+8fwEoyhNFhjyXhL+CRM72kadUa5Xrzv2FMgA+U
 wqXTxs2P3tnQf0zzquttL/Vv/MkuNNRom54jdifl8415U12MQaHPOXyhaUmikAAAA
X-Change-ID: 20240524-b4-support-e9855fc54d40
To: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 10:44:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17023

From: Quentin Schulz <quentin.schulz@cherry.de>

b4[1] is a very nice tool for mail-based contribution. A config[2] file
exists to set up a few defaults. We can use it to set the Cc recipients
to always add, in our case the mailing list.

This also adds a wrapper script that is called by b4 to figure out which
addresses to put as Cc recipients. Considering that patches to the doc/
directory also need to be sent to the yocto-docs mailing list, this
wrapper handles that. A limitation of the script (lsdiff actually) is
that it doesn't know how to handle empty files, but those should be
of rather rare occurrences.

While the wrapper script should be enough by itself to add the bitbake
mailing list to the Cc recipients, one still needs to manually run b4
prep --auto-to-cc for that to happen. Therefore, let's add an explicit
send-series-cc so that at least that mailing list is always there.

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
when running b4 prep --check, as is required for each new series managed
by b4.

Note that b4 supports patchwork, c.f.
https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-settings
though I have no clue what it does with it as I am no maintainer, but
maybe something worth having a look at if some maintainer of this repo
wants to use b4 to merge stuff?
---
Changes in v2:
- add b4-wrapper for auto-detecting patches that are to be sent to the
  docs mailing list as well,
- disable forced b4 prep --check for each b4-managed series,
- Link to v1: https://lore.kernel.org/r/20240524-b4-support-v1-1-0c4334c36cc7@cherry.de
---
 .b4-config    |  4 ++++
 b4-wrapper.py | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000000000000000000000000000000000000..0b699f204c414099f2118ffdbc9f7b24454e4a4e
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,4 @@
+[b4]
+  send-series-cc = bitbake-devel@lists.openembedded.org
+  send-auto-cc-cmd = ./b4-wrapper.py send-auto-cc-cmd
+  prep-pre-flight-checks = disable-needs-checking
diff --git a/b4-wrapper.py b/b4-wrapper.py
new file mode 100755
index 0000000000000000000000000000000000000000..ddc2597bc0374fa5124a83be94eeab52df6f38d3
--- /dev/null
+++ b/b4-wrapper.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
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
+print("bitbake-devel@lists.openembedded.org")
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
base-commit: 0329a7e3ac694737f2d2c1861f65492551360663
change-id: 20240524-b4-support-e9855fc54d40

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


