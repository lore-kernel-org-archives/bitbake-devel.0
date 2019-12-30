Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id A322D7F8D4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Dec 2019 11:00:28 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id q6so32253236wro.9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Dec 2019 03:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=aD4GX9ANamvDKB2tDu5Dug9rCrHrofxnSQ0oPe1X8Z0=;
	b=e5JsZFkNsOsKc13Jku9EPgHXgm7soiLsQrXkPbxeVR4DJpw3Fc0Yx6dWjA+opJtG+D
	7jnRONIp1xb7OjjEUzLDIaTLxi3qHt1Qb8/F7NnJGuc7QeStAWekkw0UvRKCFww8iOj1
	jPHM3Dqpl2hc3NgFQm7l49Gd6DgD+eMXUDFbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=aD4GX9ANamvDKB2tDu5Dug9rCrHrofxnSQ0oPe1X8Z0=;
	b=d7DZPBixRhCjRXGh6G2p/EIKKPd4hV8p64Tb1ZirudqBXoB6Zw4aVsMAMRYBDyLbDH
	QtNX8p81jzwjNvrcsxuGcyZe8OMwxiY8lQD/UKD/MmwsIO600YHqWtE/K/V9AfICmX+Q
	5oMLzr/RM+tNVhusqux03UwXqs+AmpKFyQYgYa5vyF8kqfBUg7ma0NNakXEXF4ZSq2SQ
	naw4/JxnAHW8GDgGL99bON9ff4kDQqlnGAV4WLWQ7/yQXtBk1wL4ZBMX2iwk0mvdFdjH
	TOU8kp2whvELtZzlsJ9Q84rxPho2HvmbgKLn0sHIgQoVomMlk8l+aZDw3b0r0L1Y3Svu
	KDYQ==
X-Gm-Message-State: APjAAAWLCyyr/ewtOv2NxndUYkotyxltpMQIhzs1wJ1Cfe6+a7DKDTlL
	bxu8ZYN94hbNyhofHwHULxYhJQ==
X-Google-Smtp-Source: APXvYqxZOVDo/uaBdPqGrPApbgSZeoiw9fscyzsEDEICJKg78DRc+RGdgncpGdHWzZ2Bv7OKmf47bg==
X-Received: by 2002:adf:ee88:: with SMTP id b8mr69945052wro.249.1577703629191; 
	Mon, 30 Dec 2019 03:00:29 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	x132sm21530527wmg.0.2019.12.30.03.00.27
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 30 Dec 2019 03:00:28 -0800 (PST)
Message-ID: <d7d728082189ea9cde744cac1ab40b9bb11cd64e.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, Ola x Nilsson
	<Ola.x.Nilsson@axis.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Mon, 30 Dec 2019 11:00:26 +0000
In-Reply-To: <e512728a2ecb4ba68e0cbd3005596a99@XBOX03.axis.com>
References: <20191220142320.17724-1-olani@axis.com>
	<e512728a2ecb4ba68e0cbd3005596a99@XBOX03.axis.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] bitbake: prserv/serv: Use with while	reading pidfile
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
X-List-Received-Date: Mon, 30 Dec 2019 11:00:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2019-12-20 at 17:22 +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> > bounces@lists.openembedded.org> On Behalf Of Ola x Nilsson
> > Sent: den 20 december 2019 15:23
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [PATCH 1/2] bitbake: prserv/serv: Use with
> > while
> > reading pidfile
> > 
> > Signed-off-by: Ola x Nilsson <olani@axis.com>
> > ---
> >  lib/prserv/serv.py | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
> > index 3124b079..708b2e0a 100644
> > --- a/lib/prserv/serv.py
> > +++ b/lib/prserv/serv.py
> > @@ -353,9 +353,8 @@ def start_daemon(dbfile, host, port, logfile):
> >      ip = socket.gethostbyname(host)
> >      pidfile = PIDPREFIX % (ip, port)
> >      try:
> > -        pf = open(pidfile,'r')
> > -        pid = int(pf.readline().strip())
> > -        pf.close()
> > +        with open(pidfile) as pf:
> > +            pid = int(pf.readline().strip())
> >      except IOError:
> >          pid = None
> > 
> > --
> > 2.11.0
> 
> This only half the patch. Please add the following:
> 
> @@ -292,10 +292,9 @@ class PRServer(SimpleXMLRPCServer):
>          logger.addHandler(streamhandler)
>  
>          # write pidfile
> -        pid = str(os.getpid()) 
> -        pf = open(self.pidfile, 'w')
> -        pf.write("%s\n" % pid)
> -        pf.close()
> +        pid = str(os.getpid())
> +        with open(self.pidfile, 'w') as pf:
> +            pf.write("%s\n" % pid)
>  
>          self.work_forever()
>          self.delpid()
> 

I've handled this but asking me to manually merge hunks of patches
together before applying them seems a little potentially error prone?

Cheers,

Richard


