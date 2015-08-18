Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id 4DA0A76A67
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 16:29:14 +0000 (UTC)
Received: by wibhh20 with SMTP id hh20so113622311wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 09:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=nNB7/rlgPEE7VY+3AJh9FN3Si/YaDHgkxJ/ojW2fi3M=;
	b=h0k6SjoitZHpfJSfoQ+z68LE4c7ugrgC7ao3Tr/PA2EiFVDYa8BY2aLvXQ49ETewQF
	maeOPsfwGA7WLhSGj+NQNXRvW1V5Hp8V0aihfpf6R7YKJdX7ws+grzwXzuSLU22k+dWf
	/OO2mzNC4zK/+BldK8jz+EUbdwHYITAXUvi/S1SS27yWEdnBoYWFtcLtvwzE31LSrCDU
	Xpn/F5GKCAEprPZ1SD5bEGacXoKLqSWMPt9/RV875DgbD9KyCLFh8CHXctMmhixmq8xm
	BtDDo00FTJhpPGJ4be5O0CVPHK2vV3pKmg8Qe7whMMLZwrde8fqloN5hLTOeO66Jqrey
	iSwQ==
X-Gm-Message-State: ALoCoQmXww1FTicOSNkNIrjjOlj7ely3Ebe/wXzA6wf4RPhDN0f0oTYoYPxnDw5vxTcaCGPrQOIp
X-Received: by 10.194.172.130 with SMTP id bc2mr15688443wjc.85.1439915354341; 
	Tue, 18 Aug 2015 09:29:14 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	m4sm27105267wjb.37.2015.08.18.09.29.13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 09:29:13 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 17:28:56 +0100
Message-Id: <d6a18bfe2b98cd9dfc4f655e750dbab03c89f523.1439915029.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
	<1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
Subject: [PATCH 10/14] bitbake: toaster: fix updates on failed build requests
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
X-List-Received-Date: Tue, 18 Aug 2015 16:29:15 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

The patch to fix the original mistake is wrong, in the sense
that a constant from the BuildRequest class is used on the build
object.

Fixing the patch to bring in the correct constant in.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/management/commands/runbuilds.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index e3a1fdb..c3e9b74 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -130,7 +130,7 @@ class Command(NoArgsCommand):
         # update all BuildRequests without a build created
         for br in BuildRequest.objects.filter(build = None):
             br.build = Build.objects.create(project = br.project, completed_on = br.updated, started_on = br.created)
-            br.build.outcome = BuildRequest.REQ_FAILED
+            br.build.outcome = Build.FAILED
             try:
                 br.build.machine = br.brvariable_set.get(name='MACHINE').value
             except BRVariable.DoesNotExist:
-- 
2.1.4


