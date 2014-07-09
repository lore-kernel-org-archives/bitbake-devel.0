Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id 465DE70473
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jul 2014 16:55:28 +0000 (UTC)
Received: by mail-wi0-f171.google.com with SMTP id f8so2641804wiw.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Jul 2014 09:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=VGkhsPT9Q4vWuZCSWubGq4ZYqjCvOMAZ/YDGpz6iut4=;
	b=FxsD9Kki2MU098++wBzCOAx0sy9j2/MGVdxenrcf+FZ15WZT0m/sNCKHyBHJr/TsWr
	BzJxsIMUhiYhhglxtuG1d1vOYEv36YCfzg6upaEA66APdQ3hXI7jcbNKyXjAhZLWmJk2
	Im/CGjLiT4HReUMYwHR50uitek/IuwawJOeNvfa9ei8XkhlqRbPV+GyRTqal3TTDTKDU
	F1BtNrxq0mFc8J3zIqT+fK16OLQpaQ0cm5f12wgvXRBcZh9DtGFnHR8EJ9VDxz1tyNEg
	fXpB28bwApU+RPEMp05dWyBS2xjZe/ItS9+JEY3SXd/DXakFcbZiy7amyquCH5E/Gqma
	i48Q==
X-Gm-Message-State: ALoCoQmmkKhwPFJaKiM3xFRGuisGOWrqmlAefgaTzPt9AqCO2Ur2mwPhsnx20Y0rZObW3YSC1ATp
X-Received: by 10.194.71.52 with SMTP id r20mr13013460wju.113.1404924929538;
	Wed, 09 Jul 2014 09:55:29 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fb15sm21294703wid.23.2014.07.09.09.55.27 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Jul 2014 09:55:27 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 9172B560946; Wed,  9 Jul 2014 17:55:26 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Jul 2014 17:55:19 +0100
Message-Id: <05b246095d161143ca2ebc126d9e70d198ab8bb8.1404924714.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404924714.git.alexandru.damian@intel.com>
References: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404924714.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1404924713.git.alexandru.damian@intel.com>
References: <cover.1404924713.git.alexandru.damian@intel.com>
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
X-List-Received-Date: Wed, 09 Jul 2014 16:55:29 -0000

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


