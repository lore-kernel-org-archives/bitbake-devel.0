Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196])
	by mail.openembedded.org (Postfix) with ESMTP id A5499731BA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Mar 2016 06:41:34 +0000 (UTC)
Received: by mail-pf0-f196.google.com with SMTP id w128so807376pfb.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Mar 2016 22:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=yCWH+EyJ3EKLPloPRYVrFx+rqruVrtpEZnmdBw74ZPA=;
	b=LYsd79ZJKA5omH49P9Zzutu9DQghGZ+96kyfabyF9A+kg6PYJSiOAOCV/km3io2B9u
	b0NWcmumDibj+80joFFYge5XtSpGuZf58Q7UCIhxLGibtEspA1p9qc+g5AEsLYKHC2yy
	IPhbUebHROfjQLal6k30FYiCgh/hJoGE8qVG0w4Sx0/HFC+yS8OZJddAhegfTuRMjrhD
	u55Y17bcsaFWFje+LuAuA8jgVVeqbtaorFEpvifjD52/iNhhEQsO/wHZGHJSCxR3N9zB
	V70XsR0X6l/xWhSCF4/kv1pST47QA4W/nln/27rgK61ee2xC/Yc05STDNROrK4p/GxB5
	KPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=yCWH+EyJ3EKLPloPRYVrFx+rqruVrtpEZnmdBw74ZPA=;
	b=PXmFGpJQs2GvzKXJBvpPZJl5i1TFzDKOz1IgdEuk4k59UsKhLPbsuw1wKrX/bPg1IX
	dCQ+5tSVHMSW672FQg0jdYe8GiyLc7/SzcOpqduckOluvvjmyEEqG/w7o3/CorMyvO3s
	eQVxR+FmFxytLDejsDOEYZmTzTdwgdKKRYB4WqNfKh3j6eQjP5cuaqn1kI4mApqjceIQ
	BU6vd52evf4yFlLsr5V222QSwSf4byzuv5ikOskvDdzB17q/XA1BMsABtKsFY0ydNOLB
	88bv1aU/mgvUtdsA9pqbujawuUXyQUw+k9kRoTGQiQ9u/AlqlpugN0LBhYOkOcCAsMou
	Xv+w==
X-Gm-Message-State: AD7BkJIWnDTkDyyDNkeW5oZmEHCQitpoS00X8MciXGq+yEfjrXa/HqK7TQmqZ2I5jIABkA==
X-Received: by 10.98.44.73 with SMTP id s70mr1481444pfs.2.1456987295097;
	Wed, 02 Mar 2016 22:41:35 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	r62sm57476673pfr.26.2016.03.02.22.41.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Mar 2016 22:41:34 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Mar 2016 22:47:42 -0800
Message-Id: <fd655471a0731759bb7e4300c42eb7a46e94ef21.1456987460.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <05400d100e891245541e10b1d5db9a783004b20e.1456987460.git.avery.brian@gmail.com>
References: <05400d100e891245541e10b1d5db9a783004b20e.1456987460.git.avery.brian@gmail.com>
In-Reply-To: <cover.1456987460.git.avery.brian@gmail.com>
References: <cover.1456987460.git.avery.brian@gmail.com>
Subject: [PATCH 5/7] toasterui: make toasterui to work in build mode
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

Currently toasterui works only in observer mode. This is
artificial limitation which was made to support current toaster
design. As we decided to stop using bitbake server we'll
need to run toasterui also in build mode.

[YOCTO #7880]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/toasterui.py | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index fec6962..2d44377 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -168,8 +168,23 @@ def main(server, eventHandler, params):
         build_history_enabled = False
 
     if not params.observe_only:
-        logger.error("ToasterUI can only work in observer mode")
-        return 1
+        params.updateFromServer(server)
+        params.updateToServer(server, os.environ.copy())
+        cmdline = params.parseActions()
+        if not cmdline:
+            print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
+            return 1
+        if 'msg' in cmdline and cmdline['msg']:
+            logger.error(cmdline['msg'])
+            return 1
+
+        ret, error = server.runCommand(cmdline['action'])
+        if error:
+            logger.error("Command '%s' failed: %s" % (cmdline, error))
+            return 1
+        elif ret != True:
+            logger.error("Command '%s' failed: returned %s" % (cmdline, ret))
+            return 1
 
     # set to 1 when toasterui needs to shut down
     main.shutdown = 0
-- 
1.9.1


