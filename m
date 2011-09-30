Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <koen@dominion.thruhere.net>)
	id 1R9i8Z-00019J-G1; Fri, 30 Sep 2011 20:48:43 +0200
Received: by gyg8 with SMTP id 8so1762282gyg.6
	for <multiple recipients>; Fri, 30 Sep 2011 11:43:13 -0700 (PDT)
Received: by 10.236.178.10 with SMTP id e10mr30881578yhm.31.1317408193032;
	Fri, 30 Sep 2011 11:43:13 -0700 (PDT)
Received: from [10.0.1.28] (adsl-68-88-70-1.dsl.rcsntx.swbell.net.
	[68.88.70.1])
	by mx.google.com with ESMTPS id s77sm7389628yhe.22.2011.09.30.11.43.11
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 30 Sep 2011 11:43:12 -0700 (PDT)
References: <4E85D3E0.7070807@intel.com> <1317397804.11645.7.camel@scimitar>
	<689D3FDE-CD3B-48CE-9426-AE59008C0609@dominion.thruhere.net>
	<1317402997.11645.13.camel@scimitar>
In-Reply-To: <1317402997.11645.13.camel@scimitar>
Mime-Version: 1.0 (iPhone Mail 8L1)
Message-Id: <609923D1-5534-4A1F-A454-4EC76E97D2D7@dominion.thruhere.net>
X-Mailer: iPhone Mail (8L1)
From: Koen Kooi <koen@dominion.thruhere.net>
Date: Fri, 30 Sep 2011 13:43:06 -0500
To: Joshua Lock <josh@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] Feedback on HOB (new image creator GUI)
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 30 Sep 2011 18:48:43 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



Op 30 sep. 2011 om 12:16 heeft Joshua Lock <josh@linux.intel.com> het volgen=
de geschreven:

> On Fri, 2011-09-30 at 11:32 -0500, Koen Kooi wrote:
>>=20
>> Op 30 sep. 2011 om 10:49 heeft Joshua Lock <josh@linux.intel.com> het vol=
gende geschreven:
>>=20
>>> On Fri, 2011-09-30 at 08:36 -0600, Yu, Ke wrote:
>>>> Hi,
>>>>=20
>>>> As you may already know, a new GUI has been added to bitbake recently,=20=

>>>> i.e. HOB (Human Oriented Builder).=20
>>>=20
>>> It's not an acronym, it's just a name - Hob.
>>>=20
>>>> It is a graphical image creator that=20
>>>> allows user to freely choose which packages to be built in the image.=20=

>>>> The wiki https://wiki.yoctoproject.org/wiki/BitBake/GUI/Hob  has more=20=

>>>> detail.
>>>=20
>>> I'll be changing this page and adding more user-centric info in the
>>> coming weeks.
>>>=20
>>>> This email is to collect your feedback on the HOB. Current HOB is our=20=

>>>> first version, and it surely has many place to improve. We has the plan=
=20
>>>> to enhance it in Yocto 1.2. So we really hope that you can use it and=20=

>>>> provide your valuable feedback . We do think user's feedback/requiremen=
t=20
>>>> is the right way to go. Looking forward your valuable input.
>>>>=20
>>>> Best Regards
>>>> Ke
>>>>=20
>>>> Ps. The simple way to run hob is:
>>>> # touch conf/hob-pre.conf conf/hob-post.conf
>>>> # bitbake -u hob -r conf/hob-pre.conf -R conf/hob-post.conf
>>>=20
>>> In oe-core (and therefore Poky) we have a wrapper script so from an
>>> oe-init-build-env'd build directory you can just call hob.
>>>=20
>>> The script will create the required configuration files with some
>>> required values.
>>=20
>> Can we have it use local.conf by default please? I hate having to put the=
 same info in multiple places
>=20
> We do use local.conf in that if values are set there and not in either
> of the hob configuration files the values from local.conf are used
> however I had an explicit feature request to not modify local.conf.
>=20

In the past it would ignore DISTRO, leading to much headscratching


> I actually started looking at having Hob use an independent
> configuration file so that Hob settings would persist across build
> directories, this didn't make it in the 1.1 time frame unfortunately.
>=20
> Cheers,
> Joshua
> --=20
> Joshua Lock
>        Yocto Project "Johannes factotum"
>        Intel Open Source Technology Centre
>=20


