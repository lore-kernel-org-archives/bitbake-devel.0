Received: from mail-yi0-f47.google.com ([209.85.218.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <koen@dominion.thruhere.net>)
	id 1R9g6i-0005xp-GH; Fri, 30 Sep 2011 18:38:41 +0200
Received: by yia27 with SMTP id 27so1647468yia.6
	for <multiple recipients>; Fri, 30 Sep 2011 09:33:10 -0700 (PDT)
Received: by 10.236.176.105 with SMTP id a69mr8754987yhm.95.1317400390575;
	Fri, 30 Sep 2011 09:33:10 -0700 (PDT)
Received: from [10.0.1.28] (adsl-68-88-70-1.dsl.rcsntx.swbell.net.
	[68.88.70.1])
	by mx.google.com with ESMTPS id p46sm6982200yhh.15.2011.09.30.09.33.04
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 30 Sep 2011 09:33:09 -0700 (PDT)
References: <4E85D3E0.7070807@intel.com> <1317397804.11645.7.camel@scimitar>
In-Reply-To: <1317397804.11645.7.camel@scimitar>
Mime-Version: 1.0 (iPhone Mail 8L1)
Message-Id: <689D3FDE-CD3B-48CE-9426-AE59008C0609@dominion.thruhere.net>
X-Mailer: iPhone Mail (8L1)
From: Koen Kooi <koen@dominion.thruhere.net>
Date: Fri, 30 Sep 2011 11:32:50 -0500
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
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
X-List-Received-Date: Fri, 30 Sep 2011 16:38:41 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



Op 30 sep. 2011 om 10:49 heeft Joshua Lock <josh@linux.intel.com> het volgen=
de geschreven:

> On Fri, 2011-09-30 at 08:36 -0600, Yu, Ke wrote:
>> Hi,
>>=20
>> As you may already know, a new GUI has been added to bitbake recently,=20=

>> i.e. HOB (Human Oriented Builder).=20
>=20
> It's not an acronym, it's just a name - Hob.
>=20
>> It is a graphical image creator that=20
>> allows user to freely choose which packages to be built in the image.=20
>> The wiki https://wiki.yoctoproject.org/wiki/BitBake/GUI/Hob  has more=20
>> detail.
>=20
> I'll be changing this page and adding more user-centric info in the
> coming weeks.
>=20
>> This email is to collect your feedback on the HOB. Current HOB is our=20
>> first version, and it surely has many place to improve. We has the plan=20=

>> to enhance it in Yocto 1.2. So we really hope that you can use it and=20
>> provide your valuable feedback . We do think user's feedback/requirement=20=

>> is the right way to go. Looking forward your valuable input.
>>=20
>> Best Regards
>> Ke
>>=20
>> Ps. The simple way to run hob is:
>> # touch conf/hob-pre.conf conf/hob-post.conf
>> # bitbake -u hob -r conf/hob-pre.conf -R conf/hob-post.conf
>=20
> In oe-core (and therefore Poky) we have a wrapper script so from an
> oe-init-build-env'd build directory you can just call hob.
>=20
> The script will create the required configuration files with some
> required values.

Can we have it use local.conf by default please? I hate having to put the sa=
me info in multiple places


>=20
> Regards,
> Joshua
> --=20
> Joshua Lock
>        Yocto Project "Johannes factotum"
>        Intel Open Source Technology Centre
>=20
>=20
> _______________________________________________
> Openembedded-core mailing list
> Openembedded-core@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/openembedded-core


