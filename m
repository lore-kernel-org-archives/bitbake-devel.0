Received: from mail-we0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei@gherzan.ro>) id 1SoiFV-0002nD-Nf
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jul 2012 23:45:37 +0200
Received: by mail-we0-f175.google.com with SMTP id r6so311310wey.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2012 14:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
	:in-reply-to:references:x-gm-message-state;
	bh=+o95SUsPSR9QrFLh80LBLea0ecCy6Ps+WeGH5fyxrso=;
	b=IjZTG16wqOQWIG8cqpnEf0RwTMx9Zz+fStJZvGS5XS99x1rq3lTHvfTZTKF5/lK777
	RypBFtIwltnw9qvn9lSy4vwRBcyIXAxBZUsFnPwh3H/bYZNwsRqJE/7XUozBfw9wCQvE
	ryyHtn06WlhMUWbRyvBrQHAwIH/Obralbn3APiJbON2qKZFFNAVGe69Ppt7o/C/lln/e
	foQb0hKpR5vVrP4E7S2Q22PyOkmvhi+k90CoTgjf0jOsPU1Jo9ZfulH271VGEg7zPwQU
	ipOJxUUOlw0vDtbJeSr+Y+Wb2A2RB7Z09FWsqRdYXcPfRYDD2W5XeaDzWG/I7k5vkAQT
	zMcg==
Received: by 10.180.103.4 with SMTP id fs4mr41398578wib.16.1341956069023;
	Tue, 10 Jul 2012 14:34:29 -0700 (PDT)
Received: from localhost.localdomain ([79.117.115.156])
	by mx.google.com with ESMTPS id bc2sm46013474wib.0.2012.07.10.14.34.27
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 10 Jul 2012 14:34:28 -0700 (PDT)
From: Andrei Gherzan <andrei@gherzan.ro>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Jul 2012 00:34:16 +0300
Message-Id: <8a090e60f4ae12aff2112f7125949f88aa8667c2.1341955881.git.andrei@gherzan.ro>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <4c68385d27450254afed6263f5140df817d7bf94.1341955881.git.andrei@gherzan.ro>
References: <4c68385d27450254afed6263f5140df817d7bf94.1341955881.git.andrei@gherzan.ro>
In-Reply-To: <cover.1341955881.git.andrei@gherzan.ro>
References: <cover.1341955881.git.andrei@gherzan.ro>
X-Gm-Message-State: ALoCoQmHumsnR1cxOoFLZyuw1Sr2KUkrzHTRYSLYNMiC7rawqxxqS5N4UxuUiBDbtr33GLV3757z
Subject: [PATCH-V2 4/5] fetch2/bzr.py: Use "protocol" parameter to get the protocol
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
X-List-Received-Date: Tue, 10 Jul 2012 21:45:37 -0000

Signed-off-by: Andrei Gherzan <andrei@gherzan.ro>
---
 bitbake/lib/bb/fetch2/bzr.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/bzr.py b/bitbake/lib/bb/fetch2/bzr.py
index 0d10eb4..97daa62 100644
--- a/bitbake/lib/bb/fetch2/bzr.py
+++ b/bitbake/lib/bb/fetch2/bzr.py
@@ -60,7 +60,7 @@ class Bzr(FetchMethod):
 
         basecmd = data.expand('${FETCHCMD_bzr}', d)
 
-        proto =  ud.parm.get('proto', 'http')
+        proto =  ud.parm.get('protocol', 'http')
 
         bzrroot = ud.host + ud.path
 
-- 
1.7.9.5



