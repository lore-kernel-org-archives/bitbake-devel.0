Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7147FCCF9F8
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 10:20:19 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8245.1762510816616236704
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Nov 2025 02:20:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BHMM3hOD;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ed86157911so7125811cf.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 02:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762510816; x=1763115616; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SZJA0eyU3g2ZPRGLqAlQOKtm0z+2PQFT1X/MNy/PIRQ=;
        b=BHMM3hODoj2EgMr4NtSjws/VDSgBESx+ALmVOUw7LVyw0pHjw7WU/ocGZ0q7NSwabi
         FUiKz1TrCV06+jM7sXIv2lU9DlddmYqYxnT+W539Im8kWFT+6rTcXRUNulBLvQ3hcFKJ
         JO4QAC7ZitAbxaFFndWKW3u13zj2W17ATtfXv98d/IaS8ezb+OyeKNam3RaNf3yhQjlc
         7DpMyTUrCffYEievDomAdHpHyfa7JPnMSSgD8EC+etfBzn/V6h/UonYpGM9hQpd86H2X
         reyWDxXC4TJYbRokTcb+HZTz6OsT7xfaTjPmmnR7N0VXWbRmo2eyk2HAxsZeVVh/suOS
         PkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762510816; x=1763115616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZJA0eyU3g2ZPRGLqAlQOKtm0z+2PQFT1X/MNy/PIRQ=;
        b=xPiZlCrl+nAT/iUxMfs0MSIovjQHebwQWJRFdPzurWftZ4WY5CiW/Bx+E7dntg8kkA
         6Wz3PnMo2MjplA7W4YPf3mVWgs2rO69vK/eRS50/A+CaKBtKqf9suhlqVz0ISmlIJlYF
         TVS4hTDzKaMkS1uADZmFD9XajJcbIRUoFYGic6kpLa8SQt2PnLS1NBUwnDaknDgxHIU1
         7nmtE/PsxU7JRdDkKA3gob/ASY2eEvhBXLNgRDDJweFRAiz4WdXIgQIqUPw9GG7BBH5D
         nnV4np3V5S5WLsgfvAg2ijz2iJfqkjAmS0B0KBD4BBfyTJu/z+TAjgzNTEJWG82S6fPr
         rE4g==
X-Forwarded-Encrypted: i=1; AJvYcCWoe81K0BPl6+mP1tU+ydHflkNWKee8kZDOQWUxLPhZ/KENCaGPIGLp421dAMPSwDJdHoRrQu0Z45028j/i@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy+wKPYyqfUvAIVjmDO34kvIoMRl0aN1DSkwFJPsSw9GEVRppRO
	14DsnsoDPkhRIe1BHdGWFhd3LqPo1l/BSv5zYdZwoG+y2j7mEF/SsqUbFyatOEtOzIY1Rg+eKSn
	QafMG6TvlzHawLqmgzK3mFV2mSiDGHKA=
X-Gm-Gg: ASbGncuYhD/y/6t5cdCRIp5nuIwAaAzdq4jVVA1qnX6kdB2rEi3RjaxgsATN7Z3/hnm
	SjJeRneI2QZFGO08mpgVMz2lySbaU5QYjwKjth9VUbcGleVqhY7BEBLy9379XBqgzWPWspqNL5U
	fkGgj5g5kkkrP58sxCgtGX47utH5Cges/pRi9lc0/7kLp7Pxo7sFnectIAj5r9sfWQMzRH8sMU9
	RnOaVubqQ4PZgkqpyuz69+rmMhcYA3Eg9sDcPFHyneM2Hrw+LcHvJC68wa8T+2RDASwJWEj2YbY
	KedVZ/yI1YtOyl4fbPN5IR7cUHDZ3Q==
X-Google-Smtp-Source: AGHT+IEjIQTzLFq/9pt+RWEVTbeb1UYi4sOU4P4C4henPzoPlozpB9sC5SGLy/Ze17b0AFjwxsvFWmWGB0TVZynIEsU=
X-Received: by 2002:a05:622a:134c:b0:4ec:f9eb:ff8d with SMTP id
 d75a77b69052e-4ed94a83f62mr26507201cf.79.1762510815628; Fri, 07 Nov 2025
 02:20:15 -0800 (PST)
MIME-Version: 1.0
References: <20251106114714.918370-1-alex.kanavin@gmail.com>
 <DE1LO4GV39WM.156UBA1PODPOV@bootlin.com> <CANNYZj-pgb6SMxhzB4g-siGY7oWaNjb=jOSk3m-TRKLwHPytFQ@mail.gmail.com>
 <278bb2544a713588af57889f35197e0c6f424c8b.camel@linuxfoundation.org>
 <DB5PR02MB10213C5C0AD578C01BF7DB065EFC3A@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <CANNYZj_qwFt6F-LEwMqe0D04dy7t9_FJMWf1tpCUZ0bayfdUZQ@mail.gmail.com>
 <daa19e97cfc92bdfdfdebc0b344dc11c6462d0fc.camel@linuxfoundation.org>
 <CANNYZj96A91YLjusG__6Nb0G+5xzsqTXSmPxha_H25J2H6RpVg@mail.gmail.com> <23ceab57be35384282f708b8a0a4f9d0c9f7d338.camel@linuxfoundation.org>
In-Reply-To: <23ceab57be35384282f708b8a0a4f9d0c9f7d338.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 7 Nov 2025 11:20:04 +0100
X-Gm-Features: AWmQ_bm2CVPrw-NchYSceLdnwtMMkKruqe9IGSf1sw7cSHYMg9OLxV31D09h7DQ
Message-ID: <CANNYZj_dABVkbqu4E-Z-LLyALkpv8pzVdZu=+x9W_MqxfsCqsA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: replace {THISDIR} token
 with an explicit keyword
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	Antonin Godard <antonin.godard@bootlin.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 10:20:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18305

On Fri, 7 Nov 2025 at 11:17, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:

> No problem, I can make this one based on one of your patches.

Thanks! Don't forget the json schema too (I sent patches for it, so
can be reused too :)

I'm packing a suitcase right this moment, but I will keep an eye on
emails over the next days.

Alex

