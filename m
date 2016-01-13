Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id 813DC731A7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Jan 2016 21:37:36 +0000 (UTC)
Received: by mail-wm0-f46.google.com with SMTP id b14so393233180wmb.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Jan 2016 13:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=hQcHZpT8Rc79ri758eUy+ZFy7GAj39OTDlSO+E/+XaI=;
	b=ydRKlaR+SRYZbIR0pz/Rm8Zdnkzps1UiPQYxd7DhNFMF/7COTS3tdezX9xflujBfom
	0ha3MtCgfxOebySZYIFooUUTplMJXRMG9IHnxVUs5Me6WBOoRe3BGVv3rJX9IXtKxMpR
	yu4pMkjYmR9yNgfBZoZ9m3hYPsxu39FTwnn0CiyH9/s4WMZmWV9G2sA0yxo0r+fdZWO6
	O7v8Z8JeI96nFEs7k/aPKifc6r4QLqHstkV214sUuyNzjaKFlgacAu0zaPUF7HTdqLSd
	WpK9uLxVJrRrRa+jOO/sbXZDv6B+a287hOplzKFECVGhUm7ryCU+bsNfsFHPTs9WBo7K
	0RGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=hQcHZpT8Rc79ri758eUy+ZFy7GAj39OTDlSO+E/+XaI=;
	b=XpDKXMzzf0PmeOLa2dwRd2f2j3tssjM88hWKE0DcGQVZhxp8K0rt3rzCsN80DpFtkI
	X47iHzjVMfKqC7g8eoN7a7mvh+KJ37LV9Y7yCuAOH9f/g5Ntt2gUApTD28+xKcjISDdd
	ZHlGwrr2PxTLm7fphkEhxcia49/NdLBkZjGtRnEdXFe9kJhyf8yaljhOFlfUMVXFtB20
	7wvwS0g9pyBXThqHxPzqgaIh1cZqXFZk6gK9+Bcpsgwye9myzhb2KSqAd57gwD3SGZu3
	HBMeR9DGsKPjNdg0TmTFWgzIPQSWx+rJG/Lkc8vX6PkI/Oopgw/RT28D9x6niYeB241W
	gPNw==
X-Gm-Message-State: ALoCoQkTQrcveuJF+6+arsoAJQqakBXkPyt7S0zszeG40rE3fG2/t4+suqtWkVZkyoqVQ5ZOnoOvZTJl6JEiBeniZwxgHNogFA==
MIME-Version: 1.0
X-Received: by 10.28.182.133 with SMTP id g127mr11814426wmf.61.1452721056603; 
	Wed, 13 Jan 2016 13:37:36 -0800 (PST)
Received: by 10.194.209.131 with HTTP; Wed, 13 Jan 2016 13:37:36 -0800 (PST)
In-Reply-To: <1452172732.7598.114.camel@linuxfoundation.org>
References: <1452172732.7598.114.camel@linuxfoundation.org>
Date: Wed, 13 Jan 2016 13:37:36 -0800
Message-ID: <CAJ86T=Xb6HHZm0BaqtGeCUknP1_dTy6t1L7LtZru9F+=j-BmSg@mail.gmail.com>
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
X-List-Received-Date: Wed, 13 Jan 2016 21:37:40 -0000
Content-Type: text/plain; charset=UTF-8

On Thu, Jan 7, 2016 at 5:18 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> Some servers, e.g. bitbucket.org can't cope with ssh:// as part of
> the git url syntax. git itself is happy enough with this but you
> get server side errors when using it.
>
> This changes the git fetcher to use the more common ssh url format
> which also means we need a : before the path.

This seems to break SRC_URIs using ssh to access self hosted git
servers setup following the process described here:

  https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Server

An example of such a SRC_URI, which now fails to work:

  SRC_URI = "git://git@mylocalserver.com:/opt/git/myrepo.git;protocol=ssh"

----

Looking at the original #8864 bug report, the problem seems to be that
the SRC_URI used to access BitBucket contains a ':' where it should
contain a '/'. ie

  SRC_URI = "git://git@bitbucket.org:<username>/<repository>.git;protocol=ssh"

should be:

  SRC_URI = "git://git@bitbucket.org/<username>/<repository>.git;protocol=ssh"

which is a format which works fine for both BitBucket and GitHub.

(Unfortunately the BitBucket website does provide copy and paste repo
URLs containing the ':' which work OK from the command line but need
to have the ':' manually replaced with a '/' for use in a SRC_URI).


> Seems a shame to have to do this due to broken servers however
> it should be safe enough since this other form is the one most people
> use on the commandline so it should be safe enough.
>
> [YOCTO #8864]
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 5ffab22..10ba1d3 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -330,6 +330,10 @@ class Git(FetchMethod):
>              username = ud.user + '@'
>          else:
>              username = ""
> +        if ud.proto == "ssh":
> +            # Some servers, e.g. bitbucket.org can't cope with ssh://
> +            # and removing that means we need a : before path.
> +            return "%s%s:%s" % (username, ud.host, ud.path)
>          return "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
>
>      def _revision_key(self, ud, d, name):
>
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

