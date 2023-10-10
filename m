Return-Path: <bhstalel@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CD7CD8C93
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 14:36:10 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web11.92929.1696948569647878577
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Oct 2023 07:36:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Z0lrKfOG;
 spf=pass (domain: gmail.com, ip: 209.85.218.46, mailfrom: bhstalel@gmail.com)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9b2cee40de8so1245392466b.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Oct 2023 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696948568; x=1697553368; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6nli1GoQRSLsuo0SsR8F71zq8PMoBM7tBP2RhUJmon8=;
        b=Z0lrKfOGcO/6on6yFi1aqJW+cmRiKM7nGk6EdDoEXtHxuSJvXVElWXMNPVTCtH4S6Y
         Gx18uAv9xVCV5bLEOGfLdHRHdbix7WlNxWl76XgXDYscHY/4SjwUiMBMSGziDUmeM+UX
         38gBzaT/zi8x1JLTi06RmBiu2ITab9kzNIWKx6sGMFWXQ/VMbsRyiIBx9XO+64mF2uwr
         pqmE1BayoUYAKWn051Cjhsx18Zfc0vw9hAbt30PNKb0x41/z1kbYfQ8l7BFouFRhQrI1
         RA/rVzQxwd+h+Inz6kWyzWIYrUdIvIOxSa0N7MaB6PN/EO13DsoyRJpkBxnIEUhmPjO9
         n3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696948568; x=1697553368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nli1GoQRSLsuo0SsR8F71zq8PMoBM7tBP2RhUJmon8=;
        b=Am/Mz6Bi2fo+3pBYMUyg56te186lz781Y9kykHIVOYuuoaZDO7ASDHy8UZxsJWwXzF
         4BPGWnMAWcVfZRM6CRwAMWbp3FO9HtuOP/AIoZAKpDt66A++WY7KejZNjyFIRUe5iiVu
         Aulsjxt1UIhqB8bHtPf29o+dxWlum2XtJsm/5yDZb9WyfpcZsSHAMzuE0FOJuznjZH3p
         ac5yR2zEfIgWQgVe62nSeDufihIAh5P9sbeFH+3CHfWcU4Mi17rmw2yMide14LlAQPjk
         vN093GvR3qHyKJFIp+2qBMUFMWsAqxDtdVAuTtQRWDvo8Rw5m5XKHr4W6NNDBj5Fswh+
         9gmA==
X-Gm-Message-State: AOJu0YztJGtXC+8tWbiZSitrgheXG31kM+6YBy6e+mCeyK8F2/TS0Cri
	Ua5FW9YEZgExbYLMtxUteXttbz0ICNws+tQsbsI=
X-Google-Smtp-Source: AGHT+IEQbz38OEMmaAxShlCpnk5vAIfmtKEAuRhY7f4fJl2S/Nr/jRK+aJ6GPVUC+Q1kC2pjvPas2cOPP2U5EVvcogc=
X-Received: by 2002:a17:907:7daa:b0:9b2:b37d:17ff with SMTP id
 oz42-20020a1709077daa00b009b2b37d17ffmr13317114ejc.19.1696948567767; Tue, 10
 Oct 2023 07:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231010014835.947330-1-bhstalel@gmail.com> <49ed9ab41a08e2665bc66080d1955d078cb2d888.camel@linuxfoundation.org>
In-Reply-To: <49ed9ab41a08e2665bc66080d1955d078cb2d888.camel@linuxfoundation.org>
From: Talel BELHADJ SALEM <bhstalel@gmail.com>
Date: Tue, 10 Oct 2023 15:35:56 +0100
Message-ID: <CAOgG7m2BVasNj-xPFMbP0VBBi5aXB0tGF84fiK1QFY+1eNFmrg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] Ensure that BBFILE_COLLECTIONS and BBPATH
 exist at add-layers and parsing
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000095818906075da028"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Oct 2023 14:36:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15204

--00000000000095818906075da028
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Richard

Thanks for the reply,

Regarding the second comment:

Do you mean using addpylib can be an alternative for not setting
BBFILE_COLLECTIONS and BBPATH ? If yes, I can't see an example on how to do
that.

Kind regards,
Talel

