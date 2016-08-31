Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193])
	by mail.openembedded.org (Postfix) with ESMTP id 75F0A73216
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Aug 2016 19:57:12 +0000 (UTC)
Received: by mail-pf0-f193.google.com with SMTP id y134so3216159pfg.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Aug 2016 12:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=Ljf/zjrtIGEN1/oVPlwHpsDVPXXoEO4yJjtDhYDrzQU=;
	b=oetnxdpIDGEb5luvfPVZEsKnKYlkYG4SW4eAwm6Ddw3hz96atHGNO2+hGTEUSKF0Qt
	L76s1x+ZalQtLtHLAKhK3AXYQfHWhcE4F+1JpFtOwCyWLZrzbk5Vcs/E0F5xaCiL9v5h
	e4+jv+36VfsGcna6Izab1Za2DrHyAjkQDG7i4XJN89X2WtnCWtqqjVPVMP07vwr03Y1i
	VuUjZJgp7HrB6ZYkeCKFm/ENTlz0jUAWoXW4YmvmOEAi+x5L6tXbkgFohHXsZswxFEpW
	ju9m1HeMC4zymvh7WlUfuCGTVnFv7muqz05Zg7gemOTO0gyXD8gAtIwS4yifYHJ4wLRx
	OvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Ljf/zjrtIGEN1/oVPlwHpsDVPXXoEO4yJjtDhYDrzQU=;
	b=UWn+fyvcT53bk0+Mm0kjVOqJ+nU3wwsAjmsQfWb5RsTWrk8trPxtpIUiQEln7hjr+o
	+Bp9d6S9q3JjTugZGWIE2Y7OCJzC+W5lo3i5V53pqUVmjEJqQTxUydL3/U0zbmg9BXfH
	tGuq9YJ9tPQ3ySFdpGBb8PozR4wU+n4ynMU3z9jbFF/0En6/fuWmBscMsB4TjNsOqLst
	SUvw+Qt8r+4SjWEuPywahPpQe3VOgRvAbXf8A98tUuAa1kN8fsN3HCNzKCN5L7o0R1zB
	co0ge/zPJIJO9kIp/9KF2oYR1AYUmDVPVjDEAMx9/EsMF5DLmMerqkskmctW2Jl7D21Q
	c/vw==
X-Gm-Message-State: AE9vXwOO6BwJUhKGIT+GRMi9gP0plGSbVwoslacA4cXWO5RtqCH/GayOaDSGpzwU75WIfw==
X-Received: by 10.98.25.8 with SMTP id 8mr20052075pfz.94.1472673433430;
	Wed, 31 Aug 2016 12:57:13 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	h86sm1644491pfh.46.2016.08.31.12.57.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 31 Aug 2016 12:57:12 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 31 Aug 2016 12:57:08 -0700
Message-Id: <1472673428-16400-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.8.0
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH] bb.fetch2.svn: correctly pass workdir when fetching
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
X-List-Received-Date: Wed, 31 Aug 2016 19:57:13 -0000

From: Christopher Larson <chris_larson@mentor.com>

The ud.pkgdir argument was being passed as the 'quiet' argument to
runfetchcmd, not the 'workdir' argument, resulting in fetching the svn module
into the root of DL_DIR, not where it belongs.

Cc: Matt Madison <matt@madison.systems>
Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/svn.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 9ff9410..6ca79d3 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -141,7 +141,7 @@ class Svn(FetchMethod):
             bb.utils.mkdirhier(ud.pkgdir)
             logger.debug(1, "Running %s", svnfetchcmd)
             bb.fetch2.check_network_access(d, svnfetchcmd, ud.url)
-            runfetchcmd(svnfetchcmd, d, ud.pkgdir)
+            runfetchcmd(svnfetchcmd, d, workdir=ud.pkgdir)
 
         scmdata = ud.parm.get("scmdata", "")
         if scmdata == "keep":
-- 
2.8.0


