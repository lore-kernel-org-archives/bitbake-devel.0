Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E60C433F5
	for <webhook@archiver.kernel.org>; Mon, 16 May 2022 14:21:51 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by mx.groups.io with SMTP id smtpd.web09.29606.1652710904467069430
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 May 2022 07:21:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm1
 header.b=oz1GGoW8;
 spf=pass (domain: zhukoff.net, ip: 66.111.4.26, mailfrom: pavel@zhukoff.net)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 5884B5C017E;
	Mon, 16 May 2022 10:21:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 16 May 2022 10:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1652710903; x=1652797303; bh=NN
	6ooDDqIIh6l5S4NgeU8UfwqXQY6YOew0lF2v472Ss=; b=oz1GGoW8cuRrope8El
	gKLTKQmsKBKKrtw8xw45eZ53y7I4Az+myks3BIPPoqPO76T6R8YYk+pvO8ovBAeF
	pY+Q2vDa4sE6wp1UpunZQRz9SlskdFY+PJURnROZvBxr9qeB8xsJjn3HdL3keXnQ
	ibIa4eeLI9i/EWWKwvn9bS/qUwqYTknWO5lfEZkIxQXWvqAQT04sQu4QDckrYXWD
	26s24OJ89lijlsfGYscE6e1vrv2nJ1qahCW7vnZ2wq0nDkm5VxcuIhVofydnMeNs
	D4XtJiu1s/Bw0Rk7Y/9ZvUAgQSbTKduXw8qdQ0x1vSW6HQQbABKL8tukSn1bJ4YJ
	S4Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1652710903; x=1652797303; bh=NN6ooDDqIIh6l5S4NgeU8UfwqXQY6YOew0l
	F2v472Ss=; b=qT7dxl9zZxxJceFR04PRKSeNfNhbtjbCxABFX4l7ft1qd3gz33w
	V6rLYRobQeR6k3XSxzpIoCJvHR8PJAEBosXqWnKZEROmtnk8j/GomGiictw7fCgG
	luCv5w03Jk7evwyMDCudEM/aE9Mmcrgh54/J6Pc/gK82d2MAsODnFIhcIqQZe8a5
	spkXG7qAY/GJLXPBniAcvFv0W0PUnqykmA11hr7cJ04lbxni5PEyF8j1a2tt8Kzp
	o6m9kX1gCZDJdMtmUk5mCegKykpWdq8X+71JI+lsXImmIZshpvUsck/YqzKYkZ7e
	NL4PCptSKgt4fVF1MphWIpM0q8c5LPRjmDg==
X-ME-Sender: <xms:912CYqb4E8RM804jmH1Y4TCKovkEMqTBQD81NJLD5cmxOPBUjHFOqA>
    <xme:912CYtYe5OJIazxTa2kRup38Qp_cGyokZF3p0nsMIUKCWeHxjb5kHFXHcQFyJHz9b
    6YZxD34noyyEWfrqh8>
X-ME-Received: 
 <xmr:912CYk-9fYe4_d_mmHjVGK5wbRT4twx_CMT9ZFD5kDonApC6RDj7xnQDDYAXYN8ZWKinbXQ>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedrheehgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpehffgfhvfevufffrhgjkfggtgesthdtredttdertdenucfhrhhomheprfgrvhgv
    lhcukghhuhhkohhvuceophgrvhgvlhesiihhuhhkohhffhdrnhgvtheqnecuggftrfgrth
    htvghrnhepjeekudeiieehleejgeeiueetveekhffggeelueelhfdvgeefveeiudfhffeh
    tddvnecuffhomhgrihhnpehophgvnhgvmhgsvgguuggvugdrohhrghdpuhhtihhlshdrth
    honecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgr
    vhgvlhesiihhuhhkohhffhdrnhgvth
X-ME-Proxy: <xmx:912CYsoAVvQ9KSBHIldmE9iTNBqu72C6KSlqqUo1quyDRancvmKRdg>
    <xmx:912CYlqWz2_YiB2GUk-Q51MdH62kff8ly86JKDzvC8xxjVgF7MTm0w>
    <xmx:912CYqR8VkQKql_iTVkZ9QjMDUj-o71FgG97PAb86U-akermWolYDg>
    <xmx:912CYmCbHJj_wLCD6Uv0oprahqLsXTwTkIUzhRfkWUYWCAomrNM4tA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 May 2022 10:21:42 -0400 (EDT)
References: <20220506141733.3298-1-pavel@zhukoff.net>
 <16EE7864A573C566.16097@lists.openembedded.org>
 <f09538e33bbae7eca1ff6365492f165c2da32b0b.camel@linuxfoundation.org>
User-agent: mu4e 1.6.10; emacs 28.1
From: Pavel Zhukov <pavel@zhukoff.net>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Pavel Zhukov <pavel.zhukov@huawei.com>,
 bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v3 1/3] Honour BB_FETCH_PREMIRRORONLY
 option
