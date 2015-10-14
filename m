Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id ECFD777093
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 14:49:54 +0000 (UTC)
Received: by wicll6 with SMTP id ll6so887686wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 07:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=jFTe3th9utqZ8jrgqUkY9Etxl7/koyegem5Zft028Yc=;
	b=DdCWvcCrtNFjzWIQv8SnYPwsse1foJMJj/55WYAzjWyRfR2P5N29NXMxe3k6Oi51gs
	LOjalalxfhaT+B24YANB6S2hYWY49UEWk14d/OsCspu3ndzny26RzthSQ05lmT9r0TyA
	n8Op893yBEkOwtVNESUPt6ZiSCYpja0a3w3bHov/wm6y+8W1JaY2FUKD8FFPwF8I6oOU
	8sBN9R9OWT2BithjzGOdV1yO2CaVBMU55Q75W3vItnDjIgeBr1YK4NqTWvu9qX0lKmkK
	eiHFrGAuInXh95siTc0GKKnH9wyzhyREGEatyeaMbeFcLTcxHDdJSVylKzdNF9y3+qax
	zGog==
X-Gm-Message-State: ALoCoQknxrJD8BlwV4fmDKkg/G9OQZPVEAU5lOGgqp7Wg/Kn1/5cqcekt39s5ubDY2mJM94FFGWs
X-Received: by 10.194.234.97 with SMTP id ud1mr4580998wjc.133.1444833834370;
	Wed, 14 Oct 2015 07:43:54 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	p7sm10466970wjf.26.2015.10.14.07.43.53
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 14 Oct 2015 07:43:53 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Oct 2015 15:43:43 +0100
Message-Id: <b6b577253c245392800ea5e78391d11cef8eb8c8.1444830820.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1444830820.git.michael.g.wood@intel.com>
References: <cover.1444830820.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1444830820.git.michael.g.wood@intel.com>
References: <cover.1444830820.git.michael.g.wood@intel.com>
Subject: [PATCH 1/3] toaster: Always run bldcontrol migrations
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
X-List-Received-Date: Wed, 14 Oct 2015 14:49:57 -0000

From: Elliot Smith <elliot.smith@intel.com>

The toaster startup script conditionally migrates the database
tables depending on whether you are in managed mode or not. This
means that if you are in analysis mode, some of the bldcontrol*
database tables used by managed mode are not available.

As a consequence, some of the code in toaster which refers to
those tables can break in analysis mode, as there's no clean
isolation of the two modes.

To prevent this from happening, always run the migrations for
managed mode and create the bldcontrol* tables, even if in
analysis mode.

Also clean up the function which starts up toaster so the
logic is easier to follow.

[YOCTO #8277]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bin/toaster | 56 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index bc439e6..e976604 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -59,29 +59,50 @@ webserverStartAll()
     python $BBBASEDIR/lib/toaster/manage.py syncdb --noinput || retval=1
 
     python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=2
+
     if [ $retval -eq 1 ]; then
-        echo "Failed db sync, stopping system start" 1>&2
-    elif [ $retval -eq 2 ]; then
-        printf "\nError on migration, trying to recover... \n"
+        echo "Failed db sync, aborting system start" 1>&2
+        return $retval
+    fi
+
+    python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=1
+
+    if [ $retval -eq 1 ]; then
+        printf "\nError on orm migration, rolling back...\n"
         python $BBBASEDIR/lib/toaster/manage.py migrate orm 0001_initial --fake
-        retval=0
-        python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=1
+        return $retval
     fi
+
+    python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
+
+    if [ $retval -eq 1 ]; then
+        printf "\nError on bldcontrol migration, rolling back...\n"
+        python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol 0001_initial --fake
+        return $retval
+    fi
+
     if [ "$TOASTER_MANAGED" = '1' ]; then
-        python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
-        python $BBBASEDIR/lib/toaster/manage.py checksettings  --traceback || retval=1
+        python $BBBASEDIR/lib/toaster/manage.py checksettings --traceback || retval=1
     fi
-    if [ $retval -eq 0 ]; then
-        echo "Starting webserver..."
-        python $BBBASEDIR/lib/toaster/manage.py runserver "0.0.0.0:$WEB_PORT" </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
-        sleep 1
-        if ! cat "${BUILDDIR}/.toastermain.pid" | xargs -I{} kill -0 {} ; then
-            retval=1
-            rm "${BUILDDIR}/.toastermain.pid"
-        else
-            echo "Webserver address:  http://0.0.0.0:$WEB_PORT/"
-        fi
+
+    if [ $retval -eq 1 ]; then
+        printf "\nError while checking settings; aborting\n"
+        return $retval
+    fi
+
+    echo "Starting webserver..."
+
+    python $BBBASEDIR/lib/toaster/manage.py runserver "0.0.0.0:$WEB_PORT" </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
+
+    sleep 1
+
+    if ! cat "${BUILDDIR}/.toastermain.pid" | xargs -I{} kill -0 {} ; then
+        retval=1
+        rm "${BUILDDIR}/.toastermain.pid"
+    else
+        echo "Webserver address:  http://0.0.0.0:$WEB_PORT/"
     fi
+
     return $retval
 }
 
@@ -375,3 +396,4 @@ case $CMD in
         echo "Successful ${CMD}."
     ;;
 esac
+
-- 
2.1.4


