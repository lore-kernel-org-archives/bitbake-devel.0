Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id 2B92C6F763
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 13:41:51 +0000 (UTC)
Received: by mail-wi0-f180.google.com with SMTP id hm4so2383401wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 06:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=N9fSd7BSVnQO5hDaa7iSp1LmYLTU02RXxiw9TTx31Bc=;
	b=Hl7hPjVHKy0sZe0yO8tLYnWZRDrWDKxWEuZYYk7D7U1tK+j5luBxjvIbO/nb51enY2
	iM5woJttOvJ3zO7TItdJ/PEZXXqiUgHWIzecuqUSHfGHHwhR2YrcJza02MM138JIvQTE
	D3Wt5NdRW5pp7b7NlZ74ZK9adQ4NHUqAPMuf7w77txZRIiuBy718C6lX0qvSvI/FMgV1
	BJq03/hYzygZpvVmNeJqJAqC3OF/hI7sK8UGXNVTuxtGdJHgjVvWdcA3k2u67Rrv/NWn
	+1QwdDOPXxjo7VjWCplB67VZE3RdzjQuY28tEU6p9zdj2FbA3WJdv7+hrBIOSkOuo5MU
	WkxQ==
X-Gm-Message-State: ALoCoQktPmjTsqcbF01SMZsFDyQQgBC3HwNkOHgWhGEizupgr37qJBl/c0QF2fTUWtZsdJVroTdJ
X-Received: by 10.180.12.43 with SMTP id v11mr7688711wib.33.1394631712584;
	Wed, 12 Mar 2014 06:41:52 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id fb6sm16137340wib.2.2014.03.12.06.41.51
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Wed, 12 Mar 2014 06:41:51 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id A431556059E; Wed, 12 Mar 2014 13:41:52 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 12 Mar 2014 13:41:51 +0000
Message-Id: <1394631711-1083-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/1] toaster: fix timezone detection
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
X-List-Received-Date: Wed, 12 Mar 2014 13:41:55 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch replaces faulty timezone detection with a version
that simply reads the TZ environment variable if it is set.

This has been tested with the list of TZ values from
http://en.wikipedia.org/wiki/List_of_tz_database_time_zones

	[YOCTO #5499]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/toaster/toastermain/settings.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 51fa3cc..8be1851 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -51,8 +51,10 @@ ALLOWED_HOSTS = []
 # In a Windows environment this must be set to your system time zone.
 
 # Always use local computer's time zone
-import time
-TIME_ZONE = time.tzname[0]
+TIME_ZONE = "posix/GMT-0"               # have a sane default
+import os
+if 'TZ' in os.environ:
+    TIME_ZONE = os.environ['TZ']
 
 # Language code for this installation. All choices can be found here:
 # http://www.i18nguy.com/unicode/language-identifiers.html
-- 
1.8.3.2


