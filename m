Return-Path: <ross.burton@intel.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
	[209.85.218.65])
	by mail.openembedded.org (Postfix) with ESMTP id 4ED2379007
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 13:12:34 +0000 (UTC)
Received: by mail-oi0-f65.google.com with SMTP id j205-v6so33457147oib.4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 06:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=FZLLmukMyNGQFpGaXHej5HvSbeY7+pBeZUZxUK5uUrE=;
	b=FBbJ3lUS9fEflgoYi82Bq9O+E8Txko36sIUDfSPcnlo5/NJiluLXYsSxK6Wnc3ezG2
	4Az3naTpfiPuLDJGYCWO0m/WXttRP3IX1EjqcHQ4dO3tSgaTTz0sUUcO4WkV9sp016/f
	gg2MesuPFDe4oQbj+o99LnYf0AFoi4bzFIhX4DmzAetCsrzXyxB45+D7Ov6wwH2Md9BU
	yF/Ejvkg7MpiWhPdMf2ZwF1PmWDuaBifRj4rUrQj+BTOX6Q/pM9syd+ZnrvIaAQsgB2i
	jQzKB86FfUL9qSrXkwVx8PAG4hVClyUT8pvmqpTCh28VhZqLmHF1SuHv+yl0YHt0byRe
	uyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=FZLLmukMyNGQFpGaXHej5HvSbeY7+pBeZUZxUK5uUrE=;
	b=RtrpEkd1zVEkSsiRPmdaTXK0YWYZMUWiNa4h+/slTeXsYXmy6uNfF9T9oHdRUD97i+
	MsrTBLOhl/+cXOawc5QygD+7YVyti6ioyhxb3y/hNrsLRi/ktMTOCBXoyyfw7BFGxlXh
	D0/6tmsbr3rsVjdjV7IqOhWESqdiGSvZY3HWIUZ/wZvc7Qt3auc3Ooom3XPHongysKNS
	HSsPGb25NGLHIHgI57uATBiIQfui3Vqkx7NMLn5yi33F9ZAazQBDvrjkIAd52lWye7Vz
	OsTI/q2E2aTuPuXrrlqBVbR05/hNVlDic2SG5pZVCYPIaNnaL161v8FaT07Xl3z0WKYK
	Ugvg==
X-Gm-Message-State: AOUpUlGbmPz8G8JFeDEfyDBRcpx/8QdrOjmcBluzPR3MASd9jZCnoq3J
	TjONtiwtcti5MmSjGxmXKNK39meaAaRjzUs8ZhPieWyO
X-Google-Smtp-Source: AA+uWPxFWemnWKjAOwIqJx1YGR2A98tklpYwgUzNqtnk6YhJxJMGzOb7s1ATs4Gcxg9uUmLAJgnGd21XcMwl6cML1Mk=
X-Received: by 2002:aca:e185:: with SMTP id
	y127-v6mr24050912oig.245.1534252355392; 
	Tue, 14 Aug 2018 06:12:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:6845:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 06:12:14
	-0700 (PDT)
In-Reply-To: <49400e02-454a-42c6-e11c-0d72f9e191ab@prevas.dk>
References: <20180813180226.18299-1-ross.burton@intel.com>
	<49400e02-454a-42c6-e11c-0d72f9e191ab@prevas.dk>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 14 Aug 2018 14:12:14 +0100
Message-ID: <CAJTo0LajZO0NOr22aCTQ5X+JuZvtHGQhr9cS__8+vQnEJp5BoA@mail.gmail.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/2] utils/md5_file: don't iterate line-by-line
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
X-List-Received-Date: Tue, 14 Aug 2018 13:12:34 -0000
Content-Type: text/plain; charset="UTF-8"

Nothing whatsoever, I don't read bitbake-devel often so didn't spot
those.  The mmap approach is slightly faster though in my benchmarks.

If you have other patches which are not getting merged or commented
on, please ping the thread to remind the maintainers.

Ross

On 14 August 2018 at 09:33, Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:
> On 2018-08-13 20:02, Ross Burton wrote:
>> Opening a file in binary mode and iterating it seems like the simple solution
>> but will still break on newlines, which for binary files isn't really useful as
>> the size of the chunks could be huge or tiny.
>
> And what exactly was wrong with
>
> http://lists.openembedded.org/pipermail/bitbake-devel/2018-July/009407.html
> http://lists.openembedded.org/pipermail/bitbake-devel/2018-July/009409.html
>
> ? I have lots of patches and ideas for performance improvements in
> bitbake, pseudo and other components, but I'm not getting any response
> at all, which is rather frustrating.
>
> Rasmus

