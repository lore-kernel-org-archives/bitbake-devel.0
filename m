Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE5BC61DB9
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 18:58:03 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1874.1787857076537754465
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 11:57:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=GiZg4O3w;
 spf=pass (domain: gmail.com, ip: 209.85.128.177, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-85aeb506b78so3728547b3.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 11:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787857075; cv=none;
        d=google.com; s=arc-20260327;
        b=Yjn/nUKKG58zFi9YPCmr42wx5k6+2isuIBqbZ/5BJGtQYX2l7psuz5OvSfC4EFNYU7
         vFKERpM57KonJ5SglGHBtM6UVV5OnUC5fOBwEnHyLVldgwUoB2Md4QlTEe8S+YQwLEMm
         iWDYx5KCfGwrY/cjjl1XFuRq61+s1XxWm8aDUs6g3qbLPV43LRWblbwFgvEQf1PCYDVV
         eSjFs9mVJ1fdN64OANXD35SNqz3rm6s+fx+4kojEpliIuDhMG+/MJZ+cdc0sY6xkzbRM
         zf6h8bDxByYL/u6KSzNX7GoTnSr/p+C4ijjRDIhwn1avTZkxTVjTa2KDFJ0Xcu7c8hfw
         ximg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Sqy2rrR29wgx2ayUv6hBWeGHKi+hEoRSpjzAzEiJG+E=;
        fh=Ba+/dzH5NL8AUm91fhgpMkjNnMNLHS/w2isJVJ+9V3o=;
        b=n0MLjKlNLdEkvzzIfpdPBlY2UfVlUc1NLnvYUelcsWQILwdmMaGWvDpFV+NDzoQOBr
         lh1LYFhqJYV2Ian/vELCVqVtX9xPLPqOr3GPRBwu0C0E8NxGSclZJn607dKscFAe4ino
         OIUbcuTi37oyVYmk4AsEeywXHWS7rU+GU6CaMqSOLgZEoqGKS6kPVjLVG24xjEO686nW
         aq6OHirw71kPc0rhtZcMNZsFGvEXIQjefUX48yG5GM++CaHr5o/g3Bt3V361hlAU+/5O
         s38Pif1RAYP8pad2Js04Rh/jKtdef5i8pGiYrpDe/OS1YfszRtaQZPX1YxaAtVkUWL2Y
         2EFg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787857075; x=1788461875; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sqy2rrR29wgx2ayUv6hBWeGHKi+hEoRSpjzAzEiJG+E=;
        b=GiZg4O3w185PXe5Q11PwM1RFYJepQWStdQMDeIGnxT/eR99KWtYJSXFtw/vBYW5f2O
         mJ9V0JQDDGBDJklNG49m4Rg4J3dBAzRfYsR6VQTsnTm9hxEBauP2KHMo8PvtKr1Ztnzn
         S014ZU0muWscPzgzVzr2/yK4TkY+aTRI/s8HL06xjoqg1vUSFOunfFJFMQ5GbeARr6mo
         fKiM3xFwYvSKzm1rGY5FusxR5zfCHoRQIG6iEX9fvW0uws0TCcD31cSBrS8VnnxQOUpQ
         DRRgPjLhLqFi0QL6EM0rsxD/BX1yswkP0IhtcuzS2HatMilChaqtoUgNsckSx4G6gSXt
         Ad3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787857075; x=1788461875;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Sqy2rrR29wgx2ayUv6hBWeGHKi+hEoRSpjzAzEiJG+E=;
        b=M7dtR8DE5sx56VIQ8jpsYc5HubQUvIBs172xmPcejSduL3DXtoUJ46BAl4poT3lhpQ
         735IYA094mFdoff6nKPHmvBA3AoXBfCQ7VewqS+UiqwALNwVmka7sIug1HcgFyseCfNQ
         sP3jh1J3efPoXhe40GtDPV+nqQOeQ8CQ2qLXSxo3oWbDtB4JImF2xXzl1KSdV/KsF+7S
         dHew3Hgpzgc9XyQeEy4+raT3m9wSyEYc5IaCSIGlDPvtnIPM9eKGntitQ6ObYgsU0M5N
         ItyGRk9ZoH/woFNVOpQO1XbiTVwPzFoDl4U0LR6leY6OQWCpKdwpJWMVwIBe3ApaFwG9
         BIBQ==
X-Gm-Message-State: AFuF++mE45LNZuogttUpeWAZ9mKncJVWRaSoCc3bjUkbuXRt/LXY17hX
	mmv/+kF6uvZDceliaMgHygDysAEa4aE4CoTVWo2Msy8GAYdEQQeIS/m+pEI/aPs3QJhCY4gBPQQ
	wEC/9Y6Jrw4oqthZebbQtxSQu3fRAhlA=
X-Gm-Gg: AR+sD11x6i3jsjt4Sx5T91RvIq2kt9giXXbeEqPaPVYnvg5h+R6KG+KhrdknjZ/wB01
	7DqnkvwWHitzYPGZOBag7JpZDwr3TtY+Ay8jTrzlvo10Yb6sCO6TS5ONg/7WSQE2EyR2et2TsT7
	aU1Bqnr8wuZpKRNYUSN9v0RatKooR6uEROmteykSDapauBiNl979NWSynxTqLH20o3ZLTodvDyE
	Tx7rOdxUKXQp56CpfxN4k/lL69eD5ea6t5c2PR3LQOn5V4MijqQijTquFQ4kUDGGAHeWkTsdZo7
	/n4I/WZ6Om9Uso2yxwZ2awbihNXD+BdZahIHd02fI67s8uyU6CnlW6BEzqI=
X-Received: by 2002:a05:690e:286:b0:668:1414:e9bd with SMTP id
 956f58d0204a3-66e4c70ae29mr152823d50.38.1787857075426; Thu, 27 Aug 2026
 11:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260724212822.1165552-1-JPEWhacker@gmail.com>
 <20260730183254.793698-1-JPEWhacker@gmail.com> <1147544.1785503145144982751@lists.openembedded.org>
 <CAJdd5Ga8omZNt_KBBrrLvLhhUYgBa7ptq20vcd3zNX+ZpNiJAw@mail.gmail.com> <2326647.1787784484085855892@lists.openembedded.org>
In-Reply-To: <2326647.1787784484085855892@lists.openembedded.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 27 Aug 2026 12:57:44 -0600
X-Gm-Features: AcwNN1UqkkZQbA3Rg5gvfNZtJEMM5A1a4bK42KxPSKFQpL1WphUxVh1kMIhtAeM
Message-ID: <CAJdd5GYXyzXGXZJFkuwZmy1foL0g_UxGX_2tTAG1q2FM9jaPaw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 00/10] hashserv: Pipeline Upstream Queries
To: michalwsieron@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000e3da1a065a0be9f4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 18:58:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20073

