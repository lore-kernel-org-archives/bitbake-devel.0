Received: from mail-wi0-f171.google.com ([209.85.212.171])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1SwyoX-0006kV-US
	for bitbake-devel@lists.openembedded.org;
	Thu, 02 Aug 2012 19:03:57 +0200
Received: by wibhq4 with SMTP id hq4so4674416wib.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 02 Aug 2012 09:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=D+fxfvViyAgEs4CBiX1zq56x4tc1dy1+jj7wwbNObLM=;
	b=hT3JH+kVsOmXUw5EBEGz6SxrCpkj0ysllEy+9IrTUybVFRx3jZMOv257hi8QJDrXA/
	+/M+GFAOjLMDqSs5kH9hgooeWQYoUUrhIFrdnmftuies4ChYFUFeNABltADY5A/kvghC
	+/FPXirMw3G7Hc/VQfoLoyBJFLr1dNQMbPUUehy3l/Cu2ZptOsgza/iKOzByvxlIbFeb
	EdVDQjLbeaVbBdSsif3QbZrWbNFlqVE56Zc77G+AGsBvyfzQVIUW5FjWzoAWk1naUdZO
	TRpW0D3SqrkYraa77hn6+ILvXkHBq6SV5E7rIY3stowAdu1Gt9hFQX3oG3NLFn2wV0uG
	AxUg==
Received: by 10.216.242.196 with SMTP id i46mr10247599wer.123.1343926338333;
	Thu, 02 Aug 2012 09:52:18 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id ef5sm18479721wib.3.2012.08.02.09.52.16
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 02 Aug 2012 09:52:17 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  2 Aug 2012 18:52:15 +0200
Message-Id: <1343926335-7612-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.7.8.6
Subject: [PATCH] cooker: fix OVERRIDES in BB_SIGNATURE_HANDLER (to override value from DISTRO.conf from local.conf)
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 02 Aug 2012 17:03:58 -0000

* added as RP said. I haven't seen any unwanted side-effects in last 2
  days of using this

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/cooker.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 5d01af3..23fffc9 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -158,6 +158,7 @@ class BBCooker:
         #
         self.configuration.event_data = bb.data.createCopy(self.configuration.data)
         bb.data.update_data(self.configuration.event_data)
+        bb.parse.init_parser(self.configuration.event_data)
 
         # TOSTOP must not be set or our children will hang when they output
         fd = sys.stdout.fileno()
-- 
1.7.8.6



