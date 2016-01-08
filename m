Return-Path: <Awais_Belal@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	by mail.openembedded.org (Postfix) with ESMTP id A76FE6FF64
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jan 2016 12:20:25 +0000 (UTC)
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-FEM-03.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp 
	id 1aHW1q-0006Bo-2o from Awais_Belal@mentor.com ;
	Fri, 08 Jan 2016 04:20:26 -0800
Received: from EU-MBX-02.mgc.mentorg.com ([169.254.3.44]) by
	SVR-IES-FEM-03.mgc.mentorg.com ([137.202.0.108]) with mapi id
	14.03.0224.002; Fri, 8 Jan 2016 12:20:24 +0000
From: "Belal, Awais" <Awais_Belal@mentor.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] bitbake: fetch: use orig localpath
	when calling orig method
Thread-Index: AQHRN7WTLy9Y594dpke9G+YewV0Yzp7PJsVQgAAiqoCAB1lGGYAXuoI1gANMJp6AAAJSAIAAAr9C
Date: Fri, 8 Jan 2016 12:20:23 +0000
Message-ID: <2021B186DC632746BD5A3CE32F12BD28011FB7BFD9@EU-MBX-02.mgc.mentorg.com>
References: <1449773843-23411-1-git-send-email-awais_belal@mentor.com>
	<2021B186DC632746BD5A3CE32F12BD280119AA60C3@EU-MBX-02.mgc.mentorg.com>		,
	<CABcZANm0FxRqAfJdjLS1nq9JQ3fJeQNBAd3zWYqiWmZKhLR0cw@mail.gmail.com>
	<2021B186DC632746BD5A3CE32F12BD280119AB7286@EU-MBX-03.mgc.mentorg.com>	,
	<1450364755.13505.214.camel@linuxfoundation.org>	,
	<2021B186DC632746BD5A3CE32F12BD280119AC0AF0@EU-MBX-03.mgc.mentorg.com>
	, <2021B186DC632746BD5A3CE32F12BD28011FB7A425@EU-MBX-02.mgc.mentorg.com>
	<2021B186DC632746BD5A3CE32F12BD28011FB7BFBF@EU-MBX-02.mgc.mentorg.com>,
	<1452255024.7598.133.camel@linuxfoundation.org>
In-Reply-To: <1452255024.7598.133.camel@linuxfoundation.org>
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
X-List-Received-Date: Fri, 08 Jan 2016 12:20:26 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks a lot Richard :)=0A=
=0A=
BR,=0A=
Awais=0A=
=0A=
________________________________________=0A=
From: Richard Purdie [richard.purdie@linuxfoundation.org]=0A=
Sent: Friday, January 08, 2016 5:10 PM=0A=
To: Belal, Awais; bitbake-devel@lists.openembedded.org=0A=
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch: use orig localpath whe=
n calling orig method=0A=
=0A=
On Fri, 2016-01-08 at 12:02 +0000, Belal, Awais wrote:=0A=
> Ping2!=0A=
=0A=
Backported, sorry about the delay.=0A=
=0A=
Cheers,=0A=
=0A=
Richard=0A=

