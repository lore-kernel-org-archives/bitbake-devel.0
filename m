Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A136CCFA18
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 22:34:06 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2180.1762900438966416525
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 14:34:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=arpTaBo5;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1329275-20251111223354fbd7b1f83900020715-62rt9r@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251111223354fbd7b1f83900020715
        for <bitbake-devel@lists.openembedded.org>;
        Tue, 11 Nov 2025 23:33:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=7KeqErQz7IvuCw10Zdf+OM7/de7+oL42IqpeR0uQtZY=;
 b=arpTaBo5zBEFPPcgLLmAQ0CutFtLdX1zBTKVDBXgWGzy7dW13L4Kc6WsfVktbt6rRUs6F0
 64z8ksUc/DOMXvQLNaW9/+67fbFRitw9hVN2g63XQ/HmZAWOr3eAAA7UEJUn779FKAMTEFOi
 DxUPyHCW+WdVBa6CaJNhI9S2qTc00cYYBBErHsrUqFAVleGi3Y244W3LSDNO4C/7cqFu0Fx2
 ly8Wvlcpa92mgqSeiRw5WWD48tNtsZP2vagvkHb/0qFUBLZcQJVyEUOU2I+8iG/eo11wleaU
 dfFMJ0vvw9/ya0tDTw4uyqiu/ta1Ig+8RzT75ncFHwM8iA2jPyQv2u1Q==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 1/3] bitbake-setup: remove unused imports
Date: Tue, 11 Nov 2025 23:33:23 +0100
Message-ID: <20251111223325.2034322-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 22:34:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18337

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 6521ee6f7..a3f352d79 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -8,12 +8,9 @@ import logging
 import os
 import sys
 import argparse
-import warnings
 import json
 import shutil
 import time
-import stat
-import tempfile
 import configparser
 import datetime
 import glob
-- 
2.51.1


