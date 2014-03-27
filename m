Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f180.google.com (mail-we0-f180.google.com
	[74.125.82.180])
	by mail.openembedded.org (Postfix) with ESMTP id 085896B4F7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 13:09:16 +0000 (UTC)
Received: by mail-we0-f180.google.com with SMTP id p61so1780738wes.11
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 06:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Up2oA9DcuMGRUtlVE32at8bEm56Ll3zIT9AMlPPsTnA=;
	b=hPxI9B6rupJFoNqBERJ//m4WjcgoFgGP28Qj6o+cJ1IqaUMjxKgSgcqJ9fplVdNjuE
	r1Y9K908us3S0XATIJUGgwgoMAX3cUGtxftkOQ+OCqjiqkAXGVklDb+KklEABdSs3mCz
	7ppPQ/yhvlaZKo0uR29psDcjwg6t6QG9h59rKpePbpxK8mNzF2YGT11T1+PrGUm6Vao6
	CLdVpiURJd655kINVnYFTSeTp2ThoCbn/2sGSCD8e9LvseoVqHd3/qnSZBa2LR/NoxH6
	IKWWldvQCVqH8jJ7LKL9ujx4FaQ2LhdsCJjBnRlHWFYmof3IR5Ag46gI6FvgGo06tyxU
	a3WQ==
X-Gm-Message-State: ALoCoQmS+XLaQhliX3Zmugqw2ED/ErDH51GhNbJsDBBzOObIxifV1IwTHFzeCHAmHUh5TFB030gP
X-Received: by 10.180.19.69 with SMTP id c5mr4929732wie.7.1395925756814;
	Thu, 27 Mar 2014 06:09:16 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id t18sm7091327wiv.16.2014.03.27.06.09.15
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 27 Mar 2014 06:09:16 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 690CF563150; Thu, 27 Mar 2014 13:09:14 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Thu, 27 Mar 2014 13:09:13 +0000
Message-Id: <1395925753-31968-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/1] bitbake: toaster: fix timezone detection
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
X-List-Received-Date: Thu, 27 Mar 2014 13:09:20 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch replaces faulty timezone detection with a version
that simply reads the TZ environment variable if it is set.

If the TZ is not set, we do a reverse match search among known
timezone definitions and take the first match.

	[YOCTO #5499]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/toaster/toastermain/settings.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/toaster/toastermain/settings.py b/bitbake/lib/toaster/toastermain/settings.py
index 51fa3cc..98d2ac3 100644
--- a/bitbake/lib/toaster/toastermain/settings.py
+++ b/bitbake/lib/toaster/toastermain/settings.py
@@ -51,8 +51,16 @@ ALLOWED_HOSTS = []
 # In a Windows environment this must be set to your system time zone.
 
 # Always use local computer's time zone
-import time
-TIME_ZONE = time.tzname[0]
+import os, subprocess
+
+# the TZ variable overrides any default timezone setting
+if 'TZ' in os.environ:
+    TIME_ZONE = os.environ['TZ']
+else:
+    # need to read the /etc/localtime file which is the libc standard
+    # and do a reverse-mapping to /usr/share/zoneinfo/; since the timezone may match any number of identical timezone definitions,
+    # we just select the first that matches
+    TIME_ZONE = subprocess.Popen("find /usr/share/zoneinfo/  -type f -exec diff -s {} /etc/localtime \; | grep identical | head -1 | awk '{print $2;}' | sed 's/\/usr\/share\/zoneinfo\///'", shell=True, stdout = subprocess.PIPE).communicate()[0].strip()
 
 # Language code for this installation. All choices can be found here:
 # http://www.i18nguy.com/unicode/language-identifiers.html
-- 
1.8.3.2


