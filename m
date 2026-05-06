Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5BFCD342C
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 12:43:15 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17483.1778071393908260693
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2026 05:43:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=kxzK465g;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8eea23d01f7so858954585a.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 05:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778071393; cv=none;
        d=google.com; s=arc-20240605;
        b=fAgZvRw15gggoSemHrkjHvjrXbebZbXAvmEyd8jMaHafNpcCt4mMyKRTBg0G9Wzc1V
         7BWJrYrhZEEJeaI43ABzLxIaByuHu1VhiqigsMxZMIZ2Rs1ySDozcpiQlLM3fb4S+e7x
         ra2jJ96L2OLTP3V1Ri/LN6XYr937hb0ZCEKdnvUqrcdyQMjOaf/rv5Pdw+9twwab0rE9
         L6NSYQOqy/HfLEAI+YlxU+wOXniNMa0m4hPvX/DfzbZFDR0+uSuDCo48sGtrmKIZWyEE
         N+vkkKgwJlm3ZgJDGU4NbK8MYJOBXAV2SH7TeLd7nRgfR5StFa3ZiQiB2jg6N1+1szoH
         K0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gsmHvLADdrOj2HTYG/M2vTHD+fP18Lu4yC4vEzwlYac=;
        fh=0PRmyMBzIh+hjfrfU9DbL4itR7mj/qrS3wsLRvQ6Bco=;
        b=H3rcSPLPszBuKTUDK84BsSB1QOr2EO8IJMfvuLP5vc8KwX8TK/PHK0Rh3Bo+kskA0A
         +Odgk+4M/hji8Irxg2vfHT1VAlz7uR611sqB5cJssAww5g9NVJezLkA5rtKu5x30ca//
         lMr0df7YCUEsLHnsp9IamWXNAon4YdYaVA4txzxO69/Nh6Pl0umk02hXqCFh75Q29P0M
         pQEq9xNI7FBW3xdlRFKV1uUvDlQ/9w2B51y8XZWHyG8MpX5vp09ceIap4aQOXdv2ueAL
         6bRDLIsh5I4gcRRi4BN7wvP322vfDsRnXYnQU059PVPec8aU/3mzS2FNMjMbrfBBgEOY
         IT3w==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778071393; x=1778676193; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gsmHvLADdrOj2HTYG/M2vTHD+fP18Lu4yC4vEzwlYac=;
        b=kxzK465g8xHmvAvEBVaXoOHD1YW32TGN/96B0Y7/Al5CUHlVkvR7mQlPOZS8Z1TP01
         HlQW17PY1sraY2wM1ERuDPYtF6T3M+xB212MbqDLgp4Sx7WAYtFzJUpBR0z/cT21xDQ2
         dVZQF08WcwtznKXM6SDRHpFAvfJHLhV9UqYtgOKbuDrFhjCJy0qubBLSc4aM6pbX+bni
         TpgPtj1LMQkBzW43rIMNuOJ1047QCpaoDaSmsUSETgB/K2I4rgWul69gpEIF1NpTHaau
         yTfpQFpfL9zsyqsO4lvaLIbMNT5GUn7El6cGsrovNTRF588NVIKACL1MTFsJXzeqskU/
         LJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071393; x=1778676193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsmHvLADdrOj2HTYG/M2vTHD+fP18Lu4yC4vEzwlYac=;
        b=gGBIqe66cOfAd7TIqU49DXXi1RIkSouUvsye2ybWIHk97kox4WcK4mTaxtlIybqUYb
         FzC+tHgzzN1C/LmetcCIeKS04bZSfzm/p8XMKVolAede4kjilvDi9l4edaD2Ci9TcaXw
         i8gu2gUMwE1hgMgnBTFz28QzjpsT0w/TUi4467SpSEnpEd9xvat/7/ugPZ46XBsmf34q
         J/ZrWk7cs94BPaQdWhffSljI8WsQCIZruV1gm11vqK7EP5TjVbB+gU7zpMy/F2t5api3
         5DQKdLBFHrA1h2mlqsIYJnEIbzb1VxZRB15SXnBfyvkH+4MpDJbpzRUCQcZ4+jDBXV9y
         kMQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+KvaHt/0qu82AMNUpHTySXW4o4Fch6b/L1RiKIUPQO+VC1Tst2k7FJ4Xksm/8oy3ktP1IuoJuC77ippU25@lists.openembedded.org