Date: Mon, 16 May 2022 12:55:46 +0200
Reply-To: pavel@zhukoff.net
In-reply-to: 
 <f09538e33bbae7eca1ff6365492f165c2da32b0b.camel@linuxfoundation.org>
Message-ID: <87y1z136f0.fsf@gentoo.zhukoff.net>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 May 2022 14:21:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13703


"Richard Purdie" <richard.purdie@linuxfoundation.org> writes:

> On Thu, 2022-05-12 at 22:21 +0100, Richard Purdie via
> lists.openembedded.org wrote:
>> On Fri, 2022-05-06 at 16:17 +0200, Pavel Zhukov wrote:
>> > This should fix [Yocto 13353] and related to [Yocto 13233] as well.
>> > Previously if git repo mirror has been updated in between of two builds
>> > fetcher of the second build didn't try updated mirror but switched to
>> > git clone from upstream instead. This is problem for offline builds.
>> > Fix this to raise MirrorException if BB_FETCH_PREMIRRORONLY has been
>> > specified by the mirror doesn't contain SRC_REV.
>> > 
>> > Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
>> > ---
>> >  lib/bb/fetch2/__init__.py | 2 ++
>> >  lib/bb/fetch2/git.py      | 6 ++++--
>> >  2 files changed, 6 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>> > index ac557176..c99cd104 100644
>> > --- a/lib/bb/fetch2/__init__.py
>> > +++ b/lib/bb/fetch2/__init__.py
>> > @@ -1745,6 +1745,8 @@ class Fetch(object):
>> >                              done = False
>> >  
>> >                  if premirroronly:
>> > +                    if not done:
>> > +                        raise FetchError("Failed to download premirror {} and BB_FETCH_PREMIRRORONLY has been set to 1.".format(self.d.getVar("PREMIRRORS")))
>> >                      self.d.setVar("BB_NO_NETWORK", "1")
>> >  
>> >                  firsterr = None
>> > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
>> > index bdcfa497..e556f297 100644
>> > --- a/lib/bb/fetch2/git.py
>> > +++ b/lib/bb/fetch2/git.py
>> > @@ -353,10 +353,12 @@ class Git(FetchMethod):
>> >          if ud.shallow and os.path.exists(ud.fullshallow) and self.need_update(ud, d):
>> >              ud.localpath = ud.fullshallow
>> >              return
>> > -        elif os.path.exists(ud.fullmirror) and not os.path.exists(ud.clonedir):
>> > +        if os.path.exists(ud.fullmirror) and self.try_premirror(ud, d) and self.need_update(ud, d):
>> >              bb.utils.mkdirhier(ud.clonedir)
>> >              runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)
>> > -
>> > +            if self.need_update(ud, d) and bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")):
>> > +                    raise bb.fetch2.FetchError("Premirror doesn't contain revisions {} and "\
>> > +                            "upstream cannot be used due to BB_FETCH_PREMIRRORONLY setting".format(ud.revisions))
>> >          repourl = self._get_repo_url(ud)
>> > 
>> 
>> Thanks for this series, it is a long standing issue we need to fix.
>> Sorry for the delayed reply, I've had to think about this for while. I
>> think your patch is mostly correct. What I'm worried about is the
>> fetchers having premirror knowledge, that was intended to say inside
>> __init__.py in the fetcher.
>> 
>> I think there is a better way for the git fetcher to behave. It tries
>> hard to preserve clonedir if it already exists but in the premirror
>> case it will remove it.
>> 
>> This does lead me to one concern with the patch as it stands which is
>> that if clonedir already exists and we untar ud.fullmirror over the top
>> of it, the mix of existing and new files may be toxic (e.g. expanded
>> refs and packed-refs being mixed). At the very least we need a delete
>> in there.
>> 
>> I think what it should do is untar ud.fullmirror to a temp directory,
>> then replace clonedir if this looks "better" than clonedir, else if
>> just deletes the temp directory.
>> 
>> I think that way we can remove a lot of the twisted logic and simplify
>> things. Would you agree and is that something you could look at?
>
> I realised I wasn't clear. I've never liked deleting clonedir since
> this has the potential to lose data. The pathalogical case is where we
> screw up a revision of linux-yocto, it gets deleted as bitbake can't
> find the revision and then the user has to download the whole thing
> again.
>
> I mentioned deletion above but I've realised we could clone into
> clonedir from the temp dir, thereby removing the risk other revisions
> were removed from the repo too. That would seem to be the best way to
> handle this to mitigate the most issues.
>
> Cheers,
>
> Richard
>
Thank you for the review. While addressing review comments I've found
one more bug related to this patch which can be fixed by fetching from
the fullmirror instead of overwriting it. Looking into it.

-- Pavel
>
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13700): https://lists.openembedded.org/g/bitbake-devel/message/13700
> Mute This Topic: https://lists.openembedded.org/mt/90934195/6390638
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [pavel@zhukoff.net]
> -=-=-=-=-=-=-=-=-=-=-=-


