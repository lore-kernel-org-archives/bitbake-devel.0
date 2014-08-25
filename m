Return-Path: <peter.kjellerstedt@axis.com>
X-Greylist: delayed 312 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 25 Aug 2014 15:12:16 UTC
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id B3A5C6ACBA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Aug 2014 15:12:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 56B9A180D4;
	Mon, 25 Aug 2014 17:07:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id cJWSO+QB5dIg; Mon, 25 Aug 2014 17:06:57 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id DA6E6180B8;
	Mon, 25 Aug 2014 17:06:56 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 6EA911463;
	Mon, 25 Aug 2014 17:04:35 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 24844146D;
	Mon, 25 Aug 2014 17:04:35 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id E0FAF134822;
	Mon, 25 Aug 2014 17:04:32 +0200 (CEST)
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail2.se.axis.com
	([10.0.5.74]) with mapi; Mon, 25 Aug 2014 17:04:32 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Mon, 25 Aug 2014 17:02:16 +0200
Thread-Topic: [bitbake-devel] [PATCH] siggen: Fix a subtle bug in hash
	calculation for shared work tasks
Thread-Index: Ac++q34WzSJ9TapYThuJaKd6exuCigBjIG7w
Message-ID: <A612847CFE53224C91B23E3A5B48BAC7ACE9DAC1F6@xmail3.se.axis.com>
References: <1408782155.5457.1.camel@ted>
In-Reply-To: <1408782155.5457.1.camel@ted>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
MIME-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] siggen: Fix a subtle bug in hash calculation for shared work tasks
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
X-List-Received-Date: Mon, 25 Aug 2014 15:12:20 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Richard Purdie
> Sent: den 23 augusti 2014 10:23
> To: bitbake-devel
> Subject: [bitbake-devel] [PATCH] siggen: Fix a subtle bug in hash
> calculation for shared work tasks
>=20
>=20
> With a shared work task like gcc, the task can be run from a variety of
> different recipes which may have different virtual extensions in place.
>=20
> Depending on whether gcc-runtime or nativesdk-gcc-runtime's
> do_preconfigure
> task is called for example will change the sorting of the task hashes
> due
> to the way clean_basename currently works.
>=20
> The correct thing to do here is sort on the base filename first, then
> any
> extension when ordering the hashes. This means we do account for things
> like recipes with both a native and non-native dependency but we also
> fix
> the shared work case where we don't care whether it was a virtual
> version
> or not.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>=20
> diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
> index 933311c..548f50d 100644
> --- a/bitbake/lib/bb/siggen.py
> +++ b/bitbake/lib/bb/siggen.py
> @@ -295,7 +295,7 @@ def dump_this_task(outfile, d):
>=20
>  def clean_basepath(a):
>      if a.startswith("virtual:"):
> -        b =3D a.rsplit(":", 1)[0] + ":" + a.rsplit("/", 1)[1]
> +        b =3D a.rsplit("/", 1)[1] + ":" + a.rsplit(":", 1)[0]
>      else:
>          b =3D a.rsplit("/", 1)[1]
>      return b

After the rewrite above, this can be simplified as:

def clean_basepath(a):
    b =3D a.rsplit("/", 1)[1]
    if a.startswith("virtual:"):
        b +=3D ":" + a.rsplit(":", 1)[0]
    return b

//Peter


