Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id AC5C76EEFA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:07 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id n12so2525062wgh.24
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ZSUHPc+6A1uCAWK9jpAK6/QHOc6S7XrbId1ZvRfe/BY=;
	b=RC/sMRPdMFT0kiLXUKXFXc7iYZBzZN4IN93e81iBevo+1p5E/A8Kr9zIzRKZt9j91L
	UOvzenMfj8YgQJBNB7szblBFff4aQueT7Pqc7AVHU/kl7qelZaO2jRAWWElg3DECUn0W
	v8ccReS7eOd49wTynLEw66cZ50P17qkt/DdsFYYT6tGDiI1hYJIRJmyCwmKOjfDXG27m
	VDOLf9/lMbb7VcDw6VEDKHpk548KpN69Y0gBv1GNDmD2sSt6nKKSh7UZ2IxbnKbFjAAM
	VI0krtVNC7zmffu3hdhoqCCIGpaL53Ez9gcQ53yyUquD7SELxA0tAbOo93lwt7GbG6hq
	KuJg==
X-Gm-Message-State: ALoCoQl9fpIfHBtJhHaZUSihYrxTae2u9GvEq0VNhwYEiylXXlP5JezhXO2vNrLQzGWBEZ0Me2iM
X-Received: by 10.180.24.134 with SMTP id u6mr7319672wif.41.1394819947977;
	Fri, 14 Mar 2014 10:59:07 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id n3sm18700556wix.10.2014.03.14.10.59.03
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:05 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 1695C56119B; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:50 +0000
Message-Id: <a58b88aebfde54ea97740f27335582fac195dfdc.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Subject: [PATCH 09/19] toaster: Fixing "Show all builds" link
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:08 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Replacing the placeholder attribute with the value attribute
in the no search results page broke the "Show all builds" link.
This change applies the inline javacript used for the clear search
button for the "Show all builds" link, which fixes the problem.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/build.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/build.html b/lib/toaster/toastergui/templates/build.html
index f0ef4d4..3c9256c 100644
--- a/lib/toaster/toastergui/templates/build.html
+++ b/lib/toaster/toastergui/templates/build.html
@@ -71,7 +71,7 @@
         <form class="no-results input-append" id="searchform">
             <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
             <button class="btn" type="submit" value="Search">Search</button>
-            <button class="btn btn-link" onclick="javascript:reload_params({'search':'', 'filter':''})">Show all builds</button>
+            <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all builds</button>
         </form>
       </div>
   </div>
-- 
1.8.3.2


