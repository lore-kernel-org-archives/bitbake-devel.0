Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C997ACD5BD1
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 09:27:24 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24662.1780306037459362330
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2026 02:27:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=blze6gfv;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49068493267so54166575e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780306036; x=1780910836; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxzSubDay7Kds0lOItvbTMTGBQvlyfEHKV0ChHhacg0=;
        b=blze6gfvLIVT37Ax1VwSyKvHW/XLNnmC9Urgf1bm71JTpLbv+2/CKgujI9M3iYZxkN
         s96ucUZgURb0WZgf41HP8vIZxA6WSVg/7ZbOIpJRwtQNQOtbUUdqiheXP4TXiNTLky/6
         ItsXJOM2EgQKkXhIUlAFVWqrHOdMZ6eWGdhPdFQ5GNZIVBNmTSSSuzxKrodXAzZIj6Qz
         ATEycs/k58jwJxx6m5V8kWFDf6K7oU1aTAep5cGnIbe34w6WjInP+sH65xrbvpNFQ5+2
         J2FggR9VL6To5JPik8EZDOwQ+MLaXZNtwxfRFfRhjhwPlJ8wczBlAVQGnQT/GK1XCOPv
         HZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780306036; x=1780910836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxzSubDay7Kds0lOItvbTMTGBQvlyfEHKV0ChHhacg0=;
        b=OGHgmfu/q2BNVkEDB1uGi2Ik/PClv1pK34NL1LnUrYrou4L33e+gzvzihEzyiquqhx
         e66fM+IMTX73dTMSmWmcYUHkpGpNSujQ3Yf0S+k1F99D8rf00/6OMOLD7GSYvgD+5EX4
         drL4S/diAkaklFzwoTZZikSrHRPNhLdS8HgBwJ4YD9egWc6OeMAedCA9nzkLnPf2ZvHO
         psuzAuNNoTOkmyfhA+64PZD67UlyKsP2xGSbIBfrkLJobLJSKJwnpBj7r0o2HvkZqBVU
         rYepgopd0AnIZ0LVpWFeJakwM84XntSExcFl7pBTDVyKowUJdkEgoCFCkTHYyns3wiPJ
         wtqA==
X-Gm-Message-State: AOJu0YzehhHOCYEP8wSGtBEvtAawptYyYVIAlpJMSwYlaFgvvGKFVvXd
	Oq89Sfe7/JwaVdSh3Ea5p1UzyeS6SU+tWkXBd93hxlVael1za5Xv9NOV
X-Gm-Gg: Acq92OF0VQ1dxvK9Yed5DndWdLAXdXjopyU9f33KrMZU3gGZLpjSLdULv7TeAuz1NEx
	GyqbEEOpz914KVP7K++AKWvM3W4oIAKkOSECqUwpdUDohrYIjh4jG22NDiQBqIjpnIxjgUh6UwY
	luxmbqVjpKsU+0X0IqKufgTZ0IPbZO3NiKbp8p6Ozatr3R3Xjn92MbtNQedz21qPXCiplXUQBwi
	hBCNHIyZKnQJT07cU/mWb9F3ZLVzYCOc4TDyXGdOlMm7Q8eNzUgK0HQD9Wy6E+6hLQ4+jeSD3TH
	zG2zRrNTdIpiRQb/Guo/ePg/5RIqI5ngnsI+E41oi1IHn9piZboFW6E7cEJc+pgomyt4QEJaRtX
	4ucZCtCf79S1poXn02tvz+wXli2T710prUNZyaR6+2wC2BV+RK5dfwk4n3zv1ZI2wf/zkFf342n
	fFuLKrwDQGPOPR7joilLER9xhuUW6eCdj7FdSiN0Wf6WvLAfD+Lb4xmn0UXl/iHRgCL3D/fxcGC
	/ud17e86fNCsov7nk2k9sKI80GXErJcTtsozA==
