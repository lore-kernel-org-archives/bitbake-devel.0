Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57017C433EF
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 13:08:11 +0000 (UTC)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by mx.groups.io with SMTP id smtpd.web11.11989.1654607288502954136
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jun 2022 06:08:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm2
 header.b=Gm4/eP+x;
 spf=pass (domain: zhukoff.net, ip: 64.147.123.25,
 mailfrom: pavel@zhukoff.net)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 6C2E43200D85;
	Tue,  7 Jun 2022 09:08:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 07 Jun 2022 09:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1654607286; x=1654693686; bh=0N
	kl+ie+NN1hZrHsTv02AsiGwZS1egWPcnzrJGe0FGc=; b=Gm4/eP+x6X8RVrcqn4
	acsz8+TyOT0iphQokReJWE6lzcf2Ce7IZAxMVkX6usqkVfsONQiIX/drn3yo7zAL
	e8ZP15zjeXhmDCr6zvE8XbpHLkzixeZF5Ky5Vbr7wPchkDMKwS4wXp5cIKbSYZGy
	Go/0qyOSgyF2U8buDpVjpTBToUCY1jf7cbPrAISVm7cA2po71k03G4DYp1lk3pph
	+4UJp1PRnTPFpET7iKqgguoDGwz3svlRNyHC36psrY/9OjWpCiwu5WzIvEOvif8E
	fZESF/IsBO45e26qRn46NqKWEirnRCDbys9s4sqWBSouft8tJffmmYDeUE6xa/E/
	Wy2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1654607286; x=1654693686; bh=0Nkl+ie+NN1hZ
	rHsTv02AsiGwZS1egWPcnzrJGe0FGc=; b=g21kTlI999R8d3on+Lj323jDV2597
	yxwOVo+uSb+ukQ0U3z154vy6TOtYLSOIMGkzGQtf5m/CDjdCpWBRFzaL0AghtNzT
	jG9z8cLCXLHngx5bWN+kTN2pq2MK0PuxOIsxUpmIuoIghsyzKhL3CaG72okeqgw9
	fyw6vu+ZzgLtLXXnbYkrOLYKcDixG+D5IwP5IN6If6WJ6dmGonVC/JWtEqkpXCk2
	HNI0fXmBW+eTE8Pd06PU3AZrusoHaOxBxOh08B/AboWu9sZ+bPQrMyNRZeHyOPCB
	VK9yLRb+OrXhcf0kd21Wp3rCabqEFbIg3uUrtDpwjxSmkIpDtEA14ilBw==
X-ME-Sender: <xms:tk2fYgPpGj3gKSAqbCwmT4rBYK06LniSoFxtknFJI8ZctCaeM7xoUQ>
    <xme:tk2fYm8EiOKLTlVD8j_zid6z1WV8Z5ZOL6gBCx7FNS4lHirZeyWOu-YQzEWLH1mcr
    nhI_5HEUO2yUzy9HP0>
X-ME-Received: 
 <xmr:tk2fYnT1mffsAVPtN2fv4Xw-8YlC0F6spK1oVt-O79P4RMO8F_y5pKW9DxtaO5GCyrlGo_w>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedruddthedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffhrjgfkgggtsehttdertddtredtnecuhfhrohhmpefrrghv
    vghlucgkhhhukhhovhcuoehprghvvghlseiihhhukhhofhhfrdhnvghtqeenucggtffrrg
    htthgvrhhnpedvtdfgheeftddukeefkedvtdeiudeuhefgtedugeehueffgeevieehudej
    ledvudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hprghvvghlseiihhhukhhofhhfrdhnvght
X-ME-Proxy: <xmx:tk2fYosm5-Ia4LNbNU6e89SyhSUg8rdEmCeo77RQOhtVcFY3-iFumw>
    <xmx:tk2fYocPdJeSicbYt0DNpQdP-fieNcs9tS0RWC4inPAAX1gpmsAgPg>
    <xmx:tk2fYs2CuKVnWpUSRA5V7b4vGd-Bfoq21UDnPZ_cDf8jbYVTDXH6Zg>
    <xmx:tk2fYkFYKtMzq7kZ11ho1xiqIFmaRYcl_EhT7CVqlqubftcrHsQukQ>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jun 2022 09:08:05 -0400 (EDT)
References: 
 <f09538e33bbae7eca1ff6365492f165c2da32b0b.camel@linuxfoundation.org>
 <20220525144243.19999-1-pavel@zhukoff.net>
 <2c0eaba3e77b0313ad4d861076e52a2e51fe4656.camel@linuxfoundation.org>
User-agent: mu4e 1.6.10; emacs 28.1
From: Pavel Zhukov <pavel@zhukoff.net>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, Pavel Zhukov
 <pavel.zhukov@huawei.com>
Subject: Re: [PATCH v4] Honour BB_FETCH_PREMIRRORONLY option
Date: Tue, 07 Jun 2022 14:57:49 +0200
Reply-To: pavel@zhukoff.net
In-reply-to: 
 <2c0eaba3e77b0313ad4d861076e52a2e51fe4656.camel@linuxfoundation.org>
Message-ID: <87fskg39ln.fsf@gentoo.zhukoff.net>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jun 2022 13:08:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13734


Richard Purdie <richard.purdie@linuxfoundation.org> writes:

