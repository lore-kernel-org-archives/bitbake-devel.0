Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE89AD69107
	for <webhook@archiver.kernel.org>; Thu, 28 Nov 2024 12:54:47 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.94197.1732798477129475579
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Nov 2024 04:54:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=B9pxazK/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a742481aso6989405e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 Nov 2024 04:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732798475; x=1733403275; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZM9bNlenoS7biaT0Intfn96FHk2Th8XNbuQLZg97hD4=;
        b=B9pxazK/CUbdHfPiCpwpFJN7LVB+6jGDROshaj6jLq1JuZ9BEIXba1hPtP4ZkahBg1
         TY0zc8k7sTfKDB5bDiZPcS6gsu5T8nsThiv1YbZDs6pNOey/W1lk+7Csi/631iwVjHAD
         ETv1zQEIpaEadg/iZumgZ5P1YKejpzvebRKYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732798475; x=1733403275;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZM9bNlenoS7biaT0Intfn96FHk2Th8XNbuQLZg97hD4=;
        b=e+iNrCk6rlQZB5ZLwbrUD8RDujbiwWwxqCEY9hekBNyfk6WLAunpkDKQAnePgh5gkU
         MrrJHfYIbu6unAA8qGp1Wbiy/t3TYyhZUdH7wP1T4Hs8zrzrjx+4k/fiK7t/uUMmLdYi
         j1gG4wvLgYojlX50TAyrn7A771RDixveX8dHcHEFAKjeedDLrBj7BN6rGxKpoJ62JtD0
         MlYxIq90QfzlM8OxIYyvFhsDCOJS8MxzAwMkpckNCQvOvFqVvU1XkmZBXnFQaTBY0c+L
         041hcPix0Csp2zdrz4RhG6woFtWjhcAkt2zdyXGc4A9EFc+w/5wIJpvmjaSWxU7HSovi
         8GZA==
X-Forwarded-Encrypted: i=1; AJvYcCVOtwgHpbSRj0JZBIJP6xkcPjSbSmuc73WJXv4L5cPj3qOGUbC5+vnF8Y2L+FCmJ3nsXzGSuvENrA5zi0qj@lists.openembedded.org
X-Gm-Message-State: AOJu0YyQOKJkBMPzAk3SfcTeyPA0AQikowtnmaG3vBUQ0odaevARTHf3
	9z+x1YnWUyn1Xzs/sxDLFl1ySBSUwmwupmWdARVnv34otfbQSHq7obniIWydpkM=
X-Gm-Gg: ASbGnctPpClruPS3Urh74gKQFWlwtw5IYq0PwzVO4EaB/PTEo0MvKVZfX30hYEl2Joc
	KuJRTLEcUdQP/YLhGOVTnztof3QKBmP87BhrDSv6kvAP3hxjUAWSWoexQT2p65c7f1jq8bT+BBa
	MFjc4863iCNEDtX0N+sVtRu/1C3sVVH6fAZ10OtJf7QGK3ZX05/RJHiTBkgRFLjcKdYaQjrh36z
	xXHB9iczyvGaT1d2cciXyb1eSRqwjKNtkHpHpAuorIIsL9ybvW4xlAbTTFNvPt0gvqqAYtjR5FD
	EZRQ362h1h2YxXgtAW3fCyGyDujlhHPZFhtnxdA=
