Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E60CD484C
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 22:03:23 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9655.1762984998475714165
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 14:03:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=LaDD2vPo;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1329275-20251112220314e91597014700020710-fed_5a@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251112220314e91597014700020710
        for <bitbake-devel@lists.openembedded.org>;
        Wed, 12 Nov 2025 23:03:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=MFsmpZL5LdtZew0HLWZPdMhAdXLr7xYNpkUoDW5zTNY=;
 b=LaDD2vPoP+TC4HqDjJu3B/BgVaVfcBpLs84plgnBKCKvsvzgDgHkFlXCib1CbtaVRq50PF
 yRiiYtmMfxGewcGtYaEQT1JoesvqncfgbLWDaogzVBEIXG/7rnW3pQW0GL29pghTlM56z2s2
 PAH+HNSTP6cjhm+49mVcFEYOxlUtggHuTrcf3Oq4VLSgyAByNs9VN7hD6kk5e/hjma4gHRXT
 ApcGAo06O1vMcJ1aECkaUy42gsiluAl6CvlKLqRL7pI8eicUGvKLsWuAg7k0980aDhuEuGJy
 b6080ne9n42NctiybFLCMVfKjWpz8ZcLKVKQ1G8Wz5Slk9NLBcvcq0TQ==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 1/2] bitbake-setup: default top-dir-prefix to cwd
Date: Wed, 12 Nov 2025 23:03:00 +0100
Message-ID: <20251112220301.3651499-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 22:03:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18365

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

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index e11a466c6..3a281defa 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -878,7 +878,7 @@ def main():
 
         builtin_settings = {}
         builtin_settings['default'] = {
-                         'top-dir-prefix':os.path.expanduser('~'),
+                         'top-dir-prefix':os.getcwd(),
                          'top-dir-name':'bitbake-builds',
                          'registry':default_registry,
                          }
-- 
2.51.1


