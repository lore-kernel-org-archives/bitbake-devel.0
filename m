Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73054CCA471
	for <webhook@archiver.kernel.org>; Fri,  3 Oct 2025 09:35:49 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.3644.1759484145743487972
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Oct 2025 02:35:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Angh+cz2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so14863935e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Oct 2025 02:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759484144; x=1760088944; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWUAOHQ5fK5Ko5a3AWesjbGOU23NP/tH+F+94R303yc=;
        b=Angh+cz27gcJ8X2gGBoQuetLwhGVF/ZwP5XlMw2uGvAoEnt6n9MnFg7UE6qh/c1WXa
         wFRyJfDnGUaJCimr3VQgg56rBJNwQeMym85qumZ5/EMuG5hoBWApyuc2PYXQWgMcpuSF
         Qlh5VZvEURtslMItt3OE88Ckw2xnKsJ7hVbPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759484144; x=1760088944;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kWUAOHQ5fK5Ko5a3AWesjbGOU23NP/tH+F+94R303yc=;
        b=AwoBfh+Ari/7A154ch0OuF4/zOCpuxHhzDhQ6AnubMusV1SLkKdL6RDEmLmQgh3nMK
         Q4ujJNGsews++rXxvb+uwFyusKMMGK39/ab/F8H13wdbtLgBYdfKVlTMIDVUYKqqSpju
         sqGlZxdKlpVa4D6bbQ2DowjBPVkz1mB7IiA7iHkBGBggS/q25y3NwdLCDB5PmePPm9to
         CvGJy5Bo1kQQxxoqXLVN66rTMNoCCTjgkjcYoNFyy08gwytsBD2pBi7WYI3wrPr7X1jJ
         H7zYEQAUxRxk+dLaV0kwgpobviUm7X87Qgf2T+x9dB8T5PQ74ne8ssucu35J4LbECsPv
         Qmxg==
X-Forwarded-Encrypted: i=1; AJvYcCUvxNmL2StjiMvkSECyvGSCImQW9fjCzW61X9OWzrQMAtDzqbw26PQ+HZTxRdrmxzkO+5+EZTjE/YXl2LK7@lists.openembedded.org
X-Gm-Message-State: AOJu0YysE6Y0IhtzjGNezml/TziHh4Eh2FMoET7ja9bm+vyFn1NnzfLQ
	rXKSGyzr6z5jAisxeDbYoiDUVPMDnrEV9+RFybE4mHpVRwjid6fPpXfTHP4CjTS6PbY=
X-Gm-Gg: ASbGncupkkJXiPLgi3TN6pX0/Odm+qSlITxTkafpzhEUHwOVI8Ok9TGlO1ELvVuZPBf
	lmNwyyApoCuwbAOVaM4UQI9FCq+MofToUDbETeqLawX/BxNEPU7orOjf3Xqzdu+/faAbnePnCuy
	MvPDizTWi8QmQKRPI9/zJoiQZufHiACIyVq0Jm6AsdnXpgHBDIr+1H4f7WfNtaiDRkI3fVMFQvq
	musIqxfh72wZfWKwyCfQcm5RlBGawqaxCRzqtONSiVkI+2ttSkFQjDmeyXxZT7+WtfsBrNyc1S4
	EDshA8ChHMMEcFBKzR0IOBSv+WKW85XXh2MU0hI84M9vrCaRJFlDh7BOY3GwpNlcSibZwo8lMdO
	rCe4kWshJW49ckn/riyzAszwfsnq7Dps24mJ3TKyXfWXGO1TXicp2of5bEXOezJ+n6OcCz7iq9U
	9g1CHOBEjkhyLPaCB/bfsiQjOBreHxsx2M
X-Google-Smtp-Source: AGHT+IER3iO360Pox+PUDIWxt7g2XVfww8i0l9qRA+0y4KpL2BsSQOtDa9Rhdzwrn5JqMrn3Z+vKjA==
X-Received: by 2002:a05:600c:4fc8:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-46e7110adfcmr16224445e9.12.1759484143949;
        Fri, 03 Oct 2025 02:35:43 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:67c:cc8a:4a49:c12a? ([2001:8b0:aba:5f3c:67c:cc8a:4a49:c12a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234e5fdsm22788845e9.6.2025.10.03.02.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:35:43 -0700 (PDT)
Message-ID: <8bf3234625affeee077859ea356928d64b7116b0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake-setup: optionally support
 JSON5 (e.g. comments) format
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yoann.congal@smile.fr, bitbake-devel@lists.openembedded.org
Date: Fri, 03 Oct 2025 10:35:42 +0100
In-Reply-To: <20251002155210.782342-1-yoann.congal@smile.fr>
References: <20251002155210.782342-1-yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Oct 2025 09:35:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18128

On Thu, 2025-10-02 at 17:52 +0200, Yoann Congal via lists.openembedded.org =
wrote:
> From: Yoann Congal <yoann.congal@smile.fr>
>=20
> One major limitation of JSON files is that comments are not
> supported.
> JSON5 (https://json5.org/) is an extension of the current JSON file
> format that support comments (among other evolutions).
>=20
> This patch adds the support of the JSON5 file format when reading
> configuration files.
>=20
> Sadly, no JSON5 support exists in Python stdlib, so we have to
> install a
> module. I chose https://pypi.org/project/json5/=C2=A0(but
> https://pypi.org/project/pyjson5/=C2=A0may be an alternative).
>=20
> I took care of only patching reading of the config file, the internal
> JSON files of bitbake-setup are still in classic JSON, which mean
> that
> operations that don't need to read the original configuration still
> work
> without a json5 module.
>=20
> I put an example of a JSON5 config in
> default-registry/configurations/poky-master_json5.conf.json
> This is poky-master.conf.json translated to JSON5 plus some comments.
>=20
> To try this:
> =C2=A0 python3 -m venv .venv; . .venv/bin/activate # if needed
> =C2=A0 pip install json5
> =C2=A0 ./bin/bitbake-setup init default-registry/configurations/poky-
> master_json5.conf.json poky_json5

We could do something horrible like preprocess the json file and remove
any lines starting with "//". That works for reading but not for
writing.

I'm keen to try and keep the external dependencies that bitbake has to
a minimum. Why? People don't realise the issues they create for
documentation, container environments, things like build-appliance and
general ease of use. Yes, you can usually pip install things but it is
an extra hurdle for users. The websockets requirement for remote
hashequiv is an example of how an obvious/"trivial" dependency can work
out to be a pain and a usability issue.

Given that, I'd really prefer to stick to what the python standard
library supports, which effectively means json at this point.

FWIW I personally really dislike yaml files too, for no particularly
good reason, I just don't get on with the format.

Cheers,

Richard
=20


