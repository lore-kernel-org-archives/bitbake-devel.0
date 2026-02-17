Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B223BE909AC
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 13:36:46 +0000 (UTC)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11924.1771335398290646471
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Feb 2026 05:36:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=A9xRRtxb;
 spf=pass (domain: 0leil.net, ip: 83.166.143.169, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fFgfD1zyDz1Sr;
	Tue, 17 Feb 2026 14:36:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1771335396;
	bh=TIpo6dlJKBEOICrDq6vDAMhB5nfAvlTPduYYwR9+no4=;
	h=From:Subject:Date:To:Cc:From;
	b=A9xRRtxbSUQjOzJPDNC2Uq6jd5DaiE5wMPONGO2JyieH8fjCSy23zYURitbhxqBxj
	 VPBxQkaYecgmP4n2uCr+vjd4XRCvk+AlnAA/s4ugnUW4p+aJR828bqWqQwJaAkQyn/
	 DgxlNtUUgl+TmIKh8DhzmSwse4naHKnnFqwJxlJniuF0T9tnWKO8UYBOCA9Jaw2Hid
	 +8PqMjfiPI2QW7kd+0gQJzcTXA4KeWKBjN8CEMilGBj4hgoU5Ll4kQp7puGTwzWkjb
	 KXMVpKUM6ZAFqUWo5fFgU49SxZYu9+s6s4MrH65GM2oTCZ3LNLHlFGsqmeTexoSW/D
	 nDIFqCpFoUi4A==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fFgfC3KJTzY80;
	Tue, 17 Feb 2026 14:36:35 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH v3 0/5] doc: bitbake-user-manual-ref-variables: clarify
 BBMASK examples
Date: Tue, 17 Feb 2026 14:36:26 +0100
Message-Id: <20260217-bbmask-slashes-v3-0-6a02cde9fdab@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBQFf4V0bQ0t0AZX/odx0cetrQ8wvdhIC
 P8uxQ2JcTnJmTkTQYgBkByKiURIAUPfLVDtCmK86i5Ag12Y8JKLkjNGtX4ovFG8K/SAVIJqy1o
 7UdWSLNIzggvvNXg6fxlf+gpmyJW88AGHPo7rY2J59zeeGC2plpwJZkQtwR2NhxjHvQWS44lvd
 fGj86y3WjfcNc5WdqvP8/wBK+gyIf0AAAA=
X-Change-ID: 20260211-bbmask-slashes-7ea904bf6347
To: bitbake-devel@lists.openembedded.org
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, docs@lists.yoctoproject.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Feb 2026 13:36:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19054

Robert reported being confused by the leading slash inconsistencies in
our BBMASK examples and wondered if it had any significance. Myself not
being less confused, I went reading the code and testing, and it does
have significance, so this tries to explain the difference and why you
would want a leading slash in most cases.

It also explains that still with only a leading slash there could be
involuntary matches, which one should be able to get rid of by using
BBFILE_PATTERN from the layer they want to mask recipe or append files
from.

While at it, update the meta-ti example such that it matches what's
currently in the repo (migrated in kirkstone from a single meta-ti git
repo layer to a meta-ti git repo with multiple layers, such as
meta-ti-bsp).

This reorganizes examples such that the ones with BBFILE_PATTERN are the
ones we provide as first examples as those are the ones users should
typically be using such that the masks only apply to a specific layer.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- switched to a list to explain the multiple matching rules for the
  example with multiple BBMASK such that it's easier to digest,
- added missing words here and there,
- reworded the openldap explanation to make it clear it matches
  everything under an openldap directory,
- added missing naming scheme for optee file match rule,
- switched absolute paths from /builds/ to /bitbake-builds/poky-master/
  such that it matches the layout when using bitbake-setup,
- Link to v2: https://patch.msgid.link/20260216-bbmask-slashes-v2-0-b9bb52f5fd3d@cherry.de

Changes in v2:
- added patch 5,
- completely reorganize patch 3 such that the examples with
  BBFILE_PATTERN are the ones provided by default,
- Link to v1: https://patch.msgid.link/20260211-bbmask-slashes-v1-0-b72161c647ef@cherry.de

---
Quentin Schulz (5):
      doc: bitbake-user-manual-ref-variables: clarify BBMASK directory matching
      doc: bitbake-user-manual-ref-variables: have directory examples be consistent
      doc: bitbake-user-manual-ref-variables: expand and reorganize BBMASK explanations
      doc: bitbake-user-manual-ref-variables: update BBMASK example with current meta-ti
      doc: bitbake-user-manual-ref-variables: update Python re doc link to HTTPS

 .../bitbake-user-manual-ref-variables.rst          | 95 +++++++++++++++++++---
 1 file changed, 84 insertions(+), 11 deletions(-)
---
base-commit: 8b635a400152bb40beaa0d7a47181febb43f5c84
change-id: 20260211-bbmask-slashes-7ea904bf6347

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>


