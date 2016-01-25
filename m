Return-Path: <elliot.smith@intel.com>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
	[209.85.223.181])
	by mail.openembedded.org (Postfix) with ESMTP id 2467276659
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Jan 2016 14:20:51 +0000 (UTC)
Received: by mail-io0-f181.google.com with SMTP id g73so156139305ioe.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Jan 2016 06:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=Xt8LD4e2f4LS1o8n41UbgYacfCSHN+btJCEgnYTA/8I=;
	b=c1fYJJhliwnqxYKvYPFgteYhUIng20ssnHmdSW+iZLRMcpxpIchT0dw5sAIBKEhjvM
	DG/jsdUCoaIgdrGN5XyIgR2OWuyzJWO3D+yy3CkoScMr+qVqpLHTB//dwzgqMjYtHzD4
	ZxgqP+eGoICFddylQ3nT44iGpCcHqX6RjEYgSj3T5o6lvwnsSpPgCRIIcxldfcPFMcnT
	QopXQ7CWQucJo+UCrQyESjhDxm1fa4MApPsF/sRv58XA9Bt3R/U0jSMPlImmxSZOCWu2
	wgEg9TGdcwe6ciT2bNWJeLR2u2wybSWkDRAz8+oqT+pnfVqgXwd2UJjDPby9nj7H041d
	1Yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=Xt8LD4e2f4LS1o8n41UbgYacfCSHN+btJCEgnYTA/8I=;
	b=Xi3zSADb/mpbl46pSryxt2mIjh2kqqFq55jFFfTIdIJCjXzrLI43R+23KLTmOb52Bz
	11C9PPwkT3nW4R3ctCcKoJ1vCamQOih3qD3uBvI8TmonThG4S1Uf4XWOCskben65I3oY
	0DrVgWNzz/RS3pSPJqqS+NpRa4Kjan1N9JmBHDUI1Rzj8Acj6g1dHR1bepqxV9RIWe9k
	Ke2xegF6geLphc96x0OHjpngZ3t/vgSvqnaCl/lj8uYdY6R9XXHb2zNNuo66DcM7s9Fq
	IhYKV2N00WkWb1qOFUz2ivfWblIERS6sdQxUKMDXi0jIJeOqug6LFyj72RjhXLA1zz6L
	SSkA==
X-Gm-Message-State: AG10YOSXn1PznmZt21Jam0tFwDOdUigehGPSezwxYZsbUpRWYKqwZlo2jFiOBF4GqND7SAsEENALg4IAYGnlFXRe
MIME-Version: 1.0
X-Received: by 10.107.137.26 with SMTP id l26mr16314362iod.141.1453731651886; 
	Mon, 25 Jan 2016 06:20:51 -0800 (PST)
Received: by 10.64.73.65 with HTTP; Mon, 25 Jan 2016 06:20:51 -0800 (PST)
In-Reply-To: <1453731509-12180-1-git-send-email-elliot.smith@intel.com>
References: <1453731509-12180-1-git-send-email-elliot.smith@intel.com>
Date: Mon, 25 Jan 2016 14:20:51 +0000
Message-ID: <CA+1hgUh4dfAJkMZm1f2khreU0NvLU-ekAV3e0+rtRCAESeXMiw@mail.gmail.com>
From: "Smith, Elliot" <elliot.smith@intel.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: toaster: make runbuilds loop
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 25 Jan 2016 14:20:52 -0000
Content-Type: multipart/alternative; boundary=001a113fc404b5c8e1052a29460a

--001a113fc404b5c8e1052a29460a
Content-Type: text/plain; charset=UTF-8

Apologies, I sent this prematurely, and it's a patch for jethro.

Please ignore.

Elliot

On 25 January 2016 at 14:18, Elliot Smith <elliot.smith@intel.com> wrote:

