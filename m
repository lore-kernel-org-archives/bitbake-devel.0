Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB4DC021A4
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 09:50:05 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web10.11426.1739353796183906734
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Feb 2025 01:49:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jAVC8/8u;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e4554e1c26so7188416d6.0;
        Wed, 12 Feb 2025 01:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739353795; x=1739958595; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5KQ8TPoyLPj56jctqzBkIjn5eR1qAoevIaen95/9evo=;
        b=jAVC8/8uhsb1l0FoZef/MkIQo7a0gntAM+xoO4GXVHbwNGiZEgj7s+DW+5F9ivGzbH
         UcGiLU7jIwJwFmHq+BLuXO2PNy/dguYUvvwCX5gyQHSP3Z+bvaCsgsu2O6rsKXNjaWfL
         YH7E6XM/lsFqU7XC5eP3LuahaNAamRHg+mJ0tCN+uXU/MH/dZU9IN9du5JQbHzD7OIrJ
         dH0D/5hFSYqJWyw0ciz21r8irawPmDT63WoltEcoMIJFisUa3JGLbzfXZXfiQuErF1ot
         oBdGjwqdqUoNQs0GRACAQTx7i1r1rPoP+mpFwvHgyqI6f3WpgqlGPOi9AiL4ioYHqVDW
         72TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739353795; x=1739958595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KQ8TPoyLPj56jctqzBkIjn5eR1qAoevIaen95/9evo=;
        b=chYKrnMk0pIzerkZadU46yfSpwlgIfmYIF4uHb7x639C1fDM6B220JV1ntlK2BfEF1
         Idg4aXExVFmYTlmbwUlz27JZvhigSYg8VDVSIXbVEM9k1ghGoX8N95Q7MyqS+pM2iFmV
         Rw/hTYjybPE2yn+uxQAB/lL99lPF+aeOFn046x3712tkwQennNrR5HA/4/yK0E/6ucpO
         +QxctpLOCOA7SvkntbBvWXydQ54Vd0QaYtKb/UDEwv6PKcnCe6hYXYPZLMQyEfzcT8C/
         tSb5y9WyUl5tWp/T0/aj17uDziDzulg6AIdxFPq7G+TkHWC3rfZUFrGQFDVnL2vRXesb
         /9gw==
X-Forwarded-Encrypted: i=1; AJvYcCV4Z/6+HggKT7FrMsnUDymjxT3t16uORRS1dEkU+6x3e92Za4rNkt7YtBj4BIJXb/lvpRAGJp9hDsNK4xGcouHEvyA=@lists.openembedded.org, AJvYcCXWOTzkxBxBaWHRlmNWpFcOG5qhO5Lp9BeO84WO6rHo1ycQ/NUiptvahBefWohVSdA0szxev+Tp+Zk+MEwi@lists.openembedded.org
X-Gm-Message-State: AOJu0YxUzNL5g8+hRhgBowEZKu4otLnNxeWA5MXhxgEiGPhj2HwfVDUC
	KcDhM1ydikbmRSjj77VTa4nb3MNdvJtuMNA7WwdCJkZTEr3WhU5QvBGTc0IJ+6qul/epWrWOceG
	m7DnD+k/2MGG3fXkUliu4yvdOO5I=
X-Gm-Gg: ASbGnctjTXfLgCYaRsaOahvTBZITAL9aJ7x6cL7rVC8KXkYzKkVHsuw7MVD+rC/qo9H
	NeY8OkWhUSX7aW/IWWKjQvktWBWMBSw6B+CcOMpSkiXVlm4w1q8aqdq778mSfrIREIEFUSqtFNq
	+eCBPG3O2CVKTfzWgYsIWLimBcI/FeC1A=
X-Google-Smtp-Source: AGHT+IHAoCc6nEpf0l9G6eGa74AgDz9UpqUYS/9w5dk2vaYF9LMhTiDX1syytTVvpv7rcS5tOV7HgJpgBhVCWxu8qGo=
X-Received: by 2002:a05:6214:5096:b0:6e2:49eb:fb7 with SMTP id
 6a1803df08f44-6e46802e37amr85190986d6.3.1739353795283; Wed, 12 Feb 2025
 01:49:55 -0800 (PST)
MIME-Version: 1.0
References: <20250211150034.18696-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <20250211150034.18696-11-stefan.herbrechtsmeier-oss@weidmueller.com>
 <DB5PR02MB10213E77A6A5281EE044BA688EFFD2@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <81801173-8a60-4278-a8b1-70715fa5accc@weidmueller.com>
In-Reply-To: <81801173-8a60-4278-a8b1-70715fa5accc@weidmueller.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 12 Feb 2025 10:49:42 +0100
X-Gm-Features: AWEUYZka2dEI2yWaqOcMjBYfdLIZbHt9qm-4veF6FAXMKeQTpFa1_Qv_nDKgSf4
Message-ID: <CANNYZj-D--g+ChmBH-9kP7vj7cSNrJ=fKVmSUi8zHoLJ_EUZ3w@mail.gmail.com>
Subject: Re: [OE-core] [bitbake-devel] [RFC PATCH 10/30] conf: bitbake: add
 SRC_URI_FILES variable
To: stefan.herbrechtsmeier-oss@weidmueller.com
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"openembedded-core@lists.openembedded.org" <openembedded-core@lists.openembedded.org>, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 09:50:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17200

On Wed, 12 Feb 2025 at 09:55, Stefan Herbrechtsmeier via
lists.openembedded.org
<stefan.herbrechtsmeier-oss=weidmueller.com@lists.openembedded.org>
wrote:

> The variable holds paths to files which contains dynamic generated SRC_URIs. The dynamic SRC_URIs are unknown at parse time and only the file paths are fix. The files are filled with generated SRC_URIs via a separate task.

This doesn't explain why we need this separate new variable to begin
with. In what scenarios it would be useful? How does the
implementation rely on it?

I'd suggest SRC_URI_DYNAMIC, we have a precedent in PACKAGES_DYNAMIC.

Alex

