Return-Path: <msm-oss@mcclintock.net>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id C961A71DCC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Dec 2016 09:00:52 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id t79so123739664wmt.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Dec 2016 01:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mcclintock.net; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=RkCEq84SlBgpLQAMjQqYpr3i/soyjrjyUhoKG2JaaUY=;
	b=OSxjfBca2X+fk9SJPcFdqElROi9IL6bzfp+6qHrxGVbP0ORruAPRMWgLes7/7BLD9y
	L+oSldu78WxV0kf8VOOPj9pyDzKQeTErTQwEsRdE6JFvj2e2derA2RwTUaiQQIJLMzHE
	P/Fu7fcjm+wjekmSOq60Mjqq2iNbvaMpii2qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=RkCEq84SlBgpLQAMjQqYpr3i/soyjrjyUhoKG2JaaUY=;
	b=ksjMWwA7UcB4ljHdjm3msfejRP9wX2ln4x2nvS1MS6GAKxv3eYzWz21YOVfb5+GnXm
	H2nJgf3qTf1NiXgeNAG3lDl4CKn3aVFZhyNq0sfb0s4Sjn9ueZ3MsuMvFG8Qqn28kKI6
	Rn27DJQYIWf1GilzViyDnCT8xvjHmc1+Kx9t/hAkFD8VyksJWDrnkUuSwjglRK5Nmfew
	yx06VvG4IUYbiQUigLK8t3p/HAyVSxvS7LejdwJgkenA7un2y6NES1ZA1nKWWqVJBoxp
	QyM+/yAMO8U+abaXEQlG6UGt5XxUmxB0u6PIZJlkxpUBizKerNyZC/cvvKUW1mfKqDYJ
	aeBw==
X-Gm-Message-State: AIkVDXLd5yNRoG358CTBgk5CBI7a9nqjOODL6KtyrW80WMmTIqF/lxiKE9SiEXTdUddm+4Y4M9hW8aDQmNgy+w==
X-Received: by 10.28.0.210 with SMTP id 201mr847016wma.49.1482224453184; Tue,
	20 Dec 2016 01:00:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.168.198 with HTTP; Tue, 20 Dec 2016 01:00:32 -0800 (PST)
In-Reply-To: <5a9b5f14-3af6-25b7-c1df-9ddc8d01d804@windriver.com>
References: <1481880762-26028-1-git-send-email-msm-oss@mcclintock.net>
	<7610040c-55e8-10e1-8451-5c5842c82a60@windriver.com>
	<CAEsOVNeaQi2WybD+RK_5COYN5QSybMPUrSUkNxGhzKRgBALcHg@mail.gmail.com>
	<5a9b5f14-3af6-25b7-c1df-9ddc8d01d804@windriver.com>
From: Matthew McClintock <msm-oss@mcclintock.net>
Date: Tue, 20 Dec 2016 10:00:32 +0100
Message-ID: <CAEsOVNfM5TwodxXsZvqrhU7-9KQdaCnTwWZJPvkuD2Nwihi4KA@mail.gmail.com>
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
X-List-Received-Date: Tue, 20 Dec 2016 09:00:53 -0000
Content-Type: text/plain; charset=UTF-8

On Tue, Dec 20, 2016 at 1:50 AM, Mark Hatle <mark.hatle@windriver.com> wrote:
>> I'm confused how is .netrc dangerous in this regard? The python
>> library actually won't use netrc if the permissions on the file are
>> wrong but I'm not aware of how there is leakage here? Maybe you're
>> just warning against parsing and adding to the command line?
>
> The credentials are stored in plain text in .netrc.  This is a problem on
> multiuser machines, as often user home directories are world accessible, and
> often users forget to mark things like .netrc as private.
>
> Any time a credential is stored in plain text is potentially dangerous if
> someone can access the users directory.  (I don't consider .ssh credentials in
> the same category because people and ssh enforce the permissions on the
> directory for security reasons.  wget does not.)

Well you can only go so far to protect users, perhaps we could add a
usenetrc=true flag to URI's and then error if the permissions are
wrong or even just throw the error from the netrc python lib instead
of catching it?

Currently though wget uses netrc and python checkstatus does not so
I'd claim this is broken as-is.

-M

