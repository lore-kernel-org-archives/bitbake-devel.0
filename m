Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id 3F4587114C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 17:23:48 +0000 (UTC)
Received: by mail-wi0-f175.google.com with SMTP id ho1so6175670wib.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 10:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=HAjn2dcCKokCfDbYBqGUOeBc4DAR1uWz9W/0tbRxEyw=;
	b=kKjFQ3jIcYNED5vX+bfUB8xA5MEUiI62PQY+jLscuDSHC/r4D85OaZpPZ8kSW8KLRJ
	UNah+lDZy6NJT1l8iBlBnRw1zBjXql0bLxjxSRueHhNei4nYTNxRAAL3Kr2OIGdl/vdA
	GNoIGwJbCD7xTNf3D83WOmw/ydEnWVr9RZGHJYmhxEWNQvlOpUSlONMoTmgJfLc12hpO
	I6qQZHGeZPgSCrSJR09xJwgmD6hLT31kux+AXmNwWHNghQwnEsPyUPnh5Z2EWiXWPdpC
	wMhHncrNFxhH8r84ltYI7TMx+j/GF1DZlEj5SWRA+TA7ifrlONayL5qccqcpWudLEtrE
	lAmw==
X-Gm-Message-State: ALoCoQma7fkeE8H1WMAnsQOjieNeVzRoGV6ppxI9eCS8FDOoUUw8jED7wkm/D17JhZQSrFzm6/++
X-Received: by 10.180.73.139 with SMTP id l11mr30155335wiv.30.1409160227152;
	Wed, 27 Aug 2014 10:23:47 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id xa6sm2664917wjc.19.2014.08.27.10.23.45
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 27 Aug 2014 10:23:46 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 373C4560F7F; Wed, 27 Aug 2014 18:23:45 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 27 Aug 2014 18:23:34 +0100
Message-Id: <03faf268a5b0b39ad0b05d3b3faefc281b0fc9be.1409159626.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
References: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1409159626.git.alexandru.damian@intel.com>
References: <cover.1409159626.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 02/11] toaster: fix application discovery in settings.py
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
X-List-Received-Date: Wed, 27 Aug 2014 17:23:49 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We fix application discovery, tuples don't have .append().

Other minor fixes.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastermain/settings.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 09ec2bd..a8b3e3a 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -241,8 +241,6 @@ INSTALLED_APPS = (
     'django.contrib.humanize',
     'orm',
     'toastermain',
-    'toastergui',
-    'bldviewer',
     'south',
     'bldcontrol',
 )
@@ -261,7 +259,7 @@ currentdir = os.path.dirname(__file__)
 for t in os.walk(os.path.dirname(currentdir)):
     modulename = os.path.basename(t[0])
     if ("views.py" in t[2] or "models.py" in t[2]) and not modulename in INSTALLED_APPS:
-        INSTALLED_APPS.append(modulename)
+        INSTALLED_APPS = INSTALLED_APPS + (modulename,)
 
 # A sample logging configuration. The only tangible logging
 # performed by this configuration is to send an email to
-- 
1.9.1


