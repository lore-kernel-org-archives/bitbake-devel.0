Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id 2DCAB7F883
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Dec 2019 16:46:35 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id p17so4434540wma.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 05 Dec 2019 08:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=CtqPgpQ8FTIA8UKUmxGV0WQi0Z2bOyk9BM0xk2TtO6w=;
	b=eCack96eU9837nx3K25vjz//s01FNXmygcDsSKljZKmDXJZ3khKVqaUrTd5xbs0E/0
	yuOl1+iA2EzeYEAUhQaIpZ8hHWH/mKgsDcKGTMTycEH00nnWEgQroqgBWxuN2bSzkOBH
	5eEzUg4aOYHY2qjwRh77BnjW+rPlMhWFZ23Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=CtqPgpQ8FTIA8UKUmxGV0WQi0Z2bOyk9BM0xk2TtO6w=;
	b=ZeFrZFUSwc58+YsH66gPC6W1i4L8CGdLVVvsIZXS0qidt0aDdoSmSDmjRhjZcQ7eP+
	cg9/yjwsrpSqWJeRgwmWq/Y2FQBPUh6JUwJIL1gjOfPyxNhr3YWxdasWK6sPYw3ZHRWJ
	FKyaW8vJZgnmylVy3+/mk+NeuGK8KUIPfcyCq7JROcmue7uKszt/BI2G0Mf4AnRqUXTl
	qc/3+qSHekktK0r4cHuzx98oezHcIskNYqfNUcjZ4/HRg0d4F3U1lZWKbjFLDpJ3l7e9
	s/SHU5N4bGdOIPLcGdls/ehw8r97rWpTJTFsmn77pMYEAdKeCSDpa9bYe5ii8kL2v9zs
	UVnA==
X-Gm-Message-State: APjAAAUs5SCuzcO7vCYJDw9uMjlp4WOLS5rPcvglsvl3tHCa6TSAEl42
	e7swD9v/KsLUGrJduXwgFAkaSdJAFbc=
X-Google-Smtp-Source: APXvYqxQdfNFheY5Xd+A+ZaC0qDtaatb7Bjd7d/GtVqqAOufTrUxH8plZouBYoGDMUNOLHFDUjN3Ow==
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr6216191wmg.163.1575564396536; 
	Thu, 05 Dec 2019 08:46:36 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id s65sm371415wmf.48.2019.12.05.08.46.35
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 05 Dec 2019 08:46:36 -0800 (PST)
Message-ID: <e6d5e2cdb0e649d2dd0e1383463210d364ea1aba.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@kernel.crashing.org>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 05 Dec 2019 16:46:34 +0000
In-Reply-To: <a20b8e3d-8c4b-79fa-1b16-9863a7441c45@kernel.crashing.org>
References: <20191205152909.30943-1-richard.purdie@linuxfoundation.org>
	<a20b8e3d-8c4b-79fa-1b16-9863a7441c45@kernel.crashing.org>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH] siggen: Avoid taskhash mismatch errors for nostamp tasks when dependencies rehash
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
X-List-Received-Date: Thu, 05 Dec 2019 16:46:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-12-05 at 10:34 -0600, Mark Hatle wrote:
> I don't have the context of this, but the question popped into my
> mind.
> 
> Is there a way that the system can clear the tainted hash?   (i.e. on
> a memory
> resident bitbake over multiple builds for instance)
> 
> Or is this not an issue, since these reset for each build, and it's
> only in memory?

This data is part of the runqueue so its only relevant for a given
build.

Cheers,

Richard


