Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id F1C88758E1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:35:21 +0000 (UTC)
Received: by wicnd19 with SMTP id nd19so13685594wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=6bwUsniGXspIEvveBeT1jA6aTLN+0pMuyh+d645FGaE=;
	b=C+5GekcidN3fdOeUUW0GytmbZzmOrdX9hF757GunWJ+af8+nIez7JeBLYH/q/XM5bT
	DKD8VzlWrQr31R2n5ZU+L2U+NPQpYl4D/8fOYC9Ro+7mufssNni8muIi6u1KruUK/1SP
	vByXq7bNGq7IpOJUC6HIF7R2Sqd+vfo6RmcdzUhoCTaL54ZDyYosm6aBfaIyfdtTnbBy
	dFqTrzb927JlABTuDlEqRmS+6u+jxp9LOBxxlPZVBeyZxnW/vJbgZAsJBcrmv5fO5myI
	7AbJ/45ipKfmWV80yxcfeDiDW9Rrt0tFk4C9/Lhy9ooI0l+hdQ/+osoZ3kKfoyfRVNAS
	Fs8g==
X-Gm-Message-State: ALoCoQnKasAnu3Um+ifHrb2dS4CYWClNdOJHLPC96R5UD5mHmpxypJ95t6vbBSX0Kxn0WLOqypsk
X-Received: by 10.194.118.167 with SMTP id kn7mr9449340wjb.83.1435228522808;
	Thu, 25 Jun 2015 03:35:22 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id qm6sm2033947wjc.46.2015.06.25.03.35.21
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:35:22 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id EB5C1562E3B; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:34:00 +0100
Message-Id: <0a8e740e18333da981b24a76db4c891845e5df78.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 23/23] toaster: Add url pattern for backward compatibility
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
X-List-Received-Date: Thu, 25 Jun 2015 10:35:23 -0000

From: Michael Wood <michael.g.wood@intel.com>

This adds an url to match the old orm application.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastermain/urls.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index 26ad3a2..521588a 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -40,6 +40,10 @@ urlpatterns = patterns('',
     # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
 
 
+    # This is here to maintain backward compatibility and will be deprecated
+    # in the future.
+    url(r'^orm/eventfile$', 'bldcollector.views.eventfile'),
+
     # if no application is selected, we have the magic toastergui app here
     url(r'^$', never_cache(RedirectView.as_view(url='/toastergui/'))),
 )
-- 
1.9.1


