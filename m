Return-Path: <armccurdy@gmail.com>
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com
	[209.85.213.175])
	by mail.openembedded.org (Postfix) with ESMTP id 700976ABF7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 23:04:07 +0000 (UTC)
Received: by igbyr2 with SMTP id yr2so1435427igb.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 16:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=3cZXPAC7rGcLoWkYfqkMBXPiIEWsGjLeROzs5kgzTt4=;
	b=VAOOGnU6ZrQKtyPdV84HQyyNDFVh+zFUhFWtTP3JxmQeMEm4/FM6lmJ0PT2mk6OVO/
	rkkXAGrms+RlIVecTEsQvLDxT0U1ozd6JkGMFc2jQIsqqT2PA8O6Pxk+YBqDmAfpMDF6
	Z7c8vwqgvE++367zl9/7cKAq1VtGWJK5dsgMWG3d4APtJhq97xuIU+reVKDxlnpS7mTf
	RyD3FTbpU4qfSXnM3ayMMAurXZfIWHnJ0/szsoIwTiqgguMehXWxU5CQl4BMsxxTnYzw
	jJfyaONSzlW3+SIkeDJ3ae5AgC+HYzffzjhYve3XosY4mg9oMLsvtDHXK2qfGOcsgCxl
	Q8RQ==
X-Received: by 10.107.169.160 with SMTP id f32mr143451ioj.83.1429225448708;
	Thu, 16 Apr 2015 16:04:08 -0700 (PDT)
Received: from e6520.cablelabs.com
	(50-204-102-64-static.hfc.comcastbusiness.net. [50.204.102.64])
	by mx.google.com with ESMTPSA id r39sm5265331ioi.2.2015.04.16.16.04.07
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 16 Apr 2015 16:04:07 -0700 (PDT)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Apr 2015 16:03:50 -0700
Message-Id: <1429225430-4409-1-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] toastergui: minor spelling fixes
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
X-List-Received-Date: Thu, 16 Apr 2015 23:04:09 -0000

  RRECOMENDS -> RRECOMMENDS
  TRECOMENDS -> TRECOMMENDS

Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
---
 lib/toaster/toastergui/views.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index be59c83..06c7dd5 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1554,7 +1554,7 @@ dependencies.  The return value is a dictionary consisting of two other
 lists: a list of 'runtime' dependencies, that is, having RDEPENDS
 values in source package's recipe, and a list of other dependencies, that is
 the list of possible recipe variables as found in OTHER_DEPENDS_BASE plus
-the RRECOMENDS or TRECOMENDS value.
+the RRECOMMENDS or TRECOMMENDS value.
 The lists are built in the sort order specified for the package runtime
 dependency views.
 """
-- 
1.9.1