X-Gm-Message-State: AOJu0Yxelk0BOkc3QOmx4u/tpI/HMyu+R91Ad1v0z0XVywuS8ZgyYzOq
	xF71LwcJ6f3xLTgftV3jiapeJ4VG4lPYxMVBMTFBRC8Dm1pSwmTSaP12T+y9e7jH6Y6J6HaPgZQ
	qkZB64EsUy+MEc0+EXnYgZCo7/qb+1g8=
X-Gm-Gg: AeBDievy12na/ToWKUXI3dnoWPQ5IRa2ujmrKna4rw/LAFV0V+OCH3Z3VfvzBBChWo2
	zrxEN6AMGtGnVs79cIxuKxHEYcCqK2jQQgm1GOpXCaFDx5TEUsGXoSZl41XxZ3Vu6X9iSqD6CAE
	bxoOVy+e3lTYK+FKNoJ+kaE2LOCWoRHq/5SCrdjuK8fcfknBP64IrcGoNKLPfWDt8CG1XEW9x4Z
	JVejwFfOdE/kAM2c1hNbxAsnrzv1dCXfQt0IHg+0OOQ/58TGZfCA2tXCpaU3Q/bmYI2VzBY1RZi
	g1OMzlrV8kuo90XQkNCRuphtmUuFY8pq3cXCNc7AK7l2pA5FqMkE
X-Received: by 2002:a05:620a:f0c:b0:8f0:7516:da99 with SMTP id
 af79cd13be357-904d70c4701mr456524785a.60.1778071392755; Wed, 06 May 2026
 05:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj-hrSdEoX5XRmM1MYhXMVkqpa0CBHHbMqVhjM034bKTDg@mail.gmail.com>
 <66b3dbc7-e6f0-4013-8d2e-d646f0fd8c9b@baylibre.com> <CANNYZj9dsi3XDGVBtEM4Hp8eqZfLtf9Jwa-0m8T5J9rt7V7skw@mail.gmail.com>
 <CA+HEL7_H1MJe3WGhdP3TMQho8u0M8g5OfUv2oFXxQjefAo6Hnw@mail.gmail.com>
In-Reply-To: <CA+HEL7_H1MJe3WGhdP3TMQho8u0M8g5OfUv2oFXxQjefAo6Hnw@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 6 May 2026 14:43:01 +0200
X-Gm-Features: AVHnY4LICyWcOF1-eZVhHEx-EEHUtZdI6jIUnqeVl84lkemZXGWw2STAyq63z1Q
Message-ID: <CANNYZj9=Qap1AsWfgFgEforE17Gz8ft8fNz4hJcU4Y=zmTKDZA@mail.gmail.com>
Subject: Re: [Openembedded-architecture] proposal: build pipelines in bitbake-setup
To: Daiane Angolini <daiane.angolini@foundries.io>
Cc: Trevor Gamblin <tgamblin@baylibre.com>, 
	openembedded-architecture <openembedded-architecture@lists.openembedded.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Yocto-mailing-list <yocto@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 12:43:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19446

On Wed, 6 May 2026 at 12:23, Daiane Angolini
<daiane.angolini@foundries.io> wrote:
> > 6. Run a pipeline, stopping after a particular step:
> > $ bitbake-setup build <pipeline-name> --stop-after <step-name>
> >
> > Etc. How's this looking?
> >
>
> I like the term `steps`. I would like to add that this should be
> optional, not required. One can still decide to avoid creating a
> pipeline.

Yes of course.

> Regarding a setup tool for builds, why not use `bitbake
> <pipeline-name>` instead of `bitbake-setup build <pipeline-name>`?

bitbake operates on recipes using a well-known command line interface.
We can't bolt on something entirely different.

That said, pipeline functions don't have to be in bitbake-setup, they
can be in a separate tool (Trevor mentioned that 'bitbake-setup' as a
name doesn't fit that functionality very well). I just don't have any
ideas off the top of my head. 'bitbake-pipeline' ?

Alex

