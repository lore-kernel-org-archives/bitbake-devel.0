Return-Path: <alan.kozlay@ves.solutions>
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
	[209.85.210.170])
	by mail.openembedded.org (Postfix) with ESMTP id 606027F0DA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 13:03:28 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id q10so4282566pff.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ves-solutions-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Cf+4FhLcYhrLPIniYLQBRivOOxlsjnxUnUJvyFf3nmg=;
	b=J+QIvy7BiIRMQ1t32qkL6kG3aArJ/Ks46rBja3U5dI0iDGZP5KbRIrEqGr5SOpre0g
	Wh0NOt87QuaNFZ7a5vlrWx5R3nNTa3M2khcs7lZ01ZiflCS3G3dVzdRXV87vaaAjnJc6
	y6AIJZ9I5kCTeiO02l166lzGE9NKfHvsok+E31gvqE+dvGi6o4nWxYR4ksv4erZWKtI0
	7FHLTXhSHXNPE9GWwA1jXqWidwSlP83Yc9M3Vc32qB2EK8zrBLdIFgOE7n+h4s+PcgVN
	w6+UOFRzj+nS5/GQ17ytp6L7ggyt8nZcqojkF2d1K99NM7LxWqsGz75FkxnP3R0mvz/8
	44oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Cf+4FhLcYhrLPIniYLQBRivOOxlsjnxUnUJvyFf3nmg=;
	b=CcqxLDGceAwF4cP7hoKTj2TF6ZIgelc8s8ju5v5LpCwKQcA111eTGMypoHBFg7jrD1
	lDqEaTpEo+tJD6sBV24nFOqe93bGHFTCI6njfobg37RjVf5vG5OT5IrlJBiREKRmSEUd
	nEjVrHmqlK645blaocL2aHXknbNq3XkKxtQBRlOVbqEhSc6Uas+y9ZX/KL4FaFnc2i8L
	wh4lQx0ACPUMHyKVEEsGMcDtinJYgMaNzV4MOR0FlhikMmMEVVBd6WTdOArO8VLu3R0W
	VYnEtGKUqY8wQZvu7peXHb3h2esvZcNv4JQpCX8uj9c4l4Hs3sZmYm2JmlPHYktoYlOJ
	xwaA==
X-Gm-Message-State: APjAAAX+5XLQUlrXhQHxn8vnO0XS2vQbQSghgru+YmijVIf5KkfmJw7+
	IZmAHqHS4oCPB/nmrCMyD16+oVh83JyynvaeXDEyjGKr
X-Google-Smtp-Source: APXvYqybIiL4qG5Vkv80XxjUGKM7RU+AnQd5kLvddbdDfDruIpIlNjSbsiiEZ0IbIPbd61j44BZWwGJusHLXejzzlAM=
X-Received: by 2002:a63:d84e:: with SMTP id k14mr10778551pgj.234.1562936609174;
	Fri, 12 Jul 2019 06:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJE9sG=4MPryg2+h5a-jmhhpqPW=o6E26rte-JSPc31UioNbwQ@mail.gmail.com>
	<d12b286a3b55653e61d8d8e7672d87b374ae37d6.camel@linuxfoundation.org>
	<CAJE9sGmynaeD3uL-UBJnJt74rhv-sjSYjtQ=mNByQ69pVwaerg@mail.gmail.com>
	<a29ff39b8e26b1c9dd7d1f24e8991e93097225ec.camel@linuxfoundation.org>
	<CAJE9sGk59TaZiijPx5GqsJ7KVEeq3yW3ywTC7Z6phihCjua4mg@mail.gmail.com>
	<a964c86b9ef3301b22f75c2cc79af35cfa1ed598.camel@linuxfoundation.org>
In-Reply-To: <a964c86b9ef3301b22f75c2cc79af35cfa1ed598.camel@linuxfoundation.org>
From: Alan Kozlay <alan.kozlay@ves-solutions.com>
Date: Fri, 12 Jul 2019 09:03:18 -0400
Message-ID: <CAJE9sGmMNHgT_N1VQo7Qi+=M+7vxBiMeA0eMsiFE8KS37hUH3g@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Should multiconfig save build time?
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
X-List-Received-Date: Fri, 12 Jul 2019 13:03:28 -0000
Content-Type: multipart/alternative; boundary="00000000000065953b058d7b89ff"

--00000000000065953b058d7b89ff
Content-Type: text/plain; charset="UTF-8"

Cool, thanks!

Alan Kozlay
443-752-0323
Software Engineer
VES Solutions, LLC
Sent from my Android phone

On Thu, Jul 11, 2019, 12:14 PM <richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2019-07-10 at 11:58 -0400, Alan Kozlay wrote:
> > Thanks for the feedback.
>
> Good news is that with the basics of the work done, optimising the
> multiconfig case turned out not to be too bad.
>
> I've shared some further patches on the mailing list (also in master-
> next) and you could give those a try if you're feeling adventurous.
>
> I've shown they do the right thing in the test I wrote for it. Its had
> no real world testing as yet, you're at the edge of development here.
>
> Cheers,
>
> Richard
>
>

--00000000000065953b058d7b89ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Cool, thanks!<br><br><div data-smartmail=3D"gmail_signatu=
re">Alan Kozlay<br>443-752-0323<br>Software Engineer<br>VES Solutions, LLC<=
br>Sent from my Android phone</div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 11, 2019, 12:14 PM  &lt;<a h=
ref=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfound=
ation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Wed, =
2019-07-10 at 11:58 -0400, Alan Kozlay wrote:<br>
&gt; Thanks for the feedback. <br>
<br>
Good news is that with the basics of the work done, optimising the<br>
multiconfig case turned out not to be too bad.<br>
<br>
I&#39;ve shared some further patches on the mailing list (also in master-<b=
r>
next) and you could give those a try if you&#39;re feeling adventurous.<br>
<br>
I&#39;ve shown they do the right thing in the test I wrote for it. Its had<=
br>
no real world testing as yet, you&#39;re at the edge of development here.<b=
r>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div>

--00000000000065953b058d7b89ff--
