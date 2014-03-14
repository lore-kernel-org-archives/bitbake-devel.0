Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com
	[74.125.82.178])
	by mail.openembedded.org (Postfix) with ESMTP id A3BB66F7E4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:02 +0000 (UTC)
Received: by mail-we0-f178.google.com with SMTP id u56so2445771wes.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=UffttgOG7vi+HIxtNDfw9n+gN2bbQU8aIrbHYubYeCQ=;
	b=KiVclDf/erfGOJc+czdj72zy7UvPtI+8jztE1vt7MgZYPRHjhAKB3CrN39aSZBmVsE
	Erby5utV36W1aX0lFox6w1i8EaomyFvj1PnT+l4rXmwBrEnsDN97PtQRqIGA/8ccL4CL
	edSRt3SQVzb4zgRzSSlPKT8srkoZFGSegWSSYnrBJlEiMbklsSgfb8IuiKF5eyJzqCjV
	Ph9yiANvJydhGNUs9lsASyKbbt0C+0ktuTNC/7fpJsMQGrrJIJRQ/Tjcpl/n0D3lccc/
	ff8NBved72/3vKU5C4wxuUPI5j2lB16+O+jq7SP+bozNDP503uiL6Q93KDzF0OlwcK0l
	EdQA==
X-Gm-Message-State: ALoCoQnpKNNLhKLsD/sMY0IA5L9a/BcImiiQG8a8BGfMwFVH/A01syhfB3B35nvaZsuuWUmyZwCL
X-Received: by 10.180.79.7 with SMTP id f7mr7344303wix.20.1394819942954;
	Fri, 14 Mar 2014 10:59:02 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	qg3sm36758902wic.10.2014.03.14.10.59.01 for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:01 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 0FA9B561087; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:46 +0000
Message-Id: <018db5cf683755a7a41b0ef491e130809e1ff003.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Subject: [PATCH 05/19] toaster: Format package size in recipe.html
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:04 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Package sizes in the recipe details page (recipe.html)
were displaying in bytes. Apply the filtered_filesizeformat
project tag to show the package size in a more human
readable format.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/recipe.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/toastergui/templates/recipe.html
index 29c9728..716ddfa 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -159,7 +159,7 @@
                     <tr>
                         <td><a href="{% url "package_built_detail" build.pk package.pk %}">{{package.name}}</a></td>
                         <td><a href="{% url "package_built_detail" build.pk package.pk %}">{{package.version}}_{{package.revision}}</a></td>
-                        <td><a href="{% url "package_built_detail" build.pk package.pk %}">{{package.size}}</a></td>
+                        <td><a href="{% url "package_built_detail" build.pk package.pk %}">{{package.size|filtered_filesizeformat}}</a></td>
                     </tr>
 
                     {% endfor %}
-- 
1.8.3.2


