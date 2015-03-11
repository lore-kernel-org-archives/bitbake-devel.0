Return-Path: <anders@chargestorm.se>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
	[209.85.217.170])
	by mail.openembedded.org (Postfix) with ESMTP id 2868773AC7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Mar 2015 07:10:19 +0000 (UTC)
Received: by lbjb6 with SMTP id b6so6770876lbj.9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Mar 2015 00:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-type:content-disposition:in-reply-to
	:organization:user-agent;
	bh=mwAgwdnobYnANw/4r4q7zdsrSfbzMh5wSiXZ6LxneUg=;
	b=JV3y/7n/Zexv0kp1mY/GANzViF6rQ/+Mu01ZTHdSG0TXypFJxzwHN3o0FqC1jZlvUJ
	fzJYoOZgp5UTv9JDm868CNN+fnBMfb22+dU8fn7/tJOJyTXdTEsaQfSs5KsCfH4hRWZq
	r5gcT64q64NR7D1FRMRsVowxXJJVODsnmsySRGbzrw0V9TSgB4YSb59QSeNNv5QnxT46
	o5tg36cgXkmy/7V2WuyAT7T4lJujmbo8yMiC7jU9sVZgTZewjt2gss7ckHJk7tJczIRF
	8aGlQTMqZyWbd3wtJYE5ckhMN3XyW5Ir3XGvQAXTkKUPvPUqk7I4q1bIPePek+BUnI+Y
	/nNw==
X-Gm-Message-State: ALoCoQno2lMYWS+pTsQQz+reW1bQ57ATPKIcNeuMQI3XV5Wxjfrg8Zm4lbcR0QDacVAZl0jk0H3D
X-Received: by 10.152.4.136 with SMTP id k8mr33517715lak.103.1426057820196;
	Wed, 11 Mar 2015 00:10:20 -0700 (PDT)
Received: from ad.chargestorm.se (213-64-219-84-no126.business.telia.com.
	[213.64.219.84])
	by mx.google.com with ESMTPSA id k3sm535807lah.40.2015.03.11.00.10.19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 11 Mar 2015 00:10:19 -0700 (PDT)
Date: Wed, 11 Mar 2015 08:10:17 +0100
From: Anders Darander <anders@chargestorm.se>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Message-ID: <20150311071017.GA6520@ad.chargestorm.se>
References: <alpine.LFD.2.11.1503071053070.28079@Device-040570>
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.11.1503071053070.28079@Device-040570>
X-Accept-Language: sv, en, de
X-GPG-Fingerprint: 5AF0 B2E9 78FE 9D75 D110  6F8F 3E31 84D7 920E 938C
X-GPG-Key-Id: 0x920E938C
X-GPG-Keyserver: hkp://keys.gnupg.net
Organization: ChargeStorm AB
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: suddenly confused by appends and overrides being used together
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
X-List-Received-Date: Wed, 11 Mar 2015 07:10:22 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Robert P. J. Day <rpjday@crashcourse.ca> [150307 18:16]:
>   thought i understood how appending and overrides work together but a
> simple example suggests i have no clue.  from the in-progress bitbake
> user manual here:

> http://www.yoctoproject.org/docs/latest/bitbake-user-manual/bitbake-user-manual.html

> section 3.2.3, this first example looks right (start excerpt):

>      OVERRIDES = "foo"
>      A = "Z"
>      A_foo_append = "X"

> For this case, A is unconditionally set to "Z" and "X" is
> unconditionally and immediately appended to the variable A_foo.
> Because overrides have not been applied yet, A_foo is set to "X" due
> to the append and A simply equals "Z"."  (end of manual excerpt)

<snip>
> back as in the first example:

>      OVERRIDES = "foo"
>      A = "Y"
>      A_foo_append = "Z"
>      A_foo_append += "X"


> For this case, before any overrides are resolved, A is set to "Y"
> using an immediate assignment. After this immediate assignment, A_foo
> is set to "Z", and then further appended with "X" leaving the variable
> set to "Z X". Finally, applying the override for "foo" results in the
> conditional variable A becoming "Z X" (i.e. A is replaced with A_foo).
> (end of excerpt)

Well, I'd agree with you that the manual in work isn't really wording
those sections "good enough".

In the first case, you're correctly arriving at:
A = "Z"
A_foo = "X"

In the last case:
A = "Y"
A_foo = "Z X"

Thus, sofar (in my understanding), they ought to be written in the same
way. What the last example seems to try to higlight, is that if the
override gets active, the value of A will be changed. E.g. if foo is for
instance either of the current machine, arch, or distro in the
OpenEmbedded build system.

I'll see if someone takes the bite and correct me, though this is my
understanding of the examples (note: I've only read your e-mail, not the
actual manual...)

Cheers,
Anders

-- 
Anders Darander
ChargeStorm AB / eStorm AB

