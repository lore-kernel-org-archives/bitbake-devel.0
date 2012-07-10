Received: from mail-wi0-f171.google.com ([209.85.212.171])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei@gherzan.ro>) id 1SoiFU-0002o5-VN
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jul 2012 23:45:36 +0200
Received: by wibhq4 with SMTP id hq4so3994141wib.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2012 14:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
	:in-reply-to:references:x-gm-message-state;
	bh=qsOWPjlr0VRtvDIQFvT0kWo9UoR1wO5TggUT0W0UgjE=;
	b=l+PfGkJ54+oIIPw3CQLKbKLb+jIYN7uATLFb1lB2x29A9/bdIZbMc7NnAsdocxPjWA
	sQrb9SL2WGkwj5rlbn7lh5yG6e8Wb+0tMrwzUinbaT53d5Ddg6bPMFNoN8WbuKiSbuXx
	c90pnKV8P1xjEPMcuey1IyJHHkh3gfl14Tf/0Es7zw0CTsftaqj1fRZ1qH0GLZfVCSXC
	yDgbs+SNcGA2PWjchfzWaFN4QBCTArh9PZtyXbx17a5/TfbRxkwgAZSXjeBllYwVfmru
	3wCnDAkMK4hVrkqvBtZ2F2sA6nIl2Z4d14mZdkX4eOlU/OfB/LVbRInryd9a6sp+DgGP
	UC/w==
Received: by 10.180.93.68 with SMTP id cs4mr41417309wib.14.1341956066176;
	Tue, 10 Jul 2012 14:34:26 -0700 (PDT)
Received: from localhost.localdomain ([79.117.115.156])
	by mx.google.com with ESMTPS id bc2sm46013474wib.0.2012.07.10.14.34.24
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 10 Jul 2012 14:34:25 -0700 (PDT)
From: Andrei Gherzan <andrei@gherzan.ro>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Jul 2012 00:34:14 +0300
Message-Id: <156a5704180f682916d0a45bc4b657fd39a1ce15.1341955881.git.andrei@gherzan.ro>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <4c68385d27450254afed6263f5140df817d7bf94.1341955881.git.andrei@gherzan.ro>
References: <4c68385d27450254afed6263f5140df817d7bf94.1341955881.git.andrei@gherzan.ro>
In-Reply-To: <cover.1341955881.git.andrei@gherzan.ro>
References: <cover.1341955881.git.andrei@gherzan.ro>
X-Gm-Message-State: ALoCoQlNyDCHbmilVsfg6jZJgUEtqbiotMJYrHok3fDitKNaeQSFQWGbPAmVpXm6wJ5bni1m1eK2
Subject: [PATCH-V2 2/5] fetch2/osc.py: Use "protocol" parameter to get the protocol
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
 bitbake/lib/bb/fetch2/osc.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/osc.py b/bitbake/lib/bb/fetch2/osc.py
index a16a53e..1a3a7bb 100644
--- a/bitbake/lib/bb/fetch2/osc.py
+++ b/bitbake/lib/bb/fetch2/osc.py
@@ -57,7 +57,7 @@ class Osc(FetchMethod):
 
         basecmd = data.expand('${FETCHCMD_osc}', d)
 
-        proto = ud.parm.get('proto', 'ocs')
+        proto = ud.parm.get('protocol', 'ocs')
 
         options = []
 
-- 
1.7.9.5



