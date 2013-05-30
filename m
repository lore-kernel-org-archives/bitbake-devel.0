Return-Path: <wmat@alphatroop.com>
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
	[209.85.223.180])
	by mail.openembedded.org (Postfix) with ESMTP id 5ABD160881
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 May 2013 17:24:43 +0000 (UTC)
Received: by mail-ie0-f180.google.com with SMTP id b11so1284929iee.11
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 May 2013 10:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:x-originating-ip:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type:x-gm-message-state;
	bh=Jk6/mgsIab4o3bUEGsYG/urJ/3AhBHmia4Xx5piZ42k=;
	b=YgugyB7BOVZFCSrDGoEUack0QSTNriC+nD72S07LJEZC/MPT2Ts3VURNJb17Lt4UBb
	kVJSqGeAi4dFvylKpgpNPdYQ/EidaBsLWNZe5+s4U71aU9cAUlOyTERJfA/rMG6ctERK
	BhQ5wBTtza6YDcnWWn4L9BnZEYCX7fD9osjCjWWnoERILmVC13NHEzXIOOVOR5yz1ndx
	PsU8Y0JeRnqQFzi3YDDQhI2iJGkuPG8GZHLEW4TMtdJ5lapb9/jNtGVZsIb4ULAC9rUm
	9bzZfPi4FLm3ktcMCFwhpwvmuKzNFZ+2dcjHgG3quKU6q7a6aJwus2LYsxNzE6B8H4jn
	hfIA==
X-Received: by 10.50.50.6 with SMTP id y6mr11711474ign.90.1369934683857; Thu,
	30 May 2013 10:24:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.44.42 with HTTP; Thu, 30 May 2013 10:24:23 -0700 (PDT)
X-Originating-IP: [24.246.30.132]
In-Reply-To: <3360241.lzjhbPNm27@helios>
References: <CAGfZjq7x_OAHRw-_S8Rm0mZRa793dmnp36mpPCbTw18zvNKhEA@mail.gmail.com>
	<3360241.lzjhbPNm27@helios>
From: "William M.A. Traynor" <wmat@alphatroop.com>
Date: Thu, 30 May 2013 13:24:23 -0400
Message-ID: <CAGfZjq5QBijbXV2kvp0AkivFyDc7EE2F2HFAa5AxKcvz-tZwFA@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
X-Gm-Message-State: ALoCoQm6RKcw/gHjUVXWo2hz+tOqYyHyWPvp8ucod/g9qR7iiIG+OHPlBPXNWNJiG6jh6Ay1tfe4
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Hello World example for BitBake Manual
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 30 May 2013 17:24:43 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Thu, May 30, 2013 at 1:11 PM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
> On Wednesday 29 May 2013 13:28:11 William M.A. Traynor wrote:
>> In researching and trying to work through a Hello World example for
>> inclusion in the BitBake Manual, I've been able to reproduce the
>> examples described in the following thread:
>> http://www.mail-archive.com/yocto@yoctoproject.org/msg09347.html
>
> I think this example is generic enough for the documentation.

Excellent, I will use it as the basis for the manual content.

>
>> and in the following blog post:
>> http://hambedded.org/blog/2012/11/24/from-bitbake-hello-world-to-an-image/
>
> This however, whilst it is a very detailed and well written explanation, goes
> a bit further and is trying to put something together that's moving a bit
> towards what OE does, as an aid to explain how OE works (e.g. the introduction
> of an "autotools.bbclass"). I'm not sure this is really appropriate for the
> Bitbake manual IMHO. You could draw inspiration from parts of it though.
>
>> Does anyone have sufficient knowledge of each of these examples to
>> comment whether they're "generic" enough for the manual?  I'm trying
>> my best to keep content as generic as possible, but it's proving to be
>> a struggle at times.
>>
>> Specifically, I'm finding that it's possible to be to generic, and
>> thereby not adequately demonstrate the power of the tool.
>
> I know, it can be tricky. If you have specific areas you'd like help on then
> I'm more than happy to help though.

Thanks, I have many lately and will be posting them here.

>
> Cheers,
> Paul
>
> --
>
> Paul Eggleton
> Intel Open Source Technology Centre

