Return-Path: <michael.g.wood@intel.com>
Received: from mail-wj0-f182.google.com (mail-wj0-f182.google.com
	[209.85.210.182])
	by mail.openembedded.org (Postfix) with ESMTP id BEEDD71B3F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 11:20:25 +0000 (UTC)
Received: by mail-wj0-f182.google.com with SMTP id v7so30972922wjy.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 03:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=QBXRQy6vvTXt0/ZJ9C+S7tHy4QjkZMpIrFZ4ciJtpEc=;
	b=M9/tn0iKx/9NrM7tcY2miCgt3HkPCIkkgoLv5wStz5QxvS0N6VHdxY10+5dmrfNG9o
	H8LZ7dHY2whUTP/ZglQgonY8wWevYLaSFOMWhWfJcQyo6ULrEJ24DIOHiqboN9aKwRZa
	9nkUl0mGwczl/qANEQERShiZeAse/Fq85fzOMyGLrjEnk0KTkC/y1kTZeXu0Rp15jQns
	uwHdssTSqmkf6+m3MVV6nsQ6Lw8CjylLErGFrQmm8DF88UifKwCqNTYtKjWTnbpGLx4M
	E0HfFEAA5nEXKpM3wACnr5jMKQAs15sRxbBYqM7vKW96wIBk8qTvGUDPK7OExRg4MneU
	Rycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=QBXRQy6vvTXt0/ZJ9C+S7tHy4QjkZMpIrFZ4ciJtpEc=;
	b=mJT78m+rdArISN/Xc9lgbY68DzBEc0nalkcc4ZEtByo2rZW30NFChgVPPVCdTHVWJV
	XTQPdrRyaUyHriscFK07JduIQNH+w+IhQKRXqn8X3ream+LIK+MKi+SOU00Ck+bAf2ES
	nTmazXU0L2/ZVbBsiuT1Mi8LLS1OmagGaYcZGPBFXPwlNsJgyfensANPRBKADOtIU2Mh
	kXReDfXYM0MtOhgipX/rtPEbVWDharSXlIBFp+8w84vMXZwZqnf30VC8RifYxxzFJB2N
	ZECp3dWd/SG4+YUkEiAR0aa2THZp7ziQ+m5hLyEzga1FZ9wFyskBV2wQxn9ts7cAazVP
	DOxA==
X-Gm-Message-State: AKaTC025CG5BT1vvAn6RDfYhwRr3Gkv38VWRJLKMZWp/41sB3/gkpm1KlTUe6PiR6YbdSFhs
X-Received: by 10.194.8.226 with SMTP id u2mr1785209wja.91.1479986427013;
	Thu, 24 Nov 2016 03:20:27 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	g184sm7696900wme.23.2016.11.24.03.20.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 24 Nov 2016 03:20:26 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 11:19:57 +0000
Message-Id: <1479986406-4657-7-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
References: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 06/15] toaster: tablejs Fix missing close square bracket
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
X-List-Received-Date: Thu, 24 Nov 2016 11:20:27 -0000

From: "Reyna, David" <david.reyna@windriver.com>

There is a missing close square bracket.

[YOCTO #10631]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/static/js/table.js | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index 176ce57..aaa3e1f 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -706,7 +706,7 @@ function tableInit(ctx){
             if (action) {
               // Setup the current selected filter; default to 'all' if
               // no current filter selected
-              var radioInput = action.find('input[name="filter"]');
+              var radioInput = action.find('input[name]="filter"]');
               if ((tableParams.filter &&
                   tableParams.filter === radioInput.val()) ||
                   filterActionData.action_name == 'all') {
-- 
2.7.4


