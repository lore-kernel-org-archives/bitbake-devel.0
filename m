Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com
	[209.85.166.42])
	by mail.openembedded.org (Postfix) with ESMTP id B9A98619CE
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Mar 2020 20:02:30 +0000 (UTC)
Received: by mail-io1-f42.google.com with SMTP id s24so3814325iog.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Mar 2020 12:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=cGt8/72HuJ80CmL5F/Ok1ALQAh4IWKRFg2cvJcBqpdw=;
	b=izT41oXhn6tkw9O46JHycjS/spz/hp5ztHRGWl+nSvsjgjXnZszq3FcuxcwUb3KZX9
	rAjqif7yhxF1DJ6qrAWyL5JXx/FgKYSN65MBONCRuKe9Y99GICZtlqYitGB57TytQkOT
	rtbHkGkGCMx/UIiWjouQa6IA/F/1Qj/S998Xs4XrfB6ZkcJihSV8waU6AhJ/h5Jherqh
	8jZbLTfAkotsPeEf0kcV3xtHENOIaVoZ/uM42wCu3V+MLMTtuZckh211Cfw/8ZmdxdOq
	D9rdZn7ivLiyHuRLRdxqjk54kPTEYL0zPetoUpnJ2YS+QcnR3xH+rzTYneqKgyKGNpnJ
	plnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=cGt8/72HuJ80CmL5F/Ok1ALQAh4IWKRFg2cvJcBqpdw=;
	b=SpR59W7YcncjuVvQR/mep7EKMDDaFnKKcP5ThShG8MbnUOdU8RdAfBzRLGpFX9ZxHL
	37tL3JzfgxDlbGcxK4t9WWRXnuMMmoHFv/qcc+qxrJOG4wdJwvUgCqC2FqIQo24rg6Nx
	D7r1bsWCBDjf0wptEH7Ds/LnQNKNcsKIuqcnDOhNRGSlLh2xz4dao0tKFLQ8CYFd7Vy+
	5CxO3/U1SKwag7Z/0ViAMBIY2H4z710I1vmkTQtior+AjKf213pLHzLSM5WJHfmGCvMM
	GLlCLDOoRmdJ9KrgVbIel2hiheq4u280vyzcrSR2SAGgki02yJV3hVmcky8kkAgiA3c4
	gPuQ==
X-Gm-Message-State: ANhLgQ3uimRcJI3IVTOqLxeW7wMF9Bf9tLCmfLjUCRUSVp9EBkASubWt
	7Hniexiz17NJLOOlhuVdJyFgesYT6fo=
X-Google-Smtp-Source: ADFU+vvTrm7FqMDC59fhs4j7FZCcYlOXvcLhA+EjwUkbiKWq6x3oQMGuc9g24jtFm6v90fNqmE5KCg==
X-Received: by 2002:a02:caa2:: with SMTP id e2mr4386059jap.6.1583352151417;
	Wed, 04 Mar 2020 12:02:31 -0800 (PST)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id j4sm7310626ilf.21.2020.03.04.12.02.30
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 04 Mar 2020 12:02:30 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Mar 2020 14:02:24 -0600
Message-Id: <20200304200226.23771-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304200226.23771-1-JPEWhacker@gmail.com>
References: <20200304200226.23771-1-JPEWhacker@gmail.com>
Subject: [PATCH 2/4] bitbake: cooker: Respect multiconfig parameter
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
X-List-Received-Date: Wed, 04 Mar 2020 20:02:30 -0000

The cooker had a multiconfig parameter for the findProviders() and
findBestProviders() API, but it was being ignored.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cooker.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index bda6d1b5c4..e527e23114 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1023,16 +1023,16 @@ class BBCooker:
             bb.event.fire(bb.event.FilesMatchingFound(filepattern, matches), self.data)
 
     def findProviders(self, mc=''):
-        return bb.providers.findProviders(self.data, self.recipecaches[mc], self.recipecaches[mc].pkg_pn)
+        return bb.providers.findProviders(self.databuilder.mcdata[mc], self.recipecaches[mc], self.recipecaches[mc].pkg_pn)
 
     def findBestProvider(self, pn, mc=''):
         if pn in self.recipecaches[mc].providers:
             filenames = self.recipecaches[mc].providers[pn]
-            eligible, foundUnique = bb.providers.filterProviders(filenames, pn, self.data, self.recipecaches[mc])
+            eligible, foundUnique = bb.providers.filterProviders(filenames, pn, self.databuilder.mcdata[mc], self.recipecaches[mc])
             filename = eligible[0]
             return None, None, None, filename
         elif pn in self.recipecaches[mc].pkg_pn:
-            return bb.providers.findBestProvider(pn, self.data, self.recipecaches[mc], self.recipecaches[mc].pkg_pn)
+            return bb.providers.findBestProvider(pn, self.databuilder.mcdata[mc], self.recipecaches[mc], self.recipecaches[mc].pkg_pn)
         else:
             return None, None, None, None
 
-- 
2.17.1


