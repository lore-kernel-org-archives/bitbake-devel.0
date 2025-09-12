Return-Path: <reatmon@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93751CA101F
	for <webhook@archiver.kernel.org>; Fri, 12 Sep 2025 20:46:06 +0000 (UTC)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 by mx.groups.io with SMTP id smtpd.web11.1170.1757709961337295659
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Sep 2025 13:46:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=lweaf7+N;
 spf=pass (domain: ti.com, ip: 198.47.19.246, mailfrom: reatmon@ti.com)
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CKk0gS1045522
	for <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 15:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757709960;
	bh=jxyB1NRy7mmXrHliXJcxaxpa/eRSEvx1qtTKNLbPzrI=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=lweaf7+N/Pbf8J4MweOtfqGbZItn3TWN8xhRz8H6ohMrvyVGLCTqblIuuC3fV8hW+
	 xilxLeHLzjy+yHuwXQ/e5CBillw2rBlIL1Icvsnd0hSyOnurvMrHDDtzCbBuMwAgmE
	 +eQ1BEpef3DjbuknWl8eKo94SuSs98giryKDmog0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CKk0741553821
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 15:46:00 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 15:46:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 15:46:00 -0500
Received: from uda0214219 (uda0214219.dhcp.ti.com [128.247.81.222])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CKk0sA273155
	for <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 15:46:00 -0500
Received: from reatmon by uda0214219 with local (Exim 4.90_1)
	(envelope-from <reatmon@ti.com>)
	id 1uxAee-0002hu-6B
	for bitbake-devel@lists.openembedded.org; Fri, 12 Sep 2025 15:46:00 -0500
From: Ryan Eatmon <reatmon@ti.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [bitbake][PATCH 3/3] bitbake-setup: Add --build-dir-style to init
Date: Fri, 12 Sep 2025 15:45:59 -0500
Message-ID: <20250912204559.10360-3-reatmon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250912204559.10360-1-reatmon@ti.com>
References: <20250912204559.10360-1-reatmon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 20:46:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18015

To allow for user control over the name of the build directory, add a
new command line argument to the init function that allows you to choose
from a list of options:

flat    - <config>-<opt1>-<opt2>-...-<optn>
hier    - <config>/<opt1>/<opt2>/.../<optn>
config  - <config>
options - <opt1>-<opt2>-...-<optn>

Where the <opt#> is the sequence of option choices configured in the
json file.

Signed-off-by: Ryan Eatmon <reatmon@ti.com>
---
 bin/bitbake-setup | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 342251bd5..cce9dcc70 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -386,7 +386,15 @@ def init_config(settings, args, d):
     upstream_config = obtain_config(settings, args, source_overrides, d)
     print("\nRun 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(" ".join(upstream_config['non-interactive-cmdline-options'])))
 
-    builddir = os.path.join(os.path.abspath(args.top_dir), "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_")))
+    if args.build_dir_style == "hier":
+        builddir = os.path.join(os.path.abspath(args.top_dir), "{}/{}".format(upstream_config['name'],"*slash*".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_").replace("*slash*","/")))
+    elif args.build_dir_style == "config":
+        builddir = os.path.join(os.path.abspath(args.top_dir), "{}".format(upstream_config['name']))
+    elif args.build_dir_style == "options":
+        builddir = os.path.join(os.path.abspath(args.top_dir), "{}".format(" ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_")))
+    else:
+        builddir = os.path.join(os.path.abspath(args.top_dir), "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_")))
+
     if os.path.exists(builddir):
         print("Build already initialized in {}\nUse 'bitbake-setup status' to check if it needs to be updated or 'bitbake-setup update' to perform the update.".format(builddir))
         return
@@ -749,6 +757,7 @@ def main():
     parser_init.add_argument('config', nargs='*', help="path/URL/id to a configuration file (use 'list' command to get available ids), followed by configuration options. Bitbake-setup will ask to choose from available choices if command line doesn't completely specify them.")
     parser_init.add_argument('--non-interactive', action='store_true', help='Do not ask to interactively choose from available options; if bitbake-setup cannot make a decision it will stop with a failure.')
     parser_init.add_argument('--source-overrides', action='store', help='Override sources information (repositories/revisions) with values from a local json file.')
+    parser_init.add_argument('--build-dir-style', action='store', default='flat', choices=['flat','hier','config','options'], help='Style to use for assembling the path to the build directory.  Default is flat.')
     parser_init.set_defaults(func=init_config)
 
     parser_status = subparsers.add_parser('status', help='Check if the build needs to be synchronized with configuration')
-- 
2.17.1


