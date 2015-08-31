Return-Path: <martin.jansa@gmail.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
	[209.85.212.178])
	by mail.openembedded.org (Postfix) with ESMTP id 29FA876F56
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Aug 2015 20:18:16 +0000 (UTC)
Received: by wibz8 with SMTP id z8so11413611wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Aug 2015 13:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=DPX5jBd9O7J+c3Mvo6RQ/j/1Zjfkw35cy3HGzumEyGA=;
	b=WWyPtYClGYOO727iGKidMwCFjcMS7WeLynYQ9bqOHN1IRN7ZqDizckpc9UdrfiV2aq
	AhucT/aGE3a46X87lhDbw2P+Lr5IUBQ/qsCmXBDL71UQdEmEJKDpP+RBrk7g7rzmiQiK
	XYTA1kulx7CSY5nzqmnzdS7zSgovlPB0ILNiDNQFrMSDFFXSaNrQiV9GE/18Q6hkOzM4
	fWOsV2LyaOW05lI8lumyF+5U/DInpXc5FDyquZHdd2H6ZrMPO8dpc+WfvI+g5/NwAqGf
	DA8ZZfBticViWijFsXvXBSx3KlHpLM+aqXLbBUoYNY/MlhVAjVXN8u4nth0HtMkymDxc
	BIdA==
X-Received: by 10.180.8.68 with SMTP id p4mr338443wia.27.1441052296415;
	Mon, 31 Aug 2015 13:18:16 -0700 (PDT)
Received: from localhost (ip-86-49-34-37.net.upcbroadband.cz. [86.49.34.37])
	by smtp.gmail.com with ESMTPSA id gv1sm355179wib.15.2015.08.31.13.18.15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 31 Aug 2015 13:18:15 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Mon, 31 Aug 2015 22:18:22 +0200
To: Alex Franco <alejandro.franco@linux.intel.com>
Message-ID: <20150831201822.GA823@jama>
References: <1441051232-30028-1-git-send-email-alejandro.franco@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <1441051232-30028-1-git-send-email-alejandro.franco@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: david.nystrom@enea.com, clarson@kergoth.com,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Allow bitbake commands starting with do_ v2
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
X-List-Received-Date: Mon, 31 Aug 2015 20:18:17 -0000
X-Groupsio-MsgNum: 6292
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2015 at 03:00:32PM -0500, Alex Franco wrote:
> The output of "bitbake, -c listtasks pkg" lists tasks with their real nam=
es
> (starting with "do_"), but then "bitbake -c do_task" fails, as "do_" alwa=
ys
> gets unconditionally prepended to task names. This patch handles this err=
or
> by always removing "do_" from the beginning of task names when the runque=
ue
> is being constructed.
>=20
> [YOCTO #7818]

"v2" belongs to [PATCHv2] (set by subject-prefix), you don't want it to be =
part of final commit
message, do you?

>=20
> Signed-off-by: Alex Franco <alejandro.franco@linux.intel.com>
> ---
>  bitbake/lib/bb/runqueue.py | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 0f99e5a..834992f 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -634,6 +634,10 @@ class RunQueueData:
> =20
>              fnid =3D taskData.build_targets[targetid][0]
>              fn =3D taskData.fn_index[fnid]
> +
> +            if target[1].startswith("do_"):
> +                target[1] =3D target[1].replace("do_", "", 1)
> +
>              self.target_pairs.append((fn, target[1]))
> =20
>              if fnid in taskData.failed_fnids:
> --=20
> 2.5.1
>=20
> --=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlXkto0ACgkQN1Ujt2V2gBzQlQCeIduIs207gmWoeqcByYgjvrLc
X80AoLc2DyQtcZObcnrWmgQtF89o7SgQ
=mPDT
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
