Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f171.google.com (mail-we0-f171.google.com
	[74.125.82.171])
	by mail.openembedded.org (Postfix) with ESMTP id 7AEF6617B8
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Jul 2014 12:44:27 +0000 (UTC)
Received: by mail-we0-f171.google.com with SMTP id q58so1643265wes.16
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Jul 2014 05:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=VGkhsPT9Q4vWuZCSWubGq4ZYqjCvOMAZ/YDGpz6iut4=;
	b=aiXM61ppa3+gpDl/PqR9rqMyoACFdwLqdKAWX75EgXpDcaooOKTpym3y9QptfTNHp2
	sVkvPZT6bQToqml+eb64kyJJmuH+VNMkHtrYcTKxrbkLpYkBoufe/g5TQeJ8GGBs/Ik2
	eb3X+hHiUpWc6Tfar59OFt5h4wm+GbBK9wSQUYZLkTb41UK20FX7BNTtg56P7/YF9Ju+
	9069r+vGjLRAeXfsgr4fSKjdb+GU98GGYhmJYmwTlgESSkZEw9Cg9dunPOl1he/nhXgR
	gdV7Wza2G1YlF8kZxwlWcgCNt6Jes3MbPuzq2jt1LYWttQ65L707Bea5pezSpksJVNnb
	4ASA==
X-Gm-Message-State: ALoCoQmBWRnEU8V0Tb8rKIaybhWoVElvnixOzYyzbUeK/oSVm3NJqAcmv1jMExxA2bzgsUQxCACP
X-Received: by 10.180.73.106 with SMTP id k10mr55610613wiv.11.1404477868653;
	Fri, 04 Jul 2014 05:44:28 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ja9sm78900636wic.8.2014.07.04.05.44.27
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Jul 2014 05:44:27 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 20CB7561184; Fri,  4 Jul 2014 13:44:27 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Jul 2014 13:44:20 +0100
Message-Id: <05b246095d161143ca2ebc126d9e70d198ab8bb8.1404477729.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404477729.git.alexandru.damian@intel.com>
References: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404477729.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1404477729.git.alexandru.damian@intel.com>
References: <cover.1404477729.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 3/9] toaster: automatically enable applications
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
X-List-Received-Date: Fri, 04 Jul 2014 12:44:30 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We automatically enable local applications in INSTALLED_APPS
based on detecting a models.py or views.py file.
This allows Toaster extensibility by adding applications,
without having to edit configuration files.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastermain/settings.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 2ce10c4..97f2ff7 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -243,6 +243,15 @@ INSTALLED_APPS = (
     'bldcontrol',
 )
 
+# We automatically detect and install applications here if
+# they have a 'models.py' or 'views.py' file
+import os
+currentdir = os.path.dirname(__file__)
+for t in os.walk(os.path.dirname(currentdir)):
+    modulename = os.path.basename(t[0])
+    if ("views.py" in t[2] or "models.py" in t[2]) and not modulename in INSTALLED_APPS:
+        INSTALLED_APPS.append(modulename)
+
 # A sample logging configuration. The only tangible logging
 # performed by this configuration is to send an email to
 # the site admins on every HTTP 500 error when DEBUG=False.
-- 
1.9.1


