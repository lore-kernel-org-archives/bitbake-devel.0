Return-Path: <bhstalel@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC18CD68FC
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 08:04:56 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web11.85820.1696925094167886232
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Oct 2023 01:04:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Fi95PvGT;
 spf=pass (domain: gmail.com, ip: 209.85.218.48, mailfrom: bhstalel@gmail.com)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-99357737980so924742466b.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Oct 2023 01:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696925092; x=1697529892; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yftYGgprK0NEwXiAuu0jb61jkkjnTw+j/yz3vuSOD3A=;
        b=Fi95PvGTJaWlKGdWuRUsNOTaQT/lYPeSFTP+tD7yEGW07GpnTlNNxk8tgYu22JJRCF
         BglmC6vl+8crlSE8Ph2WNR5tDk59xLXI1WJRXlkLoa/CHnVxCsqbjQ21O+lalcITw1aZ
         7Lo11a4WIPNNFU4/9GCnnzRpokdcMmPwYK26U1X9kFfHwWYyvr/Tu5qjrx1/6G1Tdds8
         4uRzW/YzI93/snIbE02fOy3/5zi61RQqOvp9ARoUnzfgAwu+XOQUUo1rXrT9ODP75lAI
         kEKz11Htt5iHMxPIFTGs9I5mU162PP7oQW4lSsa+ST3BLJ9OfodYOP8Y9pFpTL/LcqDM
         T5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696925092; x=1697529892;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yftYGgprK0NEwXiAuu0jb61jkkjnTw+j/yz3vuSOD3A=;
        b=vL8QOTjJY0+7ZsYMDHkR6O7JGvk+18E2umfTovegIhRtgELVHKZkwC9/j3p04MWbRB
         4ccZllObm+ObwpNtGNEJ9y3VxFJNhKPAdW3UnKDEUmNVfmTUKmuFB3kxktaJfwrTiqZD
         8dejYQGEB0GT8vWbpyJ8zHSN6woKQwb0yZQs/a0Udqxh6/zl8eNvYRd6UR7FkFE4vdyY
         tZNcvnuSsztcncUQ7VDon9DFdA9dTpw3sg+ZUmSppEwM/ouSQ1xca3sMl4XteqpRa00B
         JExyQXqBr5CIbsQYxDhEZJStMq3GfRRuaxOt8OxZK0x1q+Dvm6JffXaXStB+EXQMVru4
         BuRA==
X-Gm-Message-State: AOJu0YygdlIBeORfTGrG/fCkPTHji92m8ZzGwWJKm7+uIJ0HjjH/K1hf
	If4ZgdzQOWj8Cx6b1b6O9D/LcUA07QqWQjPNAaDE1KTKCN8=
X-Google-Smtp-Source: AGHT+IGeEkBDYUo/Jf4r1vvrTHeRHXur/7a69IfnzrvzWTkQ5BC9GuOXMNha/EN5XxIi745e7UTIc+bDhKb3TTRDcEs=
X-Received: by 2002:a17:906:314c:b0:9a5:d657:47e1 with SMTP id
 e12-20020a170906314c00b009a5d65747e1mr16265660eje.43.1696925092053; Tue, 10
 Oct 2023 01:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231010014835.947330-1-bhstalel@gmail.com>
In-Reply-To: <20231010014835.947330-1-bhstalel@gmail.com>
From: Talel BELHADJ SALEM <bhstalel@gmail.com>
Date: Tue, 10 Oct 2023 09:04:40 +0100
Message-ID: <CAOgG7m1C02mjA6Pici=gzF=9ou055+Z96ZXj=Q_tCab8Hhw1CA@mail.gmail.com>
Subject: Re: [PATCH] Ensure that BBFILE_COLLECTIONS and BBPATH exist at
 add-layers and parsing
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000005286f60607582949"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Oct 2023 08:04:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15200

--0000000000005286f60607582949
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I was coding this at 2 in the morning then I realized a simple check on the
start of the line for a given variable is enough.
But also it can be a pattern for BBFILE_COLLECTIONS or other ideas. This
can be fixed, but I need a review on the idea itself first.

