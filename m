Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by mx.groups.io with SMTP id smtpd.web12.1906.1590622042755163313
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 May 2020 16:27:22 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: linux.intel.com, ip: 192.55.52.88, mailfrom: timothy.t.orling@linux.intel.com)
IronPort-SDR: jC8+tlT9Vz7HU+mh+zJ5iuLDsi4+Ob22LB/+4WB6a+u5MVvX8SDyvJ8kpEIpLFXQBSfTRmiBsg
 p5XdDhKkQi6Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 16:27:21 -0700
IronPort-SDR: 180yilo/4baCynhwetxvAJLgFw2ROMl9PUD5LrftM+ibXn6Uwh9ZYS6yQNbXeDfTpxUvoi+Kec
 FpcpP9WSv9ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="scan'208";a="270639231"
Received: from wrath.jf.intel.com ([10.54.31.24])
  by orsmga006.jf.intel.com with ESMTP; 27 May 2020 16:27:21 -0700
From: "Tim Orling" <timothy.t.orling@linux.intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: david.reyna@windriver.com,
	Tim Orling <timothy.t.orling@linux.intel.com>
Subject: [master][PATCH] toaster-requirements.txt: require Django 2.2
Date: Wed, 27 May 2020 16:27:12 -0700
Message-Id: <20200527232712.27473-1-timothy.t.orling@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 9730f95686b2ac72cf1fa513c555f7c7787e2667
Django 2.2 was enabled.

Django 1.11 was EOL on April 1, 2020

Signed-off-by: Tim Orling <timothy.t.orling@linux.intel.com>
---
 toaster-requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index a682b085..735b6145 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -1,3 +1,3 @@
-Django>1.8,<1.12
+Django>2.2,<2.3
 beautifulsoup4>=4.4.0
 pytz
-- 
2.24.0

