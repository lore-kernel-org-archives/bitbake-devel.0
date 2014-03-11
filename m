Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
	[74.125.82.169])
	by mail.openembedded.org (Postfix) with ESMTP id B6B506F876
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 15:49:53 +0000 (UTC)
Received: by mail-we0-f169.google.com with SMTP id w62so10350205wes.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 08:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=zItJekmd2tGDhmg6kyFCDLY96TN/xbaPVTx6IOPaV0c=;
	b=YIayBs2FKQGFY2mho/5nZqqfCF6eeLxrvDG5fEJyoP+3DI+44O7QCIoXDCbvDurTdA
	Dmk5MyVAtYfTG3PM+jx4dt9IFeOMThvUb8VPlc/SsNoCFZV43m17q2awK9q53JOQ2hZc
	fHTQu1YMcqID0R2LbUt4P52cppSiOA7fNzHJrgKdk2DcxqdY4gwKvTbd5ebW7pBjxZsk
	7sZvaGbcKRqtON1ftvHIpSc7Iell7gHIco9hDXbO75D+TjGL2oP6Slz+5uIDa6pdbnG/
	QkiZjuhVS+Ue80VTO26b/Jkiz793M5VQeDHEGWcn5WSulRVY2N6fQvg2tzi0xj6fyIlR
	C+PQ==
X-Gm-Message-State: ALoCoQmcXqfTLWQLvV2coa+3lDJfTQJFreMKTA8C/OZF/QKx5e6zADkrgcCmIonaaS/IFLDXH4Wg
X-Received: by 10.194.48.100 with SMTP id k4mr8224310wjn.49.1394552994090;
	Tue, 11 Mar 2014 08:49:54 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id dd3sm62440151wjb.9.2014.03.11.08.49.52
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 11 Mar 2014 08:49:53 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 35DE25605D0; Tue, 11 Mar 2014 15:49:54 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Mar 2014 15:49:48 +0000
Message-Id: <5d6594de8876be8ce4df56b846fee0fc687a6261.1394552757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <f8488845ee9670e16a63c331dd2e97fdb314929c.1394552757.git.alexandru.damian@intel.com>
References: <f8488845ee9670e16a63c331dd2e97fdb314929c.1394552757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394552757.git.alexandru.damian@intel.com>
References: <cover.1394552757.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 4/8] toaster: erase checks for stop command
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
X-List-Received-Date: Tue, 11 Mar 2014 15:49:54 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We remove the checks for the stop command, since we assume
the user really means it wants to shutdown the system when
he issues the command.

	[YOCTO #5376]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 38e71ac..9c0a15f 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -143,25 +143,12 @@ if [ -e $BUILDDIR/bitbake.lock ]; then
 fi
 
 if [ ${CMD} == "start" ] && ( [ $lock -eq 0 ] || [ -e $BUILDDIR/.toastermain.pid ] ); then
-    echo "Error: bitbake lock state error. System is already on." 2>&1
-    return 3
-elif [ ${CMD} == "stop" ] && ( [ $lock -eq 1 ] || ! [ -e $BUILDDIR/.toastermain.pid ] ) ; then
-    echo "Error: bitbake lock state error. Trying to stop a stopped system ?
-If you think the system is hanged up, you can try to manually stop system with the commands
-
-# BBSERVER=localhost:8200 bitbake -m
-
-and
-
-# webserverKillAll
-" 2>&1
+    echo "Error: bitbake lock state error. File locks show that the system is on." 2>&1
+    echo "If you see problems, stop and then start the system again." 2>&1
     return 3
 fi
 
 
-
-
-
 # Execute the commands
 
 case $CMD in
-- 
1.8.3.2


