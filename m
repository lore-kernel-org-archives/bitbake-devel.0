Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail.openembedded.org (Postfix) with ESMTP id 7D0D171BF9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Jul 2017 19:29:59 +0000 (UTC)
Received: by mail-wm0-f67.google.com with SMTP id 184so17353397wmo.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Jul 2017 12:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=UYTkhaBIBJevRSQzjVQX2VzmvpyvSU6NUDvk9dpUYkg=;
	b=I8kw+gOMYBFbeAvLQPtOqruum8ImSez/bNLHVKAA9ZEzUrFcXZ0+gY2sHgv/g7fkcP
	4//4GyOsz7SJSRMaVYQ/vB7B0X/TrQfj++ULAjxX7cvubhnlqEID7grhvUrQC8yNy9bu
	s1rrxBfT7o7wIHRKX4XuHpvNUFiWqd970ckG9TUoz+HppU8ngvirqi/Ah6EnIWCgMfJq
	Y040zZWjrDXiskXEsE9bF3WH8i5mh15LKTXlJklo/PCOVI/VyVUX41c6xJegDvOlEdv7
	F92uhIQ0UUhiqe6oyx9Mx4kQEVzKIKVWvClNGmKukBpz2Ee84QLGeEZItsKMgDfkB2kY
	qbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=UYTkhaBIBJevRSQzjVQX2VzmvpyvSU6NUDvk9dpUYkg=;
	b=nN/hq9LkLyr6FiCS5qPfzdv1EDUg2g9PdB8GcmaenKoHOZIbDg85tw0ePCYztzPZ+i
	JiApPEd1RF7s63rdAHSD4nl+LjZMDdNgJVpcvZA4df1FVGRwcuXMD8bluz1MdYHst0dD
	jsqi7Bd9jR+wYTYhrcZe5BO3i/O57nSg52gaSATYiSdaAJpIxLW3zHnjaA8m1CoC8Ta1
	daOfJUvlb9zy48Tfpf2dhBF1DS2+ANhwJJIcrEE9XWPligy1NemiYyV/qdBClP7YMjcA
	EZQ5rYLZDjcmWzYKnAjWasr5ao1RaluYyV38oTdzDb3+rN5AG1Lql8/spXcwavCWlh6J
	tmAA==
X-Gm-Message-State: AIVw113Es8KYKQXiFXbIsVrmtAlhFzeTdtuX61N5scuDwpZ7fz2zOYQt
	H1GWX4IjIIYquvsZRDID+aM0H2ojiw==
X-Received: by 10.28.216.21 with SMTP id p21mr9411083wmg.24.1501011000845;
	Tue, 25 Jul 2017 12:30:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.175.16 with HTTP; Tue, 25 Jul 2017 12:30:00 -0700 (PDT)
In-Reply-To: <dbd9a8df-5baa-d4de-ca19-722843d3b3ea@windriver.com>
References: <1464700684-24169-1-git-send-email-fabien.proriolpatch@kazoe.org>
	<1464702613.3814.2.camel@linuxfoundation.org>
	<CAJ86T=Vp41R2c-XboBxv0NRK5FdFhpOE4WE8GpE8rOfbuXCJPA@mail.gmail.com>
	<dbd9a8df-5baa-d4de-ca19-722843d3b3ea@windriver.com>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Tue, 25 Jul 2017 12:30:00 -0700
Message-ID: <CAJ86T=UW4gzF_CVhVMFdRCJsm3Nc6ETB9Acj=CUDzv96yUDg+g@mail.gmail.com>
To: Mark Hatle <mark.hatle@windriver.com>
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
X-List-Received-Date: Tue, 25 Jul 2017 19:30:00 -0000
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 25, 2017 at 7:43 AM, Mark Hatle <mark.hatle@windriver.com> wrote:
> On 7/24/17 4:04 PM, Andre McCurdy wrote:
>> On Tue, May 31, 2016 at 6:50 AM, Richard Purdie
>> <richard.purdie@linuxfoundation.org> wrote:
>>> On Tue, 2016-05-31 at 15:18 +0200, fabien.proriolpatch@kazoe.org wrote:
>>>> From: Fabien Proriol <fabien.proriol@jdsu.com>
>>>>
>>>> This patch add the possibility to bitbake to avoid git protocol to
>>>> fetch sources.
>>>> This is usefull in some network with firewall blocking git port.
>>>>
>>>> When BB_GIT_PROTOCOL_FIREWALL is set, the PROTOCOL_MIRRORS table is
>>>> used to find the new protocol (http or https) and the new host (if
>>>> different) to used.
>>>>
>>>> BB_GIT_PROTOCOL_FIREWALL can also contains a list of host accepted.
>>>> This is usefull for exemple, if we use local git repository inside
>>>> the network.
>>>>
>>>> Exemple usage:
>>>>     # Avoid all git protocol
>>>>     BB_GIT_PROTOCOL_FIREWALL = "1"
>>>>
>>>>     # Avoid git protocol, except for srv1 and srv2 in local network
>>>>     BB_GIT_PROTOCOL_FIREWALL = "srv1.mydomain.com;srv2.mydomain.com"
>>>
>>> Why not use the more generic MIRRORS and PREMIRRORS for this? If they
>>> can't support this, we likely should figure out a way to make them work
>>> for it rather than adding new fetcher specific variables.
>>
>> Sorry for resurrecting such an old thread, but I'm wondering if
>> there's been any more work on an upstreamable solution?
>>
>> The problem being that recipes which define SRC_URI to git://* with
>> protocol=git (or with protocol unspecified, since git is the default)
>> fail during fetching for users working behind a firewall which blocks
>> the native git protocol.
>>
>> Although MIRRORS and PREMIRRORS allow mapping from one host to another
>> there's no support for mapping one git fetch protocol to another and
>> it looks like extending the MIRRORS syntax to support that would be a
>> non-trivial change...
>
> Won't the following work:
>
> PREMIRRORS_append = " \
>      git://.*/.* git://HOST/PATH;protocol=https \n \
>      git://.*/.* git://HOST/PATH;protocol=http \n \
> "

Thanks! Yes, that does work. It's the first time I've ever seen HOST
or PATH being used as mirror replacement patterns. Useful to know.

Would a patch adding something similar to the default MIRRORS (ie try
http[s] as a fallback if the git protocol fails) be acceptable in
upstream oe-core?

> Note: I've not actually tried the above, but I expect it will work.  We do
> something similar to provide local (on-disk) git caches using:
>
> git://.*/.* git://${LAYERDIR}/git/MIRRORNAME;protocol=file
>
> --Mark
>
>>> Cheers,
>>>
>>> Richard
>>> --
>>> _______________________________________________
>>> bitbake-devel mailing list
>>> bitbake-devel@lists.openembedded.org
>>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

