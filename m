Received: from relay1.mentorg.com ([192.94.38.131])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Andrew_Stubbs@mentor.com>) id 1Tv6FD-0003UJ-KD
	for bitbake-devel@lists.openembedded.org;
	Tue, 15 Jan 2013 14:08:19 +0100
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp 
	id 1Tv60L-0001eN-JW from Andrew_Stubbs@mentor.com 
	for bitbake-devel@lists.openembedded.org;
	Tue, 15 Jan 2013 04:52:37 -0800
Received: from SVR-IES-FEM-01.mgc.mentorg.com ([137.202.0.104]) by
	SVR-ORW-EXC-10.mgc.mentorg.com with Microsoft
	SMTPSVC(6.0.3790.4675); Tue, 15 Jan 2013 04:52:37 -0800
Received: from [172.30.4.143] (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
	(137.202.0.104) with Microsoft SMTP Server id 14.1.289.1;
	Tue, 15 Jan 2013 12:52:35 +0000
Message-ID: <50F55111.8040408@codesourcery.com>
Date: Tue, 15 Jan 2013 12:52:33 +0000
From: Andrew Stubbs <ams@codesourcery.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
CC: <bitbake-devel@lists.openembedded.org>
References: <50F421E6.4060400@codesourcery.com>
In-Reply-To: <50F421E6.4060400@codesourcery.com>
X-OriginalArrivalTime: 15 Jan 2013 12:52:37.0384 (UTC)
	FILETIME=[321BF080:01CDF31F]
Subject: Re: [PATCH] fix bundled base.bbclass file
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
X-List-Received-Date: Tue, 15 Jan 2013 13:08:22 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 14/01/13 15:19, Andrew Stubbs wrote:
> Hi,
>
> The base.bbclass file that is included with the bitbake sources does not
> appear to work properly. Specifically, none of the output appears on
> screen.
>
> A quick look at the poky equivalent shows that they use a different
> means to print the data. Presumably something got updated somewhere, and
> the example base class is merely out of date.
>
> The attached patch fixes the do_listtasks and do_showdata code such that
> it works as I would expect.
>
> I had expected that the base_do_build function would run if my .bb file
> did not define do_build, but it does not appear to, and it's not obvious
> to me how, when, or why it is supposed to work.

I forgot to add, the env printing still doesn't work, but I don't know 
how best to fix that? The emit_env method takes a file handle, but 
stdout and stderr don't work.

Andrew


