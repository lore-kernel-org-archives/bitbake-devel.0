Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id D6B1D6B7CA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 16:27:37 +0000 (UTC)
Received: by mail-pa0-f41.google.com with SMTP id rd3so2883789pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 08:27:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=8q7X6wK6HxPGhQUA1s8kb6BZeHcgAbdANrGl03MdF1Q=;
	b=hYGNNmc5pYiRwdEFFEsLZSizoMBrjhfJWh44BO39+PcE97lwcL5zcK8tXo+b4RrRll
	l8WvTo30An7rmhCxaoxYoUPvvowx4ZkaK4+vMpbFPSF/s2fnSnqntQCgX2FcteLK5EWm
	Vyh3eyIoEKc4+0D4hiM4QpQYBOX2ehrcsvJSafPchqVeECZzVw68pjV7LQ5IDJQtOr/y
	XIAXEZa8/Or7U5OHyK2KRayucVGds8f7PhmTlessD30mKYPzTMmaOZFuJK//6cwRgyk6
	G6mcCvN2zJLQ4FcR6fVpsASVZF8ybCKzlIrwaWqBEFpoba/13f3UVagBn+9w0vhdVSDA
	VzUA==
X-Gm-Message-State: ALoCoQmyDBzgX7qp/3jdwSqdlAfe2O2KY5MsmfbBrQZAmkjdL+gNVxQroe184seIffcm0sYwwY1v
X-Received: by 10.70.45.233 with SMTP id q9mr57927481pdm.24.1416500858573;
	Thu, 20 Nov 2014 08:27:38 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id y10sm2500432pdq.15.2014.11.20.08.27.35
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 20 Nov 2014 08:27:36 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 853035641E5; Thu, 20 Nov 2014 16:27:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Nov 2014 16:27:24 +0000
Message-Id: <83af0db872ea28965cd6007ad72ff210f67a4f30.1416500715.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
References: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1416500715.git.alexandru.damian@intel.com>
References: <cover.1416500715.git.alexandru.damian@intel.com>
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 08/11] toaster: Tiny refinements to the new build button dialog
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
X-List-Received-Date: Thu, 20 Nov 2014 16:27:38 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

* Get rid of the display:block attribute for the "View
all projects" link, to stop it from firing when you
click outside (but next to) the link

* Give some margin to the incomplete configuration
alert

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
---
 lib/toaster/toastergui/static/css/default.css | 3 ++-
 lib/toaster/toastergui/templates/base.html    | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 6194c97..902a2bd 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -133,7 +133,8 @@ select { width: auto; }
 
 /* styles for the new build button */
 .new-build .btn-primary { padding: 4px 30px; }
-#view-all-projects { display: block; }
+.new-build .alert { margin-top: 10px; }
+.new-build .alert p { margin-top: 10px; }
 
 /* Configuration styles */
 .icon-trash { color: #B94A48; font-size: 16px; padding-left: 2px; }
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 87746bf..734d2ad 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -81,12 +81,12 @@
                         <button id="save-project-button" class="btn" type="button">Save</button>
                         <a href="#" id="cancel-change-project" class="btn btn-link">Cancel</a>
                       </div>
-                      <a id="view-all-projects" href="{% url 'all-projects' %}">View all projects</a>
+                      <p><a id="view-all-projects" href="{% url 'all-projects' %}">View all projects</a></p>
                     </form>
                   </li>
                   <div class="alert" style="display:none">
                     This project's configuration is incomplete,<br/>so you cannot run builds.<br/>
-                    <a href="{% if project.id %}{% url 'project' project.id %}{% endif %}">View project configuration</a>
+                    <p><a href="{% if project.id %}{% url 'project' project.id %}{% endif %}">View project configuration</a></p>
                   </div>
                   <li id="targets-form">
                     <h6>Target(s):</h6>
-- 
1.9.1


