Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BFCCAC5B0
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 15:58:28 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.12896.1759420704770027163
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Oct 2025 08:58:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=YO9hViqw;
 spf=pass (domain: smile.fr, ip: 209.85.221.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so1000063f8f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1759420703; x=1760025503; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8/J/ofqbz3d3xMAGeyA3VdGWkuhuh3SEFPczgPjup8=;
        b=YO9hViqwn1Hz7edVBrmmyfPRX+l2ktk612HWIpYAFEhF9wiWUjWR3rfwM3scOnOtEq
         K3UOCRg1Ib78FWhAX7ynV6n53h5tHSD0e+T8yG/zDiBvJKpldUvOwZef3rwbdf6JDGT9
         afsYfCzGvLF94OQz/pi02/sLaxMwTghgdUn70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759420703; x=1760025503;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8/J/ofqbz3d3xMAGeyA3VdGWkuhuh3SEFPczgPjup8=;
        b=heEExEqyBAxnllDIolwpwRp5Z36R91x3govqy3DC+8AajLXme+NJcfX3jVxazNHotb
         cfgJotWgHTs0EMAmu48gpHGPfeDtWtABVsaOjJS9curkwTSbjRevvVh0QMTLEKKMKErP
         1/lOOY/HFuYzWGfofK6sc7zaGzvNKWmlFw/SkAVcz0stXkYgypTLtTP+ePhP9S577EPh
         1DJHWRYOLsrnZPjfM/3KEFUstPd8lTPRvAep2d7FLUABVb97f1jWnhVvUjzfnouVrDu8
         aRXyAnLgH6yWxa27CJg+DBQP7soKFDTUKxdTUiQaRxaSK8DlTGL7JFPDhY3xzngNwkXa
         Jaiw==
X-Gm-Message-State: AOJu0Yx9nITsKQAAMZ+WT5t22YVV3/kbDBjTy33nWJVNp/3x3MJs4Uc/
	R4X29JvBuz1BxWIkZNrlgYeSL+4mbtzSk2ndP3cnTZzmpvjONixFw+Ug86uN0yxPsc2GOvC/dnk
	aKYtH0Ya9YExQfKU9de4UnWLCM9zqXkF+GqKOEzLnmiaxT7mwucWx
X-Gm-Gg: ASbGnct3CZZsu945sJ/fDk3lHKDCiDlhv1YqfPgLuLOT76XZn1OvroEN3ptvcio77Ov
	oUwPF8kvLaz31Z+gsuOgvI//iF+EkuiXsENyMLtBlVsV5ZRrd4dVR2UWnHsyV0IDiygiG8iP/Y/
	pV8riXeH8pWLlH7bdYwGgBRIVNnOKeSEeUwhsLTxOXoemV5qt6ZLnHhvrjejjY0P0IVy+CakNUr
	bzhNgg0Z9LreSRtRyY0boH/vzFXweAdtHK0Y1v5D+02bOsoO7Gu5XQhPj209J1guvghRxWpvVDH
X-Google-Smtp-Source: AGHT+IGup0JDfvaQswTxaxBPOkmKe+ihpPOU1xrilxF+yWBWrJSLSu72EyMwfSV1dv46inRD6z6DOZIb+w3hY0iEVuY=
X-Received: by 2002:a05:6000:230c:b0:404:ac77:6598 with SMTP id
 ffacd0b85a97d-425577edd46mr5814057f8f.11.1759420701821; Thu, 02 Oct 2025
 08:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20251002155210.782342-1-yoann.congal@smile.fr>
In-Reply-To: <20251002155210.782342-1-yoann.congal@smile.fr>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Thu, 2 Oct 2025 17:57:56 +0200
X-Gm-Features: AS18NWB1KyA94M02_uXFt9fsOqWua84uUS14h4bO4l4fUDt4ig1VzBTtUo3WEXs
Message-ID: <CAMSfU+7QkYM2KGitg6_tfXYwgRsn11yY-ZQh9uWUkH1UgNCHKQ@mail.gmail.com>
Subject: Re: [RFC PATCH] bitbake-setup: optionally support JSON5 (e.g.
 comments) format
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000f1621f06402f0dd3"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 15:58:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18124

--000000000000f1621f06402f0dd3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 2 oct. 2025 =C3=A0 17:52, Yoann Congal <yoann.congal@smile.fr> a =
=C3=A9crit :

> From: Yoann Congal <yoann.congal@smile.fr>
>
> One major limitation of JSON files is that comments are not supported.
> JSON5 (https://json5.org/) is an extension of the current JSON file
> format that support comments (among other evolutions).
>
> This patch adds the support of the JSON5 file format when reading
> configuration files.
>
> Sadly, no JSON5 support exists in Python stdlib, so we have to install a
> module. I chose https://pypi.org/project/json5/ (but
> https://pypi.org/project/pyjson5/ may be an alternative).
>
> I took care of only patching reading of the config file, the internal
> JSON files of bitbake-setup are still in classic JSON, which mean that
> operations that don't need to read the original configuration still work
> without a json5 module.
>
> I put an example of a JSON5 config in
> default-registry/configurations/poky-master_json5.conf.json
> This is poky-master.conf.json translated to JSON5 plus some comments.
>
> To try this:
>   python3 -m venv .venv; . .venv/bin/activate # if needed
>   pip install json5
>   ./bin/bitbake-setup init
> default-registry/configurations/poky-master_json5.conf.json poky_json5
>

Addendum:
The main need is to have comments in the configuration file.
An alternative is to use the YAML format (which supports comments) but is
still not supported without installing modules outside of python sdtlib.


>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
>  bin/bitbake-setup                             |  8 ++
>  .../poky-master_json5.conf.json               | 93 +++++++++++++++++++
>  2 files changed, 101 insertions(+)
>  create mode 100644
> default-registry/configurations/poky-master_json5.conf.json
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index bb466d85..d1c54269 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -19,6 +19,14 @@ import datetime
>  import glob
>  import subprocess
>
> +try:
> +    # Try to import the non-standard json5 module to load JSON files
> +    from json5 import load as json5_load
> +    json.load =3D json5_load
> +    print("Using json5 to load JSON")
> +except ImportError:
> +    pass
> +
>  default_registry =3D os.path.normpath(os.path.dirname(__file__) +
> "/../default-registry")
>
>  bindir =3D os.path.abspath(os.path.dirname(__file__))
> diff --git a/default-registry/configurations/poky-master_json5.conf.json
> b/default-registry/configurations/poky-master_json5.conf.json
> new file mode 100644
> index 00000000..cf447e9a
> --- /dev/null
> +++ b/default-registry/configurations/poky-master_json5.conf.json
> @@ -0,0 +1,93 @@
> +{
> +    // This file format supports comments
> +    description: "Poky - The Yocto Project testing distribution
> configurations and hardware test platforms",
> +// ^           ^ As long as the object keys are compatible with a JS
> variable name, quotes are optional:
> +    //
> +    sources: {
> +        bitbake: {
> +            "git-remote": { // note "git-remote" is not a valid JS
> variable name because of the dash
> +                remotes: {
> +                    origin: {
> +                        uri: "git://
> git.openembedded.org/bitbake;protocol=3Dhttps",
> +                    },
> +                },
> +                branch: "master",
> +                rev: "master", // This file format accepts a comma after
> the last element of lists/objects
> +            },
> +            path: "bitbake",
> +        },
> +        "openembedded-core": {
> +            "git-remote": {
> +                remotes: {
> +                    origin: {
> +                        uri: "git://
> git.openembedded.org/openembedded-core;protocol=3Dhttps",
> +                    },
> +                },
> +                branch: "master",
> +                rev: "master",
> +            },
> +            path: "openembedded-core",
> +        },
> +        "meta-yocto": {
> +            "git-remote": {
> +                remotes: {
> +                    origin: {
> +                        uri: "git://
> git.yoctoproject.org/meta-yocto;protocol=3Dhttps",
> +                    },
> +                },
> +                branch: "master",
> +                rev: "master",
> +            },
> +            path: "meta-yocto",
> +        },
> +        "yocto-docs": {
> +            "git-remote": {
> +                remotes: {
> +                    origin: {
> +                        uri: "git://
> git.yoctoproject.org/yocto-docs;protocol=3Dhttps",
> +                    },
> +                },
> +                branch: "master",
> +                rev: "master",
> +            },
> +            path: "yocto-docs",
> +        },
> +    },
> +    "bitbake-setup": {
> +        configurations: [
> +            {
> +                name: "poky_json5",
> +                description: "Poky - The Yocto Project testing
> distribution (from a JSON5 config)",
> +                "bb-layers": [
> +                    "openembedded-core/meta",
> +                    "meta-yocto/meta-yocto-bsp",
> +                    "meta-yocto/meta-poky",
> +                ],
> +                "oe-fragments": [
> +                    "core/yocto/sstate-mirror-cdn",
> +                ],
> +                "oe-fragments-one-of": {
> +                    machine: {
> +                        description: "Target machines",
> +                        options: [
> +                            "machine/qemux86-64",
> +                            "machine/qemuarm64",
> +                            "machine/qemuriscv64",
> +                            "machine/genericarm64",
> +                            "machine/genericx86-64",
> +                        ],
> +                    },
> +                    distro: {
> +                        description: "Distribution configuration
> variants",
> +                        options: [
> +                            "distro/poky",
> +                            "distro/poky-altcfg",
> +                            "distro/poky-tiny",
> +                        ],
> +                    },
> +                },
> +            },
> +        ],
> +    },
> +    version: "1.0",
> +}
>


--=20
Yoann Congal
Smile ECS

--000000000000f1621f06402f0dd3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0jeu. 2 =
oct. 2025 =C3=A0=C2=A017:52, Yoann Congal &lt;<a href=3D"mailto:yoann.conga=
l@smile.fr">yoann.congal@smile.fr</a>&gt; a =C3=A9crit=C2=A0:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">From: Yoann Congal &lt;<a hre=
f=3D"mailto:yoann.congal@smile.fr" target=3D"_blank">yoann.congal@smile.fr<=
/a>&gt;<br>
<br>
One major limitation of JSON files is that comments are not supported.<br>
JSON5 (<a href=3D"https://json5.org/" rel=3D"noreferrer" target=3D"_blank">=
https://json5.org/</a>) is an extension of the current JSON file<br>
format that support comments (among other evolutions).<br>
<br>
This patch adds the support of the JSON5 file format when reading<br>
configuration files.<br>
<br>
Sadly, no JSON5 support exists in Python stdlib, so we have to install a<br=
>
module. I chose <a href=3D"https://pypi.org/project/json5/" rel=3D"noreferr=
er" target=3D"_blank">https://pypi.org/project/json5/</a> (but<br>
<a href=3D"https://pypi.org/project/pyjson5/" rel=3D"noreferrer" target=3D"=
_blank">https://pypi.org/project/pyjson5/</a> may be an alternative).<br>
<br>
I took care of only patching reading of the config file, the internal<br>
JSON files of bitbake-setup are still in classic JSON, which mean that<br>
operations that don&#39;t need to read the original configuration still wor=
k<br>
without a json5 module.<br>
<br>
I put an example of a JSON5 config in<br>
default-registry/configurations/poky-master_json5.conf.json<br>
This is poky-master.conf.json translated to JSON5 plus some comments.<br>
<br>
To try this:<br>
=C2=A0 python3 -m venv .venv; . .venv/bin/activate # if needed<br>
=C2=A0 pip install json5<br>
=C2=A0 ./bin/bitbake-setup init default-registry/configurations/poky-master=
_json5.conf.json poky_json5<br></blockquote><div><br></div><div>Addendum:</=
div><div>The main need is to have comments in the configuration file.</div>=
<div>An alternative is to use the YAML format (which supports comments) but=
 is still not supported without installing modules outside of python sdtlib=
.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" ta=
rget=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
---<br>
=C2=A0bin/bitbake-setup=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 ++<br>
=C2=A0.../poky-master_json5.conf.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 93 +++++++++++++++++++<br>
=C2=A02 files changed, 101 insertions(+)<br>
=C2=A0create mode 100644 default-registry/configurations/poky-master_json5.=
conf.json<br>
<br>
diff --git a/bin/bitbake-setup b/bin/bitbake-setup<br>
index bb466d85..d1c54269 100755<br>
--- a/bin/bitbake-setup<br>
+++ b/bin/bitbake-setup<br>
@@ -19,6 +19,14 @@ import datetime<br>
=C2=A0import glob<br>
=C2=A0import subprocess<br>
<br>
+try:<br>
+=C2=A0 =C2=A0 # Try to import the non-standard json5 module to load JSON f=
iles<br>
+=C2=A0 =C2=A0 from json5 import load as json5_load<br>
+=C2=A0 =C2=A0 json.load =3D json5_load<br>
+=C2=A0 =C2=A0 print(&quot;Using json5 to load JSON&quot;)<br>
+except ImportError:<br>
+=C2=A0 =C2=A0 pass<br>
+<br>
=C2=A0default_registry =3D os.path.normpath(os.path.dirname(__file__) + &qu=
ot;/../default-registry&quot;)<br>
<br>
=C2=A0bindir =3D os.path.abspath(os.path.dirname(__file__))<br>
diff --git a/default-registry/configurations/poky-master_json5.conf.json b/=
default-registry/configurations/poky-master_json5.conf.json<br>
new file mode 100644<br>
index 00000000..cf447e9a<br>
--- /dev/null<br>
+++ b/default-registry/configurations/poky-master_json5.conf.json<br>
@@ -0,0 +1,93 @@<br>
+{<br>
+=C2=A0 =C2=A0 // This file format supports comments<br>
+=C2=A0 =C2=A0 description: &quot;Poky - The Yocto Project testing distribu=
tion configurations and hardware test platforms&quot;,<br>
+// ^=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^ As long as the object keys =
are compatible with a JS variable name, quotes are optional:<br>
+=C2=A0 =C2=A0 //<br>
+=C2=A0 =C2=A0 sources: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bitbake: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;git-remote&quot;: { // not=
e &quot;git-remote&quot; is not a valid JS variable name because of the das=
h<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remotes: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 orig=
in: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uri: &quot;git://<a href=3D"http://git.openembedded.org/bitbake;=
protocol=3Dhttps" rel=3D"noreferrer" target=3D"_blank">git.openembedded.org=
/bitbake;protocol=3Dhttps</a>&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 branch: &quot;mast=
er&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rev: &quot;master&=
quot;, // This file format accepts a comma after the last element of lists/=
objects<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: &quot;bitbake&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;openembedded-core&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;git-remote&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remotes: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 orig=
in: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uri: &quot;git://<a href=3D"http://git.openembedded.org/openembe=
dded-core;protocol=3Dhttps" rel=3D"noreferrer" target=3D"_blank">git.openem=
bedded.org/openembedded-core;protocol=3Dhttps</a>&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 branch: &quot;mast=
er&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rev: &quot;master&=
quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: &quot;openembedded-core&qu=
ot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;meta-yocto&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;git-remote&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remotes: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 orig=
in: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uri: &quot;git://<a href=3D"http://git.yoctoproject.org/meta-yoc=
to;protocol=3Dhttps" rel=3D"noreferrer" target=3D"_blank">git.yoctoproject.=
org/meta-yocto;protocol=3Dhttps</a>&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 branch: &quot;mast=
er&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rev: &quot;master&=
quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: &quot;meta-yocto&quot;,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;yocto-docs&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;git-remote&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remotes: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 orig=
in: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uri: &quot;git://<a href=3D"http://git.yoctoproject.org/yocto-do=
cs;protocol=3Dhttps" rel=3D"noreferrer" target=3D"_blank">git.yoctoproject.=
org/yocto-docs;protocol=3Dhttps</a>&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 branch: &quot;mast=
er&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rev: &quot;master&=
quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path: &quot;yocto-docs&quot;,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 &quot;bitbake-setup&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 configurations: [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: &quot;poky_j=
son5&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &quot=
;Poky - The Yocto Project testing distribution (from a JSON5 config)&quot;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;bb-layers&qu=
ot;: [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;openembedded-core/meta&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;meta-yocto/meta-yocto-bsp&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;meta-yocto/meta-poky&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;oe-fragments=
&quot;: [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;core/yocto/sstate-mirror-cdn&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;oe-fragments=
-one-of&quot;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mach=
ine: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 description: &quot;Target machines&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 options: [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;machine/qemux86-64&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;machine/qemuarm64&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;machine/qemuriscv64&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;machine/genericarm64&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;machine/genericx86-64&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dist=
ro: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 description: &quot;Distribution configuration variants&quot;,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 options: [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;distro/poky&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;distro/poky-altcfg&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;distro/poky-tiny&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ],<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 version: &quot;1.0&quot;,<br>
+}<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--000000000000f1621f06402f0dd3--

