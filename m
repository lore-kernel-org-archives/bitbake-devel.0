Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 9356870634
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jul 2014 12:15:05 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id z12so3432213wgg.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jul 2014 05:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=eiWydjiZEeOG5mgFgszwDwKVtjHRSoQQKj6wCkOheAE=;
	b=NcCBE4vJKwqh2ISuStwGqj211ExPMGI1+UaElYg4MB04E2bhMXtgxdQFBFThrJA/rh
	TAdl8FuvtYlGye4Ltf+K384Kci4G6b0CICmCfM1UReP1ofjymwFy0bVguiKdVcsXSn1w
	nFcDCenSU4JWwoXM9t1MLOJkepRgGO9NyzdMjiatVSezd/Ze3rHa693BM8ByaJR9EDdR
	LlLyPCdHccsanbSLqsLxHYdbRNiOoMoApxaqIy8Ye6mVTG91/p0YEG2ot0WiG6+hHlAl
	jvdFL/c9ScFGI3oBzShEIEIQAOO3BjMbpYbgwvEe/PUNmqhGe3A3tojQu/bPfFCiXV/p
	SVQw==
X-Gm-Message-State: ALoCoQkw3xYUrRNqjtzHd4E+xA/uYNnJgi1yvpG/j73XkTA23XdPicx/xQ41W65uWXsGWN7D5flR
X-Received: by 10.194.59.65 with SMTP id x1mr6166861wjq.60.1405685706574;
	Fri, 18 Jul 2014 05:15:06 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id o9sm6075479wib.22.2014.07.18.05.15.04
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 18 Jul 2014 05:15:05 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id D9DAB56041D; Fri, 18 Jul 2014 13:15:02 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Fri, 18 Jul 2014 13:15:01 +0100
Message-Id: <7f5ce509f977fff964aa2bc30a13c5e7a326facc.1405685308.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <a487f31bcfa47e1a48cb4bc122017ccb5e8b8f1a.1405685308.git.alexandru.damian@intel.com>
References: <a487f31bcfa47e1a48cb4bc122017ccb5e8b8f1a.1405685308.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1405685308.git.alexandru.damian@intel.com>
References: <cover.1405685308.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 7/8] toaster start script allows for Django 1.6
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
X-List-Received-Date: Fri, 18 Jul 2014 12:15:06 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We perform upgrade to Django 1.6 in order to keep using
a current Django version. In practice, this means
allowing for both 1.5 and 1.6 version in the toaster
start script. We also modify the suggestion
installation commands to remove "sudo" since now pip
can be used in a virtualenv.

Update requirements.txt to install the 1.6 Django release.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster      | 13 ++++++++-----
 requirements.txt |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 93d75b0..ce16de6 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -63,8 +63,10 @@ function webserverStartAll()
             retval=0
             python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=1
         fi
-        python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
-	python $BBBASEDIR/lib/toaster/manage.py checksettings  || retval=1
+	if [ "x$TOASTER_MANAGED" == "x1" ]; then
+	        python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
+		python $BBBASEDIR/lib/toaster/manage.py checksettings  || retval=1
+	fi
 	echo "Starting webserver"
         if [ $retval -eq 0 ]; then
             python $BBBASEDIR/lib/toaster/manage.py runserver 0.0.0.0:8000 </dev/null >${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
@@ -140,6 +142,7 @@ if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; th
         webserverKillAll
         RUNNING=0
     }
+    TOASTER_MANAGED=1
     export TOASTER_MANAGED=1
     webserverStartAll || (echo "Fail to start the web server, stopping" 1>&2 && exit 1)
     xdg-open http://0.0.0.0:8000/ >/dev/null 2>&1 &
@@ -163,13 +166,13 @@ fi
 
 # Verify prerequisites
 
-if ! echo "import django; print (1,5) == django.VERSION[0:2]" | python 2>/dev/null | grep True >/dev/null; then
-    echo -e "This program needs Django 1.5. Please install with\n\nsudo pip install django==1.5"
+if ! echo "import django; print (1,) == django.VERSION[0:1] and django.VERSION[1:2][0] in (5,6)" | python 2>/dev/null | grep True >/dev/null; then
+    echo -e "This program needs Django 1.5 or 1.6. Please install with\n\npip install django==1.6"
     return 2
 fi
 
 if ! echo "import south; print [0,8,4] ==  map(int,south.__version__.split(\".\"))" | python 2>/dev/null | grep True >/dev/null; then
-    echo -e "This program needs South 0.8.4. Please install with\n\nsudo pip install south==0.8.4"
+    echo -e "This program needs South 0.8.4. Please install with\n\npip install south==0.8.4"
     return 2
 fi
 
diff --git a/requirements.txt b/requirements.txt
index 2bb07e6..19b5293 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -1,4 +1,4 @@
-Django==1.5
+Django==1.6
 South==0.8.4
 argparse==1.2.1
 wsgiref==0.1.2
-- 
1.9.1


