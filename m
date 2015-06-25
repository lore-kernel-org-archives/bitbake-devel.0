Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id D25B275A3E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:34:35 +0000 (UTC)
Received: by wibdq8 with SMTP id dq8so71515425wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=HTwnIlTOvSyUzliEaNoXHahHyulRmirJABjy/+I482o=;
	b=m3HrBKcX+Qhz+jIBX8rd0pafNvr93MNDXd34VH0BFGAV43JZ/9Fy22y2mqEg7lnEXB
	1Kk+qU914yhBcZBV/maI18G5v9Us0VvpeSShK7nWCtc1oML+1i+6cZ0CLmrhFRPYK+TT
	CTS4gfQqRyEq5Wn1oRSMyM9h6oN6O4R2lr/Vy8q/gBn7PDGfR4Ba0vD3w4ByUQvii6/1
	V3y+tDxSWae42wS8V3iVV3I6FiVeScLhCPiPYQw9JuxSJyc5L7MFOMiWVGBs0VFlIWYA
	oZHG2Y/CzHQk0YqkqfPXwGoWc7RH+mBU7dHvnC480m7899EYkW6/5NGb64yI9u6xRROP
	KG+g==
X-Gm-Message-State: ALoCoQkbJxDd5z7T2MgKfE7aWty1P1nEkaDND07eDNI9NpduI8/bixyNwg/vuQ4+ZSxfluoiSHQe
X-Received: by 10.180.87.38 with SMTP id u6mr4456647wiz.43.1435228476273;
	Thu, 25 Jun 2015 03:34:36 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id v3sm6910308wix.8.2015.06.25.03.34.34
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:34:35 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id D1D6C562557; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:48 +0100
Message-Id: <4b92add34167304b45c66b9726cbc64bc0f74d9f.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 11/23] toaster: bring django-aggregate-if into the project
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
X-List-Received-Date: Thu, 25 Jun 2015 10:34:36 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We bring the django-aggregate-if module (with minor changes to import)
into the project.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/contrib/django-aggregate-if-master/aggregate_if.py | 2 +-
 lib/toaster/toastermain/settings.py                            | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/contrib/django-aggregate-if-master/aggregate_if.py b/lib/toaster/contrib/django-aggregate-if-master/aggregate_if.py
index 4ea9e8c..d5f3427 100644
--- a/lib/toaster/contrib/django-aggregate-if-master/aggregate_if.py
+++ b/lib/toaster/contrib/django-aggregate-if-master/aggregate_if.py
@@ -10,7 +10,7 @@ This code was based on the work of others found on the internet:
 4. https://groups.google.com/forum/?fromgroups=#!topic/django-users/vVprMpsAnPo
 '''
 from __future__ import unicode_literals
-import six
+from django.utils import six
 import django
 from django.db.models.aggregates import Aggregate as DjangoAggregate
 from django.db.models.sql.aggregates import Aggregate as DjangoSqlAggregate
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 141ad08..60e80de 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -393,3 +393,12 @@ class InvalidString(str):
             "Undefined variable or unknown value for: \"%s\"" % other)
 
 TEMPLATE_STRING_IF_INVALID = InvalidString("%s")
+
+import sys
+sys.path.append(
+    os.path.join(
+    os.path.join(
+        os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
+            "contrib"),
+            "django-aggregate-if-master")
+    )
-- 
1.9.1


