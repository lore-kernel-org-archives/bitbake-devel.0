Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id 4933D60234
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 28 Dec 2019 12:24:25 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id c14so28446117wrn.7
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 28 Dec 2019 04:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=NU7wsg++ljIKzu80SAmS0ZG+Yg05AW2ydLUmVsPgxjA=;
	b=M7Rq8HtC0e+ekT5hTLMsMI5TmJikjoyDu5Lyn2jgUun+3gDvzmDXquxXU7Z2o28JtT
	G1QqUi/Us2o8+kHBTdpJdOcoKnXgplKiw0snRIiEw3gRylu9pC+9s98Xm9sTnHMUq3rc
	6yEd/Hq0JS1hY/j6ZtzWB9hnIdOH5lgb+wOSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=NU7wsg++ljIKzu80SAmS0ZG+Yg05AW2ydLUmVsPgxjA=;
	b=tSsDjvEVd9x08nY8dEWZEiMUSnouzPAF/KtnlrlgIGCDPkOHL53wNrkDhdQegyuwJB
	WtTBt8a0pF5tvGTtlQqiGpyzrXv0vca98PLaIstEKmCu5l7kPbzZ9E86KAwNszTyBqkv
	vaB8qOBmE5qDP545ePxonYW2U7Bqy4Jy+ZjTU5NLEHdqyNUv+j1VVBbcADdZvSKEOYH2
	/lI+fEL/bsWuBQKemR1MVYpgddUueN8nYOiuxUdcCrfSz8WYd+IJ90wm3cjsdtSc2KRl
	nLyCfe86Mz2aPMz4xQIJLsbeJjk3dD0wXfHgl7SuhQPAHGQPGItgxoupMrY5RmUK04zi
	mlaA==
X-Gm-Message-State: APjAAAWmK5C0K6MklHUK9KNZdstDyhH/H1Ap8yf+SVc1hdqNQj6C1aAS
	PSOKmVkmix/piqfsF+1c+e+v4Q==
X-Google-Smtp-Source: APXvYqyW4oEt9oukyEbeErI5ua9NF6xOQiTEMJiCrOK4HFZh5qe7WGj4Y6jfNAJK2L4SIGlbtLah3A==
X-Received: by 2002:adf:d846:: with SMTP id k6mr53331402wrl.337.1577535866025; 
	Sat, 28 Dec 2019 04:24:26 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p5sm38036752wrt.79.2019.12.28.04.24.25
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 28 Dec 2019 04:24:25 -0800 (PST)
Message-ID: <b20d922b796944231207d0980940186f933e15f8.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, Armin Kuster
	<akuster808@gmail.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Sat, 28 Dec 2019 12:24:24 +0000
In-Reply-To: <16250e99a56442a4b98a5635c635c8f3@XBOX03.axis.com>
References: <cover.1577076251.git.akuster808@gmail.com>
	<222df6d6b832868c6e87334f8acdd74b730a91d6.1577076251.git.akuster808@gmail.com>
	<16250e99a56442a4b98a5635c635c8f3@XBOX03.axis.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [1.44 02/18] runqueue/siggen: Allow handling of	equivalent hashes
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
X-List-Received-Date: Sat, 28 Dec 2019 12:24:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2019-12-23 at 08:25 +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> > bounces@lists.openembedded.org> On Behalf Of Armin Kuster
> > Sent: den 23 december 2019 05:50
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [1.44 02/18] runqueue/siggen: Allow handling of
> > equivalent hashes
> > 
> > From: Richard Purdie <richard.purdie@linuxfoundation.org>
> > 
> > Based on the hashserv's new ability to accept hash mappings, update
> > runqueue
> > to use this through a helper function in siggen.
> > 
> > This addresses problems with meta-extsdk-toolchain and its dependency on
> > gdb-cross which caused errors when building eSDK. See the previous commit
> > for more details.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > (cherry picked from commit 39098b4ba2133f4d9229a0aa4fcf4c3e1291286a)
> > ---
> >  lib/bb/runqueue.py | 31 +++++++++++++++++++------------
> >  lib/bb/siggen.py   | 26 ++++++++++++++++++++++++++
> >  2 files changed, 45 insertions(+), 12 deletions(-)
> > 
> > diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> > index bd7f03f..a869ba5 100644
> > --- a/lib/bb/runqueue.py
> > +++ b/lib/bb/runqueue.py
> > @@ -2283,12 +2283,26 @@ class RunQueueExecute:
> >                          for dep in self.rqdata.runtaskentries[tid].depends:
> >                              procdep.append(dep)
> >                          orighash = self.rqdata.runtaskentries[tid].hash
> > -                        self.rqdata.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, procdep, self.rqdata.dataCaches[mc_from_tid(tid)])
> > +                        newhash = bb.parse.siggen.get_taskhash(tid, procdep, self.rqdata.dataCaches[mc_from_tid(tid)])
> >                          origuni = self.rqdata.runtaskentries[tid].unihash
> > -                        self.rqdata.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(tid)
> > -                        logger.debug(1, "Task %s hash changes: %s->%s %s->%s" % (tid, orighash, self.rqdata.runtaskentries[tid].hash, origuni, self.rqdata.runtaskentries[tid].unihash))
> > +                        newuni = bb.parse.siggen.get_unihash(tid)
> > +                        # FIXME, need to check it can come from sstate at all for determinism?
> > +                        remapped = False
> > +                        if newuni == origuni:
> > +                            # Nothing to do, we match, skip code below
> > +                            remapped = True
> > +                        elif tid in self.scenequeue_covered or tid in self.sq_live:
> > +                            # Already ran this setscene task or it running. Report the new taskhash
> > +                            remapped = bb.parse.siggen.report_unihash_equiv(tid, newhash, origuni, newuni, self.rqdata.dataCaches)
> > +                            logger.info("Already covered setscene for %s so ignoring rehash (remap)" % (tid))
> 
> Do we really want this level of logging? I have not commented on it for 
> master (yet), as I expect it is invaluable for RP & co that are currently 
> working hard on the hash server, but for me as common user of bitbake, 
> this is just noise (and a lot of it). I have a local patch that changes 
> this to logger.debug(1, ...) together with another logger.info("Task %s 
> unihash changed to %s" ...) a few lines earlier to get the cooker UI 
> reasonably back to usable. Also see below.

This is a tough one. I appreciate the console is getting noisy,
equally, there are some significant problems with hashequiv and without
this logging we're even more in the dark about what went wrong :(.

We're struggling to figure out what is wrong already and I'd much
rather have logs I can look at and have some idea of what happened
rather than shrugging and saying "dunno".

Whilst right now I'm using this to debug the issues the autobuilder is
showing, if other users run into issues we'll need the same logs. If
someone sends me a log with these entries missing, I will close the bug
as unfixable, I really don't have any other choice.

Fundamentally, we need to sort this out differently so that bitbake
does write a decent log somewhere about what happened even if its not
on the console.

We also need to ensure it *is* on the console on the autobuilder since
those are the logs which are preserved.

I do agree with Armin that we should keep master and zeus with the same
behaviour as to do otherwise will just create more of a mess.

I will likely reduce the noise eventually but only when we're not
hitting issues.

Cheers,

Richard





