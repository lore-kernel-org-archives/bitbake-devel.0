Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3AACD13CF
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 22:34:06 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2186.1762900446038701941
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 14:34:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=k7GbpqY3;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1329275-202511112234041ab2e023c4000207c6-hggvn4@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202511112234041ab2e023c4000207c6
        for <bitbake-devel@lists.openembedded.org>;
        Tue, 11 Nov 2025 23:34:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=k+HLCADDlRBBhU2yUdQl9rIpMf/6+HGt1b6GD1RcfyI=;
 b=k7GbpqY3H5gB/xddwpNooqv6QXGqOobYBWGUCQB3vIdY9/sxCLLdNs3bXQEeiLVDFRqkDC
 Gmx9Kfv+O8GJcU9e5RRfPzg3qDBQFHah/wbs6z4g9Zb0kOTvU3VenS8jy8pdsOARt2i2+Stv
 9M+0rhB6TAOsD3953zMLMJFcvIn6Jh9sxW8DaKtZt+UOYdT/G5UrL/O9aNWv7yzA0AXOcE1B
 ww4q7D/G5xvYbk3iF3uDupd9ot0mhb/gbvNqTPHODSzlXpnZd8XJP0S3EQov5zxoM8yeIDtS
 GZdZicEY1DJVgVd5Y3KoAvGDtngdQ5vfP94yee7n7K1ss54Enx28QqBg==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 2/3] bitbake-setup: default top-dir-prefix to cwd
Date: Tue, 11 Nov 2025 23:33:24 +0100
Message-ID: <20251111223325.2034322-2-adrian.freihofer@siemens.com>
In-Reply-To: <20251111223325.2034322-1-adrian.freihofer@siemens.com>
References: <20251111223325.2034322-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 22:34:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18338

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Change the default for top-dir-prefix from user's home directory to
current working directory.

This allows to do:
    mkdir -p ~/temp/bb-test
    cd ~/temp/bb-test
    bitbake-setup init
      ...
      setup-dir = poky-altcfg

ending up with the build directory at:
  ~/temp/bb-test/bitbake-builds/poky-altcfg/build

It's a well known pattern to have Yocto builds setup in a self-contained
directory rather than in a absolute directory. There are also users who
have seperate partitions or even extra disks for their builds.

bitbake-selftest: setup: check default top-dir-prefix is cwd

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup     | 2 +-
 lib/bb/tests/setup.py | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index a3f352d79..bda62f5f4 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -870,7 +870,7 @@ def main():
 
         builtin_settings = {}
         builtin_settings['default'] = {
-                         'top-dir-prefix':os.path.expanduser('~'),
+                         'top-dir-prefix':os.getcwd(),
                          'top-dir-name':'bitbake-builds',
                          'registry':default_registry,
                          }
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 6e9bf0365..d761ee734 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -239,6 +239,10 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         # check that --help works
         self.runbbsetup("--help")
 
+        # check that the default top-dir-prefix is cwd before any settings are configured
+        out = self.runbbsetup("settings list")
+        self.assertIn("default top-dir-prefix {}".format(os.getcwd()), out[0])
+
         # set up global location for top-dir-prefix
         out = self.runbbsetup("settings set --global default top-dir-prefix {}".format(self.tempdir))
         settings_path = "{}/global-config".format(self.tempdir)
-- 
2.51.1


