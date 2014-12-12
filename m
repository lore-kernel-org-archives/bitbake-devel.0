Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f53.google.com (mail-wg0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id 1BC60724AC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 11:45:20 +0000 (UTC)
Received: by mail-wg0-f53.google.com with SMTP id l18so8898646wgh.12
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 03:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=5ArIDNhf78mwjRkonnGMDvV3xh5cif3/AHg+fFBVby4=;
	b=bYaphTR4BhVPIY6GbhZHEsnwhKwS8ESS/ajiy8fAS9SNR8HySM5RunmGnYqLQX9oe6
	uf4vU4rhBCrmK7rBmYTAus3VPeLvIw9JGq49kQbOxSgPSH4z8bfW3wYoSjwmOfcoPjGD
	Ow7Z86zybPVHrVyNvHFz2GXaIVYZqSw94NAS6h0bR+TQodziXikRMGpx72NZ4AivpgrQ
	aIXHaalJ+nPddHTAab4PMydqllgV6yayiVX2c0iGhh9zFoUKnFezDazrY63RymFHFX2q
	Mvk3vBWHhZk6GrNb51ftNvho5DQzFJlhvp9IOIq0+JVnjxPhr3IwM7pYXVw2TIjgSTB+
	CnZA==
X-Gm-Message-State: ALoCoQnaMlGL5Cu/q/Uo4ppQ+yc2kha8JgpbhHhNqGTR2H7ryx8qwmrpaYGr9TrA7K9lp/LtP/9k
X-Received: by 10.180.211.196 with SMTP id ne4mr6682564wic.71.1418384720337;
	Fri, 12 Dec 2014 03:45:20 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id f7sm1739113wiz.13.2014.12.12.03.45.18
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Dec 2014 03:45:19 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 3B1BF565094; Fri, 12 Dec 2014 11:45:19 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Dec 2014 11:45:05 +0000
Message-Id: <e354a40d7dbcd85fea9d37d3983428e4470df2dd.1418384609.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
References: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418384609.git.alexandru.damian@intel.com>
References: <cover.1418384609.git.alexandru.damian@intel.com>
Subject: [PATCH 06/18] toaster: base Only show change project icon when > one project
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
X-List-Received-Date: Fri, 12 Dec 2014 11:45:23 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

In the new build button, it only makes sense to change
the selected project when there is more than one project
in the Toaster instance. If the number of projects is 1,
we hide the change project icon.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/js/base.js | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index fac59e6..619ad28 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -11,6 +11,10 @@ function basePageInit (ctx) {
       return;
   }
 
+  /* Hide the change project icon when there is only one project */
+  if (ctx.numProjects == 1){
+     $('#project .icon-pencil').hide(); 
+  }
 
   newBuildButton.show().removeAttr("disabled");
 
-- 
1.9.1


