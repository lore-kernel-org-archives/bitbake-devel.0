Received: from mail-qc0-f175.google.com ([209.85.216.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei@gherzan.ro>) id 1SoYcY-0007BG-CP
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jul 2012 13:28:46 +0200
Received: by qcad10 with SMTP id d10so5686365qca.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2012 04:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
	:in-reply-to:references:x-gm-message-state;
	bh=P4Vzyg8B3OwVDybrcee5S6jcOI0fEny4AXW9LT+bIo8=;
	b=BrC/nva0Q+2PTH4/vGDS/s0jO/+GqDD+xNPW/e4vdQXtrabb4uR7RZSlsGEQH2EloA
	mT3m6JrEbBHp0FG87i/LUw2bxVGW97dbecZdz/W/Fyn98H1SlxB2Gu4OvWAwuj8pgHMY
	sCw23W3RhFRyLgy9rmIPUfDDHLHi5L7mlt7/bzGNrvtiKEC7noZXXY3OUk3cIkFEn9WH
	S76IntHSzcR5ARAPJ84Ri/QI+l8el1LiqO3MDqNX1/nxhbk60mPsngpOTApGSE++fGJZ
	O0I59bofG2ezxLrmtPZX/BZdE0hsEIPN35E4nwDuQRR9osSnkRCF4RLWhqSXuWn2oTEz
	1o+w==
Received: by 10.224.176.70 with SMTP id bd6mr78754747qab.27.1341919055647;
	Tue, 10 Jul 2012 04:17:35 -0700 (PDT)
Received: from otp-agherzan-l1.corp.ad.wrs.com ([89.121.200.106])
	by mx.google.com with ESMTPS id f14sm43675514qak.20.2012.07.10.04.17.33
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 10 Jul 2012 04:17:34 -0700 (PDT)
From: Andrei Gherzan <andrei@gherzan.ro>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Jul 2012 14:16:48 +0300
Message-Id: <b6e8ccee34d81d6d11089a008d2d2996ed934c80.1341918809.git.andrei@gherzan.ro>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <04cbd60330fb7ae53d40956fa06feee67bc9e1cb.1341918809.git.andrei@gherzan.ro>
References: <04cbd60330fb7ae53d40956fa06feee67bc9e1cb.1341918809.git.andrei@gherzan.ro>
In-Reply-To: <cover.1341918809.git.andrei@gherzan.ro>
References: <cover.1341918809.git.andrei@gherzan.ro>
X-Gm-Message-State: ALoCoQkMqNF8yXV/1RsdCghfM1F7A/HUsyuuTXJY+og6pYuCK7+34eEoaEFhg2NiJna2CudZUOEa
Subject: [PATCH 5/5] fetch2/svn.py: Use "protocol" parameter and warn user if recipe is using "proto"
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
X-List-Received-Date: Tue, 10 Jul 2012 11:28:47 -0000

If SRC_URI uses the parameter "proto" while specifying the protocol, use this
value but warn the user about this problem.

Signed-off-by: Andrei Gherzan <andrei@gherzan.ro>
---
 bitbake/lib/bb/fetch2/svn.py |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
index bc5b96b..48adce8 100644
--- a/bitbake/lib/bb/fetch2/svn.py
+++ b/bitbake/lib/bb/fetch2/svn.py
@@ -71,7 +71,12 @@ class Svn(FetchMethod):
         command is "fetch", "update", "info"
         """
 
-        proto = ud.parm.get('proto', 'svn')
+        proto = ud.parm.get('protocol', 'svn')
+
+        if ud.parm.get('proto') is not None:
+            logger.warn('Update %s recipe to use "protocol" not "proto".', d.getVar('PN', True))
+            # Use proto value for now
+            proto =  ud.parm.get('proto')
 
         svn_rsh = None
         if proto == "svn+ssh" and "rsh" in ud.parm:
-- 
1.7.9.5



