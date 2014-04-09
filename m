Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 9FE9C65D9D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Apr 2014 17:00:55 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id n12so2818675wgh.24
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Apr 2014 10:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=6DLW+b2y4D7kYsaD1CZbWudIJ4pLsNHKTqs46jgR2cE=;
	b=muxdtDLnrUbiVmbuyohkSS2O7k8U45bL9LhcF02rNZ+FjA+Nyg7/kp0YvLdcD+rQEa
	VW4v9yPuRFZaE+Ca0PzbMKcU9M3EpWaK7gJrofdZExXU2s0kMPn+3E7Jscs+GBh8lt/0
	IetclFFRu2H7BvX+A3a0dmHIxYJ9u99RNT9F4acy+zrEVOY2dRqDQ716CeeHC8kER2yi
	s1gDX84Rs0j6pDXCduv0NnrmLQiJXVg4+0wnxaDa5zdEXS8/niaiwEXc4iPfFVH4+pcH
	GsG45fq95ukBv/uplZdp2gV1PzJnTe+j44dr6GJSIX5MG2LeUB6ITmko1Zy0YJQFPoWJ
	aKQA==
X-Gm-Message-State: ALoCoQnlVLShCBSmdG/m5V5XkEToNKE7fDGLQzlWNBF2Of6/Cp7PkNGva6pxmvxdgO55qki44DMy
X-Received: by 10.194.81.98 with SMTP id z2mr10910181wjx.12.1397062856494;
	Wed, 09 Apr 2014 10:00:56 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	l10sm11190374wiz.18.2014.04.09.10.00.54 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Apr 2014 10:00:55 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id B11BF560236; Wed,  9 Apr 2014 18:00:54 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 10 Apr 2014 01:00:53 +0800
Message-Id: <1397062853-13768-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/1] bitbake: toaster: Allow toaster to start without pytz
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
X-List-Received-Date: Wed, 09 Apr 2014 17:00:57 -0000

From: Belen Barros <belen.barros.pena@intel.com>

This patch allows toaster to start without pytz.

Django can work with or without pytz, but in the
time zone fix I mistakenly added a hard dependency
on this module.

This patch eliminates the hard dependency.

Signed-off-by: Belen Barros <belen.barros.pena@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/toaster/toastermain/settings.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/toaster/toastermain/settings.py b/bitbake/lib/toaster/toastermain/settings.py
index 6e9d85d..40a2b1a 100644
--- a/bitbake/lib/toaster/toastermain/settings.py
+++ b/bitbake/lib/toaster/toastermain/settings.py
@@ -64,15 +64,20 @@ else:
     for dirpath, dirnames, filenames in os.walk(ZONEINFOPATH):
         for fn in filenames:
             filepath = os.path.join(dirpath, fn)
+            zonename = filepath.lstrip(ZONEINFOPATH).strip()
             try:
                 import pytz
                 from pytz.exceptions import UnknownTimeZoneError
-                zonename = filepath.lstrip(ZONEINFOPATH).strip()
-                if pytz.timezone(zonename) is not None:
-                    zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] = zonename
-            except UnknownTimeZoneError, ValueError:
-                # we expect timezone failures here, just move over
                 pass
+                try:
+                    if pytz.timezone(zonename) is not None:
+                        zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] = zonename
+                except UnknownTimeZoneError, ValueError:
+                # we expect timezone failures here, just move over
+                    pass
+            except ImportError:
+            	zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] = zonename
+		
 
     TIME_ZONE = zonefilelist[hashlib.md5(open('/etc/localtime').read()).hexdigest()]
 
-- 
1.9.1


