Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
 by mx.groups.io with SMTP id smtpd.web11.2688.1630532814511472690
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Sep 2021 14:46:54 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=permerror, err=syntax error for token:  (domain: kernel.crashing.org, ip: 76.164.61.194, mailfrom: mark.hatle@kernel.crashing.org)
Received: from Marks-MacBook-Pro-16.local ([76.164.61.198])
	(authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 181LkllN018775
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Wed, 1 Sep 2021 16:46:48 -0500
Subject: Re: [bitbake-devel] [PATCH 0/1] RFC Bug in PREMIRROR
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        Vishal Patel <vishal.patel@xilinx.com>,
        bitbake-devel@lists.openembedded.org
Cc: mark.hatle@xilinx.com
References: <20210901194456.2642587-1-vishal.patel@xilinx.com>
 <e648cf6d7d613e0ee1d5ad7b3ff0d8b0d332e6db.camel@linuxfoundation.org>
From: "Mark Hatle" <mark.hatle@kernel.crashing.org>
Message-ID: <b510348a-a95f-fab8-d756-e2bb15b57bf4@kernel.crashing.org>
Date: Wed, 1 Sep 2021 16:46:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e648cf6d7d613e0ee1d5ad7b3ff0d8b0d332e6db.camel@linuxfoundation.org>
X-MIME-Autoconverted: from 8bit to quoted-printable by kernel.crashing.org id 181LkllN018775
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 9/1/21 4:40 PM, Richard Purdie wrote:
> On Wed, 2021-09-01 at 12:44 -0700, Vishal Patel wrote:
>> I think we found a bug in the PREMIRROR system where if both a remote an=
d local
>> PREMIRROR is defined, as well as BB_NO_NETWORK =3D '1', the system will =
fail with
>>
>> bb.fetch2.NetworkAccess: Network access disabled through BB_NO_NETWORK (=
or set indirectly due to use of BB_FETCH_PREMIRRORONLY)
>>
>> instead of trying the next PREMIRROR which is a local file:// based one.
>> The attached patch only adds a test case for the issue, but does not fix=
 the problem.
>> If anyone can point me to where to fix the problem, I can work on this.
>=20
> Thanks for the testcase, that does at least make this easy to see.
>=20
> Running the test, it is clear from the trace that after trying a mirror, =
the
> bb.fetch2.NetworkAccess exception is fatal and stops any other url from b=
eing
> tried. That does seem not to be what the user would want.
>=20
> I was going to let you debug that but I did quickly try this:
>=20
>=20
> diff --git a/bitbake/lib/bb/fetch2/__init__.py
> b/bitbake/lib/bb/fetch2/__init__.py
> index 914fa5c0243..65d8c38af76 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -1034,7 +1034,7 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D=
 False):
>          return ud.localpath
> =20
>      except bb.fetch2.NetworkAccess:
> -        raise
> +        return False
> =20
>      except IOError as e:
>          if e.errno in [errno.ESTALE]:
>=20
> and found that does make your test case pass.=C2=A0It also doesn't regres=
s any other
> test that I spotted in quick testing.
>=20
> I'm not sure if that is the correct fix, I'd need to think about it a bit=
 more.=C2=A0
>=20
> The question is whether if you disable the networking, you want errors on
> network access or want the accesses disabled. Some people do want to know=
 if the
> network is used when disabled and BB_NO_NETWORK may mean different things=
 to
> different people.

I thought in the past it just skipped them but stored a message or somethin=
g
about the networkaccess.. then if it couldn't find anything it THEN display=
ed
the message.

roughly:

try... ohh network?  capture exception
try next...
try next...
nothing found, print exception message (and since it's PREMIRROR don't fail=
,
continue to regular download and then MIRROR)

--Mark

> Cheers,
>=20
> Richard
>=20
>=20
>=20
>=20
>=20
