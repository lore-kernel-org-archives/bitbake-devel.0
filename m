Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
	[74.125.82.170])
	by mail.openembedded.org (Postfix) with ESMTP id 820D865D4A
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Apr 2014 13:17:43 +0000 (UTC)
Received: by mail-we0-f170.google.com with SMTP id w61so2476311wes.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Apr 2014 06:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=DrycGPLvvdKOe9uYcnvoC9gLDCGR9m+7X1ONr+iiki8=;
	b=cvHrCN83U47fBvWcnYAtdJJNMn/vQ8FPW+HiTMP0bAJ9YjtkjGDjxPtLBd7MbeqqVC
	1QwVqKq5C0lg1GBTOY73m/barMMIdULyNb0tp7xIEzEjpZK7OSg4jPY7lyDrMa0UHgJU
	UluBeDF5s1ai8lEW2e4pEuH5+zfD1ZWWBO93bc9PZ9ttQ/1JXrWCbEs9TtaDdL+k4y5Z
	6rRymokjr0NLHPIzXXrhJuGSBTUlmfruUKQfGCnYm7RDYy9JAoXD9lshx7Xrg1jr2sbW
	EHdhq9kCYibitaH9MsMc6ycIGYxN5UQLnTdQjBj6GIbHa2kQGo6dRnsWv6j8hSbtDY4T
	bzKw==
X-Gm-Message-State: ALoCoQnKouVvRZqhXaWyTVCwx2RZAZX/nGTQW8pIUaBkwRPPbCtv8cpd3ckLkvpuJxsLy4Z2R3ll
X-Received: by 10.180.7.227 with SMTP id m3mr9828369wia.59.1397049463769;
	Wed, 09 Apr 2014 06:17:43 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ct2sm1650208wjb.33.2014.04.09.06.17.41
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Apr 2014 06:17:42 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 73146560234; Wed,  9 Apr 2014 14:17:41 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Apr 2014 14:17:33 +0100
Message-Id: <586cd2f6af11cd316a12799b2b9d031e8b7098b6.1397049329.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c93e5ca809d9c335b0cf35dcad4705487414c71b.1397049329.git.alexandru.damian@intel.com>
References: <c93e5ca809d9c335b0cf35dcad4705487414c71b.1397049329.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1397049329.git.alexandru.damian@intel.com>
References: <cover.1397049329.git.alexandru.damian@intel.com>
Cc: Dave Lerner <dave.lerner@windriver.com>
Subject: [PATCH 2/9] toaster: disable 'size over total' sort
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
X-List-Received-Date: Wed, 09 Apr 2014 13:17:45 -0000

From: Dave Lerner <dave.lerner@windriver.com>

[YOCTO 6061]

Disable size-over-total table column sorts in the image installed
packages view because that field is a computed field and only model
fields are sortable in the current table toaster implementation.

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
---
 lib/toaster/toastergui/views.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 910b3b9..96ce4d7 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -568,8 +568,6 @@ def target(request, build_id, target_id):
                 {
                     'name':'Size over total (%)',
                     'qhelp':'Proportion of the overall included package size represented by this package',
-                    'orderfield': _get_toggle_order(request, "size"),
-                    'ordericon':_get_toggle_order_icon(request, "size"),
                     'clclass': 'size_over_total',
                     'hidden' : 1,
                 },
-- 
1.9.1


