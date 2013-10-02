Return-Path: <erik.boto@pelagicore.com>
Received: from mail-lb0-f177.google.com (mail-lb0-f177.google.com
	[209.85.217.177])
	by mail.openembedded.org (Postfix) with ESMTP id 72EB06B605
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Oct 2013 14:37:57 +0000 (UTC)
Received: by mail-lb0-f177.google.com with SMTP id w7so822358lbi.36
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Oct 2013 07:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-type:content-transfer-encoding;
	bh=Pt5CmEXkGXREWKr6yw0kLNPkeKcggiNcSKngbmm54fQ=;
	b=ep8ALV3pxVVpS1AhOBfTlFWTRhjIK809HGL0WfTvVBM4W+sflyuRoAArO5ansluYz+
	An2tjXIXpidWiSaJ1WDYAiWm+BMvI3bSElUXiqncAe0zhu4eGbwWciKgliG5HKj+3pOE
	BRBTMwFqbrNWdPdN2FJQWTbhP/iQ1bipZ+UGeNvwTZBASasjWDN66SBjNnWAQVQzOVg8
	3lIogrb8fiFjkv28HoSj+WNYqbxDa0kw6+RT+AVEv1DhiKuYhBzOChxd2kIiaJh4A2PT
	WDAl6Z6cShApg9VKqf0AdcVW+lg4e8VAPxA8MN1M/KAZZwjFyyRgtCugRlPwTH1SV+PZ
	Q0Ng==
X-Gm-Message-State: ALoCoQne/0kPloGehAe7a0EfeKduBAXZBmzmtCK3Q0gLeg7Vtb/10PdFrkJeXeTtDbKBtChPDfGO
X-Received: by 10.152.22.35 with SMTP id a3mr1466538laf.45.1380724678610;
	Wed, 02 Oct 2013 07:37:58 -0700 (PDT)
Received: from erik-mbook.office.pelagicore.net
	(194-237-7-146.customer.telia.com. [194.237.7.146])
	by mx.google.com with ESMTPSA id l10sm1902592lbh.13.1969.12.31.16.00.00
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Wed, 02 Oct 2013 07:37:57 -0700 (PDT)
From: =?UTF-8?q?Erik=20Bot=C3=B6?= <erik.boto@pelagicore.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Oct 2013 16:37:37 +0200
Message-Id: <1380724657-23629-1-git-send-email-erik.boto@pelagicore.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
Subject: [PATCH] lib/bb/monitordisk.py: fix spelling in error text
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
X-List-Received-Date: Wed, 02 Oct 2013 14:37:57 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Erik Botö <erik.boto@pelagicore.com>
---
 lib/bb/monitordisk.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/monitordisk.py b/lib/bb/monitordisk.py
index c6d0767..3e6ecbd 100644
--- a/lib/bb/monitordisk.py
+++ b/lib/bb/monitordisk.py
@@ -225,7 +225,7 @@ class diskMonitor:
                         self.preFreeS[k] = freeSpace
 
                     if action == "STOPTASKS" and not self.checked[k]:
-                        logger.error("No new tasks can be excuted since the disk space monitor action is \"STOPTASKS\"!")
+                        logger.error("No new tasks can be executed since the disk space monitor action is \"STOPTASKS\"!")
                         self.checked[k] = True
                         rq.finish_runqueue(False)
                         bb.event.fire(bb.event.DiskFull(dev, 'disk', freeSpace, path), self.configuration)
@@ -253,7 +253,7 @@ class diskMonitor:
                         self.preFreeI[k] = freeInode
 
                     if action  == "STOPTASKS" and not self.checked[k]:
-                        logger.error("No new tasks can be excuted since the disk space monitor action is \"STOPTASKS\"!")
+                        logger.error("No new tasks can be executed since the disk space monitor action is \"STOPTASKS\"!")
                         self.checked[k] = True
                         rq.finish_runqueue(False)
                         bb.event.fire(bb.event.DiskFull(dev, 'inode', freeInode, path), self.configuration)
-- 
1.8.1.2


