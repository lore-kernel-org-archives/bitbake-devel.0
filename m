Return-Path: <michael.g.wood@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 3BAE960557
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Oct 2014 17:48:04 +0000 (UTC)
Received: by mail-wg0-f43.google.com with SMTP id n12so1481232wgh.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Oct 2014 10:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=hFxc+wSV2TPDXITviOWfORrRxNQcxhIiiy4vvw2ST1c=;
	b=DbrYBex9MIuxkD6IOA/2HMbuEjJURTtifNDUYy2aJy3duE58WL9qLeSodbAOs6/6P6
	PV3R+UwHU/qb6vdEL3eH6IYFRSkTmBwoAaXwLz5JmJxIEYOHPo+rp8x2+eHOR2vN4NO6
	l9iXlEDaJlByUBjWt5f/BJWn7JVlx20dapSs8diuuoWXcZ0WD4tsPLYv3Xfj6CxKdYBK
	Ofl1c0Y+r/hmxUdDCjLAsbFrhs2TpiUJNKNoY/+zYbb/YYFZSgD7lBt0SKhnfbPhi+XE
	4t94nCva78U4inHU4HuiKy8B+e+wnbIPuK36MDmhQ3kxO7fvXKXktFGAHFG7y3nPGnlQ
	uL9w==
X-Gm-Message-State: ALoCoQm+Pu/Kbu0D6rw45PPscrr7EiZdjJOdYPZ7jvSH8tBjxG5WECAP8FJm3cClplFDYJQrh5KZ
X-Received: by 10.180.88.102 with SMTP id bf6mr29635433wib.43.1414518482821;
	Tue, 28 Oct 2014 10:48:02 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fa16sm16157296wid.5.2014.10.28.10.48.02 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 28 Oct 2014 10:48:02 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Oct 2014 17:47:12 +0000
Message-Id: <1414518432-28450-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] bitbake: buildinfohelper: Make sure we use the orm defined value for loglevel
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 28 Oct 2014 17:48:08 -0000

We need to consistently use LogMessage.INFO/WARNING/ERROR to make sure toaster knows
how to categories these rather than passing in the "raw" loglevel value
which in best case comes from python logging but worst case any value.

[YOCTO 6885]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 3800626..fcef53b 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -983,14 +983,12 @@ class BuildInfoHelper(object):
 
         log_information = {}
         log_information['build'] = self.internal_state['build']
-        if event.levelno >= format.ERROR:
-            log_information['level'] = event.levelno
+        if event.levelno == format.ERROR:
+            log_information['level'] = LogMessage.ERROR
         elif event.levelno == format.WARNING:
             log_information['level'] = LogMessage.WARNING
-        elif event.levelno == format.INFO:
-            log_information['level'] = LogMessage.INFO
         else:
-            log_information['level'] = event.levelno
+            log_information['level'] = LogMessage.INFO
 
         log_information['message'] = event.msg
         log_information['pathname'] = event.pathname
-- 
1.9.1


