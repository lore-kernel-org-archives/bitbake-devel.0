Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
	[209.85.192.180])
	by mail.openembedded.org (Postfix) with ESMTP id 5831E73746
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 17:21:08 +0000 (UTC)
Received: by pdev10 with SMTP id v10so34681207pde.10
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 09:21:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=OzVIdA6xnUMr8ooV3buix1H6tdYbxrCZhbjVmFRL12M=;
	b=WYcB8AQ1HI4b+hdS2m13LXmpAfOi4SnBHh99icnsUZVcc7jTuqEJgF10FBI3BBt6z3
	22oliZdGm463VHB3rJVc4+Viul6MeAQQ6w5L85CkRT68iU7C1PjrgWhDevRH++wCOZRx
	RDMexefUyEWnWCOirLiPw72YsMAiIbRU3bNBp0y9gpPdpv8NhkryhF8HHoipmnZpqFJL
	Ax1JpfYCSK6g6YbviWxT7UV+hY+EabAHzRRmURZk7mx/QlitjYFzwrnnZmxJpRfi0LVx
	OtQ3aiPGlT7cbGAf5rA6lnQ4B2ITN2FwhDUMueDgWkU6Dyr5L5Ib6ehGl9Q5Acv0Kgni
	cF3Q==
X-Gm-Message-State: ALoCoQkF3xkhMkErmgw65w+GTA9RjpKefxyquVafLXWLtzudLyJyH+lMTpHEJJd7nYZQkrqugmBk
X-Received: by 10.66.164.200 with SMTP id ys8mr30521355pab.130.1424798469964; 
	Tue, 24 Feb 2015 09:21:09 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ku12sm39897839pab.39.2015.02.24.09.21.07
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 24 Feb 2015 09:21:08 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 9A4A8561980; Tue, 24 Feb 2015 17:21:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Feb 2015 17:20:56 +0000
Message-Id: <c35ff31bd681dca6a84bf3c10cf3ad6356ec7181.1424798369.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
References: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424798369.git.alexandru.damian@intel.com>
References: <cover.1424798369.git.alexandru.damian@intel.com>
Subject: [PATCH 08/12] toaster: update requirement for Django 1.6
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
X-List-Received-Date: Tue, 24 Feb 2015 17:21:08 -0000

From: Alexandru Damian <alexandru.damian@intel.com>

In order to bring in transaction.set_commit support,
we need Django 1.6, discarding support for Django 1.5

This patch removes 1.5 from the list of acceptable Django
versions.

Signed-off-by: Alexandru Damian <alexandru.damian@intel.com>
---
 bin/toaster | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 04f2e99..7907b57 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -129,8 +129,8 @@ function notify_chldexit() {
 function verify_prereq() {
 	# Verify prerequisites
 
-    if ! echo "import django; print (1,) == django.VERSION[0:1] and django.VERSION[1:2][0] in (5,6)" | python 2>/dev/null | grep True >/dev/null; then
-        echo -e "This program needs Django 1.5 or 1.6. Please install with\n\npip install django==1.6\n"
+    if ! echo "import django; print (1,) == django.VERSION[0:1] and django.VERSION[1:2][0] in (6,)" | python 2>/dev/null | grep True >/dev/null; then
+        echo -e "This program needs Django 1.6. Please install with\n\npip install django==1.6\n"
         return 2
     fi
 
-- 
1.9.1


