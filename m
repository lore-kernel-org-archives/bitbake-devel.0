Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f178.google.com (mail-pf0-f178.google.com
	[209.85.192.178])
	by mail.openembedded.org (Postfix) with ESMTP id 2B490773DD
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 14:30:03 +0000 (UTC)
Received: by mail-pf0-f178.google.com with SMTP id p64so65239254pfb.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Sep 2016 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=TaVF+BVi7auIjgtxaBAbehxKuvcQzAUVQAknK/todu0=;
	b=0ZGHH9HSbnI2c/dLcBGoMG1hn3QIuLgGlpRHJBN5WE6riie0N/d1TmNHs513I4xieF
	3NF2+BXR7/cBgu4zD8wBr5eRjs5V70LU9rvM9WQoeqCs8UzvlCaVarXEcoXwHNc294ni
	pCf/fJ/zmZrnISzvVimcQkfz0A7KOZg3MatJxMDPy6Mi2B006ZqqBu4r8MlLLWurBcil
	rxuRE/kMxdcj2iA2okL45yn7+3uOEwoQ14YulJ82hYbSy6NZsuNj43wlnddF9HtB6Rsd
	+EfdtOi1zyqYWgIw2ry3A4LMGA8OGsivaoRk85gfvnArLn08Qcdbgm9TFLjfjcxG1w2D
	uxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=TaVF+BVi7auIjgtxaBAbehxKuvcQzAUVQAknK/todu0=;
	b=i9j61Ec9BAh55hva2XIuhHJrEl1xhu90c35JHIaskBQO1kHNBMBck/Q0Nwg/D87M/C
	XkQnxY2D8yKFCSpu5AbuJauaCRNX8vxTuG2WA/O0jbeTLV1P+QR7ACSAQhWIbcDwlyDv
	OQPsDfUa6WPZ9LjIi6vUM3sSK6ihabXU18KpdBb87Xxy4l1vxkdvyc5Euats7rjtWCuP
	cgn+nlBjmdfCNjig5kY66o9sJ91GQ5RiHIQOBGTxq1vYNmtB2FAN9W0YNxxWxlW4fimH
	89G6hou+hDDMfwkp9CkrVz/h/cg9CjLW7TSRTrMcHgK0tGFNrvD1xCkFR0WWMduNQHnU
	OcGw==
X-Gm-Message-State: AE9vXwPIm99E5StYWBSp2bEHe3WjF0jySThAFRygfzOzuQkDJKxwiTb3qEEfys4YdAUBktd2
X-Received: by 10.98.93.25 with SMTP id r25mr64136081pfb.122.1473085804637;
	Mon, 05 Sep 2016 07:30:04 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr03-ext.fm.intel.com.
	[192.55.54.38]) by smtp.gmail.com with ESMTPSA id
	j21sm34058285pfj.75.2016.09.05.07.30.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 05 Sep 2016 07:30:03 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Sep 2016 15:29:32 +0100
Message-Id: <1473085772-17878-12-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
References: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 11/11] toaster: don't kill all runserver processes
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
X-List-Received-Date: Mon, 05 Sep 2016 14:30:05 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Toaster script kills runserver process 2 ways:
 - sending signal to pid from .toastermain.pid.
 - sending signal to pids found by grepping ps output:
       ps fux | grep "python.*manage.py runserver"

Second approach is redundant and harmfull as it kills all django
development server running on the machine.

[YOCTO #7973]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bin/toaster | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index b14749a..6641dbc 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -33,9 +33,6 @@ webserverKillAll()
             while kill -0 $pid 2>/dev/null; do
                 kill -SIGTERM -$pid 2>/dev/null
                 sleep 1
-                # Kill processes if they are still running - may happen
-                # in interactive shells
-                ps fux | grep "python.*manage.py runserver" | awk '{print $2}' | xargs kill
             done
             rm  ${pidfile}
         fi
-- 
2.7.4


