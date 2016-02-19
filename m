Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id C63F66FFD4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Feb 2016 05:16:03 +0000 (UTC)
Received: by mail-pa0-f44.google.com with SMTP id fy10so43884525pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Feb 2016 21:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=38suuvFAtF8y8gMOn5+7+7n5BixzmT4l6xhXi6pxPvE=;
	b=0ae3ewYGUVUDL/WcGtscdYxmS6CW9G+xXBdeSDGrrCiI7pxhfibDGmrDzlDNJyUKUg
	HYrT2r3As0Xcx/YDhHdJrpjzK10/8s2aJf86pfRbkQni+T6ZF4a61EYIoc4DWNlOA9us
	05wE0GnjWeCAygbMuUNpzqMRAZEvjfq96QgojgO5BcKR02j7GcNuxO2aJ2J5UHk56Kp9
	fNH4zj3hIVSCwG8vAkFJSAW9E8pRuWrjHtX0Y3ZxCknfnbEKJTGuwtEBnPzVuHNe6Sxp
	D/dvYGzTsC2VfX0jfXqMuf27PNBP0vjEXl9E15SCbYE5fOmjYAhHDIu2RGrfZiQWsPfn
	+cLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=38suuvFAtF8y8gMOn5+7+7n5BixzmT4l6xhXi6pxPvE=;
	b=bxrNltsr124cN6mXWa0dV4OUk7RTiPpV7R6iX1WZ10xpTAAcnS3T7I0LlHil2JWybs
	2+8MbTpjHzFBFKD1tSD4Iu0s8OvZNeFOWkx7W+DSfAfSU147tnMBhs8iMVKz75C47i1S
	YPPGMst6j5JBoQT4i00jXDRymxwQoxjpK8ady75yxsrenqcGZ/gREr7C4JCxBrCH3235
	SsNcZ+WzfM335Yhhfr7UmQJp9jYGR3AzFyH+25WNJjPBz5SbpMzV30qMtO6XlfoAmdTo
	En0bQjN6qVCXIS2qhnGM+AiFR6A2FgAiBn0sOYJH9mgBW4qhei02Moz24ko+VHO2FtLG
	tHng==
X-Gm-Message-State: AG10YOStqCK+PfUaI/ddcuNyD+fIJGAMagJ/tmY5ukNw12BxIuqXc/Evv/LZqpkkWrRRPw==
X-Received: by 10.66.251.194 with SMTP id zm2mr15619757pac.131.1455858964519; 
	Thu, 18 Feb 2016 21:16:04 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ml5sm13317073pab.2.2016.02.18.21.16.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 18 Feb 2016 21:16:03 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Feb 2016 21:21:51 -0800
Message-Id: <5c14658a09dcca155d62c9f94c5da413cb180454.1455859137.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1074d09d9af22d962880d1ba7791b85eecfeac08.1455859137.git.avery.brian@gmail.com>
References: <1074d09d9af22d962880d1ba7791b85eecfeac08.1455859137.git.avery.brian@gmail.com>
In-Reply-To: <cover.1455859137.git.avery.brian@gmail.com>
References: <cover.1455859137.git.avery.brian@gmail.com>
Subject: [PATCH 4/5] toaster: PackagesTable show only installed packages
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
X-List-Received-Date: Fri, 19 Feb 2016 05:16:03 -0000

From: Michael Wood <michael.g.wood@intel.com>

When showing the package list for the image recipe details only show the
packages which are installed in the image rather than all the packages
which are produced.

[YOCTO #9108]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/tables.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 5a589d3..c0ad2b7 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -654,7 +654,9 @@ class PackagesTable(ToasterTable):
                                       ).last()
 
         if target:
-            return target.build.package_set.all()
+            pkgs = target.target_installed_package_set.values_list('package',
+                                                                   flat=True)
+            return Package.objects.filter(pk__in=pkgs)
 
         # Target/recipe never successfully built so empty queryset
         return Package.objects.none()
-- 
1.9.1


