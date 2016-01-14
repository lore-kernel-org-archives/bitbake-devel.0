Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 8C557731BD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jan 2016 16:51:59 +0000 (UTC)
Received: by mail-wm0-f41.google.com with SMTP id f206so441847824wmf.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jan 2016 08:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=CWZ8l0ahHXrArJue3IfHoVAHYf3KjpNN2eQs399OgGA=;
	b=v+qX32XcjALaE7tlfYHQNnfHYKbpjNScqX2DTF7JUgB8mQ7I5F+RAbY6EIVYM+Np5Y
	5H+Ab8SshzlX9yeSz4Ahxk699mqWKjRsVib/VBCWoKEqr3c02xZdZ2KREI3FKuXzvyge
	JuvtKibWgotlpE4S69A/0EcB5TGf6+lgshaGmjxlaiYaFikdCiOg8XHeva/snuKxTMRQ
	hu7+inWrBUAEIX/nb2wDpg2OUwlrEK0kxYkatl+vEGvGsizRbEQUdIqfAYR4+/gp6cAn
	o+msPf/iGhxRqowthNBIoThN/BYoThH1C6nWYSyq3MjT8Z3uYc2PTx4rMjIK8rGAgzXw
	aqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=CWZ8l0ahHXrArJue3IfHoVAHYf3KjpNN2eQs399OgGA=;
	b=JqS70peEQuFdHk/dpeIYsdEY04UMfLvdmTRdVp1E9UhF3CLLMofhtdHuTjmdEqA8by
	v3ha4kvr0Ijm93GYHS9rxOwHFkqkroNQyF/Bgm5h2Swfzj4eiDTMkNGPwwY3OiOPmxy1
	qLqpgsAyyBE/XbY3yyhRlJqOBhZINKghPv7WMcmKTcneqyjza6PjcXd9nHpWo43e7hBN
	Xjb/BHpssqK5eM1jEK/DCFDCrw7EVwFLO0DdfSyr+Jo1fze2ymmKwovZrHe091rgO2fr
	PzE3dNGKnYBztIhmT+aATdnnCUy+Mu8UZhCEwYK+d3VYIFwPysS9a4GIj8040RePKMV8
	MCdg==
X-Gm-Message-State: ALoCoQn6xcrjiPa9buJ8elcgVfuq59jzfZlII1w/Rxwpw7Wk20T5glSXJy0Rh7lqZFxqO10rzE/tODtIxEeW8IEw3RUfqwDIcA==
MIME-Version: 1.0
X-Received: by 10.194.156.199 with SMTP id wg7mr6095823wjb.114.1452790319820; 
	Thu, 14 Jan 2016 08:51:59 -0800 (PST)
Received: by 10.194.209.131 with HTTP; Thu, 14 Jan 2016 08:51:59 -0800 (PST)
In-Reply-To: <1452785159.28375.135.camel@linuxfoundation.org>
References: <1452172732.7598.114.camel@linuxfoundation.org>
	<CAJ86T=Xb6HHZm0BaqtGeCUknP1_dTy6t1L7LtZru9F+=j-BmSg@mail.gmail.com>
	<1452723582.28375.118.camel@linuxfoundation.org>
	<90f0d7cacc2743e58535b16f6fe316bd@XBOX02.axis.com>
	<1452785159.28375.135.camel@linuxfoundation.org>
Date: Thu, 14 Jan 2016 08:51:59 -0800
Message-ID: <CAJ86T=X9LU04NhjnaLtq+G7WSE6=9t2yiNF2MiuDrnn+M5exLQ@mail.gmail.com>
From: Andre McCurdy <armccurdy@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch/git: Change to use clearer ssh url syntax for broken servers
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
X-List-Received-Date: Thu, 14 Jan 2016 16:52:02 -0000
Content-Type: text/plain; charset=UTF-8

On Thu, Jan 14, 2016 at 7:25 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Thu, 2016-01-14 at 14:47 +0000, Peter Kjellerstedt wrote:
>> > -----Original Message-----
>> > From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>> > devel-bounces@lists.openembedded.org] On Behalf Of Richard Purdie
>> > Sent: den 13 januari 2016 23:20
>> > To: Andre McCurdy
>> > Cc: bitbake-devel
>> > Subject: Re: [bitbake-devel] [PATCH] fetch/git: Change to use
>> > clearer
>> > ssh url syntax for broken servers
>> >
>> > On Wed, 2016-01-13 at 13:37 -0800, Andre McCurdy wrote:
>> > > On Thu, Jan 7, 2016 at 5:18 AM, Richard Purdie
>> > > <richard.purdie@linuxfoundation.org> wrote:
>> > > > Some servers, e.g. bitbucket.org can't cope with ssh:// as part
>> > > > of
>> > > > the git url syntax. git itself is happy enough with this but
>> > > > you
>> > > > get server side errors when using it.
>> > > >
>> > > > This changes the git fetcher to use the more common ssh url
>> > > > format
>> > > > which also means we need a : before the path.
>> > >
>> > > This seems to break SRC_URIs using ssh to access self hosted git
>> > > servers setup following the process described here:
>> > >
>> > >   https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the
>> > > -Ser
>> > > ver
>> > >
>> > > An example of such a SRC_URI, which now fails to work:
>> > >
>> > >   SRC_URI = "git
>> > > ://git@mylocalserver.com:/opt/git/myrepo.git;protocol=ssh"
>> >
>> > Does:
>> >
>> > SRC_URI = "git
>> > ://git@mylocalserver.com/opt/git/myrepo.git;protocol=ssh"
>> >
>> > work though?
>>
>> The above may work, but this does not any more:
>>
>> SRC_URI = "git
>> ://git@mylocalserver.com:12345/opt/git/myrepo.git;protocol=ssh"
>>
>> I.e., when the Git server requires a port, like our Gerrit server
>> does...
>> Please revert the commit and solve the actual problem with
>> bitbucket.org
>> some other way.
>
> I'm not sure there is one other than special casing bitbucket urls in
> the fetcher.

But I don't think there is any problem with BitBucket. The original
bug report was caused by trying to use a URL with a ':' between the
host and the repo path. A URL like that does not work when prefixed by
ssh://, it's the same for GitHub URLs too.

> With Andre's case, we clearly don't support cut and paste of urls into
> SRC_URI so I'm less concerned about that but the above is more of an
> issue.
>
> The url parsing in the fetcher should really be aware of port numbers
> and I suspect if we do that, we can fix the above. I'm not going to
> instantly revert the other change over this.
>
> I'd also state that if you expect particular syntaxes to work, I'd
> strongly encourage they're in the selftests for the fetcher. The self
> tests didn't show any regressions...
>
> Cheers,
>
> Richard
>

