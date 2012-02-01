Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>)
	id 1Rsg7F-0002YN-IO; Wed, 01 Feb 2012 20:45:13 +0100
Received: by lahc1 with SMTP id c1so854494lah.6
	for <multiple recipients>; Wed, 01 Feb 2012 11:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=g7APpr9ilcag3crGW172oTUE3COYAtynDmeXF1Pp8ps=;
	b=NE6eBTqeFnnLYS8YSSfqKwlb4N5ETJfneAZS9f/gkAIBAZk+reC8tYOH/OznSE2NAu
	AxLkb+9Ep0JSmJEnhWitbCjnh+KqimluqcDDdfRkozjSSnnaBSboNV6EEV5bLdBb4It8
	FqaCCOX1TkJCfdzTOT9pebMjZhiEv2aRGpyhQ=
Received: by 10.152.122.38 with SMTP id lp6mr13982243lab.13.1328125038270;
	Wed, 01 Feb 2012 11:37:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.152.5.201 with HTTP; Wed, 1 Feb 2012 11:36:48 -0800 (PST)
In-Reply-To: <20120201181909.GC6969@jama.jama.net>
References: <CAMKF1so7zfZSiGq+txWdBkONMtMi8iKRhqV_TOPt3FV3fTTEpQ@mail.gmail.com>
	<CAEsOVNekW4Zo6YRHyNCTMJ_GsgrzaOE8QvWr70tRNAZQNokcig@mail.gmail.com>
	<CAP9ODKo5EQEWr2CU9uQdz6mXKPJfN6zhbSkTcC01k8rU2D4kQg@mail.gmail.com>
	<CAEsOVNeh8GTOcU+jF1jxs1FJTi84vq0_AVX9osvU1R83gzq2nA@mail.gmail.com>
	<CAMKF1sqkdApUR9YPamhtxtUHoanHZ5Sxp8ggUnp8PS0v_qPPgg@mail.gmail.com>
	<20120201181909.GC6969@jama.jama.net>
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 1 Feb 2012 11:36:48 -0800
Message-ID: <CAMKF1so9c_r10kK1nhY17p8vjVm==vz5wxdXvFJim6JCbHpdiQ@mail.gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] should we switch off patchwork for oe-core and bitbake projects
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
X-List-Received-Date: Wed, 01 Feb 2012 19:45:13 -0000
Content-Type: text/plain; charset=UTF-8

On Wed, Feb 1, 2012 at 10:19 AM, Martin Jansa <martin.jansa@gmail.com> wrote:
> On Wed, Feb 01, 2012 at 10:07:14AM -0800, Khem Raj wrote:
>> On Wed, Feb 1, 2012 at 9:51 AM, McClintock Matthew-B29882
>> <B29882@freescale.com> wrote:
>> > I'm saying leave it there even if its not maintained. I can still go search
>> > for patches sent by me or other specific people.
>>
>> thats what mailing list archives are for.
>
> is there something like
> oe/contrib/patchwork/pw-am.sh
> for some mailing list archive?
>

not exactly but if we enable mbox archive download on the ml
you can see the mails in mbox formats and download it. then it would
be git am'able

> When I see some interesting patch in ML, easiest way for me to get it to
> development branch is to open patchwork web (from any computer) and then
> call pw-am.sh NUMBER in screen session on my development workstation.
>
> Even when reading mail in mutt on the same machine it's easier for me to
> use pw-am.sh to get that patch to my chroot for OE builds.
>
> And that git hook marking them as applied works very well.. so usually I
> just have to mark cover letters as applied.
>

yes it works fine for most of the times however for oe-core
the patches get sent to ml and then picked and again resent
as pull request sometimes nudged sometimes unmodified and patchwork
does not close them automatically.

so purpose of patchwork in this case would be different then It is just to host
the patches for oe-core but has a different usage for
oe-devel where the patches are picked and closed from the patchwork.
This could be confusing at times especially
for new people. But if we see enough value to keep it
that way then we can think of making some changes so it
detects the resends somehow if the patch hashes are not same
etc and close them.


