Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74D7C433F5
	for <webhook@archiver.kernel.org>; Thu, 23 Dec 2021 12:18:23 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.31959.1640261902427948783
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Dec 2021 04:18:22 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=permanent DNS error (domain: 0leil.net, ip: 217.70.183.201,
 mailfrom: foss+yocto@0leil.net)
Received: (Authenticated sender: foss@0leil.net)
	by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A1A1C1BF206;
	Thu, 23 Dec 2021 12:18:19 +0000 (UTC)
Date: Thu, 23 Dec 2021 13:18:15 +0100
From: Quentin Schulz <foss+yocto@0leil.net>
To: bitbake-devel@lists.openembedded.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: =?US-ASCII?Q?Re=3A_=5Bbitbake-devel=5D_=5BPATCH_2/2=5D_bitba?=
 =?US-ASCII?Q?ke-worker=3A_Respect_nonetwork_task_flag?=
In-Reply-To: <20211222231907.1036709-2-richard.purdie@linuxfoundation.org>
References: <20211222231907.1036709-1-richard.purdie@linuxfoundation.org>
 <20211222231907.1036709-2-richard.purdie@linuxfoundation.org>
Message-ID: <62E099B1-5C97-4824-844D-B2DB432E73BF@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Dec 2021 12:18:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13201

Hi,

On December 23, 2021 12:19:07 AM GMT+01:00, Richard Purdie <richard=2Epurd=
ie@linuxfoundation=2Eorg> wrote:
>Add a "nonetwork" task specific flag which then triggers networking to
>be disabled for this task=2E
>
>This needs to happen before we enter the fakeroot environment of the task
>due to the need for the real uid/gid which we save in the parent process=
=2E
>

I'd like to see some docs about this in Bitbake in the variable flags sect=
ion https://docs=2Eyoctoproject=2Eorg/bitbake/bitbake-user-manual/bitbake-u=
ser-manual-metadata=2Ehtml#variable-flags so it's not a hidden feature :)

Just writing this here so we don't forget=2E

Cheers,
Quentin

>Signed-off-by: Richard Purdie <richard=2Epurdie@linuxfoundation=2Eorg>
>---
> bin/bitbake-worker | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/bin/bitbake-worker b/bin/bitbake-worker
>index bf96207edc=2E=2E32d4f58655 100755
>--- a/bin/bitbake-worker
>+++ b/bin/bitbake-worker
>@@ -152,6 +152,10 @@ def fork_off_task(cfg, data, databuilder, workerdata=
, fn, task, taskname, taskha
>     fakeenv =3D {}
>     umask =3D None
>=20
>+    uid =3D os=2Egetuid()
>+    gid =3D os=2Egetgid()
>+
>+
>     taskdep =3D workerdata["taskdeps"][fn]
>     if 'umask' in taskdep and taskname in taskdep['umask']:
>         umask =3D taskdep['umask'][taskname]
>@@ -257,6 +261,10 @@ def fork_off_task(cfg, data, databuilder, workerdata=
, fn, task, taskname, taskha
>=20
>                 bb=2Eutils=2Eset_process_name("%s:%s" % (the_data=2EgetV=
ar("PN"), taskname=2Ereplace("do_", "")))
>=20
>+                if the_data=2EgetVarFlag(taskname, 'nonetwork', False):
>+                    logger=2Edebug("Attempting to disable network")
>+                    bb=2Eutils=2Edisable_network(uid, gid)
>+
>                 # exported_vars() returns a generator which *cannot* be =
passed to os=2Eenviron=2Eupdate()=20
>                 # successfully=2E We also need to unset anything from th=
e environment which shouldn't be there=20
>                 exports =3D bb=2Edata=2Eexported_vars(the_data)

