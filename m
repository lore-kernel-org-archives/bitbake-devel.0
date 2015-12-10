Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id DFE716FF56
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:53:14 +0000 (UTC)
Received: by pabur14 with SMTP id ur14so40487557pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=1OcCxEhYZ2s5vOaOHCjlusW5PGjHx+q2okxKcUpW290=;
	b=Kqrj24ArepHZHolO1XSBNvgs7YPtEWcGC4fIHdDfuTTvU119ogsq9Zn1nIT13m8sRI
	jjyD6fTGY/gFZoWetWaXEGsftkHpY0MIs6P52uVKax1FXyZ5gn1FmtkdMqMx5B9CYRC8
	n/jjZo2qG1rQcf9EVQ8FmZ3xAjkXK/Q6zvQXHqmw48oEYlDl81Eyo+gFqxX67guLsWa0
	VbE6NLkzJaR2q1OAEJVNToAfj0EGWrCsR4Z3TVoaxhLp6eocv5rlDR5Tj2rE6lcPcxRh
	hlBNrKCEcBt+sx4rKCDiwTjdVAeP6lcFiBDxVDBeaU7gr9yl/MUCkMz4IMnjnluyhP9S
	bO6Q==
X-Received: by 10.67.7.101 with SMTP id db5mr13221988pad.53.1449719595436;
	Wed, 09 Dec 2015 19:53:15 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	c20sm14761349pfd.17.2015.12.09.19.53.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:53:14 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:43 -0800
Message-Id: <889da33cd1a5bfd121a0f03bce685f6032f3c32c.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
References: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449719707.git.avery.brian@gmail.com>
References: <cover.1449719707.git.avery.brian@gmail.com>
Subject: [PATCH 18/18] toaster: rework checking of Django version
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
X-List-Received-Date: Thu, 10 Dec 2015 03:53:15 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Checked django version considering information from
toaster-requirements.txt, e.g. if requirements file contains
line "Django>1.8,<1.9" toaster should be able to check that
requirement correctly.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster              | 24 ++++++++++--------------
 toaster-requirements.txt |  2 +-
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 7645c56..1c1e029 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -156,16 +156,15 @@ notify_chldexit() {
 
 
 verify_prereq() {
-    # Verify prerequisites
-    regex="([0-9])\.([0-9])"
-    for line in `cat $BBBASEDIR/toaster-requirements.txt | grep Django` ; do
-        [[ `echo $line` =~ $regex ]]
-        required_major_version="${BASH_REMATCH[1]}"
-        required_minor_version="${BASH_REMATCH[2]}"
-    done
-
-    if ! echo "import django; print ($required_major_version,) == django.VERSION[0:1] and django.VERSION[1:2][0] in ($required_minor_version,)" | python 2>/dev/null | grep True >/dev/null; then
-        printf "This program needs Django $required_major_version.$required_minor_version. Please install with\n\npip install -r $BBBASEDIR/toaster-requirements.txt\n"
+    # Verify Django version
+    reqfile=$(python -c "import os; print os.path.realpath('$BBBASEDIR/toaster-requirements.txt')")
+    exp='s/Django\([><=]\+\)\([^,]\+\),\([><=]\+\)\(.\+\)/'
+    exp=$exp'import sys,django;version=django.get_version().split(".");'
+    exp=$exp'sys.exit(not (version \1 "\2".split(".") and version \3 "\4".split(".")))/p'
+    if ! sed -n "$exp" $reqfile | python - ; then
+        req=`grep ^Django $reqfile`
+        echo "This program needs $req"
+        echo "Please install with pip install -r $reqfile"
         return 2
     fi
 
@@ -265,10 +264,7 @@ if [ "$1" = 'restart-bitbake' ] ; then
     return $rc
 fi
 
-if ! verify_prereq; then
-    echo "Error: Could not verify that the needed dependencies are installed. Please use virtualenv and pip to install dependencies listed in toaster-requirements.txt" 1>&2
-    return 1
-fi
+verify_prereq || return 1
 
 # We make sure we're running in the current shell and in a good environment
 if [ -z "$BUILDDIR" ] ||  ! which bitbake >/dev/null 2>&1 ; then
diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index 5d34494..0e8c742 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -1,4 +1,4 @@
-Django==1.8.6
+Django>1.8,<1.9
 argparse==1.2.1
 wsgiref==0.1.2
 beautifulsoup4>=4.4.0
-- 
1.9.1


