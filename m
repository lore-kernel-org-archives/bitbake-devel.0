Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id DD5B76C1D5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Oct 2019 13:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D0FBA9C0349;
	Wed, 23 Oct 2019 09:07:15 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id Su3IbIDhCVIL; Wed, 23 Oct 2019 09:07:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D142B9C0368;
	Wed, 23 Oct 2019 09:07:14 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id oiitLFj0ArpW; Wed, 23 Oct 2019 09:07:14 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A73949C0349;
	Wed, 23 Oct 2019 09:07:14 -0400 (EDT)
Date: Wed, 23 Oct 2019 09:07:14 -0400 (EDT)
From: Jean-marie Lemetayer <jean-marie.lemetayer@savoirfairelinux.com>
To: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <573850250.248944.1571836034627.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <4409c36d-23b9-4ddb-d681-5328f75330dc@kernel.crashing.org>
References: <20191022090408.1368-1-jean-marie.lemetayer@savoirfairelinux.com>
	<20191022090408.1368-3-jean-marie.lemetayer@savoirfairelinux.com>
	<4409c36d-23b9-4ddb-d681-5328f75330dc@kernel.crashing.org>
MIME-Version: 1.0
X-Mailer: Zimbra 8.8.11_GA_3737 (ZimbraWebClient - GC77 (Linux)/8.8.11_GA_3737)
Thread-Topic: fetch2/npm.py: refactor the npm fetcher
Thread-Index: OaOQRPvomuOV/1In4aSGDC6NXfz2oQ==
Cc: paul eggleton <paul.eggleton@linux.intel.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Savoir-faire Linux Rennes <rennes@savoirfairelinux.com>
Subject: Re: [RFC][PATCH 2/2] fetch2/npm.py: refactor the npm fetcher
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
X-List-Received-Date: Wed, 23 Oct 2019 13:07:15 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Oct 22, 2019, at 7:10 PM, Mark Hatle mark.hatle@kernel.crashing.org wrot=
e:
> On 10/22/19 4:04 AM, Jean-Marie LEMETAYER wrote:
>> This commit refactors the npm fetcher to improve some points and fix
>> others:
>>=20
>> =C2=A0- The big change is that the fetcher is only fetching the package
>> =C2=A0 =C2=A0source and no more the dependencies. Thus the npm fetcher a=
ct as the
>> =C2=A0 =C2=A0other fetchers e.g git, wget. The dependencies will now be =
fetched
>> =C2=A0 =C2=A0by the npm class.
>=20
> I don't completely understand this and the associated class, but does it =
work
> with the existing MIRROR and BB_NO_NETWORK/BB_ALLOWED_NETWORKS settings?
>=20
> My concern is for people in environments that are not allowed to download=
 except
> from trusted machines, or on disconnected networks so they have everythin=
g on a
> local mirror of some sort.
>=20
> Additionally with the mirroring, it's not unusual for the name of what is
> downloaded (as well as where it's downloaded from) to change protocol and
> format. =C2=A0I.e. I'd hope something like:
>=20
> .*:.*/.* file://my_local/on/disk/mirror

Thank you for pointing this out. As I was inspired by the wget fetcher, I
think this should be good but i still need to check.

However the npm.bbclass fetches the npm dependencies (currently in the
do_compile task) and this settings are not respected. I am working on a v2
to fix this point.

> I'm also not seeing any test cases for this fetcher. =C2=A0Since this wor=
k isn't well
> understood by most of the regular maintainers, I think it's extremely imp=
ortant
> that test cases are added during any new changes to ensure that the fetch=
er is
> working properly.

Thank you again. The former npm support does not have any tests so I did no=
t
think about it. I will add some basic tests in the v2.

Regards,
Jean-Marie

