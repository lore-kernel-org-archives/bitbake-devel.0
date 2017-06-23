Return-Path: <msm-oss@mcclintock.net>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
	by mail.openembedded.org (Postfix) with ESMTP id F1066780EC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Jun 2017 15:18:16 +0000 (UTC)
Received: by mail-pg0-f65.google.com with SMTP id f127so6501591pgc.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Jun 2017 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mcclintock.net; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=95VwYyLXDIvDvG6JEcrg0MLclRrfkGBKuy/bPF0U+P4=;
	b=OqcuQ9hoTHX2csLf1ztRZTSFE3Y0IjDw4e9IvyNW/H85yZKJjKTU0h4yXGnZMBq5ZR
	94R+4lpaes0NfcLjNMyOkwd9WxeprvnmZArG+5PsvzJ0OD8DhnsrZTxxqEd4ICQeOoR8
	C49Fn2kVQcb1hKfRsAU7OoNhZjLHANiLtSKO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=95VwYyLXDIvDvG6JEcrg0MLclRrfkGBKuy/bPF0U+P4=;
	b=S6DPw1vzLsemugj0g0q5X0RXP2m+rayj1Ts48kciJhRFqhHeVi3+GVqSKIZj+dx/Q0
	CwAC+pUjr6NFIaFZgoenGz1WLXlmdXISt+2XYMQN6EdqDhzoo7kdKV2LAd/ohFMIH8LC
	WJf74mrSUWl7+2G2xZVQmQfebFowgFjDflFYDJf0JxCj23Bt9LObVctIYCQkwgg9L/CA
	+TLcqTs3S2xJTjVvxoTVtkwa6zl4ZWQxojqdvNVbJRielJuLYv0E/7pyOqly2dcVe9FS
	gkGumuEZ48w7fUbS9MJquOwH1cqm1vb0WwjnmqU6WrUMZP/cUxBamtOZnYeFYXO96QH4
	ni1A==
X-Gm-Message-State: AKS2vOyNQgP4FUhdK12kjBV2+bds/pRYdMYVGmLS6mdsPesClQ6bHyys
	9yDdvXX2GVpvOQIFyjlathoPEOnbpTPs
X-Received: by 10.84.212.151 with SMTP id e23mr8330544pli.115.1498231097927;
	Fri, 23 Jun 2017 08:18:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.130.73 with HTTP; Fri, 23 Jun 2017 08:17:57 -0700 (PDT)
In-Reply-To: <1498229869.24449.133.camel@linuxfoundation.org>
References: <1496408567-18673-1-git-send-email-richard.purdie@linuxfoundation.org>
	<CAEsOVNfCAwNkq=dnBWgX=0XXbP7510GRx4Ga=EbYf5yr34vdGw@mail.gmail.com>
	<7c5e6653-c5a4-6622-b40f-58f80a238c07@gmail.com>
	<CAEsOVNcKduRtHRP9rd4TjDcy3zw5hqe-FtHHEqvMaW4BmOMLgg@mail.gmail.com>
	<1498229869.24449.133.camel@linuxfoundation.org>
From: Matthew McClintock <msm-oss@mcclintock.net>
Date: Fri, 23 Jun 2017 10:17:57 -0500
Message-ID: <CAEsOVNdgwOAsbp2VCJaELxGa62sHXR7rTsYMr1oJgEhT_F69wA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, akuster808 <akuster808@gmail.com>
Subject: Re: [PATCH] siggen: Make calc_taskhash match get_taskhash for file checksums
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
X-List-Received-Date: Fri, 23 Jun 2017 15:18:18 -0000
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 23, 2017 at 9:57 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Fri, 2017-06-23 at 09:29 -0500, Matthew McClintock wrote:
>> On Thu, Jun 22, 2017 at 5:29 PM, akuster808 <akuster808@gmail.com>
>> wrote:
>> > On 06/22/2017 02:10 PM, Matthew McClintock wrote:
>> > >
>> > >
>> > > Seeing this issue on some older (err, really olderrrr) versions
>> > > of
>> > > bitbake. How far back could we backport?
>> > Technically 1.34, 1.32 and 1.30 (krogoth). How far back is
>> > "olderrrr' ?
>> I guess I'm seeing this on krogoth so that would be good.
>
> Did backporting the patch fix it? There are a variety of ways you could
> hit this error and I want to confirm it was this specific issue you
> were hitting...

Yes, we had an identical fix actually.

-M

