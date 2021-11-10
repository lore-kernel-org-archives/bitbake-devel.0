Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD74AC433EF
	for <webhook@archiver.kernel.org>; Wed, 10 Nov 2021 16:33:21 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web08.548.1636562000872896668
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Nov 2021 08:33:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iRoaB2Pz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id r8so5020314wra.7
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Nov 2021 08:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=IaLcBwSUIF3+BYtngNWVL+RRrkq8kbtLcDfRYzuAoqg=;
        b=iRoaB2Pzvvj88CSvsdrTONLUolcd9+UM/giID0fPSyv52Xbv3nz9R/eFy2XXcgVJcG
         cannsov77+Pe5Oa89sbEq6477BdvyDq7aEoavz7TEeahOsGas9h3FxS4O+ca+a8fHwoL
         EnB73mLDvsfbqVxofRTvLi4AR1swv4F3qKo2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IaLcBwSUIF3+BYtngNWVL+RRrkq8kbtLcDfRYzuAoqg=;
        b=q6Qkg//aXBhZFsVvZcf5oNUOPEEGLmfx21LuYo9PU7LplKSgGeqThcoOOZ3HSM8oJD
         F/cB1u8DBm1+c9k0fKYxKUzk9rDswdoAH+BOGcDM4INd7xW+3UH8Ubgrvi/1q6iI7XMv
         cfPI7zb+whAaEezvtSeKDPiC9CyFiyEQH3dfL2iz1KP/u5zctzA4Vv9vYiLDiuAlIVP3
         Mw7q5MdEOc3RNZ/Nofmzy5NyDN0qdLSVSQjC3O52skZrMU3svFNZQ6IxWZEDNfmwJtXx
         Nqs4BPS8oz40HD0YbjvklF1uEVxq1528IyNK5G09ervcUms/pnIFp81Df6zoHlU9pKgw
         zMzw==
X-Gm-Message-State: AOAM533FSpiDVixxMTWum81Qx55hfElbx97Dk5wo1UQqtKh1ZbpbWUSo
	BjR+ML4bKAhQ8PgSnXVkeEjMoA==
X-Google-Smtp-Source: 
 ABdhPJxhO8b+sM4o1Ja5GreIcyxSeFOdQA8QnVEB3va8655+SS7XRZ7gnpH6Nm5unGH7BYVaawaUvA==
X-Received: by 2002:adf:ce0e:: with SMTP id p14mr304673wrn.423.1636561999039;
        Wed, 10 Nov 2021 08:33:19 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:ac1:e64:a6c2:6c7d?
 ([2001:8b0:aba:5f3c:ac1:e64:a6c2:6c7d])
        by smtp.gmail.com with ESMTPSA id
 c11sm385191wmq.27.2021.11.10.08.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 08:33:18 -0800 (PST)
Message-ID: 
 <b8b2081df6de0e8eb0caaf0bb93cb2c337d885c2.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe
 for repo 2.17.3
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
	"openembedded-core@lists.openembedded.org"
	 <openembedded-core@lists.openembedded.org>, "kweihmann@outlook.com"
	 <kweihmann@outlook.com>, "jasper@fancydomain.eu" <jasper@fancydomain.eu>
Cc: "martin@mko.dev" <martin@mko.dev>, "Daniel.Baumgart@iris-sensing.net"
	 <Daniel.Baumgart@iris-sensing.net>, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Wed, 10 Nov 2021 16:33:16 +0000
In-Reply-To: <d36258228dd2fb0dc2fdb88ddab9a117fa1454db.camel@iris-sensing.com>
References: <20211105133104.19895-1-jasper@fancydomain.eu>
	 <AM9PR09MB4642AA3727D430C698E95EE5A88E9@AM9PR09MB4642.eurprd09.prod.outlook.com>
	 <b8897c8a436f384ef0a41d708816c2f61f9e22c7.camel@iris-sensing.com>
	 <d87ff011218f55d97e5aa48ff9b06d216f6d477a.camel@iris-sensing.com>
	 <029d18fa589265e32476c7cc45c9977f7b4bb9aa.camel@linuxfoundation.org>
	 <3101a847508371b09b2949434f9ca09c672a7097.camel@iris-sensing.com>
	 <f815b01f00eb3271ea947442cd6837fa27cefb3f.camel@linuxfoundation.org>
	 <d36258228dd2fb0dc2fdb88ddab9a117fa1454db.camel@iris-sensing.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Nov 2021 16:33:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12993

On Wed, 2021-11-10 at 13:52 +0000, Jasper Orschulko wrote:
> Hi Richard,
> 
> > When you say "fixed refspec", will that be a definitive sha revision
> > or a tag?
> > We always force resolution of tags as they tend to cause problems and
> > can change even if it is bad form.
> 
> that's a good point. Actually, Martin and I have just been discussing
> this, as we noticed that this point actually got "lost" during our
> implementation. We are currently working on fixing this. Good to know
> how you handle this. I will keep you posted.

Ok, it is good to be clear on that one. I know the fact we hit the network for
tags does concern some but it really is the only way to handle them.

> > This is potentially a big issue. Cloning operations during parsing is
> > pretty
> > horrible. We'd not expect any thing being written out like that
> > during a parse.
> > It would probably work "ok" for one recipe but if you start getting
> > the hundreds
> > of git recipes we have in some layers, it wouldn't scale if we
> > allowed that :(.
> > 
> > Not sure what to recommend here but it is definitely problematic.
> 
> Just to make sure that we are on the same page: This ONLY affects
> recipes which use the repo fetcher. And it ONLY clones the repository
> containing the repo manifest (which tend to be small in size).

Correct, we are on the same page. This is still quite problematic as the recipes
are meant to parse quickly and a repository clone is definitely not expected.

> So unless developers start using hundreds of repo-based recipes, which I
> find a very unlikely scenario, this should not be an issue.

Even ten recipes using this will show a degradation in parsing speed and I do
get a lot of complaints when parsing slows down for any reason. The user doesn't
expect this and it won't be visible what bitbake is doing (sitting at 99% parsed
for a period).

Also, the "tend to be small" implies someone will create a huge one at some
point even if that is a bad idea for whatever reasons, I just know how these
things end up going :(.

> Unfortunately, I don't see any other way to access the repo manifest
> file, as we need to calculate the commit hashes of the git repos
> referenced in the repo manifest file. Otherwise, it is impossible for
> us to determinate the necessity of an update when SRCREV =
> "${AUTOREV}". 

Some further questions:

* Does it only clone a repo in the AUTOREV case?
* Could it only obtain the manifest file somehow without a clone of the repo?

> However, I see one potential improvement here. Currently the cloning of
> the manifest repo is done on a per-recipe basis. E.g. this means if we
> have 10 recipes inheriting a bbclass containing a repo fetcher, we will
> clone 10 identical manifest repos. We'll work on improving this.

At least for wget or git, it is assumed that for a given url, there would be one
tarball/clone and that there is locking in place to share it between them. This
means you'll see do_fetch tasks for binutils, binutils-cross-XXX, nativesdk-
binutils and binutils-native and one will block the others but the fetch will
happen once and be shared between them. I guess with repo it may not be as
simple as that but we should try and share what we can if possible.

Cheers,

Richard



