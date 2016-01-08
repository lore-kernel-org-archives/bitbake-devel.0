Return-Path: <Awais_Belal@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	by mail.openembedded.org (Postfix) with ESMTP id 6B451731E0
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jan 2016 12:02:15 +0000 (UTC)
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-FEM-01.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp 
	id 1aHVkG-0000dW-60 from Awais_Belal@mentor.com ;
	Fri, 08 Jan 2016 04:02:16 -0800
Received: from EU-MBX-02.mgc.mentorg.com ([169.254.3.44]) by
	SVR-IES-FEM-01.mgc.mentorg.com ([137.202.0.104]) with mapi id
	14.03.0224.002; Fri, 8 Jan 2016 12:02:15 +0000
From: "Belal, Awais" <Awais_Belal@mentor.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] bitbake: fetch: use orig localpath
	when calling orig method
Thread-Index: AQHRN7WTLy9Y594dpke9G+YewV0Yzp7PJsVQgAAiqoCAB1lGGYAXuoI1gANMJp4=
Date: Fri, 8 Jan 2016 12:02:14 +0000
Message-ID: <2021B186DC632746BD5A3CE32F12BD28011FB7BFBF@EU-MBX-02.mgc.mentorg.com>
References: <1449773843-23411-1-git-send-email-awais_belal@mentor.com>
	<2021B186DC632746BD5A3CE32F12BD280119AA60C3@EU-MBX-02.mgc.mentorg.com>	,
	<CABcZANm0FxRqAfJdjLS1nq9JQ3fJeQNBAd3zWYqiWmZKhLR0cw@mail.gmail.com>
	<2021B186DC632746BD5A3CE32F12BD280119AB7286@EU-MBX-03.mgc.mentorg.com>, 
	<1450364755.13505.214.camel@linuxfoundation.org>,
	<2021B186DC632746BD5A3CE32F12BD280119AC0AF0@EU-MBX-03.mgc.mentorg.com>,
	<2021B186DC632746BD5A3CE32F12BD28011FB7A425@EU-MBX-02.mgc.mentorg.com>
In-Reply-To: <2021B186DC632746BD5A3CE32F12BD28011FB7A425@EU-MBX-02.mgc.mentorg.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.202.0.69]
MIME-Version: 1.0
Subject: Re: [PATCH] bitbake: fetch: use orig localpath when calling orig method
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
X-List-Received-Date: Fri, 08 Jan 2016 12:02:16 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ping2!=0A=
=0A=
BR,=0A=
Awais=0A=
=0A=
________________________________________=0A=
From: bitbake-devel-bounces@lists.openembedded.org [bitbake-devel-bounces@l=
ists.openembedded.org] on behalf of Belal, Awais=0A=
Sent: Wednesday, January 06, 2016 2:40 PM=0A=
To: Richard Purdie; bitbake-devel@lists.openembedded.org=0A=
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch: use orig localpath whe=
n calling orig method=0A=
=0A=
Ping!=0A=
=0A=
BR,=0A=
Awais=0A=
=0A=
________________________________________=0A=
From: bitbake-devel-bounces@lists.openembedded.org [bitbake-devel-bounces@l=
ists.openembedded.org] on behalf of Belal, Awais=0A=
Sent: Tuesday, December 22, 2015 12:20 PM=0A=
To: Richard Purdie; bitbake-devel@lists.openembedded.org=0A=
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch: use orig localpath whe=
n calling orig method=0A=
=0A=
Hi Richard,=0A=
=0A=
This applies to 1.28 as well as I stated earlier but I see that it only got=
 its way into master. Is someone else maintaining 1.28 or is this just queu=
ed for later?=0A=
=0A=
BR,=0A=
Awais=0A=
=0A=
________________________________________=0A=
From: Richard Purdie [richard.purdie@linuxfoundation.org]=0A=
Sent: Thursday, December 17, 2015 8:05 PM=0A=
To: Belal, Awais; bitbake-devel@lists.openembedded.org=0A=
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch: use orig localpath whe=
n calling orig method=0A=
=0A=
On Thu, 2015-12-17 at 13:02 +0000, Belal, Awais wrote:=0A=
> Ping! Is there a reservation against this?=0A=
=0A=
No reservation, it just came in at the end of the last round of patches=0A=
I batched/tested/merged and is therefore going into the next one.=0A=
=0A=
Cheers,=0A=
=0A=
Richard=0A=
--=0A=
_______________________________________________=0A=
bitbake-devel mailing list=0A=
bitbake-devel@lists.openembedded.org=0A=
http://lists.openembedded.org/mailman/listinfo/bitbake-devel=0A=
--=0A=
_______________________________________________=0A=
bitbake-devel mailing list=0A=
bitbake-devel@lists.openembedded.org=0A=
http://lists.openembedded.org/mailman/listinfo/bitbake-devel=0A=

