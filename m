Return-Path: <ross.burton@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 54CD265E05
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Jun 2014 10:07:26 +0000 (UTC)
Received: by mail-wi0-f176.google.com with SMTP id n3so5047057wiv.9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Jun 2014 03:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=5ZbtE6oS0RSqHgUSaKQ2VN5GKBkm6F9T/EoZqjrUD0Q=;
	b=J05xeSBK3M93gdiTb/w7GBC1EBUDR6iQq2QGQut6SYp8iS1kPkPBQXhqXQfTwf7S6Z
	oMtAtWB7yqIpJbjROPKDr6en3ZIwhmV9QIDqTpB+9NiD85Z300sEhZL15xtvkzLH9FC0
	FHGDthSOwZcsg+KPjfRedF9KZy30VbT4uUCZaAlVWt3IbBQuJ5AkrttsO6cTM+qxMqIX
	E9pk8yH+10RRmNK7OJa6jrUsYSJ0M9/q/ln3TIyG3v3AAUXZq/G4icKcdALK7TDxwrwt
	s7+GOu6Z9jHSBxFy5cSW36x4wkRFxRyfQbnVti9QFly3Oi0b4bQnb0mUqgDHkT1N8ROM
	4TJA==
X-Gm-Message-State: ALoCoQkp7ASivwayUUgpnW3FEoi80fAF3mGCz2d1PXq3SjX56O4vwTZWdMKAoWRxEpXyEXKgnA9z
X-Received: by 10.194.110.10 with SMTP id hw10mr22814467wjb.81.1402481246464; 
	Wed, 11 Jun 2014 03:07:26 -0700 (PDT)
Received: from melchett.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
	by mx.google.com with ESMTPSA id vc2sm33522760wjc.2.2014.06.11.03.07.25
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 11 Jun 2014 03:07:25 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Jun 2014 11:04:44 +0100
Message-Id: <1402481084-13848-2-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402481084-13848-1-git-send-email-ross.burton@intel.com>
References: <1402481084-13848-1-git-send-email-ross.burton@intel.com>
Subject: [PATCH 2/2] bb/utils: fix contains_any()
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
X-List-Received-Date: Wed, 11 Jun 2014 10:07:33 -0000

"set1 in set2" doesn't do what you'd expect, and if it did do a subset test
that's not the logic required by contains_any().

Instead get the intersection of checkvalues and val and check if the resulting
set is empty or not (by evaluating it in a boolean context), which tells us if
there are any elements in common.

Based on a patch by Valentin Popa <valentin.popa@intel.com>.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/utils.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 96d8218..f62709b 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -851,7 +851,7 @@ def contains_any(variable, checkvalues, truevalue, falsevalue, d):
         checkvalues = set(checkvalues.split())
     else:
         checkvalues = set(checkvalues)
-    if checkvalues in val:
+    if checkvalues & val:
         return truevalue
     return falsevalue
 
-- 
1.7.10.4


