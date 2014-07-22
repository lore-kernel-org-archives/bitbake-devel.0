Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id A796C65E08
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jul 2014 08:12:36 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s6M8CGwp019983
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 22 Jul 2014 01:12:17 -0700 (PDT)
Received: from [128.224.162.181] (128.224.162.181) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.169.1;
	Tue, 22 Jul 2014 01:12:16 -0700
Message-ID: <53CE1CDE.3060801@windriver.com>
Date: Tue, 22 Jul 2014 16:12:14 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>, "Rifenbark, Scott M"
	<scott.m.rifenbark@intel.com>
References: <cover.1404452300.git.liezhi.yang@windriver.com>	
	<29052f940ce9526083a09d3ce4e665a5aa9e0db1.1404452300.git.liezhi.yang@windriver.com>	
	<41DEA4B02DBDEF40A0F3B6D0DDB1237983FB63A9@ORSMSX101.amr.corp.intel.com>	
	<53BA3B26.4050407@windriver.com>	
	<41DEA4B02DBDEF40A0F3B6D0DDB1237983FB63CD@ORSMSX101.amr.corp.intel.com>
	<1405966732.22985.104.camel@ted>
In-Reply-To: <1405966732.22985.104.camel@ted>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/2] bitbake-user-manual-intro.xml: update for dump-signatures
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
X-List-Received-Date: Tue, 22 Jul 2014 08:12:40 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 07/22/2014 02:18 AM, Richard Purdie wrote:
> On Mon, 2014-07-07 at 06:18 +0000, Rifenbark, Scott M wrote:
>> Ok - if there is a problem or changes then let me know.  I have the
>> doc changes pushed to poky-contrib/srifenbark/bb-manual only.  Richard
>> would have to merge them from there into the upstream bitbake
>> repository.
>
> I modified Roberts patch a bit. Could you update the manual based on
> that patch? I didn't take the change for the manual you have queued for
> this, I'd suggest we create a new one. I did merge everything else in
> your bitbake manual branch.

Sorry, but I think that we need remove this:

type="choice", choices=("none", "printdiff")

after your explanations, otherwise we can't input other handlers.

I will update it later.

// Robert

>
> Cheers,
>
> Richard
>
>
>

