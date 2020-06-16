Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web12.2135.1592333296610950171
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2020 11:48:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YfdMmUY1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f65.google.com with SMTP id r7so21888520wro.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2020 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=oX5tFYkqB8nzlyEORjzfbw8SFFKBrqtEsgFdn1cjDOk=;
        b=YfdMmUY14lCLx6NriQaZquKe4bcMqEdf1rRVXE4poxltgvxlz9QiDC35esfhth2QBt
         zcuBU1axIIdXtu9fvJSy8HrpOMM3H3YmqDgjb12zcJvnn1vs6caZOobBJF9wO4lRbUW2
         TgZZ4ocuJXnilNzzFxB8jRkbcEc+57ALjoIrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oX5tFYkqB8nzlyEORjzfbw8SFFKBrqtEsgFdn1cjDOk=;
        b=Z5spzsK0AsVZOqAecL/V9295ziB6y7VafLTi/NK+eOiU32cCq039r58Jc63K7/xLZB
         7gH8VK+GJaJK66qHhR6K55kSA1dE2ZyIeiwNihnB87FoZnZFQOopdVM07tAlrgOjikAE
         U5JBAmhs4iwFBipU68MC11HT09yw/Bqb4ga7G7mAL/ix6BrB/qhobvrpNAv3JyMWka19
         v2U9VadWbrWJdNBXTDhxpLzBbFqYGXM2WlSmYfyT1rJG5duDeKyfGXIVYRmeaLpVFb8w
         4SJF8gJIAdzRnwv6koNU2/jbAtK6x6IPGwVqTF0LqH8DkHm7p9gXm3f7mBSbtukstXvG
         FwyQ==
X-Gm-Message-State: AOAM530EtQL+OJonMB1cSWbJ8onjGLbmQsWcgLA0uIzWYzsDUMAfnLW2
	ZoF6/wl3V1LiR1t7S0MibF3CJQ==
X-Google-Smtp-Source: ABdhPJzbB1ozYGG66sqXFM3S2xPQ+6W2On4IjaplE23V1kzYn9a9a/P5ZDlvM+RnYlVAhHrY6gdeLw==
X-Received: by 2002:adf:e44c:: with SMTP id t12mr4286550wrm.181.1592333295074;
        Tue, 16 Jun 2020 11:48:15 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id a3sm5063031wmb.7.2020.06.16.11.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:48:14 -0700 (PDT)
Message-ID: <7f41ff1c938ef998c4e5d67ac07642b8ebb324c4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] lib/bb/utils.py: Do not preserve TERM in the environment
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Jacob Kroon <jacob.kroon@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 16 Jun 2020 19:48:13 +0100
In-Reply-To: <b748351a-7330-50d0-86b3-890b3ec28570@gmail.com>
References: <20200615122231.1325750-1-jacob.kroon@gmail.com>
	 <2677ce4ecd89cb99e7bd491a68be93908023c87b.camel@linuxfoundation.org>
	 <b748351a-7330-50d0-86b3-890b3ec28570@gmail.com>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-06-16 at 10:14 +0200, Jacob Kroon wrote:
> On 6/15/20 2:29 PM, Richard Purdie wrote:
> > On Mon, 2020-06-15 at 14:22 +0200, Jacob Kroon wrote:
> > > The value of TERM is leaking into OE-Core postinst-useradd-${PN}
> > > scripts,
> > > which in turn can optionally be monitored by buildhistory. Prune
> > > the
> > > value in
> > > order to make the OE-Core buildhistory output more deterministic.
> > > 
> > > Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
> > > ---
> > >   lib/bb/utils.py | 1 -
> > >   1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> > > index 5f5767c1..50032e50 100644
> > > --- a/lib/bb/utils.py
> > > +++ b/lib/bb/utils.py
> > > @@ -580,7 +580,6 @@ def preserved_envvars_exported():
> > >           'PATH',
> > >           'PWD',
> > >           'SHELL',
> > > -        'TERM',
> > >           'USER',
> > >           'LC_ALL',
> > >           'BBSERVER',
> > 
> > When you send a patch like this, please be clear that its for
> > testing.
> > I know from a discussion on IRC that this patch needs close vetting
> > to
> > see if its "safe" and its likely going to break things around the
> > menuconfig tasks for example. The patch needs to state that so
> > people's
> > expectations are right.
> > 
> 
> Right, I should have been more upfront with that in the patch.
> Should that go in the commit message itself, after the '---', or just
> a prefix in the email header ?

After the --- would be fine. Its just so everyone has the right
expectations about the patch.

> I understand TERM must be used for *something*, I've just never 
> understood in what ways exactly. Is it for allowing 
> screen/tmux/xterm/your-favourite-terminal to do extra fancy things ?
> 
> At a first glance I can't see anything breaking the kernels
> menuconfig, 
> and in a devshell TERM is back, regardless if I use tmux or plain 
> gnome-shell.

We're not seeing any issues testing this on the autobuilder which is
good. Its part of some very old code, created when we first started to
try and clean up the build environment so its possible other
improvements have obsoleted this need now. Its obviously just had to
test and be sure!

Cheers,

Richard

