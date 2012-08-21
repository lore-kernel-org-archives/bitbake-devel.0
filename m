Received: from mga06.intel.com ([134.134.136.21] helo=orsmga101.jf.intel.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ross.burton@intel.com>) id 1T3rz6-0001YI-Su
	for bitbake-devel@lists.openembedded.org;
	Tue, 21 Aug 2012 19:11:21 +0200
Received: from mail-wi0-f178.google.com ([209.85.212.178])
	by mga02.intel.com with ESMTP/TLS/RC4-SHA; 21 Aug 2012 09:17:06 -0700
Received: by wibhr14 with SMTP id hr14so3889001wib.13
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Aug 2012 09:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
	:x-gm-message-state;
	bh=58XbP6qU2Zwv1RqmFYRlpTJAs1tzlFXwR3zi9p8VGx8=;
	b=j3Gs7I9OgTDZtGoXLrHm2MaBdJHBCqqqmTV8go8Z8jYMv619lJyAnKHxtriaWBUs4c
	sThz4ubHgKl8icmq1KkKoPPYFAYYBbYUlBAA3KqzCF8yjFtyx6gcDh4ulQpLxtImr/es
	PTA0gV9Hv67J082TPKtRdc2qvIl3Lscu9cpC2Q6Tv1JSAP36R4n7Km1mnB7zQ5iJ7+nu
	Gg+dhTgejaA9PbDe6iQYxqYqjo9x4nAgqPPwVyWT4VN3tzHpOzFxEfR0A/UI3byfUK7s
	7JRptMTOlgbqMXGmHCuF+BO/2xsvKopXcBMCfPhR/4kU3fgVbZMTSz1DgEcBAG5VcjeU
	DPOA==
Received: by 10.180.82.230 with SMTP id l6mr37599581wiy.21.1345565825130;
	Tue, 21 Aug 2012 09:17:05 -0700 (PDT)
Received: from melchett.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
	by mx.google.com with ESMTPS id t8sm34286920wiy.3.2012.08.21.09.17.03
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 21 Aug 2012 09:17:04 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Aug 2012 17:16:26 +0100
Message-Id: <1345565786-23409-2-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1345565786-23409-1-git-send-email-ross.burton@intel.com>
References: <1345565786-23409-1-git-send-email-ross.burton@intel.com>
X-Gm-Message-State: ALoCoQkwDyIfv4sjtP2m9SKrRG8jVNP9uG9o4gHEd7SQ/ZzVK6wPU7M+E7QQuaAy/rat0YxFLFj4
Subject: [PATCH 2/2] data_smart: skip all interal (underscored) flags in getVarFlags
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
X-List-Received-Date: Tue, 21 Aug 2012 17:11:21 -0000

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/data_smart.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index dbfcefb..f5f3b13 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -379,7 +379,7 @@ class DataSmart(MutableMapping):
 
         if local_var:
             for i in local_var:
-                if i == "_content":
+                if i.startswith("_"):
                     continue
                 flags[i] = local_var[i]
 
-- 
1.7.10



