Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD810CF31BA
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 12:35:46 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5853.1763555746336983818
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 04:35:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iCRg77gr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso16904765e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 04:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763555744; x=1764160544; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oUC6ECs8Rx3K+cQmHq9SSAKrQOgW/1h+O+Am7g2Oxg=;
        b=iCRg77grlkT3uD9qLoaQmNzU1tqyEieokYoKU1OHIDhCe1K9bE6EFixuKKnOzy2HBs
         TKEICr1D6Qt3XSWPc3bTygI24zu7vuBcdsmcvFQKhQwBlkD3C+ZhppyTSx0jRrhOWj7U
         UF91axLBPU5bbkZmdBrYyjA3xdoLZg11mzYi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763555744; x=1764160544;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oUC6ECs8Rx3K+cQmHq9SSAKrQOgW/1h+O+Am7g2Oxg=;
        b=l99X3IEOCxgVdhh5H+4dDFxRbvJxsOGY0/+2kKu+Ikw/URaxrMUjAvo/HnpjCO7QdV
         5TSC44wxxrky6mV+UOmyVg3VaCK827fSj6K4dDAjswhnTEVEvJiQhPTVbZyAQDld563i
         Rqy9HchB2UZFRIanC0rUom4SRBgz/Sw4iWZcRtlat/Sh4NUR+Be7ZdcqrtV8JCawQ+3l
         LWMbDkJbc3Pe5T4eDJVBnF567wOH+KKmvYPDtTghW84Uab3dAzP3XMhkOoY33z4gwLJ5
         1cKT2NjqHZp9SNb8PKL5keq/xqo9BENFKzhkBZQ6T9MKPSrb3Riu1+Yvg+JEU+Adg++r
         hWBg==
X-Forwarded-Encrypted: i=1; AJvYcCWhfrQE4e6oqGCk9ex+p8vOnKnvit1F0L/3Mhv+PZUZKp36htN7HmS+Tk0QB6N84+rhB5ZPKtfwIS5qkf/Y@lists.openembedded.org
X-Gm-Message-State: AOJu0YynLf6jXyaq53PehurQ62PpchWbJa+e+hjVJakx9qj/ICts2Dks
	RaC4wosngk8K3BwRMfSdwuQAs5uoDQheO/WcH7RWfWglLTcd1XTifR4oqgq9Vy2ho5U=
X-Gm-Gg: ASbGncsXzZaIMTQ/+xfyCGsqF0wCyNl/6o+XGOmr7KCqUN+dUQwbILAVjepnVEO9MXr
	j5bkbd7Ff06ygkl4an1UxbxiRv7DMU+RnmUPgLlU3br7GIUNpTTIoS0A/k27c6Qr/cCtT+/PIuy
	kmU9jWnJvpcn4ZLjG0W9tmIFmLhFaMD0KjWe2Bx/224LNo1MI407xhlun5j3dO1i2y+H/xcFh5w
	rHQkn3U8LS2C1EATRkvp444qpfOh1dP4DjSygTARPDQTcLj6y7lqI39rSDpZ/PKzT+8V8Ebxn09
	6TegOlAcVWNJXbpQJjoh3lFSoLn2rZLjRn2lXruRU6X1aUtFfJj1FXJIVweNnP/JMmDFl4Vvek2
	JuU4auExV7CZn4w21+mBt6QWalCwfz6z4xFR2dRLP1vzOpCTxQfP7LmtEG1c2k+/62QvV40D0rP
	bLbIqgHjhQvOlZuMcNx/SrNhJ9OfrugcCJCmYRJbOar0DF6B9am8jz0xScFJry15TWVBPPS8nLt
	oCoTmN4mz+OAQ==
X-Google-Smtp-Source: AGHT+IGOhNbj/u0B4uwJMQn3eOoh4jPWVovSoRozEnccXY2l9Pr/FRxQOdj7DkQAgNFbOuAIIvvW1w==
X-Received: by 2002:a05:600c:a49:b0:475:e007:baf1 with SMTP id 5b1f17b1804b1-4778feadb6dmr175060455e9.34.1763555744286;
        Wed, 19 Nov 2025 04:35:44 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:8b60:264a:98da:e4b2? ([2001:8b0:aba:5f3c:8b60:264a:98da:e4b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b106b10asm46295965e9.10.2025.11.19.04.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 04:35:43 -0800 (PST)
Message-ID: <40e6833209f3155e7bce445ba8f8d32cada2388a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bb/utils: add layer_path() function
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ross.burton@arm.com, bitbake-devel@lists.openembedded.org
Date: Wed, 19 Nov 2025 12:35:42 +0000
In-Reply-To: <20251117153649.3611181-1-ross.burton@arm.com>
References: <20251117153649.3611181-1-ross.burton@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 12:35:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18454

On Mon, 2025-11-17 at 15:36 +0000, Ross Burton via lists.openembedded.org w=
rote:
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 366836bfc9..8106ada29c 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -1902,6 +1902,22 @@ def get_file_layer(filename, d, collection_res=3D{=
}):
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 return result
> =C2=A0
> +def layer_path(layername, d):
> +=C2=A0=C2=A0=C2=A0 """
> +=C2=A0=C2=A0=C2=A0 Return the path to the specified layer, or raises Key=
Error if the layer
> +=C2=A0=C2=A0=C2=A0 cannot be found.
> +=C2=A0=C2=A0=C2=A0 """
> +=C2=A0=C2=A0=C2=A0 bbpath =3D d.getVar("BBPATH").split(":")
> +=C2=A0=C2=A0=C2=A0 pattern =3D d.getVar('BBFILE_PATTERN_' + layername)
> +=C2=A0=C2=A0=C2=A0 if not pattern:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise KeyError(f"Cannot find =
BBFILE_PATTERN for {layername}")
> +
> +=C2=A0=C2=A0=C2=A0 # Sort and reverse to protect against BBFILE_PATTERNs=
 that don't have
> +=C2=A0=C2=A0=C2=A0 # trailing slashes
> +=C2=A0=C2=A0=C2=A0 for path in reversed(sorted(bbpath)):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if re.match(pattern, path + "=
/"):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n path
> +=C2=A0=C2=A0=C2=A0 raise KeyError(f"Could not match BBFILE_PATTERN for {=
layername}")
> =C2=A0
> =C2=A0# Constant taken from http://linux.die.net/include/linux/prctl.h
> =C2=A0PR_SET_PDEATHSIG =3D 1

I have a concern with this.=C2=A0I think having such an API is good but I a=
m
worried about the implementation details. If we add this it means we
have two different pieces of code handling layer pattern matching. I'm
a bit worried this function could return one thing while the parse
process could do something slightly differently.

I think in the next development cycle, we may be better off clearing
out some of the legacy collection API since layers are clearly the
better solution to that problem. I'd hope that allows us to simplify
the code and allow a function like this to be abstracted.

Cheers,

Richard

