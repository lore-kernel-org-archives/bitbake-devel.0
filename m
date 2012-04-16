Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <belen.barros.pena@intel.com>) id 1SJlHX-0004nT-8F
	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Apr 2012 14:43:47 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 16 Apr 2012 05:34:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="154141667"
Received: from irsmsx103.ger.corp.intel.com ([163.33.3.157])
	by fmsmga002.fm.intel.com with ESMTP; 16 Apr 2012 05:34:20 -0700
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.40]) by
	IRSMSX103.ger.corp.intel.com ([169.254.3.162]) with mapi id
	14.01.0355.002; Mon, 16 Apr 2012 13:32:52 +0100
From: "Barros Pena, Belen" <belen.barros.pena@intel.com>
To: "Wang, Shane" <shane.wang@intel.com>, "Xu, Dongxiao"
	<dongxiao.xu@intel.com>
Thread-Topic: [bitbake-devel] [PATCH 09/10] Hob: Change base image to
	"Create your own image" if customized
Thread-Index: AQHNG80JVWdMZMB5zUCgC1Wl2Tkh8w==
Date: Mon, 16 Apr 2012 12:32:51 +0000
Message-ID: <CBB1CF21.D401%belen.barros.pena@intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23B173AF@SHSMSX102.ccr.corp.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.14.0.111121
x-originating-ip: [10.254.195.170]
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
X-List-Received-Date: Mon, 16 Apr 2012 12:43:47 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2CD9DACB177FC24DA29469E533FED99D@intel.com>
Content-Transfer-Encoding: quoted-printable

I see what you are trying to do, but I think this solution also has
problems. Would the Base image combo box have to include a .*-changed item
for every single base image?

If yes, what happens when I select one of those .*-changed options and I
don't customise the image?

If not, wouldn't it be weird to see the base image combo set to an option
that was not initially listed?

Cheers

Belen

On 08/04/2012 11:10, "Wang, Shane" <shane.wang@intel.com> wrote:

>Dongxiao suggested another solution. If any recipe is removed from or
>added into the list.
>The base image could be changed into e.g. "core-image-minimal *" or
>"core-image-minimal-changed" to indicates the set is based on
>core-image-minimal.
>Technically, what we want is to change the base image name, we can't
>reuse "core-image-minimal".
>
>--
>Shane
>
>Barros Pena, Belen wrote on 2012-04-06:
>
>>=20
>> On 06/04/2012 04:45, "Xu, Dongxiao" <dongxiao.xu@intel.com> wrote:
>>=20
>>> On Wed, 2012-04-04 at 23:21 +0800, Barros Pena, Belen wrote:
>>>> Thanks for explaining, Shane. I now understand why you are doing it,
>>>>but
>>>> people using Hob will not have the benefit of your explanation. They
>>>> will
>>>> just see they selected a base image, made a small change to that base
>>>> image and when they go back to the Image configuration screen, Hob has
>>>> changed the base image they selected of its own accord.
>>>=20
>>> Though the base image is changed to "Create your own image", however
>>>all
>>> the contents in the base image (except those customized) are still
>>> there. If user changes recipes/packages, actually they are trying to
>>> create their own image not a base image.
>>=20
>> I don't think so, Dongxiao: for BitBake, the user is trying to create
>> their own image. For me (Hob user) I am trying to create
>> core-image-minimal without recipe x.
>>=20
>> But I see we are going to get into one of those circular arguments. We
>> need evidence that this is a problem. Until I can provide you with
>>that, I
>> accept the easiest way to handle this is changing the user selection to
>> "Create your own image" when customisation happens.
>>=20
>> What a hard life ;)
>>=20
>>>=20
>>>>=20
>>>> Could the template have some "hidden" information indicating if a base
>>>> image has been customised and therefore the default contents of the
>>>>base
>>>> image should be ignored and replaced with the remembered recipes and
>>>> packages? This way the template would still work, but Hob users will
>>>> still
>>>> see their selected base image.
>>>=20
>>> Base image is also a recipe, so we could not ignore its related
>>>recipes,
>>> unless we switch to a new one whose dependency recipes/packages are
>>> None. Otherwise, it will change the core base of the Hob logic.
>>>=20
>>> Thanks,
>>> Dongxiao
>>>=20
>>>>=20
>>>> Belen
>>>>=20
>>>> On 04/04/2012 13:58, "Wang, Shane" <shane.wang@intel.com> wrote:
>>>>=20
>>>>> Barros Pena, Belen wrote on 2012-04-03:
>>>>>=20
>>>>>> From the design side of things, I am not sure this is a good idea.
>>>>>> I've explicitly selected 'base image x'. If I then customise it, I
>>>>>> still think I am working on 'base image x'. I might not understand
>>>>>> why my selection of base image has been changed automatically. In
>>>>>> general, it is not a good idea to have software that changes things
>>>>>> I do of its own accord. Such behaviours undermine the sense of
>>>>>> control users should have when interacting with software.
>>>>>>=20
>>>>>> Cheers
>>>>>>=20
>>>>>> Belen
>>>>>>=20
>>>>>=20
>>>>> What we want is to change the item in the base image combo. The
>>>>> target image is still based on the base image the user selected plus
>>>>> delta. We have the strict definition for the predefined base images.
>>>>> For instance, sato includes 300 recipes. An image including 299
>>>>> recipes is not called sato but your own image (say, sato-minus)
>>>>>=20
>>>>> The reason why we do that is because for templates, we will remember
>>>>> the item in the image combo as the base image in some bb file, and we
>>>>> also remember what we selected for the recipes and the packages.
>>>>> However, the base image covers all of them by default and because of
>>>>> that, bitbake can't recognize the delta and will include all (300
>>>>> recipes), which causes the wrong behavior.
>>>>>=20
>>>>> --
>>>>> Shane
>>>>=20
>>>=20
>>>
>
>

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.



