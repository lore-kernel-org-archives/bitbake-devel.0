Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id D50F375F7C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jul 2015 16:23:10 +0000 (UTC)
Received: by wgav7 with SMTP id v7so69318657wga.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jul 2015 09:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=K0gKi1+Hn3YfcYIIUOSrYfIvw73guUqlheu+myN/JjI=;
	b=Dku2+061oh1Rmt0pa57Yxohk2dSBshsf4tuPxTWcCnFJxaTT4970yNFBqJf5ua4+c4
	U4vNU48hH67dFpI72FNJJESQuQ2N0ZxT097daG8z++6//ai6j0uGKnS67Lmb839oX/SR
	Lrju8xlo41i62f9nkyqpwINNxTk6xl3DEHaxvbXNg1CwIm0qSTGVDbECJYrvaDyuJVp0
	JVtJ7DZCW8VfqbbfYT7Crf8gbTAOuL/861YK6+W5JMchO2ZEBapCyZR0Y/8h8atuocbt
	pmkypvsFX/INn0QjcPrfRQmw2YefC//eWXLya0BJn5agEAF8jh32xKqiiJlRX7JGEQsq
	8YSA==
X-Gm-Message-State: ALoCoQl4riGKOiDPwMNkYrRrJJ2rMTqq70ktgIoZmYoigHNsbt4oplNO330H8fGTvjjFO4avuiDj
X-Received: by 10.180.95.101 with SMTP id dj5mr23011029wib.16.1437409390046;
	Mon, 20 Jul 2015 09:23:10 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	b13sm12519919wic.15.2015.07.20.09.23.08
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 Jul 2015 09:23:09 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id EFCE0561AEA; Mon, 20 Jul 2015 17:23:20 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Jul 2015 17:23:20 +0100
Message-Id: <1437409400-23597-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Brian Avery <brian.avery@intel.com>
Subject: [PATCH 1/1] toaster: continue processing layer dependencies despite errors
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
X-List-Received-Date: Mon, 20 Jul 2015 16:23:13 -0000

From: Brian Avery <brian.avery@intel.com>

Sometimes, a layer dependency will not exist,
  or not exist for a particualr branch. In this case
  we need to continue processing and hope for the best.

[YOCTO #7955]

Signed-off-by: Brian Avery <brian.avery@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 4ea75f2..2b1a5b7 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -889,9 +889,8 @@ class LayerIndexLayerSource(LayerSource):
                 dependlist[lv] = []
             try:
                 dependlist[lv].append(Layer_Version.objects.get(layer_source = self, layer__up_id = ldi['dependency'], up_branch = lv.up_branch))
-            except Layer_Version.DoesNotExist as e:
+            except Layer_Version.DoesNotExist:
                 print "Cannot find layer version ", self, ldi['dependency'], lv.up_branch
-                raise e
 
         for lv in dependlist:
             LayerVersionDependency.objects.filter(layer_version = lv).delete()
-- 
1.9.1


