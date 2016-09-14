Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
	[209.85.218.65])
	by mail.openembedded.org (Postfix) with ESMTP id 56776601D4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Sep 2016 21:48:11 +0000 (UTC)
Received: by mail-oi0-f65.google.com with SMTP id c129so2521779oih.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Sep 2016 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=llSRFwquzh0HEgjqpf2xGFMad+ryg8fmBaYXoEJ5JfQ=;
	b=T3PK2eidG7QYRaG0igoUkm+w2UmOevtCHhIKUhyJBdsp3xAyiDfMqgFh3FBcyy9s2J
	9CPf1g8h6B4ztBbawc1Ry09VZtoRKrGk14IpqA96xw1Op0THYwQf6wG03bWd7a2kRGZG
	u85Jv/Oyv1qW/sucSAi+y4HIdO7wrzSb86/EvQXGWRdC3kCSwZMbbRCZ0cF5L5rxG+s/
	pjUMAQXon9Vp1235lK7xADXHR7Y5uQStGhtBLL5+Ci+jONbbXTLlh/Pj3O9bR7jaITC+
	Qhmrsh0DkJsr7oPVFNTCzaVNg1u1nZEW/P7x1ATud9bPn0TnQmspVXCBxr7WX593Ecpz
	rpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=llSRFwquzh0HEgjqpf2xGFMad+ryg8fmBaYXoEJ5JfQ=;
	b=P80aci6nS1L/PUTEGAdzfpyF/bUCS8I4VDBw+ZIWpEgbCD2vZaSDtEp61LZ0aSum/M
	9Qj/BLzyA9hmTRkeofLI0jBll9PC9msVfm+tZ19as8uYtgW/DYHMeWw5R2ZksqS59YU+
	UixdWesxcmA+y9nvoxdSau/avlYmzTr8NkZpY8IA8XhBjuXzc/SlI115nhx6hzySFbi9
	/HmGIM/M74XTT6SPHbPlzfM/SVDj3q7n14+CAOfpSyi/CdFJ5RdUHakXTMxtrQAuZ3tn
	jkWnOLday/tRFleaRDOxsEHd2HkRuXTM3FdX2Y7zYRiqLPV0415FnfGDVVndjsY2gfcb
	SNhg==
X-Gm-Message-State: AE9vXwMZRcH0geCqiYLzR2jbaeGiIHZvwB9cbXpH1cjXsPMHIjDGIDZ/fsC06UGku/ei6o9BetLqqM+srGXyyw==
X-Received: by 10.157.45.23 with SMTP id v23mr4203036ota.167.1473889692475;
	Wed, 14 Sep 2016 14:48:12 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.13.194 with HTTP; Wed, 14 Sep 2016 14:47:52 -0700 (PDT)
In-Reply-To: <1473888583.7207.63.camel@linuxfoundation.org>
References: <1473888583.7207.63.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 14 Sep 2016 14:47:52 -0700
X-Google-Sender-Auth: QjRpqEQR9lwwwDznRvSE756ncXs
Message-ID: <CABcZANnwTYkZefDtmM9nuTXn9mx2f8E6WtBOoM6-=Lcq6ZDoQg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] build: Allow dirs/cleandirs to work for empty functions
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
X-List-Received-Date: Wed, 14 Sep 2016 21:48:12 -0000
Content-Type: multipart/alternative; boundary=001a113df5d08eecd4053c7eaf46

--001a113df5d08eecd4053c7eaf46
Content-Type: text/plain; charset=UTF-8

On Wed, Sep 14, 2016 at 2:29 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Users are surprised when dirs/cleandirs aren't acted upon for
> empty functions. This reorders the code slightly so that those
> flags are acted upon for empty functions as there are cases where
> this is expected.
>
> [YOCTO #10256]
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Looks good.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113df5d08eecd4053c7eaf46
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Sep 14, 2016 at 2:29 PM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div id=3D":2ip" class=3D"a3s aXjCH m1572a9b294c0e4b3">Users are su=
rprised when dirs/cleandirs aren&#39;t acted upon for<br>
empty functions. This reorders the code slightly so that those<br>
flags are acted upon for empty functions as there are cases where<br>
this is expected.<br>
<br>
[YOCTO #10256]<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@<wbr>linuxfoundation.org</a>&gt;</div></blockqu=
ote></div><br>Looks good.<br>-- <br><div class=3D"gmail_signature" data-sma=
rtmail=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot com=
<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Se=
nior Software Engineer, Mentor Graphics</div>
</div></div>

--001a113df5d08eecd4053c7eaf46--
