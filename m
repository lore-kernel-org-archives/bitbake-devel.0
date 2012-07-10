Received: from mail-wg0-f41.google.com ([74.125.82.41])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei@gherzan.ro>) id 1SoiFW-0002oE-DC
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jul 2012 23:45:38 +0200
Received: by wgbds1 with SMTP id ds1so3625117wgb.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2012 14:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
	:in-reply-to:references:x-gm-message-state;
	bh=kBJXelqR0IX1Fm2rDCIFaaKevPA6VOF/IqtiybL012k=;
	b=SeB0aI2hEFGAxJCAXsWmcf1IeEWhuAFM0KgViHWVr3kD6uCHzGLVVr6NAk94j7XyBv
	/y+zgPdCwuKnlkMpVf5/jZxOcNznXnqV7lm9B6tqMJksTCsUPOJQG4y6hXMFWOXxEEpX
	nEhx33ZnK9hEle5DtbPMS/eyyhNPpQZ6ROPtzE275r8eF633H/mteET+7a8MtxY1IixY
	Rgi1aORcgs38Nkl/hq9ct66LCOu01rc0bmf4MjzYpImW6AHDBkBzTrxvyoFBBxFTBkWE
	i+MwHNFaVIEc/wvtiirJaRwfCwolWQ0LCO0CebEGhNRBQhY7TtW5IODvRqKSBt2bwffJ
	csyQ==
Received: by 10.216.181.7 with SMTP id k7mr20621305wem.182.1341956067623;
	Tue, 10 Jul 2012 14:34:27 -0700 (PDT)
Received: from localhost.localdomain ([79.117.115.156])
	by mx.google.com with ESMTPS id bc2sm46013474wib.0.2012.07.10.14.34.26
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 10 Jul 2012 14:34:26 -0700 (PDT)
From: Andrei Gherzan <andrei@gherzan.ro>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Jul 2012 00:34:15 +0300
Message-Id: <885b63f823a958182f18db1678b9676e5b3d4adc.1341955881.git.andrei@gherzan.ro>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <4c68385d27450254afed6263f5140df817d7bf94.1341955881.git.andrei@gherzan.ro>
References: <4c68385d27450254afed6263f5140df817d7bf94.1341955881.git.andrei@gherzan.ro>
In-Reply-To: <cover.1341955881.git.andrei@gherzan.ro>
References: <cover.1341955881.git.andrei@gherzan.ro>
X-Gm-Message-State: ALoCoQnR+YPkJeKJ8zDJ4yRhdwn8CXe/7o+EVpqoQSEfmwXlpfacPL1mjuVaQwY1wWl9zPWUwAS9
Subject: [PATCH-V2 3/5] fetch2/hg.py: Use "protocol" parameter to get the protocol
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 10 Jul 2012 21:45:38 -0000

Signed-off-by: Andrei Gherzan <andrei@gherzan.ro>
---
 bitbake/lib/bb/fetch2/hg.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index ad6e85d..155ae67 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -82,7 +82,7 @@ class Hg(FetchMethod):
 
         basecmd = data.expand('${FETCHCMD_hg}', d)
 
-        proto = ud.parm.get('proto', 'http')
+        proto = ud.parm.get('protocol', 'http')
 
         host = ud.host
         if proto == "file":
-- 
1.7.9.5



