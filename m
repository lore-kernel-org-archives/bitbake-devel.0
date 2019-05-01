Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by mail.openembedded.org (Postfix) with ESMTP id 0ED1C7D589
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 May 2019 19:42:49 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id y197so311853wmd.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 May 2019 12:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=6wF26vxKY9b8FUX9cb+LAw1ivHKkNi4zALBazO3wQ80=;
	b=Pl4blIoysGef8ECvdMzYRZ8GdcLKsye+2ewK3z3t4OYC4Nnr++xtA0VSojOg0uMlQe
	rJ8BvFrPidYLpIwuJBxVb+nmYH4XDxv+fm0xbUMWazzS3biujnJ+uuBrOHaW0NE99S+I
	5w0esIV/cqW832OmdiZBbTygAkdJ5Rgjq2ZTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=6wF26vxKY9b8FUX9cb+LAw1ivHKkNi4zALBazO3wQ80=;
	b=Xgd5ojNBEXy6DtK0CGF4rELe6ldeNVP0+BTKe3bt6gaWuNl4JiS1Q4whi8dHqF0CNe
	7rZxahQWK5dZn8joOVGpVNMYFe62AISGaqav9hPqXsmGcvtdmPm62svqTeiW6k94De+C
	PGTtcXgRZ0t4nSlUZhFSYfHRW2FdWi3QXhVbZ3zuuritiD34d59a2Eoqp5kQIqVDOdW+
	NfEy8qifH81tbTtJIiXzlO/MMMF6KfjmyG97ayTDvVi3k+uOlXtJL2ZZ+20FITCCA2Ju
	/0lV/OuUxvefHqYGWSP7bszZ64AYbqZJN3caCXJr3difZKtufKltOwQ9RA3DY4ZeLG8K
	xkUA==
X-Gm-Message-State: APjAAAV71VZWlpeN3Jh1532nQT9hdnaIryku8+RPp+1pJRCcmyRIFbri
	qKg35UzdR8rdmtRsTXEQDqUUCA==
X-Google-Smtp-Source: APXvYqzbCY65udY04r39pky4No/k3rMgW+buZlP71Xm2xVro+j+pN8FDN8JR4RJyPpvzM3ZtMZzj2g==
X-Received: by 2002:a1c:7514:: with SMTP id o20mr5249655wmc.39.1556739770811; 
	Wed, 01 May 2019 12:42:50 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	d1sm22123082wrb.61.2019.05.01.12.42.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 12:42:49 -0700 (PDT)
Message-ID: <4659e72f46cee86b62be445fc267bf2fae4f78b4.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>, "Burton, Ross"
	<ross.burton@intel.com>
Date: Wed, 01 May 2019 20:42:48 +0100
In-Reply-To: <CAP71WjxDASA04Fz6Fd6ew2FQPZFbtU9gMFJKoUiYVmKUNkbyag@mail.gmail.com>
References: <cover.1556186399.git.liezhi.yang@windriver.com>
	<d37712258af9b6fedb9e1586ace28908bec88391.1556186399.git.liezhi.yang@windriver.com>
	<9f8a038abf7b7eff75038ccef5f066bfd37e58f5.camel@linuxfoundation.org>
	<0c45f88f-6056-2fa6-1db1-f7ce413ba0f3@windriver.com>
	<CAPbeDCnOwvCVx-okYiXU0CXjWLxDGBX7xQc4ij+_iGgd2t-T-w@mail.gmail.com>
	<CAJTo0LapxS3a00e31b9ur32x4XtNPTWUSmw4i=_x9AjbLuECjQ@mail.gmail.com>
	<CAP71WjxDASA04Fz6Fd6ew2FQPZFbtU9gMFJKoUiYVmKUNkbyag@mail.gmail.com>
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/2] bitbake: build.py: check dependendent task for addtask
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
X-List-Received-Date: Wed, 01 May 2019 19:42:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-05-01 at 18:48 +0200, Nicolas Dechesne wrote:
> On Wed, May 1, 2019 at 5:30 PM Burton, Ross <ross.burton@intel.com>
> wrote:
> > On Wed, 1 May 2019 at 11:51, Jacob Kroon <jacob.kroon@gmail.com>
> > wrote:
> > > I'm getting a lot of these warnings after removing tmp/ and
> > > rebuilding
> > > my image from sstate cache.
> > > FWIW I use rm_work.bbclass, and regularly use the
> > > sstate-cache-management,sh script to prune old cache.
> > 
> > There's a patch I hacked up in master-next that shows where these
> > warnings are coming from.  Yes, this patch produces two warnings
> > per
> > recipe with rm_work enabled.
> 
> argh... i hit the same issue and came up with the exact same
> conclusion.. i should have checked the mailing list earlier today ;)
> 
> I am getting thousands of warnings like that with rm_work. I had
> modified bitbake so that it shows the 'task' name like Ross, in ().

I suspect we're going to need to rethink that patch, and/or perhaps
rm_work...

I did have concerns about it but was assured it was widely tested. We
also probably need an rm_work test case on the autobuilder (need a bug
for that so we don't forget?).

Cheers,

Richard




