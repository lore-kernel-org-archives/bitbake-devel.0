Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E440E81BB1
	for <webhook@archiver.kernel.org>; Mon,  9 Feb 2026 13:09:39 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47005.1770642577244493048
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Feb 2026 05:09:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=VmQtmheq;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DF25BC23D87;
	Mon,  9 Feb 2026 13:09:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0C1A56074B;
	Mon,  9 Feb 2026 13:09:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B21B1119D066A;
	Mon,  9 Feb 2026 14:09:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770642574; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8TTrY4YpkRXAeuT3yoHSW06YFbk8hrIjHpBZfIsx93A=;
	b=VmQtmheq6Ogbc4aWaDiYrXdy3NVioJhzMai7etS3Gcd+CWCVe//zTuU96mmuiFb4wnfrtq
	c82dbfIszh0BJWeTz0YO8ohxJ8z2iGK/e6piJ/tiwBmP5r1XVUvRH/NirM7iL/bUI0+XNW
	o2qq+FzwY/2CwLDXPw81NRi0aH89E/qt+YrPQc9KVqFl8lZYKfQ9Gwq0VkreMNJKSRCKH/
	jesfSJF+SGzunpAiZIMM7PsGipnb2IQ1PpL5bzTzB6xDlE1kxnOimCNMujTzTU9G2YXbNF
	kvHQ/wpY6L3pVjTwi/RdQU0F7b1ziKlMry3Qqgs1QHMPMc17fg6PJf7k6zXHwQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Feb 2026 14:09:33 +0100
Message-Id: <DGAGEOPPKN0O.1PO5OD6RTZXLX@bootlin.com>
To: <alex.kanavin@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v3 2/2] bitbake-setup: share sstate by
 default between builds
Cc: "Alexander Kanavin" <alex@linutronix.de>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20260129120421.4413-1-alex.kanavin@gmail.com>
 <20260129120421.4413-2-alex.kanavin@gmail.com>
In-Reply-To: <20260129120421.4413-2-alex.kanavin@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 13:09:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18989

On Thu Jan 29, 2026 at 1:04 PM CET, Alexander Kanavin via lists.openembedde=
d.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>
> Nowadays sharing sstate must also include sharing the hash equivalency
> information and thus, managing a hash equivalency server. There are
> two ways to do it:
>
> - starting/stopping the server outside the bitbake invocations, and
> guaranteeing that it's available when bitbake is invoked.
>
> - using bitbake's built-in start/stop code which launches a server
> before a build starts and stops it when a build is finished; essentially
> this is a private server, using a database private to a build directory
> (by default).
>
> I couldn't come up with a good way to do the first option in bitbake-setu=
p:
> it needs to be invisible to users, they should not have to run special co=
mmands
> and they should not wonder why there is a mysterious background process.
> It's not impossible to auto-start a shared server, but that will quickly
> run into synchronization issues: if one server is being started, another
> should not be started at the same time. If one server is shutting down
> (e.g. after an inactivity timeout), another starting server should wait
> until it frees the socket, and block all bitbake invocations on that.
> Memory resident bitbake does this in lib/bb/server/process.py with a lot =
of
> complexity, and I don't think it should be added to the hash server as we=
ll.
>
> On the other hand, hash equivalency database is sqlite-driven, and sqlite
> documentation reassures that sharing it between different simultaneous
> processes is okay: nothing will get lost or corrupted: https://sqlite.org=
/faq.html#q5
>
> I've confirmed this by running simultaneous builds that way: nothing
> unusual happened, and sstate was shared as it's supposed to.
>
> There's a new setting that turns off this behavior for situations
> where the server and sstate are managed externally.
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---

Hi Alex,

I noted some performance regression on the autobuilder with this patch.
I did not had time to fully investigate the underlying reasons so far,
but I'm fairly convinced they were introduced by this change.

This is visible at least on selftest builds, rising from 1-3 hours to
something like 5-8 hours.

A build with my branch on the commit just before: https://autobuilder.yocto=
project.org/valkyrie/#/builders/35/builds/3158
A build with my branch on this commit: https://autobuilder.yoctoproject.org=
/valkyrie/#/builders/35/builds/3161

Some tests appear to be way longer to run, typically:

2026-02-05 11:26:19,583 - oe-selftest - INFO - buildoptions.ArchiverTest.te=
st_arch_work_dir_and_export_source (subunit.RemotedTestCase)
2026-02-05 11:26:19,583 - oe-selftest - INFO -  ... ok
2026-02-05 11:26:19,583 - oe-selftest - INFO - 11: 1/34 11/664 (36.33s) (0 =
failed) (buildoptions.ArchiverTest.test_arch_work_dir_and_export_source)

2026-02-05 15:48:59,247 - oe-selftest - INFO - buildoptions.ArchiverTest.te=
st_arch_work_dir_and_export_source (subunit.RemotedTestCase)
2026-02-05 15:48:59,247 - oe-selftest - INFO -  ... ok
2026-02-05 15:48:59,247 - oe-selftest - INFO - 11: 1/34 59/664 (1568.37s) (=
0 failed) (buildoptions.ArchiverTest.test_arch_work_dir_and_export_source)

Maybe the configuration is clashing with the configuration we have on
the autobuilder, or maybe this is just something else in my branch.

I will try to get a better view of the situation, but I wanted to first
note this before the patch get merged.

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


