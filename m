Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5374BC433FE
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 17:46:40 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com
 [209.85.222.53])
 by mx.groups.io with SMTP id smtpd.web08.9123.1636134399464431213
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 10:46:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=gJUItogk;
 spf=pass (domain: gmail.com, ip: 209.85.222.53,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f53.google.com with SMTP id p37so17385678uae.8;
        Fri, 05 Nov 2021 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wHavSbIZ6Oj8UbTS48nghANCLDJLAlaCIUhq5pM+ik=;
        b=gJUItogkirUtOuq0ZNbovzjaxE0ZyWsfQrX7mkY5GPEIEYUpA4H+fpovSH3XDUJngc
         8RI2HrRtQvyNjmMzKc/LGosUD1cA6qbkWUiYSFDVId+OKQLF8CfGTrwTMthjkSZNMbIV
         7948cbfdv+FMWB77nAAJQ1yVVmkuhWPXQGy+RIhVqzwW779OfGn5ICQlAr5lAWgG2EVb
         8t/orPh3TmWghcWhEZ7yDK73kkunYBw0t8xfH8ub2lTn2SNwRjsBawNPbYOEzHUARyFv
         MuSCyw8QpbTyXezUFgMZlWEUYVaoG9cdoZMcQ/717hj6m+ITCIVJFg8OQm7vC47xcDKw
         bbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wHavSbIZ6Oj8UbTS48nghANCLDJLAlaCIUhq5pM+ik=;
        b=XTVMXRSxBuwY6K+2hO1ViKDJMK8Tp3n4qPZA/O9lLWnN0wvaM/zwHH3RLf7Er5CtIu
         2yQ5fcd4ZK0To3kvox6qgfI0mxJ6Qrej7u1xUXoeexbdRZT/9mgK3h5sUIJmlW4GORlt
         csHPihtk+t7Hh/dsYD8wDUhfaJtWngwFKDspw/wods+7x85qjyFK+xVXz9FGNaVXCgCV
         aJfQJ9a4Ne7kDSQfz7zZN+kiKmSdPlHLVt+2hhYGoQDKG64rXsQMPbeYJdDwvK7pj9mm
         yHg9GKVzo9NGB6FOpIOuipO1LLZtxfVZsI9MrYKkbefuS15Vhe+pkokKLQ7vroI1LmFf
         JO1g==
X-Gm-Message-State: AOAM531jSo9rYyDyMw2gcQ+wM1u6CzbdZtaVNf9UP4xm3smhyr6zpWww
	yzs6cPPyr/xfI9QzqO0YWU4dY73X+18QZxdDRJRUi33y
X-Google-Smtp-Source: 
 ABdhPJyH7XOpb27s96u4ghJlUb/ScUVGAGgY+jxcdiJ4PHSgzslTI7FILuWWr8o95ARM6WQyU0geTKKPXC8JkTE/iM4=
X-Received: by 2002:a67:ae47:: with SMTP id u7mr75196830vsh.7.1636134398647;
 Fri, 05 Nov 2021 10:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211105133104.19895-1-jasper@fancydomain.eu>
 <CANNYZj_s8_PkKfMQnBxNZLs-p0F5xb4StCXiF84OkbE5zpptqw@mail.gmail.com>
 <ea3f24549a6e54f880e925e8f5cf6128fc5629f9.camel@iris-sensing.com>
In-Reply-To: <ea3f24549a6e54f880e925e8f5cf6128fc5629f9.camel@iris-sensing.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 5 Nov 2021 18:46:27 +0100
Message-ID: 
 <CANNYZj9sxmakRNGKUuH+ZAWDMJs2EhKT5O4f8HRxd=ovhQPpug@mail.gmail.com>
Subject: Re: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe for
 repo 2.17.3
To: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Cc: "jasper@fancydomain.eu" <jasper@fancydomain.eu>,
	"openembedded-core@lists.openembedded.org"
 <openembedded-core@lists.openembedded.org>,
	"martin@mko.dev" <martin@mko.dev>,
 Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000a2e2ae05d00e3920"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 17:46:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12916

--000000000000a2e2ae05d00e3920
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Nov 2021 at 16:24, Jasper Orschulko <
Jasper.Orschulko@iris-sensing.com> wrote:

>
> In our case some binary which is made up from some 50ish separately
> versioned sub-components. We used to have separate recipes for each of
> this components and static link them using DEPENDS. However, this does
> not scale well. E.g. if you want to create another version with
> different cmake flags, you would have to create copies of all 50ish
> recipes. You could move all the components into a single recipe and do
> 50x git fetcher, but keeping this versioned is still painful.
> Especially since the developers mainly don't use yocto but use the SDK
> for cross-compiling. As such this used to mean, that versioning in the
> development workflow and the release workflow worked differently ->
> more maintenance work.
>
> With repo fetcher we can streamline the versioning within the yocto
> build process and the daily developer workflow, as both can fetch the
> repo manifest from a central stored git repo. The idea is, that the
> repo manifest defaults to develop branch for all component repos and if
> we want to create a release we can use repos own tooling to
> automatically create fixed refspecs from the development manifest.
> something like `repo manifest -r -o release-1.0.0.xml`, push that as a
> release to the manifest repo, set this release as refspec in the recipe
> within the meta layer and proceed with the release process. So no more
> manually maintaining the component versioning within the yocto recipes.
>

I see. I don't particularly endorse that you invented a custom, proprietary
workflow that you have to support entirely by yourselves - instead of
finding ways to do what you need with standard yocto tooling, improving the
tooling where/if necessary. But if that works out ok for you, then fine :)

Alex

--000000000000a2e2ae05d00e3920
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, 5 Nov 2021 at 16:24, Jasper Orschulko &lt;<a href=3D"mailto:=
Jasper.Orschulko@iris-sensing.com">Jasper.Orschulko@iris-sensing.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
In our case some binary which is made up from some 50ish separately<br>
versioned sub-components. We used to have separate recipes for each of<br>
this components and static link them using DEPENDS. However, this does<br>
not scale well. E.g. if you want to create another version with<br>
different cmake flags, you would have to create copies of all 50ish<br>
recipes. You could move all the components into a single recipe and do<br>
50x git fetcher, but keeping this versioned is still painful.<br>
Especially since the developers mainly don&#39;t use yocto but use the SDK<=
br>
for cross-compiling. As such this used to mean, that versioning in the<br>
development workflow and the release workflow worked differently -&gt;<br>
more maintenance work.<br>
<br>
With repo fetcher we can streamline the versioning within the yocto<br>
build process and the daily developer workflow, as both can fetch the<br>
repo manifest from a central stored git repo. The idea is, that the<br>
repo manifest defaults to develop branch for all component repos and if<br>
we want to create a release we can use repos own tooling to<br>
automatically create fixed refspecs from the development manifest.<br>
something like `repo manifest -r -o release-1.0.0.xml`, push that as a<br>
release to the manifest repo, set this release as refspec in the recipe<br>
within the meta layer and proceed with the release process. So no more<br>
manually maintaining the component versioning within the yocto recipes.<br>=
</blockquote><div><br></div>I see. I don&#39;t particularly endorse that yo=
u invented a custom, proprietary workflow that you have to support entirely=
 by yourselves - instead of finding ways to do what you need with standard =
yocto tooling, improving the tooling where/if necessary. But if that works =
out ok for you, then fine :)</div><div class=3D"gmail_quote"><br></div><div=
 class=3D"gmail_quote">Alex<br></div></div>

--000000000000a2e2ae05d00e3920--

