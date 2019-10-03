Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id A6CE960879
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Oct 2019 15:34:41 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id l3so3270022wru.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 03 Oct 2019 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=ig2YP8M5SqdbKVF5087ozLwkBTmx+e4hKzQr3FgxjYg=;
	b=Cp0b5Qiqi8U6SToC2C9bSddNjjtzHT4r49XtUqKL12OIL8sGwLIo5BgsKdDq3/TyEV
	nw71eOyACUzXf4cocBjezPufKHzPNvam5kftfPY36F0W4zJbIoIzAK7l8RYy9FkReV91
	ZI1ZNkXT3vTF/u5eT5UenYev9On8HYH7K/WYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=ig2YP8M5SqdbKVF5087ozLwkBTmx+e4hKzQr3FgxjYg=;
	b=uPdw52dGHvawzaifKY9jUqGfvDy/7AEWhghG/YBbZC8kiL3C1+/oWBOA2fhvJyyI8S
	KZDxmaOP1HVxqmNd3kQPuK4S37bFnZcGtvmcw9LwJlKv7O7MjUAr3GFBdJT7EKjcqAWz
	E73Z38SPuvNxTJzzga9xF5KP7/h6W52tekZhKWeZ5NltQ1/cDv5S26MFVof/RgTQeVNe
	AEjA6kFFFadQTQEq3j1ak7BQ/alQiyGyVL4oufybQeCEmsxfapCBPgh1EibdXaDDv6TU
	1yfzmAISZ+L7Yy/nlfTeXGWRhQYkwIt0GiBj0ZTHg/r8fkBdt7llg8iWwiPw8DBAnj1J
	lRqA==
X-Gm-Message-State: APjAAAXwWFrq8vroFuA6XZG2dxc9QfEMq9y2MseyYww3MmywksJBF7/I
	di4CXEOP7HDHSdE5rwulGxYrBA==
X-Google-Smtp-Source: APXvYqzpgLGyC9rWmMAKlLBHIq/AUoeGlb3OxFdjyjq5j5ybC6SokygSpUnbynXfjLyknEPp2z7eXA==
X-Received: by 2002:adf:f7c3:: with SMTP id a3mr6424039wrq.275.1570116882369; 
	Thu, 03 Oct 2019 08:34:42 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm3919495wrq.88.2019.10.03.08.34.41
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 03 Oct 2019 08:34:41 -0700 (PDT)
Message-ID: <7e3597a6bb96e483e3002198e18a4e47b3100bba.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Thu, 03 Oct 2019 16:34:40 +0100
In-Reply-To: <22cd7d8c-27d9-d56e-4630-34ce3d8347fb@gmail.com>
References: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
	<20190927123347.19276-5-richard.purdie@linuxfoundation.org>
	<22cd7d8c-27d9-d56e-4630-34ce3d8347fb@gmail.com>
User-Agent: Evolution 3.34.0-1 
MIME-Version: 1.0
Subject: Re: [PATCH 5/9] siggen/runqueue: Fix signature mismatch issues
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
X-List-Received-Date: Thu, 03 Oct 2019 15:34:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2019-09-27 at 08:35 -0500, Joshua Watt wrote:
> On 9/27/19 7:33 AM, Richard Purdie wrote:
> > We need to set the setscene tasklist before we call into the
> > taskhash/unihash code else the behaviour is inconsistent.
> > 
> > Avoid reporting hashes for non setscene tasks since we'd never
> > query that.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >   lib/bb/runqueue.py | 3 ++-
> >   lib/bb/siggen.py   | 6 +++++-
> >   2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> > index 65169931f1..29bfd65e0b 100644
> > --- a/lib/bb/runqueue.py
> > +++ b/lib/bb/runqueue.py
> > @@ -1162,6 +1162,8 @@ class RunQueueData:
> >   
> >           self.init_progress_reporter.next_stage()
> >   
> > +        bb.parse.siggen.set_setscene_tasks(self.runq_setscene_tids
> > )
> > +
> >           # Iterate over the task list and call into the siggen
> > code
> >           dealtwith = set()
> >           todeal = set(self.runtaskentries)
> > @@ -1173,7 +1175,6 @@ class RunQueueData:
> >                       self.prepare_task_hash(tid)
> >   
> >           bb.parse.siggen.writeout_file_checksum_cache()
> > -        bb.parse.siggen.set_setscene_tasks(self.runq_setscene_tids
> > )
> >   
> >           #self.dump_data()
> >           return len(self.runtaskentries)
> > diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> > index 71fa018227..6207cbca30 100644
> > --- a/lib/bb/siggen.py
> > +++ b/lib/bb/siggen.py
> > @@ -455,7 +455,11 @@ class SignatureGeneratorUniHashMixIn(object):
> >           report_taskdata =
> > d.getVar('SSTATE_HASHEQUIV_REPORT_TASKDATA') == '1'
> >           tempdir = d.getVar('T')
> >           fn = d.getVar('BB_FILENAME')
> > -        key = fn + ':do_' + task + ':' + taskhash
> > +        tid = fn + ':do_' + task
> > +        key = tid + ':' + taskhash
> > +
> > +        if self.setscenetasks and tid not in self.setscenetasks:
> > +            return
> 
> Would this be worth of a bb.fatal() (or perhaps a bb.warn()) to try
> and discover issues sooner?

There are some circumstances where such a message is confusing and I
couldn't make it work reliably yet. Its worth looking at further
though...

Cheers,

Richard



