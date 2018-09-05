Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 53AA374AF1
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Sep 2018 17:28:15 +0000 (UTC)
Received: by mail-wm0-f51.google.com with SMTP id n11-v6so8548750wmc.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 05 Sep 2018 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=scDUWBRF+ImVtm5QT86sAaCIW7lal+KyLbnlQkZFbd8=;
	b=a1WCezGuV0E97VyEZ0ahy0Q9IGfOXxRXGZJARBXrIeZPyRcZViDE9I64YFwz+bnfmA
	MpxBAfh0X29nNsbVYUJ+XnuzWgFWMIh872ciZK9n7JdP/GBXlrf8joGnME1NTJphjI4f
	E4RpmYN0TRQfjhJTclebSA+wLBUkn1me+Ti+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=scDUWBRF+ImVtm5QT86sAaCIW7lal+KyLbnlQkZFbd8=;
	b=uTNaQOUorCnHY4ikBDSyRrBCk0Q2BbxpmDVMD7PxrL+pCB5Se0hS68qWTb0PqPBk3i
	naCaKk+ToMBNitWFyQy2DMwEp/ykens3KuhZLmU98HOo9gqmurGF3IBXkV6THoMdmBa1
	bGHWx2I01d7k+bMyTFSPkCM+OQJacmL3rwoF4MxvaU0Ul/kyamfpf5sOdMbbkI0vG8pP
	J+p/AYXWbew3lX5fmV5mD2HdlddQPPd4HKZTXw2nFsl/VGUW3bbzuZ5eZk2xdjGc4Su2
	xZu76eFCoTovzycLXZM1JgWzKPVEsQK/lftnNvYwHxD0PolOzcWoUOZt69m/eHCTE4NN
	TZqA==
X-Gm-Message-State: APzg51ACh1UjWZy8dIkGPGeoJ6qNs49BiJzL9cuXVHp8XjKI1SXjmrre
	P5m+jThdXv9JzoS3NSMAvvlPAQ==
X-Google-Smtp-Source: ANB0VdauCIdtBXxLIH+Tkq50/RlHX8f3BY16DeM6gD4d5oXlUS8HewVF+F1zLL5piPuqYM7rM8FrNw==
X-Received: by 2002:a1c:1609:: with SMTP id 9-v6mr924642wmw.12.1536168496024; 
	Wed, 05 Sep 2018 10:28:16 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	j6-v6sm1718000wrq.25.2018.09.05.10.28.13
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 05 Sep 2018 10:28:14 -0700 (PDT)
Message-ID: <26d9005d53f6bbde44236b6bb44098045af0b9eb.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: =?UTF-8?Q?=C5=81ukasz_Gardo=C5=84?= <lukaszgardon555@gmail.com>, 
	Alexander Kanavin <alex.kanavin@gmail.com>,
	bitbake-devel@lists.openembedded.org
Date: Wed, 05 Sep 2018 18:28:11 +0100
In-Reply-To: <CC13D61A-9A15-4BD7-B8F8-531EC354D62A@gmail.com>
References: <20180901133644.1577-1-lukaszgardon555@gmail.com>
	<CANNYZj9-ybLPr=kNLEGFgdPG1U_kNJEEVzCw_5FiYUPYVVQQYw@mail.gmail.com>
	<94B3180E-9326-43AC-9780-39A3E2D9F850@gmail.com>
	<CANNYZj9UY7rrTySn-ctmd0u+OGnneB+p_nH=OvXe35L+JB-Zzg@mail.gmail.com>
	<1577859A-5F16-4E3F-8C23-1ECB099AB770@gmail.com>
	<7679349B-ECD4-4895-BE9D-052E4674408C@gmail.com>
	<CC13D61A-9A15-4BD7-B8F8-531EC354D62A@gmail.com>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Subject: Re: Add files supporting bash completion for bitbake tools
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
X-List-Received-Date: Wed, 05 Sep 2018 17:28:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2018-09-05 at 19:24 +0200, Łukasz Gardoń wrote:
> Richard, may I ask You kindly help here to decide if such files
> should be stored in bitbake repository ?

My initial reaction is what the upstream policy for bash completions
is?

We don't tend to install bitbake as a traditional programme so users
will probably struggle to access these if they're in bitbake. If they
were in upstream bash-completion, it would likely make for a better
experience.

So I'd probably ask upstream as that is probably the preferred
location. If they won't take them for some reason, bitbake would be a
second choice.

Cheers,

Richard

