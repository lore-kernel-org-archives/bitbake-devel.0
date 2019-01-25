Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id CACC77C394
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 14:10:49 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id 96so10481646wrb.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 06:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=0kuvSTEKWS+YSvjAAb2Rb3yNKajiXonFwQ8ggW2dDqk=;
	b=SjkigSPoXs99qx/u5DecMLCG3gKORxr8bgIFx5xJj41RCKi2YA1gKfW0u6S9pwc3IB
	kyDEZbq/GPORf0i2OzDvXrdlcIAZVJ1kRfMJ23XVKzWB3DlNbr4IL8RdR+xIeNyoRcn8
	bnsPYbxo1G/HfS1yUCCJ/gVFatevO1kw6YKCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=0kuvSTEKWS+YSvjAAb2Rb3yNKajiXonFwQ8ggW2dDqk=;
	b=Djb5Qa4ZzLvBEK9RcPWeHUEocdNMWqMlxDQ0JFWZQQIXNzY7eULbrdCeMwanGads2H
	bB7tKLzYBzpCfzj/MfwFWquR1hKG8sIzxfu+ECFykQ5yyjv48+nmCPpQE5Nx9zjnHXEd
	4dC8GWoBDRw4Lmbxe40tpD/CwibMIhen4xm1m6/MlGPz+ZijZF9gArFXFr4/7MJsiGRo
	qPB4oIrew1tZyeNoNPinOAms2XbRrc3HmSNAkwdvrcwZfTOEV3VXURoSSKefqn6BAB4h
	m8dMt16TSZLR2O2PVzMqRqK57oq1NZqdatA9MU+Gg48gOK5eCJUqX0PdUjBzvSbmkvCv
	sHWw==
X-Gm-Message-State: AJcUukcQgPhtlaK6t6b4BwOzlEOugHA4c4YOB+PSrAAFXYN5DvZ7tZq+
	sF9CMjYdciAf5g47rcDze6SoBA==
X-Google-Smtp-Source: ALg8bN6i6fq6mzTfNNVY1xR0E5n4ru939Ulh5d1LAm0eSl5JyTBkz+pMyOltnqjM9dPG2qy2nkfAMg==
X-Received: by 2002:adf:9484:: with SMTP id 4mr10994422wrr.98.1548425450328;
	Fri, 25 Jan 2019 06:10:50 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	j14sm87821923wrv.96.2019.01.25.06.10.48
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 25 Jan 2019 06:10:49 -0800 (PST)
Message-ID: <31f945c230acc44677171059ae3aaac8950e20c4.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ming Liu <liu.ming50@gmail.com>, mark.hatle@windriver.com
Date: Fri, 25 Jan 2019 14:10:46 +0000
In-Reply-To: <CALatG=5tuk+qOc3D67wFpP=bnPxxyP4r-K=5wD2ieVgMYEhD+Q@mail.gmail.com>
References: <1548413847-32550-1-git-send-email-liu.ming50@gmail.com>
	<18561a9b63079e5dc2d4b4a8b6b12728475b0402.camel@linuxfoundation.org>
	<CALatG=7YgmkROJpk_6pfZFKGP3=RjoJC_mh3gRsKMF+e=6=aqA@mail.gmail.com>
	<1dbceb752ca54fcbb32c4c4325272b80670693f4.camel@linuxfoundation.org>
	<CALatG=5tuk+qOc3D67wFpP=bnPxxyP4r-K=5wD2ieVgMYEhD+Q@mail.gmail.com>
User-Agent: Evolution 3.30.4-1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org,
	Stefan Agner <stefan.agner@toradex.com>, Luka Pivk <luka.pivk@toradex.com>
Subject: Re: [PATCH] fetch2/gitsm: fix config file concurrent update race
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
X-List-Received-Date: Fri, 25 Jan 2019 14:10:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2019-01-25 at 14:44 +0100, Ming Liu wrote:
> Hi, Richard:
> 
> Involve in Mark.
> 
> Please correct me if I am wrong, but according to the code, seems
> these upper level locks could not protect this race condition,
> because it's inside the GitSM unpack function, the call chain is:
> 
> Inside GitSM:
> ```
> def unpack
>   -> for module in submodules:
>        -> unpack_submodules 
>             -> runfetchcmd
>                  -> bb.process.run
>                       -> git config submodule
> ```
> 
> since 'git config submodule' run concurrently and try to modify a
> same git config file, hence the race might happen, but it's hard to
> be reproduced since 'git config submodule' finishes quite quickly.

for that git config call, workdir=ud.destdir so its not in any shared
location like DL_DIR but in a recipe's workdir?

Cheers,

Richard


