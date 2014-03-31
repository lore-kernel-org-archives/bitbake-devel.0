Return-Path: <joe@deserted.net>
Received: from mail-qg0-f44.google.com (mail-qg0-f44.google.com
	[209.85.192.44])
	by mail.openembedded.org (Postfix) with ESMTP id 2E1F060DFA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 20:44:29 +0000 (UTC)
Received: by mail-qg0-f44.google.com with SMTP id a108so7888790qge.17
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 13:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=vCh6gsONVXOruU83A/JNW3iixwrDqdHSx5tc/uKcbUc=;
	b=Gn/9PdhLp3iSruXa5S/7jv8Yh0Z5pmYJZxRhyoF0ereZ9ooSgPzWI9s0F6zZIBS1mw
	xw2e9jSEmlOEXKQTzr6UIgjthGpQMPt2DU72mUGo/cs80MHY2EAPa6jBUCaPNEbFRYGf
	2lfD6a1PxNPwowaazWiWcVzZYdYB6+rP6cA5n/v0aPdIF6AkMJzEhSrg9I0uT1hEOctl
	ebJTLb9jyCjEJZ/NS2RnXd4ZHCOabMafFmBrICS0ERKnDNgMibxQVGLe1It7FerSkQfZ
	a8YLb1aVpYC/rR/AZD5wCNxWdgOp55iixzscl/PrNGIQIPZKfyTDfqn7jHui7GtqLQrd
	KZqw==
X-Gm-Message-State: ALoCoQnhxQzqaGQLPUSm3A5byqicQQiMVQ6wPj7O97VPZRYn0Gva8LLYt7Wmp69jIUcCIon4sQwr
X-Received: by 10.224.14.14 with SMTP id e14mr10395841qaa.80.1396298670384;
	Mon, 31 Mar 2014 13:44:30 -0700 (PDT)
Received: from burninator.local ([128.224.252.2])
	by mx.google.com with ESMTPSA id p2sm30445725qah.38.2014.03.31.13.44.29
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 31 Mar 2014 13:44:29 -0700 (PDT)
From: joe@deserted.net
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Mar 2014 16:44:27 -0400
Message-Id: <1396298667-17975-1-git-send-email-joe@deserted.net>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH] bitbake: parse: allow vars_from_file to consider inc files as recipes
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
X-List-Received-Date: Mon, 31 Mar 2014 20:44:31 -0000

From: Joe MacDonald <joe@deserted.net>

A side-effect of making vars_from_file return None for non-recipes is that
PV gets 'None' if you have an included file named <recipe>.inc.  If there
is a recipe with a version number in the name for a .inc file, it's
probably reasonable to calculate PV based on that file, rather than giving
it 'None' (which becomes 1.0 in most cases).

Signed-off-by: Joe MacDonald <joe@deserted.net>
---
 bitbake/lib/bb/parse/__init__.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

I ran into this when building meta-selinux where there's a chain of includes:

   refpolicy-mls_2.20130424.bb
    -> refpolicy_2.20130424.inc
      -> refpolicy_common.inc

refpolicy_2.20130424.inc sets FILESEXTRAPATH to pick up patches out of the
refpolicy-2.20130424 directory, but during the build PV would be 2.20130424 only
until the .inc file was included, then it became 1.0 and the patches were never
found.


diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index e4a44dd..5157d80 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
@@ -127,7 +127,7 @@ def resolve_file(fn, d):
 # Used by OpenEmbedded metadata
 __pkgsplit_cache__={}
 def vars_from_file(mypkg, d):
-    if not mypkg or not mypkg.endswith((".bb", ".bbappend")):
+    if not mypkg or not mypkg.endswith((".bb", ".bbappend", ".inc")):
         return (None, None, None)
     if mypkg in __pkgsplit_cache__:
         return __pkgsplit_cache__[mypkg]
-- 
1.7.10.4


