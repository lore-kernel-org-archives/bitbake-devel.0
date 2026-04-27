Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059DAFF885E
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 08:51:36 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39398.1777279884870248866
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Apr 2026 01:51:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=XZcuh7wJ;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6BD7DC5CD45;
	Mon, 27 Apr 2026 08:52:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 55728600D1;
	Mon, 27 Apr 2026 08:51:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22BAC1072239C;
	Mon, 27 Apr 2026 10:51:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777279881; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jGyzr1l7GoBlxypZx/IS+5xqNztGBOQRwSDZLoEUiqI=;
	b=XZcuh7wJGuvusUi2n+3x1A73ONk/AE5K6XK4u3lE5Z/DcJxdGv9n/hCoOb1+w0nEuuilk9
	yQ9bMbRfH9u21mecjAq/vZ8T2MSDYcRaUUoQZKLZ+Z78Qz2+PzCf+VtJXmJvCIGikW5Fq1
	GLE07R+VecYk6dH6X4SyPAFiI7Do4PHLx0DJM+lad2o491imyYJIuSGk8VpYodxdhA84mc
	pfrOKdk5QvCPuErRJf5M9XXNedkHIl/6unqSKhacWOkDmFfkbL6sab5QqHlj6wq1MLk3rR
	ZyYqfj6giQSVWdRdL53HCJgXl9ua+PmtgJtXTIB+N54ViTNlG+LZ3XpyHvyWYg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 10:51:20 +0200
Message-Id: <DI3T4XKSTUPE.Y4MSPXKSLM3S@bootlin.com>
To: <corentin.guillevic@smile.fr>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] cooker: limit the execution of the
 hashequiv client/server ping
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20260423102950.697501-2-corentin.guillevic@smile.fr>
In-Reply-To: <20260423102950.697501-2-corentin.guillevic@smile.fr>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Apr 2026 08:51:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19392

On Thu Apr 23, 2026 at 12:29 PM CEST, Corentin Guillevic via lists.openembe=
dded.org wrote:
> From: Corentin Guillevic <corentin.guillevic@smile.fr>
>
> The ping method is used to test the connection to the hash equivalence se=
rver.
> However, if the server is unavailable, the bitbake server has to wait sev=
eral
> minutes for the system to terminate.
>
> While waiting for a response from the hash server, the bitbake server doe=
s not
> provide any feedback to the bitbake client. The latter then closes the li=
nk and
> fails with the error:
>
> Timeout while waiting for a reply from the bitbake server (60s at 09:50:1=
5.377337)
>
> Adding a timeout to the ping step allows quicker action when a remote ser=
ver is
> unavailable, and prevents disconnection of the client due to timeout.
> The default timeout is 10 seconds, but this can be set using the
> BB_HASHSERVER_TIMEOUT variable.
>
> Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
> ---

Hi Corentin,

Thanks for your patch.

It looks like this is triggering some oe-selftest failures:

2026-04-24 13:28:03,744 - oe-selftest - INFO - prservice.BitbakePrTests.tes=
t_import_export_override_db (subunit.RemotedTestCase)
2026-04-24 13:28:03,746 - oe-selftest - INFO -  ... FAIL
...
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/openem=
bedded-core/meta/lib/oeqa/selftest/cases/prservice.py", line 115, in test_i=
mport_export_override_db
    self.run_test_pr_export_import('m4', replace_current_db=3DFalse)
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/openem=
bedded-core/meta/lib/oeqa/selftest/cases/prservice.py", line 89, in run_tes=
t_pr_export_import
    self.increment_package_pr(package_name)
    ~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/openem=
bedded-core/meta/lib/oeqa/selftest/cases/prservice.py", line 61, in increme=
nt_package_pr
    self.assertEqual(res.status, 0, msg=3Dres.output)
    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.13/unittest/case.py", line 907, in assertEqual
    assertion_func(first, second, msg=3Dmsg)
    ~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.13/unittest/case.py", line 900, in _baseAssertEqua=
l
    raise self.failureException(msg)
AssertionError: 1 !=3D 0 : NOTE: Reconnecting to bitbake server...
NOTE: Retrying server connection (#1)... (13:28:02.531366)
NOTE: Started PRServer with DBfile: /srv/pokybuild/yocto-worker/oe-selftest=
-armhost/build/build-st-1371670/cache/prserv.sqlite3, Address: 127.0.0.1:37=
647, PID: 2273277
ERROR: PRservice localhost:37647 not available
ERROR: Unable to start PR Server, exiting, check the bitbake-cookerdaemon.l=
og
...
2026-04-24 13:28:06,081 - oe-selftest - INFO - prservice.BitbakePrTests.tes=
t_import_export_replace_db (subunit.RemotedTestCase)
2026-04-24 13:28:06,081 - oe-selftest - INFO -  ... FAIL
...
2026-04-24 13:28:08,453 - oe-selftest - INFO - prservice.BitbakePrTests.tes=
t_pr_service_deb_arch_dep (subunit.RemotedTestCase)
2026-04-24 13:28:08,453 - oe-selftest - INFO -  ... FAIL
...
2026-04-24 13:28:10,791 - oe-selftest - INFO - prservice.BitbakePrTests.tes=
t_pr_service_deb_arch_indep (subunit.RemotedTestCase)
2026-04-24 13:28:10,792 - oe-selftest - INFO -  ... FAIL
...
2026-04-24 13:28:13,383 - oe-selftest - INFO - prservice.BitbakePrTests.tes=
t_pr_service_ipk_arch_dep (subunit.RemotedTestCase)
2026-04-24 13:28:13,384 - oe-selftest - INFO -  ... FAIL
...
2026-04-24 13:28:15,719 - oe-selftest - INFO - prservice.BitbakePrTests.tes=
t_pr_service_ipk_arch_indep (subunit.RemotedTestCase)
2026-04-24 13:28:15,720 - oe-selftest - INFO -  ... FAIL
...
2026-04-24 13:28:18,037 - oe-selftest - INFO - prservice.BitbakePrTests.tes=
t_pr_service_rpm_arch_dep (subunit.RemotedTestCase)
2026-04-24 13:28:18,038 - oe-selftest - INFO -  ... FAIL
...
2026-04-24 13:28:20,344 - oe-selftest - INFO - prservice.BitbakePrTests.tes=
t_pr_service_rpm_arch_indep (subunit.RemotedTestCase)
2026-04-24 13:28:20,345 - oe-selftest - INFO -  ... FAIL

https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/3834
https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3744
https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/3624

Can you have a look at the issue?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


