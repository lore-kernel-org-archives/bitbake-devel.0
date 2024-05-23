Return-Path: <dan.dedrick@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0316C25B7C
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 16:17:27 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
 by mx.groups.io with SMTP id smtpd.web11.2758.1716481040605164566
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 May 2024 09:17:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fnH/B9gm;
 spf=pass (domain: gmail.com, ip: 209.85.128.169, mailfrom: dan.dedrick@gmail.com)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61be674f5d1so59027277b3.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 May 2024 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716481039; x=1717085839; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=80b0BPBeH5oDNXCXuQ2lgJnsx7+lKdrZm+5HT4RjTiU=;
        b=fnH/B9gmYgJPC0hYYeOnygxXrXXShpkPAxPSpNIFKEh9x+mOqfeDU0h4OvPh+PG5h2
         knToAnQDnGI6FD6FA5U2i6BhW6dNLngaCODhFccnmqH3qGFWF4JbnWDHzMBc/xV8Q7qn
         S2KBk93VGOC3d+YR+HfRfSQCNdhoPENhrxNa5h4Fh561lbw5jWD7BEntP1g7LNUGwoAT
         tjGvAvxPHOpagCT9KHSIQdZvPEnyn5jQdRRzPwP8EG/spUSLW0MPlTlsY2IrIJlCUsIX
         bSuNZTpYgc0XazL7PmBRvHMDbVe6B6EvBDGbReC01HDTz2vHwkk0wp4AFBTJP4XvRtUj
         fJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716481039; x=1717085839;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=80b0BPBeH5oDNXCXuQ2lgJnsx7+lKdrZm+5HT4RjTiU=;
        b=lbhdsKwGEtjGDVQPokTu4GlZUsKCT+3Ksy5iR1tIFRNvp0H8udGrM//XUbBRAAFvmy
         BkQodiyhVgfszLzuLZLe7oAH9EIm9l31dFOTBRRrsWhSzXlyiVIrWQHXCw3SIVZPO+RV
         QYF/meOT4b7sBrb70cgoIWJk4JXSHXG5O6dc/j8nUWhMCUeWvXPHeVFxm8Oo4uCSZjZp
         nmkT8JW/k/UmPJcuywumlZWdmFfXJlQuEHUGR4hOeGeHvaT5ozH5f5DVlN644j7VraSM
         9tIayHuuVUOcguqvvf9C4/AxBJaJTZ8Fy7t8P/t0x4Z6oua3TRZqRen7Mv1o2CDsb8XN
         ejXQ==
X-Gm-Message-State: AOJu0Yxzk1RCXmeEJeXE7wmlZmBa5I1lcCCDQfAC3lbOCAjlmchG5mnX
	R3jBS3fYMY9cj/D6SqUGX0s6DXh3rr/cxVJD8G9AuIbgdluPWOd0uCQRA5XxL5njuzIUGMIwQSG
	xEUvC3Y1YbGHdvQ281WtMRrM94LMlb4Pz
X-Google-Smtp-Source: AGHT+IGnpLTjQ8BI7y/vO5GR75RoAc+je8oURwCL3x0cDYZsNNgIcUYSQtg2R3nEQQ10CypOVkxnOUcSBDC0tSuNzic=
X-Received: by 2002:a25:680b:0:b0:df4:43f6:5b75 with SMTP id
 3f1490d57ef6-df4e0d487c0mr7470752276.24.1716481038675; Thu, 23 May 2024
 09:17:18 -0700 (PDT)
MIME-Version: 1.0
From: Dan Dedrick <dan.dedrick@gmail.com>
Date: Thu, 23 May 2024 12:17:07 -0400
Message-ID: <CAO-9+V8g89_GtrP-pXEy23YAsr4gQ2xr4YHEKD-bKJV37TRyAA@mail.gmail.com>
Subject: wget fetcher path unquoting
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000092f92b06192162da"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 May 2024 16:17:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16246

--00000000000092f92b06192162da
Content-Type: text/plain; charset="UTF-8"

