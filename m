Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id 668FE73D56
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 14:47:41 +0000 (UTC)
Received: by widdi4 with SMTP id di4so197756847wid.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 07:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=IsWX0omeJNkJOMWplVr0Mmx9hY25EwhmFxFUOAgytoE=;
	b=FJxkbAoRomfLOHjG30Q6cA1S551PHszAnW1Yfk2c+Zh83JZ7yR1nE6vHv6ZqKH+sNN
	0sBiSRMm0NV+iBueRrG1y0PMg1BWiI+qMShrdixqCUjKA99k3cZt8iApBxropvS8lLTS
	Azf4Lk39FmhAqoneX6gpvsKq0Knlq+ExZ6q90hBGBN82p8rPPIHdL/f4BHQw1CLkVzHg
	DYbUl096qSNCwd5V2d99/Y+XtFcJ6bixdUc/NtlhRN/xJg8Boo1bVbLZzsv2SlVElG2O
	YMXBtWY2LwVM2BspCVTaUGXuGnCiwEKGKBAYq2iG7k5j0nB7tNeGCVG7ZDiqDtkAdtQd
	rytQ==
X-Gm-Message-State: ALoCoQluyNtMRJqqaYdPLBN5hoDhm0Z/oiBi2ZpkWZDCJ1ahXoAbf48F9J+BeEEY8wLI84+cLUcI
X-Received: by 10.194.61.133 with SMTP id p5mr62394415wjr.132.1429195662766;
	Thu, 16 Apr 2015 07:47:42 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	hw7sm10713230wjb.24.2015.04.16.07.47.41
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Apr 2015 07:47:41 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id BFD7D560A93; Thu, 16 Apr 2015 15:47:41 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Apr 2015 15:47:36 +0100
Message-Id: <bcce829302a69c6b322053d72af741ca97048843.1429195580.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <e4e9f956e8370ba543578054ea7e889a9f689632.1429195580.git.alexandru.damian@intel.com>
References: <e4e9f956e8370ba543578054ea7e889a9f689632.1429195580.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1429195580.git.alexandru.damian@intel.com>
References: <cover.1429195580.git.alexandru.damian@intel.com>
Subject: [PATCH 3/8] toasterui: correct terminology in landing page
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
X-List-Received-Date: Thu, 16 Apr 2015 14:47:42 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Change the introductory description of Toaster
we provide on first use, to make sure it mentions
all the bits that make up the build system, and
not just BitBake.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/landing.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/landing.html b/lib/toaster/toastergui/templates/landing.html
index 5bbe694..4af849c 100644
--- a/lib/toaster/toastergui/templates/landing.html
+++ b/lib/toaster/toastergui/templates/landing.html
@@ -15,7 +15,7 @@
        <h1>
         This is Toaster
        </h1>
-       <p>A web interface to <a href="http://www.yoctoproject.org/tools-resources/projects/bitbake">BitBake</a>, the <a href="http://www.yoctoproject.org">Yocto Project</a> build system.</p>
+       <p>A web interface to <a href="http://www.openembedded.org">OpenEmbedded</a> and <a href="http://www.yoctoproject.org/tools-resources/projects/bitbake">BitBake</a>, the <a href="http://www.yoctoproject.org">Yocto Project</a> build system.</p>
 
 	{% if MANAGED %}
 
-- 
1.9.1


