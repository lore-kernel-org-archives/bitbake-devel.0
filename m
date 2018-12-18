Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
	[209.85.166.65])
	by mail.openembedded.org (Postfix) with ESMTP id B574D7C059;
	Tue, 18 Dec 2018 16:31:33 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id w21so13271450ioc.1;
	Tue, 18 Dec 2018 08:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:message-id:subject:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=KVoNzAodnyAXRT1noZHIbRnlkdQOajDmqB7U1UpDVQI=;
	b=ZoP79IkA/k0IdduWSU6ZLBZjRG5AwBo0ZF3hwdT50i8LktjQYGKzMeR8+cvP75iGof
	yFrRAlOIg6HmqFVOWOxWm+aOIK90QXZuVJkDm31+n+2NvypCg/Kjxsf2Y2P+PkTY8Ujb
	JASmflJNDC2vDvRTckxK1zM8WRhswQ5rBqw6Vh2EinDLC3okBvhho3TjtAv6qpaMmYQT
	PGZUC6qz6s3yzTBYD0LUayfkc+Nrvfn44kwx6eUdd3umG4xIEMyYLsZi2jSMDoh/wJtM
	RHfehI9MMKFcJhgSIClOOYbyWwWK34RBUviP24mafAyGFiLMA7NUjlG6TQUM5c24/suw
	ogIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:message-id:subject:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=KVoNzAodnyAXRT1noZHIbRnlkdQOajDmqB7U1UpDVQI=;
	b=Hroge0ABzghVrxL/SluYI44uPhXaCKJqZ0TpZ0RPFPhUNcdUPrCq6Uta4wABhkm9XT
	wEzXg/iQzm2dz9FynRl9KRcILHFJuF9bBKN1PiZhOPHHruIhOzBRrNnb/d+WJZENAxgs
	LxAN7uT/Ai1DEHrFivD2VFe8TJtWBF0ZW0Utt4Ps/ywSM+SMpVYw1FcpQBzi3AG1x9Sy
	cfpDzrU/CubJHjx+sN6KKLx08Maj5TKnggV1MREzL48bfjmtLNn60Z9D3PbizPkgT7+k
	M8UDMDO2jkvdCsFr7q1Isl/ArbUKnmGeScCwyNNK9YbG4W2Q3ODhVCygmW6SpnJdm3Bl
	SVww==
X-Gm-Message-State: AA+aEWarX2yv8bMx+BKW5Seri3/5WF+8qRaQlXZU/RNgSGoMvdpSoSdV
	BInUuW7MgVJaq3pLi08TCPE=
X-Google-Smtp-Source: AFSGD/UwxJSWFvCNgu7y09ymML5vVHu8xcInmu01xntdUc9vD75uRdg6hXHyzSMU651EArO0kqwatw==
X-Received: by 2002:a6b:8bc6:: with SMTP id
	n189mr13641296iod.234.1545150694552; 
	Tue, 18 Dec 2018 08:31:34 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.googlemail.com with ESMTPSA id
	k2sm1647683itk.35.2018.12.18.08.31.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 08:31:33 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Message-ID: <7a7dc3aa64c82995b4ebfd476b205affee988eb6.camel@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 10:31:33 -0600
In-Reply-To: <2d3ed923953d6bd5747e2ddd510872c4f773c32f.camel@linuxfoundation.org>
References: <20181204034245.25461-1-JPEWhacker@gmail.com>
	<20181218153101.9212-1-JPEWhacker@gmail.com>
	<20181218153101.9212-8-JPEWhacker@gmail.com>
	<2d3ed923953d6bd5747e2ddd510872c4f773c32f.camel@linuxfoundation.org>
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Subject: Re: [OE-core] [PATCH v4 07/10] bitbake: runqueue: Pass unique hash to hash validate
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
X-List-Received-Date: Tue, 18 Dec 2018 16:31:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2018-12-18 at 16:24 +0000, Richard Purdie wrote:
> On Tue, 2018-12-18 at 09:30 -0600, Joshua Watt wrote:
> > If the unique hash is being used to track task dependencies, the
> > hash
> > validation function needs to know about it in order to properly
> > validate
> > the hash.
> > 
> > [YOCTO #13030]
> > 
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > ---
> >  bitbake/lib/bb/runqueue.py | 38 +++++++++++++++++++++++++++-------
> > ----
> >  1 file changed, 27 insertions(+), 11 deletions(-)
> > 
> > diff --git a/bitbake/lib/bb/runqueue.py
> > b/bitbake/lib/bb/runqueue.py
> > index de57dcb37b8..161f53c7cb1 100644
> > --- a/bitbake/lib/bb/runqueue.py
> > +++ b/bitbake/lib/bb/runqueue.py
> > @@ -1378,6 +1378,23 @@ class RunQueue:
> >              cache[tid] = iscurrent
> >          return iscurrent
> >  
> > +    def validate_hash(self, *, sq_fn, sq_task, sq_hash, sq_hashfn,
> > siginfo, sq_unihash, d):
> > +        locs = {"sq_fn" : sq_fn, "sq_task" : sq_task, "sq_hash" :
> > sq_hash, "sq_hashfn" : sq_hashfn,
> > +                "sq_unihash" : sq_unihash, "siginfo" : siginfo,
> > "d" : d}
> > +
> > +        for hashvalidate_args in ("(sq_fn, sq_task, sq_hash,
> > sq_hashfn, d, siginfo=siginfo, sq_unihash=sq_unihash)",
> > +                                  "(sq_fn, sq_task, sq_hash,
> > sq_hashfn, d, siginfo=siginfo)"):
> > +            try:
> > +                call = self.hashvalidate + hashvalidate_args
> > +                return bb.utils.better_eval(call, locs)
> > +            except TypeError:
> > +                continue
> > +
> > +        # If none of the hash validate functions worked, try one
> > more time
> > +        # with the oldest type
> > +        call = self.hashvalidate + "(sq_fn, sq_task, sq_hash,
> > sq_hashfn, sq_unihash, d)"
> > +        return bb.utils.better_eval(call, locs)
> 
> I think sq_unihash shouldn't be in this last fallback option. You
> copy
> and pasted from your updated code rather than the original (pre
> unihash?) You could add (sq_fn, sq_task, sq_hash, sq_hashfn) to the
> args list?

Oops, yep I'll fix that. 

The reason I did it like this to make it not suppress the final
TypeError if the last try failed.... I wasn't sure if there was some
other error I should raise instead if we exit the loop when they all
fail?

> 
> Cheers,
> 
> Richard
> 
-- 
Joshua Watt <JPEWhacker@gmail.com>


