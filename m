Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web12.138711.1598032401796274125
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2020 10:53:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZMPtKxqg;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: jeff.dagenais@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id dd12so1004776qvb.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2020 10:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3ZMJyW8KyPRSbpCxR0WZKBAe1EXJIUbN8tSbTetQwsM=;
        b=ZMPtKxqgCI2ATph1mCQleezB7E6Sx68xynjbgwGMTAe8sMiZ45IVONmW6ENc0KkH8A
         I4+4HdEEAiVWLhjCeWjRYfCcV+3XQ4nB723ff1rtgG72oIVZTNeScxONeTMgBzhD4t18
         Is8edoZKq1XGv+N7PKw4904OV0hxbcRJAcdgOThlSOUHn/Msp1N5ZUFEU+ZlpWHpusFT
         3wOOuOwAhCv9m8RBIq2a79bLmlfNUCvUS224eAfraWrFtgupQgvMqvfgR9dWq50CoUW0
         BjTtgygDj/1b+WU4IxR8Zjx6146HiftqnX5DOLOAoXHSEkTZ2R9Fo6uu6V9RBcHu64v8
         C1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3ZMJyW8KyPRSbpCxR0WZKBAe1EXJIUbN8tSbTetQwsM=;
        b=sZmibUxZJLFncGV6GPQ78TYLo+O8XM5nJXVZSBJKecU/dtBu5MeltbIA8pu2QOAkTS
         NtdGrIaVPPEGrcpZuc02GIpod7FDw7QOGftnY2+azrbO+A9cMb8/E3WIElko3VlOlb5b
         YtGw2OWY6hZXT4gWwby99Bs+hzFsT+AK2b/qOaCb/ZkeS0y047hAjCEac1qsxb+/u8Ym
         PeQYBFO5U+k8zAf4LxFK2tR6iAh6s9EqXOBchbWs/eD3XjULlHnKjfzwTeQccK3vFWvX
         IqywNW37+WLPMjMz0fPZdi3TzajDDLEcvFhl8oFKuijnq46k8I4ZoB6z119aXp3ytrPU
         i6lA==
X-Gm-Message-State: AOAM53167eSa/tO6v+cDFyzkU0lI69zw3SGDU3Y2jFSkszsIP+DEuB4L
	S0lswezylGE9BOsgs9A85kA=
X-Google-Smtp-Source: ABdhPJxnxT6JiXnzQcX2QCmY1ynGpc8CPfRvi6d9g1rz0VfjLNk+gKshAS5T4XLnS/ZUnmV7mIKMMw==
X-Received: by 2002:ad4:46e1:: with SMTP id h1mr3427817qvw.129.1598032400899;
        Fri, 21 Aug 2020 10:53:20 -0700 (PDT)
Return-Path: <jeff.dagenais@gmail.com>
Received: from [10.0.0.29] ([135.0.225.35])
        by smtp.gmail.com with ESMTPSA id f4sm2496640qtp.38.2020.08.21.10.53.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 10:53:20 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [bitbake-devel] [RFC] siggen: clean_basepath leaks full recipe file path
From: "Jean-Francois Dagenais" <jeff.dagenais@gmail.com>
In-Reply-To: <376560ff987c4585f7f21c2cae4c8f50451ad743.camel@linuxfoundation.org>
Date: Fri, 21 Aug 2020 13:53:19 -0400
Cc: bitbake-devel@lists.openembedded.org,
 =?utf-8?Q?Maxime_Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>,
 guillaume.champagne@sonatest.com
Message-Id: <866732CC-FB4E-4F0F-853B-1225FBAC9749@gmail.com>
References: <20200820215000.30818-1-jeff.dagenais@gmail.com>
 <1819f13202abc9339dbdd0215d714fda8a9b070b.camel@linuxfoundation.org>
 <29032972-1F01-4FE9-A3BD-13E1FFD43790@gmail.com>
 <376560ff987c4585f7f21c2cae4c8f50451ad743.camel@linuxfoundation.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable


> On Aug 21, 2020, at 11:10, Richard Purdie =
<richard.purdie@linuxfoundation.org> wrote:
>=20
> /path/recipedir/recipe_verison.bb:do_task
> virtual:A:/path/recipedir/recipe_verison.bb:do_task
> virtual:A:B:/path/recipedir/recipe_verison.bb:do_task
> virtual:A:B:C:/path/recipedir/recipe_verison.bb:do_task
> mc:X:virtual:A:/path/recipedir/recipe_verison.bb:do_task
> mc:X:virtual:A:B:/path/recipedir/recipe_verison.bb:do_task
> mc:X:virtual:A:B:C:/path/recipedir/recipe_verison.bb:do_task
>=20
> and what we care about particularly is that given a list of these, the
> sorted() result of the return values is consistent, independent of
> path.
>=20
> For example, we should get the same value back for:
>=20
> /short/recipedir/recipe_version.bb
> and
> /this/is/a/long/path/recipedir/recipe_version.bb
>=20
> so perhaps a unittest which tested that, iterating the above formats?

Would it be true to say then, that the ONLY purpose of =
`clean_basepath()` is to
remove the full path of the recipe?

If true, then could we not simply only snip the path itself, and leave =
the rest
in the same order?

So =
'mc:X:virtual:A:B:C:/this/is/a/long/path/recipedir/recipe_verison.bb:do_ta=
sk'
would become 'mc:X:virtual:A:B:C:recipedir/recipe_verison.bb:do_task' ?

That would definitely simplify the implementation and be more future =
proof,
would it not?=
