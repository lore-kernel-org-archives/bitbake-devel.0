Return-Path: <otavio.salvador@ossystems.com.br>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id 6547C77155
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Feb 2016 16:43:59 +0000 (UTC)
Received: by mail-pa0-f42.google.com with SMTP id cy9so16177504pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Feb 2016 08:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
	h=from:mime-version:in-reply-to:references:date:message-id:subject:to
	:cc:content-type;
	bh=QU8ojMJ4rsNJcxFlv8twyEPF6k1nG1OCMSW487jhOBQ=;
	b=gKUrys0RzAKSEE9jEGiiBr4+5bf7Dwq2VQK/6QkiAyoxgfUCbZf0Qb9HpbEorKxAng
	aQwP9gtuwkKsfMEmcggd9WouMKt6tyltC/V1NfSvoHLl+2Wz2As9gyv0lI1jO7wj5KoF
	oAKSdHdL+ChMbzk8tdTrdps1Er9Zo4uwd3LjBNCDU6/uFbJ31y8DtKHaFCxL0yg/1pqs
	poEo88+jKj2Dc7HPli/XH7WTXUdzSYHvSW4t3rF3GzqNOjN1b4tvGM3C+RKNx1tMHrV0
	ZfGTCIM1+g027W/rTuWT/xcqTtJLGo6s4SBLyyiGRpYVToBb8pTIe4PYSKxPvcJ2yAwd
	icwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:mime-version:in-reply-to:references:date
	:message-id:subject:to:cc:content-type;
	bh=QU8ojMJ4rsNJcxFlv8twyEPF6k1nG1OCMSW487jhOBQ=;
	b=hSlA8NkmB+XmvxZk0w+geApC/RWyNgw5uIEb81RcQzT5d/qkR5ZlEYFx/t1tLcM2Td
	Rpv7JRQH0DLpcCD5n+wX+krq8s55i4A6GeSjXB/6XqBNwASLj7VBM3VHAa8nBdjesaMW
	Deg0JJEzon2vz/l4k6bwDsu3YI3JdLjc70AXTI/e5/gmgcDLg2CODnsYCFNvl1tlsZ6d
	II+X4tRcxz1dCEfz7PMToMM1sf0qKy6AwXYws+XoX0jNcE4mpwOsAxIQhJcNweevwJxB
	PuQXlkWFA+aojO3A59dF6gDM+fmjym1eMs7b0YhAV8JE/po1m4N6X8VGbYgelUEH+arT
	XTUA==
X-Gm-Message-State: AG10YORjlz1cSdDJJNlz1k9HFQUV0qfKPcyvsVDZ4qiFIaSO7E6dIWwR0GkOIwOTrJMb4g==
X-Received: by 10.66.101.74 with SMTP id fe10mr3697880pab.66.1454517840406;
	Wed, 03 Feb 2016 08:44:00 -0800 (PST)
Received: from mail-pf0-f177.google.com (mail-pf0-f177.google.com.
	[209.85.192.177]) by smtp.gmail.com with ESMTPSA id
	dz8sm11048107pab.19.2016.02.03.08.43.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 03 Feb 2016 08:43:58 -0800 (PST)
From: Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-pf0-f177.google.com with SMTP id o185so16504276pfb.1;
	Wed, 03 Feb 2016 08:43:58 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.98.12.221 with SMTP id 90mr3653346pfm.95.1454517838386; Wed,
	03 Feb 2016 08:43:58 -0800 (PST)
Received: by 10.66.72.229 with HTTP; Wed, 3 Feb 2016 08:43:58 -0800 (PST)
In-Reply-To: <20160203150638.GB2567@jama>
References: <1454457340.27087.143.camel@linuxfoundation.org>
	<CAP9ODKqGa0Lurxye_+TviFbxBT-d3sf2D3tD_WiR9er_RcFsKg@mail.gmail.com>
	<1454498556.27087.180.camel@linuxfoundation.org>
	<20160203150638.GB2567@jama>
Date: Wed, 3 Feb 2016 14:43:58 -0200
X-Gmail-Original-Message-ID: <CAP9ODKopXQJn_cgCAAKsJBwjYUig5az1rKSzfGiTG13MHZCoKA@mail.gmail.com>
Message-ID: <CAP9ODKopXQJn_cgCAAKsJBwjYUig5az1rKSzfGiTG13MHZCoKA@mail.gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] [PATCH] data_smart: Drop default expand=False to getVar [API change]
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
X-List-Received-Date: Wed, 03 Feb 2016 16:44:01 -0000
Content-Type: text/plain; charset=UTF-8

On Wed, Feb 3, 2016 at 1:06 PM, Martin Jansa <martin.jansa@gmail.com> wrote:
> On Wed, Feb 03, 2016 at 11:22:36AM +0000, Richard Purdie wrote:
>> On Wed, 2016-02-03 at 08:11 -0200, Otavio Salvador wrote:
>> > On Tue, Feb 2, 2016 at 9:55 PM, Richard Purdie
>> > <richard.purdie@linuxfoundation.org> wrote:
>> > > At some point in the future, getVar should expand by default. To
>> > > get
>> > > there from the current position, we need a period of time where the
>> > > expand parameter is mandatory.
>> > >
>> > > This patch starts that process. Clear errors will result from any
>> > > code
>> > > which doesn't provide this. Layers can be fixed with an expression
>> > > like:
>> > >
>> > > sed -e 's:\(\.getVar([^,()]*, [^,()]*\)):\1, False):g' -i `grep
>> > > -ril getVar *`
>> > >
>> > > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> >
>> > I am in favor of making it mandatory but I fail to see what we gain
>> > in making it expand by default in future.
>>
>> Less ugly syntax, in 99.9% of usages, you would want expand=True and
>> getVar("X") is neater than getVar("X", True).
>
> Consistent indentation is also neater than mixing tabs and spaces, but
> you were refusing to take such cosmetic change and now you're proposing
> neater getVar syntax which is (in some cases silently) breaking existing
> metadata and make backporting changes more difficult?
>
> I'm not opposing the change, just don't understand why the same
> arguments work here and not for indentation.

I second Martin's comments here. I would like to see more consistency
applied to the metadata. I know that some people will have conflicts
when rebasing out-of-tree code but this is the price of not
upstreaming code.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750

