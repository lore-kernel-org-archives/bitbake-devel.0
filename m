Received: from mail-qa0-f47.google.com ([209.85.216.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei@gherzan.ro>) id 1SoYbx-0006W8-D8
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jul 2012 13:28:16 +0200
Received: by qabg1 with SMTP id g1so2316164qab.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2012 04:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
	:in-reply-to:references:x-gm-message-state;
	bh=SELLi0YnE9wyb2pvS0Ij/VpO8YEw9LGByiTWWZ402rQ=;
	b=CbdmRuMzjvlv5//3cMoxTeYBFuZSbgwnmdp/E+hBpr1wtZL7oXB4Dz5ahNSe1ixYG4
	uWLAdJ7KuDVmFXq8fYzfAFTLF8e5ibxPyKDVuSRqzEw5hIvpVOJvmxosnLHdOiVr8OqZ
	MQETnwMIEojHy6aGU/KBJSugiHf4dd3nANWS2cEKSCnfPeMEHBD7SrWVsHVBq3QBIePe
	LDzOODEXtdpk9YuMBbwzLoAWHb5g5Y+reOdngnZBjW8ez+0Qf1uGqSvCbn0fK9rdUND0
	wG3hlugv0AZBoINeRMe2SrJFFTL+NnPLhGY1rAZi3x/wijcJbpFR1oz8ebdL3k8gQnfm
	EALA==
Received: by 10.229.106.151 with SMTP id x23mr23023420qco.112.1341919018507;
	Tue, 10 Jul 2012 04:16:58 -0700 (PDT)
Received: from otp-agherzan-l1.corp.ad.wrs.com ([89.121.200.106])
	by mx.google.com with ESMTPS id f14sm43675514qak.20.2012.07.10.04.16.57
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 10 Jul 2012 04:16:58 -0700 (PDT)
From: Andrei Gherzan <andrei@gherzan.ro>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Jul 2012 14:16:45 +0300
Message-Id: <9de1c29dc2b30bfd841529381b5419455ebde4de.1341918809.git.andrei@gherzan.ro>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <04cbd60330fb7ae53d40956fa06feee67bc9e1cb.1341918809.git.andrei@gherzan.ro>
References: <04cbd60330fb7ae53d40956fa06feee67bc9e1cb.1341918809.git.andrei@gherzan.ro>
In-Reply-To: <cover.1341918809.git.andrei@gherzan.ro>
References: <cover.1341918809.git.andrei@gherzan.ro>
X-Gm-Message-State: ALoCoQlWpk0w1MchZ0qcZD6pYGRvImOHTncwytk7NuKZXC2u3wmA4X9PN+hyTjlFDUqmz152S+S2
Subject: [PATCH 2/5] fetch2/git.py: Use "protocol" parameter and warn user if recipe is using "proto"
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
X-List-Received-Date: Tue, 10 Jul 2012 11:28:17 -0000

If SRC_URI uses the parameter "proto" while specifying the protocol, use this
value but warn the user about this problem.

Signed-off-by: Andrei Gherzan <andrei@gherzan.ro>
---
 bitbake/lib/bb/fetch2/git.py |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 384007c..354f3b1 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -92,6 +92,10 @@ class Git(FetchMethod):
         """
         if 'protocol' in ud.parm:
             ud.proto = ud.parm['protocol']
+        elif 'proto' in ud.parm:
+            logger.warn('Update %s recipe to use "protocol" not "proto".', d.getVar('PN', True))
+            # Use proto value for now
+            ud.proto = ud.parm['proto']
         elif not ud.host:
             ud.proto = 'file'
         else:
-- 
1.7.9.5



