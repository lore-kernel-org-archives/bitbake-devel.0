Return-Path: <belen.barros.pena@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 970F860657
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Oct 2015 11:12:34 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 26 Oct 2015 04:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,201,1444719600"; d="scan'208";a="803106533"
Received: from irsmsx102.ger.corp.intel.com ([163.33.3.155])
	by orsmga001.jf.intel.com with ESMTP; 26 Oct 2015 04:12:34 -0700
Received: from irsmsx155.ger.corp.intel.com (163.33.192.3) by
	IRSMSX102.ger.corp.intel.com (163.33.3.155) with Microsoft SMTP Server
	(TLS) id 14.3.248.2; Mon, 26 Oct 2015 11:12:32 +0000
Received: from irsmsx110.ger.corp.intel.com ([169.254.15.151]) by
	irsmsx155.ger.corp.intel.com ([169.254.14.242]) with mapi id
	14.03.0248.002; Mon, 26 Oct 2015 11:12:31 +0000
From: "Barros Pena, Belen" <belen.barros.pena@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, "Smith, Elliot"
	<elliot.smith@intel.com>
Thread-Topic: [bitbake-devel] [PATCH] cooker: Ensure BB_CONSOLE remains
	correct over server resets
Thread-Index: AQHRD981LIkmk7m+8ky7bGF3hHsXVQ==
Date: Mon, 26 Oct 2015 11:12:31 +0000
Message-ID: <D253B966.68FF8%belen.barros.pena@intel.com>
References: <1444555346.14364.24.camel@linuxfoundation.org>
	<CA+1hgUj5Lty=V_jSWE1YA2CPJuaY5-PAoj+P8gEtzSKDN5gVjA@mail.gmail.com>
	<1445011191.17974.34.camel@linuxfoundation.org>
	<CA+1hgUg7=OhPXV=fHrXzLpSeWKZekx0BkYpu1BC8zaA1H7gG2w@mail.gmail.com>
	<1445685965.21913.58.camel@linuxfoundation.org>
In-Reply-To: <1445685965.21913.58.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.5.7.151005
x-originating-ip: [10.252.19.69]
MIME-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker: Ensure BB_CONSOLE remains correct over server resets
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
X-List-Received-Date: Mon, 26 Oct 2015 11:12:35 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6F23A65697967B4AB66C3C9BEDCDB69E@intel.com>
Content-Transfer-Encoding: quoted-printable



On 24/10/2015 12:26, "bitbake-devel-bounces@lists.openembedded.org on
behalf of Richard Purdie" <bitbake-devel-bounces@lists.openembedded.org on
behalf of richard.purdie@linuxfoundation.org> wrote:

>On Mon, 2015-10-19 at 13:27 +0100, Smith, Elliot wrote:
>> Thanks for clarifying.
>>
>> Will these patches be in 2.0? From the toaster point of view, it would
>> be better if the current behaviour remained for now, even though it is
>> broken.
>>
>> We are working on a solution which will write separate build logs from
>> within Toaster itself, which will mean we can keep our log download
>> working when your patches do go in.
>>
>> However, we may not get this finished for 2.0, and it would be good if
>> we could keep the Toaster log download feature working in the
>> meantime.
>>=20
>Given the other discussion I've seen, I'm assuming it would be ok to
>merge these now?

I think it would be ok to merge them only if this

https://lists.yoctoproject.org/pipermail/toaster/2015-October/003196.html


Makes it to 2.0. Right now is still under review in the Toaster mailing
list.

Elliot: correct me if I am wrong.

Cheers

Bel=E9n


>
>Cheers,
>
>Richard
>
>
>
>--=20
>_______________________________________________
>bitbake-devel mailing list
>bitbake-devel@lists.openembedded.org
>http://lists.openembedded.org/mailman/listinfo/bitbake-devel


