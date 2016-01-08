Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 1555E6FF64
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jan 2016 12:10:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u08CAUOR026307; Fri, 8 Jan 2016 12:10:30 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GpO4d4fXPyr4; Fri,  8 Jan 2016 12:10:30 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u08CAOPD026301
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 8 Jan 2016 12:10:25 GMT
Message-ID: <1452255024.7598.133.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Belal, Awais" <Awais_Belal@mentor.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Fri, 08 Jan 2016 12:10:24 +0000
In-Reply-To: <2021B186DC632746BD5A3CE32F12BD28011FB7BFBF@EU-MBX-02.mgc.mentorg.com>
References: <1449773843-23411-1-git-send-email-awais_belal@mentor.com>
	<2021B186DC632746BD5A3CE32F12BD280119AA60C3@EU-MBX-02.mgc.mentorg.com>
	, <CABcZANm0FxRqAfJdjLS1nq9JQ3fJeQNBAd3zWYqiWmZKhLR0cw@mail.gmail.com>
	<2021B186DC632746BD5A3CE32F12BD280119AB7286@EU-MBX-03.mgc.mentorg.com>
	, <1450364755.13505.214.camel@linuxfoundation.org>
	, <2021B186DC632746BD5A3CE32F12BD280119AC0AF0@EU-MBX-03.mgc.mentorg.com>
	, <2021B186DC632746BD5A3CE32F12BD28011FB7A425@EU-MBX-02.mgc.mentorg.com>
	<2021B186DC632746BD5A3CE32F12BD28011FB7BFBF@EU-MBX-02.mgc.mentorg.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
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
X-List-Received-Date: Fri, 08 Jan 2016 12:10:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2016-01-08 at 12:02 +0000, Belal, Awais wrote:
> Ping2!

Backported, sorry about the delay.

Cheers,

Richard

