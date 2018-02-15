Return-Path: <anderssontobias88@gmail.com>
Received: from mail-lf0-f50.google.com (mail-lf0-f50.google.com
	[209.85.215.50])
	by mail.openembedded.org (Postfix) with ESMTP id EEF7771AB3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Feb 2018 21:46:11 +0000 (UTC)
Received: by mail-lf0-f50.google.com with SMTP id f136so1535571lff.8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Feb 2018 13:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=qwfYsX3qMrkmk4kFiJnrrS+8OW0d+N8fci3N3qVNaiA=;
	b=nwVXFahb1lSfjpjyTSyD14KIg6g47voXaF1AoypQw46ouf9sqqr6kid/r5O1EIbbt8
	d0gSBVpJZAVWTTmIY+ZpKrr7Qy+6gUdVZicnMfths4hLQsMYFMo47fjP9v5zNuk4x72i
	BbjX1zJTw7NvXivgeeeaT3/7Q6vzezizq1djEhLY6mBeE3rOufuMnONkQtXeu6nEckw7
	EFlVzwT6Bx0JPz5yC73+7dwNTXwvZL1tWB+6eJQWvDqanrQwtmff2dpO5w+HQatyB99k
	niAv4/JuMVzv6j8kolfrzM2+jGTGrAWliNUAz5a7Sk6zvAN9E0VYG606X0Gkvg9zUMZM
	Ftmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=qwfYsX3qMrkmk4kFiJnrrS+8OW0d+N8fci3N3qVNaiA=;
	b=Yp7AhMApEPIRY8srK5jOKZix7le1iYEKZrMBTyAluF8M5k2Ul68FYG9w2aNPIi44an
	hVYie0RBjHU1nqcOF4nREW/iGQHc2dUU0sDh641srgAIHSU97SjmzRRecTLB+FeyMnNJ
	SegpPFB41PVrb+vMeOYCIRRmqNE7W3UegGe89uAoLGUOfXuStfND09mtfHEnOWd44zzV
	kRezJ89yx7ACe6GIIpbk8RJgv6C5mPxCq4dOIWLGjJiDiu6QINUL4PFg44WRiWnA4j77
	lQwZ8q8sU8kTwy9JqiXlzf3M5BsK/hlkJBD8LIb3Vd+VTVlsEQdasFaDl0LDkdUUvRRB
	brSQ==
X-Gm-Message-State: APf1xPAXQj9qP74kMIoQF/NeziYMIHV60Lrgf515fj6sK8+/Yv+DaC6W
	kygE+exly9rwO3ILuk0/SaHUvw==
X-Google-Smtp-Source: AH8x224Ht+G0fEZz3fkxxgYLRKB9wZ0BW/xkgMbLCtDn6uKvZ0vP4n9RmmoFRPdqQVnBJdRLC2Yccg==
X-Received: by 10.25.158.67 with SMTP id h64mr2906702lfe.56.1518731171950;
	Thu, 15 Feb 2018 13:46:11 -0800 (PST)
Received: from builder.lund.multiq.com (www3.mikrolund.ideon.se. [85.235.1.83])
	by smtp.gmail.com with ESMTPSA id
	g10sm3241229ljg.94.2018.02.15.13.46.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 15 Feb 2018 13:46:10 -0800 (PST)
From: Tobias Andersson <anderssontobias88@gmail.com>
X-Google-Original-From: Tobias Andersson <tobias.andersson@multiq.com>
To: bitbake-devel@lists.openembedded.org
Message-Id: <1518731148-12744-1-git-send-email-tobias.andersson@multiq.com>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Mon, 02 Apr 2018 22:22:40 +0000
Cc: Tobias Andersson <tobias.andersson@multiq.com>
Subject: [meta][PATCH] Toaster now starts
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
Date: Thu, 15 Feb 2018 21:46:12 -0000
X-Original-Date: Thu, 15 Feb 2018 22:45:48 +0100
X-List-Received-Date: Thu, 15 Feb 2018 21:46:12 -0000

---
 bitbake/bin/toaster | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster
index 4036f0a..4c8ad31 100755
--- a/bitbake/bin/toaster
+++ b/bitbake/bin/toaster
@@ -38,7 +38,7 @@ databaseCheck()
     retval=0
     # you can always add a superuser later via
     # ../bitbake/lib/toaster/manage.py createsuperuser --username=<ME>
-    $MANAGE migrate --noinput || retval=1
+    python3 $MANAGE migrate --noinput || retval=1
 
     if [ $retval -eq 1 ]; then
         echo "Failed migrations, aborting system start" 1>&2
@@ -46,7 +46,7 @@ databaseCheck()
     fi
     # Make sure that checksettings can pick up any value for TEMPLATECONF
     export TEMPLATECONF
-    $MANAGE checksettings --traceback || retval=1
+    python3 $MANAGE checksettings --traceback || retval=1
 
     if [ $retval -eq 1 ]; then
         printf "\nError while checking settings; aborting\n"
@@ -91,7 +91,7 @@ webserverStartAll()
 
     echo "Starting webserver..."
 
-    $MANAGE runserver "$ADDR_PORT" \
+    python3 $MANAGE runserver "$ADDR_PORT" \
            </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 \
            & echo $! >${BUILDDIR}/.toastermain.pid
 
@@ -159,7 +159,7 @@ else
 fi
 
 export BBBASEDIR=`dirname $TOASTER`/..
-MANAGE="python3 $BBBASEDIR/lib/toaster/manage.py"
+MANAGE="$BBBASEDIR/lib/toaster/manage.py"
 OE_ROOT=`dirname $TOASTER`/../..
 
 # this is the configuraton file we are using for toaster
@@ -264,9 +264,9 @@ custom_extention toaster_prepend $CMD $ADDR_PORT
 case $CMD in
     start )
         # check if addr:port is not in use
-        if [ "$CMD" == 'start' ]; then
+        if [ "$CMD" = 'start' ]; then
             if [ $WEBSERVER -gt 0 ]; then
-                $MANAGE checksocket "$ADDR_PORT" || return 1
+                python3 $MANAGE checksocket "$ADDR_PORT" || return 1
             fi
         fi
 
@@ -292,7 +292,7 @@ case $CMD in
         fi
         export BITBAKE_UI='toasterui'
         if [ $TOASTER_BUILDSERVER -eq 1 ] ; then
-            $MANAGE runbuilds \
+            python3 $MANAGE runbuilds \
                </dev/null >>${BUILDDIR}/toaster_runbuilds.log 2>&1 \
                & echo $! >${BUILDDIR}/.runbuilds.pid
         else
-- 
2.7.4