Kind regards
Talel

On Tue, Oct 10, 2023 at 2:49=E2=80=AFAM Talel BELHAJSALEM <bhstalel@gmail.c=
om>
wrote:

> Empty layer.conf is added to bblayers.conf and not shown by show-layers.
>
> It will have no effect on BBFILES or BBPATH so no need to add it in the
> first place.
>
> Other than this, when working with the layer.conf variables, I noticed th=
e
> following:
>
> 1) No BBFILE_COLLECTIONS will lead to no effect for BBFILE_PATTERN, so
> BBFILES on its own work well.
> 2) No BBFILE_COLLECTIONS and no BBPATH with BBFILES set to a directoy wil=
l
> work as well but custom inherits will fail only if the recipe matches:
> meta-*/*.bb.
>    So checking on BBPATH will also fix this.
>
> In conclusion any messing around with layer.conf's variables will lead to
> unexpected behavior.
>
> Making sure BBFILE_COLLECTIONS exist will ensure:
>         - error if no LAYERSERIES_COMPAT
>         - error if no BBFILE_PATTERN
>         - warning if no BBFILES
>         - Layer shown in (bitbake-layers show-layers)
>
> Making sure BBPATH exist will ensure that classes and conf found
> regardless of BBFILES content (it can be a directory that will trigger
> find_bbfiles)
>
> Signed-off-by: Talel BELHAJSALEM <bhstalel@gmail.com>
> ---
>  bitbake/lib/bb/cooker.py       |  2 +-
>  bitbake/lib/bb/cookerdata.py   |  7 ++++++-
>  bitbake/lib/bblayers/action.py | 26 ++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 2adf4d297d..f163d3a2a3 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1827,7 +1827,7 @@ class CookerCollectFiles(object):
>              for ignored in ('SCCS', 'CVS', '.svn'):
>                  if ignored in dirs:
>                      dirs.remove(ignored)
> -            found +=3D [os.path.join(dir, f) for f in files if
> (f.endswith(['.bb', '.bbappend']))]
> +            found +=3D [os.path.join(dir, f) for f in files if
> (f.endswith(('.bb', '.bbappend')))]
>
>          return found
>
> diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
> index ec3741cc1d..fd1e0cf06f 100644
> --- a/bitbake/lib/bb/cookerdata.py
> +++ b/bitbake/lib/bb/cookerdata.py
> @@ -18,6 +18,7 @@ from functools import wraps
>  import bb
>  from bb import data
>  import bb.parse
> +from bblayers.action import ActionPlugin
>
>  logger      =3D logging.getLogger("BitBake")
>  parselog    =3D logging.getLogger("BitBake.Parsing")
> @@ -377,7 +378,11 @@ class CookerDataBuilder(object):
>                      layer =3D layer.rstrip('/')
>                  data.setVar('LAYERDIR', layer)
>                  data.setVar('LAYERDIR_RE', re.escape(layer))
> -                data =3D parse_config_file(os.path.join(layer, "conf",
> "layer.conf"), data)
> +                layer_conf =3D os.path.join(layer, "conf", "layer.conf")
> +                res, msg =3D ActionPlugin.do_check_layer(layer_conf)
> +                if not res:
> +                    bb.fatal(msg)
> +                data =3D parse_config_file(layer_conf, data)
>                  data.expandVarref('LAYERDIR')
>                  data.expandVarref('LAYERDIR_RE')
>
> diff --git a/bitbake/lib/bblayers/action.py
> b/bitbake/lib/bblayers/action.py
> index 454c251410..5a2fcf7f8f 100644
> --- a/bitbake/lib/bblayers/action.py
> +++ b/bitbake/lib/bblayers/action.py
> @@ -23,6 +23,27 @@ def plugin_init(plugins):
>
>
>  class ActionPlugin(LayerPlugin):
> +
> +    def do_check_layer(path):
> +        """
> +        make sure that BBFILE_COLLECTIONS and BBPATH are found in
> layer.conf
> +        they should exist in non-commented lines
> +        """
> +        def _is_found(var, line):
> +                return var in line and not line.startswith('#')
> +
> +        with open(path) as layer_conf_fd:
> +            lines =3D layer_conf_fd.readlines()
> +            find_result =3D {}
> +            for to_find in ['BBFILE_COLLECTIONS', 'BBPATH']:
> +                for line in lines:
> +                    find_result[to_find] =3D True if _is_found(to_find,
> line) else False
> +                    if find_result[to_find]:
> +                        break
> +                if not find_result[to_find]:
> +                    return False, "Specified layer configuration %s
> doesn't contain %s\n" % (path, to_find)
> +        return True, ""
> +
>      def do_add_layer(self, args):
>          """Add one or more layers to bblayers.conf."""
>          layerdirs =3D [os.path.abspath(ldir) for ldir in args.layerdir]
> @@ -37,6 +58,11 @@ class ActionPlugin(LayerPlugin):
>                  sys.stderr.write("Specified layer directory %s doesn't
> contain a conf/layer.conf file\n" % layerdir)
>                  return 1
>
> +            res, msg =3D ActionPlugin.do_check_layer(layer_conf)
> +            if not res:
> +                sys.stderr.write(msg)
> +                return 1
> +
>          bblayers_conf =3D os.path.join('conf', 'bblayers.conf')
>          if not os.path.exists(bblayers_conf):
>              sys.stderr.write("Unable to find bblayers.conf\n")
> --
> 2.25.1
>
>

--0000000000005286f60607582949
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I was coding this at 2 in the morning then I realized a si=
mple check on the start of the line for a given variable is enough.<div>But=
 also it can be a pattern for BBFILE_COLLECTIONS or other ideas. This can b=
e fixed, but I need a review on the idea itself first.</div><div><br></div>=
<div>Kind=C2=A0regards</div><div>Talel</div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 10, 2023 at 2:49=E2=
=80=AFAM Talel BELHAJSALEM &lt;<a href=3D"mailto:bhstalel@gmail.com">bhstal=
el@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Empty layer.conf is added to bblayers.conf and not shown by sho=
w-layers.<br>
<br>
It will have no effect on BBFILES or BBPATH so no need to add it in the fir=
st place.<br>
<br>
Other than this, when working with the layer.conf variables, I noticed the =
following:<br>
<br>
1) No BBFILE_COLLECTIONS will lead to no effect for BBFILE_PATTERN, so BBFI=
LES on its own work well.<br>
2) No BBFILE_COLLECTIONS and no BBPATH with BBFILES set to a directoy will =
work as well but custom inherits will fail only if the recipe matches: meta=
-*/*.bb.<br>
=C2=A0 =C2=A0So checking on BBPATH will also fix this.<br>
<br>
In conclusion any messing around with layer.conf&#39;s variables will lead =
to unexpected behavior.<br>
<br>
Making sure BBFILE_COLLECTIONS exist will ensure:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 - error if no LAYERSERIES_COMPAT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 - error if no BBFILE_PATTERN<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 - warning if no BBFILES<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Layer shown in (bitbake-layers show-layers)<b=
r>
<br>
Making sure BBPATH exist will ensure that classes and conf found regardless=
 of BBFILES content (it can be a directory that will trigger find_bbfiles)<=
