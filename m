Received: from mail-wg0-f51.google.com ([74.125.82.51])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <twoerner@gmail.com>) id 1Txh64-0005e3-DM
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 Jan 2013 17:53:18 +0100
Received: by mail-wg0-f51.google.com with SMTP id 8so2792387wgl.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jan 2013 08:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:in-reply-to:references:date:message-id
	:subject:from:to:cc:content-type;
	bh=5QSgFB6CmIIaKnNvz25lAf3q34JNgyp2EVWBuGXrBms=;
	b=xzayIJZvQFYkf6SVGyTiytF+qsZ2xZAaUGujw21UHClyAx94ry6F5jpcAdTQSx+DE1
	LltRIIQOnvTvLz4saOkWwj4nQx+ze6ucMg8RVzpO7Y+oqCZwArzhoLNTNlZCt+gK66Mv
	tuP9kNjexgWwN4L5efvRHrl0lBYZ/LugKxK86gRCcJENmUEoVwmXUEpuNbsbSw7lfbBV
	A4Y1VH4B2uMimP8dXY6IRQFs2fpAQihS0YOYugOl/G52e+Aa4/hq05MDANE0WuvMtmq3
	9PJburRIBNL0TT4gKHzXcDGqmdyOOanrFDbISWoQfUL0umTnzDZnul0UMj47PfXBLX0z
	UGHw==
MIME-Version: 1.0
X-Received: by 10.180.82.69 with SMTP id g5mr22533034wiy.21.1358872660997;
	Tue, 22 Jan 2013 08:37:40 -0800 (PST)
Received: by 10.227.132.205 with HTTP; Tue, 22 Jan 2013 08:37:40 -0800 (PST)
In-Reply-To: <6811518C-5E13-40A7-8B8B-57C2810DEA8B@gmail.com>
References: <6811518C-5E13-40A7-8B8B-57C2810DEA8B@gmail.com>
Date: Tue, 22 Jan 2013 11:37:40 -0500
Message-ID: <CAHUNapSSaOqnkOZq3_BaMthqY6hG+JTxvi9XpgD_38yT6+wDhA@mail.gmail.com>
From: Trevor Woerner <twoerner@gmail.com>
To: Trung Hoang <trungiee@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Display mode
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 22 Jan 2013 16:53:19 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jan 22, 2013 at 1:20 AM, Trung Hoang <trungiee@gmail.com> wrote:
> The current git HEAD of bit bake nicely displays the x threads and what is happening on them instead of constantly scrolling in detail what is exactly happening.

This feature is called "knotty".

> Is this feature configurable? How do i enable it on older versions of bitbake? As the gumstix setup scripts check out a older version of bit bake and it displays reams and reams of info.

Knotty was added this past... August (?) (or, perhaps it is more
correct to say "it was made the default" this past August?). So making
it work on older versions would require back-porting it to those
versions.


