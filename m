Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f196.google.com (mail-ig0-f196.google.com
	[209.85.213.196])
	by mail.openembedded.org (Postfix) with ESMTP id 90AEC6FF97
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 16:37:25 +0000 (UTC)
Received: by mail-ig0-f196.google.com with SMTP id kj7so11746638igb.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 May 2016 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=UNMqwYBYYBWyXAhPriQn+YKuCLlisZJH7UOW/JjHiNY=;
	b=ATrlSaQX3J+OyT+p3sCF5E8IpW2SauDR9FPH9DQWApefWu7qvIGIz5+dfv1Y3PB4G2
	gHuk3K29qb/tc1YEmKqw6bCLOT/jubnuMNktks0T+Lw9MeHCfbEkxtZDVAFvQ2ZR8D/w
	AMu3bh/8cL8KV2jr9kufwu23CfR1pZ+2TtqWZ2AhIdzDOYsHSziQDrTncBZSpMaWfKtB
	WJdap3x2pHq/RTE5jiWRdFSls5OLVpLKicwTMVFHki7c5GWiCf+ia6ON81T4jCd/bDo8
	qPtGUhuAdI02236JskmUQ2U1UsFLGqLjBncLvtGMVHQkRE3guYvxOm3GvExdgPWrPIbZ
	tFhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=UNMqwYBYYBWyXAhPriQn+YKuCLlisZJH7UOW/JjHiNY=;
	b=TU8aKaFLNPvIuLxM8MX0cwCc7oupgTrPwUYMrC6RU/CQLX61DeyZcCVVfN1bil6VdU
	LkKxMHYs+YqlRYxYSJS6e22CT68VVjSxSuqNUxNJtB5h68Sq1TmgOM6OECbH9z9THaYU
	HaTh5UMF2n5Ll1itgaOk9zXxDEzsvAyoWDqe7wmd37RWD5CDEB5dJreM61zJvrbBkS+l
	P2fodsbzW2pTGg65+rcIR7asgS0Lmx20H2tYogmnzCXYkYgdV3yhGLx0v0vfeHJyfd5B
	8tDLgiRtq3UHds9RFw9+UrIjR4cCU2f8LxqX6jM3Wqtz+lk3Zn/UKEt+PBfAaou6mEFJ
	555w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=UNMqwYBYYBWyXAhPriQn+YKuCLlisZJH7UOW/JjHiNY=;
	b=l/+dRC/1qdghwFDNDRAWh+4Eb2HLtlqVNKIRBEiDwPCnxNrwedn7ndfJ0TqPUi3xlN
	yhagiheUnfX7ecagaVoMHKxUvoMUGmmqkc/fqLlgSh99hI7ZHhaZZ5iozvK902t9KHQK
	mPl/XEpJExplNFa05Jex3t0fLKt4sPG7qpytIyMdfFR83WQGYYtyxUJeQJLpvUEy6fn/
	LIAvNgSgGGEeoyBJiU5fO/eCGVx7eQ3H8jqWjbo/dfAllx1HiWZl9NJaYDJuMm1b0ztP
	yyTFTjdaYPsblgABUw/XKpMaMT2aGeyjc0a5r0HKngmeospYy3W7jAKxJQ8oMp4qkdBi
	zTMQ==
X-Gm-Message-State: AOPr4FUxJLr9jRwPVTzQ8JCYByueGXvOn8gwLmRKivUGhFi0OF/EVkbgIaSn5ruC+udPxzKaItJBMUp/55MJ4Q==
X-Received: by 10.50.123.161 with SMTP id mb1mr13030042igb.20.1462811846040;
	Mon, 09 May 2016 09:37:26 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.134.70 with HTTP; Mon, 9 May 2016 09:37:06 -0700 (PDT)
In-Reply-To: <1462799237.21831.134.camel@linuxfoundation.org>
References: <1462799237.21831.134.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 9 May 2016 09:37:06 -0700
X-Google-Sender-Auth: W-5TqwBFKbHszM52Ur32tepMB1w
Message-ID: <CABcZANmKsw7wz_TxjRS2TSeNHFrZHqkvJ_+Hhch3FG9mi=bkvQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] lib/bb/utils.py: Fix explode_dep_versions2() determinism issue
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
X-List-Received-Date: Mon, 09 May 2016 16:37:25 -0000
Content-Type: multipart/alternative; boundary=001a1135e7ea74e83805326b6c22

--001a1135e7ea74e83805326b6c22
Content-Type: text/plain; charset=UTF-8

On Mon, May 9, 2016 at 6:07 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> When we pass data into explode_dep_versions2(), we need to result to be
> able to be processed in a deterministic way so that we end up with
> consistent hash values. This means we need an ordered structure rather
> than an unordered one.
>
> To do this, return an OrderedDict() rather than a dict().
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Nicely spotted. Looks good.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1135e7ea74e83805326b6c22
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, May 9, 2016 at 6:07 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.p=
urdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-le=
ft-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex"><div id=
=3D":v3" class=3D"">When we pass data into explode_dep_versions2(), we need=
 to result to be<br>
able to be processed in a deterministic way so that we end up with<br>
consistent hash values. This means we need an ordered structure rather<br>
than an unordered one.<br>
<br>
To do this, return an OrderedDict() rather than a dict().<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt;</div></blockquote><=
/div><br>Nicely spotted.=C2=A0Looks good.<br>-- <br><div class=3D"gmail_sig=
nature">Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBa=
ke, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engin=
eer, Mentor Graphics</div>
</div></div>

--001a1135e7ea74e83805326b6c22--
