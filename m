Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DD2D41C01
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 07:50:11 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4277.1765439401484126957
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Dec 2025 23:50:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=sUwAjhO8;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso7767305e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Dec 2025 23:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1765439400; x=1766044200; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkDlExfivz4Y5UrvVTc4Y3rwCVGl+JOqd7Th+8CPiqs=;
        b=sUwAjhO8GoMrLgiSBk+PN72SDobxlBqoNzAL9tIZ2DSENdSnuYpccOjTQ60PkP5iGF
         Ozdkbgwbm5PbExyMFd3b86dvpgrxPLobF4kks8NqWIurTock0WAF4JHEFa99d6sehxRR
         QtQ4qbRGY0tFwRaZ6U06kQhErQ/omyE0+0Sjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765439400; x=1766044200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TkDlExfivz4Y5UrvVTc4Y3rwCVGl+JOqd7Th+8CPiqs=;
        b=QUmWCAhE8cjszcfJEv0ZULBewOfyAG02rXUHLGmc0imatjPPR9X3iVNqS/DZp+j46h
         HKKQIgj5BOavQyuel8BXOpUyxZJ/c9Gc8hpo8sGG/Um0Y9cR/Vg/QHsUrkMjNKUXxGpT
         Wrygx0utXyFQ/T8/YdGyKLhf3s1VO2v+PNmLizId+PENPm7Aq6AJEslxlFE05eCqaZEw
         UeLI2sF76Ln2rsOY+Ne/WolStC/ttpzfoi9mp3U2Iv10v252CD6UEcLZVHaXxCyr77Dj
         bW2+70mVqx1raJ+cMQ0zD4lz7pvmfZ3auCBWWuwv9Zcst3YGvbjPQGKra8J5TF5NBCZ2
         uyiA==
X-Gm-Message-State: AOJu0YxE5M3zzOUObuSNL6CsNcBkFhO2Kchvc3AWEhDlyj9SjbSbqCBK
	TKbIpjBteLQt+2Ooxgsc1eA9lhUVNZ6yanYhFvRImHKRA6RNow6pNR4ZSPzrb4X1uDYrB41aQSI
	pNqROhRwdVzUohlcIX/X6h7GqW5lHjaXCt13wDFVB5Q==
X-Gm-Gg: AY/fxX5VrrxQq3gpuJI+lH2tabnmBLRqHbBbgwj5lWXm0LRVnoIFaqlzsu7MlfAhJ5T
	8FM37qvZzEzLnaD/A1beBWUGQx+lXC8jKAPmY/QvQLsI03Ynu8lJp/LUPtV9YlUlOP4ywHfHx2X
	ZCkSxmBkpXy57RrL1NZVIZESadu+vXBQW0Qy2JDPCH1yGGTdXFO6K0HjtMg8TPNJn98pIXoMZKO
	yFEhtyG8MaZ7m3UHF7H9sER7cYLIi7xmnFbOkApHOiKp68XC1ezBG91Spbydq+GCUCrBNPDFHiI
	d7WH0ijVvnStfYU+AgsgvelnULzr
X-Google-Smtp-Source: AGHT+IHG6TfuP8rMI7MZa0bZngT4QQhWYFwXG0N1Yda9n/WizVkjBMvjXVNGsw5i0R3sBvhf5JLvvwf3f6op0EBqHcw=
X-Received: by 2002:a05:6000:1863:b0:42b:396e:2817 with SMTP id
 ffacd0b85a97d-42fa3af7eb7mr5821578f8f.40.1765439399841; Wed, 10 Dec 2025
 23:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20251205234033.6363-1-swami310@gmail.com> <CA+-_CqnqT4roapfisF_6gt2P-OJ8gkw9GvRNEnWh9FQX6HU7Sw@mail.gmail.com>
In-Reply-To: <CA+-_CqnqT4roapfisF_6gt2P-OJ8gkw9GvRNEnWh9FQX6HU7Sw@mail.gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Thu, 11 Dec 2025 08:49:33 +0100
X-Gm-Features: AQt7F2rFTvoyWZnrrDDtPjMjDqdRQnm-drZLHkNIZOkQXD-59F7P8uUbVvwLBr0
Message-ID: <CAMSfU+5enXOdO03=d2Nfx6infFOoema2Y7xQG9VErNN1DgbE9A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v7] bitbake-user-manual: Document BB_CMDLINE
To: swami310@gmail.com
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org, 
	michael.opdenacker@rootcommit.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Dec 2025 07:50:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18563

Le jeu. 11 d=C3=A9c. 2025 =C3=A0 08:02, Swami via lists.openembedded.org
<swami310=3Dgmail.com@lists.openembedded.org> a =C3=A9crit :
>
> Hi,
> I have not heard anything after I submitted Patch V7. Is it accepted ?  H=
ow can I know the latest status ?
> Please help me understand.

Hello,

Thanks for your patch :)

Your patch is in the master-next branch :
https://git.openembedded.org/bitbake/log/?h=3Dmaster-next

Which means it has been selected for review and tests. Once those
happen you will either receive a review by mail or see your patch get
merged on master.
Merges usually happen after the patch review calls (which are on
monday and thursday :
https://www.yoctoproject.org/community/get-involved/).
Ping back if nothing happens in a week or so.

> regards
> Swami
>
> On Sat, Dec 6, 2025 at 5:11=E2=80=AFAM Swami <swami310@gmail.com> wrote:
>>
>> Add documentation for the internal read-only variable :term:`BB_CMDLINE`=
.
>>
>> Fixes [YOCTO #15746]
>>
>> Signed-off-by: Swaminathan K <swami310@gmail.com>
>> ---
>>  doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.r=
st b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> index 734c7858a..32860ec0c 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> @@ -116,6 +116,10 @@ overview of their function and contents.
>>        Specifies if SSL certificates should be checked when fetching. Th=
e default
>>        value is ``1`` and certificates are not checked if the value is s=
et to ``0``.
>>
>> +   :term:`BB_CMDLINE`
>> +      :term:`BB_CMDLINE` is an internal variable and is read-only. It c=
aptures
>> +      the exact command line used for the current invocation of BitBake=
.
>> +
>>     :term:`BB_HASH_CODEPARSER_VALS`
>>        Specifies values for variables to use when populating the codepar=
ser cache.
>>        This can be used selectively to set dummy values for variables to=
 avoid
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18561): https://lists.openembedded.org/g/bitbake-deve=
l/message/18561
> Mute This Topic: https://lists.openembedded.org/mt/116643097/4316185
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [yoann.=
congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Yoann Congal
Smile ECS

