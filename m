Received: from mail-wi0-f171.google.com ([209.85.212.171])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei@gherzan.ro>) id 1SoiFT-0002o4-K7
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jul 2012 23:45:35 +0200
Received: by wibhq4 with SMTP id hq4so3994120wib.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2012 14:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
	:x-gm-message-state;
	bh=rBdQMvAb0TiW/4g+3TC13zlRtPFs8OKXnePPq5+g3jA=;
	b=cVjkPEtdGBLmIbQdnfTS18rQ421p9N4o8UQK2apHDs7McCp1T1CwiQ1UCgClWEJV4R
	qsUMjS+G4Gipi3lvU00a9DuDGdbp1fLvQLa/USQH8ehPlOhjS9Vdhq+ZJNXXETBHA2k6
	PhkURVMF6AH0CamKiQjWWkyppZ6MP8kpTDzWLyF7MED2Jyjt8BxNTJp2L8+XE3TF7ZL1
	Pn+07f/RZUMmCazmcBmX8y7CAb2XlzAWymRbHRNWm421zc+wTHlm/t4+WJ3AjN5LIwZS
	mEsn+UOClasWHe5gyCcw3Q3LiylPpbs9bHGAQctfw9S6HXJiJ/45sAuM8/GqZvIc65TH
	b4Xg==
Received: by 10.216.138.73 with SMTP id z51mr18719366wei.39.1341956064597;
	Tue, 10 Jul 2012 14:34:24 -0700 (PDT)
Received: from localhost.localdomain ([79.117.115.156])
	by mx.google.com with ESMTPS id bc2sm46013474wib.0.2012.07.10.14.34.23
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 10 Jul 2012 14:34:23 -0700 (PDT)
From: Andrei Gherzan <andrei@gherzan.ro>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Jul 2012 00:34:13 +0300
Message-Id: <4c68385d27450254afed6263f5140df817d7bf94.1341955881.git.andrei@gherzan.ro>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1341955881.git.andrei@gherzan.ro>
References: <cover.1341955881.git.andrei@gherzan.ro>
X-Gm-Message-State: ALoCoQmsdWjAaleXU438pe1x7P7F3EiXUsWgFpvfDswFBGDR1EwTkezqu5WKC9INPXTTKKaKWtLM
Subject: [PATCH-V2 1/5] fetch2/svn.py: Use "protocol" parameter to get the protocol
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
X-List-Received-Date: Tue, 10 Jul 2012 21:45:35 -0000

Signed-off-by: Andrei Gherzan <andrei@gherzan.ro>
---
 bitbake/lib/bb/fetch2/svn.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
index bc5b96b..ea5902e 100644
--- a/bitbake/lib/bb/fetch2/svn.py
+++ b/bitbake/lib/bb/fetch2/svn.py
@@ -71,7 +71,7 @@ class Svn(FetchMethod):
         command is "fetch", "update", "info"
         """
 
-        proto = ud.parm.get('proto', 'svn')
+        proto = ud.parm.get('protocol', 'svn')
 
         svn_rsh = None
         if proto == "svn+ssh" and "rsh" in ud.parm:
-- 
1.7.9.5



