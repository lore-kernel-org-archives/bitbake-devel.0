Return-Path: <ulfalizer@gmail.com>
Received: from mail-vk0-f43.google.com (mail-vk0-f43.google.com
	[209.85.213.43])
	by mail.openembedded.org (Postfix) with ESMTP id 70EDB731FC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 20:20:22 +0000 (UTC)
Received: by mail-vk0-f43.google.com with SMTP id 16so134002788vko.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 13:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=9y6C68g7uzTwYISA8QVJfNMTE4xJTNMzQvaWQSfv6Zw=;
	b=aTix01M5KF/FC8Jq0N1ZIdqlflOa5GYh9ysjchLzBoMy0gyAQJS1F7nrPmQBFE2/bu
	Hg8aaPXsGuBSg9paWjnRp9NG7z+sMajtRTVH8kiuBGqdPRsYD5C1Dw14XFjaSjJxwUHY
	hNesO3iEbglc2v6Il5xyXaeGgOBcwoTGVcHOdAqCERgZwRSzLlMdHLnI5sbYLjwJsAkM
	H+PrJLSy4xdROMKPmggIR98JqXY8ADWbXRIVdeaYkI71e0dR9BjShYEI8gcv8YRzs4Xg
	6q+098kazI3CBzan6WCYHyCWR8bjatEdUsAG1a6SnyEElLu01TIeH10eTYebRbEiQmBj
	O9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=9y6C68g7uzTwYISA8QVJfNMTE4xJTNMzQvaWQSfv6Zw=;
	b=Wq1YcgZA3LeB+nai+ttlZ+ZfaPRJwOs72+9cvW4/JGabnR+g3NzvSpDMy2QYIvxL6o
	a2Zh9/P3MoclZPSvi2cKq+gymmopnG2jqybmq3jkFaGZFxspNG6cRB7GNCIUMv+2OYRw
	EkZCjSyB2H6cBXlxP9aJpspLuooZmZBV9mz60MMpZIUhiuZSmMmWFIXRHfHLdjSxBnA4
	oCgatnBoJ0z13gxh4ImGtp6NbeXU31tTcRjj81q56RYLqFc4a5Jdbdxv9bfq/ohZsaX/
	cfNkeTDa75eaJV1usr4LsG74q+W5yXkV5UP2wsYKN9p+y5bdWiBW05iNPxoS8+euf0Q0
	IuUg==
X-Gm-Message-State: AE9vXwPr7g17L3etAkd/1xdz+Apfl8UXXD2TDU1cP/B+GclB8MIlb5gsf2RwkDHviYbEVMP2Oq6Djdvd9U5Jlw==
X-Received: by 10.31.124.133 with SMTP id x127mr9548808vkc.43.1473711623515;
	Mon, 12 Sep 2016 13:20:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.48.146 with HTTP; Mon, 12 Sep 2016 13:20:23 -0700 (PDT)
In-Reply-To: <1473711412-22161-1-git-send-email-ulfalizer@gmail.com>
References: <1473711412-22161-1-git-send-email-ulfalizer@gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 12 Sep 2016 22:20:23 +0200
Message-ID: <CAFkk2KSXctSDxxHCUq2gx3shDfSQ9osshxO9VudX=Wf7akzJNA@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: fetch2: Make SRCREV_FORMAT name substitution safer
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
X-List-Received-Date: Mon, 12 Sep 2016 20:20:23 -0000
Content-Type: text/plain; charset=UTF-8

On Mon, Sep 12, 2016 at 10:16 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> Given two names "foo" and "foobar" and SRCREV_FORMAT = "foo_foobar",
> "foo" might currently get substituted twice. Work around the issue by
> sorting the list of names by length and substituting longer names first.
>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index 11c75cc..4ca024e 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -764,7 +764,10 @@ def get_srcrev(d, method_name='sortable_revision'):
>      seenautoinc = False
>      for scm in scms:
>          ud = urldata[scm]
> -        for name in ud.names:
> +        # Sort the list of names and replace the longest names first. Given two
> +        # names "foo" and "foobar", this prevents "foo" being substituted twice
> +        # in "foo_foobar" (and "foobar" from not being substituted at all).
> +        for name in sorted(ud.names, key=len, reverse=True):
>              autoinc, rev = getattr(ud.method, method_name)(ud, d, name)
>              seenautoinc = seenautoinc or autoinc
>              if len(rev) > 10:
> --
> 2.5.0
>

A syntax like the following would have been safer, but it might be too
late for that now.

  SRCREV_FORMAT = "{foo}_{foobar}"

Cheers,
Ulf

