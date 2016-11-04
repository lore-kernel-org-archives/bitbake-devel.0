Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id D1D7C71A73
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Nov 2016 12:27:15 +0000 (UTC)
Received: by mail-wm0-f46.google.com with SMTP id a197so47684547wmd.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Nov 2016 05:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=McavX4Oz1ST5Vq6JrfZrX5mLXjtmvsbMS5VctwrgmyM=;
	b=pTtRXjZ85O/c40DNF9+KRwglMdo3el9CgFyMI43+7+xiyMcCxYhLa2xZP6pmF33ots
	fWb3sF7xph+5CAiCIKmPDltyVigXQ8z43yL4XiZxn40Ii0zy1TmOtIAejbmC37RI8Nx5
	XyBeX4eH5s4ZW+/k+o1Z2nvbyRuyub0lUgR8y1MNBF1vDvF+GmgCdyIjbvBZBn2zaMqU
	J75WuhOL3rwHWJK0O+CW/XuvrL2nBVSBK827rPcX1srnwcMPRKCqFiW6Bc74opVs/F28
	pWfu/KzsOOFc6vh+TruHktHPSii3dVUxtYoYkGHwjS+hI396bEuoM/Sm+Ho/KCIEAOWU
	A6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=McavX4Oz1ST5Vq6JrfZrX5mLXjtmvsbMS5VctwrgmyM=;
	b=AAH0snszat5UkNi2cZiD5kXOhDaITGrgNSfhy/EZBXXEAG6WQFa98PJjN2wwwNtfjh
	fFYPjnV3DQoNkh3N3SBy89LoGQLXadCTNMSZBJFc5laGKHqjuv/kxqLG29gnKMi4U79R
	+k6as1gsX+gfqrj44Cpg1yFC2cE0KSMb+TrC+iIfgpAe26KbOjemF1+/Lm+nbPtELPgm
	boLUavUlCE2dH1osSP+N1/eBA5gHuzdP/0ODfnqnAOUHY885rfVPbtkyWJ+1duYiIK0o
	kaUXp9LX2b1m2H2Vb+WCM8bBsmVW6WsFVVDk6zz9zOXdGPCjZkeelt3ZOeLXyztfSnlb
	EmIg==
X-Gm-Message-State: ABUngvfqdRhieZArORd6Mm354KYKhXfDvBNCxPcOqHDCCO2zSW9LJMf++eaPaB6QPcdADh0k
X-Received: by 10.28.210.195 with SMTP id j186mr3011155wmg.73.1478262436083;
	Fri, 04 Nov 2016 05:27:16 -0700 (PDT)
Received: from orion.home (host31-48-249-102.range31-48.btcentralplus.com.
	[31.48.249.102]) by smtp.gmail.com with ESMTPSA id
	p13sm4319174wmd.20.2016.11.04.05.27.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 04 Nov 2016 05:27:15 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Nov 2016 12:27:06 +0000
Message-Id: <1478262426-5350-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH][master/morty/1.32] toaster: settings set ALLOWED_HOSTS to * in debug mode
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
X-List-Received-Date: Fri, 04 Nov 2016 12:27:16 -0000

From: brian avery <brian.avery@intel.com>

As of Django 1.8.16, Django is rejecting any HTTP_HOST header that is
not on the ALLOWED_HOST list.  We often need to reference the
toaster server via a fqdn, if we start it via webport=0.0.0.0:8000 for
instance, and are hitting the server from a laptop. This change does
reduce  the protection from a DNS rebinding attack, however, if you are
running the toaster server outside a protected network, you should be
using the production instance.

[YOCTO #10578]

Signed-off-by: brian avery <brian.avery@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastermain/settings.py | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 3dfa2b2..aec9dbb 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -60,9 +60,19 @@ DATABASES = {
 if 'sqlite' in DATABASES['default']['ENGINE']:
     DATABASES['default']['OPTIONS'] = { 'timeout': 20 }
 
-# Hosts/domain names that are valid for this site; required if DEBUG is False
-# See https://docs.djangoproject.com/en/1.5/ref/settings/#allowed-hosts
-ALLOWED_HOSTS = []
+# Update as of django 1.8.16 release, the '*' is needed to allow us to connect while running
+# on hosts without explicitly setting the fqdn for the toaster server.
+# See https://docs.djangoproject.com/en/dev/ref/settings/ for info on ALLOWED_HOSTS
+# Previously this setting was not enforced if DEBUG was set but it is now.
+# The previous behavior was such that ALLOWED_HOSTS defaulted to ['localhost','127.0.0.1','::1']
+# and if you bound to 0.0.0.0:<port #> then accessing toaster as localhost or fqdn would both work.
+# To have that same behavior, with a fqdn explicitly enabled you would set
+# ALLOWED_HOSTS= ['localhost','127.0.0.1','::1','myserver.mycompany.com'] for
+# Django >= 1.8.16. By default, we are not enforcing this restriction in
+# DEBUG mode.
+if DEBUG is True:
+    # this will allow connection via localhost,hostname, or fqdn
+    ALLOWED_HOSTS = ['*']
 
 # Local time zone for this installation. Choices can be found here:
 # http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
-- 
2.7.4


