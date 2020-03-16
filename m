Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by mail.openembedded.org (Postfix) with ESMTP id A6AFA6022D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Mar 2020 11:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=axis.com; l=1358; q=dns/txt; s=axis-central1;
	t=1584357568; x=1615893568;
	h=from:to:subject:date:message-id:references:in-reply-to:
	content-transfer-encoding:mime-version;
	bh=lz/aoPMlIzwx0IwxbXUXS6J48BS7mNSkeakoVEZeCYk=;
	b=BC3h6tdrD/0jxnk2Uu5d6V+3RER0j6dIBar6k/lo4tXk0WNdRiHgeqFH
	VurcX3V6sDVbd9cPoeB0CsTIBQYbn1vvmeT98ndZAFi3/UA8assww5Szw
	nOvW4G5E3aXIClvMlzpTBk0FYDHD2gR56FFblbr0VZ9mUlvNoAazXZgU/
	3LnCX/Clo8VL8MWkouXR/9rYLs3fhIp8CKbCDSgGCYtIc3lYlrQt/WJ/s
	fex1fGRnScYFub/9YNDQCcMSlkzSIWoXnoHFWfgKmRhPHbgaPy/i7D/cr
	zJ4FFxazuy6oSuq4Oc0/lpBOQjFDJNlvFr8HVlqxxAL+C8BaAEDJWzRKR A==;
IronPort-SDR: dBbCFuxvJ0Rhoktdf5fzn/BFmPWEIDqVqe/KDCJjR5bW+e6u4hnzPKyj9oN1CEZhdcsQT5YZaj
	ryKrV9EsmJhggzVglyhPrUKt+itPa887+kOM24yaehu98ttouj6Zjet9R6L6EnlxJLP5fVjdRQ
	oOolm5SJj5O2jmULG7k06wcvU+9njqJbaNsGlezBFvZshG62B11rlYoOHOL7x/cAN8YPQa4Hez
	xMK6tYwNzSJuC9HtZktJjKbYwFhYAlIv86yoVLNsaF6VSNo6bt9ljvOh+Job2vHarFZeJPB0Qh
	DPE=
X-IronPort-AV: E=Sophos;i="5.70,560,1574118000"; 
   d="scan'208";a="6356686"
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, akuster808 <akuster808@gmail.com>
Thread-Topic: [bitbake-devel] [master][zeus][PATCH 1/3] knotty: Make the
	bb.command.CommandExit event terminate bitbake
Thread-Index: AQHV47A/cg+ihBxqQkipOaQajf1IJKhLQUfQ
Date: Mon, 16 Mar 2020 11:19:26 +0000
Message-ID: <6b3a542faa054325940f888386e2495e@XBOX03.axis.com>
References: <20200215032955.3958-1-pkj@axis.com>
In-Reply-To: <20200215032955.3958-1-pkj@axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Subject: Re: [master][zeus][PATCH 1/3] knotty: Make the	bb.command.CommandExit event terminate bitbake
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
X-List-Received-Date: Mon, 16 Mar 2020 11:19:27 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> bounces@lists.openembedded.org> On Behalf Of Peter Kjellerstedt
> Sent: den 15 februari 2020 04:30
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [master][zeus][PATCH 1/3] knotty: Make the
> bb.command.CommandExit event terminate bitbake
>=20
> This matches the other bb.command.Command* events and without it,
> running `bitbake --revisions-changed` will hang indefinitely if there
> are changed revisions.
>=20
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  bitbake/lib/bb/ui/knotty.py | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
> index a0340dfc20..cbb289b05f 100644
> --- a/bitbake/lib/bb/ui/knotty.py
> +++ b/bitbake/lib/bb/ui/knotty.py
> @@ -590,6 +590,7 @@ def main(server, eventHandler, params, tf =3D Termina=
lFilter):
>              if isinstance(event, bb.command.CommandExit):
>                  if not return_value:
>                      return_value =3D event.exitcode
> +                main.shutdown =3D 2
>                  continue
>              if isinstance(event, (bb.command.CommandCompleted, bb.cooker=
.CookerExit)):
>                  main.shutdown =3D 2
> --
> 2.21.1

Please backport the three patches in this set to Zeus now that they have=20
been integrated to master.

//Peter


