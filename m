Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <belen.barros.pena@intel.com>) id 1SG4ak-0007Om-EM
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Apr 2012 10:32:22 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 06 Apr 2012 01:23:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="127817165"
Received: from irsmsx101.ger.corp.intel.com ([163.33.3.153])
	by azsmga001.ch.intel.com with ESMTP; 06 Apr 2012 01:23:07 -0700
Received: from irsmsx102.ger.corp.intel.com (163.33.3.155) by
	IRSMSX101.ger.corp.intel.com (163.33.3.153) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Fri, 6 Apr 2012 09:22:24 +0100
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.40]) by
	IRSMSX102.ger.corp.intel.com ([169.254.2.39]) with mapi id
	14.01.0355.002; Fri, 6 Apr 2012 09:22:23 +0100
From: "Barros Pena, Belen" <belen.barros.pena@intel.com>
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
Thread-Topic: [bitbake-devel] [PATCH 09/10] Hob: Change base image to
	"Create your own image" if customized
Thread-Index: AQHNE85k0v/uNpj2gUaLC8+pShV19A==
Date: Fri, 6 Apr 2012 08:22:23 +0000
Message-ID: <CBA4642A.C9D8%belen.barros.pena@intel.com>
In-Reply-To: <1333683924.12347.4.camel@dongxiao-osel>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.14.0.111121
x-originating-ip: [10.254.195.108]
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
X-List-Received-Date: Fri, 06 Apr 2012 08:32:22 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0DDE4EE828C143479F4D09D4F1FC15B8@intel.com>
Content-Transfer-Encoding: quoted-printable


On 06/04/2012 04:45, "Xu, Dongxiao" <dongxiao.xu@intel.com> wrote:

>On Wed, 2012-04-04 at 23:21 +0800, Barros Pena, Belen wrote:
>> Thanks for explaining, Shane. I now understand why you are doing it, but
>> people using Hob will not have the benefit of your explanation. They
>>will
>> just see they selected a base image, made a small change to that base
>> image and when they go back to the Image configuration screen, Hob has
>> changed the base image they selected of its own accord.
>
>Though the base image is changed to "Create your own image", however all
>the contents in the base image (except those customized) are still
>there. If user changes recipes/packages, actually they are trying to
>create their own image not a base image.

I don't think so, Dongxiao: for BitBake, the user is trying to create
their own image. For me (Hob user) I am trying to create
core-image-minimal without recipe x.

But I see we are going to get into one of those circular arguments. We
need evidence that this is a problem. Until I can provide you with that, I
accept the easiest way to handle this is changing the user selection to
"Create your own image" when customisation happens.

What a hard life ;)

>
>>=20
>> Could the template have some "hidden" information indicating if a base
>> image has been customised and therefore the default contents of the base
>> image should be ignored and replaced with the remembered recipes and
>> packages? This way the template would still work, but Hob users will
>>still
>> see their selected base image.
>
>Base image is also a recipe, so we could not ignore its related recipes,
>unless we switch to a new one whose dependency recipes/packages are
>None. Otherwise, it will change the core base of the Hob logic.
>
>Thanks,
>Dongxiao
>
>>=20
>> Belen
>>=20
>> On 04/04/2012 13:58, "Wang, Shane" <shane.wang@intel.com> wrote:
>>=20
>> >Barros Pena, Belen wrote on 2012-04-03:
>> >
>> >> From the design side of things, I am not sure this is a good idea.
>>I've
>> >> explicitly selected 'base image x'. If I then customise it, I still
>> >>think
>> >> I am working on 'base image x'. I might not understand why my
>>selection
>> >>of
>> >> base image has been changed automatically. In general, it is not a
>>good
>> >> idea to have software that changes things I do of its own accord.
>>Such
>> >> behaviours undermine the sense of control users should have when
>> >> interacting with software.
>> >>=20
>> >> Cheers
>> >>=20
>> >> Belen
>> >>=20
>> >
>> >What we want is to change the item in the base image combo. The target
>> >image is still based on the base image the user selected plus delta.
>> >We have the strict definition for the predefined base images. For
>> >instance, sato includes 300 recipes.
>> >An image including 299 recipes is not called sato but your own image
>> >(say, sato-minus)
>> >
>> >The reason why we do that is because for templates, we will remember
>>the
>> >item in the image combo as the base image in some bb file, and we also
>> >remember what we selected for the recipes and the packages. However,
>>the
>> >base image covers all of them by default and because of that, bitbake
>> >can't recognize the delta and will include all (300 recipes), which
>> >causes the wrong behavior.
>> >
>> >--
>> >Shane
>>=20
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



