Received: from mail-qa0-f54.google.com ([209.85.216.54])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei@gherzan.ro>) id 1SoYbv-0006TZ-SI
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jul 2012 13:28:07 +0200
Received: by qaat11 with SMTP id t11so45791qaa.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2012 04:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
	:x-gm-message-state;
	bh=9v2YrMb2yu8rtyKV5oKLS6mrq6jDa7be5woOqrW31o4=;
	b=Jm0HnjQ/Pt8xYmrb+RNw6+xYLdzWH8gQrAb9WHYv1C35u+UgTjYFrK2Um/EEgG+b/j
	sfP+mdeBXg6z1pKNywg+153AS08cVfFaoXuyFCSVV4zlqzUzglNaWOP4XfLUTmAI2pjP
	T4JyXx17Li5kfBvDtdM6BELLh74MGk1R+Y1JnPVktWk04PZS+SzUB2/647syEumzwZ3Z
	WzJPUficfGZ/+06tc2dQ6PxKTDWzWwJASuYLCE3EEoMm6c6hfFUYCuTcFYshAX2WeHsr
	EivMeNOv5x/325rNChBJ07zLXQb9Eoh8/e7aTjwJQrh4iWNmPxUxfvtCY6g+A5VtvVtm
	ZLXg==
Received: by 10.224.176.193 with SMTP id bf1mr2409581qab.98.1341919017122;
	Tue, 10 Jul 2012 04:16:57 -0700 (PDT)
Received: from otp-agherzan-l1.corp.ad.wrs.com ([89.121.200.106])
	by mx.google.com with ESMTPS id f14sm43675514qak.20.2012.07.10.04.16.55
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 10 Jul 2012 04:16:56 -0700 (PDT)
From: Andrei Gherzan <andrei@gherzan.ro>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Jul 2012 14:16:44 +0300
Message-Id: <04cbd60330fb7ae53d40956fa06feee67bc9e1cb.1341918809.git.andrei@gherzan.ro>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1341918809.git.andrei@gherzan.ro>
References: <cover.1341918809.git.andrei@gherzan.ro>
X-Gm-Message-State: ALoCoQlGX5Lz0biUoAejF9lrsgwpugtCEUDQfyJBSo8G4ypj+T/yXmaHucjOyNs2mR5ivIcWd5zm
Subject: [PATCH 1/5] fetch2/bzr.py: Use "protocol" parameter and warn user if recipe is using "proto"
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
X-List-Received-Date: Tue, 10 Jul 2012 11:28:08 -0000

If SRC_URI uses the parameter "proto" while specifying the protocol, use this
value but warn the user about this problem.

Signed-off-by: Andrei Gherzan <andrei@gherzan.ro>
---
 bitbake/lib/bb/fetch2/bzr.py |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/bzr.py b/bitbake/lib/bb/fetch2/bzr.py
index 0d10eb4..e27c70e 100644
--- a/bitbake/lib/bb/fetch2/bzr.py
+++ b/bitbake/lib/bb/fetch2/bzr.py
@@ -60,7 +60,12 @@ class Bzr(FetchMethod):
 
         basecmd = data.expand('${FETCHCMD_bzr}', d)
 
-        proto =  ud.parm.get('proto', 'http')
+        proto =  ud.parm.get('protocol', 'http')
+
+        if ud.parm.get('proto') is not None:
+            logger.warn('Update %s recipe to use "protocol" not "proto".', d.getVar('PN', True))
+            # Use proto value for now
+            proto =  ud.parm.get('proto')
 
         bzrroot = ud.host + ud.path
 
-- 
1.7.9.5



