Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D50CD80C4
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 12:48:28 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.90436.1696942103678767542
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Oct 2023 05:48:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=H+5LslaJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4065f29e933so54791535e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Oct 2023 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696942102; x=1697546902; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RQ4O5BaljDNK+IJn/9nKy/jvcSjQgY18HnyML1xFNY=;
        b=H+5LslaJ0yOUIUngBPv51mP18otkOzfpvkKT4B+uUSxKD53XenE8sVVqEIzl6OvLc5
         lMQUmPrsQo/i+3Fjstv0EGzyz189f8qdpqNi4dCplONzWFP9b05TlEcCNHmBDA8mhkR7
         Q9ZNmBSHIeLAj54ntNCSs17dhbQMeMSluMy00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696942102; x=1697546902;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0RQ4O5BaljDNK+IJn/9nKy/jvcSjQgY18HnyML1xFNY=;
        b=UMbsTAabEh8tUPy5uPccISy+VAtC2tAXFUBBVj6pQyUGR6CEQIFQmZsPL1VDU8R+We
         r6yUd73AZYRKH8h4u6AuWzV4CzwhvTuD6IRNUxJkXsVx5gD/6AL6fvlpUo8KVELWvVCQ
         UljxC21yM/o7as/Lxe2aJmVJ9OotXXd5lsBEg60dzK8tqZk27pbb0X22n5gWsEzCAOGG
         dVDGtGIot+vJSCJNrR0aXXp6RvWHxa+71l2LjlWFlwMQTh7/kctCsoe4Wxz5DTwfqMTS
         rp2tq0/IFnnbMP2Fo8ppn4KWNOFSgzHz/I0vaUUBF29anXmmLemPt5yqF/wvjxNLwMsQ
         Nibw==
X-Gm-Message-State: AOJu0Yx8DPL1P8xLNNQ7bYD4WIzb7iDv+iISgUtSFdgWiIP2hFDKKRLa
	sILT77c0xixijBlRoWbq0Bkehg==
X-Google-Smtp-Source: AGHT+IGxZJcwCQg4JkxCpOZDKkCIVue4cJ7anycXeJ4Sxzl1N/sk9Ur4xl8KjDWIXHG8ixPSBePCyA==
X-Received: by 2002:a05:600c:b4b:b0:405:3f06:c084 with SMTP id k11-20020a05600c0b4b00b004053f06c084mr15403617wmr.13.1696942102043;
        Tue, 10 Oct 2023 05:48:22 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2892:849c:e303:df3f? ([2001:8b0:aba:5f3c:2892:849c:e303:df3f])
        by smtp.gmail.com with ESMTPSA id l25-20020a1c7919000000b00405c7591b09sm14073902wme.35.2023.10.10.05.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:48:21 -0700 (PDT)
Message-ID: <49ed9ab41a08e2665bc66080d1955d078cb2d888.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] Ensure that BBFILE_COLLECTIONS and
 BBPATH exist at add-layers and parsing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: BELHADJ SALEM Talel <bhstalel@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 10 Oct 2023 13:48:20 +0100
In-Reply-To: <20231010014835.947330-1-bhstalel@gmail.com>
References: <20231010014835.947330-1-bhstalel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Oct 2023 12:48:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15203

