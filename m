Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
	[209.85.192.194])
	by mail.openembedded.org (Postfix) with ESMTP id 55DE2731BA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Mar 2016 06:41:34 +0000 (UTC)
Received: by mail-pf0-f194.google.com with SMTP id w128so807394pfb.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Mar 2016 22:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=TJC+6Uks16tOXFejvW/BZtqiZ741qSch80EKkuP78Mg=;
	b=GYl1SMscept5m7STWSrF5P2BgRVm0049VMXaH4beDKwUC9gYB8ZofrvUmuhwBp8w+u
	PivV2W1/YZxCFV9wDeKsdsLylYn0n4kv9vhP8QARPsjIB22gSghTCDLUEcTghx6fFVvL
	xU+dAYUdpSs4dLLpRC81x6nSmHsVFJErf8NKSy0SFdWlnRwN//oGIHYD6KCe3XlQG/kK
	5qRANWSwVlnnzh1m1ocEpUqCLYsjHCBhUxGOAxJsGPcCzew3atX6w1/eJbFv/N+CyPz9
	bc4My0Ej/HUyAApmmGQJAG0T8SQmczanEMuJiBt6qIiC93pLq0H5+RJ/tGDCT0y2db+U
	Kblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=TJC+6Uks16tOXFejvW/BZtqiZ741qSch80EKkuP78Mg=;
	b=S04O+m4RQGlQ+bmm4amdlkETUyRsquU83a7JW96Z5jpVR93vvH1G7JiFortC49ZFYW
	VZBUhMXLU7JuayLm5/eBds+N37RVJL0LWai9VocCN2+MPHdXTIuZalU3GU1V/3Gu64M3
	xZ0p+eng28uU7QGw9LvIKEdmH8/GHE5hD7XQISPGvQfeKZi01jA31hodGGB76VYj8a9z
	EYkBUn1f/GQJG2vqqssE629uffDPcASmw33PrJCluVF+uI2mYKfAU87WK4oCj+BYyLjh
	dvTd29SIdCgzOtIZyo6OFEto8WFm80p2ZP1/qviDZjqrx39N+zqovzHDbBlIeetNX4ZU
	E0CQ==
X-Gm-Message-State: AD7BkJKWdHFDpA5Uh/v7FIrIFeocy4FJlv6EsCB1XP7nWOmDzU153vr+/pds0/KrLTSnmw==
X-Received: by 10.98.42.8 with SMTP id q8mr1422285pfq.13.1456987295985;
	Wed, 02 Mar 2016 22:41:35 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	r62sm57476673pfr.26.2016.03.02.22.41.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Mar 2016 22:41:35 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Mar 2016 22:47:43 -0800
Message-Id: <3c22600af7e3ed4cbd96264ffa5b4bf3be0287a9.1456987460.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <05400d100e891245541e10b1d5db9a783004b20e.1456987460.git.avery.brian@gmail.com>
References: <05400d100e891245541e10b1d5db9a783004b20e.1456987460.git.avery.brian@gmail.com>
In-Reply-To: <cover.1456987460.git.avery.brian@gmail.com>
References: <cover.1456987460.git.avery.brian@gmail.com>
Subject: [PATCH 6/7] toasterui: exit on final events
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
X-List-Received-Date: Thu, 03 Mar 2016 06:41:35 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Toasterui exits only if bitbake observer shuts down.
In build mode it should exit when build is done.

Made toasterui exit on bb.command.CommandCompleted,
bb.command.CommandFailed and bb.command.CommandExit events
when it's running in build mode.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/toasterui.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 2d44377..728803d 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -388,7 +388,10 @@ def main(server, eventHandler, params):
             if isinstance(event, (bb.command.CommandCompleted,
                                   bb.command.CommandFailed,
                                   bb.command.CommandExit)):
-                errorcode = 0
+                if params.observe_only:
+                    errorcode = 0
+                else:
+                    main.shutdown = 1
 
                 continue
 
-- 
1.9.1


