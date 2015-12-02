Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
	[209.85.220.52])
	by mail.openembedded.org (Postfix) with ESMTP id D603C612E5
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 18:00:03 +0000 (UTC)
Received: by pabfh17 with SMTP id fh17so48548077pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 10:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=8lX3dQUtvVEgcMAy8i4Uaai4NGTisGJIMtaNL6Wc2R8=;
	b=rBfpoJkURvLtFLH4pYRDh65X84I7Bs1ZLMsz2zh/qsB5qa3Aiv5IWIT6e8W7ld1DtD
	XjcEpuc4rWQiksv3cbQ9HF5W0hKHoguZX9Gym+gyzBejVVTymFq69KfwJpCR/ClWKdfz
	ZYGXgNgjHg2iq1S/0geMfPMVLG1mSmlhXJmxKtfvknQ+YhrcAAwzPfSLgKS+mn/+tetg
	tZi+DCbpDSLQW+V/92rlCzTaTDGMgkl+4t/gqNLy2GPoxTZRdX0FodQCMhCH0oPr8Cf0
	ymvqob3gkgKj8uH4eglL7opgZ/xN1/5xqa7FyHubUXinyQg5iG+sDSW157yug/E5HM3e
	YHew==
X-Received: by 10.66.102.97 with SMTP id fn1mr6524195pab.131.1449079204950;
	Wed, 02 Dec 2015 10:00:04 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.10.00.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 10:00:04 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:03:02 -0800
Message-Id: <d27c3c279025a7c4bd1c0851ad40195cad318937.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 30/30] toasterui: process CommandStarted event
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
X-List-Received-Date: Wed, 02 Dec 2015 18:00:04 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Currently BRBE is known to toasterui only when build is
started. It't passed to it with BuildStarted event. This is
too late as if build fails earilier than build starts toasterui
can not inform Toaster about the failure.

Set BRBE as soon as it's provided by Toaster.
This should make toasterui to be able to inform Toaster
about early build failures, i.e. failures during parsing.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/toasterui.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 435cc2b..1fc5f1f 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -185,6 +185,13 @@ def main(server, eventHandler, params):
             # pylint: disable=protected-access
             # the code will look into the protected variables of the event; no easy way around this
 
+            # Set brbe as soon as it's provided by toaster
+            if isinstance(event, bb.command.CommandStarted):
+                if event.commandline[0] == 'setVariable' and \
+                   event.commandline[1] == 'TOASTER_BRBE':
+                    buildinfohelper.brbe = event.commandline[2]
+                continue
+
             # we treat ParseStarted as the first event of toaster-triggered
             # builds; that way we get the Build Configuration included in the log
             # and any errors that occur before BuildStarted is fired
-- 
1.9.1