--000000000000e3da1a065a0be9f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah, the upstream server is the part I was missing. Ya, that fix is probably
correct. I'll run it through more testing and post it to the ML.

Thanks.

On Wed, Aug 26, 2026 at 4:48=E2=80=AFPM Michal Sieron via lists.openembedde=
d.org
<michalwsieron=3Dgmail.com@lists.openembedded.org> wrote:

> Hi Joshua,
>
> > Any chance you've had time to look at this more? I've been unable to
> reproduce this particular issue. It looks like the server is just crashin=
g
> or stuck somewhere where it's no longer responding, but I can't quite
> figure out where that might be occurring.
>
> Unfortunately, I did not. But I just tried it again on my setup (new
> changes pulled since last time), and it reproduced immediately.
> As I still don't have *that much* time to debug this I went and threw thi=
s
> at Cursor, which did find the issue and generated a fix and a minimal rep=
ro
> test.
> I attached the patch.
>
> Br,
> Micha=C5=82
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#20062):
> https://lists.openembedded.org/g/bitbake-devel/message/20062
> Mute This Topic: https://lists.openembedded.org/mt/120523853/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> JPEWhacker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000e3da1a065a0be9f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Ah, the upstream server is the part I was missing. Ya=
, that fix=C2=A0is probably correct. I&#39;ll run it through more testing a=
nd post it to the ML.</div><div><br></div><div>Thanks.</div></div><br><div =
class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, Aug 26, 2026 at 4:48=E2=80=AFPM Michal Sieron via <a href=3D=
"http://lists.openembedded.org">lists.openembedded.org</a> &lt;michalwsiero=
n=3D<a href=3D"mailto:gmail.com@lists.openembedded.org">gmail.com@lists.ope=
nembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><div>Hi Joshua,</div>
<div>=C2=A0</div>
<div>&gt; Any chance you&#39;ve had time to look at this more? I&#39;ve bee=
n unable to reproduce this particular issue. It looks like the server is ju=
st crashing or stuck somewhere where it&#39;s no longer responding, but I c=
an&#39;t quite figure out where that might be occurring.</div>
<div>=C2=A0</div>
<div>Unfortunately, I did not. But I just tried it again on my setup (new c=
hanges pulled since last time), and it reproduced immediately.</div>
<div>As I still don&#39;t have *that much* time to debug this I went and th=
rew this at Cursor, which did find the issue and generated a fix and a mini=
mal repro test.</div>
<div>I attached the patch.</div>
<div>=C2=A0</div>
<div>Br,</div>
<div>Micha=C5=82</div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#20062): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/20062" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/20062</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/120523853/361=
6693" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/120523853/3616693</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:JPEWhacker@gmail.com" target=3D"_b=
lank">JPEWhacker@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000e3da1a065a0be9f4--

