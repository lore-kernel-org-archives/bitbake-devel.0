Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by mail.openembedded.org (Postfix) with ESMTP id F12727FE2F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Sep 2019 19:38:23 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id b24so5313527wmj.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Sep 2019 12:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=wD+F62cBfcgDBW4Owv6gXZU0Bu+aWA6PX9vgj8hOve4=;
	b=WFQC3y+57HwMhQiwxh4VErbqFGnZof7Qdzoty2tShyomWCCxJDJp1WJeSaCyhH5KKD
	aVDRivE0zmErcg5jZEN3F4vKu2cz7vVLpQn6y1XnJRdlBaWr3ZQEyAven1Wqr80HWxGk
	yG0m4lyZEdeX6Yvv+9oKNfHR7TYOvcGQoWx2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=wD+F62cBfcgDBW4Owv6gXZU0Bu+aWA6PX9vgj8hOve4=;
	b=V5SO7GaFzhZaBnK3KLAqJhlR7pJXkjbj2l+ObXRj9KUp/R2Z+U/dP4HTY6i/bH0szL
	+QOilxNx2WlAQLtyvufPhOITz3V9qxe22x7YyeqGpLuRofUSf8B7ARQ2NYTQ4jbU8rQh
	nVGhGLWysSA/WxRIuzTMvbJFJRxPwfNpoZkVjIZW5ijZPLjY21gQ0B+tJB6Tpazi0e9M
	K9wHPQIw8W9cml07Qp14nX0SymmUpxdci4YGSTq2S/iwt7IOx9Q5w+edZluz7LWFIdgO
	cYmn1Q1vjCZIwN5LFDFkos6CpMx0/KGYuGHHz8HV0dzQF67JZ867cDsEhLAXOtLF5xEB
	X/+w==
X-Gm-Message-State: APjAAAXJSzu/zAEj312FKmlicaXdX58Wx3gOPr+hqbWU0QvHoMFDDHYf
	Dwlax4KhoWfV8HZ8YCs75qwdHg==
X-Google-Smtp-Source: APXvYqxQ5mb2NVmztYSp84QVhz1q/WSpv7LPyhAdTbBqav0B0pftdbArrAVzWwAh7e/YtUhANGWY+g==
X-Received: by 2002:a1c:3cc3:: with SMTP id j186mr4018660wma.119.1568921904661;
	Thu, 19 Sep 2019 12:38:24 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	a10sm10562046wrm.52.2019.09.19.12.38.23
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 19 Sep 2019 12:38:23 -0700 (PDT)
Message-ID: <04de5bfb296a0ca8abe1425e1368bcceb82055ab.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: akuster <akuster@mvista.com>, bitbake-devel@lists.openembedded.org
Date: Thu, 19 Sep 2019 20:38:22 +0100
In-Reply-To: <b3abe85f-fcb5-69ca-4f05-11a1437b19ae@mvista.com>
References: <20190919155122.28732-1-richard.purdie@linuxfoundation.org>
	<b3abe85f-fcb5-69ca-4f05-11a1437b19ae@mvista.com>
User-Agent: Evolution 3.33.4-1build1 
MIME-Version: 1.0
Subject: Re: [PATCH] utils: Add ionice option to prunedir
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
X-List-Received-Date: Thu, 19 Sep 2019 19:38:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-09-19 at 11:02 -0700, akuster wrote:
> 
> On 9/19/19 8:51 AM, Richard Purdie wrote:
> > Autobuilder type infrastructure can benefit from deletion of
> > certain files as
> > background IO due to the way Linux filesystem priority works.
> > 
> > We have problems where build directories as part of oe-selftest
> > being
> > delete starves the running tasks of IO to the point builds take
> > much
> > longer to compelte.
> > 
> > Having this option of running the deletion at "idle" helps a lot
> > with
> > that.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/utils.py | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> > index 3e90b6a306..d035949b3d 100644
> > --- a/lib/bb/utils.py
> > +++ b/lib/bb/utils.py
> > @@ -677,7 +677,7 @@ def _check_unsafe_delete_path(path):
> >          return True
> >      return False
> >  
> > -def remove(path, recurse=False):
> > +def remove(path, recurse=False, ionice=False):
> >      """Equivalent to rm -f or rm -rf"""
> >      if not path:
> >          return
> > @@ -686,7 +686,10 @@ def remove(path, recurse=False):
> >              if _check_unsafe_delete_path(path):
> >                  raise Exception('bb.utils.remove: called with
> > dangerous path "%s" and recurse=True, refusing to delete!' % path)
> >          # shutil.rmtree(name) would be ideal but its too slow
> > -        subprocess.check_call(['rm', '-rf'] + glob.glob(path))
> > +        cmd = []
> > +        if ionice:
> > +            cmd = ['ionice', '-c', '3']
> Would allowing folks to configure the ionice value apply here?

Its a good question, there isn't usually a lot of choice since a
process can only "degrade" its priority, not increase it. I'd prefer to
leave this as is and extend if anyone ever really needs it.

(3 means 'idle' which matches what the autobuilder does for file
deletion in general)

Cheers,

Richard