X-Received: by 2002:a05:600c:8a0a:20b0:48f:da34:ec4e with SMTP id 5b1f17b1804b1-490a29303aemr134977505e9.19.1780306035451;
        Mon, 01 Jun 2026 02:27:15 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0ec5f8sm102459475e9.3.2026.06.01.02.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:27:14 -0700 (PDT)
Date: Mon, 1 Jun 2026 11:27:14 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-setup: support default
 source overrides
Message-ID: <qmofjhb5u4v5wk65l63keskbrovplczo6lpdh3fh7l42ixxrlf@toxw7lriwyik>
References: <20260529-bb-setup-override-improvements-v1-0-91db62e0149e@toradex.com>
 <20260529-bb-setup-override-improvements-v1-2-91db62e0149e@toradex.com>
 <CANNYZj9FxhgKEfBu0M=1o7pc3RYZ67XdcpOyr5dEKTpmTAWYYg@mail.gmail.com>
 <tgfbutopbavkq6ehs2g62lkfpw7guzyfpucg46lj2p2j534f2b@aaiam4e7b4xf>
 <CANNYZj-i+koZijvYCjCq74P+ArUW7Aq9kcpJ5j_afCyXKJyDow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANNYZj-i+koZijvYCjCq74P+ArUW7Aq9kcpJ5j_afCyXKJyDow@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 09:27:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19580

On Fri, May 29, 2026 at 06:40:04PM +0200, Alexander Kanavin wrote:
> On Fri, 29 May 2026 at 18:06, Ernest Van Hoecke
> <ernestvanhoecke@gmail.com> wrote:
> 
> > Thanks for your feedback, I understand your concern and was not sure how
> > to go about it for that reason.
> >
> > Yes, that's exactly the issue I'm facing. We would like to have a "dev"
> > and "release" setup. My current idea was to have the "dev" setup be the
> > default, with all revisions pointing to master/tip of the branch and use
> > source-overrides to create a "release" without relying on users to pass
> > it correctly.
> >
> > If users have to pass it on the CLI, it also creates an awkward
> > bootstrapping where they first have to check out our registry locally
> > before setting up the release build.
> >
> > And if revisions are tightly specified in the main conf.json, it's also
> > less straight forward to update it with the current fixed-revisions
> > system.
> 
> The overrides system was added for a different use case. We wanted to
> support CI systems which need to set up a build from something like a
> pull request, where one of the layers needs to come from a developer's
> branch, but everything else should remain standard. Another use case,
> added a bit later, was to write out fixed revisions override, so that
> a build that was set up from a floating revision config, could be
> reproduced exactly with specific revisions that were resolved at that
> point.

Thanks for the background info. I really liked the idea of using these
fixed revisions to then generate a "release", but maybe I've approached
the design problem from the wrong side. I could switch things around and
have fixed hashes in the main configuration, and have CI update those to
keep everything contained in one file, that can certainly be cleaner.

The drawback to me is that this "update"/"release" action moves outside
of bitbake-setup, but now that I think about it more, I can see how
separating that responsibility might be beneficial and indeed it should
be an easy Python/jq/.. job.
 
> I agree that supporting multiple sets of sources would be useful,
> perhaps you could look into adding a "sources-overrides" section into
> the json, which would contain multiple sets of overrides (e.g. 'dev',
> 'release', 'oldrelease'), and then the UI would allow selecting one
> interactively or through command line? Unfortunately 'sources' itself
> can't be extended like that.
> 
> Alex
> 

That's an interesting idea to go along with the above. We could keep
pinned "release" revisions, and then have "dev" move them back to a
branch tip. Not entirely sure it's worth the implementation effort since
it's less of a problem to have to remember passing overrides for a dev
setup than it is for a release, but I'd certainly prefer it to be
specified in the .conf.json instead of the CLI.

Thanks for your input, will have a think on our next steps. Probably
I'll have our tooling fill in the fixed revisions into the main
.conf.json.

Kind regards,
Ernest

