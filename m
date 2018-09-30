Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 6098E7995D
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 30 Sep 2018 07:41:34 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w8U7eVkE014442
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Sun, 30 Sep 2018 00:40:42 -0700
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.79]) by
	ALA-HCA.corp.ad.wrs.com ([147.11.189.40]) with mapi id 14.03.0415.000;
	Sun, 30 Sep 2018 00:40:21 -0700
From: "Reyna, David" <david.reyna@windriver.com>
To: akuster808 <akuster808@gmail.com>, "Belal, Awais" <Awais_Belal@mentor.com>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>
Thread-Topic: [bitbake-devel] [sumo][PATCH] toaster: localhostbecontroller:
	fix bitbake path resolution
Thread-Index: AQHUS0UdM8G0xVWi7EeQqAsalTR7hKTvXz/wgBaVVC6AAoxKYIAACRVg
Date: Sun, 30 Sep 2018 07:40:20 +0000
Message-ID: <5E53D14CE4667A45B9A06760DE5D13D0F3ADA276@ALA-MBD.corp.ad.wrs.com>
References: <1536831336527.93802@mentor.com>
	<5E53D14CE4667A45B9A06760DE5D13D0F3AC15D6@ALA-MBD.corp.ad.wrs.com>
	<1537430385445.98207@mentor.com> <1538034849901.46023@mentor.com>
	<f3a9349906015f5961c688f27b82fa92967e5510.camel@linuxfoundation.org>
	<1538120253384.1227@mentor.com>
	<573089240e7086a6091c1123454a842cec4cff78.camel@linuxfoundation.org>
	<1538131095353.74870@mentor.com>
	<816315bc-4572-6c96-9872-8f19bf511eb1@gmail.com>
	<5E53D14CE4667A45B9A06760DE5D13D0F3ADA18C@ALA-MBD.corp.ad.wrs.com>
In-Reply-To: <5E53D14CE4667A45B9A06760DE5D13D0F3ADA18C@ALA-MBD.corp.ad.wrs.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.11.119.35]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [sumo][PATCH] toaster: localhostbecontroller: fix bitbake path resolution
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
X-List-Received-Date: Sun, 30 Sep 2018 07:41:34 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi again,

I have submitted the patch. The patch itself looks the same to me, however =
I did use the official "create-pull-request" on top of the latest pull, so =
maybe it will have a happier apply. I also took advantage of this submissio=
n by adding a formal Bugzilla case number into the commit text.

- David

-----Original Message-----
From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bo=
unces@lists.openembedded.org] On Behalf Of Reyna, David
Sent: Sunday, September 30, 2018 12:07 AM
To: akuster808; Belal, Awais; richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [sumo][PATCH] toaster: localhostbecontroller: =
fix bitbake path resolution

Hi all,

I created my own version of Awais's patch from my Sumo branch. The only dif=
ference was that I based by patch from the "bitbake" directory (Awais did i=
t from the bitbake/lib" directory), plus I got an extra blank line at the e=
nd.

I am going to submit my version of the patch in a few minutes. It should lo=
ok identical to the original from Awais, except for the above observations.

- David

-----Original Message-----
From: akuster808 [mailto:akuster808@gmail.com]=20
Sent: Friday, September 28, 2018 9:09 AM
To: Belal, Awais; richard.purdie@linuxfoundation.org; Reyna, David; bitbake=
-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [sumo][PATCH] toaster: localhostbecontroller: =
fix bitbake path resolution



On 09/28/2018 03:38 AM, Belal, Awais wrote:
>>> The patch doesn't apply to master so could you send a version which
>>> applies there please?
>>> I can then apply the sumo one at the same time which does presumably
>>> apply to sumo (I've not tried that as yet).
> Extremely sorry, this is only needed for sumo (1.38), master doesn't have=
 this problem.

This does not apply to sumo either. We have the commit it depends on:

c1f5ec8 bitbake: toaster: use a more flexible way to find bitbake

- armin

>
>
>
> BR,
> Awais
>
> ________________________________________
> From: richard.purdie@linuxfoundation.org <richard.purdie@linuxfoundation.=
org>
> Sent: Friday, September 28, 2018 12:52 PM
> To: Belal, Awais; Reyna, David; bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] [sumo][PATCH] toaster: localhostbecontroller=
: fix bitbake path resolution
>
> On Fri, 2018-09-28 at 07:37 +0000, Belal, Awais wrote:
>>>> I'm confused. Does master need the patch? or only sumo?
>> Both.
> The patch doesn't apply to master so could you send a version which
> applies there please?
>
> I can then apply the sumo one at the same time which does presumably
> apply to sumo (I've not tried that as yet).
>
> Thanks,
>
> Richard

--=20
_______________________________________________
bitbake-devel mailing list
bitbake-devel@lists.openembedded.org
http://lists.openembedded.org/mailman/listinfo/bitbake-devel

