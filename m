Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F7BC4332F
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 14:42:21 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web12.8308.1668091332323487796
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Nov 2022 06:42:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DD3+knG7;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id h133-20020a1c218b000000b003cf4d389c41so3562274wmh.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 10 Nov 2022 06:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tOT9olvYDDeFPU7y45U+xDEc19JIIqbHiuXgT8sOZQ=;
        b=DD3+knG73oS5d0tL5TNA8bmTWpQ/BahjTe2KK8JbSOVXEc4eFhrBT04ZC6/LrD/p6k
         c8Hkfh0UZgcj8NvHxBn1f1IR+YSZ9CO+/svDFeDCc0VrgsaJYR34w0qeXo3VXA6RZIv7
         QTK3QD/4/doWvowjdfwUjd7ngEFIa9ZDz4AI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+tOT9olvYDDeFPU7y45U+xDEc19JIIqbHiuXgT8sOZQ=;
        b=0R79ULircKyw3vQptBO0gJIQnr9QOYn6gf5r1BlKPVpEzwoPSbgWykSiqNHBknt9o+
         soVnTJGTnGJZ+6EIYv4p3UA2EOQ8mOkUBCDDQGHiZ4w8K1ivX38M44jwXnUYBuZOFsjF
         5g1U13WgsYTYy88Jl+8aNxTltgo7Da9ot8NzLNUnkAXw7FR5Jll62bAjS5erjPJo15oa
         q+2W0otp8DuAdswg9sQWWAyT6bE2AuZJ63DDvuL9aznXdSTyqXLiYt6Gcfv2mCMqPOTo
         Oq7MKo5PlIvtgiKQReEcptfI0gwx2M2yBy/pYoJhoGU7F3NvWpPap2oioiTj89h4DipU
         FHQQ==
X-Gm-Message-State: ACrzQf1FVCmG7AhEwywFTozakt4FJdxvI6pOHkIDVTtAMzC1cW0DGAEw
	Gf/Mw4yqk1AMdPqApiHxL6fmIg==
X-Google-Smtp-Source: AMsMyM7H6FJcBAksIw4oIXZMF5OAt8KyHFOfNDjfpWVWQj/xHicDe6k+qN8YPJmg0fu35xekqL6OdA==
X-Received: by 2002:a05:600c:1e8b:b0:3c6:f6e5:c41d with SMTP id be11-20020a05600c1e8b00b003c6f6e5c41dmr54239854wmb.12.1668091330573;
        Thu, 10 Nov 2022 06:42:10 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:17d7:2b2a:fa9:1005? ([2001:8b0:aba:5f3c:17d7:2b2a:fa9:1005])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b003cf894c05e4sm6238742wmq.22.2022.11.10.06.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 06:42:09 -0800 (PST)
Message-ID: <32efd92d996ee0dad8bc1a41fc93fa01521fd473.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] data_smart: allow python snippets to
 include a dictionary
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Asselstine <mark.asselstine@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 10 Nov 2022 14:42:07 +0000
In-Reply-To: <20221107164652.435071-1-mark.asselstine@windriver.com>
References: <20221107164652.435071-1-mark.asselstine@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Nov 2022 14:42:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14066

On Mon, 2022-11-07 at 11:46 -0500, Mark Asselstine wrote:
> [YOCTO #14917]
>=20
> Attempting to use a dictionary in a python code snippet for variable
> assignment results in an error. For example attempting something such
> as
>=20
>   IDX =3D "green"
>   VAL =3D "${@{ 'green': 1, 'blue': 2 }[d.getVar('IDX')]}"
>=20
> produces the error
>=20
>   expansion of VAL threw ExpansionError: Failure expanding variable
>   VAL, expression was ${@{ 'green': 1, 'blue': 2 }[d.getVar('IDX')]}
>   which triggered exception SyntaxError: '{' was never closed (Var
>   <VAL>, line 1)
>=20
> The existing __expand_python_regexp__, "\${@.+?}", will match the
> first close curly bracket encountered, resulting in incomplete and
> un-parsable code, and thus produce the error. We can correct this by
> allowing a single depth of nested curly brackets in
> __expand_python_regexp__ by using "\${@(?:{.*?}|.)+?}", which will
> match up to and including the matching close curly bracket to the
> open, '${@', curly bracket, even if there are one or more singly
> nested curly brackets present. This change allows the usecase
> described above to function.
>=20
> This change can't be made on its own though. The old regex would, in
> an obscure way, handle the case where a python snippet contained an
> unexpandable variable. Since the unexpandable variable is in curly
> brackets it would cause incomplete/un-parsable python code and thus
> remain unparsed. So something like
>=20
>   VAL =3D "${@d.getVar('foo') + ${unsetvar}}"
>=20
> would remain unparsed as the close curly bracket in "${unsetvar}"
> would match and terminate the snippet prematurely. This quirk resulted
> in the proper handling of python snippets with unexpanded
> variables. With the change to __expand_python_regexp__ the full
> snippet will match and be parsed, but to match the old/correct
> behavior we would not want to parse it until ${unsetvar} can be
> expanded. To ensure the old/correct behavior for python snippets with
> unexpanded variables remains in place we add a check for unexpanded
> variables in the python snippets before running them.
>=20
> This handling of unparsed variables brings two benefits. The first we
> now have an explicit check visible to all for unexpanded variables
> instead of a somewhat hidden behavior. The second is that if there are
> multiple python snippets the old behavior would run the code for each
> but a single snippet with unexpanded variables would mean all snippets
> would remain unparsed, meaning more and repeated processing at a later
> time.
>=20
> For example:
>   "${@2*2},${@d.getVar('foo') ${unsetvar}}"
> old behavior would give:
>   "${@2*2},${@d.getVar('foo') ${unsetvar}}"
> new behavior will give:
>   "4,${@d.getVar('foo') ${unsetvar}}"
>=20
> The old behavior would calculate '2*2' but toss the result when the
> second snippet would fail to parse resulting in future recalculations
> (or fetching from cache), while the new behavior avoids this.

Thanks for digging into and fixing this one, not a simple situation.
I'm particularly happy you added test cases.

I'm just hoping the cookie monster didn't frighten you away! :)

Cheers,

Richard

