Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id F36A860EFA
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Apr 2014 13:17:42 +0000 (UTC)
Received: by mail-wi0-f173.google.com with SMTP id z2so8864980wiv.12
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Apr 2014 06:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=rP+RutB9pX1D94zVoJiB8kBy3wYiSj6AeWmYOJ5h+mo=;
	b=JSeDWvGShEMLHSu89jas1rL+T9U5txFpmdRSB9pYn5voJcpe9qqWpjiekmoaoXSJ6x
	35xjIEIph4tbQiWQJml9gOapwDhwHZ5m21PA/2OSYBLq0wy/9yO24mxnZm2dpgiZhz8+
	ZrHMOnz1PvrZhfiV8hvHX2kwv8DpyukB4V7oJ/Lmr36Otz3iIlYj539gSB18DEqbTyiL
	xqgGAcpKWPjoGRUb+EXIPSImJW3as0RibithnQMcvGrX5YySnEG8pWzKLYbo31qE+T59
	oLgu7Hmq6Ae9jgIVVqUncJo4CBSrSZGoHwxSOTsxsGlCijg1kNgTR5nmM1K5YfKHgJYZ
	2uzQ==
X-Gm-Message-State: ALoCoQnheFNgLUYUlFMPWLXBhucNuhr88ZeUXyD/ZgUqeml5S0cHiaEOopDSo2NcGr17aimDmxvl
X-Received: by 10.194.77.50 with SMTP id p18mr2463727wjw.68.1397049463290;
	Wed, 09 Apr 2014 06:17:43 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	l10sm10053057wiz.18.2014.04.09.06.17.41 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Apr 2014 06:17:42 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 716C4560213; Wed,  9 Apr 2014 14:17:41 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Apr 2014 14:17:32 +0100
Message-Id: <c93e5ca809d9c335b0cf35dcad4705487414c71b.1397049329.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1397049329.git.alexandru.damian@intel.com>
References: <cover.1397049329.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/9] toaster: do not load all available timezones
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
X-List-Received-Date: Wed, 09 Apr 2014 13:17:45 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch makes sure that we only load pytz-recognized
timezones. Pytz is used to transform the timezone information
for the database queries, and needs to be able to deal with
the TIME_ZONE value that we set up.

[YOCTO #6093]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastermain/settings.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index e26ee3c..6e9d85d 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -64,7 +64,15 @@ else:
     for dirpath, dirnames, filenames in os.walk(ZONEINFOPATH):
         for fn in filenames:
             filepath = os.path.join(dirpath, fn)
-            zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] = filepath.lstrip(ZONEINFOPATH).strip()
+            try:
+                import pytz
+                from pytz.exceptions import UnknownTimeZoneError
+                zonename = filepath.lstrip(ZONEINFOPATH).strip()
+                if pytz.timezone(zonename) is not None:
+                    zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] = zonename
+            except UnknownTimeZoneError, ValueError:
+                # we expect timezone failures here, just move over
+                pass
 
     TIME_ZONE = zonefilelist[hashlib.md5(open('/etc/localtime').read()).hexdigest()]
 
-- 
1.9.1


