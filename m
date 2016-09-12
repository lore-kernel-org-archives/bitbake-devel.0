Return-Path: <ulfalizer@gmail.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail.openembedded.org (Postfix) with ESMTP id 9FA1773289
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 20:17:00 +0000 (UTC)
Received: by mail-wm0-f66.google.com with SMTP id g141so4232900wmd.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 13:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=u37GVM/5EmDtLtT/qkOGv24tkFKLqn8I3rAZcmQKjQU=;
	b=rK1jizNOYpoNinUWv0UxOUA0XuR++lI8mQ0up6EMeKMo9bkmrJSVqqGSrc9shQe/uJ
	XNeLdsETBgyDe5Lh3QVVY89A6M2l3BWPHZCjeiXhYUVC/1yd7F5HURsW/rduK3Opp2SP
	urvC0sv/OVU48Nf9/jZENmo2XeWgmM+N4JQ6bgUYArk4j997IASwSiBscjhEXkoo4Rd9
	zSyRzb8NfnHr5XUVtyl+gxhSguc4hhkI4AU9Zvdv7jVKKwX9Umo4GKy19KAGZ7zSOrh4
	S+h+oJSCKOXheY2hjomJ9AjnzH8y1YWLTfF9preYHS6A3KSyZMdrTInFrG5T/+uUeACn
	7rUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=u37GVM/5EmDtLtT/qkOGv24tkFKLqn8I3rAZcmQKjQU=;
	b=hvZFMZTJ6ABmIAonmvkmuiOATx+1LBc4oARwArZJqVxWDPaNnEYQ1UPL4PszLmPUai
	vCGu+d5E3pIn8G7fZHNQATgOBOEkEtl16sPrDp93bmYQwVr+MhcrU8pH2WB7heDLgn+L
	ZSVEkoelbyJqateTkYR6DPfULa6/0HF9aR2cDFHB7k4eZpItYFs5pUXqi4ffxS9f7qUX
	SE/wVA5atfz2/gOKvayqXORbt4JcV+Vekme/UmSrTR87Gl89V/N1ImjoOHjss9geODm8
	k911vSaM/0XxSF1cCWe389SAvcADyTle1NqO3ZMjC5QnLZOyMsH5zvGkFeEw+QjkSVVX
	iN6A==
X-Gm-Message-State: AE9vXwOM96H71YdvEY0n/58HhExwU1mhFT2BF4yvNQDJBAN7GXUxQ0dkXJeCw9TIX0lqlA==
X-Received: by 10.28.91.12 with SMTP id p12mr2313517wmb.34.1473711420611;
	Mon, 12 Sep 2016 13:17:00 -0700 (PDT)
Received: from huvuddator.home (ip5f5bfeac.dynamic.kabel-deutschland.de.
	[95.91.254.172]) by smtp.gmail.com with ESMTPSA id
	ka5sm19463606wjb.7.2016.09.12.13.16.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 12 Sep 2016 13:17:00 -0700 (PDT)
From: Ulf Magnusson <ulfalizer@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Sep 2016 22:16:52 +0200
Message-Id: <1473711412-22161-1-git-send-email-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.5.0
Subject: [PATCH] bitbake: fetch2: Make SRCREV_FORMAT name substitution safer
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 12 Sep 2016 20:17:01 -0000

Given two names "foo" and "foobar" and SRCREV_FORMAT = "foo_foobar",
"foo" might currently get substituted twice. Work around the issue by
sorting the list of names by length and substituting longer names first.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 11c75cc..4ca024e 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -764,7 +764,10 @@ def get_srcrev(d, method_name='sortable_revision'):
     seenautoinc = False
     for scm in scms:
         ud = urldata[scm]
-        for name in ud.names:
+        # Sort the list of names and replace the longest names first. Given two
+        # names "foo" and "foobar", this prevents "foo" being substituted twice
+        # in "foo_foobar" (and "foobar" from not being substituted at all).
+        for name in sorted(ud.names, key=len, reverse=True):
             autoinc, rev = getattr(ud.method, method_name)(ud, d, name)
             seenautoinc = seenautoinc or autoinc
             if len(rev) > 10:
-- 
2.5.0


