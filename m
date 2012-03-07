Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S5QJM-00011O-Te
	for bitbake-devel@lists.openembedded.org;
	Thu, 08 Mar 2012 00:30:25 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 07 Mar 2012 15:21:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="116121923"
Received: from pgsmsx101.gar.corp.intel.com ([10.221.44.78])
	by azsmga001.ch.intel.com with ESMTP; 07 Mar 2012 15:21:45 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	PGSMSX101.gar.corp.intel.com (10.221.44.78) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Thu, 8 Mar 2012 07:21:17 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Thu, 8 Mar 2012 07:21:17 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH 04/32] Hob: fixed the issue in the
	brought-in-by dialog.
Thread-Index: AQHM+J6k2OfwoE2tPEa2YCgcBsb8LpZffFDQ
Date: Wed, 7 Mar 2012 23:21:17 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AE4B16@SHSMSX102.ccr.corp.intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<660576fe6e84608bbf4d7237f5804cfd244029cd.1330523904.git.shane.wang@intel.com>
	<4F4E9885.6090705@linux.intel.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23ADFD13@SHSMSX102.ccr.corp.intel.com>
	<4F510B37.4040108@linux.intel.com>
In-Reply-To: <4F510B37.4040108@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 04/32] Hob: fixed the issue in the brought-in-by dialog.
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
X-List-Received-Date: Wed, 07 Mar 2012 23:30:25 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Joshua Lock wrote on=A02012-03-02:

> On 01/03/12 23:22, Wang, Shane wrote:
>> Joshua Lock wrote on 2012-03-01:
>>> On 29/02/12 06:15, Shane Wang wrote:
>>>> When typing any thing in the search entry, the brough-in-by dialog wil=
l
> be
>>> shown. That is because we call back "selection-changed" signal to pop
>>> up the dialog, which is not correct.
>>>> This patch is to fix the problem by using "row-activated" signal.
>>>>=20
>>>> Signed-off-by: Liming An<limingx.l.an@intel.com>
>>>> Signed-off-by: Shane Wang<shane.wang@intel.com>
>>>=20
>>> I point out some incorrect padding below but other than that:
>>> Signed-off-by: Joshua Lock<josh@linux.intel.com>
>>=20
>> OK, Got it. May I know why padding=3D6 only conforms to hig?
>=20
> Of course, but you should really read it though rather than asking me to
> quote it for you.
>=20
> "As a basic rule of thumb, leave space between user interface components
> in increments of 6 pixels, going up as the relationship between related
> elements becomes more distant."
>=20
> http://developer.gnome.org/hig-book/3.0/design-window.html.en#window-la
> yout-spacing
>=20
> I've volunteered to work through Hob and make it more HIG conformant but
> the HIG for a platform really is a document you should at least be aware
> of when developing for it.

Thank you for pointing out why 6, and volunteering to make the spacing 6.
We all just follow and are going to follow the design in the video.
And as well, make the build process go correctly and UI be friendly.

Again, there is no requirement to follow Hig at the beginning. There are a =
lot of hig specs
http://en.wikipedia.org/wiki/Human_interface_guidelines#Examples_of_HIG.

But regarding you raise the Gnome hig issue, I agree with you to make them =
conformant.

--
Shane

>=20
> Cheers,
> Joshua



