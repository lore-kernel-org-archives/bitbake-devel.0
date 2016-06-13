Return-Path: <bartosz@woronicz.com>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
	[209.85.215.68])
	by mail.openembedded.org (Postfix) with ESMTP id 8776273166
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 12:16:18 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id l184so1261014lfl.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 05:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=woronicz.com; s=greetings;
	h=sender:from:to:cc:subject:date:message-id;
	bh=DE8HJDacbDyKJ59tZ50XoYsr9R4k5rVr+6MWTDdpIe4=;
	b=yC1aSmImQRsETASA8NtaVJGcY3pxCmvXr2Wibf5EIMutkhWfTz/KZnM+6hl0ldb/M1
	QuYdyodqrdnDabzr0S/vnlR9gaYgexKd89RSQT95FVrQtGqW0dzzwAlUNLVmQGUbWugG
	Hw757CRv/hQ30ZtGvvcs5IIgMdxJxPOozA/p8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mastier.pl; s=mastier;
	h=sender:from:to:cc:subject:date:message-id;
	bh=DE8HJDacbDyKJ59tZ50XoYsr9R4k5rVr+6MWTDdpIe4=;
	b=dYv6RPPcRURtpV7kqLxu4Z+bKydHQ0YCvMNIzKYS336izRWoqC+NLIqYe2QZgT6vdY
	QKmjGr86697wvEmkmVS3MT4lJKaaOR7PH1PHiryxyg0ZdUURhJzweHvwaI5VM4B26aLK
	jZQnlcm9NCp5Sls5m90xn6zOlwEUAbK43ND4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
	bh=DE8HJDacbDyKJ59tZ50XoYsr9R4k5rVr+6MWTDdpIe4=;
	b=YspBO5dXyZMsoKu0cyNZ44W0ZgubXPFJlSXhXdInLyfjDm5EkqOVr22R4PmpsEkXGr
	oHEA7bsqwPTCiW/oniZHquFl24jqen74xAiUbZx77ZKm3q3+NtaN22vxZ4pn7uei5rag
	m/DMCRl0sBPu8iOc4pCl31MfTVJecEfVpyC9f880DfgFBYXjcB4G8JvzK/5vb8WTzZB8
	edwQ/JuILcHjDXBtKwuxWKTgB6oLiZYFadEWXtriMY9RnTT/XcrJkdyrittBT52bqnrH
	8dj/gGdYeZW/uS/qUOnxalDHXtvMf1xNZ15Ur+htCeQr50NvGDKiL87msyrorAZ2Duuk
	Ruhw==
X-Gm-Message-State: ALyK8tKyZOh5qZWWYp4GrdFe7ITdjUqhOJ7rW/nlATgyykoXc9cTAU2h6G5JIUS477+scQ==
X-Received: by 10.25.26.10 with SMTP id a10mr191164lfa.97.1465820177451;
	Mon, 13 Jun 2016 05:16:17 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-241-90.play-internet.pl.
	[94.254.241.90]) by smtp.gmail.com with ESMTPSA id
	f20sm1247607lji.46.2016.06.13.05.16.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 13 Jun 2016 05:16:16 -0700 (PDT)
Sender: Bartosz Woronicz <bartosz@woronicz.com>
From: Bartosz 'mastier' Woronicz <mastier@mastier.pl>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Jun 2016 14:16:07 +0200
Message-Id: <1465820168-1657-1-git-send-email-mastier@mastier.pl>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 1/2] depexp: remove the not needed -g option requirement
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
X-List-Received-Date: Mon, 13 Jun 2016 12:16:21 -0000

Signed-off-by: Bartosz 'mastier' Woronicz <mastier@mastier.pl>
---
 bitbake/lib/bb/ui/depexp.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/depexp.py b/bitbake/lib/bb/ui/depexp.py
index 240aafc..6a6bfd5 100644
--- a/bitbake/lib/bb/ui/depexp.py
+++ b/bitbake/lib/bb/ui/depexp.py
@@ -202,9 +202,6 @@ def main(server, eventHandler, params):
             print(cmdline['msg'])
             return 1
         cmdline = cmdline['action']
-        if not cmdline or cmdline[0] != "generateDotGraph":
-            print("This UI requires the -g option")
-            return 1
         ret, error = server.runCommand(["generateDepTreeEvent", cmdline[1], cmdline[2]])
         if error:
             print("Error running command '%s': %s" % (cmdline, error))
-- 
2.7.4


