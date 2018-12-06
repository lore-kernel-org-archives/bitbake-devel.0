Return-Path: <jpewhacker@gmail.com>
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
	[209.85.167.194])
	by mail.openembedded.org (Postfix) with ESMTP id 6DCAF79357;
	Thu,  6 Dec 2018 14:58:32 +0000 (UTC)
Received: by mail-oi1-f194.google.com with SMTP id a77so600411oii.5;
	Thu, 06 Dec 2018 06:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:message-id:subject:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=AtVe/OovBXjq3I+UexQ/PW1Ub3m5fCF1TOxNy6g8GaQ=;
	b=MBeJNmj4JmSWUgVLHSxr7Y4GSz1gFobIEQjwQxyRr4RgU9M64WJCGf/PHnlnfvOUvW
	rJjXxQgLWu0wtodrNzKYL/HshH2BZw14cOAJWNT1aqELHSoYul3Pty4pciDZtYGWb9dg
	LY6+MQ0jq8cRGmzavRPMnGgiJLBK2yRamif0Jhm2ISOcX2tD6VETNemPujpARBQ/Fx1e
	eDMr85J5qfLfn8vxWUiNiUAeQCsUbGzfqCddyi97VMICci4qQ/tiVQKgvopyRSOMDzPb
	3M3uR8IkyhVt9ojvqx6cWcyijgMODa13jd6K1UlmHg6OyPgclQBgjA8NS+YIV07k2Xpr
	tAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:message-id:subject:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=AtVe/OovBXjq3I+UexQ/PW1Ub3m5fCF1TOxNy6g8GaQ=;
	b=t1FTrP9hC8xqBVNvY19PvCj/XCx+DUQ5+QsKk4Sa8fpEZ4SVwg63rCAocL9TJnGToV
	41o6Z0m8+6huALbgCIvx4fcCf7hsFTm9ohqXpaqN0zW5PXY8WPku6tPd+Idgmi+UtpEF
	oFuCWvkC3zGwVoOk5/jJXe0jlIAR/mD++iLzQuww/CPys5kkUSDO8YSBImnqLKtZPOnd
	FoChawjnRUCPGaGAjE5paWPL+m5nXWLdklIR4ADKK12k4RsbPeO7BgzTvqBaHpZ281qr
	YnKeP8aVJ5hXxMtp+/xrizi+pq/ONY4yWOMI4q7I1QulaEe/PHw49XSWWQ/74/kGlOcj
	6REA==
X-Gm-Message-State: AA+aEWah8cxb3BszkpqPfC+sHaaN1bU6dXTsPJBynTkuohtU7+aeC0DD
	wa5HhJcGB8j96nc2sdcPxHc=
X-Google-Smtp-Source: AFSGD/Vr/HkYcV+sHrAD3V4E0jkvX0dvCN++iqHS3fpyNJC21MRqIbzKyigs5Kb/Kd+5auJJ5aipBg==
X-Received: by 2002:aca:54c4:: with SMTP id
	i187mr16918634oib.238.1544108312974; 
	Thu, 06 Dec 2018 06:58:32 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.googlemail.com with ESMTPSA id
	21sm214793oie.24.2018.12.06.06.58.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 06 Dec 2018 06:58:32 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Message-ID: <cb3093ba9816ce9e80cfcf7ccab15ed6e1edb307.camel@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Thu, 06 Dec 2018 08:58:30 -0600
In-Reply-To: <92dc76b3b209f034ebafaf88ae8ff9844475abb9.camel@linuxfoundation.org>
References: <20180809220840.26697-1-JPEWhacker@gmail.com>
	<20181204034245.25461-1-JPEWhacker@gmail.com>
	<20181204034245.25461-11-JPEWhacker@gmail.com>
	<92dc76b3b209f034ebafaf88ae8ff9844475abb9.camel@linuxfoundation.org>
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Subject: Re: [OE-core][PATCH v3 10/17] bitbake: siggen: Split out task depend ID
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
X-List-Received-Date: Thu, 06 Dec 2018 14:58:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2018-12-05 at 22:50 +0000, Richard Purdie wrote:
> On Mon, 2018-12-03 at 21:42 -0600, Joshua Watt wrote:
> > Abstracts the function to get the dependency ID for a task so it
> > can
> > return something other that the taskhash
> > 
> > [YOCTO #13030]
> > 
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > ---
> >  bitbake/lib/bb/siggen.py | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
> > index ab6df7603c8..2daca70538a 100644
> > --- a/bitbake/lib/bb/siggen.py
> > +++ b/bitbake/lib/bb/siggen.py
> > @@ -41,6 +41,9 @@ class SignatureGenerator(object):
> >      def finalise(self, fn, d, varient):
> >          return
> >  
> > +    def get_depid(self, task):
> > +        return self.taskhash[task]
> > +
> >      def get_taskhash(self, fn, task, deps, dataCache):
> >          return "0"
> 
> I spent a while wondering why we still had "IDs" in the runqueue code
> when I thought I'd removed them all. Once I'd gotten over that I

I suppose I'm not familiar enough with bitbake's history to have
understood that these "IDs" were problematic in the past :)

> somehow thought this related to the task's dependencies and then how
> could it only have one of them?
> 
> I therefore suspect calling this "depid" is going to be confusing and
> we need a better name for it. I'm wondering about taskresid?
> taskresolvid? taskresolvedid? taskreshash?
> 
> I appreciate why you're calling it an 'ID', hash may be clearer
> thought, not sure...

Ya, I struggled with the naming. There is no reason it has to be a
hash, so I went with a (probably too generic) "ID"... in practice using
a hash is reasonable so I don't have a problem using "hash" in the
name. My runner up names were "dephash" or "taskdephash". I think
indicating that it is involved in the dependency calculations is
important, although I can see how it might be some confusion about
where it is involved. I'm not too keen on the "resolved" names... but
maybe I'm missing where the are stemming from?

Another option if you want to go more of the graph theory approach
might be "taskedgehash", "edgehash", "taskedgeid", "edgeid", etc.

> 
> Cheers,
> 
> Richard
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
-- 
Joshua Watt <JPEWhacker@gmail.com>


