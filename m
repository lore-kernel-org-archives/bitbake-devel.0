Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
	[209.85.220.50])
	by mail.openembedded.org (Postfix) with ESMTP id E063C65C78
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 16:27:32 +0000 (UTC)
Received: by mail-pa0-f50.google.com with SMTP id bj1so2843128pad.37
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 08:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=sCdCgzAUbjYfTSpycv6oERftLoNsqpeOL3XUBFCjSzg=;
	b=ZF4rCLvQ+AHoJ7u6z3WuTe3gFbF3yOfDQn8UpkuMwV+Q6m5BUstNVFEPmla7KwnQEw
	lTeR1wBGOZ+02I1OO+jqJaWTfjCFATjk0jit2fXVoHMCMKK/9zVmZhwKT1370NB8QR55
	2TEtpj1jwqxOmVKRAhnX4a//WsE1G1Dw7sMxs+flfpd901tk+UkpWciJWS/7UNNt/g4i
	4UKe2m1rUTj6hmiPdf2tDxbv/Oo81h97Gnx7wZy8qJDTBpuQCek9196J2xPY7g2wjHrJ
	GnxtX2n/VLszchRzLdKTgX2lxkATIzfVhxmcx4xx8REFwkmBoOeh3B93RfhERYMSwyL7
	bNnA==
X-Gm-Message-State: ALoCoQl9rKcwZW4EcYwem8TzJqky4Wk3PDUzBdi7/aOwh2kHRdUnxWYet+CP+YaTX/KPnCuCWWwc
X-Received: by 10.68.215.67 with SMTP id og3mr56578431pbc.117.1416500852730;
	Thu, 20 Nov 2014 08:27:32 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id k4sm2454010pbq.74.2014.11.20.08.27.31
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 20 Nov 2014 08:27:31 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 771A8563F4C; Thu, 20 Nov 2014 16:27:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Nov 2014 16:27:17 +0000
Message-Id: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1416500715.git.alexandru.damian@intel.com>
References: <cover.1416500715.git.alexandru.damian@intel.com>
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 01/11] toaster: fix file name collision
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
X-List-Received-Date: Thu, 20 Nov 2014 16:27:33 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

When toaster is used by multiple users on the same machine,
it is possible that files in /tmp have a name race.

This patch makes sure that the files have unique names.

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
---
 bin/toaster | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index 4c6ac5a..75f31d0 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -69,7 +69,7 @@ function webserverStartAll()
 	fi
         if [ $retval -eq 0 ]; then
 	    echo "Starting webserver"
-            python $BBBASEDIR/lib/toaster/manage.py runserver "0.0.0.0:$WEB_PORT" </dev/null >${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
+            python $BBBASEDIR/lib/toaster/manage.py runserver "0.0.0.0:$WEB_PORT" </dev/null >${BUILDDIR}/toaster_web_$$.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
             sleep 1
             if ! cat "${BUILDDIR}/.toastermain.pid" | xargs -I{} kill -0 {} ; then
                 retval=1
-- 
1.9.1


