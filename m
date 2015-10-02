Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id B0720770E4
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Oct 2015 18:03:35 +0000 (UTC)
Received: by padhy16 with SMTP id hy16so112576103pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Oct 2015 11:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=mFKXk691v/GyiEekmx1ayJmCJdPu8jlEyWB0d7q9rUI=;
	b=KXTSTzlskALUispRX79D1M5nLwSWbhezWdc598fnK8icIiOeEZSDo4YRGYnqJYENwg
	ldcv52QWrQtE9fRzI/+VPtd1/5gc0uxXbxgL5ai99aTIeOJV5HuowzZFq7UE37+Rt1lH
	YubYv3QTEeVymVtidGFNyXIK7ZE9ekDNyeorgvey79Rx0KZOvm7ASyhyephBtr2K9y/G
	rcvjxEBStJB8zqHKOhPw8asYa7Zcc8uW/NQdO53nt/I4rPhwaCjaUohoLdsJehCMgfBx
	zD6memdVAzHsReLhcdVWmq8ybA8cZfIb2arj+yi2EUeT+qU59lf4D621oW2ovgm9z9fB
	JDHw==
X-Received: by 10.69.1.67 with SMTP id be3mr21847038pbd.78.1443809015705;
	Fri, 02 Oct 2015 11:03:35 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	kw10sm13142211pbc.25.2015.10.02.11.03.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 02 Oct 2015 11:03:34 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Oct 2015 11:05:14 -0700
Message-Id: <8a643a3e0a049a4a8434f9c7482ef7af75883ccf.1443809021.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f026371a5150719b58b806622ad111dd1567513f.1443809021.git.avery.brian@gmail.com>
References: <f026371a5150719b58b806622ad111dd1567513f.1443809021.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443809021.git.avery.brian@gmail.com>
References: <cover.1443809021.git.avery.brian@gmail.com>
Subject: [PATCH 3/5] toaster: fix NameError
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
X-List-Received-Date: Fri, 02 Oct 2015 18:03:35 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Fixed exception: NameError: global name 'DoesNotExist' is not defined

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/orm/models.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 431bd8b..670ec78 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -900,7 +900,7 @@ class LayerIndexLayerSource(LayerSource):
                     oe_core_l.save()
                     continue
 
-                except DoesNotExist:
+                except Layer.DoesNotExist:
                     pass
 
             l, created = Layer.objects.get_or_create(layer_source = self, name = li['name'])
-- 
1.9.1


