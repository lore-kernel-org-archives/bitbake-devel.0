Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id 9DCE672503
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 11:45:24 +0000 (UTC)
Received: by mail-wi0-f180.google.com with SMTP id n3so2270444wiv.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 03:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ppHcTEnlc2zUwssZ/Y1j98NFXj/mf6HmptLXjq04Zkw=;
	b=FMglbrVyvVoge/SCTASAN0aJCIBWrmxm8EL62R7IF8/3XgNzl8rxl3pl1KcRnXbSJM
	tD6EsSNz9K5ncd38MDtNUK/Nq1lrQz/oo+nGOlunF2aVaLZkjxA0DqqPw9DG0uGY3Pat
	Fbqz55L1WTMA5VoP0un7bVAbyQe3iaj051Qazu35mASmVJL85TT/A3sT8sJtVOGcI390
	zQPouKwL/NS2d55fxzeghBt9Ie2oac6B/Z19cP93A59EJEMMRAuIs7w9yDwSqRCAgdl8
	s6Iut+f/WdvSWZmAqbKGIhfI6YEeif1a37FXoT8VVpSr0eVlGfEBHsDfKjrA+BWvUEMp
	dNiQ==
X-Gm-Message-State: ALoCoQnDaE1xu6efoMJB06FNVl4yE2jGKiQJ6MS6wKWXtALdq9rJ7lz/iSL/EuJ6tmajjyp55YQk
X-Received: by 10.180.11.140 with SMTP id q12mr6848723wib.45.1418384724551;
	Fri, 12 Dec 2014 03:45:24 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id x2sm1517998wjx.9.2014.12.12.03.45.21
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Dec 2014 03:45:22 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 3FD6F56624C; Fri, 12 Dec 2014 11:45:19 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Dec 2014 11:45:06 +0000
Message-Id: <c635dd71670030da78c52545d2bb32b8c485c1af.1418384609.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
References: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418384609.git.alexandru.damian@intel.com>
References: <cover.1418384609.git.alexandru.damian@intel.com>
Subject: [PATCH 07/18] toaster: Initialise the 'change' icon tooltips
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
X-List-Received-Date: Fri, 12 Dec 2014 11:45:24 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

All 'change' icons should have a tooltip that appears
when you hover over them. The tootlip says (fittingly):
"Change". Initialise those icons in the libtoaster.js
file so that they work outside the project page.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 8e76ecb..37fc80e 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -213,6 +213,9 @@ $(document).ready(function() {
     // show task type and outcome in task details pages
     $(".task-info").tooltip({ container: 'body', html: true, delay: {show: 200}, placement: 'right' });
 
+    // initialise the tooltips for the icon-pencil icons
+    $(".icon-pencil").tooltip({ container: 'body', html: true, delay: {show: 400}, title: "Change" });
+
     // linking directly to tabs
     $(function(){
           var hash = window.location.hash;
-- 
1.9.1


