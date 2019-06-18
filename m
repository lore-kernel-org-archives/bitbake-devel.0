Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id AEDD07E923
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jun 2019 15:59:16 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id f9so50308wre.12
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jun 2019 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=hQedKZ9y8ekY8A/9EtHFgStcSSzyCH9S6lHjmuaITgg=;
	b=ihyy+ErpBWISr5zxeWILvhN4lOErDklrllyzfeqc6Dg4m31OF1vrWQ+BYxsfoXdOc1
	bXRHvZUsqsRseaLdtA1qVHt6MLNtNJgY/NbmGua9cEFG4zu9TD1jENbXI6U23Lazh7iH
	AQDaFGRaptv3ZnJWM/975VLPR+H4SIue1DPbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=hQedKZ9y8ekY8A/9EtHFgStcSSzyCH9S6lHjmuaITgg=;
	b=qNKc60PFpAwLq2aVFsh0UNSYMNPfeZ0ZVXcpDNBTcMyc/4Ss3djopU46JBRyA1TCtc
	kCJExX8nV4/533H0d5VBt9X66ND9/I4O2XLzrcq9g2VbBu2QtOWjshVZ14JljQNENXe5
	rU83cQpU9SvEoGzzLS8+Pc0DWW1o60nnryHTWscUbmYgVpa3X85H+ktpar5Xz4A2ku3i
	6m0kj1lqOZXO9JJK3ypGhSk5q1rR3nnZ6f4nIGJ0aZbYHYVTMXXA2Vbdbk0TZ0fS/kW9
	pec0N2YY+csHE/DheSk/S5fRKQvStmiO+TO35ZpTXxIifet8TO1/2QbhESSb0zdfkzq7
	Qc/g==
X-Gm-Message-State: APjAAAWFOPI+PkTMCHTzRwAHc4esNs/P4EpQy9Dm8TcWwrRhUtiDep+X
	TqtYmT1fWJwDCcMkqopyQmhSTg==
X-Google-Smtp-Source: APXvYqyIf9ppebEwAiWynBPDloprOAmwXPMENexPIqLzjcri4cBXvcVNKWfMKn+YnhkIG2oOq4OBkg==
X-Received: by 2002:adf:f812:: with SMTP id s18mr16510015wrp.32.1560873557429; 
	Tue, 18 Jun 2019 08:59:17 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	u11sm11159671wrn.1.2019.06.18.08.59.16
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 18 Jun 2019 08:59:16 -0700 (PDT)
Message-ID: <21e75add4a5c58632ef8817d9c9c0a94d88fbd1c.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Armin Kuster <akuster808@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 18 Jun 2019 16:59:15 +0100
In-Reply-To: <cover.1560872271.git.akuster808@gmail.com>
References: <cover.1560872271.git.akuster808@gmail.com>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] 1.42 next pull reqest
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
X-List-Received-Date: Tue, 18 Jun 2019 15:59:16 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2019-06-18 at 08:41 -0700, Armin Kuster wrote:
> Please consider these for 1.42
> The following changes since commit
> 2a823584a5dbc2427060352f3b4798dbb2640cfd:
> 
>   gitsm: Fix a bug where the wrong path was used for the submodule
> init (2019-06-18 11:43:03 +0100)
> 
> are available in the git repository at:
> 
>   git://git.openembedded.org/bitbake-contrib stable/1.42-next
>   
> http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.42-next
> 
> Matthias Schiffer (1):
>   fetch2: runfetchcmd(): unset _PYTHON_SYSCONFIGDATA_NAME
> 
> Richard Purdie (2):
>   bitbake: Add initial pass of SPDX license headers to source code
>   bitbake: Drop duplicate license boilerplace text

Do we really want to backport the SPDX header changes? I'm not sure
that is particularly desirable for the stable series...

Cheers,

Richard


