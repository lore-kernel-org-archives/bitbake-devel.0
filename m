Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
	[209.85.192.175])
	by mail.openembedded.org (Postfix) with ESMTP id 10181721D5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 16:27:39 +0000 (UTC)
Received: by mail-pd0-f175.google.com with SMTP id y10so3335920pdj.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 08:27:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=uqX7IaSqZG+ZHPB8G+Pd8+sNmgILnYV+61pZk0c3gcA=;
	b=Xb0UWqnYTPjstmTnM1YY8SZIFkxo1KEb5JKKzkhbgmsLgLlUmem4chKSz7BfBR0WCj
	NXVKYgPGFaWpS+Z71V7u96ahTRZ8oe9ZniSWFctwF5ypKeBJTpGliAPAS1pJ0BWOu8LP
	PB/qb4X+YowyvDz+9MTfzmrJo5UD5MB3SabdG3Ofos1Gil/gfQ8/PsWV5vpytJ7+RrMN
	9pnvbQf50KpuJ4yzBocm6JTxqMJLvU+EBq8ZL526Nosi9lC2CCAbg9F+X+rgGQcybyCu
	PXR6chUN5Kbkpa2efvZTu6VxMMT0sJS/uBuYR4Bl2MAY9zzrdcmNRyZwg3dGES3lEzOg
	wncA==
X-Gm-Message-State: ALoCoQlQ49r6FlV3yLy57veIrHsfx/LhgfU3pn92pNt95IEi4WJllAAb4SEqgyouV/A1JpE1f6JT
X-Received: by 10.69.31.138 with SMTP id km10mr58096601pbd.6.1416500857984;
	Thu, 20 Nov 2014 08:27:37 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id kc15sm2503207pbb.3.2014.11.20.08.27.35
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 20 Nov 2014 08:27:36 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 83BC35641DA; Thu, 20 Nov 2014 16:27:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Nov 2014 16:27:23 +0000
Message-Id: <c2021dda953db51f59fb115542ea4a329a854f76.1416500715.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
References: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1416500715.git.alexandru.damian@intel.com>
References: <cover.1416500715.git.alexandru.damian@intel.com>
Subject: [PATCH 07/11] toaster: project page remove additional tooltip for Change pencil
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
X-List-Received-Date: Thu, 20 Nov 2014 16:27:40 -0000

From: Michael Wood <michael.g.wood@intel.com>

We have a global pencil icon tooltip so avoid two tooltips appearing by
removing them from the project page. This also means it's one less place to
update it.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/project.html | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index e1ef824..18a52bf 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -281,7 +281,7 @@ vim: expandtab tabstop=2
       </h3>
       <p class="lead" id="select-machine-opposite">
         <span>{[machine.name]}</span>
-        <i id="change-machine" class="icon-pencil" ng-click="toggle('#select-machine')" tooltip="Change"></i>
+        <i id="change-machine" class="icon-pencil" ng-click="toggle('#select-machine')"></i>
       </p>
       <div id="select-machine" style="display: none">
         <div class="alert alert-info">
@@ -318,7 +318,7 @@ vim: expandtab tabstop=2
     <h3>Project name</h3>
     <p class="lead" id="change-project-name-opposite">
       <span >{[project.name]}</span>
-      <i class="icon-pencil" ng-click="toggle('#change-project-name')" tooltip="Change"></i>
+      <i class="icon-pencil" ng-click="toggle('#change-project-name')" ></i>
     </p>
     <div id="change-project-name" style="display:none;">
       <form ng-submit="edit('#change-project-name')" class="input-append">
@@ -335,7 +335,7 @@ vim: expandtab tabstop=2
     </h3>
     <p class="lead" id="change-project-version-opposite">
       <span id="project-version">{[project.release.name]}</span>
-      <i id="change-version" class="icon-pencil" ng-click="toggle('#change-project-version')" tooltip="Change"></i>
+      <i id="change-version" class="icon-pencil" ng-click="toggle('#change-project-version')" ></i>
     </p>
     <div class="div-inline" id="change-project-version" style="display:none;">
       <form ng-submit="test('#change-project-version')" class="input-append">
-- 
1.9.1


