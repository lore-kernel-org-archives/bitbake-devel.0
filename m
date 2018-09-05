Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 8C15378D34
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Sep 2018 17:23:43 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so8491833wrr.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 05 Sep 2018 10:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=SeVMe6Gs8U6NaPW+PfhHeCMe8+iNn2jCVgvPoTG3IW0=;
	b=JhT+VcqMXfEQKSqdSUeK6YkLCMctcNjaK2o0qe9esnBN7BrEkeMKjBfrRG2m2W3UMq
	z9Sr4I1Tz6IJ46vC9jfDBTB5psdzJXNHgD4jwJKmLpaTE959+L3MH4Zs7TwMblysltk0
	OO+yCtST0YGyX7NG7TgK/04mM1fmGH+Q3FD0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=SeVMe6Gs8U6NaPW+PfhHeCMe8+iNn2jCVgvPoTG3IW0=;
	b=cP3KU7IW+JpdAzzYb5jwpAelOhORzIn3VSXsywWQsQMpPGnDiuLQvaPgfwDB73VvR/
	tsX8S3JG/OfwfcoN4aMa19X5OisdZQV+n9c7O/27Drt/AiC56Q1vhl5Y4QeP+YVbME1s
	uvIuaV5a8DAuEQAEPmq2fx5HZ/14c/eHw8RI/fPIaYKC5az7At8GIOG5nqp4DGdq/cd9
	LjvUjjZrLoVUUGqEimvJkY4260WV+VAfKGsJVrr+8oBd7ERWUpK2FmhB+hwA1EOokmqK
	2plrOqaB7+z38YtfXLA54yP272an3AkfebwbiEQlO49IOLGsDMNg/OfNryGfIzirUoMI
	VmXw==
X-Gm-Message-State: APzg51AzJTcOaFDC6Jvp/Z5uIg6Ra1CUWGzPIzUSE2JgUgMur5QjIaCw
	CZXToxNT+gQuoRGLL9C/C6wgRDdC8HI=
X-Google-Smtp-Source: ANB0VdaIQRhyxq0JRcw5YsSbjFK6OpzSfsvSHzkjEArEjzFxYgNw7D/eRO3H6fRqBlI5Nyg/8OjI2w==
X-Received: by 2002:a5d:574b:: with SMTP id
	q11-v6mr492582wrw.272.1536168224401; 
	Wed, 05 Sep 2018 10:23:44 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	s13-v6sm3384582wrq.39.2018.09.05.10.23.43
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 05 Sep 2018 10:23:43 -0700 (PDT)
Message-ID: <77cdb9be0a3fa4ed085c4cc4323cfa6841c0b477.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Joshua Watt <jpewhacker@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 05 Sep 2018 18:23:42 +0100
In-Reply-To: <7d6334bd3220b7f6e660f4c161b46279c2205497.camel@gmail.com>
References: <20180905170109.31505-1-richard.purdie@linuxfoundation.org>
	<7d6334bd3220b7f6e660f4c161b46279c2205497.camel@gmail.com>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Subject: Re: [PATCH] server/process: Various server startup logging fixes
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
X-List-Received-Date: Wed, 05 Sep 2018 17:23:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2018-09-05 at 12:19 -0500, Joshua Watt wrote:
> Looks good to me. I have a few (optional) suggestions.
> 
> On Wed, 2018-09-05 at 18:01 +0100, Richard Purdie wrote: 
> >      try:
> >          so = open(logfile, 'a+')
> > -        se = so
> >          os.dup2(so.fileno(), sys.stdout.fileno())
> > -        os.dup2(se.fileno(), sys.stderr.fileno())
> > +        os.dup2(so.fileno(), sys.stderr.fileno())
> 
> I think so "leaks" here. Granted, it was doing that before so perhaps
> it could be saved for a separate patch:
> 
>  with open(logfile, 'a+') as so:
>      os.dup2(so.fileno(), sys.stdout.fileno())
>      os.dup2(so.fileno(), sys.stderr.fileno())

I'd take a patch for it.

> > +        os.close(self.readypipe)
> >          writer = ConnectionWriter(self.readypipein)
> > -        try:
> > -            self.cooker = bb.cooker.BBCooker(self.configuration,
> > self.featureset)
> > -            writer.send("ready")
> > -        except:
> > -            writer.send("fail")
> > -            raise
> > -        finally:
> > -            os.close(self.readypipein)
> > +        self.cooker = bb.cooker.BBCooker(self.configuration,
> > self.featureset)
> > +        writer.send("ready")
> > +        writer.close()
> 
> If we want to ensure that writer is always explicitly closed, would
> this be better?
> 
>  import contextlib
> 
>  with contextlib.closing(ConnectionWriter(self.readypipein)) as
> writer:
>      self.cooker = bb.cooker.BBCooker(...)
>      writer.send("ready")
> 

We don't want to do that. The closing of the fd triggers the client to
decide something went wrong and check the logs so we want that to
happen after everything has flushed. The process takedown closing the
pipe is therefore a better option in this case. You could argue we
should flush here but the general exception handling and so on is later
down the exception path so I think what we're doing after this patch is
a better option.

Cheers,

Richard