br>
<br>
Signed-off-by: Talel BELHAJSALEM &lt;<a href=3D"mailto:bhstalel@gmail.com" =
target=3D"_blank">bhstalel@gmail.com</a>&gt;<br>
---<br>
=C2=A0bitbake/lib/bb/cooker.py=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0bitbake/lib/bb/cookerdata.py=C2=A0 =C2=A0|=C2=A0 7 ++++++-<br>
=C2=A0bitbake/lib/bblayers/action.py | 26 ++++++++++++++++++++++++++<br>
=C2=A03 files changed, 33 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py<br>
index 2adf4d297d..f163d3a2a3 100644<br>
--- a/bitbake/lib/bb/cooker.py<br>
+++ b/bitbake/lib/bb/cooker.py<br>
@@ -1827,7 +1827,7 @@ class CookerCollectFiles(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for ignored in (&#39;SCCS&#=
39;, &#39;CVS&#39;, &#39;.svn&#39;):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ignored in=
 dirs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0dirs.remove(ignored)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 found +=3D [os.path.join(dir, f)=
 for f in files if (f.endswith([&#39;.bb&#39;, &#39;.bbappend&#39;]))]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 found +=3D [os.path.join(dir, f)=
 for f in files if (f.endswith((&#39;.bb&#39;, &#39;.bbappend&#39;)))]<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return found<br>
<br>
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py<br=
>
index ec3741cc1d..fd1e0cf06f 100644<br>
--- a/bitbake/lib/bb/cookerdata.py<br>
+++ b/bitbake/lib/bb/cookerdata.py<br>
@@ -18,6 +18,7 @@ from functools import wraps<br>
=C2=A0import bb<br>
=C2=A0from bb import data<br>
=C2=A0import bb.parse<br>
+from bblayers.action import ActionPlugin<br>
<br>
=C2=A0logger=C2=A0 =C2=A0 =C2=A0 =3D logging.getLogger(&quot;BitBake&quot;)=
<br>
=C2=A0parselog=C2=A0 =C2=A0 =3D logging.getLogger(&quot;BitBake.Parsing&quo=
t;)<br>
@@ -377,7 +378,11 @@ class CookerDataBuilder(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0layer =3D layer.rstrip(&#39;/&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data.setVar(&=
#39;LAYERDIR&#39;, layer)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data.setVar(&=
#39;LAYERDIR_RE&#39;, re.escape(layer))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D parse_con=
fig_file(os.path.join(layer, &quot;conf&quot;, &quot;layer.conf&quot;), dat=
a)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layer_conf =3D os.=
path.join(layer, &quot;conf&quot;, &quot;layer.conf&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res, msg =3D Actio=
nPlugin.do_check_layer(layer_conf)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not res:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.f=
atal(msg)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D parse_con=
fig_file(layer_conf, data)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data.expandVa=
rref(&#39;LAYERDIR&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data.expandVa=
rref(&#39;LAYERDIR_RE&#39;)<br>
<br>
diff --git a/bitbake/lib/bblayers/action.py b/bitbake/lib/bblayers/action.p=
y<br>
index 454c251410..5a2fcf7f8f 100644<br>
--- a/bitbake/lib/bblayers/action.py<br>
+++ b/bitbake/lib/bblayers/action.py<br>
@@ -23,6 +23,27 @@ def plugin_init(plugins):<br>
<br>
<br>
=C2=A0class ActionPlugin(LayerPlugin):<br>
+<br>
+=C2=A0 =C2=A0 def do_check_layer(path):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 make sure that BBFILE_COLLECTIONS and BBPATH a=
re found in layer.conf<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 they should exist in non-commented lines<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def _is_found(var, line):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return var in line=
 and not line.startswith(&#39;#&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(path) as layer_conf_fd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lines =3D layer_conf_fd.readline=
s()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 find_result =3D {}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for to_find in [&#39;BBFILE_COLL=
ECTIONS&#39;, &#39;BBPATH&#39;]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for line in lines:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 find=
_result[to_find] =3D True if _is_found(to_find, line) else False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if f=
ind_result[to_find]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not find_result=
[to_find]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn False, &quot;Specified layer configuration %s doesn&#39;t contain %s\n&q=
uot; % (path, to_find)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return True, &quot;&quot;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def do_add_layer(self, args):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Add one or more layers =
to bblayers.conf.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layerdirs =3D [os.path.abspath(ldir) for =
ldir in args.layerdir]<br>
@@ -37,6 +58,11 @@ class ActionPlugin(LayerPlugin):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.stderr.wr=
ite(&quot;Specified layer directory %s doesn&#39;t contain a conf/layer.con=
f file\n&quot; % layerdir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res, msg =3D ActionPlugin.do_che=
ck_layer(layer_conf)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not res:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.stderr.write(m=
sg)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bblayers_conf =3D os.path.join(&#39;conf&=
#39;, &#39;bblayers.conf&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not os.path.exists(bblayers_conf):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.stderr.write(&quot;Unab=
le to find bblayers.conf\n&quot;)<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div>

--0000000000005286f60607582949--

