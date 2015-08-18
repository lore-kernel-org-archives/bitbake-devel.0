Return-Path: <avery.brian@gmail.com>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
	[209.85.192.176])
	by mail.openembedded.org (Postfix) with ESMTP id 34D697689C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 22:32:25 +0000 (UTC)
Received: by pdob1 with SMTP id b1so17325617pdo.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 15:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=TDGRJ5prV03XRz4srtNJkQaIk/VaHSWYEJ2fywPNCrw=;
	b=CDSDbV4oO/lUauoZNpY/YOCgmONw08XCADqXVlH3F8OFM1pi7XxVIBMZOEIDrlacDw
	IbnBdZ7c6htVkuG+4M1KBd9U1IH/KA7pGLh4DeDs9OOpEJBsTMm1pE/nsPoI2SF84a1O
	mdNH8tmse1TjsVEzsAlU3N1cgBurZ0DBHTwgfLJxwaazj/NRaW4WumVlJkb2h5dmN723
	BrvzTzG7j7W8kswjkNFw7NJRKsEz9StWfKNOPCeglFHvhdmJW6qW1hzWMV02VHB9txtO
	2CWT/2Al+MyMMHQUTpJqtTB4Z6LuIL0f6pVobfCcbEQQym0uKL7Ey6ZLZlXJiopXqGDq
	vYBg==
X-Received: by 10.70.103.10 with SMTP id fs10mr17766084pdb.166.1439937145927; 
	Tue, 18 Aug 2015 15:32:25 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ns3sm19178388pbc.77.2015.08.18.15.32.24
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 15:32:24 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 15:32:52 -0700
Message-Id: <6c279aa715c578c0fc4074e2c5a1e3837d105293.1439937065.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1439937065.git.avery.brian@gmail.com>
References: <cover.1439937065.git.avery.brian@gmail.com>
Subject: [PATCH 1/1] toastergui: Call csrf function in all pages to ensure cookie is sent
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
X-List-Received-Date: Tue, 18 Aug 2015 22:32:28 -0000

From: Michael Wood <michael.g.wood@intel.com>

Not all pages call the csrf token template function so django does not
bother to send the cookike, this meant that all subsequent ajax calls
fail. So add this to the base template.

[YOCTO #8175]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/templates/base.html | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index d75bf16..f187100 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -69,6 +69,7 @@
 
 <body style="height: 100%">
 
+  {% csrf_token %}
   <div id="loading-notification" class="alert lead text-center" style="display:none">
     Loading <i class="fa-pulse icon-spinner"></i>
   </div>
-- 
1.9.1


