Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 98F1D72646
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 14:27:33 +0000 (UTC)
Received: by mail-wg0-f47.google.com with SMTP id n12so15085201wgh.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 06:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=hDa4zYZFYDJDeU+Hq7Qw34gCs+C28hpi4THARGk5u58=;
	b=Sl8cg+aVqZ4dvK39SUkO0eNPAhIYC/8dRm/9+DRzxiJ5I5O42aQKeuht8bFiVbFb33
	yBc9b7dlSCadgo+kAQvoCXyjj1dmROl68nAUwrgt6XBoWAz7bTnAXNUfxJh2G7XZs52F
	N8rvi8MhPx61SqipZPNUZL7+y4vn6xVjztJ62oExv7+zE892+ApVBksd3T5aXYMYzAEF
	r1sTNoDkZ2Yn2nDaLhfgyUIb5M6weIrGpVj39lVpdtLbO/5Zgn79sIaF2Spzwckb99qQ
	urzaelHb9vywjAXxuinW+Bc9Q/sU18MSG6QEAB8ln+fSWW06leXy2/5f4Y+aJO/sV3+G
	QLTA==
X-Gm-Message-State: ALoCoQkH1786QiqxUeJXRleJC1pIBnT8ZVmwDT/klOtV98cgxO7cL0O5kWxRBSrEBzNHBO9zq8FH
X-Received: by 10.194.90.143 with SMTP id bw15mr3304008wjb.132.1422368854132; 
	Tue, 27 Jan 2015 06:27:34 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id vq9sm2052579wjc.6.2015.01.27.06.27.32
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Jan 2015 06:27:33 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id A82B15622F7; Tue, 27 Jan 2015 14:27:36 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Jan 2015 14:27:25 +0000
Message-Id: <4fcea0aad1ac715d6eb104f60972007bc2289569.1422368757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
References: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1422368757.git.alexandru.damian@intel.com>
References: <cover.1422368757.git.alexandru.damian@intel.com>
Subject: [PATCH 04/14] toastergui: remove redundant style declaration
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
X-List-Received-Date: Tue, 27 Jan 2015 14:27:39 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The bottom margin for dd tags nested inside forms is
set twice. Delete one of them.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/css/default.css | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 5eeeea4..cb27342 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -184,7 +184,6 @@ a code:hover { color: #005580; }
 .control-group { margin-bottom: 0px; }
 #project-details form { margin: 0px; }
 dd form { margin: 10px 0 0 0; }
-dd form { margin-bottom: 0px; }
 dl textarea { resize: vertical; }
 .navbar-fixed-top {  z-index: 1; }
 .popover { z-index: 2; }
-- 
1.9.1