On Tue, 2023-10-10 at 02:48 +0100, BELHADJ SALEM Talel wrote:
> Empty layer.conf is added to bblayers.conf and not shown by show-layers.
>=20
> It will have no effect on BBFILES or BBPATH so no need to add it in the f=
irst place.
>=20
> Other than this, when working with the layer.conf variables, I noticed th=
e following:
>=20
> 1) No BBFILE_COLLECTIONS will lead to no effect for BBFILE_PATTERN, so BB=
FILES on its own work well.
> 2) No BBFILE_COLLECTIONS and no BBPATH with BBFILES set to a directoy wil=
l work as well but custom inherits will fail only if the recipe matches: me=
ta-*/*.bb.
>    So checking on BBPATH will also fix this.
>=20
> In conclusion any messing around with layer.conf's variables will lead to=
 unexpected behavior.
>=20
> Making sure BBFILE_COLLECTIONS exist will ensure:
> 	- error if no LAYERSERIES_COMPAT
> 	- error if no BBFILE_PATTERN
> 	- warning if no BBFILES
> 	- Layer shown in (bitbake-layers show-layers)
>=20
> Making sure BBPATH exist will ensure that classes and conf found regardle=
ss of BBFILES content (it can be a directory that will trigger find_bbfiles=
)
>=20
> Signed-off-by: Talel BELHAJSALEM <bhstalel@gmail.com>
> ---
>  bitbake/lib/bb/cooker.py       |  2 +-
>  bitbake/lib/bb/cookerdata.py   |  7 ++++++-
>  bitbake/lib/bblayers/action.py | 26 ++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+), 2 deletions(-)
>=20
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 2adf4d297d..f163d3a2a3 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1827,7 +1827,7 @@ class CookerCollectFiles(object):
>              for ignored in ('SCCS', 'CVS', '.svn'):
>                  if ignored in dirs:
>                      dirs.remove(ignored)
> -            found +=3D [os.path.join(dir, f) for f in files if (f.endswi=
th(['.bb', '.bbappend']))]
> +            found +=3D [os.path.join(dir, f) for f in files if (f.endswi=
th(('.bb', '.bbappend')))]
> =20
>          return found

I think this piece should become a separate commit.

> =20
> diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
> index ec3741cc1d..fd1e0cf06f 100644
> --- a/bitbake/lib/bb/cookerdata.py
> +++ b/bitbake/lib/bb/cookerdata.py
> @@ -18,6 +18,7 @@ from functools import wraps
>  import bb
>  from bb import data
>  import bb.parse
> +from bblayers.action import ActionPlugin
> =20
>  logger      =3D logging.getLogger("BitBake")
>  parselog    =3D logging.getLogger("BitBake.Parsing")
> @@ -377,7 +378,11 @@ class CookerDataBuilder(object):
>                      layer =3D layer.rstrip('/')
>                  data.setVar('LAYERDIR', layer)
>                  data.setVar('LAYERDIR_RE', re.escape(layer))
> -                data =3D parse_config_file(os.path.join(layer, "conf", "=
layer.conf"), data)
> +                layer_conf =3D os.path.join(layer, "conf", "layer.conf")
> +                res, msg =3D ActionPlugin.do_check_layer(layer_conf)
> +                if not res:
> +                    bb.fatal(msg)
> +                data =3D parse_config_file(layer_conf, data)
>                  data.expandVarref('LAYERDIR')
>                  data.expandVarref('LAYERDIR_RE')
> =20
> diff --git a/bitbake/lib/bblayers/action.py b/bitbake/lib/bblayers/action=
.py
> index 454c251410..5a2fcf7f8f 100644
> --- a/bitbake/lib/bblayers/action.py
> +++ b/bitbake/lib/bblayers/action.py
> @@ -23,6 +23,27 @@ def plugin_init(plugins):
> =20
> =20
>  class ActionPlugin(LayerPlugin):
> +
> +    def do_check_layer(path):
> +        """
> +        make sure that BBFILE_COLLECTIONS and BBPATH are found in layer.=
conf
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
> +                    find_result[to_find] =3D True if _is_found(to_find, =
line) else False
> +                    if find_result[to_find]:
> +                        break
> +                if not find_result[to_find]:
> +                    return False, "Specified layer configuration %s does=
n't contain %s\n" % (path, to_find)
> +        return True, ""
> +

I don't think writing a new parser is a great idea. There are other
ways we could detect if those variables were set/changed.

I'd also question whether this is correct. It would be perfectly fine
for a layer just to add python library files using addpylib for example
and not set BB_FILE_COLLECTIONS or BBPATH.

Cheers,

Richard

