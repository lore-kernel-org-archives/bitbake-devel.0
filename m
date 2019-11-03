Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail.openembedded.org (Postfix) with ESMTP id 5B4E97F610
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  3 Nov 2019 09:44:14 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id t1so7822929wrv.4
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 03 Nov 2019 01:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=fvcpAWixPBVy6wo29Hf2FTlANNNsLimeeN3ghJE5qTw=;
	b=PIXKSt+YWB5sgC7fFa+KIxqTmW3noPPHm60l1q/t0qzPa1i+BxNXKvSRIo4EWtFEDz
	vZGgZe2ZjOSkE9pfytloUsUvyfpr0zmaN1BSvdKKxwhpuga4aVSVxpO+hSX+O+tQDhrl
	PCmgqU6DeBeZpPgMvq1QuRXc7r9yWLTVIaI4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=fvcpAWixPBVy6wo29Hf2FTlANNNsLimeeN3ghJE5qTw=;
	b=ji6uzzAMUkEVjWMNHFKnwXvn9U+lDkyqKBngx5Yo+Jpjd06L975NqIQkYp8tAGaIR0
	/7IBpTo1Qpd4LL6QgVFwMLi9RrizhDg/kMltFzsoCfo/B3XTYvRG3OlhGCEAGa0+vKRF
	QXkoKmKvbwOXA0MyAmolRDLBvVM4QVz5D3lE9X1Tin1cvD4Ml5kmftLReKa8olWG7YKk
	qmmbsBhnWMdSbQyU1V/pU+6G4KCZ7A5+AgIJ497ckJzkubNnkMXG1GGhzaDU7p6IVPRq
	gbZrk36FsN+cXB+veJSZsfcI8cANwqst8K9G13MaCm7UbLDLb9nrY4rODDtarKWIyaQK
	/+aw==
X-Gm-Message-State: APjAAAUpA4CkGzKFEHh2KSO8nKa9QdoHDtcw6N8XIRoEjDq6ncVAaVHw
	vom9Y1+h2x1riKAdo3HOoidocg==
X-Google-Smtp-Source: APXvYqy+tFXl3K0IGKqnAVJ8Mrr4rb25QRKWzFexBVe6Z6RvRGAF6080J5NlD7R5cY3XV2gi8Vr8Kg==
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr13324402wru.52.1572774254759; 
	Sun, 03 Nov 2019 01:44:14 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	b196sm16944670wmd.24.2019.11.03.01.44.13
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 03 Nov 2019 01:44:14 -0800 (PST)
Message-ID: <c032a294dd1e26fd5061d850f9d5322a79de0c14.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Sun, 03 Nov 2019 09:44:12 +0000
In-Reply-To: <CY4PR12MB16530722ADF132F7AE920D908B7D0@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <1572543354-4229-1-git-send-email-chris.laplante@agilent.com>
	<5375964a726a0a4790c99137a52227a66e09b243.camel@linuxfoundation.org>
	<CY4PR12MB16530722ADF132F7AE920D908B7D0@CY4PR12MB1653.namprd12.prod.outlook.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH] bitbake: command: add getOverrideData command
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
X-List-Received-Date: Sun, 03 Nov 2019 09:44:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2019-11-02 at 23:11 +0000, chris.laplante@agilent.com wrote:
> Hi Richard,
> 
> > The question here is what is the usecase?
> > 
> > The override data in this form is really a datastore internal and
> > shouldn't be something we expose an external API for. It happens to
> > exist in this form for the current implementation of the datastore
> > but
> > it didn't used to and may not again, depending on how we change
> > that
> > implementation, particularly as people look at parsing performance.
> 
> Would it make more sense to come up with an external representation
> of the data that we could expose as a stable API?
> 
> My particular use case is that I needed to identify if and where
> SRCREV is getting overridden for particular recipes. For instance,
> someone might have added a SRCREV_pn-recipe to their local.conf. I am
> working on a tool that produces "buildhistory-collect-srcrevs"-style
> output from the SRCREV cache itself, without actually requiring that
> buildhistory is enabled. It's actually a general tool to inspect and
> manipulate the SRCREV cache. My team uses AUTOREV pretty extensively,
> so this kind of tool will be very useful to us.

I think it depends what kind of guarantees we're expecting around this.
For example:

python () {
    if d.getVar("MACHINE") == "bar":
        d.setVar("SRCREV", "problem")
}

Really the only way to be sure is to parse for each MACHINE and see
what the values are. I did wonder if you could just switch between
MACHINE values but that doesn't even cover the python above without the
datastore finalisation.

Basically my worry is what the expectations of the API are. Whilst you
may be fine with the limitations, its the makings of an unsolvable bug
report tomorrow :(.

Cheers,

Richard


