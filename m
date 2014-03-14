Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f172.google.com (mail-we0-f172.google.com
	[74.125.82.172])
	by mail.openembedded.org (Postfix) with ESMTP id 2A36B6F761
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:06 +0000 (UTC)
Received: by mail-we0-f172.google.com with SMTP id t61so2461856wes.17
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=GG0OSrxIIx4u/Qr63o21jDK1zeoX+3wvV+AxUf5+S/k=;
	b=l2rATnEH8ZwWsHf97Sjhk0hLGkmFQmkgFjH/NbJrcDd/33UyjktnVTlrVw8GBVdxaK
	nSL0zK2eefm+jcW3Bl+OIvrD/PbDIMue1NTr2Vbvw/lCpZ+dSLhy8i5fnPkN3WKAfTh6
	MHTqiyVE1gorND854ruBRHbe4U2n29+0Ks2k0ngOZt4Uw1QVQtYeYF4/PcR573r/AnTS
	KtltqlT3WBQC0xRgJ8vpQvuw34a+S31P8XJR1CMoOF6Ww62sIGI3U4oKB0O/vDFObCf0
	fAATB+/jlZdP11ILN9SeNuCPUdhNL1+SCXBtsG96cNesbgQIqErLTuclC/KlUyH0Nk4A
	RjMQ==
X-Gm-Message-State: ALoCoQnBJJIBaf82pm6OTc+V7ueZ5SW6/bUOSeCltgKbJcRNUkt0V6i1uA5aN94VV7ilxYjyS1Jt
X-Received: by 10.180.100.72 with SMTP id ew8mr7370146wib.16.1394819947442;
	Fri, 14 Mar 2014 10:59:07 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fq16sm15576633wjc.3.2014.03.14.10.59.04 for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:05 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 19F655611F1; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:52 +0000
Message-Id: <5e45f2bb4b0d9b56b5f4734cf40d3a267654ccb9.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Subject: [PATCH 11/19] toaster: Give an extra space to the caret
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:09 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

In the "Collapse variable value" button in configvars.html,
the caret was too close to the button label. Giving it
a bit of extra space.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/configvars.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/configvars.html b/lib/toaster/toastergui/templates/configvars.html
index 5c552c9..ae77be8 100644
--- a/lib/toaster/toastergui/templates/configvars.html
+++ b/lib/toaster/toastergui/templates/configvars.html
@@ -92,7 +92,7 @@
                         <a class="btn btn-mini full-show">...</a>
                     </span>
                 </p>
-                <a class="btn btn-mini full-hide">Collapse variable value<i class="icon-caret-up"></i>
+                <a class="btn btn-mini full-hide">Collapse variable value <i class="icon-caret-up"></i>
                 </a>
               {% endif %}
             {% else %}
-- 
1.8.3.2


