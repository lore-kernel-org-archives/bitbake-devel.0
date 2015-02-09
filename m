Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id 9033F732A2
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:09 +0000 (UTC)
Received: by mail-pa0-f42.google.com with SMTP id bj1so35363411pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=S4rUxsZbTdrkc6uy1PAeMH9cHI4vcVIxoWPDQQrPq4E=;
	b=XyZq12TB0+JCX66c57R/CwMvMyRIr+WfeclJN7wcMTnYwuv/mAZxxuLyQroh+RYKp+
	yvGrOjF7IYbvYrn+9kkPj3GVBVbNTn8516rHXGt9xQtaxG23N2DhO0DMKC4ewI9MzZGN
	B1tcDYVUhZYd6kQFJUCdjyxA173uZ5+Db0LnHZGzNPAW+HbM8y+GjgapaSrVfYVra+I3
	JY70d71zg6Z4ulV4/iu/2J9QMAa9ZZ6nzDVPeP/GhUUJZNplcQBqobxLW7Ip+dV+W4R6
	0YXMD+Trfs5zwLMDGieKk7XQ3XF2PdVOrQL6H1UkNUH0WnnFiQDK9f/rlKM1oKK2ZTEH
	RLnw==
X-Gm-Message-State: ALoCoQnLUxw7q3mfsU5Ps9M/F2JD0D+lP2PvAOYR2NGBMeosvDAhiNUshK26KJN9pXH3+Y8VYiwL
X-Received: by 10.66.62.137 with SMTP id y9mr30969178par.87.1423504930886;
	Mon, 09 Feb 2015 10:02:10 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	qz3sm17121755pab.13.2015.02.09.10.02.09
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:10 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 5DAD25661B3; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:45 +0000
Message-Id: <2c3b84f5012196c62be3ecf212e9752ee307635c.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 15/27] toaster: machines Make sure we don't overwrite the pagesize
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:09 -0000

From: Michael Wood <michael.g.wood@intel.com>

The pagesize was accidentally being over written and should be set to
the value returned from the cookie if there was one.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/views.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 641170e..9d85a93 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2778,7 +2778,7 @@ if toastermain.settings.MANAGED:
         # be able to display something.  'count' and 'page' are mandatory for all views
         # that use paginators.
         (pagesize, orderby) = _get_parameters_values(request, 10, 'updated:+')
-        mandatory_parameters = { 'count': 10,  'page' : 1, 'orderby' : 'name:+' };
+        mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby };
         retval = _verify_parameters( request.GET, mandatory_parameters )
         if retval:
             return _redirect_parameters( 'machines', request.GET, mandatory_parameters)
-- 
1.9.1


