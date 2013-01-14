Received: from relay1.mentorg.com ([192.94.38.131])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Andrew_Stubbs@mentor.com>) id 1TulYn-0000m4-Vt
	for bitbake-devel@lists.openembedded.org;
	Mon, 14 Jan 2013 16:02:50 +0100
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp 
	id 1TulJx-00015U-BP from Andrew_Stubbs@mentor.com ;
	Mon, 14 Jan 2013 06:47:29 -0800
Received: from SVR-IES-FEM-01.mgc.mentorg.com ([137.202.0.104]) by
	SVR-ORW-EXC-10.mgc.mentorg.com with Microsoft
	SMTPSVC(6.0.3790.4675); Mon, 14 Jan 2013 06:47:29 -0800
Received: from [172.30.3.170] (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
	(137.202.0.104) with Microsoft SMTP Server id 14.1.289.1;
	Mon, 14 Jan 2013 14:47:28 +0000
Message-ID: <50F41A7D.7080108@codesourcery.com>
Date: Mon, 14 Jan 2013 14:47:25 +0000
From: Andrew Stubbs <ams@codesourcery.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To: Bill Traynor <wmat@alphatroop.com>
References: <50F4106E.8070404@codesourcery.com>
	<CAGfZjq4GBKd=qc5LQgZQ=6odp8bJgGSW72qE9N=397UjfcYGig@mail.gmail.com>
In-Reply-To: <CAGfZjq4GBKd=qc5LQgZQ=6odp8bJgGSW72qE9N=397UjfcYGig@mail.gmail.com>
X-OriginalArrivalTime: 14 Jan 2013 14:47:29.0054 (UTC)
	FILETIME=[137393E0:01CDF266]
Cc: Andrew Stubbs <ams@codesourcery.com>, bitbake-devel@lists.openembedded.org
Subject: Re: Minimal BitBake template
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
X-List-Received-Date: Mon, 14 Jan 2013 15:02:50 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 14/01/13 14:23, Bill Traynor wrote:
> This doesn't answer your problem directy, and you may have seen this
> tutorial already, but in case not:
>
> http://hambedded.org/blog/2012/11/24/from-bitbake-hello-world-to-an-image/
>
> Note that I'm including a hello world example in the new BitBake User
> Manual I'm working on.

Thanks!  That's a very useful resource. :)

It's surprisingly hard to find BitBake tutorials that do not assume that 
one is trying to insert something into OE. I wish I'd found this sooner.

The other think I wish I'd found sooner, that you page references, are 
the example conf and bbclass files inside the bitbake sources. I had 
assumed they were some sort of internal detail, and not for the likes of me.

Apparently my base.bbclass and hello.bb files are absolutely fine, but 
something, as yet unidentified, in the bitbake.conf from the sources has 
fixed my problem.

Andrew


