Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7499C36010
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 19:00:15 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.5067.1743793208951427642
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Apr 2025 12:00:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=WgwlwS/X;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-256628-20250404190005d351f399c946951015-mbxdzt@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250404190005d351f399c946951015
        for <bitbake-devel@lists.openembedded.org>;
        Fri, 04 Apr 2025 21:00:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=RyB8R4P/gOD+IOG5KkdjHvxtI5x+jgVbWqj9WPYuoqc=;
 b=WgwlwS/Xl46i3rmax/cWwpdAWNPAkZpghkptdUeEB/37yz7svWVf3WXzFqlC6tGgmkurxv
 CUw0+jfp9VqnHczhVaE2hqNVxCl580qziGL87VYhu5s3CIvpEWHqS24RwgR6/W3Qg7Noc9LA
 VrXtNV2Cj85kwvaZIuQEArruDT8GcTQjbeQJcpJ+P0cZl41PF6zVJAt4dQeknHFu/htwTlJR
 muC5FBQXXNGXmomB5UYNoh/9DJNxEnolczB3iUTliTdr7aGJrZCuoECvo/Cd1q+WCvpsR92Q
 tqOpFDqRzH2sTdsRKQPstWUXPhtnJGmOMx30G9UsGncHkErgoUqYqpuA==;
From: Peter Marko <peter.marko@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [PATCH 1/2] fetch/git: always fetch lfs when creating shallow tarball
Date: Fri,  4 Apr 2025 20:59:10 +0200
Message-Id: <20250404185911.137153-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 04 Apr 2025 19:00:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17518

From: Peter Marko <peter.marko@siemens.com>

Before fast shallow tarballs the shallow tarball with lfs worked only
if the original .../downloads/git2/... directory existed. Once it was
not there, do_unpack on shallow tarball without lfs files failed due to
disabled network.
It was fixed for fast shallow tarballs and this commit fixes the other
scenarios, too.

This can happen when such shallow tarball is put to mirror or if
someone does cleanup to reclaim disk space.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 bitbake/lib/bb/fetch2/git.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 5f4ec6128c..587a16994a 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -634,9 +634,8 @@ class Git(FetchMethod):
 
         runfetchcmd(fetch_cmd, d, workdir=dest)
         runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision), d, workdir=dest)
-        # Fetch Git LFS data for fast shallow clones
-        if not ud.shallow_skip_fast:
-            self.lfs_fetch(ud, d, dest, ud.revision)
+        # Fetch Git LFS data
+        self.lfs_fetch(ud, d, dest, ud.revision)
 
         # Apply extra ref wildcards
         all_refs_remote = runfetchcmd("%s ls-remote origin 'refs/*'" % ud.basecmd, \

