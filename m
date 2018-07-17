Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id A394A7546E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Jul 2018 14:00:48 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id c4-v6so1367806wrs.12
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Jul 2018 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=0cHY6YSTqu1cwa6mXndOvyBZa4wU7ksqVFByHIYtS5E=;
	b=dB24I4GQ/K/InVz0z5P2SC3bOVTkBxayIgdfXB4pIMPZPK0bsUFXLIa/2axS26AvLM
	WK+0LDTayxRW7SHvoRewL1j+3QcwgrMYEEtMtli7lOGP0Xpxe5oHbqxe5rFATot+gxZe
	aFT8KTqAZRunWHDcmrdqLSKoQxLuyeWhGGeyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=0cHY6YSTqu1cwa6mXndOvyBZa4wU7ksqVFByHIYtS5E=;
	b=iqZ8YuOPiqB2Jkae1Wz12FPF195lV1bs6IJn06vb7LhX5SCdGUHMMutAfT4a9EB1KN
	koR2p8pgVuZRUzdmbaQUm9ulKKSNXr6qRSNruJyq8Vz4qgRkUcP/47wb1mqILX3Bau+c
	UJuGjsnn7OrdzSRsAvYZfQrbQRkfVotJTZTUkCWq+KDYSuRbqqh9r8lZgwntIo+mDwoI
	NMq9CyrBsxICYO0o9R9OGv6tZPoamilyn2m7JslBqToF8uwsJpMSYdbC5I1/gLJUOvNN
	3PGZruCZ/rN/yTNwpYYXlTFrEIL1Ym/PW6ODDH7OBj4Tqvc9lAYUJ5aWe708DH65Y4ED
	puKw==
X-Gm-Message-State: AOUpUlED58u14EZhdOCJiy3CH32N4FXH2l4AWwMHMOLF5MJIowwg5hU4
	+ozMWjdbnxtAROWK5ZbmoaDEtQ==
X-Google-Smtp-Source: AAOMgpdedpdBQLjKWsuD4CRqVGGnAbB/M1AzxpW5OTpBmEf2fb3HoEmQbdPSY0bKkFhMt+ArD2sJkw==
X-Received: by 2002:adf:f8c7:: with SMTP id
	f7-v6mr1472096wrq.237.1531836049138; 
	Tue, 17 Jul 2018 07:00:49 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	f18-v6sm1626454wrt.64.2018.07.17.07.00.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 17 Jul 2018 07:00:48 -0700 (PDT)
Message-ID: <8afc9bc960e469d4e243e7512a0285c2dd36a584.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Urs =?ISO-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 17 Jul 2018 15:00:46 +0100
In-Reply-To: <1531834769.2962.38.camel@bbv.ch>
References: <1531826153.2962.36.camel@bbv.ch>
	<27b7bf4b1cd46e051b3c9c9e109ecacf6f238336.camel@linuxfoundation.org>
	<1531834769.2962.38.camel@bbv.ch>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Subject: Re: Issue with bitbake fetch/unpack when using MIRRORS rewrite
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
X-List-Received-Date: Tue, 17 Jul 2018 14:00:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2018-07-17 at 15:39 +0200, Urs Fässler wrote:
> You can reproduce the problem with a current (rocko) Yocto. Add the
> following lines in local.conf:
>   BB_GIT_SHALLOW = "1"
>   BB_GENERATE_MIRROR_TARBALLS = "1"
>   PREMIRRORS += "git://git.yoctoproject.org/.*
> git://git.yoctoproject.org/git/PATH;protocol=https \n"
> 
> and execute
>   bitbake fstests -c unpack
> 
> You should get something like:
>   tar -xzf
> .../build/downloads/gitshallow_git.yoctoproject.org.fstests_e5939ff-
> 1_master.tar.gz failed with exit code 2, output:
>   tar (child):
> .../build/downloads/gitshallow_git.yoctoproject.org.fstests_e5939ff-
> 1_master.tar.gz: Cannot open: No such file or directory
> 
> What happens is that the download step generates the tarball:
>   gitshallow_git.yoctoproject.org.git.fstests_e5939ff-1_master.tar.gz
> but the unpack step expects the tarball:
>   gitshallow_git.yoctoproject.org.fstests_e5939ff-1_master.tar.gz
> 
> The difference in the tarball names come from the different url used
> in the recipe and when rewritten according to PREMIRRORS.

Is this just a problem with shallow clones or with git recipes in
general and the above was just a simple/fast example?

> The symlink solution would add a symlink from
> gitshallow_git.yoctoproject.org.fstests_e5939ff-1_master.tar.gz to
> gitshallow_git.yoctoproject.org.git.fstests_e5939ff-1_master.tar.gz.
>
> The recipe-url solution would name the tarball
> gitshallow_git.yoctoproject.org.fstests_e5939ff-1_master.tar.gz.
>
> > > Now the question is which solution we should implement. For us,
> > > it
> > > is
> > > the second one (tarball naming after recipe-url). It comes with
> > > the
> > > downside that the one mentioned test fails and has to be removed.
> > > In
> > > a
> > > real scenario this results in downloading a repository twice and
> > > having
> > > 2 tarballs with the same content. But I expect this to be
> > > unlikely
> > > in
> > > a
> > > real world scenario.
> > > 
> > > A third solution may be that we add a link between the download
> > > and
> > > unpack task. But this would be the most intrusive solution for
> > > Bitbake.
> > 
> > I'm more than a little concerned about the symlink comment since
> > the
> > fetcher assumes that symlinks work in other places too.
> 
> Sorry for concerning you. I think it is no issue. We generate the
> tarballs and archive them on a system without symlinks. Then we get
> the tarballs over http with the help of a premirror rule. We do it as
> described in the Bitbake manual chapter "The Download (Fetch)". I
> expect this to be a fairly common use case.
> 
> Another rationale for the recipe-url solution is that the mirrors are
> used when the server from the recipe-url is not available. When we
> generate a tarball, it would be strange that the name of it depends
> on some local conditions (closed ports, local mirror rewrite rules,
> ...) rather than the recipe.
> This probably invalidates my argument that the symlink solution is
> nice since it has the same method for naming as the git clone naming.
> This are 2 quite different use cases.
> 
> > Also, do you have any new test cases to add which illustrate it?
> 
> I have a test but it is a bit tricky since there are 2 issues. The
> one you see (as mentioned above with Yocto) is actually not the real
> problem but an issue that is only seen in this scenario.

Could we have separate test cases for the two issues?

> Since I am now quite sure that the solution where we use the recipe-
> url for the tarball name is the correct one, I like to reformulate my
> Question: Do you see a reason why it is a bad solution?
> 
> If you don't see a problem I will implements this behavior. The
> failing test will be replaced with other tests that capture the new
> behavior.

For better/worse, the current fetcher behaviour with mirrors was to use
symlinks to represent the path its resolved through. We use them in a
variety of cirumstances such as when referencing local file:// mirrors
we can't write to.

My instinct is therefore to have all the fetchers behave the same way
with regard to how DL_DIR works. Having consistency is important and
multiple code paths with different behaviour has caused us problems in
the past.

At the back of my mind there is some thinking that the symlink approach
does protect us against some potential data duplication in the
downloads directory but I'm out of time to work through that thought
right now.

Can you confirm if the normal git fetcher has the issue or its just
shallow clones as that is probably important?

I'd be interested to see your alternative patches too if you have them.

Cheers,

Richard




