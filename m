Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id 6DD7260670
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 18:21:59 +0000 (UTC)
Received: by mail-wg0-f48.google.com with SMTP id x12so12910170wgg.7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=qN3SFob/xgWan5bLyBs2gkq+CjozURD9a/oIfxanVdk=;
	b=czEV/AWIZry8hutdk50wsFS0lKFT5sGXHbSmZtgVtKvsA+UZ9m9RwjNuPNIHmnp7rW
	/GOBYaMfmMhdPmBvMWGB7YnK3cFiuDvnjG7wzTQ+Sgl7jqSkiSglKmm4YbE3wdOs20C8
	WnPUDcgiRlfShhUsrWMiMV/GXAtT9CqGSd4M0YjTb8a+m2S8HD+fW3ce20qC7EHNbsQc
	YlUj7/Fk1QgswmzBDR8Zs1sDUn6zCfzfEave2jMATBgzH3MmdMQnC2bcfppofsJjd/5e
	oaq+NP1qwfR079g8a0dLoK7+naq3/A+lC/Lz0EueVa16YkDJ9EwkttJunMJ3QFpjTYT2
	g4kg==
X-Gm-Message-State: ALoCoQkur8bB7DY7M0vJrCze/4u6D3RjFWfGxQdTCYokvkJ0uKRjGVocK4gJAbAWH2nZ5Stn4a07
X-Received: by 10.180.198.166 with SMTP id jd6mr58637229wic.18.1421864520336; 
	Wed, 21 Jan 2015 10:22:00 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id di11sm6218179wid.8.2015.01.21.10.21.56
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 Jan 2015 10:21:57 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id F13D5564118; Wed, 21 Jan 2015 17:01:42 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Jan 2015 17:01:41 +0000
Message-Id: <db8c7ab557a4ee6d63d8eafb2e8c84851b14ff1f.1421859619.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
References: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1421859619.git.alexandru.damian@intel.com>
References: <cover.1421859619.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 11/12] toastergui: all projects column show/hide
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
X-List-Received-Date: Wed, 21 Jan 2015 18:22:05 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes the show/hide in all projects page.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/projects.html | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/toastergui/templates/projects.html b/lib/toaster/toastergui/templates/projects.html
index 432f025..0396e25 100644
--- a/lib/toaster/toastergui/templates/projects.html
+++ b/lib/toaster/toastergui/templates/projects.html
@@ -23,12 +23,12 @@
       <td><a href="{% url 'project' o.id %}">{{o.release.name}}</a></td>
       <td>{{o.get_current_machine_name}}</td>
       <td>{{o.get_number_of_builds}}</td>
-      <td>{{o.get_last_outcome}}</td>
-      <td>{{o.get_last_target}}</td>
-      <td>{{o.get_last_errors}}</td>
-      <td>{{o.get_last_warnings}}</td>
-      <td>{{o.get_last_imgfiles}}</td>
-      <td>{{o.updated|date:"d/m/y H:i"}}</td>
+      <td class="loutcome">{{o.get_last_outcome}}</td>
+      <td class="ltarget">{{o.get_last_target}}</td>
+      <td class="lerrors">{{o.get_last_errors}}</td>
+      <td class="lwarnings">{{o.get_last_warnings}}</td>
+      <td class="limagefiles">{{o.get_last_imgfiles}}</td>
+      <td class="updated">{{o.updated|date:"d/m/y H:i"}}</td>
     </tr>
   {% endfor %}
 {% include "basetable_bottom.html" %}
-- 
1.9.1


