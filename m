Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <belen.barros.pena@intel.com>) id 1SFSC7-0001sq-Tq
	for bitbake-devel@lists.openembedded.org;
	Wed, 04 Apr 2012 17:32:24 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 04 Apr 2012 08:22:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="85243448"
Received: from irsmsx101.ger.corp.intel.com ([163.33.3.153])
	by AZSMGA002.ch.intel.com with ESMTP; 04 Apr 2012 08:22:07 -0700
Received: from irsmsx152.ger.corp.intel.com (163.33.192.66) by
	IRSMSX101.ger.corp.intel.com (163.33.3.153) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Wed, 4 Apr 2012 16:21:31 +0100
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.40]) by
	IRSMSX152.ger.corp.intel.com ([169.254.6.86]) with mapi id
	14.01.0355.002; Wed, 4 Apr 2012 16:21:31 +0100
From: "Barros Pena, Belen" <belen.barros.pena@intel.com>
To: "Wang, Shane" <shane.wang@intel.com>, "Xu, Dongxiao"
	<dongxiao.xu@intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 09/10] Hob: Change base image to
	"Create your own image" if customized
Thread-Index: AQHNEnacmKMJbUIV+UStD7ne6k83yw==
Date: Wed, 4 Apr 2012 15:21:30 +0000
Message-ID: <CBA223C9.C4FB%belen.barros.pena@intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23B12025@SHSMSX102.ccr.corp.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.14.0.111121
x-originating-ip: [10.254.112.116]
MIME-Version: 1.0
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
X-List-Received-Date: Wed, 04 Apr 2012 15:32:24 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <911A93F32E541840B82F9A1482155ED8@intel.com>
Content-Transfer-Encoding: quoted-printable

Thanks for explaining, Shane. I now understand why you are doing it, but
people using Hob will not have the benefit of your explanation. They will
just see they selected a base image, made a small change to that base
image and when they go back to the Image configuration screen, Hob has
changed the base image they selected of its own accord.

Could the template have some "hidden" information indicating if a base
image has been customised and therefore the default contents of the base
image should be ignored and replaced with the remembered recipes and
packages? This way the template would still work, but Hob users will still
see their selected base image.

Belen

On 04/04/2012 13:58, "Wang, Shane" <shane.wang@intel.com> wrote:

>Barros Pena, Belen wrote on 2012-04-03:
>
>> From the design side of things, I am not sure this is a good idea. I've
>> explicitly selected 'base image x'. If I then customise it, I still
>>think
>> I am working on 'base image x'. I might not understand why my selection
>>of
>> base image has been changed automatically. In general, it is not a good
>> idea to have software that changes things I do of its own accord. Such
>> behaviours undermine the sense of control users should have when
>> interacting with software.
>>=20
>> Cheers
>>=20
>> Belen
>>=20
>
>What we want is to change the item in the base image combo. The target
>image is still based on the base image the user selected plus delta.
>We have the strict definition for the predefined base images. For
>instance, sato includes 300 recipes.
>An image including 299 recipes is not called sato but your own image
>(say, sato-minus)
>
>The reason why we do that is because for templates, we will remember the
>item in the image combo as the base image in some bb file, and we also
>remember what we selected for the recipes and the packages. However, the
>base image covers all of them by default and because of that, bitbake
>can't recognize the delta and will include all (300 recipes), which
>causes the wrong behavior.
>
>--
>Shane

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.



