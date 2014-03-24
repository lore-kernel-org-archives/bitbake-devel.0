Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id E47206F77C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:32 +0000 (UTC)
Received: by mail-wi0-f177.google.com with SMTP id cc10so2715431wib.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=c81KYjcwvmWusnhsUdIqvTM1cUgVbxPQ9u+Fu2Aewlo=;
	b=ZCXebF22NW+hrgcf3Nqz/erBNVst15zTfARxXUq75QRQB129AzDFoF6tVU1q8g2Jsy
	qowPJnUgdA6Cor4HtNwOky0O8XrWq20P/fagQvrGUuVhZ27yLdQjeoTlYBnLgZEPN4Ek
	Rpfmod8FXTHo6DRLI+qk74u3vOB4WZViGzbfGhh/fAZKL4PPc5/oLYs0McyVmvFZ/uvR
	MYv0zHApE3OzLNm4/KzgROAip5PpQIe6WKBey2+2iywouZ802CdFYvjlbzUqO5ASeeiG
	N1xFpZbBGPTr69HddflFmZznnr08dxHYAso9FZveusksyTwFPnRBedQEBAY/r5xQV/OZ
	VjYw==
X-Gm-Message-State: ALoCoQmKVnJT7qHDa/gVNTogYEZjJTcBscnWxk1cSqswPHXLdwuTiEigbfJXvsVaxAimK2cYXSO5
X-Received: by 10.180.109.231 with SMTP id hv7mr18059364wib.38.1395686253493; 
	Mon, 24 Mar 2014 11:37:33 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id t6sm41427734wix.4.2014.03.24.11.37.30
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:31 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id B4165561135; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:14 +0000
Message-Id: <841a086822a3fa740b5651938aee6a42eba58409.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
References: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Subject: [PATCH 04/18] toaster: Change objectname 'packages' to 'packages built'
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
X-List-Received-Date: Mon, 24 Mar 2014 18:37:34 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

This will set the placeholder attribute of the search input
field in bpackage.html to the required "Search packages
built".

[YOCTO #5977]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/views.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index eaa6cf8..a4bd9d6 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1111,7 +1111,7 @@ def bpackage(request, build_id):
     packages = _build_page_range(Paginator(queryset, request.GET.get('count', 100)),request.GET.get('page', 1))
 
     context = {
-        'objectname': 'packages',
+        'objectname': 'packages built',
         'build': Build.objects.filter(pk=build_id)[0],
         'objects' : packages,
         'tablecols':[
-- 
1.8.3.2


