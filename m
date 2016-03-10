Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id 94F476E268
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Mar 2016 17:00:54 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id l68so37112169wml.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Mar 2016 09:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=t/Ca4TMCUmKvxAfMk665qzTQEvPNTjZybNOSXh0Q+xE=;
	b=RH0RYL2It51MH60etg6BLU9cS6EuUa5l1wBcSL3+6357uetpW7oIe49IgBdB7dlVuM
	N5jaM9+kY/ZjMbFqDcHtyDTRfV0VS+oqVBOwMXV+6wrhhngOQQUzT7UYtQIZmqJU2cfF
	9cfmOyb/+f3yqsy08PyOR5oyXzWxYi8ABr3CVCZHt+5WkydWYmq2manKkz8fXyJs9Oh/
	NfMf0STk67ryL2ZMpm7//qjqNE4j9d/HxVzKJsgQsM7PmXCTkIdFVMZ4EqMDpYdVuIOH
	YwJXDWiuo+Oy0ZWog5VVuXvNRC2uWwFAMWly8PP16HAm7K7TY79TasbP1MA9DMUt8dor
	t+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:date:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=t/Ca4TMCUmKvxAfMk665qzTQEvPNTjZybNOSXh0Q+xE=;
	b=dhAXexUArDIkxQY+cCZtpxr3iF9MM5M/mSytv3TOv/CuvlWlsmyPcX5ZpYzAI2kPY0
	fqAmwf6wH1tVCIRRFjBls/zpdp9xfmg3BW78U1vX42uiad16WRw0gBxRvspL7ocm7kkJ
	8U8WarEsPbgIl6afQU31mfzMlxcQhcHodx3mjtTtdbdyJG35DUE5sv/e02daLcM8NrKU
	uwZFc+Rm90rwvYr541BShBnyzbh4s/ZDDvFBWk+/ertMZXBMnpCyQIh5xvtFrKa+l69q
	8BuTmXVl9buVYx8bJmOMkxrED6qW5ebIgO4qk486ywfsFvt2g1H2VlrO+doaoM1Fbrld
	gmyQ==
X-Gm-Message-State: AD7BkJIiUifQKKc7tdNQJnq26a1SSjQ3DvT9Flt3Biu2E041GbUixgxjLpdWYR/cRZexaA==
X-Received: by 10.194.58.12 with SMTP id m12mr5483291wjq.22.1457629253261;
	Thu, 10 Mar 2016 09:00:53 -0800 (PST)
Received: from localhost (ip-86-49-34-37.net.upcbroadband.cz. [86.49.34.37])
	by smtp.gmail.com with ESMTPSA id
	ll9sm4386781wjc.29.2016.03.10.09.00.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 10 Mar 2016 09:00:52 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Thu, 10 Mar 2016 18:03:50 +0100
To: Andre McCurdy <armccurdy@gmail.com>
Message-ID: <20160310170350.GL2573@jama>
References: <1457626532-11121-1-git-send-email-armccurdy@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1457626532-11121-1-git-send-email-armccurdy@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: include PV in 'Unable to get checksum for SRC_URI entry' warnings
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
X-List-Received-Date: Thu, 10 Mar 2016 17:00:57 -0000
X-Groupsio-MsgNum: 7179
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pz0BBB9QxoYXlT+x"
Content-Disposition: inline

--Pz0BBB9QxoYXlT+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 10, 2016 at 08:15:32AM -0800, Andre McCurdy wrote:
> Referencing PN only is ambiguous if multiple versions of a recipe are
> present.

Would it work with FILE to get immediate pointer to file where to update
them?

>=20
> Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
> ---
>  lib/bb/fetch2/__init__.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index f86014c..124420d 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1102,9 +1102,9 @@ def get_checksum_file_list(d):
>                  if f.startswith(dl_dir):
>                      # The local fetcher's behaviour is to return a path =
under DL_DIR if it couldn't find the file anywhere else
>                      if os.path.exists(f):
> -                        bb.warn("Getting checksum for %s SRC_URI entry %=
s: file not found except in DL_DIR" % (d.getVar('PN', True), os.path.basena=
me(f)))
> +                        bb.warn("Getting checksum for %s SRC_URI entry %=
s: file not found except in DL_DIR" % (d.getVar('P', True), os.path.basenam=
e(f)))
>                      else:
> -                        bb.warn("Unable to get checksum for %s SRC_URI e=
ntry %s: file could not be found" % (d.getVar('PN', True), os.path.basename=
(f)))
> +                        bb.warn("Unable to get checksum for %s SRC_URI e=
ntry %s: file could not be found" % (d.getVar('P', True), os.path.basename(=
f)))
>                  filelist.append(f + ":" + str(os.path.exists(f)))
> =20
>      return " ".join(filelist)
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

--Pz0BBB9QxoYXlT+x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlbhqPYACgkQN1Ujt2V2gBwdxQCgla3BAGeEQJ7huBRuLDLM6gu+
NgAAnRcCYS2bcOhIe5eN5b0sE/kFoh0q
=aJQ7
-----END PGP SIGNATURE-----

--Pz0BBB9QxoYXlT+x--
