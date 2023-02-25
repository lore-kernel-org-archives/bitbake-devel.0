Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F3FC64EC7
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 16:50:39 +0000 (UTC)
Received: from a11-6.smtp-out.amazonses.com (a11-6.smtp-out.amazonses.com [54.240.11.6])
 by mx.groups.io with SMTP id smtpd.web11.47255.1677342967918073631
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Feb 2023 08:36:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@richelberger.com header.s=5u2mht5g5nbgnd5xxu4iibla5zobc5bd header.b=iTGNEoyy;
 spf=pass (domain: amazonses.com, ip: 54.240.11.6, mailfrom: 01000186896e845c-37272abb-a04f-4c1e-87ef-c0007b322ca0-000000@amazonses.com)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=5u2mht5g5nbgnd5xxu4iibla5zobc5bd; d=richelberger.com;
	t=1677342967;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id;
	bh=nWAxN80icACbBKqKGZdCqNq37bH69WjmNodOp54erRs=;
	b=iTGNEoyy23DuLzye6jJufeEiPHPfZwYG8aWV3kuT8NtumDq2ExpV2TdJ3uE2nnRu
	dvmqCEYmdurjZUDJSk+4RY6hhtzwjPztmVJe8tWPd1m8eEZ2WY/BeFtLCuxBuKzOC1Y
	cQWtovlFLSYWarClVcbBX9LbQxK1LGebCFMXfj68=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1677342967;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id:Feedback-ID;
	bh=nWAxN80icACbBKqKGZdCqNq37bH69WjmNodOp54erRs=;
	b=iWp+/OwLmYjoIYTF0vbEv3HLQJBsEwy0K2c66YFMt7rFWNo9GnJdcKEnl6s5OauK
	2co9dXBvdwTGT2IyfgbzYwTQq6i7sRX1/4iaXAt7klQbX1afrjPUcsG6mLCFBAd6WYY
	owBNipDRiZsMmFB63LP7VsaI7EdKaSRqinoCumlQ=
Subject: [PATCH] documentation: bitbake: add file-checksums to varflags section
From: "Richard Elberger" <rich@richelberger.com>
To: =?UTF-8?Q?bitbake-devel=40lists=2Eopenembedded=2Eorg?=
  <bitbake-devel@lists.openembedded.org>
Cc: =?UTF-8?Q?docs=40lists=2Eyoctoproject=2Eorg?=
  <docs@lists.yoctoproject.org>, =?UTF-8?Q?Richard_Elberger?=
  <rich@richelberger.com>
Date: Sat, 25 Feb 2023 16:36:06 +0000
Mime-Version: 1.0
References: <20230225163601.377422-1-rich@richelberger.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHZSTdAIrouy/VPT9qxy+VNpMFPdw==
Thread-Topic: [PATCH] documentation: bitbake: add file-checksums to varflags
 section
X-Original-Mailer: git-send-email 2.34.1
X-Wm-Sent-Timestamp: 1677342965
Message-ID: <01000186896e845c-37272abb-a04f-4c1e-87ef-c0007b322ca0-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2023.02.25-54.240.11.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Feb 2023 16:50:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14493

Fixes [YOCTO #11605] by:=0D=0A=0D=0A- Adding definition of file-checksums=
 to Variable Flags section.=0D=0A- Describe data to add to list which add=
s external file dependencies.=0D=0A- Write example on usage to prepend a =
value to file-checksums list.=0D=0A=0D=0ASigned-off-by: Richard Elberger =
<rich@richelberger.com>=0D=0A---=0D=0A .../bitbake-user-manual-metadata.r=
st            | 17 +++++++++++++++++=0D=0A 1 file changed, 17 insertions(=
+)=0D=0A=0D=0Adiff --git a/doc/bitbake-user-manual/bitbake-user-manual-me=
tadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst=0D=0A=
index deb7afad..ba8129af 100644=0D=0A--- a/doc/bitbake-user-manual/bitbak=
e-user-manual-metadata.rst=0D=0A+++ b/doc/bitbake-user-manual/bitbake-use=
r-manual-metadata.rst=0D=0A@@ -1496,6 +1496,23 @@ functionality of the ta=
sk:=0D=0A    directory listed is used as the current working directory fo=
r the=0D=0A    task.=0D=0A=20=0D=0A+- ``[file-checksums]``: Controls the =
file dependencies for a task. The=0D=0A+  baseline file list is the set o=
f files associated with=0D=0A+  :term:`SRC_URI`. May be used to set addit=
ional dependencies on=0D=0A+  files not associated with :term:`SRC_URI`.=0D=
=0A+=0D=0A+  The value set to the list is a file-boolean pair where the f=
irst=0D=0A+  value is the file name and the second is whether or not it=0D=
=0A+  physically exists on the filesystem. ::=0D=0A+=0D=0A+    do_configu=
re[file-checksums] +=3D "${MY_DIRPATH}/my-file.txt:True"=0D=0A+=0D=0A+  I=
t is important to record any paths which the task looked at and=0D=0A+  w=
hich didn't exist. This means that if these do exist at a later=0D=0A+  t=
ime, the task can be rerun with the new additional files. The=0D=0A+  "ex=
ists" True or False value after the path allows this to be=0D=0A+  handle=
d.=0D=0A+=0D=0A -  ``[lockfiles]``: Specifies one or more lockfiles to lo=
ck while the=0D=0A    task executes. Only one task may hold a lockfile, a=
nd any task that=0D=0A    attempts to lock an already locked file will bl=
ock until the lock is=0D=0A--=20=0D=0A2.34.1=0D=0A=0D=0A

