Received: from sender4-op-o13.zoho.com (sender4-op-o13.zoho.com [136.143.188.13])
 by mx.groups.io with SMTP id smtpd.web11.36263.1631022625911105348
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Sep 2021 06:50:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=dwrobel@ertelnet.rybnik.pl header.s=ertelnet header.b=WNf93oJN;
 spf=pass (domain: ertelnet.rybnik.pl, ip: 136.143.188.13, mailfrom: dwrobel@ertelnet.rybnik.pl)
ARC-Seal: i=1; a=rsa-sha256; t=1631022621; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I5gNonsVHGnkS1NKuZk2mG5e+q3Ia738KjA5TFhmaDdGb9NyumFeUWSNvnxAEA306mWAnoeL6JEqRbkAdbQat37dl9Ob8ik+4FfbyKXZF84YtQbVMEumTuJpouHb44OL0E62hyNn54ocSTqj5iMVmE58fUEx5fpwQTF68BM634g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1631022621; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=MuXbar+xVIqhMi3RxM7tXoFIL6waTD7looRn05wWhRc=; 
	b=Aq3WMccaOawQbjNS6HSxLnHDE05te4ivb6djG3KwyXIL1KmopWPYvpceLnqvvndEcaGZNK8QnJ4wf8hFBVhaTfbnEUKYKdUHsHQPSVWrxvWRhyVBLCZ8i4/noRxnvnEvFubEtKUndNP1SDr0LpyJnToznbV4KFtyL6MkMItAD+Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ertelnet.rybnik.pl;
	spf=pass  smtp.mailfrom=dwrobel@ertelnet.rybnik.pl;
	dmarc=pass header.from=<dwrobel@ertelnet.rybnik.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1631022621;
	s=ertelnet; d=ertelnet.rybnik.pl; i=dwrobel@ertelnet.rybnik.pl;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MuXbar+xVIqhMi3RxM7tXoFIL6waTD7looRn05wWhRc=;
	b=WNf93oJN2GLMo3dilSQuWUiLWQILBD91aPgG0rmnzmFzjsgHOVSkf3+w1dBKZHU5
	jB6fmW61j65i7/YR4IgJDwn6EOmxiZbnUO12mq95UZLFLF1MGqC58RtULvJaw56stio
	Ecvsxlh7e9yu+tP8IAuwf5lMtlhaLFQSU4DAsln0=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1631022620667816.7904140456703; Tue, 7 Sep 2021 06:50:20 -0700 (PDT)
Date: Tue, 07 Sep 2021 15:50:20 +0200
From: "Damian Wrobel" <dwrobel@ertelnet.rybnik.pl>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel" <bitbake-devel@lists.openembedded.org>
Message-ID: <17bc0861fe8.10265a7ec273381.5356961515124934870@ertelnet.rybnik.pl>
In-Reply-To: <3ac3e69e0b3d7f0cbb25da58c450411b466259a7.camel@linuxfoundation.org>
References: <209f7a813b8003ad75e5edb9600f729a91abee7b.camel@linuxfoundation.org>
	 <3199.1631004870582679813@lists.openembedded.org> <3ac3e69e0b3d7f0cbb25da58c450411b466259a7.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] cooker: Only warn on potentially incompatible layer
MIME-Version: 1.0
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit




 ---- On Tue, 07 Sep 2021 13:40:07 +0200 Richard Purdie <richard.purdie@linuxfoundation.org> wrote ----
 > On Tue, 2021-09-07 at 01:54 -0700, Damian Wrobel wrote:
 > > On Sat, Sep 4, 2021 at 09:54 AM, Richard Purdie wrote:
 > > > Adding a single keyword every six months to show the layer is active and
 > > > meant
 > > > to work with a new release is not in my view a huge maintenance burden
 > > > compared
 > > > to showing that the layer is actively maintained and clearly showing which
 > > > combinations are meant to work.
 > >
 > > It's not feasible because if the layer required some extra bbclasses cherry-
 > > picked to be support it in the older yocto, then no one can simply add this
 > > keyword to mark it's supported with older yocto.
 > 
 > I don't understand your example here. If you can cherry-pick changes into a
 > layer, you can also add a patch to mark the layer as supported using the
 > standard variables?

Let's consider the following example:

a) meta-layer-which-we-want-to-consume (contains: LAYERSERIES_COMPAT_clang-layer = "gatesgarth hardknott")
b) openembedded-core
c) bitbake
d) meta-our-layer

By saying that layer (a) required some extra bbclasses to be cherry-picked I meant that
in order to use layer (a) we had to cherry-pick some extra bbclasses or other changes
into (d) to get (a) working with (b) and (c).

This worked for us when (b), (c) and (d) were on yocto morty, but stopped to work when
we switched to dunfell because dunfell started to utilize LAYERSERIES_COMPAT.

This is very common situation that nothing needs to be modified in (a) to get it working with different versions
of (b) and (c).

So the question is why we have to modify also (a) to make (c) happy?

--
Regards,
Damian

 > 
 > > This in practise means that despite the layer itself didn't require any
 > > changes to be supported in older yocto it will be unconditionally rejected by
 > > bitbake.
 > 
 > Your previous sentence says "the layer required some extra bbclasses" so it did
 > need changes?
 > 
 > > So, in reality it mean that such a layer has to be forked and modified to be
 > > accepted by bitbake.
 > > 
 > > I hope this clearly shows why this kind of checking in bitbake is
 > > inappropriate.
 > 
 > I'm afraid I don't understand your example.
 > 
 > Cheers,
 > 
 > Richard
 > 
 > 
