Received: from mail-qa0-f54.google.com ([209.85.216.54])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei@gherzan.ro>) id 1SoYcM-0006TZ-OT
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jul 2012 13:28:35 +0200
Received: by mail-qa0-f54.google.com with SMTP id t11so45791qaa.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2012 04:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
	:in-reply-to:references:x-gm-message-state;
	bh=7xAzFIOIom51tUSGF/5kxOmuLnYjqEj5dMetrzEUmGY=;
	b=ASOd79wWQmT9X0NKp/xgQWPtrluKbpLxIVtLLl50xByKUkD+NK8Yaw+SOYkrL1owNE
	smNYGql8BJjERWVgKAsvvriXgiAPbU1Wuu4fIquL9ivmvCrTh4317gcQhUfReysxz6mN
	8EJACdBMVf+lQkgdQCWXHE71ZSAF5fUg/u62QqiimH/ElO7vIY9vlbdRgvCQBhBo/r4f
	mmmzbnoPaMJKUdLLlNOJ9n0m1ZyjL+ejuP24mJkGPdW8PvsOiTPJv3iOxnws5LmVYYNf
	Tl/kIg5aMRZsUoYpVDC/hxNj5EB0OZrL9vRgjf7fWWchQO+Qax0RMAmTjRZDZ2L+NRw2
	xUZw==
Received: by 10.229.105.140 with SMTP id t12mr22251148qco.18.1341919019880;
	Tue, 10 Jul 2012 04:16:59 -0700 (PDT)
Received: from otp-agherzan-l1.corp.ad.wrs.com ([89.121.200.106])
	by mx.google.com with ESMTPS id f14sm43675514qak.20.2012.07.10.04.16.58
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 10 Jul 2012 04:16:59 -0700 (PDT)
From: Andrei Gherzan <andrei@gherzan.ro>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Jul 2012 14:16:46 +0300
Message-Id: <f597d06bf1b2146f1321d3779951776038137048.1341918809.git.andrei@gherzan.ro>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <04cbd60330fb7ae53d40956fa06feee67bc9e1cb.1341918809.git.andrei@gherzan.ro>
References: <04cbd60330fb7ae53d40956fa06feee67bc9e1cb.1341918809.git.andrei@gherzan.ro>
In-Reply-To: <cover.1341918809.git.andrei@gherzan.ro>
References: <cover.1341918809.git.andrei@gherzan.ro>
X-Gm-Message-State: ALoCoQmW9SEhXZgLMxhcWXiopDF0knGmbBjnkDMIv9jIj2S4DvKHM+s5b0nfnzPtEiu2YfwOkiyd
Subject: [PATCH 3/5] fetch2/hg.py: Use "protocol" parameter and warn user if recipe is using "proto"
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
X-List-Received-Date: Tue, 10 Jul 2012 11:28:35 -0000

If SRC_URI uses the parameter "proto" while specifying the protocol, use this
value but warn the user about this problem.

Signed-off-by: Andrei Gherzan <andrei@gherzan.ro>
---
 bitbake/lib/bb/fetch2/hg.py |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index ad6e85d..31ba1cf 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -82,7 +82,12 @@ class Hg(FetchMethod):
 
         basecmd = data.expand('${FETCHCMD_hg}', d)
 
-        proto = ud.parm.get('proto', 'http')
+        proto = ud.parm.get('protocol', 'http')
+
+        if ud.parm.get('proto') is not None:
+            logger.warn('Update %s recipe to use "protocol" not "proto".', d.getVar('PN', True))
+            # Use proto value for now
+            proto =  ud.parm.get('proto')
 
         host = ud.host
         if proto == "file":
-- 
1.7.9.5



