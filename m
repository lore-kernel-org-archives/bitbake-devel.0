Return-Path: <ulfalizer@gmail.com>
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com
	[209.85.213.52])
	by mail.openembedded.org (Postfix) with ESMTP id BF224600E3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Oct 2016 11:12:19 +0000 (UTC)
Received: by mail-vk0-f52.google.com with SMTP id 2so66819274vkb.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Oct 2016 04:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=60925/7nTVifq2VcLGeBV0AYIIl88SRdW3UeNmuoSCg=;
	b=jmdB8gkRORpH8jrUv4duAqqMkZ+VzRVX6e6QBduA0zABmqdhHPP91yiBqb06kiTIqM
	Vd0oIbfcwzVtfz3tgNg8Z1OVVNnk/1aHpli5P3pnCVW97mDIdtdd1siX99Ge5mkRxDvd
	RFDMTdNmhifELKNKDcOeOOj8F7WyjUqPhVAfAIbiv5i4Yqm/h8wpW1vZFNDBQBcsrAMr
	MgTSL9GEDb8lg2LDWb1ILXZeXnY9E94Avjkuo98dq+dh99AVDp1kDRGsptJ9z9LKcJ+g
	TCzyvrrWhwtk6tIvmUQ06jGk5ayK3tADHE3UxnVsFjyS4gApjnikxdgeDXhvILa7wUPP
	jq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=60925/7nTVifq2VcLGeBV0AYIIl88SRdW3UeNmuoSCg=;
	b=Gb+6mL6Oi/pxA6GXs1J2KI98xM0NlFZ2EQlaB6cy6b/rVwq/RTx7xe84gBJuoee+uS
	Y8tJIWTBBfx9fUODoJt1Ok5skudqjBmXNahysbhnJaSGejxBJ22PIpyupQImzwKT/dqy
	kVouOYiAfIOSDmuJCCp37tWf9MmDq9L54RRW7M71jUtLkSUeK+wGQ3YdZzseOYwSFTuW
	EVIDTgv+Z9mpykB6Tsgq3CeYpvDot46EQvgyNiKkEBaaDbk/9XzKpAHZ21bASSWEIgq9
	8yyIzaHfhxslmTgpCSUb4d9+isBnlJqNwMQmRe99USi7oTaORWK4ZIU5ybW1OLQH55/g
	5tBg==
X-Gm-Message-State: AA6/9RnJGZvY+v02oh7Ttkt+8S74wBqxr5pTc/94AmWcAzO9lbOOjg4dPqC/O9lficpAgTZCgagD1kOLmoiCcA==
X-Received: by 10.31.227.129 with SMTP id a123mr107464vkh.65.1476961940567;
	Thu, 20 Oct 2016 04:12:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.153.194 with HTTP; Thu, 20 Oct 2016 04:12:19 -0700 (PDT)
In-Reply-To: <CACfi_Z10fp9_iL9FX_jHSgES=N6CF+uBv2ouVSyb-ab9wtbLcQ@mail.gmail.com>
References: <CACfi_Z10fp9_iL9FX_jHSgES=N6CF+uBv2ouVSyb-ab9wtbLcQ@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 20 Oct 2016 13:12:19 +0200
Message-ID: <CAFkk2KQHDr5qWMh2fmn2ewLyn7EaS2bQ8VaY_PUYNk8OeG5b3w@mail.gmail.com>
To: Davis Roman <davis.roman84@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Difference between inclusion and inheritance
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
X-List-Received-Date: Thu, 20 Oct 2016 11:12:20 -0000
Content-Type: text/plain; charset=UTF-8

On Tue, Oct 18, 2016 at 11:50 PM, Davis Roman <davis.roman84@gmail.com> wrote:
> Hello Bitbake community,
>
> I'm a bitbake newbie and so naturally I'm becoming familiar with the bitbake
> documentation.
>
> I came across something confusing ( well atleast for me ) regarding the
> difference between optional/required Inclusion versus inheritance.
>
> As far as optional/required inclusion is concerned, the documentation states
> quite clearly that the main difference is that the former will not issue an
> error message if the specified file is not found while the latter will so
> there is no issue here.
>
> My issue has to do with the 'inherit' command. Sounds to me like 'include'
> and 'require' already do the trick so I'm curious to know what value does
> 'inherit' bring ?
>
> Any clarification would be extremely appreciated.
>
> Thank you,
>
> Davis

Hello,

One important feature of 'inherit' is that it only includes classes
once, even if they are inherited multiple times.

Say your recipe uses two classes that both in turn use the same helper
class foo.bbclass for example. With 'include'/'require', you'll get
two instances of foo.bbclass, which could break things (appends will
turn into double appends, etc.) With 'inherit', you'll get a single
instance of foo.bbclass.

I'm not sure if this is well documented at the moment. Consider
filling a documentation bug at
https://bugzilla.yoctoproject.org/enter_bug.cgi?classification=Documentation
if it isn't.

Cheers,
Ulf

