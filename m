Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id EE4F275692
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:15:39 +0000 (UTC)
Received: by wgme6 with SMTP id e6so37726055wgm.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=vmJQASNGTZgvbQfQigLBDB5i9aPyWht11MYOHshvx8k=;
	b=l6h2n8CJhWBA9cEN4EuH206vK97AElQyNzvNkMT7nJpV8tddMIBAGLQKs4xZtb/wCO
	x31rxE4uwx74GlyUjce9Cx4zpVBF+Tr95j9MDsqwGjGXfzEd6/0h+91WwxWHvlLfk493
	jR65iMmz7a4bzLJqRGt7KZ0ywW8w2DCwNAO65Cr1MkLl0kHN1MRMWM44tW7d5rgII6no
	QEWZUvvDca8jZhEDYV2MeQiSp3wtH2AbCGC0eO32uGSb9oU+aQSMWrP6ILVr4oRcazCH
	bH8UwmSuRaPB81iEgn6VoCXF4yffL76MqrDfH+8beukkB9WcwOjkhPYwx7Y+rFetRpPB
	JE3Q==
X-Gm-Message-State: ALoCoQkVqzScwTTj6rdrMkQOk3yLVp+XnUeE11dLepB00k46cUFCXv7Ojjt1XoSFMlDJQVehSBap
X-Received: by 10.180.95.67 with SMTP id di3mr16234786wib.78.1432822540238;
	Thu, 28 May 2015 07:15:40 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id x3sm8752834wiy.20.2015.05.28.07.15.39
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:15:39 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id BFFCC561210; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:14:01 +0100
Message-Id: <bec0c7705643f5cb3007c072a7d81b88c6bb2a5e.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 07/22] toaster: Fix toastertable header
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
X-List-Received-Date: Thu, 28 May 2015 14:15:40 -0000

From: Michael Wood <michael.g.wood@intel.com>

Fixes regression introduced by 'tables updates for HTML5 compliance'

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/toastertable.html | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/toastergui/templates/toastertable.html b/lib/toaster/toastergui/templates/toastertable.html
index 21392bb..4e6c4ce 100644
--- a/lib/toaster/toastergui/templates/toastertable.html
+++ b/lib/toaster/toastergui/templates/toastertable.html
@@ -93,6 +93,7 @@
   <!-- The actual table -->
   <table class="table table-bordered table-hover tablesorter" id="{{table_name}}">
     <thead id="tableheader">
+      <tr><th></th></tr>
     </thead>
     <tbody></tbody>
   </table>
-- 
1.9.1


