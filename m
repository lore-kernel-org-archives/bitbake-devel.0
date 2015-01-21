Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
	[74.125.82.169])
	by mail.openembedded.org (Postfix) with ESMTP id 799E772CB7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 18:22:18 +0000 (UTC)
Received: by mail-we0-f169.google.com with SMTP id p10so21216750wes.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=FJV7D7aWJ9JUcdr0gFCZIAmLtxOEv/pMVyMxu+Z4J68=;
	b=Whcq0cDVHB4E9zAI4la+q2MO511HChrk53SxorrJd57uoaTyJkR4fVOf27yj0ANCco
	MtMByOoybc1vNwo95ltVQ6qL5kjSBtL5tIDtb5XBmFQt9YbmaEHP6bqQzOmLJjeqVIDs
	QQ160Unf6cgcBbrSJ3+roUnGhr83OvzEH7piA0G0iKRS6NvlCtqReEP/qB5lyFuJRTrR
	LT+Ch/AkYoI1gXlMd2yTBesfDPow6dFf8O+4tfi+mTLL14/yPqdBeyxzoRRzofzCxhZM
	5P4HJb8yhV+XDtYz1+XvPFHIUujzSvB0kGWbpTI9f11aelGz3nk0pcZMTYNUI1v4yNjb
	dDgQ==
X-Gm-Message-State: ALoCoQlk6Ox0JwjQG7oyhDmANagq0j9h0fc+0kM2pPN8MzaGfEg+/32ZWl/QuawvKAO03dBwrljR
X-Received: by 10.180.37.77 with SMTP id w13mr59904014wij.66.1421864538858;
	Wed, 21 Jan 2015 10:22:18 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id p6sm767044wjf.39.2015.01.21.10.22.16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 Jan 2015 10:22:16 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id EF7F6564115; Wed, 21 Jan 2015 17:01:42 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Jan 2015 17:01:40 +0000
Message-Id: <5f904c0945d20dcf563efcc26bcb486426aa7711.1421859619.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
References: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1421859619.git.alexandru.damian@intel.com>
References: <cover.1421859619.git.alexandru.damian@intel.com>
Subject: [PATCH 10/12] toastergui: fix the second 'view all targets' link
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
X-List-Received-Date: Wed, 21 Jan 2015 18:22:18 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The project page has 2 links to the all targets page.
The one at the top of the page is working, but not
the one further down. This patch sorts that out.

[YOCTO #7147]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/project.html | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index fe3bcf2..b8579e4 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -294,7 +294,8 @@ vim: expandtab tabstop=2
           </div>
           {% csrf_token %}
         </form>
-        <p><a href="{% url 'targets' %}">View all targets</a></p>
+        <p>
+          <a href="{% url 'all-targets' %}">View all targets</a></p>
         <div ng-if="frequenttargets.length">
         <h4 class="air">
             Most built targets
-- 
1.9.1


