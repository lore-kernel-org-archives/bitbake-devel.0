Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f54.google.com (mail-wg0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id C6CC373D56
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 14:47:42 +0000 (UTC)
Received: by wgyo15 with SMTP id o15so83620240wgy.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 07:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=dfFS+NZ8R0LQQbjzYysaB6g0NYD6p9eT2hs1Xaq19ag=;
	b=Hs+dLfANZJPpQO1EoruiaXA5IaufMCIa60q6au77dgyP9khYBV3LMPLdzOoxVWPySo
	cdmauAeuWjgXkJJQKg5lAEJCUAgUWlIbL0L7C/y1mVMUQFEpA22OKxIApYHrR/MRFku+
	Uc7HcIW3a8droXzxv/L++v7+yk9wltuSnWkD1rO/xXvv2nQsm4LFmpB3g6AtfIqCM8dd
	1d4BxNDyRSmpG6+wNN9eKWpQULMlXCrWy9CgXyFfbgvqUtlE30WBi1q3sRK0qMpCRAgq
	HrfU9b8qn0kXexGiQQtAoKfswartHWQsCH9wRMPsMMNtg6kcM8CpJZXlH4J2+u/uF5iG
	xH0g==
X-Gm-Message-State: ALoCoQnDZFxVmGGLzM3tUaixEFXkRf3aFFYL3waXyibdm5EopM1chcVj7zhZmT4M6bqXoy+rxJBc
X-Received: by 10.180.106.73 with SMTP id gs9mr5045276wib.52.1429195663439;
	Thu, 16 Apr 2015 07:47:43 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ew10sm14287658wic.22.2015.04.16.07.47.41
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Apr 2015 07:47:41 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C53DF560CE2; Thu, 16 Apr 2015 15:47:41 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Apr 2015 15:47:38 +0100
Message-Id: <da1f40aa83b972d18a7713888a34507c240effc8.1429195580.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <e4e9f956e8370ba543578054ea7e889a9f689632.1429195580.git.alexandru.damian@intel.com>
References: <e4e9f956e8370ba543578054ea7e889a9f689632.1429195580.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1429195580.git.alexandru.damian@intel.com>
References: <cover.1429195580.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 5/8] toaster: searching all projects table resets page count
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
X-List-Received-Date: Thu, 16 Apr 2015 14:47:43 -0000

From: David Reyna <David.Reyna@windriver.com>

Add missing '_save_parameters_cookies' to preserve page count.

[YOCTO #7483]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/views.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index be59c83..500834c 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -3330,7 +3330,10 @@ if toastermain.settings.MANAGED:
                     },
                     ]
             }
-        return render(request, template, context)
+
+        response = render(request, template, context)
+        _save_parameters_cookies(response, pagesize, orderby, request)
+        return response
 
     def buildrequestdetails(request, pid, brid):
         template = "buildrequestdetails.html"
-- 
1.9.1


