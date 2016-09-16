Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
	[209.85.220.43])
	by mail.openembedded.org (Postfix) with ESMTP id 6399676F8C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 16:22:59 +0000 (UTC)
Received: by mail-pa0-f43.google.com with SMTP id cm16so27480299pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=o/oos6BsIBrTDD18zHQ4p3QNIsffSTDjavt42jd9//M=;
	b=UNJa20GAW0PMMWqz/x8WkA9CqzvHO9cHpb1D5VQXG5HafKksW5CORahoWPfSAROnIi
	tZUZgo2D+j2iDrrqwiwOnhnbo9rxJP4XkJNhNP5+a+y+bmHXJ36l2obFpdQmSLvh0MKc
	Ej6OOZLr53uihMc15sNiSZAzm1H0/fZGcSv76IQbTftDlzyVXBYJ4Q29yBc4geexcXOK
	S+ddD3fwWVhPGhmk0gOMWZxTeENGFAiRoTuLlyPTqXrvOD9TMEYXkIqqKjccIM/USrK8
	bw6HgCuUcWDqiA/5Hw0ylvIE/FyMdI8+jfk+YQMfCAYrctVbFC8mfe8SXjfmi+oEFtsL
	io2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=o/oos6BsIBrTDD18zHQ4p3QNIsffSTDjavt42jd9//M=;
	b=KpROYCYama6u45sLrryyhPRw9ozdSbWDapH8zsQMOGphMu/aIdN/l5KUS4kBX58uHZ
	ce2NsOdyPIhGNqAUZZg9NaBY6Ar69qHsgLTiGKcUHEu9xzIV+QrF2uWeQLqHDnScRph0
	LUrTpeNTCHlP5H8gaSAxpm4haNP5PJwxDjNu7cQRL9Lkw4DUeBMOrKJvENHPsHL0e62D
	UVcupnOkZG0u611r0hS/LwkQ83XKCISaIRZK1coNow8Bzbw3j0GOMf6g0i8W3WxbHHNo
	XrNxggsMB1vAm/Hu26QrQ7YcpGofDUycuSthIOMzm0Dyhe1+CHi1Qb8xr7lw3Twcb02G
	rfig==
X-Gm-Message-State: AE9vXwPMoA5dKV6Gyc85j9WdjvI27JIQfNMIhpXTUeJWIw1D5JxBAvJLOWc1VJ/w53G5saOG
X-Received: by 10.66.10.170 with SMTP id j10mr24343935pab.3.1474042980282;
	Fri, 16 Sep 2016 09:23:00 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr04-ext.fm.intel.com.
	[192.55.55.39]) by smtp.gmail.com with ESMTPSA id
	bm8sm13336146pac.16.2016.09.16.09.22.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Sep 2016 09:22:59 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2016 17:22:35 +0100
Message-Id: <1474042955-12618-9-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474042955-12618-1-git-send-email-michael.g.wood@intel.com>
References: <1474042955-12618-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 8/8] toaster: unlock BuildEnvirnoment when build is done
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
X-List-Received-Date: Fri, 16 Sep 2016 16:23:00 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

There is no need to lock build environment before changing
build status as this operation is very fast. However, there
is a need to unlock it after changing build status.

Explicitly unlocked BuildEnvironment after build reaches
final status SUCCEEDED, FAILED or CANCELLED. This should
allow runbuilds process to pickup next build faster.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index c93ee94..2246960 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -1524,9 +1524,7 @@ class BuildInfoHelper(object):
             return
 
         br_id, be_id = self.brbe.split(":")
-        be = BuildEnvironment.objects.get(pk = be_id)
-        be.lock = BuildEnvironment.LOCK_LOCK
-        be.save()
+
         br = BuildRequest.objects.get(pk = br_id)
 
         # if we're 'done' because we got cancelled update the build outcome
@@ -1543,6 +1541,10 @@ class BuildInfoHelper(object):
         else:
             br.state = BuildRequest.REQ_FAILED
         br.save()
+
+        be = BuildEnvironment.objects.get(pk = be_id)
+        be.lock = BuildEnvironment.LOCK_FREE
+        be.save()
         signal_runbuilds()
 
     def store_log_error(self, text):
-- 
2.7.4


