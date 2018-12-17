Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id E52457BFB5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Dec 2018 21:33:47 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id a62so656011wmh.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Dec 2018 13:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=0PMYwDfWBIBDPt9RhRdJkVJUkQr4X6kLssNjQe9Ji3w=;
	b=I5dindWQeMOghFeO4cfLmcznQHhfepVwZ62AKiEEkPPCJfijsXwshfvOSE0CQEtPdT
	YgIcGzajgRL3FIMgYmRv6HFdQ8PX9HP1z5M1B5FC2RKikeS/dzaTkByMZ+iz9jTz7jT4
	7hc5/NgGc4gXmL3JLWOFD38enYeeaxzpvRtCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=0PMYwDfWBIBDPt9RhRdJkVJUkQr4X6kLssNjQe9Ji3w=;
	b=UqgCnw6LTyYWDCAmwNMAL4YzvgYrFE20+qEHhEl0q02oaYX7cJjySV+oXsAF/Q2D2F
	RO2N8hIhGUCIB7igMvJaBl4pSs6HJkrlANbW4hX4tbj3gDVFTJ2tHtEMfvAA0PwoMEB5
	3f/ToWU3T8ITwkrVllYRJzv0QZlxaOQPULyrsrko2loW1D5qwpc7X5l+U6XvruZ3PDIF
	XWvABpUBqGTqT7w3jMeMlReYCl+t1PsqQVaMDAE3Zo3bTAOTTnqls0/qcnamHZdnbwYI
	R/p5fg4nD5PJubZNlejt+IvuWPcBWxIC13S1jXIEpHhdptL8Pj6FH3iW9CrPBS3gFrwI
	2MeA==
X-Gm-Message-State: AA+aEWbKgO8bFwqPNchMY+v30EUV/aygFkGXgHmL+ktQacKN7lzurcAe
	gEI6sN9Wfa6J90qWSSMu/TprKw==
X-Google-Smtp-Source: AFSGD/UPhXVNCRmRO140aLCt+iX/EQ1jAiGLCXGH8lw9hpmADJeniZ4rqBURdEwJTfqSLpy3P44dAg==
X-Received: by 2002:a1c:868a:: with SMTP id i132mr626707wmd.49.1545082428568; 
	Mon, 17 Dec 2018 13:33:48 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e142sm648872wmf.46.2018.12.17.13.33.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 17 Dec 2018 13:33:47 -0800 (PST)
Message-ID: <94dc7afb9f161df5728b6e3b1af0c9cbef4ce806.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Jacob Kroon <jacob.kroon@gmail.com>
Date: Mon, 17 Dec 2018 21:33:46 +0000
In-Reply-To: <CAPbeDCk51q9Fz4ZsJ1jZP64aLdZc7YRaWCQVK5=kNSO=xfScrw@mail.gmail.com>
References: <20181217144006.32015-1-richard.purdie@linuxfoundation.org>
	<CAPbeDCk51q9Fz4ZsJ1jZP64aLdZc7YRaWCQVK5=kNSO=xfScrw@mail.gmail.com>
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] codeparser: Switch to sha256 from md5
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
X-List-Received-Date: Mon, 17 Dec 2018 21:33:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2018-12-17 at 19:47 +0100, Jacob Kroon wrote:
> On Mon, Dec 17, 2018 at 3:40 PM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > We've reports of hash collision with codeparser. Looking at the way collision
> > problems occur with md5 and the way our function templating works, I can believe
> > we may run into issues.
> > 
> > This patch therefore switches to sha256.
> > 
> > Performance wise, parse time could appear to rise by 4s in 374s
> > 
> > Before:
> > 
> > 384329 in 2.966s (md5)
> > 
> > After:
> > 
> > 349743 in 2.340s (sha256)
> > 34723 in 1.245s (md5)
> > 
> > since we still have md5 used elsewhere in the code, something we should look at
> > next (using sha256 everywhere is around 5.3s in total)
> > 
> > Unfortunately this does nearly double the size of the codeparser cache file
> > due to the hash size change.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/codeparser.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
> > index 3f8ac1d5f6..ac995a6a1d 100644
> > --- a/lib/bb/codeparser.py
> > +++ b/lib/bb/codeparser.py
> > @@ -33,7 +33,7 @@ from bb.cache import MultiProcessCache
> >  logger = logging.getLogger('BitBake.CodeParser')
> > 
> >  def bbhash(s):
> > -    return hashlib.md5(s.encode("utf-8")).hexdigest()
> > +    return hashlib.sha256(s.encode("utf-8")).hexdigest()
> > 
> >  def check_indent(codestr):
> >      """If the code is indented, add a top level piece of code to 'remove' the indentation"""
> > @@ -140,7 +140,7 @@ class CodeParserCache(MultiProcessCache):
> >      # so that an existing cache gets invalidated. Additionally you'll need
> >      # to increment __cache_version__ in cache.py in order to ensure that old
> >      # recipe caches don't trigger "Taskhash mismatch" errors.
> > -    CACHE_VERSION = 10
> > +    CACHE_VERSION = 11
> 
> The comment above mentions a "__cache_version__" in cache.py. Should
> that be bumped as well ?

Good question but in this case no. We didn't change anything about the
form of the data, just the way its represented internally in the cache.
The other code will see the same results before and after the change so
it doesn't mean it has to be bumped. It wouldn't hurt either, we just
don't need to.

Cheers,

Richard


