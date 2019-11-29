Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id 1B3557F96A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Nov 2019 11:31:22 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id s14so7888273wmh.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Nov 2019 03:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=L0W5KE8a/SPyV2AQqukPoOzmXGju88+JGcjTckRhqOY=;
	b=Vr5ZIGjYg+ykt8b4gG0tkFsu1mHqzwpiJxH+25OaUT8izHFH+y/vCXfKV87e2I8kCR
	Bus3XvR7lYGa7+F+esEcEhCJngUV6vyZnlv04xWSfD2y0zFMtQaC4YltuJDGDwavu564
	rNXIo2yS6WtBhOfK2uDcyDddWD5si3dZ2RbyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=L0W5KE8a/SPyV2AQqukPoOzmXGju88+JGcjTckRhqOY=;
	b=mJkpaUUD+EtbeVwoUFiVfh4THlF5At/51Q118L2YXcF3G/O6y+pzM/PgbKrsK+cFe7
	B/EG3L/qZxGVsuc8eP8kgdTyFETWH/omNTgHJWQsZ5Co/e5HdTboHnr5BsQcnOb45T1B
	fqNMKASWKA3sAfX44SR6zoKCa3I5RpxtQQddU+AabMJc6Z8yzeeCt9z7QBiE/R/jF0zJ
	DlWKKVsYKQQ0sRI67Gug/QpWTNfa0POQkpYja+XmXZJhrmYRcODngEb0+IuoT5kDM1+s
	Ph4kLA9tQat7IMlKHuUqK4haPM0Z3Yxe3nMGnNwOZWC1PobvAx5Q4+EgZ+uXn4NfeWX4
	2MUQ==
X-Gm-Message-State: APjAAAWHQe8Mg5q14wSloU+rJ6mq/rX+UUMiaPdaUyk4cyRNQgSwc7sM
	d0HeDFdgA31fuS+6GfHTPcM+9g==
X-Google-Smtp-Source: APXvYqwigVxQaXY1LTKIh6OdozNH/Okbz/jT/U1Sk++/rOEbbFH+2oZXx7JZIVIKqdkSaqlX6DnzDQ==
X-Received: by 2002:a1c:4b0d:: with SMTP id y13mr8742283wma.134.1575027082726; 
	Fri, 29 Nov 2019 03:31:22 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id t1sm4903878wma.43.2019.11.29.03.31.20
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 29 Nov 2019 03:31:22 -0800 (PST)
Message-ID: <b3042ab0f605c20e45ed90bfe77659969bbd91f8.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Kang Kai <Kai.Kang@windriver.com>, bitbake-devel@lists.openembedded.org
Date: Fri, 29 Nov 2019 11:31:19 +0000
In-Reply-To: <8d9471d6-9b96-a0ed-91fe-84faa7ced515@windriver.com>
References: <20191128092718.13336-1-kai.kang@windriver.com>
	<140ccb87e6820c4daea903644f43b178a8541a26.camel@linuxfoundation.org>
	<8d9471d6-9b96-a0ed-91fe-84faa7ced515@windriver.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH] runqueue: add mc to pending hash index
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
X-List-Received-Date: Fri, 29 Nov 2019 11:31:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2019-11-29 at 09:11 +0800, Kang Kai wrote:
> On 2019/11/29 上午1:51, Richard Purdie wrote:
> > On Thu, 2019-11-28 at 17:27 +0800, kai.kang@windriver.com wrote:
> > > From: Kai Kang <kai.kang@windriver.com>
> > > 
> > > When build multiconfig target by following steps in section
> > > "Enabling
> > > Multiple Configuration Build Dependencies" in yocto dev-manual
> > > which
> > > adds dependency between multiconfig targets:
> > > 
> > > do_image[mcdepends] = "mc:x86:arm:core-image-minimal:do_rootfs"
> > > 
> > > it shows a lot of warnings, such as:
> > > 
> > > > WARNING: Deferring
> > > >    mc:x86:virtual:native:/path/to/meta/recipes-
> > > > support/nss/nss_3.45.bb:do_populate_sysroot
> > > >    after
> > > >    mc:arm:virtual:native:/path/to/meta/recipes-
> > > > support/nss/nss_3.45.bb:do_populate_sysroot
> > > In function pending_hash_index it only checks PN, taskname and
> > > hash.
> > > But
> > > they are same for multiconfig native and allarch packages. Add
> > > multiconfig
> > > to pending hash index too to make the index unique.
> > > 
> > > Ref:
> > > https://www.yoctoproject.org/docs/latest/dev-manual/dev-manual.html#dev-enabling-multiple-configuration-build-dependencies
> > > 
> > > Signed-off-by: Kai Kang <kai.kang@windriver.com>
> > This patch completes defeats the point of this code, disabling it.
> > Its
> > the wrong thing to do, we want this code to be active.
> > 
> > The bug is that this should not be a warning, probably just a note.
> > 
> > We need it to be a note so that we can tell the mechanism is in
> > action
> > from build output logs.
> 
> I have sent a patch to change from warning to note. But without 
> comment,  I thought it should be fixed in this function.
> Would you like to review the patch "runqueue.py: not show warning
> for 
> deferred multiconfig task" on Oct 17, please?

I thought I'd seen a proper fix!

That patch is correct, not sure why it wasn't merged but I'd thought it
should be. Its merged now, thanks.

Cheers,

Richard


