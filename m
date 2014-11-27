Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id 69F9C723C4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 17:08:15 +0000 (UTC)
Received: by mail-wi0-f181.google.com with SMTP id r20so8972155wiv.8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 09:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=WHYKJcC3VMWHy+aL/EOvacnn0viSAEOn2CZG3+iGEg0=;
	b=L27VadZumsP5jV1/AoyD2+44TpQhy66tD9dVEjoLUZyOVwpZiFBFgkyPqd/zamYYCo
	h69oPe8oyHu2A5WV5cA0y2AOz37ID1PIklauYLLhdIC+a6y1RYdATxWYGiaJme3n8gRH
	TZCZaPKt8OH5Ow+ovgFXGDBtm5s1WszMlZef3Si7wvZSWvuf6lF/lfvbYT4kXybieHnw
	pgbQxSDqLzujOIjQm2AsEvPTTtATzZLmziZbtexiNUh7H0yShgVxzHYRgUqQMbodQy8K
	MFcLKsy0NC5lPAT7G/L1Qku23pMNCW/G88arS71aVwFUZusfx4x3WZBUkD1BQN8dwo6q
	SB0w==
X-Gm-Message-State: ALoCoQm/0oMtl62w9hPfByp1g8puF/9ZScNmp09bZitiBgRm31rZLKv9d7xohvMMcbn5ULcXIC8C
X-Received: by 10.180.8.34 with SMTP id o2mr51779161wia.23.1417108095946;
	Thu, 27 Nov 2014 09:08:15 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ep6sm5894398wib.0.2014.11.27.09.08.11
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 27 Nov 2014 09:08:14 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 133A2564225; Thu, 27 Nov 2014 17:08:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 17:08:05 +0000
Message-Id: <1bf19f66260aaca2caa300e976bf90479e2c48f3.1417107946.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
References: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1417107946.git.alexandru.damian@intel.com>
References: <cover.1417107946.git.alexandru.damian@intel.com>
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 14/14] toaster: remove the word 'project' from layers and machine
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
X-List-Received-Date: Thu, 27 Nov 2014 17:08:15 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

Remove the word 'project' from the 'Layers' and 'Machine'
sections of the project page, following feedback from the
QA team, who suggested that the word 'project'
raised questions regarding the scope of the configuration,

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
---
 lib/toaster/toastergui/templates/project.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index fdfc3af..113e382 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -227,7 +227,7 @@ vim: expandtab tabstop=2
     <!-- project layers -->
     <div id="layer-container" class="well well-transparent span4">
       <h3>
-        Project layers <span class="muted counter">({[layers.length]})</span>
+        Layers <span class="muted counter">({[layers.length]})</span>
         <i class="icon-question-sign get-help heading-help" title="OpenEmbedded organises metadata into modules called 'layers'. Layers allow you to isolate different types of customizations from each other. <a href='http://www.yoctoproject.org/docs/current/dev-manual/dev-manual.html#understanding-and-creating-layers' target='_blank'>More on layers</a>"></i>
       </h3>
       <div class="alert" ng-if="!layers.length">
@@ -292,7 +292,7 @@ vim: expandtab tabstop=2
     <!-- project configuration -->
     <div id="machine-distro" class="well well-transparent span4">
       <h3>
-        Project machine
+        Machine
         <i class="icon-question-sign get-help heading-help" title="The machine is the hardware for which you want to build. You can only set one machine per project"></i>
       </h3>
       <p class="lead" id="select-machine-opposite">
-- 
1.9.1