In the process of upgrading to 2.8.0 I found that this commit
https://git.openembedded.org/bitbake/commit/?id=88350002d45e0aa85ecd5356da2c8d71e450641e
is causing some issues with my sstate server. I think the overall change is
good but there is one minor tweak that I think is causing some unexpected
differences.

Specifically ud.path has been run through urllib.parse.unquote(), where as
previously the uri had not been modified like this. The result is that a
url that was previously looked like this:
http://example.com/sstate/sstate%3Agnu-config-native%3Ax86_64-linux%3A20240101%2Bgit%3Ar0%3Ax86_64%3A12%3A872c3235e17b2bad69ed0a8fc44506cb0c4d2b6a9913b58a63e47fbc3e741f04_recipe_qa.tar.zst
would now look like this:
http://example.com/sstate/universal/87/2c/sstate:gnu-config-native:x86_64-linux:20240101+git:r0:x86_64:12:872c3235e17b2bad69ed0a8fc44506cb0c4d2b6a9913b58a63e47fbc3e741f04_recipe_qa.tar.zst

In my case the sstate server succeeds on the first request and fails on the
second request. I can work around this but it does seem like maybe this was
an unintentional side effect of this change. If I wrap ud.path in
urllib.parse.quote() it will go back to fetching from the old url, which
does work for me without having to work around this on the server side.

Again this is not critical for me because I can work around it on the
server side but I figured I would at least mention it since it might affect
others. I would be happy to make and submit a patch to add the quoting back
in if that is the desired behavior.

Thanks,
Dan

--00000000000092f92b06192162da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">In the process of upgrading to 2.8.0 I found that this com=
mit=C2=A0<a href=3D"https://git.openembedded.org/bitbake/commit/?id=3D88350=
002d45e0aa85ecd5356da2c8d71e450641e">https://git.openembedded.org/bitbake/c=
ommit/?id=3D88350002d45e0aa85ecd5356da2c8d71e450641e</a> is causing some is=
sues with my sstate=C2=A0server. I think the overall change is good but the=
re is one minor tweak that I think is causing some unexpected differences.<=
br><br>Specifically ud.path has been run through urllib.parse.unquote(), wh=
ere as previously the uri had not been modified like this. The result is th=
at a url that was previously looked like this:<br><a href=3D"http://example=
.com/sstate/sstate%3Agnu-config-native%3Ax86_64-linux%3A20240101%2Bgit%3Ar0=
%3Ax86_64%3A12%3A872c3235e17b2bad69ed0a8fc44506cb0c4d2b6a9913b58a63e47fbc3e=
741f04_recipe_qa.tar.zst">http://example.com/sstate/sstate%3Agnu-config-nat=
ive%3Ax86_64-linux%3A20240101%2Bgit%3Ar0%3Ax86_64%3A12%3A872c3235e17b2bad69=
ed0a8fc44506cb0c4d2b6a9913b58a63e47fbc3e741f04_recipe_qa.tar.zst</a><br>wou=
ld now look like this:<br><a href=3D"http://example.com/sstate/universal/87=
/2c/sstate:gnu-config-native:x86_64-linux:20240101+git:r0:x86_64:12:872c323=
5e17b2bad69ed0a8fc44506cb0c4d2b6a9913b58a63e47fbc3e741f04_recipe_qa.tar.zst=
">http://example.com/sstate/universal/87/2c/sstate:gnu-config-native:x86_64=
-linux:20240101+git:r0:x86_64:12:872c3235e17b2bad69ed0a8fc44506cb0c4d2b6a99=
13b58a63e47fbc3e741f04_recipe_qa.tar.zst</a><br><br>In my case the=C2=A0sst=
ate=C2=A0server succeeds on the first request and fails on the second reque=
st. I can work around this but it does seem like maybe this was an unintent=
ional side effect of this change. If I wrap ud.path in urllib.parse.quote()=
 it will go back to fetching from the old url, which does work for me witho=
ut having to work around this on the server side.<div><br></div><div>Again =
this is not critical for me because I can work around it on the server side=
 but I figured I would at least mention it since it might affect others. I =
would be happy to make and submit a patch to add the quoting back in if tha=
t is the desired behavior.</div><div><br></div><div>Thanks,</div><div>Dan</=
div></div>

--00000000000092f92b06192162da--

