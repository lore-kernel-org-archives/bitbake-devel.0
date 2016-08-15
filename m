Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
	[209.85.220.46])
	by mail.openembedded.org (Postfix) with ESMTP id A57F67680A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 10:41:41 +0000 (UTC)
Received: by mail-pa0-f46.google.com with SMTP id i5so15543454pat.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 03:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=wNx1WnzPl6vNZ7GMq9G5WWKkmWf1qWYLCEoNNZMwA7E=;
	b=XeLLBYbSEHKylaSK/PbARcgBxCIZs3cV3nH6AFJLCkroKO0oZot+NeS5I1FNfwADvG
	AAgj+0cXgGaxHTVq+4iC+gX9J+p6BDfyA+Nq+g/r87xhETl4mOMbNKsQlimgmxJqGDOP
	LmG7ZkiUs8d5/0JAgN/4g9demqkQ1Jm+0cRQqo+3bB7C1/1VGnBDULdJIuUbL8MquCmp
	x4Gubj8bfWQGRJsOyTUIJLLo394BFBDCQjFoCN+Gm4OF/L4f8zBQsT+1n7HKRnS029UA
	NF3XxtdqpSTfr7UEeoHC/FEpMjaZyZ5+g/JWG+rPKF1o0xWXo9b1pRVybLnwdGZtekoq
	W6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=wNx1WnzPl6vNZ7GMq9G5WWKkmWf1qWYLCEoNNZMwA7E=;
	b=imdHaqu49t0ZqkFy3KmhM0k9clwvQgs2x3mGQmjct0LZIzy3n4g5PHprDfnNPxovdx
	HBht7AXbQY/Cer/8cwjMrjiluzmKMAYK6ECs4d2460IXxRo5DYqZ1XdTx2mEvPDcvGsF
	WNPtEcOG6+UbrYSRxzoQufpShisiLQhYW+qGn50x4e9tGExUCHV+HjMOkq2gEd1k4yft
	ZRmTNWMNePDCyPXVvQK73Nt7z+bl8YuDHg37A/0BUXT0RemmpB3AU3wEm5ulHaqUKyMX
	8ZhdGPNqa7JzNsFv6zRz1gYepuIDeOISiB4ksvdCskARgGefJtfSH67wjbpsBugAHOoY
	YBJQ==
X-Gm-Message-State: AEkoouubwH6IBbeQ9syKFP+9CJM19x/wsP6p89tIercaDv2blyA2wJHZ32L0ASX+TNEDRScR
X-Received: by 10.66.48.133 with SMTP id l5mr408361pan.151.1471257702121;
	Mon, 15 Aug 2016 03:41:42 -0700 (PDT)
Received: from orion.ger.corp.intel.com ([192.55.54.43])
	by smtp.gmail.com with ESMTPSA id
	n10sm31033917pap.16.2016.08.15.03.41.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 15 Aug 2016 03:41:41 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 15 Aug 2016 11:41:33 +0100
Message-Id: <1471257693-11263-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: David Reyna <david.reyna@windriver.com>
Subject: [PATCH] toaster: update web urls for openembedded-core's special case
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
X-List-Received-Date: Mon, 15 Aug 2016 10:41:41 -0000

From: David Reyna <David.Reyna@windriver.com>

The layer index update command has a special case for the
updating 'openembedded-core' layer, and it was missing reading
and updating the git web URL fields.

[YOCTO #8037]

Signed-off-by: David Reyna <david.reyna@windriver.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/management/commands/lsupdates.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index 89817c8..8ff120e 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -165,6 +165,12 @@ class Command(NoArgsCommand):
                     # layerindex
                     oe_core_l.summary = li['summary']
                     oe_core_l.description = li['description']
+                    oe_core_l.vcs_web_url = li['vcs_web_url']
+                    oe_core_l.vcs_web_tree_base_url = \
+                        li['vcs_web_tree_base_url']
+                    oe_core_l.vcs_web_file_base_url = \
+                        li['vcs_web_file_base_url']
+
                     oe_core_l.save()
                     li_layer_id_to_toaster_layer_id[li['id']] = oe_core_l.pk
                     self.mini_progress("layers", i, total)
-- 
2.7.4


