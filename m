Return-Path: <kergoth@gmail.com>
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com
	[209.85.213.46])
	by mail.openembedded.org (Postfix) with ESMTP id DF1FB6AC37
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Aug 2017 16:58:16 +0000 (UTC)
Received: by mail-vk0-f46.google.com with SMTP id u133so51946371vke.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Aug 2017 09:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=WekKYbsdxM17ip5zUfyx53VUZHVJOwCcqnNTieUhou0=;
	b=VNGeaTewgPz1GnZrN9JHc/GVxnc4qPHugBPtH/HX37BePjiRWLfZ4X2kFwXErnSvOq
	gwcX7e5f5yCEdNEDOLy7qOKRq3pW4b0TiEMsRIHro7JL9luUNC7BBO2JPfYdm72HfmQo
	7daONVUYGSldc1tG8BaY+rf0i0wTMMu9VNR4QGypKHabWUAnuuyerI/WYq0fpj2d6ZKN
	nevBfz/NxE2Kzym2sbZxQe7LL/c4dIoS3NhuQ2uqLo0DrCcK/lheSClfceY/gxVFsa8h
	jLx60CJt+zmuyeNUv3NSuXlbsvxh6YIMXjzSYr1B9UMb9kuxpbfU5zpCPFJzX6wkv0JD
	P5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=WekKYbsdxM17ip5zUfyx53VUZHVJOwCcqnNTieUhou0=;
	b=RHns6ZoXhfZ1bdIR1tHD2btqqyTy7MrzvYqj01kqLN3I28ojeQVvqSA63NoLsVG4Dp
	9kZz28/GGrH2bbvsPWnUAEAvLBOchbCm3YkmzHPwRQzgf3o5TS75i9vWfKVieLXjxLOB
	cfow9hcWFVJauSDHNQABn3JzfuNVgmRPsQZZAL1aSl2juK4uhQVvdEKcjW6wSwBbnRdp
	iipMOQxBHPfol9laXZ4+AwjiHGTNgkDsxEvZKK/TgyotNkg2M99OuQhOHbKyfjqkWHn6
	w4iU1HlznQaHIRGH5QB8e84m+KOoHAEHvdTAGdEZPxvCRa/PW2e8deDRaOQbH7TYVfSq
	MBHg==
X-Gm-Message-State: AHYfb5i41FeNB3JFM+cVfkfMmhV2G/0yJfjf3cXk5JHQjPf+W6a0zVAn
	yLMPEAVNC6vyHUHmx/X2Fxp70mWru8jGl3c=
X-Received: by 10.31.85.130 with SMTP id j124mr7128041vkb.177.1503334697674;
	Mon, 21 Aug 2017 09:58:17 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.176.16.12 with HTTP; Mon, 21 Aug 2017 09:57:56 -0700 (PDT)
In-Reply-To: <20170821165708.13223-1-kergoth@gmail.com>
References: <20170821163741.28301-2-kergoth@gmail.com>
	<20170821165708.13223-1-kergoth@gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Mon, 21 Aug 2017 09:57:56 -0700
X-Google-Sender-Auth: ziGRDV6pVPKyapZhDEgxWC8bSQ4
Message-ID: <CABcZAN=cOiiH_yVBTh-ZH4pU75tgYHqL59qnr55tNvp5JQVg2A@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCHv2] fetch2/gitsm: copy submodules from DL_DIR in unpack
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
X-List-Received-Date: Mon, 21 Aug 2017 16:58:17 -0000
Content-Type: multipart/alternative; boundary="001a114e56a2a22e5405574662b9"

--001a114e56a2a22e5405574662b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Supercedes "[PATCH 2/2] Revert "fetch2/gitsm: Fix when repository change
submodules=E2=80=9D=E2=80=9D.

On Mon, Aug 21, 2017 at 9:57 AM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> Revert "fetch2/gitsm: Fix when repository change submodules"
>
> This reverts commit 12f6c0651af8bd5d6efb751690571cf2fcd3eeb0.
>
> This commit caused the gitsm fetcher to download submodules from upstream
> in
> do_unpack, rather than using the previously fetched submodules from DL_DI=
R.
> Also drop the pointless checkout, as Git.unpack() already handles this
> correctly.
>
> [YOCTO #11830]
>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> ---
>  lib/bb/fetch2/gitsm.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index 0aff1008..ed94c3d7 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -131,5 +131,6 @@ class GitSM(Git):
>          Git.unpack(self, ud, destdir, d)
>
>          if self.uses_submodules(ud, d, ud.destdir):
> -            runfetchcmd(ud.basecmd + " checkout " +
> ud.revisions[ud.names[0]], d, workdir=3Dud.destdir)
> +            if not ud.shallow or ud.localpath !=3D ud.fullshallow:
> +                runfetchcmd('cp -fpPRH "%s/modules" "%s/"' %
> (ud.clonedir, os.path.join(ud.destdir, '.git')), d)
>              runfetchcmd(ud.basecmd + " submodule update --init
> --recursive", d, workdir=3Dud.destdir)
> --
> 2.11.1
>
>


--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--001a114e56a2a22e5405574662b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Supercedes &quot;[PATCH 2/2] Revert &quot;fetch2/gitsm: Fi=
x when repository change submodules=E2=80=9D=E2=80=9D.</div><div class=3D"g=
mail_extra"><br><div class=3D"gmail_quote">On Mon, Aug 21, 2017 at 9:57 AM,=
 Christopher Larson <span dir=3D"ltr">&lt;<a href=3D"mailto:kergoth@gmail.c=
om" target=3D"_blank">kergoth@gmail.com</a>&gt;</span> wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">From: Christopher Larson &lt;<a href=3D"mailto:chris_l=
arson@mentor.com">chris_larson@mentor.com</a>&gt;<br>
<br>
Revert &quot;fetch2/gitsm: Fix when repository change submodules&quot;<br>
<br>
This reverts commit 12f6c0651af8bd5d6efb751690571c<wbr>f2fcd3eeb0.<br>
<br>
This commit caused the gitsm fetcher to download submodules from upstream i=
n<br>
do_unpack, rather than using the previously fetched submodules from DL_DIR.=
<br>
Also drop the pointless checkout, as Git.unpack() already handles this<br>
correctly.<br>
<br>
[YOCTO #11830]<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com">chris_larson@mentor.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/gitsm.py | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py<br>
index 0aff1008..ed94c3d7 100644<br>
--- a/lib/bb/fetch2/gitsm.py<br>
+++ b/lib/bb/fetch2/gitsm.py<br>
@@ -131,5 +131,6 @@ class GitSM(Git):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Git.unpack(self, ud, destdir, d)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.uses_submodules(ud, d, ud.destdir=
):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(ud.basecmd + &quot; =
checkout &quot; + ud.revisions[ud.names[0]], d, workdir=3Dud.destdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not ud.shallow or ud.localpat=
h !=3D ud.fullshallow:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&#39;c=
p -fpPRH &quot;%s/modules&quot; &quot;%s/&quot;&#39; % (ud.clonedir, os.pat=
h.join(ud.destdir, &#39;.git&#39;)), d)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0runfetchcmd(ud.basecmd + &q=
uot; submodule update --init --recursive&quot;, d, workdir=3Dud.destdir)<br=
>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.11.1<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div di=
r=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div>Christopher Lars=
on<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZaur=
us<br>Senior Software Engineer, Mentor Graphics</div></div></div></div></di=
v></div></div>
</div>

--001a114e56a2a22e5405574662b9--
