Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id DE75C72366
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 11:45:25 +0000 (UTC)
Received: by mail-wi0-f172.google.com with SMTP id n3so2188060wiv.17
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 03:45:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=AnryVnyJAHT9CSs0ZllgrsuhMsj51KL5mrpJM58F6jE=;
	b=Jqwu9UXyXFcL3M8MVwXRAbGwYvy8qetGhudq58racoARkDMfbeNA3YA3QfeKmod8JU
	lejCP2/t4Sia08/MXOCjysWpXGUqnmycucO9DRJdGRkDj9cSgqHmoziVC8VB2rFqZSA5
	cQgm3/lbWZd5n58KHo7+s/Pndo5WyTOgYV3WCoApbx4D8YRkXWgrHTNQZt4qTNbiEd7Z
	yzRWgyT0YiR/obeGnW7lXHSuJQcLgp7+Xygwz8jd6oevZGGLsDuNYJsUIhz5ag1Pwfrq
	i+NYa0jINux2rrbP0KFRqv2N+GfPFaHcpjf+pOAvMthAUx12Io3KlpY+kX1KnoVRcmQG
	Gm1Q==
X-Gm-Message-State: ALoCoQnbQgdj9Jp/yRlVleGx2V4ZR9+SNrBbNDT6aTRtsRCOuRimuFgkMB36T8P+hySF6Y9LGkmt
X-Received: by 10.194.61.168 with SMTP id q8mr25852972wjr.53.1418384726084;
	Fri, 12 Dec 2014 03:45:26 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ry19sm1524483wjb.3.2014.12.12.03.45.22
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Dec 2014 03:45:23 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 474A7566251; Fri, 12 Dec 2014 11:45:19 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Dec 2014 11:45:11 +0000
Message-Id: <1fae3ef8f87a836758519c85afb2762768c29efc.1418384609.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
References: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418384609.git.alexandru.damian@intel.com>
References: <cover.1418384609.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 12/18] toaster: tweaking the import layers form
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
X-List-Received-Date: Fri, 12 Dec 2014 11:45:26 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

This commit makes the following changes to the import
layers form:

* In the explanatory text at the top of the page, show only
the release description (to match the information shown in all
other pages)

* Make sure the spacing between form fields and labels is
consistent across the form

* Change the 'Branch, tag or commit' label to 'Revision'
and add some help text to the label

* Change the help text and the input type in the layer
 description

* Change the help text next to the form actions to match
the new field ordering in the form

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/importlayer.html | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index 913f951..00fd694 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -36,7 +36,7 @@
                 {% include "layers_dep_modal.html" %}
                 <form>
         {% if project %}
-                    <span class="help-block" style="padding-left:19px;">The layer you are importing must be compatible with {{project.release.name}} ({{project.release.description}}), which is the release you are using in this project.</span>
+                    <span class="help-block" style="padding-left:19px;">The layer you are importing must be compatible with <strong>{{project.release.description}}</strong>, which is the release you are using in this project.</span>
           {% endif %}
                    <fieldset class="air">
                       <legend>Layer repository information</legend>
@@ -60,7 +60,7 @@
 
                       </div>
 
-                        <label>
+                        <label for="layer-git-repo-url" class="project-form">
                             Git repository URL
                             <span class="icon-question-sign get-help" title="Fetch/clone URL of the repository. Currently, Toaster only supports Git repositories." />
                         </label>
@@ -85,9 +85,9 @@
 
                           <label class="project-form" for="layer-description">Layer description
                             <span class="muted">(optional)</span>
-                            <span class="icon-question-sign get-help" title="Short description for for the layer" />
+                            <span class="icon-question-sign get-help" title="A short layer explanation" />
                           </label>
-                          <input id="layer-description" type="text" class="input-xxlarge" />
+                          <textarea id="layer-description" class="input-xxlarge"></textarea>
 
                     </fieldset>
                     <fieldset class="air">
-- 
1.9.1


