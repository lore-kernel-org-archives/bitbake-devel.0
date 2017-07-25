Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 43F31781F7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Jul 2017 14:44:01 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v6PEhuFs011052
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 25 Jul 2017 07:43:56 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.227) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Tue, 25 Jul 2017 07:43:55 -0700
To: Andre McCurdy <armccurdy@gmail.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
References: <1464700684-24169-1-git-send-email-fabien.proriolpatch@kazoe.org>
	<1464702613.3814.2.camel@linuxfoundation.org>
	<CAJ86T=Vp41R2c-XboBxv0NRK5FdFhpOE4WE8GpE8rOfbuXCJPA@mail.gmail.com>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <dbd9a8df-5baa-d4de-ca19-722843d3b3ea@windriver.com>
Date: Tue, 25 Jul 2017 09:43:54 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
	Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAJ86T=Vp41R2c-XboBxv0NRK5FdFhpOE4WE8GpE8rOfbuXCJPA@mail.gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Fabien Proriol <fabien.proriol@jdsu.com>, fabien.proriolpatch@kazoe.org
Subject: Re: [PATCH] bb.fetch.git: add a way to avoid git protocol, and force http or https mirrors
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
X-List-Received-Date: Tue, 25 Jul 2017 14:44:02 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 7/24/17 4:04 PM, Andre McCurdy wrote:
> On Tue, May 31, 2016 at 6:50 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>> On Tue, 2016-05-31 at 15:18 +0200, fabien.proriolpatch@kazoe.org wrote:
>>> From: Fabien Proriol <fabien.proriol@jdsu.com>
>>>
>>> This patch add the possibility to bitbake to avoid git protocol to
>>> fetch sources.
>>> This is usefull in some network with firewall blocking git port.
>>>
>>> When BB_GIT_PROTOCOL_FIREWALL is set, the PROTOCOL_MIRRORS table is
>>> used to find the new protocol (http or https) and the new host (if
>>> different) to used.
>>>
>>> BB_GIT_PROTOCOL_FIREWALL can also contains a list of host accepted.
>>> This is usefull for exemple, if we use local git repository inside
>>> the network.
>>>
>>> Exemple usage:
>>>     # Avoid all git protocol
>>>     BB_GIT_PROTOCOL_FIREWALL = "1"
>>>
>>>     # Avoid git protocol, except for srv1 and srv2 in local network
>>>     BB_GIT_PROTOCOL_FIREWALL = "srv1.mydomain.com;srv2.mydomain.com"
>>
>> Why not use the more generic MIRRORS and PREMIRRORS for this? If they
>> can't support this, we likely should figure out a way to make them work
>> for it rather than adding new fetcher specific variables.
> 
> Sorry for resurrecting such an old thread, but I'm wondering if
> there's been any more work on an upstreamable solution?
> 
> The problem being that recipes which define SRC_URI to git://* with
> protocol=git (or with protocol unspecified, since git is the default)
> fail during fetching for users working behind a firewall which blocks
> the native git protocol.
> 
> Although MIRRORS and PREMIRRORS allow mapping from one host to another
> there's no support for mapping one git fetch protocol to another and
> it looks like extending the MIRRORS syntax to support that would be a
> non-trivial change...

Won't the following work:

PREMIRRORS_append = " \
     git://.*/.* git://HOST/PATH;protocol=https \n \
     git://.*/.* git://HOST/PATH;protocol=http \n \
"

Note: I've not actually tried the above, but I expect it will work.  We do
something similar to provide local (on-disk) git caches using:

git://.*/.* git://${LAYERDIR}/git/MIRRORNAME;protocol=file

--Mark

>> Cheers,
>>
>> Richard
>> --
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


