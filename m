Received: from mail-qe0-f47.google.com ([209.85.128.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <elizabeth.flanagan@intel.com>) id 1U9o3t-0002yb-BM
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Feb 2013 03:45:10 +0100
Received: by mail-qe0-f47.google.com with SMTP id 2so1298589qea.20
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Feb 2013 18:28:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:x-received:in-reply-to:references:date:message-id
	:subject:from:to:cc:content-type:content-transfer-encoding
	:x-gm-message-state;
	bh=ofHUuWzF8PY+z3kA8xYyHerWTVsFb+eLj/8WCSSjtDc=;
	b=pomQx75CUqxsVEaqQgjpQFuqcJrrhX1+5kgeTLfSueIdVClOYTE3tcaIFrxhaKNO9Z
	yAvJdBBmY663egaZnvk+dAtz9vLloSIoaZhK7v8DnkLVoMuKZ4TzjVNTKW/B67APE0Sy
	PVjYO8zzULmL5l/A3gEexP9LK+Zr6ofWhl2CVhDyjvKsNv+NdRnl+Wgk8s4U/l90DKji
	04WtmmtxUbiFBzy/MDztwFOXdSU6C1Bb9a1eS8FyuINlNmmmLRnIwSCNil3eTohOFdgw
	MIwRbuoIRgUzeXwJ5QwGe42i04ftQ9QcbQdTVcKUY7+SBK1fq86R6s7pz1Sl7kfFMxWS
	fK3g==
MIME-Version: 1.0
X-Received: by 10.224.222.15 with SMTP id ie15mr9149797qab.75.1361759327978;
	Sun, 24 Feb 2013 18:28:47 -0800 (PST)
Received: by 10.49.71.163 with HTTP; Sun, 24 Feb 2013 18:28:47 -0800 (PST)
In-Reply-To: <CAPhnLPCYxVk8F72Tv=PJo2OQJQmMdN0RKXNmTj_JeVy+7VJ+qA@mail.gmail.com>
References: <CALbNGRRDr+6vLtJRDgRi1NbO+s0sUB5TLT7uTck5L5La6xfDQw@mail.gmail.com>
	<CABcZANn3JbnhTEEP85K5bxXQd9ipYmuP9-bqMizpw+z9R3HhiQ@mail.gmail.com>
	<CAPhnLPCYxVk8F72Tv=PJo2OQJQmMdN0RKXNmTj_JeVy+7VJ+qA@mail.gmail.com>
Date: Sun, 24 Feb 2013 18:28:47 -0800
Message-ID: <CAPhnLPBwwM84Pu25od0pLr2446-RSbGsDHQbayQE3g+xNV2tkw@mail.gmail.com>
From: "Flanagan, Elizabeth" <elizabeth.flanagan@intel.com>
To: Chris Larson <clarson@kergoth.com>
X-Gm-Message-State: ALoCoQkudAua74CHBJEsZYoLQMud6BnJi3NaHBQzUtvxfNX7LiyCH5dRM7tG6nOpHVrYPeEFhW+o
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: trouble during parsing
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
X-List-Received-Date: Mon, 25 Feb 2013 02:45:12 -0000
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 24, 2013 at 6:12 PM, Flanagan, Elizabeth
<elizabeth.flanagan@intel.com> wrote:
> On Wed, Feb 20, 2013 at 6:31 AM, Chris Larson <clarson@kergoth.com> wrote=
:
>>
>> On Wed, Feb 20, 2013 at 5:54 AM, Andreas M=FCller
>> <schnitzeltony@googlemail.com> wrote:
>>>
>>> with current bitbake master I get
>>>
>>> ERROR: Command execution failed: Traceback (most recent call
>>> last):#########################################################
>>>                               | ETA:  00:00:17
>>>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/command.py", line
>>> 92, in runAsyncCommand
>>>     self.cooker.updateCache()
>>>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
>>> 1330, in updateCache
>>>     if not self.parser.parse_next():
>>>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
>>> 1703, in parse_next
>>>     self.virtuals +=3D len(result)
>>> TypeError: object of type 'ExpansionError' has no len()
>>
>>
>> Hmm, looks like it's returning the exceptions rather than raising them, =
for
>> some reason, but that doesn't make much sense =97 the pool code always r=
aises
>> any exceptions from its imap iterator's next() method.
>> --
>> Christopher Larson
>>
>
> I'm hitting this as well with
> poky:dde7a481354d5b0539762109bdfaaba6f85f879b, meta-ti and pandaboard
> as my machine.
>

Ach, should have updated my email. Seems reverting
0a99563a4ea270594fd9a61da46f9387fb79dc66 cleared up the issue.

-b

--=20
Elizabeth Flanagan
Yocto Project
Build and Release


