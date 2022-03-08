Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22263C433EF
	for <webhook@archiver.kernel.org>; Tue,  8 Mar 2022 10:39:52 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web12.6827.1646735989595236753
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Mar 2022 02:39:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=o9L9vIdT;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646735990;
  x=1678271990;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=awvyj5jMbspgkKI68kA213ijk1NqzTyM9bmsSm5Evrs=;
  b=o9L9vIdTn9xxWv5PVsfLFPnwgrsaf+taGHCnhFB/JJQx7dWVWy/u8ORM
   220PZVLGMAdrW1s+BnDa85UOJeHc+a3oQ7Z/iaMPaPOXDiwer5KFXZNAC
   HSE+2x2wWNbWo8n8tvz2wmqA3JN6Svw/4ARfb9xAa5IbTUDJ+/FBTkLUw
   +0zasZW7/voMnyTcwWFjHRHILx1KSGyya+8Vd616Lu0IaWf/ON3oHwU/y
   z98Wcfj6k8EoCCvRlhgJxtx7vlNJG0jZk6yCeYwXforEXYcPtACwwX+IM
   ATFOtQ9dtvUdOyZXvsQ5Y3i4t2DWTb3zw/OeY+1qLZZN9HrANYnSQxXyQ
   g==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "Mittal, Anuj" <anuj.mittal@intel.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] utils: Ensure shell function failure in
 python logging is correct
Thread-Topic: [bitbake-devel] [PATCH] utils: Ensure shell function failure in
 python logging is correct
Thread-Index: AQHYKOIrmEFo76xtiUiYatCy/qcSxKy1Xl9Q
Date: Tue, 8 Mar 2022 10:39:45 +0000
Message-ID: <ee2ce832f87b40ebbc02eb0a43339a85@axis.com>
References: <20220221160356.3167661-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20220221160356.3167661-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Mar 2022 10:39:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13442

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Richard Purdie
> Sent: den 21 februari 2022 17:04
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] utils: Ensure shell function failure in
> python logging is correct
>=20
> If a python function exec_func() calls a shell task, the logging wasn't w=
orking
> correctly in all cases since the exception was turned into a BBHandledExc=
eption()
> and the logfile piece was lost which is handled at the top task level.
>=20
> The easiest way to avoid this is to allow the ExecutionError exceptions t=
o
> be raised to a higher level, we don't need the traceback for them.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/utils.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 2c22535424..2e8256101a 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -402,7 +402,7 @@ def better_exec(code, context, text =3D None, realfil=
e =3D "<code>", pythonexception
>          code =3D better_compile(code, realfile, realfile)
>      try:
>          exec(code, get_context(), context)
> -    except (bb.BBHandledException, bb.parse.SkipRecipe, bb.data_smart.Ex=
pansionError):
> +    except (bb.BBHandledException, bb.parse.SkipRecipe, bb.data_smart.Ex=
pansionError, bb.process.ExecutionError):
>          # Error already shown so passthrough, no need for traceback
>          raise
>      except Exception as e:
> --
> 2.32.0

This needs to be cherry-picked to Honister. There are corresponding=20
patches for oe-selftest as well to exercise the above change, but I'm=20
not sure if you normally backport them too.

//Peter


