Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SGpDd-0004pW-91
	for bitbake-devel@lists.openembedded.org;
	Sun, 08 Apr 2012 12:19:37 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 08 Apr 2012 03:10:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="128387944"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 08 Apr 2012 03:10:21 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Sun, 8 Apr 2012 03:10:20 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.125]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Sun, 8 Apr 2012 18:10:18 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "Barros Pena, Belen" <belen.barros.pena@intel.com>, "Xu, Dongxiao"
	<dongxiao.xu@intel.com>
Thread-Topic: [bitbake-devel] [PATCH 09/10] Hob: Change base image to
	"Create your own image" if customized
Thread-Index: AQHNE6gTXDz1Knp5J0ma925HayQAwJaM71yAgAPILdA=
Date: Sun, 8 Apr 2012 10:10:18 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23B173AF@SHSMSX102.ccr.corp.intel.com>
References: <1333683924.12347.4.camel@dongxiao-osel>
	<CBA4642A.C9D8%belen.barros.pena@intel.com>
In-Reply-To: <CBA4642A.C9D8%belen.barros.pena@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 09/10] Hob: Change base image to "Create your own image" if customized
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
X-List-Received-Date: Sun, 08 Apr 2012 10:19:37 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dongxiao suggested another solution. If any recipe is removed from or added=
 into the list.
The base image could be changed into e.g. "core-image-minimal *" or "core-i=
mage-minimal-changed" to indicates the set is based on core-image-minimal.
Technically, what we want is to change the base image name, we can't reuse =
"core-image-minimal".

--
Shane

Barros Pena, Belen wrote on=A02012-04-06:

>=20
> On 06/04/2012 04:45, "Xu, Dongxiao" <dongxiao.xu@intel.com> wrote:
>=20
>> On Wed, 2012-04-04 at 23:21 +0800, Barros Pena, Belen wrote:
>>> Thanks for explaining, Shane. I now understand why you are doing it, bu=
t
>>> people using Hob will not have the benefit of your explanation. They
>>> will
>>> just see they selected a base image, made a small change to that base
>>> image and when they go back to the Image configuration screen, Hob has
>>> changed the base image they selected of its own accord.
>>=20
>> Though the base image is changed to "Create your own image", however all
>> the contents in the base image (except those customized) are still
>> there. If user changes recipes/packages, actually they are trying to
>> create their own image not a base image.
>=20
> I don't think so, Dongxiao: for BitBake, the user is trying to create
> their own image. For me (Hob user) I am trying to create
> core-image-minimal without recipe x.
>=20
> But I see we are going to get into one of those circular arguments. We
> need evidence that this is a problem. Until I can provide you with that, =
I
> accept the easiest way to handle this is changing the user selection to
> "Create your own image" when customisation happens.
>=20
> What a hard life ;)
>=20
>>=20
>>>=20
>>> Could the template have some "hidden" information indicating if a base
>>> image has been customised and therefore the default contents of the bas=
e
>>> image should be ignored and replaced with the remembered recipes and
>>> packages? This way the template would still work, but Hob users will
>>> still
>>> see their selected base image.
>>=20
>> Base image is also a recipe, so we could not ignore its related recipes,
>> unless we switch to a new one whose dependency recipes/packages are
>> None. Otherwise, it will change the core base of the Hob logic.
>>=20
>> Thanks,
>> Dongxiao
>>=20
>>>=20
>>> Belen
>>>=20
>>> On 04/04/2012 13:58, "Wang, Shane" <shane.wang@intel.com> wrote:
>>>=20
>>>> Barros Pena, Belen wrote on 2012-04-03:
>>>>=20
>>>>> From the design side of things, I am not sure this is a good idea.
>>>>> I've explicitly selected 'base image x'. If I then customise it, I
>>>>> still think I am working on 'base image x'. I might not understand
>>>>> why my selection of base image has been changed automatically. In
>>>>> general, it is not a good idea to have software that changes things
>>>>> I do of its own accord. Such behaviours undermine the sense of
>>>>> control users should have when interacting with software.
>>>>>=20
>>>>> Cheers
>>>>>=20
>>>>> Belen
>>>>>=20
>>>>=20
>>>> What we want is to change the item in the base image combo. The
>>>> target image is still based on the base image the user selected plus
>>>> delta. We have the strict definition for the predefined base images.
>>>> For instance, sato includes 300 recipes. An image including 299
>>>> recipes is not called sato but your own image (say, sato-minus)
>>>>=20
>>>> The reason why we do that is because for templates, we will remember
>>>> the item in the image combo as the base image in some bb file, and we
>>>> also remember what we selected for the recipes and the packages.
>>>> However, the base image covers all of them by default and because of
>>>> that, bitbake can't recognize the delta and will include all (300
>>>> recipes), which causes the wrong behavior.
>>>>=20
>>>> --
>>>> Shane
>>>=20
>>=20
>>




