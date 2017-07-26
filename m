Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 892AE62134
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Jul 2017 12:59:07 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v6QCx0iC028436
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 26 Jul 2017 05:59:00 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Wed, 26 Jul 2017 05:59:00 -0700
To: Andre McCurdy <armccurdy@gmail.com>
References: <1464700684-24169-1-git-send-email-fabien.proriolpatch@kazoe.org>
	<1464702613.3814.2.camel@linuxfoundation.org>
	<CAJ86T=Vp41R2c-XboBxv0NRK5FdFhpOE4WE8GpE8rOfbuXCJPA@mail.gmail.com>
	<dbd9a8df-5baa-d4de-ca19-722843d3b3ea@windriver.com>
	<CAJ86T=UW4gzF_CVhVMFdRCJsm3Nc6ETB9Acj=CUDzv96yUDg+g@mail.gmail.com>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <b63c8f8f-96e4-019f-e006-1f63889e5523@windriver.com>
Date: Wed, 26 Jul 2017 07:58:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
	Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAJ86T=UW4gzF_CVhVMFdRCJsm3Nc6ETB9Acj=CUDzv96yUDg+g@mail.gmail.com>
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
X-List-Received-Date: Wed, 26 Jul 2017 12:59:07 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 7/25/17 2:30 PM, Andre McCurdy wrote:
> On Tue, Jul 25, 2017 at 7:43 AM, Mark Hatle <mark.hatle@windriver.com> wrote:
>> On 7/24/17 4:04 PM, Andre McCurdy wrote:
>>> On Tue, May 31, 2016 at 6:50 AM, Richard Purdie
>>> <richard.purdie@linuxfoundation.org> wrote:
>>>> On Tue, 2016-05-31 at 15:18 +0200, fabien.proriolpatch@kazoe.org wrote:
>>>>> From: Fabien Proriol <fabien.proriol@jdsu.com>
>>>>>
>>>>> This patch add the possibility to bitbake to avoid git protocol to
>>>>> fetch sources.
>>>>> This is usefull in some network with firewall blocking git port.
>>>>>
>>>>> When BB_GIT_PROTOCOL_FIREWALL is set, the PROTOCOL_MIRRORS table is
>>>>> used to find the new protocol (http or https) and the new host (if
>>>>> different) to used.
>>>>>
>>>>> BB_GIT_PROTOCOL_FIREWALL can also contains a list of host accepted.
>>>>> This is usefull for exemple, if we use local git repository inside
>>>>> the network.
>>>>>
>>>>> Exemple usage:
>>>>>     # Avoid all git protocol
>>>>>     BB_GIT_PROTOCOL_FIREWALL = "1"
>>>>>
>>>>>     # Avoid git protocol, except for srv1 and srv2 in local network
>>>>>     BB_GIT_PROTOCOL_FIREWALL = "srv1.mydomain.com;srv2.mydomain.com"
>>>>
>>>> Why not use the more generic MIRRORS and PREMIRRORS for this? If they
>>>> can't support this, we likely should figure out a way to make them work
>>>> for it rather than adding new fetcher specific variables.
>>>
>>> Sorry for resurrecting such an old thread, but I'm wondering if
>>> there's been any more work on an upstreamable solution?
>>>
>>> The problem being that recipes which define SRC_URI to git://* with
>>> protocol=git (or with protocol unspecified, since git is the default)
>>> fail during fetching for users working behind a firewall which blocks
>>> the native git protocol.
>>>
>>> Although MIRRORS and PREMIRRORS allow mapping from one host to another
>>> there's no support for mapping one git fetch protocol to another and
>>> it looks like extending the MIRRORS syntax to support that would be a
>>> non-trivial change...
>>
>> Won't the following work:
>>
>> PREMIRRORS_append = " \
>>      git://.*/.* git://HOST/PATH;protocol=https \n \
>>      git://.*/.* git://HOST/PATH;protocol=http \n \
>> "
> 
> Thanks! Yes, that does work. It's the first time I've ever seen HOST
> or PATH being used as mirror replacement patterns. Useful to know.

As far as I know the following are defined:

TYPE, HOST, PATH, BASENAME, MIRRORNAME

The premirror pattern matching is broken up into three parts, type, host, path.
I.e.:

<pattern>://<pattern>/<pattern>

Thus the first three replacements, TYPE, HOST, PATH.

The BASENAME is simply the item the last '/' in the PATH.

MIRRORNAME is more complicated, but matches the name set in the DL_DIR.

(What has never been clear to me is how the mirroring handles the parameters,
items after the ';'.  I assume it just preserves the existing parameters and
then if you specify any additional ones adds them to the end of the list
effectively overriding any prior settings.)

I've not seen it specifically documented this way -- but I've been using this
approach now for a few years so it's possible it has been documented and I've
just missed it.

--Mark

> Would a patch adding something similar to the default MIRRORS (ie try
> http[s] as a fallback if the git protocol fails) be acceptable in
> upstream oe-core?
> 
>> Note: I've not actually tried the above, but I expect it will work.  We do
>> something similar to provide local (on-disk) git caches using:
>>
>> git://.*/.* git://${LAYERDIR}/git/MIRRORNAME;protocol=file
>>
>> --Mark
>>
>>>> Cheers,
>>>>
>>>> Richard
>>>> --
>>>> _______________________________________________
>>>> bitbake-devel mailing list
>>>> bitbake-devel@lists.openembedded.org
>>>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>


