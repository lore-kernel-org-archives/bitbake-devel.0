Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4528CCF9F8
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:43:35 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10380.1762418612910945666
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 00:43:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Bih4VD0r;
 spf=pass (domain: smile.fr, ip: 209.85.128.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47109187c32so2856005e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 00:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1762418611; x=1763023411; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TTtpROsIdOTyrLKvNN5DBBS0/aaTzuqIEhpVk1s7iLg=;
        b=Bih4VD0rgr2MABqSI7I82a2OkWOtN7injNP8iJSDC2mS6Xtc2MGGpR55hgWmIzu0uE
         kB2zypRxYPnkZyaIYGrMQjTj5ZoMr7xngOOyYuZ8b170fiwVgTWVlgj2izE7qX+TT++v
         YlOkCag+CTm+xKY9HNbKuH/aYfi/MFOMk9XfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762418611; x=1763023411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTtpROsIdOTyrLKvNN5DBBS0/aaTzuqIEhpVk1s7iLg=;
        b=q/d0AEwfLhsw3teOKSv40wt5emQmSQ/nyoKia4NXgmhe8ps6H7TMxEwFMVU2o5QqyG
         mleb1g+8bQndBMDlkWNsRgTYHpA+HGy/zNGEVG4ynMfH1mUgY7BxO1gk7X+zsZzpqH2X
         aPsQPZJ8rQRKQQw2hSz9TQoW/bWr9dSK5fknLQytTwouCY9ddgPN9N9GMNgNdkybFwaJ
         JxCOXE+gZC8+ACL3bNlltBAg1XKBdDeuWaPv/AHLboCspPRgl92TbmTBWwQezzGl3MpL
         ccoHmtpZM0CQNl8V5quDLjv0LDd2ATBO4jIZXGAklrXPWStvnsEcvM5IDWTnWAWdYp50
         0ZTA==
X-Gm-Message-State: AOJu0YxlTHV36oeQ1RIVBOk2Mr68efeniCdbCoJj+vusEBqK9v00SnyI
	AWLvTOe8GekCAqDNNICbnZHP8JCfm674B8bDaMfLS4nMMo4HWieIWNY2XzWxVEJpTtgi6wrB6Ab
	YonSY1OvYslns/1gwaJcO40r+EfzJrFfoDQXmV63WHQ==
X-Gm-Gg: ASbGncughf0t8hozaMzLpxMlRYxYe3q1gXDfoLN7DFliN7Hy9+/PSSrvSYDpenZZz6s
	yZshj/ZrKsRj0mjChXJP6qvxiSFhAsnXqAyfPoUe80ux3M83YB/oaPAVM2rnjMqnVCXKlSukMVL
	WdMrta/n7ceUFQMHnpQzySba/RUMDLM7rfmAGd0oC1BOT01C5aFazxywOqFoQ4PSxbIrxaDZrr/
	bn/hJsycLvk30PQbUXPb5/8Hu8TjjoZVPhJDCVeyPvNEMENqcH14knEPnAMjMpygXJiawA7KmXg
	+KWuiZkcvZApklAXsnI=
X-Google-Smtp-Source: AGHT+IGc5lHrzPusKcW/ZSPrGSdkKQZoJSuekzCCuJolJ8PaTATBKN3rMnOLOE6tvLZ0nNNf0gAhLUn7CBemTnhfnLU=
X-Received: by 2002:a05:600c:4584:b0:477:55de:4a6 with SMTP id
 5b1f17b1804b1-4775cdbe238mr56171635e9.3.1762418610898; Thu, 06 Nov 2025
 00:43:30 -0800 (PST)
MIME-Version: 1.0
References: <20251105232718.2801446-1-yoann.congal@smile.fr> <DE1GB2U0LTRC.11DTXWB7ZUB7T@bootlin.com>
In-Reply-To: <DE1GB2U0LTRC.11DTXWB7ZUB7T@bootlin.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Thu, 6 Nov 2025 09:43:05 +0100
X-Gm-Features: AWmQ_bnlOLNDWxZfoLhLQ2eIsbgK5GYFtKbTA8KDHrUDwtlifHjW7f0KlcaLYhM
Message-ID: <CAMSfU+4_kj4+9C5bDuVYtSFZG92yHNUPWEEPbxEDTGgrMB5Z7g@mail.gmail.com>
Subject: Re: [master-next][PATCH] bitbake-user-manual-environment-setup:
 Document "{THISDIR}" in bb-layers
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Yocto Docs ML <docs@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="0000000000003f9c510642e90f4f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 08:43:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18280

--0000000000003f9c510642e90f4f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 6 nov. 2025 =C3=A0 08:58, Antonin Godard <antonin.godard@bootlin.co=
m> a
=C3=A9crit :

> Hi,
>
> On Thu Nov 6, 2025 at 12:27 AM CET, Yoann Congal wrote:
> > From: Yoann Congal <yoann.congal@smile.fr>
> >
> > A "bb-layers" element can either:
> > * start with "{THISDIR}/meta-xxx", then "meta-xxx" is found relative to
> >   the configuration file,
> > * or not, the layer is found where bitbake-setup has cloned
> >   the layer from the "sources" list (usually a layers/ directory)
> >
> > Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> > Cc: Antonin Godard <antonin.godard@bootlin.com>
> > ---
> >  .../bitbake-user-manual-environment-setup.rst                  | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git
> a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> > index ad8143711..d9b7492b9 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> > @@ -593,6 +593,9 @@ These files are written in the JSON file format and
> are stored in a
> >        variables to include in :term:`BB_ENV_PASSTHROUGH_ADDITIONS`.
> >
> >     -  ``bb-layers`` (*optional*): Layers to add to the
> ``bblayers.conf`` file.
> > +      If the path starts by ``{THISDIR}/``, it will be relative to the
> directory
> > +      containing the configuration file. If not, it will be relative t=
o
> the
> > +      directory used by ``bitbake-setup`` to store the sources.
> >        This cannot be used in conjunction with the ``oe-template``
> option.
> >
> >     -  ``oe-template`` (*optional*, OpenEmbedded specific): OpenEmbedde=
d
> template
>
> I actually did write something about it yesterday (not sent yet). I
> extended it
> a bit more, namely to show the common use-case. Your patch helped me
> clarify it
> further, thanks. Let me know if making what follows part of my patch if o=
k
> to
> you:
>

That is very good. Definitively OK to me.


>
>    -  ``bb-layers`` (*optional*): Layers to add to the ``bblayers.conf``
> file
>       (paths are relative to the ``layers/`` directory of a :term:`Setup`=
,
>       unless ``{THISDIR}`` is used, see below).
>
>       The ``bb-layers`` option cannot be used in conjunction with the
>       ``oe-template`` option where the ``bblayers.conf`` files comes from
> the
>       template itself.
>
>       Local layers (layers not part of the ``sources``) can be added to
>       ``bb-layers`` by specifying their path with the ``{THISDIR}`` speci=
al
>       keyword. For example::
>
>          {
>             ...
>             "bb-layers": [
>                "{THISDIR}/meta-myproject"
>             ],
>             ...
>          }
>
>       ``{THISDIR}`` translates to the parent directory of the current
>       :term:`Generic Configuration` file.
>
>       This useful for a project that holds a single :term:`generic
>       configuration` file next to a local layer::
>
>          =E2=94=9C=E2=94=80=E2=94=80 meta-myproject/
>          =E2=94=94=E2=94=80=E2=94=80 myproject.conf.json
>
> Antonin
>
> --
> Antonin Godard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>

--=20
Yoann Congal
Smile ECS

--0000000000003f9c510642e90f4f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0jeu. 6 =
nov. 2025 =C3=A0=C2=A008:58, Antonin Godard &lt;<a href=3D"mailto:antonin.g=
odard@bootlin.com">antonin.godard@bootlin.com</a>&gt; a =C3=A9crit=C2=A0:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Thu Nov 6, 2025 at 12:27 AM CET, Yoann Congal wrote:<br>
&gt; From: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" target=
=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
&gt;<br>
&gt; A &quot;bb-layers&quot; element can either:<br>
&gt; * start with &quot;{THISDIR}/meta-xxx&quot;, then &quot;meta-xxx&quot;=
 is found relative to<br>
&gt;=C2=A0 =C2=A0the configuration file,<br>
&gt; * or not, the layer is found where bitbake-setup has cloned<br>
&gt;=C2=A0 =C2=A0the layer from the &quot;sources&quot; list (usually a lay=
ers/ directory)<br>
&gt;<br>
&gt; Signed-off-by: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.f=
r" target=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
&gt; Cc: Antonin Godard &lt;<a href=3D"mailto:antonin.godard@bootlin.com" t=
arget=3D"_blank">antonin.godard@bootlin.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .../bitbake-user-manual-environment-setup.rst=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 3 +++<br>
&gt;=C2=A0 1 file changed, 3 insertions(+)<br>
&gt;<br>
&gt; diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-s=
etup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rs=
t<br>
&gt; index ad8143711..d9b7492b9 100644<br>
&gt; --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rs=
t<br>
&gt; +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rs=
t<br>
&gt; @@ -593,6 +593,9 @@ These files are written in the JSON file format an=
d are stored in a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 variables to include in :term:`BB_ENV_PASST=
HROUGH_ADDITIONS`.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 ``bb-layers`` (*optional*): Layers to add t=
o the ``bblayers.conf`` file.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 If the path starts by ``{THISDIR}/``, it will be=
 relative to the directory<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 containing the configuration file. If not, it wi=
ll be relative to the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 directory used by ``bitbake-setup`` to store the=
 sources.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 This cannot be used in conjunction with the=
 ``oe-template`` option.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 ``oe-template`` (*optional*, OpenEmbedded s=
pecific): OpenEmbedded template<br>
<br>
I actually did write something about it yesterday (not sent yet). I extende=
d it<br>
a bit more, namely to show the common use-case. Your patch helped me clarif=
y it<br>
further, thanks. Let me know if making what follows part of my patch if ok =
to<br>
you:<br></blockquote><div><br></div><div>That is very good. Definitively OK=
 to me.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
=C2=A0 =C2=A0-=C2=A0 ``bb-layers`` (*optional*): Layers to add to the ``bbl=
ayers.conf`` file<br>
=C2=A0 =C2=A0 =C2=A0 (paths are relative to the ``layers/`` directory of a =
:term:`Setup`,<br>
=C2=A0 =C2=A0 =C2=A0 unless ``{THISDIR}`` is used, see below).<br>
<br>
=C2=A0 =C2=A0 =C2=A0 The ``bb-layers`` option cannot be used in conjunction=
 with the<br>
=C2=A0 =C2=A0 =C2=A0 ``oe-template`` option where the ``bblayers.conf`` fil=
es comes from the<br>
=C2=A0 =C2=A0 =C2=A0 template itself.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 Local layers (layers not part of the ``sources``) can =
be added to<br>
=C2=A0 =C2=A0 =C2=A0 ``bb-layers`` by specifying their path with the ``{THI=
SDIR}`` special<br>
=C2=A0 =C2=A0 =C2=A0 keyword. For example::<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;bb-layers&quot;: [<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;{THISDIR}/meta=
-myproject&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 ``{THISDIR}`` translates to the parent directory of th=
e current<br>
=C2=A0 =C2=A0 =C2=A0 :term:`Generic Configuration` file.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 This useful for a project that holds a single :term:`g=
eneric<br>
=C2=A0 =C2=A0 =C2=A0 configuration` file next to a local layer::<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E2=94=9C=E2=94=80=E2=94=80 meta-myprojec=
t/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E2=94=94=E2=94=80=E2=94=80 myproject.con=
f.json<br>
<br>
Antonin<br>
<br>
-- <br>
Antonin Godard, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" rel=3D"noreferrer" target=3D"_blank">https:=
//bootlin.com</a><br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--0000000000003f9c510642e90f4f--

