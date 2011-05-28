Received: from mail-ww0-f43.google.com ([74.125.82.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>)
	id 1QQ8U8-0003B1-Uk; Sat, 28 May 2011 03:38:37 +0200
Received: by wwb17 with SMTP id 17so1991224wwb.24
	for <multiple recipients>; Fri, 27 May 2011 18:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=tH4NzZxnuYRV6OXZWDp7bLe9avSc6Wz7/ROfBxgCoR0=;
	b=ZByJJA/krKsy7qM0aIcAc3eFrsEkLJhW5pNj9GR/lXGmvL6vmMr6bZ2HrQFv0iYVLM
	cXK6/uY3qSWk/anl/xw0Jxp6LTMmFFkQZmIKbkFfWN6kr5sZe7MNYgnqU8pOTsU1cO0V
	FDBpq+MzpdhyKoLh68+wgnQ/2u/MFKj8yfme4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	b=xYS1f6yIIrooJQFdP017y+Tm7JL1ccNZjdewdeGxH9wDAywY0rH465ubFD5nTugevy
	2ncor2rQiBGfH8A0uj5zhnBrFfZYXAYP28TfFv5RoaNoQGapTQQuCjL63EZRLaA11gMG
	KG8lMYCKJ/UcwD4GqFCdVfpHkZAd5HvYDglyg=
Received: by 10.216.176.82 with SMTP id a60mr305664wem.21.1306546512108; Fri,
	27 May 2011 18:35:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.60.145 with HTTP; Fri, 27 May 2011 18:34:42 -0700 (PDT)
In-Reply-To: <BANLkTim=21XEknpdU=pG=DVfTkX7NP6n_g@mail.gmail.com>
References: <cover.1306477652.git.lianhao.lu@intel.com>
	<1306515635.27470.284.camel@rex>
	<7DC6724C-BF20-4EA1-A87D-32FBEEECDA3B@dominion.thruhere.net>
	<1306526949.1747.8.camel@vorpal> <1306534180.27470.305.camel@rex>
	<BANLkTim9C=WvgeHDxVNpKBQQ4jLBucOftQ@mail.gmail.com>
	<BANLkTim=21XEknpdU=pG=DVfTkX7NP6n_g@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 27 May 2011 18:34:42 -0700
Message-ID: <BANLkTim2V8qo0TaC-_w1XBiYsBx5VwTv2w@mail.gmail.com>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [OE-core] [PATCH 00/11] Add PR service and integrate PKGV/PKGR from OE
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
X-List-Received-Date: Sat, 28 May 2011 01:38:37 -0000
Content-Type: text/plain; charset=UTF-8

On Fri, May 27, 2011 at 6:05 PM, Khem Raj <raj.khem@gmail.com> wrote:
> On Fri, May 27, 2011 at 6:02 PM, Khem Raj <raj.khem@gmail.com> wrote:
>> On Fri, May 27, 2011 at 3:09 PM, Richard Purdie
>> <richard.purdie@linuxfoundation.org> wrote:
>>> On Fri, 2011-05-27 at 13:09 -0700, Joshua Lock wrote:
>>>> Upstream BitBake still has the xmlrpc server removed. The version in
>>>> Poky's BitBake is functional (I use it daily).
>>>>
>>>> Attached are two patches against BitBake master to add back the xmlrpc
>>>> server (copied from Poky's tree) and fix the uievent.
>>>
>>> There have been API changes in upstream which mean this code will fail
>>> to work with bitbake itself although it will work with the pr server.
>>>
>>> I've merged the patches as a bandaid to allow things to work but we've
>>> now got two different server backends using different server APIs. I
>>> really just want to highlight I'm aware of this and it will get
>>> addressed next week. Its been on my todo list and is way overdue. The
>>> main priority is to get people's builds with OE-Core working again.
>>>
>>
>> btw. I am at 6c412f009e33e77cbcb5d4881c110e6bdda05282 of bitbake
>> I still see the problem
>>
>
>
> here is the error
>
> NOTE: Running task 919 of 925 (ID: 9,
> /home/kraj/work/angstrom/sources/openembedded-core/meta/recipes-core/uclibc/uclibc_git.bb,
> do_package)
> NOTE: package uclibc-0.9.31+0.9.32rc3-r2.2: task do_package: Started
> ERROR: Connecting to PR service None:None failed: int() argument must
> be a string or a number, not 'NoneType'
> ERROR: Function 'package_get_auto_pr' failed
> ERROR: Logfile of failure stored in:
> /home/kraj/work/angstrom/build/tmp-angstrom_2010_x-uclibc/work/efikamx-angstrom-linux-uclibceabi/uclibc-0.9.31+0.9.32rc3-r2.2/temp/log.do_package.5207
> Log data follows:
> | ERROR: Connecting to PR service None:None failed: int() argument
> must be a string or a number, not 'NoneType'
> | ERROR: Function 'package_get_auto_pr' failed
> NOTE: package uclibc-0.9.31+0.9.32rc3-r2.2: task do_package: Failed
> ERROR: Task 9 (/home/kraj/work/angstrom/sources/openembedded-core/meta/recipes-core/uclibc/uclibc_git.bb,
> do_package) failed with exit code '1'
> ERROR: '/home/kraj/work/angstrom/sources/openembedded-core/meta/recipes-core/uclibc/uclibc_git.bb'
> failed
>
>

this patch seems to fix it.

http://patches.openembedded.org/patch/4941/

>>> Cheers,
>>>
>>> Richard
>>>
>>>
>>>
>>> _______________________________________________
>>> Openembedded-core mailing list
>>> Openembedded-core@lists.openembedded.org
>>> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/openembedded-core
>>>
>>
>


