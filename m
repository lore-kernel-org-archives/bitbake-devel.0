Return-Path: <msm-oss@mcclintock.net>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id C38B0772E0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Dec 2016 09:42:49 +0000 (UTC)
Received: by mail-wm0-f49.google.com with SMTP id g23so54919179wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Dec 2016 01:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mcclintock.net; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=afv5n7wNcS/7hsWoe/8IylB8UCXNHEB+Him5YvclyG8=;
	b=MJEwJja1fCdmF4wBE9tyK4r2F7MXP0P/qaIXd8GxnBJhraQujI0c0AeX0yz25sPCQS
	tnUr9p8PGVUOeYZxkp3xz7GFi5qKp5xXE4qmep9un2NFaqkw406acrlviT19jmEEmuvq
	YKjLXkisoctDY/uujULwRVAksi3BhT0Oms8jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=afv5n7wNcS/7hsWoe/8IylB8UCXNHEB+Him5YvclyG8=;
	b=eOXeYQsFq9agULcvCj3LOiO6+UdVNGZZUXl+BDURSxqOIKQjKWbmL/xMAuPH8fhoMm
	RQ2k/ihp4wZIQQd1oXldeptxAL6kb43CEmxmhUHYVuJ40kUQbq6/bFAHtszuYrgkiFoq
	cRGnpiq7MvQxYFo9PzUtniNQsL3zuD/4AtOEvIVMbsf3OYu3kD/j4L6HFsXGa5yO22IP
	Ooof0dtJg6uosGbJCqU84eHbmA7yJ1gQ1eAMua10MfCl6eJIjuzfdR4laX3mUaOFixpA
	jN2KsNf6BrgXlmktqBLrp3UAT18t94JRTQGC3M5SIJ1zfEg4Y0ZSrCSgqQXujT17S6qu
	ytCQ==
X-Gm-Message-State: AIkVDXKjyaWENBUzxrSDrPyKP8SUeZ7fNduBDhCW6BXyqiVluT52qAG5mnxZC6Eet8w7bdkNu/OW+fLTtoXjpQ==
X-Received: by 10.28.184.88 with SMTP id i85mr5747424wmf.49.1481967770060;
	Sat, 17 Dec 2016 01:42:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.168.198 with HTTP; Sat, 17 Dec 2016 01:42:29 -0800 (PST)
In-Reply-To: <7610040c-55e8-10e1-8451-5c5842c82a60@windriver.com>
References: <1481880762-26028-1-git-send-email-msm-oss@mcclintock.net>
	<7610040c-55e8-10e1-8451-5c5842c82a60@windriver.com>
From: Matthew McClintock <msm-oss@mcclintock.net>
Date: Sat, 17 Dec 2016 10:42:29 +0100
Message-ID: <CAEsOVNeaQi2WybD+RK_5COYN5QSybMPUrSUkNxGhzKRgBALcHg@mail.gmail.com>
To: Mark Hatle <mark.hatle@windriver.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/wget: add Basic Auth from netrc to checkstatus()
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
X-List-Received-Date: Sat, 17 Dec 2016 09:42:50 -0000
Content-Type: text/plain; charset=UTF-8

On Fri, Dec 16, 2016 at 5:59 PM, Mark Hatle <mark.hatle@windriver.com> wrote:
> There was a recent change to wget that allows it to do an 'ASKPASS' when it
> needs credentials.
>
> This is how we handle that at Wind River.  We define a WGET_ASKPASS program that
> knows how to answer the credential questions [or prompt the user outside of the
> build system, i.e. via gnome].

This is somewhat tangential to the patch above though? You could still do both.

> (Passing anything on the command line, or even via .netrc is really dangerous.
> The command line due to 'ps' leakage on a multi-user system, and .netrc as the
> credentials are stored in plain text.)

I'm confused how is .netrc dangerous in this regard? The python
library actually won't use netrc if the permissions on the file are
wrong but I'm not aware of how there is leakage here? Maybe you're
just warning against parsing and adding to the command line?

-M

