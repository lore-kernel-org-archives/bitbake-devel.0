Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
	[74.125.82.176])
	by mail.openembedded.org (Postfix) with ESMTP id 4C9037149B
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Sep 2014 16:45:18 +0000 (UTC)
Received: by mail-we0-f176.google.com with SMTP id q59so10532617wes.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 04 Sep 2014 09:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=SM5Mme37xgNrHey8HMONtK2139dqLNFMFLTn3LhMjXQ=;
	b=EZPzA3rQ5yVsOyMaBu7vTSQA8jgEaNrEAo8ygJljMgxSH5gVp0xsbPiTSs4oLAqxlo
	Hv6vUG/Lh4cgDnPzCRriF8z54yRtPBmqFtu0MoIgpO9YQqTmDb1a2X4CVNIb+BVJ6ePH
	FrUOm67PKUs/hnEkfxvHBT8XICpxMiB6yUnFs0Zuh6m0jkAKuBIFypxNref9++QouQVP
	xNoVbn7J5CgFKUq7qtNkINNo1+J9tMgdiPmm6FBMkc6fNXivGsA6T52Z2+4EhZNGhC58
	JeY2RPI2JML7ewWDKM1TMM5lprlCkHm01Ou67fCqDhu1+v4XHVwCP1BVw1dymLNLAlY4
	xvYQ==
X-Gm-Message-State: ALoCoQkMgZsPiUYaHFKXAJdH+gB9V8lFippkNAbkFSov2OUA8vYpr1Fe5/6OAGSi2V3EJgA2Q3W/
X-Received: by 10.194.236.35 with SMTP id ur3mr7335281wjc.127.1409849119761;
	Thu, 04 Sep 2014 09:45:19 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ys5sm19974897wjc.25.2014.09.04.09.45.18 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 04 Sep 2014 09:45:18 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 3EC59561F7E; Thu,  4 Sep 2014 17:45:19 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Thu,  4 Sep 2014 17:45:13 +0100
Message-Id: <137179eafca8d1a5a69b6302f8cc8961be3b45c4.1409848901.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <a37f2c194d7e59611177cb8755524b7ad702fe91.1409848901.git.alexandru.damian@intel.com>
References: <a37f2c194d7e59611177cb8755524b7ad702fe91.1409848901.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1409848901.git.alexandru.damian@intel.com>
References: <cover.1409848901.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/6] toaster: bitbake server listen on all interface
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
X-List-Received-Date: Thu, 04 Sep 2014 16:45:20 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We change the toaster starting script to make the
bitbake server listen on all interfaces on the local machine.

This is needed to be able to receive a controlling client
running on a remote machine.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 2fabe5c..75c7a07 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -99,7 +99,7 @@ function stop_system()
         kill $(< ${BUILDDIR}/.toasterui.pid ) 2>/dev/null
         rm ${BUILDDIR}/.toasterui.pid
     fi
-    BBSERVER=localhost:8200 bitbake -m
+    BBSERVER=0.0.0.0:8200 bitbake -m
     unset BBSERVER
     webserverKillAll
     # force stop any misbehaving bitbake server
@@ -234,12 +234,12 @@ case $CMD in
             return 4
         fi
         unset BBSERVER
-        bitbake --postread conf/toaster.conf --server-only -t xmlrpc -B localhost:8200
+        bitbake --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:8200
         if [ $? -ne 0 ]; then
             start_success=0
             echo "Bitbake server start failed"
         else
-            export BBSERVER=localhost:8200
+            export BBSERVER=0.0.0.0:8200
             if [ $NOTOASTERUI == 0 ]; then        # we start the TOASTERUI only if not inhibited
                 bitbake --observe-only -u toasterui >${BUILDDIR}/toaster_ui.log 2>&1 & echo $! >${BUILDDIR}/.toasterui.pid
             fi
-- 
1.9.1


