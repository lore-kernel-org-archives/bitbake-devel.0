Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B53DCDB474
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 20:32:21 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.266957.1697574733254691000
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Oct 2023 13:32:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=tfPgX2o9;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 345549C31D0
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Oct 2023 16:32:12 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id E9jl6Cfhew8A; Tue, 17 Oct 2023 16:32:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9F4DB9C3216;
	Tue, 17 Oct 2023 16:32:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 9F4DB9C3216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1697574731; bh=JeeBUyIcUA1mVmmYNPXxJR3a5c2vwTE/2j5ArGGQitw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=tfPgX2o9OxSkoteGAJ5o7DcT9raP3FErn1TpsmSLOTD/d4hu7Lm9qS7XefHovAj5Y
	 KEZv0wWjDhwMjt29SYZ03XpREOc4UuX6nLKb//y1cXgPCSUhKGy8LYx+eevlrzJ8FU
	 +Ai9Sag5tGqyCh26VgpJNBjDyG+CHlsJndTAhU3PW32uoLZ3NxuN83ez4eBVXLVQO9
	 h9N98uAsf5T/KtXbQ02kkGSzEnn+Q/Llsf5eDG/WOxNhB5vJCPefyp4RWMD0Ik/62T
	 RqQq4ADfkqSwzIE6ZANYIKfwbZ89+dMst3jQjOYI+p+lHbX0TLqdqXUI/Q9WzupFNq
	 vdieDqGunFoRA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id DFYjdXTeopeV; Tue, 17 Oct 2023 16:32:11 -0400 (EDT)
Received: from jedi.. (unknown [196.117.75.249])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id BFBBC9C31D0;
	Tue, 17 Oct 2023 16:32:10 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH] Toaster: bug-fix on /toastermain/logs.py
Date: Tue, 17 Oct 2023 21:32:05 +0100
Message-Id: <20231017203205.378376-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Oct 2023 20:32:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15254

- Update /toastermain/logs.py to fix:
AttributeError: 'NoneType' object has no attribute 'view_name'

Signed-off-by Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/toastermain/logs.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastermain/logs.py b/lib/toaster/toastermain/lo=
gs.py
index f9953982..b4910e44 100644
--- a/lib/toaster/toastermain/logs.py
+++ b/lib/toaster/toastermain/logs.py
@@ -38,8 +38,13 @@ def log_view_mixin(view):
             request =3D kwargs.get('request')
=20
         response =3D view(*args, **kwargs)
+        view_name =3D 'unknown'
+        if hasattr(request, 'resolver_match'):
+            if hasattr(request.resolver_match, 'view_name'):
+                view_name =3D request.resolver_match.view_name
+
         log_api_request(
-            request, response, request.resolver_match.view_name, 'toaste=
r')
+            request, response, view_name, 'toaster')
         return response
     return log_view_request
=20
--=20
2.34.1


