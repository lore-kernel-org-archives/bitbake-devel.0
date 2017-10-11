Return-Path: <kergoth@gmail.com>
Received: from mail-ua0-f194.google.com (mail-ua0-f194.google.com
	[209.85.217.194])
	by mail.openembedded.org (Postfix) with ESMTP id B383877811
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Oct 2017 01:57:23 +0000 (UTC)
Received: by mail-ua0-f194.google.com with SMTP id l40so121641uah.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Oct 2017 18:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=LesYnJGlliSiL5rFYo8o0PMpQyIkTrNo5PVnNs+3PQU=;
	b=b8UpdRReopQtQUfoao81ZCJBqjuyIto0MuAL2OL/95PqHQDVkxNptMflZexfYWjA4E
	OKBKzKtzyMjp+HUzvLQlYXIclqwBLbtLtHzw9jvSpQ/ncCKx0AmKdkUqgt0Fjl1wXi5x
	YuvSFseh1gwrJ8V0Tf2hNxtdsomvka9dfwvTtsKBI9YvmHHZFXafuiOAIdtWk4eOpRZV
	7lLEW1n2x/dYLo7vP5YtL+0p1Qc24XoBy7X2ZKNnAupp4YA740Aw78umN4HQO/OG2wc3
	w2O7yhKzzVWGDJrlRFC8qp/OL8wF3ZRExNIcxCNdkiEv19s7hQIf5379GwdvxpbW0K6R
	29Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=LesYnJGlliSiL5rFYo8o0PMpQyIkTrNo5PVnNs+3PQU=;
	b=lG7nsKEi8XsFQW3HMCReWgSzlkNHHhnzS6Y7BSBxpE96VCQACllgzBL8cyPTcq2pmd
	QdzjLxzgCqU+Wao+oGB8b9EqOPz9+BrO1AXSb1UO7TCpULzrN51YR87q2ASmbYLepJ7E
	DA6VB/EVQU2gvPLOjkEeo0jQX5wPegmQXOQeb9GcE7aapLVanTKYPnxjWuRD0mOMKKED
	sBnDwK6VztpHKR70G5DFxhZNc8HtrPB7bA90FZfMZJOaqwXtnHD4VlL2zh8FzDsrgC+s
	YW8Ga680E5fkkOUk6ZnLOUaPYbemYFa5nOH4VLmIuNEOjfj96ajhtm7c/QqjSxe3WV2c
	HowQ==
X-Gm-Message-State: AMCzsaWVf+EBIbERann+qAqiQdaCz4JM/7f1HDFees3yz29h1zAEJZs9
	8MzoPFiofAe2DfSem43IXz0lJnGReXex/a4UFx4=
X-Google-Smtp-Source: AOwi7QBw6QrQ15G8Wbt4Zfv4QtWQtinpu0leq7GMdNaiPEu0UsY4Jh3oqyjr3h9wtGf6f1eHOh0zbG15UVetz9ol4wA=
X-Received: by 10.176.85.196 with SMTP id w4mr9157302uaa.75.1507687044670;
	Tue, 10 Oct 2017 18:57:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.55.193 with HTTP; Tue, 10 Oct 2017 18:57:04 -0700 (PDT)
In-Reply-To: <1507672037-29948-1-git-send-email-jpuhlman@mvista.com>
References: <1507672037-29948-1-git-send-email-jpuhlman@mvista.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Tue, 10 Oct 2017 18:57:04 -0700
Message-ID: <CABcZANkgVCzqE+me+R0TUp2G9fnR_ehCn0rM_XSCMQ2A0QNgWA@mail.gmail.com>
To: Jeremy Puhlman <jpuhlman@mvista.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] Allow layers to be added relative to topdir.
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
X-List-Received-Date: Wed, 11 Oct 2017 01:57:23 -0000
Content-Type: multipart/alternative; boundary="f403045e3176bae98f055b3bbe0d"

--f403045e3176bae98f055b3bbe0d
Content-Type: text/plain; charset="UTF-8"

I see no need for this patch:

TOPDIR := '${@os.path.dirname(os.path.dirname(FILE))}'
BBPATH = '${TOPDIR}'
BBFILES = ''
BBLAYERS = '\
    ${TOPDIR}/poky/meta-yocto-bsp \
    ${TOPDIR}/poky/meta-yocto \
    ${TOPDIR}/poky/meta \
    ${TOPDIR}/meta-oe/meta-oe \
'

On Tue, Oct 10, 2017 at 2:47 PM, Jeremy Puhlman <jpuhlman@mvista.com> wrote:

