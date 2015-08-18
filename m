Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
	[209.85.220.53])
	by mail.openembedded.org (Postfix) with ESMTP id 2C5997689C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 22:11:11 +0000 (UTC)
Received: by pacgr6 with SMTP id gr6so141524456pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 15:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=TDGRJ5prV03XRz4srtNJkQaIk/VaHSWYEJ2fywPNCrw=;
	b=pHU33/su65+8l+tGmaymk12wQg4H5sQwD0EGBZhEgWOyDtwgVE2mQAfPC7+P5hWxHr
	xmBwSfoZMx+JaYlmW+EL3alRQhPfGRB3NDGRzj+o7bSjq+z9ldW3j6ltcTN+bgnsXGD8
	qTmCv55inFT2TDRA1+gX/raOYsUWvKQFGEVbOO4ob6HruS9o0SWdf4tjTjiAUVKHtlWo
	Z94eWIxUkQmPStqdITtJN8mwUY2wmb7d/BVjvqdYiCjg/qEguthFw/4A6wLrAQDclO43
	GBJ9cuw2gCtXNVYeBQOa3GhnxuysvU73riNtFcVC2ZDkiXEf4CxFtZaduC9munmMMULo
	Tp9Q==
X-Received: by 10.66.175.162 with SMTP id cb2mr14062162pac.91.1439935871894;
	Tue, 18 Aug 2015 15:11:11 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id c2sm9050413pds.56.2015.08.18.15.11.10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 15:11:11 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 15:11:30 -0700
Message-Id: <f87bc73e473e8b69734b18d5fb7512af90ed7a49.1439935538.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1439935538.git.avery.brian@gmail.com>
References: <cover.1439935538.git.avery.brian@gmail.com>
Subject: [PATCH 1/1] bitbake: toastergui: Call csrf function in all pages to ensure cookie is sent
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
X-List-Received-Date: Tue, 18 Aug 2015 22:11:12 -0000

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


