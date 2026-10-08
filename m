Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA31CA6007
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 14:21:51 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16476.1791469303697679894
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Oct 2026 07:21:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=K2IBcH/8;
 spf=pass (domain: smile.fr, ip: 209.85.128.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a166199820so5104095e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 08 Oct 2026 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1791469302; x=1792074102; darn=lists.openembedded.org;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8+8UuGuOekGHnJeWcFONXNbo5x0oOLwMp1uI6iK6ulE=;
        b=K2IBcH/8Gk+ys52m10UFDP4xDMEP49HlFkJFOQc/F3mFY69poBXXz4ot30NEcIGNT2
         O4mZXyYlRSDcc9KY6/nOzcEIEuvMyUICPDFXvlJp+1Yjli2LWINIRBisyS7YvrAdEmcp
         B/ctGXZBuWioT1bH5CUXFir2OTosFOtLRG2l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469302; x=1792074102;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8+8UuGuOekGHnJeWcFONXNbo5x0oOLwMp1uI6iK6ulE=;
        b=AYC1tJBPk9zOJ2OorFlSluBAONQjPtR9nmf0VPCyZFqUxJ00E7lwt41wSQ7OvaT3/q
         Dh35eA17tv8XxnNx+ajcl2Tie2JG71KqRxsR8kUGLpMYCt3u9lpbfIYfHTqA6sOb5Myt
         BaaT1Z9S7JmXkp3q2bUgeLqn32nwlxA6P4aOetqdyKc1/labAfzRuFdYGZ6I0fien40L
         F5K64FMsd0vg8jOuBQhIu7XvLz/P242Z8YP6MFT7th+BysiT8qb1syzlDZo+8GE8yzmh
         fa9KuaK30NbzaXttvSX/Zr4km0P0r/+9Qe04tdm+mX3n7ZjhyWnkyp/ALgWJ2mBo0uq0
         7uqg==
X-Gm-Message-State: AFuF++mmSbsWLauwd+90oL+Pe3aRyIK7G9xrijuqOyv6JXJyhHyBXxTQ
	R8ZgWreHKbyBnQljn/pzl/Oa2yBECrI7cPQFx0qwGTSurNFbYWL8p80LOMVphKD/AKI=
X-Gm-Gg: AYBFou1ofQ/liERTMNUGbM1rrRjAUSKulmNVdrQ/1IIZBro/kS5M+zhDT3qmdKtmDEZ
	O8752+ZetXflevrP2pm5dgwy1yVqjrAyajjT+8EoldF4NMquBrJ4PmlX5cVA3w86gBMiT1dMl61
	Fuvim9rZ8dS/1ztKZkDcWO2Ns1jQW6nZXxZZAtgVfLiMLdwE05Pfj1TF3tNBifSmbXvK+v7GBd8
	Mgm/3cvHF/aAEmz4r91aVcpry40k4vXr+TbxD8yU9abunfleu9IWHL7ef+elrdvZ+9O0BSc8ooW
	6uvAKA+g47ONUMDJ/T2K5B55AeW5Vreg887aCOAR9Ux6AQBF+YRPu+jw0GLhXSvos1rjEZFD4CB
	QKV41O+0eB9cBemEf3Fp1Ty1/lIjKg8Qs4dHAcii5JpsK7gL6OGjuNpgHnYmLLOxOoPISoLjAAp
	x95oL0kh8BcHmn3bvf+zWbA4LNg3MqDN8LxORZisU6yF2ppNNZIn3NbSr26Bio9QtobL/p91p1x
	bItS9z4nkLyRJyxpKl57YtE4Z9XEQ5Nr2Tclsf+FtqO+C7kdnqiAMuZQoznvQ==
X-Received: by 2002:a05:600c:8b6f:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4a1851c2bbemr50530725e9.16.1791469301646;
        Thu, 08 Oct 2026 07:21:41 -0700 (PDT)
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843b5a2esm70649795e9.11.2026.10.08.07.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 07:21:41 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Oct 2026 16:21:40 +0200
Message-Id: <DLZIV7AFZTI6.3UVVYPQA69SGR@smile.fr>
Subject: Re: [bitbake-devel] [PATCH] tests/fetch: don't rely on wget
 --continue in the corrupt partial test
From: "Yoann Congal" <yoann.congal@smile.fr>
Cc: <bitbake-devel@lists.openembedded.org>,
 <richard.purdie@linuxfoundation.org>, <jose.quaresma@oss.qualcomm.com>
To: "Ricardo Salveti" <ricardo.salveti@oss.qualcomm.com>
X-Mailer: aerc 0.20.0
References: <4dac347fd6bd1f160fbe3646d20504bc6f47b42b.camel@linuxfoundation.org> <20261006213334.3360919-1-ricardo.salveti@oss.qualcomm.com> <DLY4FJIPDYDE.1E2VH902D858L@smile.fr> <CAA_5youj13dBFP06u4nW_T8T3xwR-fEHqSutaRZj=Nt6fwk6uw@mail.gmail.com>
In-Reply-To: <CAA_5youj13dBFP06u4nW_T8T3xwR-fEHqSutaRZj=Nt6fwk6uw@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Oct 2026 14:21:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20309

On Thu Oct 8, 2026 at 4:07 PM CEST, Ricardo Salveti wrote:
> Hi,
>
> On Wed, Oct 7, 2026 at 12:50=E2=80=AFAM Yoann Congal <yoann.congal@smile.=
fr> wrote:
>>
>> On Tue Oct 6, 2026 at 11:33 PM CEST, Ricardo Salveti via lists.openembed=
ded.org wrote:
>> > test_wget_corrupt_partial_download expected wget --continue to leave a=
n
>> > existing .tmp file as large as the remote one alone when the server
>> > ignores Range, which is what GNU wget 1.21.4 does. wget2 2.1.0 rewrite=
s
>> > the file instead, so the fetch succeeds, and wget2 2.2.1 (Fedora 45)
>> > appends the whole download to it, so the bad file ends up under anothe=
r
>> > checksum than the one the test looks for. Don't run wget for that firs=
t
>> > fetch, so the fetcher sees the partial download as it was left,
>> > whichever wget is in use.
>> >
>> > Tested with wget 1.21.4, wget2 2.1.0 and wget2 2.2.1 (Fedora 45). The
>> > test still fails without the fetcher fix.
>> >
>> > Fixes: 37b9c56ae3b2 ("fetch/wget: rename the partial download on check=
sum mismatch")
>> > Reported-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> > AI-Generated: Uses Claude Code (Claude Opus 5.5)
>> > Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
>> > ---
>> >  lib/bb/tests/fetch.py | 8 ++++----
>> >  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> Hello,
>>
>> Do you think this could be a fix for
>> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16153 ?
>> (previous patch definitely sound related)
>
> Yes, the merged one (37b9c56ae) fixes the sequence described in the
> bug: the upstream download fails its checksum, and the mirror is then
> fetched with --continue on top of the .tmp left by it, so a bigger
> mirror file ends up garbled (corrupt head, mirror tail). With
> 37b9c56ae the .tmp is renamed to <file>_bad-checksum_<sum> as soon as
> the checksum fails, so the mirror download starts from scratch and
> there is nothing for --continue to resume.
>
> Having issues with my account in bugzilla, would you mind updating the bu=
g?

I've put links in the bug so we won't lose the relation to this patch.
But, I'd rather wait for the followup "tests/fetch: don't rely on wget
--continue in the corrupt partial test" to merge before closing the bug.

Regards,
--=20
Yoann Congal
Smile ECS