> From: "Jeremy A. Puhlman" <jpuhlman@mvista.com>
>
> Use case:
> Some users place their projects and their layers under source control.
> If absolute paths are used for the layers, the bblayers file is invalid
> when checked out on another system. If the layers are checked in
> relative to the project, then the project can be used anywhere.
>
> If LAYERS_RELATIVE is set in the bblayers.conf file, each layer is added
> relative to TOPDIR.
>
> Signed-off-by: Jeremy Puhlman <jpuhlman@mvista.com>
> ---
>  lib/bblayers/action.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
> index b1326e5..4dc6622 100644
> --- a/lib/bblayers/action.py
> +++ b/lib/bblayers/action.py
> @@ -38,7 +38,9 @@ class ActionPlugin(LayerPlugin):
>          tempdir = tempfile.mkdtemp()
>          backup = tempdir + "/bblayers.conf.bak"
>          shutil.copy2(bblayers_conf, backup)
> -
> +        if self.tinfoil.config_data.getVar('LAYERS_RELATIVE'):
> +            topdir = self.tinfoil.config_data.getVar('TOPDIR')
> +            layerdir = os.path.join("${TOPDIR}", os.path.relpath(layerdir,
> topdir))
>          try:
>              notadded, _ = bb.utils.edit_bblayers_conf(bblayers_conf,
> layerdir, None)
>              if not (args.force or notadded):
> --
> 2.6.2
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>



-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--f403045e3176bae98f055b3bbe0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I see no need for this patch:<div><br></div><div><div>TOPD=
IR :=3D &#39;${@os.path.dirname(os.path.dirname(FILE))}&#39;</div><div>BBPA=
TH =3D &#39;${TOPDIR}&#39;</div><div>BBFILES =3D &#39;&#39;</div><div>BBLAY=
ERS =3D &#39;\</div><div>=C2=A0 =C2=A0 ${TOPDIR}/poky/meta-yocto-bsp \<br><=
/div><div>=C2=A0 =C2=A0 ${TOPDIR}/poky/meta-yocto \</div><div>=C2=A0 =C2=A0=
 ${TOPDIR}/poky/meta \</div><div>=C2=A0 =C2=A0 ${TOPDIR}/meta-oe/meta-oe \<=
/div><div>&#39;</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Oct 10, 2017 at 2:47 PM, Jeremy Puhlman <span dir=3D"ltr">&lt;<=
a href=3D"mailto:jpuhlman@mvista.com" target=3D"_blank">jpuhlman@mvista.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-lef=
t-color:rgb(204,204,204);padding-left:1ex">From: &quot;Jeremy A. Puhlman&qu=
ot; &lt;<a href=3D"mailto:jpuhlman@mvista.com">jpuhlman@mvista.com</a>&gt;<=
br>
<br>
Use case:<br>
Some users place their projects and their layers under source control.<br>
If absolute paths are used for the layers, the bblayers file is invalid<br>
when checked out on another system. If the layers are checked in<br>
relative to the project, then the project can be used anywhere.<br>
<br>
If LAYERS_RELATIVE is set in the bblayers.conf file, each layer is added<br=
>
relative to TOPDIR.<br>
<br>
Signed-off-by: Jeremy Puhlman &lt;<a href=3D"mailto:jpuhlman@mvista.com">jp=
uhlman@mvista.com</a>&gt;<br>
---<br>
=C2=A0lib/bblayers/action.py | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py<br>
index b1326e5..4dc6622 100644<br>
--- a/lib/bblayers/action.py<br>
+++ b/lib/bblayers/action.py<br>
@@ -38,7 +38,9 @@ class ActionPlugin(LayerPlugin):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tempdir =3D tempfile.mkdtemp()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0backup =3D tempdir + &quot;/bblayers.conf=
.bak&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shutil.copy2(bblayers_conf, backup)<br>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.tinfoil.config_data.<wbr>getVar(&#39;L=
AYERS_RELATIVE&#39;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 topdir =3D self.tinfoil.config_d=
ata.<wbr>getVar(&#39;TOPDIR&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layerdir =3D os.path.join(&quot;=
${TOPDIR}&quot;, os.path.relpath(layerdir,<wbr>topdir))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0notadded, _ =3D bb.utils.ed=
it_bblayers_conf(<wbr>bblayers_conf, layerdir, None)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not (args.force or notad=
ded):<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888">--<br>
2.6.2<br>
<br>
--<br>
______________________________<wbr>_________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.<wbr>openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/<wbr>mailm=
an/listinfo/bitbake-devel</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Chr=
istopher Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbed=
ded, OpenZaurus<br>Senior Software Engineer, Mentor Graphics</div></div></d=
iv></div>
</div></div></div>

--f403045e3176bae98f055b3bbe0d--
