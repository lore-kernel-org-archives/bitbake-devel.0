Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 467786F853
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:07 +0000 (UTC)
Received: by mail-wg0-f43.google.com with SMTP id x13so2420882wgg.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=N6jnPY67zBDC8JoHAG2Dl5dB8C+tMp7yG6ubmRBPbOw=;
	b=EWGbP6At0My3JHAjuiDWIStYd40W9/G3kNu+DoLuEueP9c7fIGCCoO8uLV0FVCXSGX
	tzkQpgQHwft5gU6nNMv2iDRZOcu5XzMzF1l3QR1EnuNMvd9Ne1pmgGGnY6GISwrbJp5a
	qtgJmUf1XPRZBtzA7Xce4/A+gLITGBrU1pzgQnBsfqtMLt4ico2GuvY7mcElNWZE41YC
	mAFEXqL4nVXH0IGodooGyWhbN8Axndfep6Q3QkRMhBKcpUfUmGSnaWw3ckvYBGf92Xdv
	0gPUdsJ8hyG72aahApyDcAk+hTGyCqsAWCIQH2crGx0WG9ZP06g4MdZqIIRdmJMic6st
	an9w==
X-Gm-Message-State: ALoCoQnhAZZijYJI+4OwaIhn3b5Dn44T5Rg9C69+990WeTtv+14ZCex8Ye+qV+7rQ5c+eDG81hKQ
X-Received: by 10.194.118.163 with SMTP id kn3mr2629065wjb.77.1394819948556;
	Fri, 14 Mar 2014 10:59:08 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id h9sm15545586wjz.16.2014.03.14.10.59.04
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:07 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 1B8855611F2; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:53 +0000
Message-Id: <6147339ac2f93a9e60eed8975ac1784caa06bb0b.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Subject: [PATCH 12/19] toaster: Shorten dependency labels
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

Changing "Task depends on" to "Dependencies" and
"Task reverse dependencies" to "Reverse dependencies".
This matches the labeling to recipe and package
information, with the additional advantage of
making the labels shorter.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/task.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/task.html b/lib/toaster/toastergui/templates/task.html
index 5d79d44..403bb03 100644
--- a/lib/toaster/toastergui/templates/task.html
+++ b/lib/toaster/toastergui/templates/task.html
@@ -214,7 +214,7 @@
 -->
     <dt>
         <i class="icon-question-sign get-help" title="Task dependency chain (other tasks)"></i>
-        Task depends on
+        Dependencies
     </dt>
     <dd>
         <ul>
@@ -227,7 +227,7 @@
     </dd>
     <dt>
         <i class="icon-question-sign get-help" title="Which other tasks depend on this task"></i>
-        Task reverse dependencies
+        Reverse dependencies
     </dt>
     <dd>
         <ul>
-- 
1.8.3.2