On Tue, Oct 10, 2023 at 1:48=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Tue, 2023-10-10 at 02:48 +0100, BELHADJ SALEM Talel wrote:
> > Empty layer.conf is added to bblayers.conf and not shown by show-layers=
.
> >
> > It will have no effect on BBFILES or BBPATH so no need to add it in the
> first place.
> >
> > Other than this, when working with the layer.conf variables, I noticed
> the following:
> >
> > 1) No BBFILE_COLLECTIONS will lead to no effect for BBFILE_PATTERN, so
> BBFILES on its own work well.
> > 2) No BBFILE_COLLECTIONS and no BBPATH with BBFILES set to a directoy
> will work as well but custom inherits will fail only if the recipe matche=
s:
> meta-*/*.bb.
> >    So checking on BBPATH will also fix this.
> >
> > In conclusion any messing around with layer.conf's variables will lead
> to unexpected behavior.
> >
> > Making sure BBFILE_COLLECTIONS exist will ensure:
> >       - error if no LAYERSERIES_COMPAT
> >       - error if no BBFILE_PATTERN
> >       - warning if no BBFILES
> >       - Layer shown in (bitbake-layers show-layers)
> >
> > Making sure BBPATH exist will ensure that classes and conf found
> regardless of BBFILES content (it can be a directory that will trigger
> find_bbfiles)
> >
> > Signed-off-by: Talel BELHAJSALEM <bhstalel@gmail.com>
> > ---
> >  bitbake/lib/bb/cooker.py       |  2 +-
> >  bitbake/lib/bb/cookerdata.py   |  7 ++++++-
> >  bitbake/lib/bblayers/action.py | 26 ++++++++++++++++++++++++++
> >  3 files changed, 33 insertions(+), 2 deletions(-)
> >
> > diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> > index 2adf4d297d..f163d3a2a3 100644
> > --- a/bitbake/lib/bb/cooker.py
> > +++ b/bitbake/lib/bb/cooker.py
> > @@ -1827,7 +1827,7 @@ class CookerCollectFiles(object):
> >              for ignored in ('SCCS', 'CVS', '.svn'):
> >                  if ignored in dirs:
> >                      dirs.remove(ignored)
> > -            found +=3D [os.path.join(dir, f) for f in files if
> (f.endswith(['.bb', '.bbappend']))]
> > +            found +=3D [os.path.join(dir, f) for f in files if
> (f.endswith(('.bb', '.bbappend')))]
> >
> >          return found
>
> I think this piece should become a separate commit.
>
> >
> > diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.p=
y
> > index ec3741cc1d..fd1e0cf06f 100644
> > --- a/bitbake/lib/bb/cookerdata.py
> > +++ b/bitbake/lib/bb/cookerdata.py
> > @@ -18,6 +18,7 @@ from functools import wraps
> >  import bb
> >  from bb import data
> >  import bb.parse
> > +from bblayers.action import ActionPlugin
> >
> >  logger      =3D logging.getLogger("BitBake")
> >  parselog    =3D logging.getLogger("BitBake.Parsing")
> > @@ -377,7 +378,11 @@ class CookerDataBuilder(object):
> >                      layer =3D layer.rstrip('/')
> >                  data.setVar('LAYERDIR', layer)
> >                  data.setVar('LAYERDIR_RE', re.escape(layer))
> > -                data =3D parse_config_file(os.path.join(layer, "conf",
> "layer.conf"), data)
> > +                layer_conf =3D os.path.join(layer, "conf", "layer.conf=
")
> > +                res, msg =3D ActionPlugin.do_check_layer(layer_conf)
> > +                if not res:
> > +                    bb.fatal(msg)
> > +                data =3D parse_config_file(layer_conf, data)
> >                  data.expandVarref('LAYERDIR')
> >                  data.expandVarref('LAYERDIR_RE')
> >
> > diff --git a/bitbake/lib/bblayers/action.py
> b/bitbake/lib/bblayers/action.py
> > index 454c251410..5a2fcf7f8f 100644
> > --- a/bitbake/lib/bblayers/action.py
> > +++ b/bitbake/lib/bblayers/action.py
> > @@ -23,6 +23,27 @@ def plugin_init(plugins):
> >
> >
> >  class ActionPlugin(LayerPlugin):
> > +
> > +    def do_check_layer(path):
> > +        """
> > +        make sure that BBFILE_COLLECTIONS and BBPATH are found in
> layer.conf
> > +        they should exist in non-commented lines
> > +        """
> > +        def _is_found(var, line):
> > +                return var in line and not line.startswith('#')
> > +
> > +        with open(path) as layer_conf_fd:
> > +            lines =3D layer_conf_fd.readlines()
> > +            find_result =3D {}
> > +            for to_find in ['BBFILE_COLLECTIONS', 'BBPATH']:
> > +                for line in lines:
> > +                    find_result[to_find] =3D True if _is_found(to_find=
,
> line) else False
> > +                    if find_result[to_find]:
> > +                        break
> > +                if not find_result[to_find]:
> > +                    return False, "Specified layer configuration %s
> doesn't contain %s\n" % (path, to_find)
> > +        return True, ""
> > +
>
> I don't think writing a new parser is a great idea. There are other
> ways we could detect if those variables were set/changed.
>
> I'd also question whether this is correct. It would be perfectly fine
> for a layer just to add python library files using addpylib for example
> and not set BB_FILE_COLLECTIONS or BBPATH.
>
> Cheers,
>
> Richard
>

--00000000000095818906075da028
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello=C2=A0Richard<div><br></div><div>Thanks=C2=A0for the =
reply,</div><div><br></div><div>Regarding the second comment:</div><div><br=
></div><div><span style=3D"color:rgb(34,35,31);font-family:&quot;Source San=
s Pro&quot;,Helvetica,sans-serif;font-size:15.12px">Do you mean using addpy=
lib can be an alternative for not setting BBFILE_COLLECTIONS and BBPATH ? I=
f yes, I can&#39;t see an example on how to do that.</span></div><div><span=
 style=3D"color:rgb(34,35,31);font-family:&quot;Source Sans Pro&quot;,Helve=
tica,sans-serif;font-size:15.12px"><br></span></div><div><span style=3D"col=
or:rgb(34,35,31);font-family:&quot;Source Sans Pro&quot;,Helvetica,sans-ser=
if;font-size:15.12px">Kind regards,</span></div><div><span style=3D"color:r=
gb(34,35,31);font-family:&quot;Source Sans Pro&quot;,Helvetica,sans-serif;f=
ont-size:15.12px">Talel</span></div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 10, 2023 at 1:48=E2=80=AFPM=
 Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">r=
ichard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Tue, 2023-10-10 at 02:48 +0100, BELHADJ=
 SALEM Talel wrote:<br>
&gt; Empty layer.conf is added to bblayers.conf and not shown by show-layer=
s.<br>
&gt; <br>
&gt; It will have no effect on BBFILES or BBPATH so no need to add it in th=
e first place.<br>
&gt; <br>
&gt; Other than this, when working with the layer.conf variables, I noticed=
 the following:<br>
&gt; <br>
&gt; 1) No BBFILE_COLLECTIONS will lead to no effect for BBFILE_PATTERN, so=
 BBFILES on its own work well.<br>
&gt; 2) No BBFILE_COLLECTIONS and no BBPATH with BBFILES set to a directoy =
will work as well but custom inherits will fail only if the recipe matches:=
 meta-*/*.bb.<br>
