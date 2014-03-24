Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id 453316FB49
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:36 +0000 (UTC)
Received: by mail-wg0-f48.google.com with SMTP id l18so3751684wgh.7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=v/dnxcqEvnVaUIuLVxRRxrNIOLZkW9eQ2E8u+zKsWDY=;
	b=eM9PCkulwXFvxeO7hmOlHR+WkPykC/YQlbFbj9SID6qZjAsRLMvMskaMWdjQ/ua404
	aBrlzHWAGVMmdxMUCYII9o++erDXktMPjiipPgOd7D0O2soTY+SwPikBrsu/kz/RuAzE
	ctSUCJDJ9JRK2Q2vVXWk2lVxPlwTyAoG7L3VU9XBloVRtjarQLnBaU2YC8jtKUKmzaK+
	Go8DlUdwaLzGhgEUxxQwX3dh1TtIse4mkSHpqJYWQcxApN0e6o24jx2Dg1/ED9hun6b5
	zeICVMSGotWbjz3qii70jCge0yLplOfs4Nhuc9NF1BiTIdqfpLtrFk6srIKbQnaqZ13R
	GB4A==
X-Gm-Message-State: ALoCoQkHqZPzzIdiSjjkEL2sZRmmjrB4wt5R6AmcVeVk9yBqJvmFp+e0kAUFD7/viF6NEBcfaAZP
X-Received: by 10.180.94.196 with SMTP id de4mr16903202wib.16.1395686257047;
	Mon, 24 Mar 2014 11:37:37 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id fs8sm41449751wib.8.2014.03.24.11.37.33
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:34 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id C52F856157D; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:23 +0000
Message-Id: <16e6fc6e0492f4ebd5f18bd236478b6f9f778a1e.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
References: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Cc: Amit Kumar Chaudhary <amit@floatingpondtech.com>
Subject: [PATCH 13/18] toaster: combine ready functions
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
X-List-Received-Date: Mon, 24 Mar 2014 18:37:37 -0000

From: Amit Kumar Chaudhary <amit@floatingpondtech.com>

Merge the code into single ready function.

[YOCTO #4283]

Signed-off-by: Amit Kumar Chaudhary <amit@floatingpondtech.com>
---
 lib/toaster/toastergui/static/js/main.js | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/main.js b/lib/toaster/toastergui/static/js/main.js
index 07aba3d..7f897d2 100644
--- a/lib/toaster/toastergui/static/js/main.js
+++ b/lib/toaster/toastergui/static/js/main.js
@@ -90,9 +90,6 @@ $(document).ready(function() {
         });
     });
 
-});
-
-$(document).ready(function() {
     //toggle the errors and warnings sections
     $('.show-errors').click(function() {
         $('#collapse-errors').addClass('in');
@@ -110,4 +107,5 @@ $(document).ready(function() {
     if (location.href.search('#warnings') > -1) {
         $('#collapse-warnings').addClass('in');
     }
+
 });
-- 
1.8.3.2


