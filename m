Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
	[209.85.192.170])
	by mail.openembedded.org (Postfix) with ESMTP id C9F5A739BB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 10:25:37 +0000 (UTC)
Received: by pdbni2 with SMTP id ni2so105050425pdb.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 03:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=SRLaMuUWtNoX77XAlLajZisiWyaFfT9iDKWtn6Z7Qjo=;
	b=RR6F8P8m7uiIAX6kwoMfgAbgJh3kN5H6QUk7fN0NCASLd+/vtaWsk3m7F6D8AXfslf
	XuY3/Wh1UWxXwD6UkUHPXZ+5ktAFioCLuosiwrbYe20k1tgsZ05vfYSMgsyTmItPJBNK
	NmB6pWrSuSrMP1B5mOiPAqDjXf2Lx21UfRFRGmVL91XsiXKCISdnIqGBEavmAK9ZOgJC
	DzietY83KUrr9x8h/DCcEeESYiQHgg91fD82TYXaXY1vMk6t13Sp7cS0H5YbQnqDZZRP
	NWtJ9cWqbISrNypQBD7FbHbmJ/iyuYavY5UFEZyIip6F3e1A7JZ5vsKC1n0s2UeGIzDt
	jHtA==
X-Gm-Message-State: ALoCoQnmhDnQzgfIbMiofjHnDSiPuZz3MkfTbSH7KZcP0Fx9ufiKDkHv+Hlh+TpXgPzu4aHpgYO/
X-Received: by 10.66.142.228 with SMTP id rz4mr187864769pab.86.1426847139218; 
	Fri, 20 Mar 2015 03:25:39 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id w1sm7426020pdp.25.2015.03.20.03.25.38
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 20 Mar 2015 03:25:38 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B1141564212; Fri, 20 Mar 2015 10:25:32 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Mar 2015 10:25:22 +0000
Message-Id: <a12650090422391c99d2764a5d97f1a30d7419ed.1426598797.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
References: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426598797.git.alexandru.damian@intel.com>
References: <cover.1426598797.git.alexandru.damian@intel.com>
Subject: [PATCH 05/14] toastergui: builds and projects outcome filter
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
X-List-Received-Date: Fri, 20 Mar 2015 10:25:39 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes the Outcome filter in the all builds and
all projects pages in Build mode.

[YOCTO #7450]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index fa34e56..e87c9f2 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1924,8 +1924,8 @@ if toastermain.settings.MANAGED:
                      'filter' : {'class' : 'outcome',
                                  'label': 'Show:',
                                  'options' : [
-                                             ('Successful builds', 'state:' + str(BuildRequest.REQ_COMPLETED), queryset_all.filter(state=str(BuildRequest.REQ_COMPLETED)).count()),  # this is the field search expression
-                                             ('Failed builds', 'state:'+ str(BuildRequest.REQ_FAILED), queryset_all.filter(state=str(BuildRequest.REQ_FAILED)).count()),
+                                             ('Successful builds', 'build__outcome:' + str(Build.SUCCEEDED), queryset_all.filter(build__outcome = Build.SUCCEEDED).count()),  # this is the field search expression
+                                             ('Failed builds', 'build__outcome:NOT'+ str(Build.SUCCEEDED), queryset_all.exclude(build__outcome = Build.SUCCEEDED).count()),
                                              ]
                                 }
                     },
-- 
1.9.1


