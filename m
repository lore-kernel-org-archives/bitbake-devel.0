Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6E3FD7F9B
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 11:30:31 +0000 (UTC)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.93813.1772191827121198814
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Feb 2026 03:30:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=Bxcws0ut;
 spf=pass (domain: 0leil.net, ip: 45.157.188.9, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fMmN11qVWzmsX;
	Fri, 27 Feb 2026 12:30:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1772191825;
	bh=/wH0DUGlQZ/0iVzWlFa1rYOEN8Ux+vx7rBRd8o913Qk=;
	h=From:Subject:Date:To:Cc:From;
	b=Bxcws0utBwcCWvczJX65rqMhTgnNiMmYasCfpoP+ObQIf9KZdBNZD6rpTY9TM8u0G
	 LWEeX9JnB0YDAocB2PwcObF4QOZMghnNtmUqV3/iBu0lgMVCW7/0uecmhTMd0l71sc
	 5y+tyOCGG0jSyc4IfJjM12duwiIMgcUTYDJKzSW/SC8An2Gs33vAI8k+oFlC+Aw66U
	 0fReAua4daAHCueyt3kYWQHKjh0Zk4CFLOWjMSoWTkQh4Ey64/AS/GbAlzWIafxAP/
	 BmkwemMbQ8PygW8Cu2ZzzZiOUHqOyclVMZFxtHnsAKJ9YQ6lrT2x3zuqDZAq9YKKy+
	 +/8DftwhbrU5A==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fMmN02vVwz7B0;
	Fri, 27 Feb 2026 12:30:24 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH v2 0/2] doc: bitbake-user-manual-metadata: list known
 limitations for shell task
Date: Fri, 27 Feb 2026 12:30:14 +0100
Message-Id: <20260227-shell-invalid-v2-0-df5cec5718bd@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMywrDIBCF4VcJs64lXkiarvoeJQtxxjogSdEgD
 cF3r82+y//A+Q7IlJgy3LsDEhXOvC4t1KUDF+zyIsHYGlSvhl4qKXKgGAUvxUZGofSgJ2u80Y6
 gfd6JPH9O7zm3Dpy3Ne0nX+Rv/ScVKaTQaCb0DsebHR8uUEr7FQnmWusXoKuXcqoAAAA=
X-Change-ID: 20260121-shell-invalid-23639a4f43ce
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 Javier Tia <javier.tia@linaro.org>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Feb 2026 11:30:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19087

This fixes an inconsistency regarding the (sub)subsection level used for
all directives, which inherit_defer doesn't respect.

This adds a section for listing limitations for the BitBake shell
parser.

It does seem we have other limitations, specifically everything after
the parameter expansion table[1]. Only ${#parameter} does something,
returning 0, the others return the empty string instead. Maybe we want
to add that to the limitations?

[1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- added patch 1 which promote inherit_defer directive subsubsection into
  a subsection to match other directives,
- fixed embedded anonymous link syntax by not using one at all,
- removed bashism example from limitations subsubsection,
- added bashism-replacement example next to where we specify tasks are
  run with /bin/sh,
- Link to v1: https://patch.msgid.link/20260121-shell-invalid-v1-1-3d49dfcd78a7@cherry.de

---
Quentin Schulz (2):
      doc: bitbake-user-manual-metadata: promote inherit_defer directive to subsection
      doc: bitbake-user-manual-metadata: list known limitations for shell tasks

 .../bitbake-user-manual-metadata.rst                 | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)
---
base-commit: bc8be83aef0a6de85cd33a6f132f281d518594f7
change-id: 20260121-shell-invalid-23639a4f43ce

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>


