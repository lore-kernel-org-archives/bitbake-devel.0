Return-Path: <martin.jansa@gmail.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id 36C4873D4A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Apr 2015 00:31:32 +0000 (UTC)
Received: by wizk4 with SMTP id k4so3511017wiz.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 17:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=ZRm8orstKKM1afcGwH+PuvxCq1tQgJrfbtnHnlGhUdU=;
	b=ezRGyhLbmr/BOwANPw462a5p5inyQOzijTJ0NpXegOmtCGjVwG8Cg/jXpsbBp9l0XG
	Rb81cvZgd/H0bkjGA/Ad3GJA0Ewqu7UKR9QkMZ5kbJhO2EeklKe4wLl9fFDhrvMagt/a
	slP2SnHQcPM1XoAWfQpPd3aR4NP3GJD+N8U9ksC0/VwAlze0nui0qXANwGbjGd9afyvD
	WFetI/eJ+7LoMefJVKovWjqET/RyRV9P/SIJlMDrupPnkek3yPdzZmTsbqTuWvCEEU94
	t1kpXH4NvkI23eKtCczF4LGekYAmbtOQ1+KCGU4FECj143RmiN9KmcCgI+Qa9z6u8KCT
	7w2g==
X-Received: by 10.180.208.7 with SMTP id ma7mr9908946wic.0.1429230693555;
	Thu, 16 Apr 2015 17:31:33 -0700 (PDT)
Received: from localhost (ip-86-49-34-37.net.upcbroadband.cz. [86.49.34.37])
	by mx.google.com with ESMTPSA id go4sm417070wib.1.2015.04.16.17.31.32
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Apr 2015 17:31:32 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Fri, 17 Apr 2015 02:31:50 +0200
To: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
Message-ID: <20150417003150.GC2341@jama>
References: <1428610909-12661-1-git-send-email-alejandro.hernandez@linux.intel.com>
	<1428610909-12661-2-git-send-email-alejandro.hernandez@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <1428610909-12661-2-git-send-email-alejandro.hernandez@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: openembedded-core@openembedded.org, bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] [daisy][dizzy] data.py: fixes bad substitution when running devshell
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
X-List-Received-Date: Fri, 17 Apr 2015 00:31:34 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2015 at 03:21:49PM -0500, Alejandro Hernandez wrote:
> From: Richard Tollerton <rich.tollerton@ni.com>
>=20
> Running bitbake inside make results in the exported environment variable
> MAKEOVERRIDES=3D"${-*-command-variables-*-}", which the shell chokes on
> when trying to expand it. But of course, it probably shouldn't have been
> trying to expand it in the first place -- so just escape the dollar
> sign.
>=20
> (Bitbake rev: 18cd0ce6a55c9065c3f1bf223b47d817b5efcd8f)

This was already cherry-picked to 1.24 where it IIRC breaks powertop
build with current oe-core/dizzy.

Please backport:

commit a3e9b391e1024d6d2e256b75c214d34e6693e332
Author: Martin Jansa <martin.jansa@gmail.com>
Date:   Thu Dec 18 15:54:14 2014 +0100

    powertop: Fix build for !uclibc
   =20
    * EXTRA_LDFLAGS isn't defined for !uclibc and configure fails
      when it reads it unexpanded, see config.log snippet:

to unblock Dizzy builds and backport the same to Dylan before merging
this to 2.22.

>=20
> Signed-off-by: Richard Tollerton <rich.tollerton@ni.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> Signed-off-by: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
>=20
> ---
>  bitbake/lib/bb/data.py | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
> index eb628c7..82eefef 100644
> --- a/bitbake/lib/bb/data.py
> +++ b/bitbake/lib/bb/data.py
> @@ -238,6 +238,7 @@ def emit_var(var, o=3Dsys.__stdout__, d =3D init(), a=
ll=3DFalse):
>      # to a shell, we need to escape the quotes in the var
>      alter =3D re.sub('"', '\\"', val)
>      alter =3D re.sub('\n', ' \\\n', alter)
> +    alter =3D re.sub('\\$', '\\\\$', alter)
>      o.write('%s=3D"%s"\n' % (varExpanded, alter))
>      return 0
> =20
> --=20
> 1.9.1
>=20
> --=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

