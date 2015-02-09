Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id C6E6B732E8
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:17 +0000 (UTC)
Received: by mail-pa0-f44.google.com with SMTP id kq14so6546023pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=EBbTtKnQvhqcr1P7GVpDy2xYGRzDh3njV4MSuGzIAFg=;
	b=YDEGZrC8OtafhsNQBDTy3tY21T+zWAQZv9TtSKym1bDkpHi6gB9FRtbOP15yX8mxpc
	ihNOifa/gMOy0o0Kmpct0fb5eMzCr6ZJZjKM73Ryd/T3+opB/tearbm4HqwVXK7Ms1Zg
	OHfWventfYLTW1J07R/LzHF+t1FvoHu+Snkf0tBIlaXBAyisdFXLA7k2SBN+wXwln4Yv
	HVrXrud0t1EArBsHpY11t3Ym+AUpcSFCbl2U+ei3FYCvQLazFgzDROS48gDGviY0mxGY
	JbKWGCu0QZDbN1ju7fpNosmm1Gky2NEfl9iSLi5cjrEmXM8uznwiA/UBUBoSHUemIoB2
	NIPw==
X-Gm-Message-State: ALoCoQnNuod94mT64jb6O3hfkNJ+BWcKCU7OhkyDaTdSOX3MOXc/zL4o2WqsXwlRpKVZwOUkPqwL
X-Received: by 10.70.61.106 with SMTP id o10mr31109485pdr.46.1423504939384;
	Mon, 09 Feb 2015 10:02:19 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ex3sm13284731pdb.23.2015.02.09.10.02.17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:18 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 2369056618B; Mon,  9 Feb 2015 18:02:15 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:55 +0000
Message-Id: <44e989b32cc36efa31f893c40930bcc9f746bd43.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 25/27] toaster: All machines show results count if filtering or searching
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:17 -0000

From: Michael Wood <michael.g.wood@intel.com>

Show the number of results returned if filtering as well as when
searching.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/machines.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/machines.html b/lib/toaster/toastergui/templates/machines.html
index f63e897..2089c26 100644
--- a/lib/toaster/toastergui/templates/machines.html
+++ b/lib/toaster/toastergui/templates/machines.html
@@ -30,7 +30,7 @@
 {% include "layers_dep_modal.html" %}
 <div class="page-header">
   <h1>
-    {% if request.GET.search %}
+    {% if request.GET.search or request.GET.filter %}
       {% if objects.paginator.count != 0 %}
         {{objects.paginator.count}} machines found
        {% else %}
-- 
1.9.1