> From: Ed Bartosh <ed.bartosh@linux.intel.com>
>
> This avoids having a loop in shell code and initializing
> heavy Django init machinery every second.
>
> Ignore exceptions to prevent exiting the loop.
>
> (Bitbake rev: e04da15556ca0936de652b8c085e4199e5551457)
>
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> Signed-off-by: brian avery <avery.brian@gmail.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> Signed-off-by: Ed Bartosh <eduard.bartosh@intel.com>
> Signed-off-by: Elliot Smith <elliot.smith@intel.com>
> ---
>  .../lib/toaster/bldcontrol/management/commands/runbuilds.py | 13
> ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git
> a/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
> b/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
> index 5243a50..48dc618 100644
> --- a/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
> +++ b/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
> @@ -5,6 +5,7 @@ from bldcontrol.bbcontroller import
> getBuildEnvironmentController, ShellCmdExcep
>  from bldcontrol.models import BuildRequest, BuildEnvironment, BRError,
> BRVariable
>  import os
>  import logging
> +import time
>
>  logger = logging.getLogger("ToasterScheduler")
>
> @@ -128,6 +129,12 @@ class Command(NoArgsCommand):
>
>
>      def handle_noargs(self, **options):
> -        self.cleanup()
> -        self.archive()
> -        self.schedule()
> +        while True:
> +            try:
> +                self.cleanup()
> +                self.archive()
> +                self.schedule()
> +            except:
> +                pass
> +
> +            time.sleep(1)
> --
> 1.9.3
>
> ---------------------------------------------------------------------
> Intel Corporation (UK) Limited
> Registered No. 1134945 (England)
> Registered Office: Pipers Way, Swindon SN3 1RJ
> VAT No: 860 2173 47
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>
>


-- 
Elliot Smith
Software Engineer
Intel Open Source Technology Centre

--001a113fc404b5c8e1052a29460a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Apologies, I sent this prematurely, and it&#39;s a patch f=
or jethro.<div><br></div><div>Please ignore.</div><div><br></div><div>Ellio=
t</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 2=
5 January 2016 at 14:18, Elliot Smith <span dir=3D"ltr">&lt;<a href=3D"mail=
to:elliot.smith@intel.com" target=3D"_blank">elliot.smith@intel.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">From: Ed Bartosh &lt;<a hr=
ef=3D"mailto:ed.bartosh@linux.intel.com">ed.bartosh@linux.intel.com</a>&gt;=
<br>
<br>
This avoids having a loop in shell code and initializing<br>
heavy Django init machinery every second.<br>
<br>
Ignore exceptions to prevent exiting the loop.<br>
<br>
(Bitbake rev: e04da15556ca0936de652b8c085e4199e5551457)<br>
<br>
Signed-off-by: Ed Bartosh &lt;<a href=3D"mailto:ed.bartosh@linux.intel.com"=
>ed.bartosh@linux.intel.com</a>&gt;<br>
Signed-off-by: brian avery &lt;<a href=3D"mailto:avery.brian@gmail.com">ave=
ry.brian@gmail.com</a>&gt;<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt;<br>
Signed-off-by: Ed Bartosh &lt;<a href=3D"mailto:eduard.bartosh@intel.com">e=
duard.bartosh@intel.com</a>&gt;<br>
Signed-off-by: Elliot Smith &lt;<a href=3D"mailto:elliot.smith@intel.com">e=
lliot.smith@intel.com</a>&gt;<br>
---<br>
=C2=A0.../lib/toaster/bldcontrol/management/commands/runbuilds.py | 13 ++++=
++++++---<br>
=C2=A01 file changed, 10 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.p=
y b/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py<br>
index 5243a50..48dc618 100644<br>
--- a/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py<br>
+++ b/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py<br>
@@ -5,6 +5,7 @@ from bldcontrol.bbcontroller import getBuildEnvironmentCont=
roller, ShellCmdExcep<br>
=C2=A0from bldcontrol.models import BuildRequest, BuildEnvironment, BRError=
, BRVariable<br>
=C2=A0import os<br>
=C2=A0import logging<br>
+import time<br>
<br>
=C2=A0logger =3D logging.getLogger(&quot;ToasterScheduler&quot;)<br>
<br>
@@ -128,6 +129,12 @@ class Command(NoArgsCommand):<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0def handle_noargs(self, **options):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.cleanup()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.archive()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.schedule()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 while True:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.cleanup()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.archive()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.schedule()<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(1)<br>
--<br>
1.9.3<br>
<br>
---------------------------------------------------------------------<br>
Intel Corporation (UK) Limited<br>
Registered No. 1134945 (England)<br>
Registered Office: Pipers Way, Swindon SN3 1RJ<br>
VAT No: 860 2173 47<br>
<br>
This e-mail and any attachments may contain confidential material for<br>
the sole use of the intended recipient(s). Any review or distribution<br>
by others is strictly prohibited. If you are not the intended<br>
recipient, please contact the sender and delete all copies.<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div dir=3D"ltr"><div>Elliot Smith<br>Software Enginee=
r<br>Intel Open Source Technology Centre</div></div></div>
</div>

--001a113fc404b5c8e1052a29460a--
