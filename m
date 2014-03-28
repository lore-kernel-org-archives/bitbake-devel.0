Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f172.google.com (mail-we0-f172.google.com
	[74.125.82.172])
	by mail.openembedded.org (Postfix) with ESMTP id 167036E221
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 14:46:35 +0000 (UTC)
Received: by mail-we0-f172.google.com with SMTP id t61so2783552wes.17
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 07:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=J1r5dZ8BPMqZgTDqxE76Oo7+rbfYiOvMPpVmuGdFwOI=;
	b=ZPb4LFib3ySq2lkPDwZldB/LcVgxqL+ck/fUDDcX7TvYu+7yiqSZzZn9QDlH3AFOri
	mdfG7W7f1KXwHT+NXY9HL1o3Cx7v6rLG7Mg6xzRds0S86DRqtOEs0FNjIgZOV/x5PV2B
	O/qQb0yAen8pBANaehOrzzGRE/HpVYX56WaJVVmLT2hgB5jnDQcPbZI/sie2dfkdngUL
	cLYWwcKoaf5pxyk+pbzqbr7GlJL6ClEn7kP4VhBu1IPOM3wO6UNY06/5Xpco9dSEPqEH
	Ncbswt17MvXy/3D2ILGq0qN8uIgoyzNcLWp3dmxGNtq2mJ+psEf/pe1efeVBfKoQmho0
	CDkQ==
X-Gm-Message-State: ALoCoQmChjwusZWo00ts+05KlHZHXbNDbPDonm0OGeKJFcZNF74XWbia2jGI4M7ElbjzuP8Tu1YL
X-Received: by 10.180.184.167 with SMTP id ev7mr21732727wic.55.1396017995837; 
	Fri, 28 Mar 2014 07:46:35 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id fb6sm7903063wib.2.2014.03.28.07.46.34
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 28 Mar 2014 07:46:34 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 4ADB3560535; Fri, 28 Mar 2014 14:46:34 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Fri, 28 Mar 2014 14:46:33 +0000
Message-Id: <1396017993-11558-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1395925753-31968-1-git-send-email-alexandru.damian@intel.com>
References: <1395925753-31968-1-git-send-email-alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH] bitbake: toaster: fix timezone detection
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
X-List-Received-Date: Fri, 28 Mar 2014 14:46:38 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch replaces faulty timezone detection with a version
that simply reads the TZ environment variable if it is set.

If the TZ is not set, we do a reverse match search among known
timezone definitions and take the first match.

    [YOCTO #5499]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/toaster/toastermain/settings.py | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/toaster/toastermain/settings.py b/bitbake/lib/toaster/toastermain/settings.py
index 51fa3cc..e26ee3c 100644
--- a/bitbake/lib/toaster/toastermain/settings.py
+++ b/bitbake/lib/toaster/toastermain/settings.py
@@ -50,9 +50,23 @@ ALLOWED_HOSTS = []
 # although not all choices may be available on all operating systems.
 # In a Windows environment this must be set to your system time zone.
 
-# Always use local computer's time zone
-import time
-TIME_ZONE = time.tzname[0]
+# Always use local computer's time zone, find
+import os, hashlib
+if 'TZ' in os.environ:
+    TIME_ZONE = os.environ['TZ']
+else:
+    # need to read the /etc/localtime file which is the libc standard
+    # and do a reverse-mapping to /usr/share/zoneinfo/;
+    # since the timezone may match any number of identical timezone definitions,
+
+    zonefilelist = {}
+    ZONEINFOPATH = '/usr/share/zoneinfo/'
+    for dirpath, dirnames, filenames in os.walk(ZONEINFOPATH):
+        for fn in filenames:
+            filepath = os.path.join(dirpath, fn)
+            zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] = filepath.lstrip(ZONEINFOPATH).strip()
+
+    TIME_ZONE = zonefilelist[hashlib.md5(open('/etc/localtime').read()).hexdigest()]
 
 # Language code for this installation. All choices can be found here:
 # http://www.i18nguy.com/unicode/language-identifiers.html
-- 
1.9.1


