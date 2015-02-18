Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
	[74.125.82.176])
	by mail.openembedded.org (Postfix) with ESMTP id 623C571F05
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 19:11:05 +0000 (UTC)
Received: by wevk48 with SMTP id k48so3090006wev.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 11:11:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=J6VoGG7+2HjOqILGoGUostkf8GkfVs2nush9szbj+zA=;
	b=IqyhswHVNVL2ox9qt/T5/rPtfbFkpnLM1rngMwFnpGl/dsN62Xi9wIB7uKV2+QMCXO
	8glSEtTjF34SqlfoJ2KX6NBqJHppKNGOZ2KDzMebegTcUYnC/LsnCDdE9JZ5ks8XqqWP
	qf5JP3tViVMIDWduChRyCClUAejTia1gIsGSJgjpLownA4gtYZ4/554tqxbRrxf4XxHX
	G4+pLxEZeWcJghvbO/NB4r9P0J1bS2hmv45s8erx5mPNRw9UfkX+4FDPoO5wYW9Spx2b
	Fh4oeJLCIncvFUFwgwpzwFrXvr5KscKbkespLQEwqka8q8HiIyVHzC5evPJo+olvsJT6
	026w==
X-Gm-Message-State: ALoCoQkNfDGdwLzFulhxMcuz2wC9n2VLkZ/pa28YksjN4vh+ay6549J5uIth5C927ig87CQ5rLJ7
X-Received: by 10.194.242.6 with SMTP id wm6mr1467382wjc.7.1424286666539;
	Wed, 18 Feb 2015 11:11:06 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	cj12sm33933120wjb.35.2015.02.18.11.11.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Feb 2015 11:11:05 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 48274561F50; Wed, 18 Feb 2015 19:11:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Feb 2015 19:10:59 +0000
Message-Id: <5cc87ee0ac3b2bd399e7f009dda9d6de87209a27.1424286571.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
References: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424286571.git.alexandru.damian@intel.com>
References: <cover.1424286571.git.alexandru.damian@intel.com>
Subject: [PATCH 05/10] toaster: get proper version string
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
X-List-Received-Date: Wed, 18 Feb 2015 19:11:05 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch brings in the toaster tree commit ID in
the version string to allow users properly report their
toaster version when submitting issues.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastermain/settings.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index b6a42c0..a7304fa 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -232,7 +232,8 @@ from os.path import dirname as DN
 SITE_ROOT=DN(DN(os.path.abspath(__file__)))
 
 import subprocess
-TOASTER_VERSION = subprocess.Popen('cd %s; git branch | grep "^* " | tr -d "* "' % SITE_ROOT, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
+TOASTER_VERSION = subprocess.Popen('git branch | grep "^* " | tr -d "* "', cwd = SITE_ROOT, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
+TOASTER_VERSION += " " + subprocess.Popen('git rev-parse HEAD ', cwd = SITE_ROOT, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
 
 ROOT_URLCONF = 'toastermain.urls'
 
-- 
1.9.1


