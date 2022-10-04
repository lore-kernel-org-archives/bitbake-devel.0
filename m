Return-Path: <rg@braneaudio.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD34C433F5
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 22:20:00 +0000 (UTC)
Received: from p3plsmtpa07-02.prod.phx3.secureserver.net
 (p3plsmtpa07-02.prod.phx3.secureserver.net [173.201.192.231])
 by mx.groups.io with SMTP id smtpd.web12.17272.1664921990631614510
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 15:19:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: braneaudio.com, ip: 173.201.192.231,
 mailfrom: rg@braneaudio.com)
Received: from [192.168.0.22] ([70.112.164.231])
	by :SMTPAUTH: with ESMTPSA
	id fqGRoJg6FhDfIfqGUobXOc; Tue, 04 Oct 2022 15:19:50 -0700
X-CMAE-Analysis: v=2.4 cv=BZAdbph2 c=1 sm=1 tr=0 ts=633cb186
 a=S3BSAMYkHO6g4MQ2VxJkNg==:117 a=S3BSAMYkHO6g4MQ2VxJkNg==:17
 a=IkcTkHD0fZMA:10 a=EfASa0wiAAAA:8 a=Q4-j1AaZAAAA:8 a=yeyJmGBnnEQbqALXa4UA:9
 a=QEXdDO2ut3YA:10 a=Ogh1Um8Ajkq3hpB3iR5s:22 a=9H3Qd4_ONW2Ztcrla5EB:22
X-SECURESERVER-ACCT: rg@braneaudio.com
Message-ID: <ad8a8eb0-48b7-3d06-f8d3-ddab5747c4f9@braneaudio.com>
Date: Tue, 4 Oct 2022 17:19:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
From: Richard Greer <rg@braneaudio.com>
Subject: [bitbake-devel][PATCH v2] Change git lfs support to allow for
 destsuffix being set.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: 
 MS4xfDzSj+prTFLipVZoPkfVG4hNvwsmusVMoN/vYpQWSIU+rjSNk3ic+Hlj+s3n5U52IeF4kRdFPvJsJkQJtpGdJgLEPm31PBlgLUrZyMRne8AKbzfiUrR5
 jEnN82vvFK2UZJs8PvDXMwXfGgYVmp3AtZEpDCErFQG3tOEd+ntz9Q+ED+QD1qfYGtTj4FSZaqGVbLCHhUvDmW2CgSNVGc/n3N8=
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Oct 2022 22:20:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14024

From: Richard Greer<rg@braneaudio.com>

When getting large files with git lfs need to try and recreate the
path where the repo is actually located after the unpack.

If destsuffix or subdir (where subdir is not an absolute path) is
set then it will not be in tmpdir/git.

It looks like the more correct place would be in ud.destdir.

This does not address the issue where it will fail in the unpack
if subdir is an absolute path since it cannot possibly be in the
same path as the tmpdir.  I have no idea as to how to deal with
that.

Signed-off-by: Richard Greer<rg@braneaudio.com>

---
v1->v2
  * Try to get rid of improper line breaks.
  * Tried git send-email but could not get it to work with our mail
    server for any settings.
  * Tried routing it through gmail using personal account as a login,
    but it failed due to personal account not being subscribed to
    mailing list.  Do not really want to have my personal email
    subscribed either.
  * I do not see line breaks in patch from previous email in what I
    received from the mailing list, nor do I see it if I look at the
    post in Chrome on lists.openembedded.org.  So, I hope attempt two
    works since git send-email does not look like an option for me.
---
  bitbake/lib/bb/fetch2/git.py | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index f0df6fb69b..fa454a1c07 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -421,8 +421,8 @@ class Git(FetchMethod):
                  # Only do this if the unpack resulted in a .git/lfs directory being
                  # created; this only happens if at least one blob needed to be
                  # downloaded.
-                if os.path.exists(os.path.join(tmpdir, "git", ".git", "lfs")):
-                    runfetchcmd("tar -cf - lfs | tar -xf - -C %s" % ud.clonedir, d, workdir="%s/git/.git" % tmpdir)
+                if os.path.exists(os.path.join(ud.destdir, ".git", "lfs")):
+                    runfetchcmd("tar -cf - lfs | tar -xf - -C %s" % ud.clonedir, d, workdir="%s/.git" % ud.destdir)
              finally:
                  bb.utils.remove(tmpdir, recurse=True)
  
-- 2.34.1


