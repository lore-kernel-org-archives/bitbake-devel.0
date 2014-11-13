Return-Path: <ross.burton@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id 5FB1C60167
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Nov 2014 16:35:23 +0000 (UTC)
Received: by mail-wi0-f175.google.com with SMTP id l15so4828629wiw.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Nov 2014 08:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=jEguN+5L8C91Eqg/BQC2JQu4MOou3HpHrlWIW5Ow/j8=;
	b=JJ4JcsfrVY49HBVnq2EcqJzu1vpCP1kzrCnr37157+HPrFyMy4+CNCJ0m3XN61hTla
	rVnmdRq8p2EDqXnG7IiroYUl8UohwxUXGIHpdz0GoYNCZLW+3JJUYa21m1aDzKz6ru2W
	Sa8uk/kF2SrDDqlcoijQLQBOD2l4U/r3x+W0DrpvtXdZxKWlZmibeB7LYAnpo+KQ16OE
	yiggK0ouDCSdMMJNGN8yolCWl/BUN7PaoXSOkZHuE1WGlK4Y0bHoK8dW9zmO9EHJqgsg
	G4zLIUZ0+ZSBLONXmrWPsaJ16ss4Wh7PgQDPMMtWq07RSVFFh1Y+tDppYr0FCxi6gd6Z
	zo1g==
X-Gm-Message-State: ALoCoQlJ/QBhYoGRUp/MYVQrjltZD5/3hEg0TGdHQKY7LTQxI0R6TPGcmAuOFPcm2Nmc7vr+t00u
X-Received: by 10.180.85.6 with SMTP id d6mr5437292wiz.82.1415896513857;
	Thu, 13 Nov 2014 08:35:13 -0800 (PST)
Received: from melchett.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
	by mx.google.com with ESMTPSA id p3sm36128355wjf.49.2014.11.13.08.35.12
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Nov 2014 08:35:13 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 13 Nov 2014 16:35:06 +0000
Message-Id: <1415896506-19460-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH] depexp: use stateForceShutdown instead of stateStop
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
X-List-Received-Date: Thu, 13 Nov 2014 16:35:24 -0000

This state was renamed in bitbake 12e9d3 but this use of it wasn't changed.

[ YOCTO #5445 ]

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/ui/depexp.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/depexp.py b/bitbake/lib/bb/ui/depexp.py
index 5d13b5b..0c71a3e 100644
--- a/bitbake/lib/bb/ui/depexp.py
+++ b/bitbake/lib/bb/ui/depexp.py
@@ -236,7 +236,7 @@ def main(server, eventHandler, params):
         try:
             event = eventHandler.waitEvent(0.25)
             if gtkthread.quit.isSet():
-                _, error = server.runCommand(["stateStop"])
+                _, error = server.runCommand(["stateForceShutdown"])
                 if error:
                     print('Unable to cleanly stop: %s' % error)
                 break
-- 
1.7.10.4


