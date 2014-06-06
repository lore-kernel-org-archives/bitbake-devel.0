Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id CD56A65E87
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Jun 2014 14:03:31 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id z12so2825313wgg.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Jun 2014 07:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=s8jQnjsfwQgV/o1rrteABvQDz43GFLe9rUJj7NWL+9g=;
	b=WNcVPhV1assJuqCBm2zww/3MA9CEzEaYtPsU14nZOry0H61TEDaaqIyX2oNmKfTx7n
	72UHvQgAo3Uvu+tDSf/y1NF3M2rCv6D7I6SNchHJ0FGkXZCpmgt681V1sBz1MSFQp34i
	JdyX8g5K2hUNGZmOBon4HM5Ktx4IvrrcdRTL0esZ3XYTa26oYOpe5B8JVWHSChy1CrmS
	A6FuOC5Hq9Q0+ZEB0xfh3mDaTI37X6X1lA4OQ8bvAqcY6rGAT9PSK5XbJKMiuso9ypF/
	UXd6ydQBmOIGJDiZ++a1y1fKZ17A1UgpoXevpEfO39b7p1q+93Zhu/7jO5XpzeSWNtlP
	KOzQ==
X-Gm-Message-State: ALoCoQk0lCDqDhW3Rv3nEpQhRdValpZMZgnuW8xKFhNBLKTy1Vf+hj3Qi1Xs8n9qc4SRW2LZQ+uO
X-Received: by 10.194.82.9 with SMTP id e9mr7067540wjy.45.1402063411678;
	Fri, 06 Jun 2014 07:03:31 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id l2sm21558465wix.13.2014.06.06.07.03.30
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 06 Jun 2014 07:03:30 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 00254561E08; Fri,  6 Jun 2014 15:03:33 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jun 2014 15:03:32 +0100
Message-Id: <1402063412-16314-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH] toaster: comment out bldcontrol migration command
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
X-List-Received-Date: Fri, 06 Jun 2014 14:03:39 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This fixes toaster startup failing after the preparatory patches
for bldcontrol application have been merged.

I slipped a bldcontrol-specific line into the toaster startup
script and this prevents toaster from starting. We comment
out this line until the bldcontrol application have been merged.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index 80bda6d..f469e4f 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -63,7 +63,7 @@ function webserverStartAll()
             retval=0
             python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=1
         fi
-        python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
+        # python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
 
         if [ $retval -eq 0 ]; then
             python $BBBASEDIR/lib/toaster/manage.py runserver 0.0.0.0:8000 </dev/null >${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
-- 
1.9.1


