Return-Path: <raj.khem@gmail.com>
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com
	[209.85.223.175])
	by mail.openembedded.org (Postfix) with ESMTP id 068756E719
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jan 2014 22:39:37 +0000 (UTC)
Received: by mail-ie0-f175.google.com with SMTP id ar20so6677212iec.20
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jan 2014 14:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=jE29FKYuvskg8rCtEvee2sNPb85b8DdcL2nlzigCCzA=;
	b=w68+a7AdV0ZvXb+NdmYULZeR0GnxO6hU9YaMv3o+qeZxQJ6PyOJn5J/b5n1EpTNOOD
	cBvBUPpacj5Z/T4pLfmar3IgK+rLdLfTbQPes5Mn4jn9ONE9bjthYVF0lVUSroai8NNI
	Y+8j70k73h9OvBkBP3hgVzuBaW72FoyNJ7ZBBV3Mqtb3B/k/TDNGCqDPdIVBSmcaxpmi
	dJPBg0oc2OR7SFW0ivmCkNlMIg2i4zeWptegnl/BQaaNltpcNoTi35KWRIaXiObl+nwW
	J1dMjWvy7TVDfhp4qfjUte8y8za/t4yySqhHgkyrWyYLtaeROJBraArkSead2Q8QLcZJ
	bggQ==
X-Received: by 10.50.154.161 with SMTP id vp1mr19609876igb.17.1390862379077;
	Mon, 27 Jan 2014 14:39:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.50.8.137 with HTTP; Mon, 27 Jan 2014 14:39:08 -0800 (PST)
In-Reply-To: <1390833424.17424.251.camel@ted>
References: <1390833424.17424.251.camel@ted>
From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 27 Jan 2014 14:39:08 -0800
Message-ID: <CAMKF1soPEMALs27a1f2Xi7upTgbt9EDix-dACYLct+QDt_3+hw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker: Add option of specifying indvidual tasks for targets
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
X-List-Received-Date: Mon, 27 Jan 2014 22:39:39 -0000
Content-Type: text/plain; charset=UTF-8

On Mon, Jan 27, 2014 at 6:37 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> Currently its near enough impossible to tell bitbake to run target X,
> task Y and target A, task B. We could hack various parts of the API
> around but it would mean incompatibilities.
>
> An alternative is to accept the syntax "<target>:do_<task>" as a target
> name. The default task would be used where the task is unspecified.
>

This should be documented in manuals as well IMO

> This has the advantage that its neat/clean code and works from all
> current APIs including the commandline.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index db4cb51..cc7d84e 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -449,9 +449,14 @@ class BBCooker:
>          current = 0
>          runlist = []
>          for k in fulltargetlist:
> +            ktask = task
> +            if ":do_" in k:
> +                k2 = k.split(":do_")
> +                k = k2[0]
> +                ktask = k2[1]
>              taskdata.add_provider(localdata, self.recipecache, k)
>              current += 1
> -            runlist.append([k, "do_%s" % task])
> +            runlist.append([k, "do_%s" % ktask])
>              bb.event.fire(bb.event.TreeDataPreparationProgress(current, len(fulltargetlist)), self.data)
>          taskdata.add_unresolved(localdata, self.recipecache)
>          bb.event.fire(bb.event.TreeDataPreparationCompleted(len(fulltargetlist)), self.data)
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