&gt;=C2=A0 =C2=A0 So checking on BBPATH will also fix this.<br>
&gt; <br>
&gt; In conclusion any messing around with layer.conf&#39;s variables will =
lead to unexpected behavior.<br>
&gt; <br>
&gt; Making sure BBFILE_COLLECTIONS exist will ensure:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- error if no LAYERSERIES_COMPAT<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- error if no BBFILE_PATTERN<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- warning if no BBFILES<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Layer shown in (bitbake-layers show-layers=
)<br>
&gt; <br>
&gt; Making sure BBPATH exist will ensure that classes and conf found regar=
dless of BBFILES content (it can be a directory that will trigger find_bbfi=
les)<br>
&gt; <br>
&gt; Signed-off-by: Talel BELHAJSALEM &lt;<a href=3D"mailto:bhstalel@gmail.=
com" target=3D"_blank">bhstalel@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 bitbake/lib/bb/cooker.py=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
&gt;=C2=A0 bitbake/lib/bb/cookerdata.py=C2=A0 =C2=A0|=C2=A0 7 ++++++-<br>
&gt;=C2=A0 bitbake/lib/bblayers/action.py | 26 ++++++++++++++++++++++++++<b=
r>
&gt;=C2=A0 3 files changed, 33 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py<br>
&gt; index 2adf4d297d..f163d3a2a3 100644<br>
&gt; --- a/bitbake/lib/bb/cooker.py<br>
&gt; +++ b/bitbake/lib/bb/cooker.py<br>
&gt; @@ -1827,7 +1827,7 @@ class CookerCollectFiles(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for ignored in (&#39;S=
CCS&#39;, &#39;CVS&#39;, &#39;.svn&#39;):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ignor=
ed in dirs:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dirs.remove(ignored)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 found +=3D [os.path.join(di=
r, f) for f in files if (f.endswith([&#39;.bb&#39;, &#39;.bbappend&#39;]))]=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 found +=3D [os.path.join(di=
r, f) for f in files if (f.endswith((&#39;.bb&#39;, &#39;.bbappend&#39;)))]=
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return found<br>
<br>
I think this piece should become a separate commit.<br>
<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.=
py<br>
&gt; index ec3741cc1d..fd1e0cf06f 100644<br>
&gt; --- a/bitbake/lib/bb/cookerdata.py<br>
&gt; +++ b/bitbake/lib/bb/cookerdata.py<br>
&gt; @@ -18,6 +18,7 @@ from functools import wraps<br>
&gt;=C2=A0 import bb<br>
&gt;=C2=A0 from bb import data<br>
&gt;=C2=A0 import bb.parse<br>
&gt; +from bblayers.action import ActionPlugin<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 logger=C2=A0 =C2=A0 =C2=A0 =3D logging.getLogger(&quot;BitBake&q=
uot;)<br>
&gt;=C2=A0 parselog=C2=A0 =C2=A0 =3D logging.getLogger(&quot;BitBake.Parsin=
g&quot;)<br>
&gt; @@ -377,7 +378,11 @@ class CookerDataBuilder(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 layer =3D layer.rstrip(&#39;/&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data.set=
Var(&#39;LAYERDIR&#39;, layer)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data.set=
Var(&#39;LAYERDIR_RE&#39;, re.escape(layer))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D pars=
e_config_file(os.path.join(layer, &quot;conf&quot;, &quot;layer.conf&quot;)=
, data)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layer_conf =
=3D os.path.join(layer, &quot;conf&quot;, &quot;layer.conf&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res, msg =3D =
ActionPlugin.do_check_layer(layer_conf)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not res:<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 bb.fatal(msg)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D pars=
e_config_file(layer_conf, data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data.exp=
andVarref(&#39;LAYERDIR&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data.exp=
andVarref(&#39;LAYERDIR_RE&#39;)<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bitbake/lib/bblayers/action.py b/bitbake/lib/bblayers/act=
ion.py<br>
&gt; index 454c251410..5a2fcf7f8f 100644<br>
&gt; --- a/bitbake/lib/bblayers/action.py<br>
&gt; +++ b/bitbake/lib/bblayers/action.py<br>
&gt; @@ -23,6 +23,27 @@ def plugin_init(plugins):<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 class ActionPlugin(LayerPlugin):<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def do_check_layer(path):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 make sure that BBFILE_COLLECTIONS and BBP=
ATH are found in layer.conf<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 they should exist in non-commented lines<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 def _is_found(var, line):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return var in=
 line and not line.startswith(&#39;#&#39;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(path) as layer_conf_fd:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lines =3D layer_conf_fd.rea=
dlines()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 find_result =3D {}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for to_find in [&#39;BBFILE=
_COLLECTIONS&#39;, &#39;BBPATH&#39;]:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for line in l=
ines:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 find_result[to_find] =3D True if _is_found(to_find, line) else False<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if find_result[to_find]:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 break<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not find_r=
esult[to_find]:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return False, &quot;Specified layer configuration %s doesn&#39;t contain %=
s\n&quot; % (path, to_find)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return True, &quot;&quot;<br>
&gt; +<br>
<br>
I don&#39;t think writing a new parser is a great idea. There are other<br>
ways we could detect if those variables were set/changed.<br>
<br>
I&#39;d also question whether this is correct. It would be perfectly fine<b=
r>
for a layer just to add python library files using addpylib for example<br>
and not set BB_FILE_COLLECTIONS or BBPATH.<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--00000000000095818906075da028--