X-Google-Smtp-Source: AGHT+IED0xvRvi5XHqA9cY8tWce6Yjd6B1hAgQSQU1/14gTzgMMLPtZRJNVVRM8vTT/2KuQTGXxhlw==
X-Received: by 2002:a05:600c:458d:b0:433:c463:62dd with SMTP id 5b1f17b1804b1-434a9e0e5femr62381835e9.27.1732798475306;
        Thu, 28 Nov 2024 04:54:35 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:930d:1506:79bd:20bc? ([2001:8b0:aba:5f3c:930d:1506:79bd:20bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f7dccasm21176435e9.43.2024.11.28.04.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 04:54:34 -0800 (PST)
Message-ID: <215a45a05eb2be50b71ad3c044334635239ff0e4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 3/4] parse: add support for
 'addfragments' directive
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Thu, 28 Nov 2024 12:54:33 +0000
In-Reply-To: <20241118162610.1423384-3-alex.kanavin@gmail.com>
References: <20241118162610.1423384-1-alex.kanavin@gmail.com>
	 <20241118162610.1423384-3-alex.kanavin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Nov 2024 12:54:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16846

Hi Alex,

Thanks for working on this. It is close but there is one small issue
needing to be resolved below.

On Mon, 2024-11-18 at 17:26 +0100, Alexander Kanavin via lists.openembedded=
.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>=20
> It takes two parameters:
> - location prefix for fragments
> - name of variable that holds the list of enabled fragments, each of them=
 prefixed
> by layer id
>=20
> Implementation of this directive essentially expands the fragment list
> obtained from the variable into absolute fragment paths and hands them to=
 the
> implementation of 'require'.
>=20
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
> =C2=A0lib/bb/parse/ast.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 33 +++++++++++++++=
+++++++++++++
> =C2=A0lib/bb/parse/parse_py/ConfHandler.py |=C2=A0 6 +++++
> =C2=A02 files changed, 39 insertions(+)
>=20
> diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
> index 001ba8d289a..d3b7fef9895 100644
> --- a/lib/bb/parse/ast.py
> +++ b/lib/bb/parse/ast.py
> @@ -326,6 +326,34 @@ class InheritDeferredNode(AstNode):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inherits.append(self.inh=
erit)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data.setVar('__BBDEFINHE=
RITS', inherits)
> =C2=A0
> +class AddFragmentsNode(AstNode):
> +=C2=A0=C2=A0=C2=A0 def __init__(self, filename, lineno, fragments_path_p=
refix, fragments_variable):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AstNode.__init__(self, filena=
me, lineno)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.path =3D fragments_path_=
prefix
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.variable =3D fragments_v=
ariable

"path" in bitbake context becomes easily confusing. I think I'd prefer
something like frag_pathprefix or something which makes it clear both
that it isn't a full path and what kind of path it is.

> +
> +=C2=A0=C2=A0=C2=A0 def eval(self, data):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def find_fragment(layers, lay=
erid, full_fragment_name):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for layerpa=
th in layers.split():
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 candidate_fragment_path =3D os.path.join(layerpath, full_fragm=
ent_name)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if os.path.exists(candidate_fragment_path) and bb.utils.get_fi=
le_layer(candidate_fragment_path, data) =3D=3D layerid:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return candidate_fragment_path
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return None
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fragments =3D data.getVar(sel=
f.variable)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 layers =3D data.getVar('BBLAY=
ERS')
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not fragments:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for f in fragments.split():
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 layer=
id, fragment_name =3D f.split('/', 1)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 full_=
fragment_name =3D data.expand("{}/{}.conf".format(self.path, fragment_name)=
)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fragm=
ent_path =3D find_fragment(layers, layerid, full_fragment_name)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if fr=
agment_path:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bb.parse.ConfHandler.include(self.filename, fragment_pat=
h, self.lineno, data, "include fragment")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bb.error("Could not find fragment {} in enabled layers: =
{}".format(f, layers))
> +

Whilst checking if the file exists and only including if present sounds
like the right thing to do, it needs to be a bit more complex. The
issue is that bitbake needs to track both the files it accesses but
also the files it looked for but didn't find. If those files are then
created, we need to reparse.

There are two ways to handle this, one is to trust that the
bb.parse.ConfHandler code does already know how to do this and just
call unconditionally until it matches a file. The apis might not let
you easily know if it found a file.

The other way is to call bb.parse.mark_dependency() and just mark the
accessed files that way.


Otherwise I think this looks good to me, thanks!

Cheers,

Richard