> On Wed, 2022-05-25 at 16:42 +0200, Pavel Zhukov wrote:
>> This should fix [Yocto 13353] and related to [Yocto 13233] as well.
>> Previously if git repo mirror has been updated in between of two builds
>> fetcher of the second build didn't try updated mirror but switched to
>> git clone from upstream instead. This is problem for offline builds.
>> Fix this to raise MirrorException if BB_FETCH_PREMIRRORONLY has been
>> specified by the mirror doesn't contain SRC_REV.
>> 
>> Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
>> ---
>>  lib/bb/fetch2/__init__.py |  2 ++
>>  lib/bb/fetch2/git.py      | 16 ++++++++++++----
>>  2 files changed, 14 insertions(+), 4 deletions(-)
>> 
>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>> index ac557176..c99cd104 100644
>> --- a/lib/bb/fetch2/__init__.py
>> +++ b/lib/bb/fetch2/__init__.py
>> @@ -1745,6 +1745,8 @@ class Fetch(object):
>>                              done = False
>>  
>>                  if premirroronly:
>> +                    if not done:
>> +                        raise FetchError("Failed to download premirror {} and BB_FETCH_PREMIRRORONLY has been set to 1.".format(self.d.getVar("PREMIRRORS")))
>>                      self.d.setVar("BB_NO_NETWORK", "1")
>>  
>>                  firsterr = None
>> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
>> index 23f8c0da..bf7c9d26 100644
>> --- a/lib/bb/fetch2/git.py
>> +++ b/lib/bb/fetch2/git.py
>> @@ -353,10 +353,18 @@ class Git(FetchMethod):
>>          if ud.shallow and os.path.exists(ud.fullshallow) and self.need_update(ud, d):
>>              ud.localpath = ud.fullshallow
>>              return
>> -        elif os.path.exists(ud.fullmirror) and not os.path.exists(ud.clonedir):
>> -            bb.utils.mkdirhier(ud.clonedir)
>> -            runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)
>> -
>> +        elif os.path.exists(ud.fullmirror) and self.need_update(ud, d):
>> +            if not os.path.exists(ud.clonedir):
>> +                bb.utils.mkdirhier(ud.clonedir)
>> +                runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)
>> +            else:
>> +                tmpdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
>> +                runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=tmpdir)
>> +                fetch_cmd = "LANG=C %s fetch -f --progress %s " % (ud.basecmd, shlex.quote(tmpdir))
>> +                runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
>> +            if self.try_premirror(ud, d) and self.need_update(ud, d):
>> +                    raise bb.fetch2.FetchError("Premirror doesn't contain revisions {} and "\
>> +                            "upstream cannot be used due to BB_FETCH_PREMIRRORONLY setting".format(ud.revisions))
>>          repourl = self._get_repo_url(ud)
>>  
>>          # If the repo still doesn't exist, fallback to cloning it
>
>
> Sorry about the delay in reviewing this, I finally ran some tests I
> wanted to run to check a couple of things. I think there are two
> changes in here and they should really be separated out. The mirror
> unpack and fetch piece in a temp directory is great and just what I
> think is needed here.
>
> The piece I worry a little more about is the raising of fetch errrors
> if premirrors are configured. The code currently disables the network
> but continues, this changes that behaviour to a hard stop.
>
> I tested with the patch below applied and things still work as expected
> so if you're ok with that, I'd like to merge this with these tweaks,
> preserving the network disabled behaviour?
I'm ok with that. However in that case *ONLY* part of the
BB_FETCH_PREMIRRORONLY doesn't make much sense for me because fetcher
will check (clone) upstream in case if revision is not in the mirror(s). This
naming inconsistence is not so important though

>
> Cheers,
>
> Richard
>
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index 9ef7fd037cc..616c67e99a0 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -1745,8 +1745,6 @@ class Fetch(object):
>                              done = False
>  
>                  if premirroronly:
> -                    if not done:
> -                        raise FetchError("Failed to download premirror {} and BB_FETCH_PREMIRRORONLY has been set to 1.".format(self.d.getVar("PREMIRRORS")))
>                      self.d.setVar("BB_NO_NETWORK", "1")
>  
>                  firsterr = None
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index bf7c9d26b5c..07b3d9a7ffe 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -362,9 +362,6 @@ class Git(FetchMethod):
>                  runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=tmpdir)
>                  fetch_cmd = "LANG=C %s fetch -f --progress %s " % (ud.basecmd, shlex.quote(tmpdir))
>                  runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
> -            if self.try_premirror(ud, d) and self.need_update(ud, d):
> -                    raise bb.fetch2.FetchError("Premirror doesn't contain revisions {} and "\
> -                            "upstream cannot be used due to BB_FETCH_PREMIRRORONLY setting".format(ud.revisions))
>          repourl = self._get_repo_url(ud)
>  
>          # If the repo still doesn't exist, fallback to cloning it
> diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
> index 56f21f8e149..7ba866520ad 100644
> --- a/bitbake/lib/bb/tests/fetch.py
> +++ b/bitbake/lib/bb/tests/fetch.py
> @@ -2883,5 +2883,5 @@ class FetchPremirroronlyLocalTest(FetcherTest):
>      def test_mirror_tarball_nonexistent(self):
>          self.d.setVar("SRCREV", "0"*40)
>          fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
> -        with self.assertRaises(bb.fetch2.FetchError):
> +        with self.assertRaises(bb.fetch2.NetworkAccess):
>              fetcher.download()


