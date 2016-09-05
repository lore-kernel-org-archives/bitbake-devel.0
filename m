Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f173.google.com (mail-pf0-f173.google.com
	[209.85.192.173])
	by mail.openembedded.org (Postfix) with ESMTP id 26925760B0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 14:29:59 +0000 (UTC)
Received: by mail-pf0-f173.google.com with SMTP id p64so65238861pfb.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Sep 2016 07:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=jcFtyhJtdcX8rUKNnGbJXcNGaTOHccygDzPbkgmVhms=;
	b=fiYLuR2oWR1V9CjkRtBiNPhyuDDCLA5rbpx5V1q9yKQXw6oQyc0Huc2QmGunsxz8CZ
	OpoZr689v7vIeNuF10gkGKrutFyxaDLvqIww1HqlNcLrTklcnV3LOkB0l2xQ01Jmj8Qj
	61d1mJITSyg/McR2BlaS4J1Fy5TfszbULW1U83d/KxwWJRebNzx3lO0t/amvJ0wRRj/w
	Uy8Dh/QQFrdp7H/MG2wNxT11P4WQTMbAxpMdbqFxW19C5tEP9mpFRZNe9BI7af9Sf9ly
	IPbS0zmF3W1F5SGE92Ft4Kon2BfaGd3JzkBIjMd+fF3M9eWEU1mSLWnL3GkUIim5pcyn
	7UBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=jcFtyhJtdcX8rUKNnGbJXcNGaTOHccygDzPbkgmVhms=;
	b=LEpV7jqV0buK67XimWQN3ZHZn0HdfcLW8J9JcQtI0Nnid+FJekTxZwTWo8+egxv1aj
	jOlV5NSk5Psjl14hAixe6NOWyULOjsurRMmRv91JpLayRWfOGhTuUt4vtK/MZAV3RP6Q
	jTawpfxq+HmL4z8NkBtApOCrCLTTU/ReZFfs7td9rtCu5yvIb294Jctc3ae4Jc+0clrs
	AyP+7HEc9/hRPBieuwTv1wcyV6JWcO21P0h+bjddGoR/ZE/pRjKi7DpLpey2GAnjM7+k
	DhzE6ZmtdPmMznAI3LqvC9XHJlwWwTnl309cD8oYMHQzOqx3ueEyn1kzyyNaU47QaCtz
	ibcg==
X-Gm-Message-State: AE9vXwNiPL9eu2kZwthw+CzWLK4RLMnFsM7XppCqxGpR/vfw4BLDptu0YamHA4YfvKsAiZob
X-Received: by 10.98.222.5 with SMTP id h5mr56112921pfg.144.1473085800138;
	Mon, 05 Sep 2016 07:30:00 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr03-ext.fm.intel.com.
	[192.55.54.38]) by smtp.gmail.com with ESMTPSA id
	j21sm34058285pfj.75.2016.09.05.07.29.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 05 Sep 2016 07:29:59 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Sep 2016 15:29:30 +0100
Message-Id: <1473085772-17878-10-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
References: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 09/11] toaster: don't kill toaster on start
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
X-List-Received-Date: Mon, 05 Sep 2016 14:29:59 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

There is no point of trying to kill django development server
when toaster starts because 'manage.py checksocket' command is already
used in the script code to check if development server port is occupied.

Even if Toaster is listening on another port, killing previous instance
looks quite implicit and doesn't solve anything as there are other
processes that might be still running.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bin/toaster | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index e35bfce..5e01101 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -249,14 +249,6 @@ case $CMD in
             fi
         fi
 
-        # kill Toaster web server if it's alive
-        if [ -e $BUILDDIR/.toastermain.pid ] && kill -0 `cat $BUILDDIR/.toastermain.pid`; then
-            echo "Warning: bitbake appears to be dead, but the Toaster web server is running." 1>&2
-            echo " Something fishy is going on." 1>&2
-            echo "Cleaning up the web server to start from a clean slate."
-            webserverKillAll
-        fi
-
         # Create configuration file
         conf=${BUILDDIR}/conf/local.conf
         line='INHERIT+="toaster buildhistory"'
-- 
2.7.4


