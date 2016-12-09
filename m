Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id 07DD46013D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Dec 2016 16:53:12 +0000 (UTC)
Received: by mail-wm0-f48.google.com with SMTP id g23so32318967wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 09 Dec 2016 08:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=4s/BSQAYMUOL5rIYAg4kctYr2YsYjXPmINmS2mbJkWw=;
	b=VKXvyMj9ch9R36uZigj/lNLbebNsIdpJ1wXa875COlRjhjfCsGJgBph7amx77TtQaN
	NzexvlOhuP4AzQ9XOlpZQXuS6xKKTa2OVWni/15dGTWZhOp2MQA5HMtCUKGrvoB+NNzD
	S6w0uXEzrvARoDXHL2KPLKDKdRhvY2NBGnvvTP8ZAcgSAANTzZ/qzQ8MJlY2FGbqmtIk
	S5lZitOzvxx1PVAUgsP7W7gQzojYgvUAKkOpsBe/4jNkwOaeWpo+uakpRBpymflhf71t
	NHkshkhNKMKj5bMrhLZPxE9721Kpwe18m0Nz23OFot3SFf7RcoaZY3u5hI7lMuQxpTLk
	fRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=4s/BSQAYMUOL5rIYAg4kctYr2YsYjXPmINmS2mbJkWw=;
	b=NM18OHNqjRRUBU0F849mJ2I40d568RP93B+nziltigerrKgcAxnJUgi0RPWIjyp54B
	xxv5S0FAcNdnD6SJUSnH0EuEp2K0+dEfQF4a+FV7rAqrxlkt6f2tn6ZEdxQLlZCBHOT7
	asEE90WCTqAssB9Qhfifcc5GE6VW1OXFP2FP3A50GIQYpgzcqFjKOPLtDVvofD3SKgr2
	AE4fGUaZuOv6upCUizKqnmgIxRdEi5DuKRx8xX8CZ0hct4Zyk2YlOfabGuDSocyg3c1b
	mLZkXHQgD4UKeNa1PTCTiP+hQMLJIJy1RG6Fa947ueTB+MyYErC1Y856ceJ1HsuPqLGh
	AefA==
X-Gm-Message-State: AKaTC01YTsXIvUT3a3CG3Nsv6YJmGLu2g7S5L208ZRH5f0pmwYrkkCwxzBEPZEd91aiJxGni
X-Received: by 10.28.23.137 with SMTP id 131mr7751979wmx.121.1481302393876;
	Fri, 09 Dec 2016 08:53:13 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	ke6sm43170601wjb.21.2016.12.09.08.53.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 09 Dec 2016 08:53:13 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Dec 2016 16:52:52 +0000
Message-Id: <1481302375-7985-12-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
References: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 11/14] toaster: typeaheads Layers add url to layer REST API to the layer
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
X-List-Received-Date: Fri, 09 Dec 2016 16:53:13 -0000

Add the url to the Layer typeahead so that this can be used later on by
the front end code to look up layer details.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/typeaheads.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/toaster/toastergui/typeaheads.py b/lib/toaster/toastergui/typeaheads.py
index 5316000..58c650f 100644
--- a/lib/toaster/toastergui/typeaheads.py
+++ b/lib/toaster/toastergui/typeaheads.py
@@ -23,6 +23,7 @@ from orm.models import Project
 from django.core.urlresolvers import reverse
 from django.core.cache import cache
 
+
 class LayersTypeAhead(ToasterTypeAhead):
     """ Typeahead for layers available and not added in the current project's
     configuration """
@@ -55,6 +56,8 @@ class LayersTypeAhead(ToasterTypeAhead):
                 'id': layer_version.pk,
                 'name': layer_version.layer.name,
                 'layerdetailurl': layer_version.get_detailspage_url(prj.pk),
+                'xhrLayerUrl': reverse('xhr_layer',
+                                       args=(prj.pk, layer_version.pk)),
                 'vcs_url': layer_version.layer.vcs_url,
                 'vcs_reference': vcs_reference,
                 'detail': detail,
-- 
2.7.4


