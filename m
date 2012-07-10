Received: from mail-qc0-f175.google.com ([209.85.216.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei@gherzan.ro>) id 1SoYcV-000788-UU
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jul 2012 13:28:44 +0200
Received: by qcad10 with SMTP id d10so5686346qca.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2012 04:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
	:in-reply-to:references:x-gm-message-state;
	bh=TahxcOb+6dGEZ/RyM5ibtynUyayoE7AedtGGEr7XPjY=;
	b=i6Pcz+SW4sbI+TaIIF7/yVSpgsf28i/gcpYM4YflTpT7dWoE05HCg82nfCkGfax3Ow
	qh2ymYpWIlj8W6I0qKYpHcBGxS1pUvW6mxlYMHFmLcYQamkA6vZCoXJhkTsPMtG4qGsl
	dsWObD8uEZATZnogxtomme80peV51XPnXG/0UtI+tUSwAKrckjPSVqQgitDiO0foazd5
	BZ6Ukm501zFU7mHlhEX4aqNXlNlPutB0FuQA8hi8jLmpVPbCw+3j1wkMvD3Fba/bfvaM
	I0Nr91ZisgHatD3n5dbyCmG+gr3GCjyjawm/KQ4UTFw5JKcccOWmKQmBAh8dRJC7eOKk
	J2NQ==
Received: by 10.224.182.19 with SMTP id ca19mr63351852qab.18.1341919053138;
	Tue, 10 Jul 2012 04:17:33 -0700 (PDT)
Received: from otp-agherzan-l1.corp.ad.wrs.com ([89.121.200.106])
	by mx.google.com with ESMTPS id f14sm43675514qak.20.2012.07.10.04.17.26
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 10 Jul 2012 04:17:32 -0700 (PDT)
From: Andrei Gherzan <andrei@gherzan.ro>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Jul 2012 14:16:47 +0300
Message-Id: <092593c08bbfdeb46f6bfe9caa80e977364600b6.1341918809.git.andrei@gherzan.ro>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <04cbd60330fb7ae53d40956fa06feee67bc9e1cb.1341918809.git.andrei@gherzan.ro>
References: <04cbd60330fb7ae53d40956fa06feee67bc9e1cb.1341918809.git.andrei@gherzan.ro>
In-Reply-To: <cover.1341918809.git.andrei@gherzan.ro>
References: <cover.1341918809.git.andrei@gherzan.ro>
X-Gm-Message-State: ALoCoQkPZLhloQCe8dFz05nNP5vTgLD/JMzzcT+w2RyrDIQE+7Vk6zXDsR+BWCYvSw+cjzFGq/4D
Subject: [PATCH 4/5] fetch2/osc.py: Use "protocol" parameter and warn user if recipe is using "proto"
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
X-List-Received-Date: Tue, 10 Jul 2012 11:28:44 -0000

If SRC_URI uses the parameter "proto" while specifying the protocol, use this
value but warn the user about this problem.

Signed-off-by: Andrei Gherzan <andrei@gherzan.ro>
---
 bitbake/lib/bb/fetch2/osc.py |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/osc.py b/bitbake/lib/bb/fetch2/osc.py
index a16a53e..5506829 100644
--- a/bitbake/lib/bb/fetch2/osc.py
+++ b/bitbake/lib/bb/fetch2/osc.py
@@ -57,7 +57,12 @@ class Osc(FetchMethod):
 
         basecmd = data.expand('${FETCHCMD_osc}', d)
 
-        proto = ud.parm.get('proto', 'ocs')
+        proto = ud.parm.get('protocol', 'ocs')
+
+        if ud.parm.get('proto') is not None:
+            logger.warn('Update %s recipe to use "protocol" not "proto".', d.getVar('PN', True))
+            # Use proto value for now
+            proto =  ud.parm.get('proto')
 
         options = []
 
-- 
1.7.9.5



