Return-Path: <armccurdy@gmail.com>
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com
	[209.85.223.170])
	by mail.openembedded.org (Postfix) with ESMTP id 3871E6E648
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Jul 2015 00:22:23 +0000 (UTC)
Received: by ieik3 with SMTP id k3so22978436iei.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jul 2015 17:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=vC/uIe5XRUEnlGqw60XeYUU10Iee3a4bt0/KGKNqGnw=;
	b=h+O71lN9ef1zZmsUeJXjSlQlqQGVG2k076plFgf38J3shfLWjMnAEMKIGBOCPo/ID9
	a5sFJqoOTletrASYQdzgK3a7N85CbWm7KRq5Z13SATQep0URw7ZTRFmAo4wc4Kj5Uzc/
	agvqRj1i08c2MbyeE3yDnq2f/ar/7xBmdKC24wlpSddMWJEKsMzdlS6SsELNLaIYU/MJ
	SFPKlOGRgiAREY9VUqWGgWrmI6I/73aseHSwN1r6y179FDvl3d+F86YhRnHrcZntG2qV
	aCfXYU6v8jWvOSmghTcUDH7UAzGA3cBP9zc8SpNRqCgT5zQTzKIVYIF074mdQtSKzfCH
	9GzQ==
X-Received: by 10.107.138.102 with SMTP id m99mr1602368iod.115.1436919743722; 
	Tue, 14 Jul 2015 17:22:23 -0700 (PDT)
Received: from e6520.cablelabs.com
	(50-204-102-64-static.hfc.comcastbusiness.net. [50.204.102.64])
	by smtp.gmail.com with ESMTPSA id
	l62sm1668698iol.36.2015.07.14.17.22.22
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 14 Jul 2015 17:22:23 -0700 (PDT)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Jul 2015 17:22:17 -0700
Message-Id: <1436919737-5705-1-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] data: Add newline after the last export in emit_func
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
X-List-Received-Date: Wed, 15 Jul 2015 00:22:29 -0000

Minor formatting improvement in generated shell scripts.

Add a newline after the last export emitted by emit_func. Also, remove
chance of putting an extra newline in the middle of the exports, since
we never want to do that.

Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
---
 lib/bb/data.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 8b21c46..2f90be6 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -271,8 +271,9 @@ def emit_func(func, o=sys.__stdout__, d = init()):
 
     keys = (key for key in d.keys() if not key.startswith("__") and not d.getVarFlag(key, "func"))
     for key in keys:
-        emit_var(key, o, d, False) and o.write('\n')
+        emit_var(key, o, d, False)
 
+    o.write('\n')
     emit_var(func, o, d, False) and o.write('\n')
     newdeps = bb.codeparser.ShellParser(func, logger).parse_shell(d.getVar(func, True))
     newdeps |= set((d.getVarFlag(func, "vardeps", True) or "").split())
-- 
1.9.1


